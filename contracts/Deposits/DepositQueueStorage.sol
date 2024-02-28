// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import "../Permissions/IRoleManager.sol";
import "../IRestakeManager.sol";
import "./IDepositQueue.sol";

abstract contract DepositQueueStorageV1 is IDepositQueue {    
    /// @dev reference to the RoleManager contract
    IRoleManager public roleManager;

    /// @dev the address of the RestakeManager contract
    IRestakeManager public restakeManager;

    /// @dev the address where fees will be sent - must be non zero to enable fees
    /// 手续费地址
    address public feeAddress;

    /// @dev the basis points to charge for fees - 100 basis points = 1%
    // 收取手续费的 基点 feeBasisPoints/10000
    uint256 public feeBasisPoints;

    /// @dev the total amount the protocol has earned - token address => amount
    /// @dev 协议获得的总金额 mapping ( 令牌地址 => 金额 )
    mapping(address => uint256) public totalEarned;
}
