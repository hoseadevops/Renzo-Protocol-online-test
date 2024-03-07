// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "../Permissions/IRoleManager.sol";
import "./OperatorDelegatorStorage.sol";
import "../EigenLayer/interfaces/IDelegationManager.sol";
import "../Errors/Errors.sol";


/// 运营商代理 主要与 EL 交互

/// @dev 这个合约将负责与Eigenlayer交互 
/// 每个部署的合同将被委派给一个特定的运营商 
/// 该合约可以处理多个ERC20令牌，所有这些令牌都将被委托给同一个运营商 
/// 每个支持的ERC20令牌将指向EL中的单个策略合约 
/// 只有RestakeManager应该与这个契约进行EL交互。

/// @dev This contract will be responsible for interacting with Eigenlayer
/// Each of these contracts deployed will be delegated to one specific operator
/// This contract can handle multiple ERC20 tokens, all of which will be delegated to the same operator
/// Each supported ERC20 token will be pointed at a single Strategy contract in EL
/// Only the RestakeManager should be interacting with this contract for EL interactions.
contract OperatorDelegator is
    Initializable,
    ReentrancyGuardUpgradeable,
    OperatorDelegatorStorageV2
{
    using SafeERC20 for IERC20;
    
    uint256 internal constant GWEI_TO_WEI = 1e9;
    // token 对应的 eigenlayer 策略 更新事件
    event TokenStrategyUpdated(IERC20 token, IStrategy strategy);
    event DelegationAddressUpdated(address delegateAddress);
    event RewardsForwarded(address rewardDestination, uint256 amount);
    // 提现开始事件
    event WithdrawStarted(
        bytes32 withdrawRoot,   // 
        address staker,         // 质押者
        address delegatedTo,    //
        address withdrawer,     //
        uint nonce,             //
        uint startBlock,        //
        IStrategy[] strategies, // 策略
        uint256[] shares        // 
    );

    /// @dev Allows only a whitelisted address to configure the contract
    modifier onlyOperatorDelegatorAdmin() {
        if(!roleManager.isOperatorDelegatorAdmin(msg.sender)) revert NotOperatorDelegatorAdmin();
        _;
    }

    /// @dev Allows only the RestakeManager address to call functions
    modifier onlyRestakeManager() {
        if(msg.sender != address(restakeManager)) revert NotRestakeManager();
        _;
    }

    /// @dev Allows only a whitelisted address to configure the contract
    modifier onlyNativeEthRestakeAdmin() {
        if(!roleManager.isNativeEthRestakeAdmin(msg.sender)) revert NotNativeEthRestakeAdmin();
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
        IStrategyManager _strategyManager,
        IRestakeManager _restakeManager,
        IDelegationManager _delegationManager,
        IEigenPodManager _eigenPodManager
    ) external initializer {
        if(address(_roleManager) == address(0x0)) revert InvalidZeroInput();
        if(address(_strategyManager) == address(0x0)) revert InvalidZeroInput();
        if(address(_restakeManager) == address(0x0)) revert InvalidZeroInput();
        if(address(_delegationManager) == address(0x0)) revert InvalidZeroInput();
        if(address(_eigenPodManager) == address(0x0)) revert InvalidZeroInput();

        __ReentrancyGuard_init();

        roleManager = _roleManager;
        strategyManager = _strategyManager;
        restakeManager = _restakeManager;
        delegationManager = _delegationManager;
        eigenPodManager = _eigenPodManager;

        // Deploy new EigenPod
        eigenPodManager.createPod();

        // Save off the EigenPod address
        eigenPod = IEigenPod(eigenPodManager.ownerToPod(address(this)));
    }

    /// 设置给定token 的策略 - 将策略设置为0x0 将 删除 "存入和取出" 令牌的功能
    /// token 到 EL（EigenLayer） IStrategy 策略 的 mapping
    /// mapping(IERC20 => IStrategy) public tokenStrategyMapping;
    ///
    /// @dev Sets the strategy for a given token - setting strategy to 0x0 removes the ability to deposit and withdraw token
    function setTokenStrategy(
        IERC20 _token,
        IStrategy _strategy
    ) external nonReentrant onlyOperatorDelegatorAdmin {
        if(address(_token) == address(0x0)) revert InvalidZeroInput();

        tokenStrategyMapping[_token] = _strategy;
        emit TokenStrategyUpdated(_token, _strategy);
    }

    /// @dev Sets the address to delegate tokens to in EigenLayer -- THIS CAN ONLY BE SET ONCE
   
    /// 设置委托地址 (setDelegateAddress)：设置要委托代币的地址，在 EigenLayer 中委托代币到指定地址。
    
    /// EigenLayer delegateAddress 地址
    /// address public delegateAddress;

    /// EigenLayer delegationManager
    /// IDelegationManager public delegationManager;
    function setDelegateAddress(
        address _delegateAddress
    ) external nonReentrant onlyOperatorDelegatorAdmin {
        if(address(_delegateAddress) == address(0x0)) revert InvalidZeroInput();
        if(address(delegateAddress) != address(0x0)) revert DelegateAddressAlreadySet();

        delegateAddress = _delegateAddress;

        /// EigenLayer delegationManager
        delegationManager.delegateTo(
            delegateAddress
        );

        emit DelegationAddressUpdated(_delegateAddress);
    }


    
    /// token 到 EL（EigenLayer） 策略 的 映射
    /// mapping(IERC20 => IStrategy) public tokenStrategyMapping;
    /// EL（EigenLayer） strategyManager
    /// IStrategyManager public strategyManager;

    /// @dev 将代币存入EigenLayer。该调用假定此合约中的任何代币余额都将被委托，因此请勿直接将代币发送到此处，否则它们将被委托并归属于下一个调用者。
    /// @return shares 作为操作的一部分在 "strategy" 中创建的新份额数量

    /// @dev Deposit tokens into the EigenLayer.  This call assumes any balance of tokens in this contract will be delegated
    /// so do not directly send tokens here or they will be delegated and attributed to the next caller.
    /// @return shares The amount of new shares in the `strategy` created as part of the action.
    function deposit(
        IERC20 _token,
        uint256 _tokenAmount
    ) external nonReentrant onlyRestakeManager returns (uint256 shares) {
        if(address(tokenStrategyMapping[_token]) == address(0x0)) revert InvalidZeroInput();
        if(_tokenAmount == 0) revert InvalidZeroInput();

        // Move the tokens into this contract
        _token.safeTransferFrom(msg.sender, address(this), _tokenAmount);

        // Approve the strategy manager to spend the tokens
        _token.safeApprove(address(strategyManager), _tokenAmount);

        // Deposit the tokens via the strategy manager
        return
            strategyManager.depositIntoStrategy(
                tokenStrategyMapping[_token],
                _token,
                _tokenAmount
            );
    }

    /// @dev 获取 策略列表 EigenLayer中 特定策略的索引
    ///
    /// @dev Gets the index of the specific strategy in EigenLayer in the staker's strategy list
    function getStrategyIndex(IStrategy _strategy) public view returns (uint256) {
        // Get the length of the strategy list for this contract
        uint256 strategyLength = strategyManager.stakerStrategyListLength(address(this));

        for(uint256 i = 0; i < strategyLength; i++) {
            if(strategyManager.stakerStrategyList(address(this), i) == _strategy) {
                return i;
            }
        }

        // Not found
        revert NotFound();
    }

    /// 开始提款 (startWithdrawal)：开始从 EigenLayer 中提取特定代币的提款流程，将提款交由策略管理器处理。
    ///
    /// @dev 启动从 EigenLayer 提取特定代币的提现。
    /// @param _token 要从 EigenLayer 提取的代币。
    /// @param _tokenAmount 要提取的代币数量。    
    ///
    /// @dev Starts a withdrawal of a specific token from the EigenLayer.
    /// @param _token The token to withdraw from the EigenLayer.
    /// @param _tokenAmount The amount of tokens to withdraw.
    function startWithdrawal(
        IERC20 _token,
        uint256 _tokenAmount
    ) external nonReentrant onlyRestakeManager returns (bytes32) {
        // 验证 抵押品 token 对应的 EL 策略是否设置了
        if(address(tokenStrategyMapping[_token]) == address(0x0)) revert InvalidZeroInput();

        // 保存EL提现 nonce
        // Save the nonce before starting the withdrawal
        uint96 nonce = uint96(strategyManager.numWithdrawalsQueued(address(this)));

        // Need to get the index for the strategy - this is not ideal since docs say only to put into list ones that we are withdrawing 100% from
        uint256[] memory strategyIndexes = new uint256[](1);
        strategyIndexes[0] = getStrategyIndex(tokenStrategyMapping[_token]);

        // Convert the number of tokens to shares - TODO: Understand if the view function is the proper one to call
        
        // EL（EigenLayer） Strategy underlyingToSharesView
        uint256 sharesToWithdraw = tokenStrategyMapping[_token].underlyingToSharesView(_tokenAmount);

        IStrategy[] memory strategiesToWithdraw = new IStrategy[](1);
        strategiesToWithdraw[0] = tokenStrategyMapping[_token];

        uint256[] memory amountsToWithdraw = new uint256[](1);
        amountsToWithdraw[0] = sharesToWithdraw;

        bytes32 withdrawalRoot = strategyManager.queueWithdrawal(
            strategyIndexes,
            strategiesToWithdraw,
            amountsToWithdraw,
            address(this), // Only allow this contract to complete the withdraw
            false // Do not undeledgate if the balance goes to 0
        );

        // Emit the withdrawal started event
        emit WithdrawStarted(
            withdrawalRoot,
            address(this),
            delegateAddress,
            address(this),
            nonce,
            block.number,
            strategiesToWithdraw,
            amountsToWithdraw
        );

        return withdrawalRoot;
    }

    /// 完成提款 (completeWithdrawal)：完成从 EigenLayer 中提取特定代币的提款流程，将提取的代币发送到指定的地址。
    /// @dev 完成从 EL（EigenLayer） 提取特定令牌的操作
    /// 提取的令牌将直接发送到指定的地址

    /// @dev Completes a withdrawal of a specific token from the EigenLayer.
    /// The tokens withdrawn will be sent directly to the specified address
    function completeWithdrawal(
        IStrategyManager.QueuedWithdrawal calldata _withdrawal,
        IERC20 _token,
        uint256 _middlewareTimesIndex,
        address _sendToAddress
    ) external nonReentrant onlyRestakeManager {
        IERC20[] memory tokens = new IERC20[](1);
        tokens[0] = _token;

        strategyManager.completeQueuedWithdrawal(
            _withdrawal,
            tokens,
            _middlewareTimesIndex,
            true // Always get tokens and not share transfers
        );

        // Send tokens to the specified address
        // TODO: do not user balance of
        _token.safeTransfer(_sendToAddress, _token.balanceOf(address(this)));
    }

    /// @dev 获取质押在策略中的token 的 余额

    /// @dev Gets the underlying token amount from the amount of shares
    function getTokenBalanceFromStrategy(
        IERC20 token
    ) external view returns (uint256) {
        // EL（EigenLayer）Strategy userUnderlyingView
        return tokenStrategyMapping[token].userUnderlyingView(address(this));
    }

    /// @dev 获取在 EigenLayer 中抵押的以太币数量

    /// @dev Gets the amount of ETH staked in the EigenLayer
    function getStakedETHBalance() external view returns (uint256) {
        // TODO: Once withdrawals are enabled, allow this to handle pending withdraws and a potential negative share balance in the EigenPodManager ownershares        
        // TODO: Once upgraded to M2, add back in staked verified ETH, e.g. + uint256(strategyManager.stakerStrategyShares(address(this), strategyManager.beaconChainETHStrategy()))
        // TODO: once M2 is released, there is a possibility someone could call Verify() to try and mess up the TVL calcs (we would double count the stakedButNotVerifiedEth + actual verified ETH in the EigenPod)
        //       - we should track the validator node's verified status to ensure this doesn't happen

        /// 一旦启用提款，需要允许此功能处理待处理的提款和 EigenPodManager 所有者份额中的潜在负份额。
        /// 在升级到 M2 后，需要重新添加已验证的 ETH，例如：+ uint256(strategyManager.stakerStrategyShares(address(this), strategyManager.beaconChainETHStrategy()))。
        /// 一旦 M2 发布，可能会有人调用 Verify() 来尝试干扰 TVL 计算（我们将在 EigenPod 中重复计算已质押但尚未验证的 ETH + 实际验证的 ETH）。
        /// - 我们应该跟踪验证节点的验证状态，以确保这种情况不会发生。
        return stakedButNotVerifiedEth + address(eigenPod).balance + pendingUnstakedDelayedWithdrawalAmount;
    }

    /// 
    /// @dev 在 EigenLayer 中抵押以太币
    /// 只有再委托管理器应该调用此函数

    /// @dev Stake ETH in the EigenLayer
    /// Only the Restake Manager should call this function
    function stakeEth(bytes calldata pubkey, bytes calldata signature, bytes32 depositDataRoot) external payable onlyRestakeManager {
        // Call the stake function in the EigenPodManager
        eigenPodManager.stake{value: msg.value}(pubkey, signature, depositDataRoot);

        // Increment the staked but not verified ETH
        stakedButNotVerifiedEth += msg.value;
    }

    /// @dev 验证提款的凭证
    /// 这将允许 EigenPodManager 验证提款的凭证并向 OD 发放份额
    /// 只有本地 ETH 再委托管理员应该调用此函数

    /// @dev Verifies the withdrawal credentials for a withdrawal
    /// This will allow the EigenPodManager to verify the withdrawal credentials and credit the OD with shares
    /// Only the native eth restake admin should call this function
    function verifyWithdrawalCredentials(
        uint64 oracleBlockNumber,
        uint40 validatorIndex,
        BeaconChainProofs.ValidatorFieldsAndBalanceProofs memory proofs,
        bytes32[] calldata validatorFields
    ) external onlyNativeEthRestakeAdmin {
        eigenPod.verifyWithdrawalCredentialsAndBalance(
            oracleBlockNumber,
            validatorIndex,
            proofs,
            validatorFields
        );

        // Decrement the staked but not verified ETH
        uint64 validatorCurrentBalanceGwei = BeaconChainProofs.getBalanceFromBalanceRoot(validatorIndex, proofs.balanceRoot);
        stakedButNotVerifiedEth -= (validatorCurrentBalanceGwei * GWEI_TO_WEI);
    }
    
    /**
     * @notice  开始从 EigenPodManager 延迟提取以太币
     * @dev     在 EigenPod 验证之前，我们可以清理掉从共识层验证节点奖励中累积的任何以太币
     *          我们还希望跟踪延迟提取路由器中的金额，以便准确跟踪 TVL 和奖励金额
     * 
     * 
     * @notice  Starts a delayed withdraw of the ETH from the EigenPodManager
     * @dev     Before the eigenpod is verified, we can sweep out any accumulated ETH from the Consensus layer validator rewards
     *         We also want to track the amount in the delayed withdrawal router so we can track the TVL and reward amount accurately
     */
    function startDelayedWithdrawUnstakedETH() external onlyNativeEthRestakeAdmin {

        // Get the current balance of the EigenPod
        uint256 beforeEigenPodBalance = address(eigenPod).balance;

        // Call the start delayed withdraw function in the EigenPodManager
        // This will queue up a delayed withdrawal that will be sent back to this address after the timeout
        eigenPod.withdrawBeforeRestaking();

        // Add to the total amount of pending rewards for this delayed withdrawal to the total we are tracking
        pendingUnstakedDelayedWithdrawalAmount += (beforeEigenPodBalance - address(eigenPod).balance); 
    }

    /**
     * 
     * @notice 用户不应直接向此合约发送 ETH，除非他们想要捐赠给现有的 ezETH 持有者。
     *         这是一个内部协议功能。
     * @dev 处理发送到此合约的 ETH - 将被转发到存款队列以作为协议奖励进行重新质押
     * 
     * 
     * @notice Users should NOT send ETH directly to this contract unless they want to donate to existing ezETH holders.
     *        This is an internal protocol function.
     * @dev Handle ETH sent to this contract - will get forwarded to the deposit queue for restaking as a protocol reward
    */
    receive() external payable nonReentrant {      

        // If a payment comes in from the delayed withdrawal router, assume it is from the pending unstaked withdrawal 
        // and subtract that amount from the pending amount
        if(msg.sender == address(eigenPod.delayedWithdrawalRouter())) {
            if(msg.value <= pendingUnstakedDelayedWithdrawalAmount) {
                // If it is less than we are tracking, subtract it
                pendingUnstakedDelayedWithdrawalAmount -= msg.value;
            } else {
                // If it is more than we are tracking, set it to 0
                pendingUnstakedDelayedWithdrawalAmount = 0;
            }
        }

        address destination = address(restakeManager.depositQueue());
        (bool success, ) = destination.call{value: msg.value}("");
        if(!success) revert TransferFailed();

        emit RewardsForwarded(destination, msg.value);
    }
}
