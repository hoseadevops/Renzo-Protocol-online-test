//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./DepositQueueStorage.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "../Errors/Errors.sol";


// 当用户存入原生以太币时，它会通过以太坊信标链验证节点进行质押。原生以太币会存放在DepositQueue合约中，
// 直到达到32 ETH的最低要求。一旦达到最低要求，ETH将直接发送到信标链存款合约，并且提款凭证指向 EigenLayer中 的 EigenPod

// 这使得ETH可以获得质押奖励，并且还可以为EigenLayer中的AVS提供安全保障，因为关闭验证节点将使EigenPod有能力在发生惩罚事件时扣留一部分ETH。
// 存入的ETH为协议赚取以太坊验证者奖励和EigenLayer AVS奖励
contract DepositQueue is Initializable, ReentrancyGuardUpgradeable, DepositQueueStorageV1 {

    using SafeERC20 for IERC20;

    event RewardsDeposited(
        IERC20 token,
        uint256 amount
    );

    event FeeConfigUpdated(
        address feeAddress,
        uint256 feeBasisPoints
    );

    event RestakeManagerUpdated(
        IRestakeManager restakeManager
    );

    event ETHDepositedFromProtocol(
        uint256 amount
    );

    event ETHStakedFromQueue(
        IOperatorDelegator operatorDelegator,
        bytes pubkey,
        uint256 amountStaked,
        uint256 amountQueued
    );

    event ProtocolFeesPaid(
        IERC20 token,
        uint256 amount,
        address destination
    );

    /// @dev Allows only a whitelisted address to configure the contract
    modifier onlyRestakeManagerAdmin() {
        if(!roleManager.isRestakeManagerAdmin(msg.sender)) revert NotRestakeManagerAdmin();
        _;
    }

    /// @dev Allows only the RestakeManager address to call functions
    modifier onlyRestakeManager() {
        if(msg.sender != address(restakeManager)) revert NotRestakeManager();
        _;
    }

    /// @dev Allows only a whitelisted address to trigger native ETH staking
    modifier onlyNativeEthRestakeAdmin() {
        if(!roleManager.isNativeEthRestakeAdmin(msg.sender)) revert NotNativeEthRestakeAdmin();
        _;
    }

    /// @dev Allows only a whitelisted address to trigger ERC20 rewards sweeping
    modifier onlyERC20RewardsAdmin() {
        if(!roleManager.isERC20RewardsAdmin(msg.sender)) revert NotERC20RewardsAdmin();
        _;
    }

    /// @dev Prevents implementation contract from being initialized.
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        // _disableInitializers();
    }

    /// @dev Initializes the contract with initial vars
    function initialize(IRoleManager _roleManager) public initializer {
        __ReentrancyGuard_init();

        if(address(_roleManager) == address(0x0)) revert InvalidZeroInput(); 
        
        roleManager = _roleManager;   
    }

    /// @dev Sets the config for fees - if either value is set to 0 then fees are disabled
    /// @dev 设置费用的配置 - 如果任一值设置为 0，则禁用费用
    function setFeeConfig(address _feeAddress, uint256 _feeBasisPoints) external onlyRestakeManagerAdmin {
        // Verify address is set if basis points are non-zero
        // 如果基点非零，则验证地址已设置
        if(_feeBasisPoints > 0) {
            if(_feeAddress == address(0x0)) revert InvalidZeroInput();
        }

        // Verify basis points are not over 100%
        // 验证基点未超过100%
        if(_feeBasisPoints > 10000) revert OverMaxBasisPoints();

        feeAddress = _feeAddress;
        feeBasisPoints = _feeBasisPoints;

        emit FeeConfigUpdated(_feeAddress, _feeBasisPoints);
    }

    /// @dev Sets the address of the RestakeManager contract
    /// @dev 设置RestakeManager合约的地址
    function setRestakeManager(IRestakeManager _restakeManager) external onlyRestakeManagerAdmin {
        if(address(_restakeManager) == address(0x0)) revert InvalidZeroInput();

        restakeManager = _restakeManager;

        emit RestakeManagerUpdated(_restakeManager);
    }

    /// @dev Handle ETH sent to the protocol through the RestakeManager - e.g. user deposits
    /// ETH will be stored here until used for a validator deposit
    /// @dev 处理 通过 RestakeManager 发送过来ETH
    /// 例如 : 用户 deposit ETH 将在此存储，直到用于 validator deposit（验证人质押）
    function depositETHFromProtocol() external payable onlyRestakeManager {
        emit ETHDepositedFromProtocol(msg.value);
    }

    /// @dev Handle ETH sent to this contract from outside the protocol - e.g. rewards
    /// ETH will be stored here until used for a validator deposit
    /// This should receive ETH from scenarios like Execution Layer Rewards and MEV (Maximal Extractable Value) from native staking
    /// Users should NOT send ETH directly to this contract unless they want to donate to existing ezETH holders
    
    /// @dev 处理从协议外部发送到此合约的ETH - 例如，奖励
    /// ETH将在此存储，直到用于 validator deposit（验证人质押）
    /// 这应该 从 以太坊执行层奖励 和 最大可提取价值（MEV）以太坊原生质押的 接收 ETH
    /// 用户不应直接将ETH发送到此合约，除非他们想捐赠给现有的ezETH持有者
    receive() external payable nonReentrant { 
        uint256 feeAmount = 0;
        // Take protocol cut of rewards if enabled
        // 如果启用（地址和百分比有一个为0 则不启用），从奖励中获取协议费用
        if(feeAddress != address(0x0) && feeBasisPoints > 0) {
            feeAmount = msg.value * feeBasisPoints / 10000;
            (bool success, ) = feeAddress.call{value: feeAmount}("");
            if(!success) revert TransferFailed();

            emit ProtocolFeesPaid(IERC20(address(0x0)), feeAmount, feeAddress);
        } 

        // Add to the total earned
        // 将奖励总额增加
        totalEarned[address(0x0)] = totalEarned[address(0x0)] + msg.value - feeAmount;

        // Emit the rewards event
        emit RewardsDeposited(IERC20(address(0x0)), msg.value - feeAmount);
    }

    /// @dev Function called by ETH Restake Admin to start the restaking process in Native ETH
    /// Only callable by a permissioned account

    /// @dev 管理员调用此函数，启动原生ETH的重质押过程
    /// 仅可由授权帐户调用

    /// 运营商代理、公钥、签名、质押根
    function stakeEthFromQueue(IOperatorDelegator operatorDelegator, bytes calldata pubkey, bytes calldata signature, bytes32 depositDataRoot) external onlyNativeEthRestakeAdmin {

        // Send the ETH and the params through to the restake manager
        // 将ETH和参数发送到重新质押管理器
        restakeManager.stakeEthInOperatorDelegator{value: 32 ether}(operatorDelegator, pubkey, signature, depositDataRoot);

        emit ETHStakedFromQueue(operatorDelegator, pubkey, 32 ether, address(this).balance);
    }

    /// @dev Sweeps any accumulated ERC20 tokens in this contract to the RestakeManager
    /// Only callable by a permissioned account

    /// @dev 将此合约中累积的任何ERC20令牌 移动 到 RestakeManager
    /// 仅可由授权帐户调用
    function sweepERC20(IERC20 token) external onlyERC20RewardsAdmin {
        uint256 balance = IERC20(token).balanceOf(address(this));
        if(balance > 0) {
            uint256 feeAmount = 0;

            // Sweep fees if configured
            // 如果配置了手续费，则支付手续费
            if(feeAddress != address(0x0) && feeBasisPoints > 0) {
                feeAmount = balance * feeBasisPoints / 10000;
                IERC20(token).safeTransfer(feeAddress, feeAmount);

                emit ProtocolFeesPaid(token, feeAmount, feeAddress);
            }

            // Approve and deposit the rewards
             // 授权 剩下的所有 ERC20 token 额度 给 restakeManager
            token.approve(address(restakeManager), balance - feeAmount);
            // 调用 被授权合约：restakeManager
            restakeManager.depositTokenRewardsFromProtocol(token, balance - feeAmount);

            // Add to the total earned
            // 除了手续费的总收入
            totalEarned[address(token)] = totalEarned[address(token)] + balance - feeAmount;

            // Emit the rewards event
            emit RewardsDeposited(IERC20(address(token)), balance - feeAmount);
        }
    }
}