// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "./RestakeManagerStorage.sol";
import "./EigenLayer/interfaces/IStrategy.sol";
import "./EigenLayer/interfaces/IStrategyManager.sol";
import "./EigenLayer/interfaces/IDelegationManager.sol";
import "./token/IEzEthToken.sol";
import "./IRestakeManager.sol";
import "./Errors/Errors.sol";

/**
 * @author  Renzo
 * @title   RestakeManager
 * @dev     This contract is the main entrypoint for external users into the protocol
            Users will interact with this contract to deposit and withdraw value into and from EigenLayer
            Ownership of deposited funds will be tracked via the ezETh token
 */
contract RestakeManager is    
    Initializable,
    ReentrancyGuardUpgradeable,
    RestakeManagerStorageV2
{
    using SafeERC20 for IERC20;
    using SafeERC20Upgradeable for IEzEthToken;

    event OperatorDelegatorAdded(IOperatorDelegator od);
    event OperatorDelegatorRemoved(IOperatorDelegator od);
    event OperatorDelegatorAllocationUpdated(IOperatorDelegator od, uint256 allocation);

    event CollateralTokenAdded(IERC20 token);
    event CollateralTokenRemoved(IERC20 token);    

    /// @dev Basis points used for percentages (100 basis points equals 1%)
    // 100 = 1%
    uint256 constant BASIS_POINTS = 100;

    /// @dev Event emitted when a new deposit occurs
    event Deposit(
        address depositor,
        IERC20 token,
        uint256 amount,
        uint256 ezETHMinted,
        uint256 referralId
    );

    /// @dev Event emitted when a new withdraw is started
    event UserWithdrawStarted(
        bytes32 withdrawalRoot,
        address withdrawer,
        IERC20 token,
        uint256 amount,
        uint256 ezETHToBurn
    );

    /// @dev Event emitted when a new withdraw is completed
    event UserWithdrawCompleted(
        bytes32 withdrawalRoot,
        address withdrawer,
        IERC20 token,
        uint256 amount,
        uint256 ezETHBurned
    );

    /// @dev Event emitted when a token TVL Limit is updated
    event CollateralTokenTvlUpdated(
        IERC20 token,
        uint256 tvl
    );

    /// @dev Allows only a whitelisted address to configure the contract
    modifier onlyRestakeManagerAdmin() {
        if(!roleManager.isRestakeManagerAdmin(msg.sender)) revert NotRestakeManagerAdmin();
        _;
    }

    /// @dev Allows only a whitelisted address to set pause state
    modifier onlyDepositWithdrawPauserAdmin() {
        if(!roleManager.isDepositWithdrawPauser(msg.sender)) revert NotDepositWithdrawPauser();
        _;
    }

    /// @dev Allows only the deposit queue to call functions
    modifier onlyDepositQueue() {
        if(msg.sender != address(depositQueue)) revert NotDepositQueue();
        _;
    }

    /// @dev Only allows execution if contract is not paused
    modifier notPaused() {
        if(paused) revert ContractPaused();
        _;
    }

    /// @dev Prevents implementation contract from being initialized.
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        // _disableInitializers();
    }

    /// @dev Initializes the contract with initial vars
    function initialize(
        IRoleManager _roleManager,
        IEzEthToken _ezETH,
        IRenzoOracle _renzoOracle,
        IStrategyManager _strategyManager,
        IDelegationManager _delegationManager,
        IDepositQueue _depositQueue
    ) public initializer {

        __ReentrancyGuard_init();
        
        roleManager = _roleManager;
        ezETH = _ezETH;
        renzoOracle = _renzoOracle;
        strategyManager = _strategyManager;
        delegationManager = _delegationManager;
        depositQueue = _depositQueue;
        paused = false;
    }

    /// @dev Allows a restake manager admin to set the paused state of the contract
    function setPaused(bool _paused) external onlyDepositWithdrawPauserAdmin {
        paused = _paused;
    }

    /// @dev Get the length of the operator delegators array
    function getOperatorDelegatorsLength() external view returns (uint256) {
        return operatorDelegators.length;
    }

    
    /// //运营商代理 列表
    /// IOperatorDelegator[] public operatorDelegators;
    /// //运营商代理 分配额
    /// mapping(IOperatorDelegator => uint256) public operatorDelegatorAllocations;
    /// 
    /// @dev Allows a restake manager admin to add an OperatorDelegator to the list
    function addOperatorDelegator(
        IOperatorDelegator _newOperatorDelegator,
        uint256 _allocationBasisPoints
    ) external onlyRestakeManagerAdmin {
        // Ensure it is not already in the list
        // 验证是否已经添加
        uint256 odLength = operatorDelegators.length;
        for (uint256 i = 0; i < odLength;) {
            if( address(operatorDelegators[i]) == address(_newOperatorDelegator)) revert AlreadyAdded();
            unchecked{++i;}        
        }

        // Verify a valid allocation
        // 验证分配的基础点数：不可以 大于 100%
        if(_allocationBasisPoints > (100 * BASIS_POINTS)) revert OverMaxBasisPoints();

        // Add it to the list
        // 添加运营商代理列表
        operatorDelegators.push(_newOperatorDelegator);

        emit OperatorDelegatorAdded(_newOperatorDelegator);

        // Set the allocation
        // 设置基点
        operatorDelegatorAllocations[
            _newOperatorDelegator
        ] = _allocationBasisPoints;

        emit OperatorDelegatorAllocationUpdated(
            _newOperatorDelegator,
            _allocationBasisPoints
        );
    }

    /// // 运营商代理 列表
    /// IOperatorDelegator[] public operatorDelegators;
    /// 
    /// // 运营商代理 分配额
    /// mapping(IOperatorDelegator => uint256) public operatorDelegatorAllocations;
    /// 
    /// // 替换法删除（顺序会变）
    /// 
    /// @dev Allows a restake manager admin to remove an OperatorDelegator from the list
    function removeOperatorDelegator(
        IOperatorDelegator _operatorDelegatorToRemove
    ) external onlyRestakeManagerAdmin {
        // Remove it from the list
        uint256 odLength = operatorDelegators.length;
        for (uint256 i = 0; i < odLength;) {
            if (
                address(operatorDelegators[i]) ==
                address(_operatorDelegatorToRemove)
            ) {
                // Clear the allocation 清理分配基点
                operatorDelegatorAllocations[_operatorDelegatorToRemove] = 0;
                emit OperatorDelegatorAllocationUpdated(
                    _operatorDelegatorToRemove,
                    0
                );

                // Remove from list
                // 清理数组 替换掉最后一个元素
                operatorDelegators[i] = operatorDelegators[
                    operatorDelegators.length - 1
                ];
                operatorDelegators.pop();
                emit OperatorDelegatorRemoved(_operatorDelegatorToRemove);
                return;
            }
            unchecked{++i;}
        }

        // If the item was not found, throw an error
        revert NotFound();
    }

    /// // 运营商代理 列表
    /// IOperatorDelegator[] public operatorDelegators;
    /// 
    /// // 运营商代理 分配额
    /// mapping(IOperatorDelegator => uint256) public operatorDelegatorAllocations;
    /// 
    /// 管理员设置 分配额
    /// @dev Allows restake manager admin to set an OperatorDelegator allocation
    function setOperatorDelegatorAllocation(
        IOperatorDelegator _operatorDelegator,
        uint256 _allocationBasisPoints
    ) external onlyRestakeManagerAdmin {
        if(address(_operatorDelegator) == address(0x0)) revert InvalidZeroInput();
        if(_allocationBasisPoints > (100 * BASIS_POINTS)) revert OverMaxBasisPoints();

        // Ensure the OD is in the list to prevent mis-configuration
        bool foundOd = false;
        uint256 odLength = operatorDelegators.length;
        for (uint256 i = 0; i < odLength;) {
            if (
                address(operatorDelegators[i]) ==
                address(_operatorDelegator)
            ) {
                foundOd = true;
                break;
            }
            unchecked{++i;}
        }
        if(!foundOd) revert NotFound();


        // Set the allocation
        operatorDelegatorAllocations[
            _operatorDelegator
        ] = _allocationBasisPoints;

        emit OperatorDelegatorAllocationUpdated(
            _operatorDelegator,
            _allocationBasisPoints
        );
    }

    /// 设置存款的最大TVL。如果设置为0，则不强制执行存款
    /// @dev Allows a restake manager admin to set the max TVL for deposits.  If set to 0, no deposits will be enforced.
    function setMaxDepositTVL(uint256 _maxDepositTVL) external onlyRestakeManagerAdmin {
        maxDepositTVL = _maxDepositTVL;
    }

    /// 抵押品token 列表
    /// IERC20[] public collateralTokens
    /// 
    /// @dev Allows restake manager to add a collateral token
    function addCollateralToken(
        IERC20 _newCollateralToken
    ) external onlyRestakeManagerAdmin {
        // Ensure it is not already in the list
        // 检查是否已经添加
        uint256 tokenLength = collateralTokens.length;
        for (uint256 i = 0; i < tokenLength;) {
            if( address(collateralTokens[i]) == address(_newCollateralToken)) revert AlreadyAdded();
            unchecked{++i;}
        }

        // 验证精度是否 18位
        // Verify the token has 18 decimal precision - pricing calculations will be off otherwise
        if(IERC20Metadata(address(_newCollateralToken)).decimals() != 18) revert InvalidTokenDecimals(18, IERC20Metadata(address(_newCollateralToken)).decimals());

        // Add it to the list
        collateralTokens.push(_newCollateralToken);

        emit CollateralTokenAdded(_newCollateralToken);
    }

    /// 抵押品token 列表
    /// IERC20[] public collateralTokens
    /// 
    /// 替换法删除（顺序会变）
    /// 
    /// @dev Allows restake manager to remove a collateral token
    function removeCollateralToken(
        IERC20 _collateralTokenToRemove
    ) external onlyRestakeManagerAdmin {
        // Remove it from the list
        uint256 tokenLength = collateralTokens.length;
        for (uint256 i = 0; i < tokenLength;) {
            if (
                address(collateralTokens[i]) ==
                address(_collateralTokenToRemove)
            ) {
                collateralTokens[i] = collateralTokens[
                    collateralTokens.length - 1
                ];
                collateralTokens.pop();
                emit CollateralTokenRemoved(_collateralTokenToRemove);
                return;
            }
            unchecked{++i;}
        }

        // If the item was not found, throw an error
        revert NotFound();
    }

    /// 抵押品token 列表
    /// IERC20[] public collateralTokens
    /// 
    /// 获取 抵押品数组长度
    /// @dev Get the length of the collateral tokens array
    function getCollateralTokensLength() external view returns (uint256) {
        return collateralTokens.length;
    }

    /// @dev 此函数计算每个运营商委托者的每个代币的 TVL，每个 OD 的总 TVL，以及协议的总 TVL。
    /// @return operatorDelegatorTokenTVLs 每个 OD 的 TVL，由 operatorDelegators 数组和 collateralTokens 数组索引
    /// @return operatorDelegatorTVLs 按照 operatorDelegators 数组的顺序列出每个 OD 的总 TVL
    /// @return totalTVL 所有运营商委托者的总 TVL

    /// @dev This function calculates the TVLs for each operator delegator by individual token, total for each OD, and total for the protocol.
    /// @return operatorDelegatorTokenTVLs Each OD's TVL indexed by operatorDelegators array by collateralTokens array
    /// @return operatorDelegatorTVLs Each OD's Total TVL in order of operatorDelegators array
    /// @return totalTVL The total TVL across all operator delegators.
    function calculateTVLs()
        public
        view
        returns (uint256[][] memory, uint256[] memory, uint256)
    {
        // 每个 运营商代理 TVL 
        uint256[][] memory operatorDelegatorTokenTVLs = new uint256[][](
            operatorDelegators.length
        );
        // 总 运营商代理 的 TVL
        uint256[] memory operatorDelegatorTVLs = new uint256[](
            operatorDelegators.length
        );
        // 总 TVL
        uint256 totalTVL = 0;

        // Iterate through the ODs 
        // 运营商代理数组 长度 operatorDelegators = 缩写：OD
        uint256 odLength = operatorDelegators.length;
        for (uint256 i = 0; i < odLength;) {
            // Track the TVL for this OD
            uint256 operatorTVL = 0;

            // Track the individual token TVLs for this OD - native ETH will be last item in the array
            // 追踪 OD 的 单独的 token 的 TVL 包括 ETH
            uint256[] memory operatorValues = new uint256[](
                collateralTokens.length + 1
            );
            operatorDelegatorTokenTVLs[i] = operatorValues;

            // Iterate through the tokens and get the value of each
            uint256 tokenLength = collateralTokens.length;
            for (uint256 j = 0; j < tokenLength;) {
                // Get the value of this token
                // 调用 el 数据
                uint256 operatorBalance = operatorDelegators[i]
                    .getTokenBalanceFromStrategy(collateralTokens[j]);

                // Set the value in the array for this OD
                // 通过 调用 el 设置 自己的预言机数据
                operatorValues[j] = renzoOracle.lookupTokenValue(
                    collateralTokens[j],
                    operatorBalance
                );

                // Add it to the total TVL for this OD
                operatorTVL += operatorValues[j];

                unchecked{++j;}
            }

            // Get the value of native ETH staked for the OD
            uint256 operatorEthBalance = operatorDelegators[i].getStakedETHBalance();

            // Save it to the array for the OD
            operatorValues[operatorValues.length - 1] = operatorEthBalance;

            // Add it to the total TVL for this OD
            operatorTVL += operatorEthBalance;

            // Add it to the total TVL for the protocol
            totalTVL += operatorTVL;

            // Save the TVL for this OD
            operatorDelegatorTVLs[i] = operatorTVL;

            unchecked{++i;}
        }

        // Get the value of native ETH held in the deposit queue and add it to the total TVL
        totalTVL += address(depositQueue).balance;

        return (operatorDelegatorTokenTVLs, operatorDelegatorTVLs, totalTVL);
    }

    /// @dev Picks the OperatorDelegator with the TVL below the threshold or returns the first one in the list
    /// @return The OperatorDelegator to use
    function chooseOperatorDelegatorForDeposit(
        uint256[] memory tvls,
        uint256 totalTVL
    ) public view returns (IOperatorDelegator) {
        // Ensure OperatorDelegator list is not empty
        if (operatorDelegators.length == 0) revert NotFound();

        // If there is only one operator delegator, return it
        if (operatorDelegators.length == 1) {
            return operatorDelegators[0];
        }

        // Otherwise, find the operator delegator with TVL below the threshold
        uint256 tvlLength = tvls.length;
        for (uint256 i = 0; i < tvlLength;) {
            if (
                tvls[i] <
                (operatorDelegatorAllocations[operatorDelegators[i]] *
                    totalTVL) /
                    BASIS_POINTS /
                    BASIS_POINTS
            ) {
                return operatorDelegators[i];
            }

            unchecked{++i;}
        }

        // Default to the first operator delegator
        return operatorDelegators[0];
    }

    /// @dev Determines the OD to withdraw from
    /// It will try to use the OD with the TVL above the allocation threshold that has the tokens to withdraw
    /// If no OD is over the allocation and has tokens, it will try to find one that has the tokens to withdraw
    /// If no OD has the tokens to withdraw, it will revert
    /// @return The OperatorDelegator to use
    function chooseOperatorDelegatorForWithdraw(
        uint256 tokenIndex,
        uint256 ezETHValue,
        uint256[][] memory operatorDelegatorTokenTVLs,
        uint256[] memory operatorDelegatorTVLs,
        uint256 totalTVL
    ) public view returns (IOperatorDelegator) {
        // If there is only one operator delegator, try to use it
        if (operatorDelegators.length == 1) {
            // If the OD doesn't have the tokens, revert
            if (operatorDelegatorTokenTVLs[0][tokenIndex] < ezETHValue) {
                revert NotFound();
            }
            return operatorDelegators[0];
        }

        // Fnd the operator delegator with TVL above the threshold and with enough tokens
        uint256 odLength = operatorDelegatorTVLs.length;
        for (uint256 i = 0; i < odLength;) {
            if (
                operatorDelegatorTVLs[i] >
                (operatorDelegatorAllocations[operatorDelegators[i]] *
                    totalTVL) /
                    BASIS_POINTS /
                    BASIS_POINTS &&
                operatorDelegatorTokenTVLs[i][tokenIndex] >= ezETHValue
            ) {
                return operatorDelegators[i];
            }

            unchecked{++i;}
        }

        // If not found, just find one with enough tokens        
        for (uint256 i = 0; i < odLength;) {
            if (operatorDelegatorTokenTVLs[i][tokenIndex] >= ezETHValue) {
                return operatorDelegators[i];
            }

            unchecked{++i;}
        }

        // This token cannot be withdrawn
        revert NotFound();
    }

    /// 抵押品token 列表
    /// IERC20[] public collateralTokens;
    ///
    /// 找抵押品 token 的索引 没有则 revert
    /// 
    /// @dev Finds the index of the collateral token in the list
    /// Reverts if the token is not found in the list
    function getCollateralTokenIndex(
        IERC20 _collateralToken
    ) public view returns (uint256) {
        // Find the token index
        uint256 tokenLength = collateralTokens.length;
        for (uint256 i = 0; i < tokenLength;) {
            if (collateralTokens[i] == _collateralToken) {
                return i;
            }

            unchecked{++i;}
        }

        revert NotFound();
    }

    /**
     * 存入 抵押品
     * 
     * 
     *  @notice 存入一个 ERC20 抵押代币到协议
     *  @dev 便利函数，无需推荐 ID 和向后兼容
     *  @param _collateralToken 要存入的抵押 ERC20 代币的地址
     *  @param _amount 要存入的抵押代币的数量（以基本单位表示）

     * @notice  Deposits an ERC20 collateral token into the protocol
     * @dev     Convenience function to deposit without a referral ID and backwards compatibility
     * @param   _collateralToken  The address of the collateral ERC20 token to deposit
     * @param   _amount The amount of the collateral token to deposit in base units
     */
    function deposit(
        IERC20 _collateralToken,
        uint256 _amount
    ) external {
        deposit(_collateralToken, _amount, 0);
    }

    /**
     * 
     * @notice  存入 ERC20 抵押代币到协议
     * @dev
     * 发送方必须预先授权此合约将代币转移至协议
     * 存款时，合约将执行以下操作：
     *   - 确定要使用的运营商代理
     *   - 将抵押代币转移到运营商代理，并存入 EigenLayer
     *   - 计算并铸造适当数量的 ezETH 返回给用户
     *     ezETH 将按用户存入价值与协议中已有价值的比例进行膨胀
     * 指定的抵押代币必须预先配置为允许在协议中使用
     * @param   _collateralToken  要存入的抵押 ERC20 代币的地址
     * @param   _amount 要存入的抵押代币数量（以基本单位计）
     * @param   _referralId 存款时要使用的推荐 ID（如果没有则为 0）
     * 
     * 
     * @notice  Deposits an ERC20 collateral token into the protocol
     * @dev
     * The msg.sender must pre-approve this contract to move the tokens into the protocol
     * To deposit, the contract will:
     *   - Figure out which operator delegator to use
     *   - Transfer the collateral token to the operator delegator and deposit it into EigenLayer
     *   - Calculate and mint the appropriate amount of ezETH back to the user
     * ezETH will get inflated proportional to the value they are depositing vs the value already in the protocol
     * The collateral token specified must be pre-configured to be allowed in the protocol
     * @param   _collateralToken  The address of the collateral ERC20 token to deposit 
     * @param   _amount The amount of the collateral token to deposit in base units
     * @param   _referralId The referral ID to use for the deposit (can be 0 if none) 
     */
    function deposit(
        IERC20 _collateralToken, // 抵押品token 合约地址
        uint256 _amount,         // 抵押金额
        uint256 _referralId      // 推荐人ID （没有推荐人则为 0 ）
    ) public nonReentrant notPaused {
        // 暂停 / 防重入

        // Verify collateral token is in the list - call will revert if not found
        // 返回在抵押品数组中的索引 没有则 revert
        uint256 tokenIndex = getCollateralTokenIndex(_collateralToken);

        // Get the TVLs for each operator delegator and the total TVL
        // 获取: 
            // 总的TVL
            // 每个 运营商代理 的 TVL
        (
            uint256[][] memory operatorDelegatorTokenTVLs,
            uint256[] memory operatorDelegatorTVLs,
            uint256 totalTVL
        ) = calculateTVLs();

        // Get the value of the collateral token being deposited
        // 获取抵押品token 指定数额的 价值
        uint256 collateralTokenValue = renzoOracle.lookupTokenValue(
            _collateralToken,
            _amount
        );

        // Enforce TVL limit if set, 0 means the check is not enabled
        if(maxDepositTVL != 0 && totalTVL + collateralTokenValue > maxDepositTVL) {
            revert MaxTVLReached();
        }

        // Enforce individual token TVL limit if set, 0 means the check is not enabled
        if(collateralTokenTvlLimits[_collateralToken] != 0) {

            // Track the current token's TVL
            uint256 currentTokenTVL = 0;

            // For each OD, add up the token TVLs
            uint256 odLength = operatorDelegatorTokenTVLs.length;
            for (uint256 i = 0; i < odLength;) {
                currentTokenTVL += operatorDelegatorTokenTVLs[i][tokenIndex];
                unchecked{++i;}        
            }

            // Check if it is over the limit
            if(currentTokenTVL + collateralTokenValue > collateralTokenTvlLimits[_collateralToken])
                revert MaxTokenTVLReached();
        }


        // Determine which operator delegator to use
        IOperatorDelegator operatorDelegator = chooseOperatorDelegatorForDeposit(
                operatorDelegatorTVLs,
                totalTVL
            );

        // Transfer the collateral token to this address
        _collateralToken.safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );

        // Approve the tokens to the operator delegator
        _collateralToken.safeApprove(address(operatorDelegator), _amount);

        // Call deposit on the operator delegator
        operatorDelegator.deposit(_collateralToken, _amount);

        // Calculate how much ezETH to mint
        uint256 ezETHToMint = renzoOracle.calculateMintAmount(
            totalTVL,
            collateralTokenValue,
            ezETH.totalSupply()
        );

        // Mint the ezETH
        ezETH.mint(msg.sender, ezETHToMint);

        // Emit the deposit event
        emit Deposit(msg.sender, _collateralToken, _amount, ezETHToMint, _referralId);
    }


    /**
     * @notice  Allows a user to deposit ETH into the protocol and get back ezETH
     * @dev     Convenience function to deposit without a referral ID and backwards compatibility
     */
    function depositETH() external payable {
        depositETH(0);
    }

    /**
     * @notice  Allows a user to deposit ETH into the protocol and get back ezETH
     * @dev     The amount of ETH sent into this function will be sent to the deposit queue to be 
     * staked later by a validator.  Once staked it will be deposited into EigenLayer.
     * * @param   _referralId  The referral ID to use for the deposit (can be 0 if none)
     */
    function depositETH(uint256 _referralId) public payable nonReentrant notPaused {
        // Get the total TVL
        (
            ,
            ,
            uint256 totalTVL
        ) = calculateTVLs();

        // Enforce TVL limit if set
        if(maxDepositTVL != 0 && totalTVL + msg.value > maxDepositTVL) {
            revert MaxTVLReached();
        }

        // Deposit the ETH into the DepositQueue
        depositQueue.depositETHFromProtocol{value: msg.value}();

        // Calculate how much ezETH to mint
        uint256 ezETHToMint = renzoOracle.calculateMintAmount(
            totalTVL,
            msg.value,
            ezETH.totalSupply()
        );

        // Mint the ezETH
        ezETH.mint(msg.sender, ezETHToMint);

        // Emit the deposit event
        emit Deposit(msg.sender, IERC20(address(0x0)), msg.value, ezETHToMint, _referralId);
    }

    /// @dev Called by the deposit queue to stake ETH to a validator
    /// Only callable by the deposit queue
    function stakeEthInOperatorDelegator(IOperatorDelegator operatorDelegator, bytes calldata pubkey, bytes calldata signature, bytes32 depositDataRoot) external payable onlyDepositQueue {
        // Verify the OD is in the list
        bool found = false;
        uint256 odLength = operatorDelegators.length;
        for (uint256 i = 0; i < odLength;) {
            if (operatorDelegators[i] == operatorDelegator) {
                found = true;
                break;
            }

            unchecked{++i;}
        }
        if(!found) revert NotFound();

        // Call the OD to stake the ETH
        operatorDelegator.stakeEth{value: msg.value}(pubkey, signature, depositDataRoot);
    }

    /// @dev Deposit ERC20 token rewards from the Deposit Queue
    /// Only callable by the deposit queue
    function depositTokenRewardsFromProtocol(
        IERC20 _token,
        uint256 _amount
    ) external onlyDepositQueue {        
        
        // Get the TVLs for each operator delegator and the total TVL
        // 获取每个运营商代理的 TVL 和 总TVL
        (
            ,
            uint256[] memory operatorDelegatorTVLs,
            uint256 totalTVL
        ) = calculateTVLs();

        // Determine which operator delegator to use
        // 确定使用哪个运营商代理
        IOperatorDelegator operatorDelegator = chooseOperatorDelegatorForDeposit(
                operatorDelegatorTVLs,
                totalTVL
            );

        // Transfer the tokens to this address
        // ERC20 转入到 当前地址
        _token.safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );

        // Approve the tokens to the operator delegator
        // 授权 当前 ERC20 转入额度 给 运营商代理
        _token.safeApprove(address(operatorDelegator), _amount);

        // Deposit the tokens into EigenLayer
        // 调用 运营商代理 质押
        operatorDelegator.deposit(_token, _amount);
    }

    /**
     * @notice  Returns the total amount of rewards earned by the protocol
     * @dev     Rewards include staking native ETH and EigenLayer rewards (ETH + ERC20s)
     * @return  uint256  The total amount of rewards earned by the protocol priced in ETH
     */
    function getTotalRewardsEarned() external view returns (uint256){
        uint256 totalRewards = 0;

        // First get the ETH rewards tracked in the deposit queue
        totalRewards += depositQueue.totalEarned(address(0x0));

        // For each token, get the total rewards earned from the deposit queue and price it in ETH
        uint256 tokenLength = collateralTokens.length;
        for (uint256 i = 0; i < tokenLength;) {    
            // Get the amount        
            uint256 tokenRewardAmount = depositQueue.totalEarned(address(collateralTokens[i]));

            // Convert via the price oracle
            totalRewards += renzoOracle.lookupTokenValue(collateralTokens[i], tokenRewardAmount);

            unchecked{++i;}
        }

        // For each OperatorDelegator, get the balance (these are rewards from staking that have not been restaked)
        // Funds in OD's EigenPod are assumed to be rewards in M1 until exiting validators or withdrawals are supported
        // Pending unstaked delayed withdrawal amounts are pending being routed into the DepositQueue after a delay
        uint256 odLength = operatorDelegators.length;
        for (uint256 i = 0; i < odLength;) {
            totalRewards += address(operatorDelegators[i].eigenPod()).balance + operatorDelegators[i].pendingUnstakedDelayedWithdrawalAmount();
            unchecked{++i;}
        }

        return totalRewards;
    }
    
    function setTokenTvlLimit(IERC20 _token, uint256 _limit) external onlyRestakeManagerAdmin {
        // Verify collateral token is in the list - call will revert if not found
        getCollateralTokenIndex(_token);

        // Set the limit
        collateralTokenTvlLimits[_token] = _limit;

        emit CollateralTokenTvlUpdated(_token, _limit);
    }
}
