// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import "./EigenLayer/interfaces/IStrategy.sol";
import "./EigenLayer/interfaces/IDelegationManager.sol";
import "./EigenLayer/interfaces/IStrategyManager.sol";
import "./token/IEzEthToken.sol";
import "./Delegation/IOperatorDelegator.sol";
import "./Permissions/IRoleManager.sol";
import "./Oracle/IRenzoOracle.sol";
import "./Deposits/IDepositQueue.sol";
import "./IRestakeManager.sol";

abstract contract RestakeManagerStorageV1 is IRestakeManager {
    /// @dev reference to the RoleManager contract
    // 管理角色
    IRoleManager public roleManager;

    /// @dev reference to the ezETH token contract
    // LRT token
    IEzEthToken public ezETH;

    /// @dev reference to the strategyManager contract in EigenLayer
    // EigenLayer (EL) 的 strategyManager
    IStrategyManager public strategyManager;

    /// @dev reference to the delegationManager contract in EigenLayer
    // EigenLayer (EL) 的 delegationManager
    IDelegationManager public delegationManager;

    /// @dev data stored for a withdrawal
    // 待提现
    struct PendingWithdrawal {
        uint256 ezETHToBurn;                     // 待销毁的 LRT
        address withdrawer;                      // 提现地址
        IERC20 tokenToWithdraw;                  // 提现的 token 合约地址
        uint256 tokenAmountToWithdraw;           // 提现金额
        IOperatorDelegator operatorDelegator;    // 运营商代理
        bool completed;                          // 是否完成
    }

    /// @dev mapping of pending withdrawals, indexed by the withdrawal root from EigenLayer
    // 待提现列表
    mapping(bytes32 => PendingWithdrawal) public pendingWithdrawals;

    /// @dev Stores the list of OperatorDelegators
    // 运营商代理 列表 （缩写：OD）
    IOperatorDelegator[] public operatorDelegators;

    /// @dev Mapping to store the allocations to each operatorDelegator
    /// Stored in basis points (e.g. 1% = 100)
    /// 运营商代理 分配额
    mapping(IOperatorDelegator => uint256) public operatorDelegatorAllocations;

    /// @dev Stores the list of collateral tokens
    // 抵押品 token 列表
    IERC20[] public collateralTokens;

    /// @dev Reference to the oracle contract
    // 项目自己的 Oracle
    IRenzoOracle public renzoOracle;

    /// @dev Controls pause state of contract
    // 是否暂停
    bool public paused;

    /// @dev The max amount of TVL allowed.  If this is set to 0, no max TVL is enforced
    // 允许的 最大 的质押价值
    uint256 public maxDepositTVL;

    /// @dev Reference to the deposit queue contract
    // 质押队列
    IDepositQueue public depositQueue;
}

abstract contract RestakeManagerStorageV2 is RestakeManagerStorageV1 {    
    // 抵押品Token 总锁定价值 限额
    mapping(IERC20 => uint256) public collateralTokenTvlLimits;
}
