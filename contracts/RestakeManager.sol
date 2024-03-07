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

    /// 设置 暂停
    ///
    /// @dev Allows a restake manager admin to set the paused state of the contract
    function setPaused(bool _paused) external onlyDepositWithdrawPauserAdmin {
        paused = _paused;
    }
    
    /// 获取 运营商代理 个数
    /// 
    /// @dev Get the length of the operator delegators array
    function getOperatorDelegatorsLength() external view returns (uint256) {
        return operatorDelegators.length;
    }

    /// 管理 运营商代理 - 添加    
    /// 
    /// // 运营商代理 列表
    /// IOperatorDelegator[] public operatorDelegators;
    /// 
    /// // 运营商代理 分配额
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

    /// 管理 运营商代理 - 移除
    /// 
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

    /// 管理 运营商代理 - 设置分配额
    /// 
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
        // 验证运营商代理 不能为零地址
        if(address(_operatorDelegator) == address(0x0)) revert InvalidZeroInput();
        
        // 验证分配的基础点数：不可以 大于 100%
        if(_allocationBasisPoints > (100 * BASIS_POINTS)) revert OverMaxBasisPoints();

        // Ensure the OD is in the list to prevent mis-configuration
        // 验证运营商代理存在
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
        // 设置 运营商代理  分配额
        operatorDelegatorAllocations[
            _operatorDelegator
        ] = _allocationBasisPoints;

        emit OperatorDelegatorAllocationUpdated(
            _operatorDelegator,
            _allocationBasisPoints
        );
    }

    /// 设置 质押 最大TVL。如果设置为0，则不检测最大质押数（即：质押的 TVL 无限制）
    /// 
    /// @dev Allows a restake manager admin to set the max TVL for deposits.  If set to 0, no deposits will be enforced.
    function setMaxDepositTVL(uint256 _maxDepositTVL) external onlyRestakeManagerAdmin {
        maxDepositTVL = _maxDepositTVL;
    }
    /// 管理抵押品 token - 添加
    ///
    /// 抵押品 token 列表
    /// IERC20[] public collateralTokens
    /// 
    /// @dev Allows restake manager to add a collateral token
    function addCollateralToken(
        IERC20 _newCollateralToken
    ) external onlyRestakeManagerAdmin {
        // 检查是否已经添加
        // Ensure it is not already in the list
        uint256 tokenLength = collateralTokens.length;
        for (uint256 i = 0; i < tokenLength;) {
            if( address(collateralTokens[i]) == address(_newCollateralToken)) revert AlreadyAdded();
            unchecked{++i;}
        }

        // 验证精度是否18 位（抵押品 精度 decimals 必须等于 18 ）
        // Verify the token has 18 decimal precision - pricing calculations will be off otherwise
        if(IERC20Metadata(address(_newCollateralToken)).decimals() != 18) revert InvalidTokenDecimals(18, IERC20Metadata(address(_newCollateralToken)).decimals());

        // Add it to the list
        // 添加到 抵押品 数组
        collateralTokens.push(_newCollateralToken);

        emit CollateralTokenAdded(_newCollateralToken);
    }

    /// 管理抵押品 token - 移除
    ///
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
                // 将移除的抵押品索引值 替换为最后一个抵押品
                collateralTokens[i] = collateralTokens[
                    collateralTokens.length - 1
                ];
                // 移除最后一个抵押品
                collateralTokens.pop();
                emit CollateralTokenRemoved(_collateralTokenToRemove);
                return;
            }
            unchecked{++i;}
        }

        // If the item was not found, throw an error
        revert NotFound();
    }

    /// 获取抵押品 token 个数
    ///
    /// 抵押品token 列表
    /// IERC20[] public collateralTokens
    /// 
    /// 获取 抵押品数组长度
    /// @dev Get the length of the collateral tokens array
    function getCollateralTokensLength() external view returns (uint256) {
        return collateralTokens.length;
    }

    /// 计算 TVL（锁定价值）
    /// 
    /// 所有 运营商代理 下的 每个 运营商代理 下的 所有 token 中 指定 token 的 TVL ==  operatorDelegatorTokenTVLs[OD_index][token_index] = TVL
    /// 所有 运营商代理 下的 每个 运营商代理 下的 所有 token 的 总 TVL == operatorDelegatorTVLs[OD_index] = TVL
    /// 所有 运营商代理 总 TVL == totalTVL
    ///
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
        // 每个 运营商代理 下的 所有 token 中的指定 token 的 TVL 
        // operatorDelegatorTokenTVLs[OD_index][token_index] = TVL
        uint256[][] memory operatorDelegatorTokenTVLs = new uint256[][](
            operatorDelegators.length
        );
        // 每个 运营商代理 的 总 TVL（ 不区分 token ）
        // operatorDelegatorTVLs[OD_index] = TVL
        uint256[] memory operatorDelegatorTVLs = new uint256[](
            operatorDelegators.length
        );
        // operatorDelegatorTVLs 总和 = TVL 
        uint256 totalTVL = 0;

        // Iterate through the ODs 
        // 迭代 运营商代理数组
        
        // odLength : 运营商代理数组长度  // operatorDelegators = 缩写：OD
        uint256 odLength = operatorDelegators.length;

        for (uint256 i = 0; i < odLength;) {

            // 追踪 单个(当前索引) 运营商代理 的 TVL （ 下次循环重置为 0 ）
            // Track the TVL for this OD
            uint256 operatorTVL = 0;

            // operatorValues : 追踪 运营商代理 中 单独的 Token 的 TVLs （ 包括 ETH : 追加到数组最后一个元素 ）
            // Track the individual token TVLs for this OD - native ETH will be last item in the array
            uint256[] memory operatorValues = new uint256[](
                collateralTokens.length + 1
            );
            operatorDelegatorTokenTVLs[i] = operatorValues;

            // 迭代 质押 token 列表
            // Iterate through the tokens and get the value of each
            uint256 tokenLength = collateralTokens.length;
            for (uint256 j = 0; j < tokenLength;) {
                // Get the value of this token
                // 通过 运营商代理 调用 EL（EigenLayer）的 策略 获取：质押在 策略中 token 的余额数量
                uint256 operatorBalance = operatorDelegators[i]
                    .getTokenBalanceFromStrategy(collateralTokens[j]);

                // Set the value in the array for this OD
                // 通过预言机 查询 抵押 token 的 EL质押数量 的 价值（EL 的 策略 中 token 的 TVL）
                operatorValues[j] = renzoOracle.lookupTokenValue(
                    collateralTokens[j],
                    operatorBalance
                );

                // Add it to the total TVL for this OD
                // 当前 运营商代理 的 总 TVL
                operatorTVL += operatorValues[j];

                unchecked{++j;}
            }

            // 获取 质押的 ETH 余额
            // Get the value of native ETH staked for the OD
            uint256 operatorEthBalance = operatorDelegators[i].getStakedETHBalance();
            
            // 记录 ETH 的 TVL
            // Save it to the array for the OD
            operatorValues[operatorValues.length - 1] = operatorEthBalance;

            // 当前 运营商代理 的 总 TVL（追加 质押 ETH 的 TVL）
            // Add it to the total TVL for this OD
            operatorTVL += operatorEthBalance;

            // 记录总的 TVL（累加单个 运营商代理总的TVL）
            // Add it to the total TVL for the protocol
            totalTVL += operatorTVL;
            
            // 记录 当前 运营商代理 的 TVL
            // Save the TVL for this OD
            operatorDelegatorTVLs[i] = operatorTVL;

            unchecked{++i;}
        }
        
        // 总质押 TVL + 在 质押队列中 暂存的 ETH
        // Get the value of native ETH held in the deposit queue and add it to the total TVL
        totalTVL += address(depositQueue).balance;

        return (operatorDelegatorTokenTVLs, operatorDelegatorTVLs, totalTVL);
    }
    
    /// 选择 运营商代理 进行质押 (只有一个 或 没有 tvls 的时候 只返回第一个； 或者 挑选 TVL 低于 阈值的 OperatorDelegator )
    /// 
    /// // 运营商代理 列表 （缩写：OD）
    /// IOperatorDelegator[] public operatorDelegators;
    /// 
    /// // 运营商代理 分配额
    /// mapping(IOperatorDelegator => uint256) public operatorDelegatorAllocations;
    ///
    /// tvls = operatorDelegatorTVLs[OD_index] = TVL
    /// 
    /// 这个函数挑选 TVL 低于 阈值的 OperatorDelegator，或者 返回列表中的第一个 OperatorDelegator。
    /// @return 将要使用的 OperatorDelegator。

    /// @dev Picks the OperatorDelegator with the TVL below the threshold or returns the first one in the list
    /// @return The OperatorDelegator to use
    function chooseOperatorDelegatorForDeposit(
        uint256[] memory tvls,
        uint256 totalTVL
    ) public view returns (IOperatorDelegator) {
        
        // 验证 运营商代理数组列表 不能为空
        // Ensure OperatorDelegator list is not empty
        if (operatorDelegators.length == 0) revert NotFound();

        // 如果只有一个运营商代理 则直接返回
        // If there is only one operator delegator, return it
        if (operatorDelegators.length == 1) {
            return operatorDelegators[0];
        }

        // 否则，查找TVL低于 阈值 的 运营商代理 
        // Otherwise, find the operator delegator with TVL below the threshold
        uint256 tvlLength = tvls.length;
        for (uint256 i = 0; i < tvlLength;) {
            // 验证 单个运营商代理阈值 : OD_TVL : tvls[i] < total * {2}%
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


    /// TODO
    ///
    /// 这个函数确定要从中撤回的 OperatorDelegator。
    /// 它将尝试使用 TVL 超过分配阈值且具有要提取的代币的 OD。
    /// 如果没有 OD 的分配超过并具有要提取的代币，它将尝试找到一个具有要提取的代币的 OD。
    /// 如果没有 OD 具有要提取的代币，它将恢复。
    /// @return 将要使用的 OperatorDelegator。

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
    /// 获取 指定抵押品token 在 （抵押品 token 列表）中的 索引 (没有则 revert)
    /// 
    /// 抵押品 token 列表
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
     * 存入 抵押品 ( ERC20 )
     * 
     *  @notice 存入一个 ERC20 抵押代币到协议
     *  @dev 便利函数，无需推荐 ID 和向后兼容
     *  @param _collateralToken 要存入的抵押 ERC20 代币的地址
     *  @param _amount 要存入的抵押代币的数量（以基本单位表示）
     * 
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
        IERC20 _collateralToken,        // 抵押品 token 合约地址
        uint256 _amount,                // 抵押金额
        uint256 _referralId             // 推荐人ID （没有推荐人 则为:0 ）
    ) public nonReentrant notPaused {   // 暂停 && 防重入

        // 返回在抵押品数组中的索引 没有则 revert
        // Verify collateral token is in the list - call will revert if not found
        uint256 tokenIndex = getCollateralTokenIndex(_collateralToken);

        // operatorDelegatorTokenTVLs[OD_index][token_index] = TVL
        // operatorDelegatorTVLs[OD_index] = TVL
        // totalTVL
        // 
        // Get the TVLs for each operator delegator and the total TVL
        (
            uint256[][] memory operatorDelegatorTokenTVLs,
            uint256[] memory operatorDelegatorTVLs,
            uint256 totalTVL
        ) = calculateTVLs();

        // 获取 抵押品 token 抵押数量 的 价值（通过预言机）
        // Get the value of the collateral token being deposited
        uint256 collateralTokenValue = renzoOracle.lookupTokenValue(
            _collateralToken,
            _amount
        );

        // 验证质押价值限额 - 验证 质押token数量价值 加上已经质押的 是否超过 最大质押限额（质押限额 为 0 则没有限制）
        // Enforce TVL limit if set, 0 means the check is not enabled
        if(maxDepositTVL != 0 && totalTVL + collateralTokenValue > maxDepositTVL) {
            revert MaxTVLReached();
        }
        
        // 验证 单个质押token价值限额（为 0 则 没有限额）
        // Enforce individual token TVL limit if set, 0 means the check is not enabled
        if(collateralTokenTvlLimits[_collateralToken] != 0) {

            // 追踪 当前token TVL
            // Track the current token's TVL
            uint256 currentTokenTVL = 0;

            // 获取 所有 运营商代理中 当前token 的 TVL 和
            // For each OD, add up the token TVLs
            uint256 odLength = operatorDelegatorTokenTVLs.length;
            for (uint256 i = 0; i < odLength;) {
                currentTokenTVL += operatorDelegatorTokenTVLs[i][tokenIndex];
                unchecked{++i;}        
            }
            
            // 检测是否超过限额
            // Check if it is over the limit
            if(currentTokenTVL + collateralTokenValue > collateralTokenTvlLimits[_collateralToken])
                revert MaxTokenTVLReached();
        }

        // 选择 运营商代理 去 质押
        // Determine which operator delegator to use
        IOperatorDelegator operatorDelegator = chooseOperatorDelegatorForDeposit(
                operatorDelegatorTVLs,
                totalTVL
            );
        
        // 转入质押 token 到当前合约（ 需要先授权 approve ）
        // Transfer the collateral token to this address
        _collateralToken.safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );
        
        // 当前合约持有 抵押的 token 所以 授权 给 运营商代理
        // Approve the tokens to the operator delegator
        _collateralToken.safeApprove(address(operatorDelegator), _amount);

        // 运营商代理 执行质押（抵押品，数量）
        // Call deposit on the operator delegator
        operatorDelegator.deposit(_collateralToken, _amount);

        // 计算 兑换的 ezETH (通过预言机)
        // Calculate how much ezETH to mint
        uint256 ezETHToMint = renzoOracle.calculateMintAmount(
            totalTVL,
            collateralTokenValue,
            ezETH.totalSupply()
        );
        
        // 铸币 ezETH
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
     * 质押 ETH
     * 
     * @notice  允许用户将 ETH 存入协议，并获得相应的 ezETH
     * @dev     发送到此函数的 ETH 金额将被发送到存款队列，稍后由验证者进行质押。一旦质押，它将存入 EigenLayer。
     * @param   _referralId  存款时使用的推荐 ID（如果没有则为 0）
     * 
     * @notice  Allows a user to deposit ETH into the protocol and get back ezETH
     * @dev     The amount of ETH sent into this function will be sent to the deposit queue to be 
     * staked later by a validator.  Once staked it will be deposited into EigenLayer.
     * * @param   _referralId  The referral ID to use for the deposit (can be 0 if none)
     */
    function depositETH(uint256 _referralId) public payable nonReentrant notPaused { // 暂停 / 防重入
        // Get the total TVL
        (
            ,
            ,
            uint256 totalTVL
        ) = calculateTVLs();

        // 验证质押价值限额 - 验证 质押token数量价值 加上已经质押的 是否超过 最大质押限额（质押限额 为 0 则没有限制）
        // Enforce TVL limit if set
        if(maxDepositTVL != 0 && totalTVL + msg.value > maxDepositTVL) {
            revert MaxTVLReached();
        }

        // 质押 ETH 到 质押队列（暂存） 
        // Deposit the ETH into the DepositQueue
        depositQueue.depositETHFromProtocol{value: msg.value}();

        // 计算 mint 的 ezETH 数量
        // Calculate how much ezETH to mint
        uint256 ezETHToMint = renzoOracle.calculateMintAmount(
            totalTVL,
            msg.value,
            ezETH.totalSupply()
        );

        // Mint the ezETH
        // 铸币 质押凭证
        ezETH.mint(msg.sender, ezETHToMint);

        // Emit the deposit event
        emit Deposit(msg.sender, IERC20(address(0x0)), msg.value, ezETHToMint, _referralId);
    }

    /// 质押 ETH 到运营商代理中
    /// 
    /// @dev 由存款队列调用，将 ETH 质押给验证者
    /// 仅可由存款队列调用
    /// 
    /// @dev Called by the deposit queue to stake ETH to a validator
    /// Only callable by the deposit queue
    function stakeEthInOperatorDelegator(IOperatorDelegator operatorDelegator, bytes calldata pubkey, bytes calldata signature, bytes32 depositDataRoot) external payable onlyDepositQueue {
        // 验证 是否有效的 运营商代理
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

    /// TODO
    /// @dev 从存款队列存入 ERC20 代币奖励
    /// 仅可由存款队列调用

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

    /*
     * 
     * @notice  返回协议赚取的总奖励金额
     * @dev     奖励包括质押的原生 ETH 和 EigenLayer 奖励（ETH + ERC20）
     * @return  uint256  以 ETH 价格计价的协议赚取的总奖励金额
     * 
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
