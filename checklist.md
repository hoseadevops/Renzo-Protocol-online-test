'npx hardhat clean' running (wd: /Users/hosea/work/audit/evaluate/Renzo-Protocol-online)
'npx hardhat clean --global' running (wd: /Users/hosea/work/audit/evaluate/Renzo-Protocol-online)
'npx hardhat compile --force' running (wd: /Users/hosea/work/audit/evaluate/Renzo-Protocol-online)
INFO:Detectors:
RestakeManager.deposit(IERC20,uint256,uint256) (contracts/RestakeManager.sol#494-570) ignores return value by operatorDelegator.deposit(_collateralToken,_amount) (contracts/RestakeManager.sol#556)
RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256) (contracts/RestakeManager.sol#639-669) ignores return value by operatorDelegator.deposit(_token,_amount) (contracts/RestakeManager.sol#668)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unused-return
INFO:Detectors:
RestakeManager.calculateTVLs() (contracts/RestakeManager.sol#296-362) has external calls inside a loop: operatorBalance = operatorDelegators[i].getTokenBalanceFromStrategy(collateralTokens[j]) (contracts/RestakeManager.sol#325-326)
RestakeManager.calculateTVLs() (contracts/RestakeManager.sol#296-362) has external calls inside a loop: operatorValues[j] = renzoOracle.lookupTokenValue(collateralTokens[j],operatorBalance) (contracts/RestakeManager.sol#329-332)
RestakeManager.calculateTVLs() (contracts/RestakeManager.sol#296-362) has external calls inside a loop: operatorEthBalance = operatorDelegators[i].getStakedETHBalance() (contracts/RestakeManager.sol#341)
RestakeManager.getTotalRewardsEarned() (contracts/RestakeManager.sol#676-704) has external calls inside a loop: tokenRewardAmount = depositQueue.totalEarned(address(collateralTokens[i])) (contracts/RestakeManager.sol#686)
RestakeManager.getTotalRewardsEarned() (contracts/RestakeManager.sol#676-704) has external calls inside a loop: totalRewards += renzoOracle.lookupTokenValue(collateralTokens[i],tokenRewardAmount) (contracts/RestakeManager.sol#689)
RestakeManager.getTotalRewardsEarned() (contracts/RestakeManager.sol#676-704) has external calls inside a loop: totalRewards += address(operatorDelegators[i_scope_0].eigenPod()).balance + operatorDelegators[i_scope_0].pendingUnstakedDelayedWithdrawalAmount() (contracts/RestakeManager.sol#699)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation/#calls-inside-a-loop
INFO:Detectors:
Lock.constructor(uint256) (contracts/Lock.sol#13-21) uses timestamp for comparisons
	Dangerous comparisons:
	- require(bool,string)(block.timestamp < _unlockTime,Unlock time should be in the future) (contracts/Lock.sol#14-17)
Lock.withdraw() (contracts/Lock.sol#23-33) uses timestamp for comparisons
	Dangerous comparisons:
	- require(bool,string)(block.timestamp >= unlockTime,You can't withdraw yet) (contracts/Lock.sol#27)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#block-timestamp
INFO:Detectors:
AddressUpgradeable._revert(bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#231-243) uses assembly
	- INLINE ASM (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#236-239)
Address._revert(bytes,string) (@openzeppelin/contracts/utils/Address.sol#231-243) uses assembly
	- INLINE ASM (@openzeppelin/contracts/utils/Address.sol#236-239)
Merkle.processInclusionProofKeccak(bytes,bytes32,uint256) (contracts/EigenLayer/libraries/Merkle.sol#48-71) uses assembly
	- INLINE ASM (contracts/EigenLayer/libraries/Merkle.sol#54-59)
	- INLINE ASM (contracts/EigenLayer/libraries/Merkle.sol#62-67)
Merkle.processInclusionProofSha256(bytes,bytes32,uint256) (contracts/EigenLayer/libraries/Merkle.sol#100-123) uses assembly
	- INLINE ASM (contracts/EigenLayer/libraries/Merkle.sol#106-111)
	- INLINE ASM (contracts/EigenLayer/libraries/Merkle.sol#114-119)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage
INFO:Detectors:
Different versions of Solidity are used:
	- Version used: ['0.8.19', '=0.8.19', '^0.8.0', '^0.8.1', '^0.8.2', '^0.8.9']
	- 0.8.19 (contracts/Delegation/IOperatorDelegator.sol#2)
	- 0.8.19 (contracts/Deposits/IDepositQueue.sol#2)
	- 0.8.19 (contracts/Errors/Errors.sol#2)
	- 0.8.19 (contracts/IRestakeManager.sol#2)
	- 0.8.19 (contracts/Lock.sol#2)
	- 0.8.19 (contracts/Oracle/IRenzoOracle.sol#2)
	- 0.8.19 (contracts/Permissions/IRoleManager.sol#2)
	- 0.8.19 (contracts/RestakeManager.sol#2)
	- 0.8.19 (contracts/RestakeManagerStorage.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IBeaconChainOracle.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IDelayedWithdrawalRouter.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IDelegationManager.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IDelegationTerms.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IEigenPod.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IEigenPodManager.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IPausable.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IPauserRegistry.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/ISlasher.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IStrategy.sol#2)
	- =0.8.19 (contracts/EigenLayer/interfaces/IStrategyManager.sol#2)
	- =0.8.19 (contracts/EigenLayer/libraries/BeaconChainProofs.sol#3)
	- =0.8.19 (contracts/EigenLayer/libraries/Endian.sol#2)
	- =0.8.19 (contracts/EigenLayer/libraries/Merkle.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts/token/ERC20/IERC20.sol#4)
	- ^0.8.0 (@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
	- ^0.8.0 (@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#4)
	- ^0.8.0 (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#4)
	- ^0.8.1 (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#4)
	- ^0.8.1 (@openzeppelin/contracts/utils/Address.sol#4)
	- ^0.8.2 (@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#4)
	- ^0.8.9 (contracts/token/IEzEthToken.sol#2)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
RestakeManager.removeOperatorDelegator(IOperatorDelegator) (contracts/RestakeManager.sol#170-200) has costly operations inside a loop:
	- operatorDelegators.pop() (contracts/RestakeManager.sol#191)
RestakeManager.removeCollateralToken(IERC20) (contracts/RestakeManager.sol#263-285) has costly operations inside a loop:
	- collateralTokens.pop() (contracts/RestakeManager.sol#276)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#costly-operations-inside-a-loop
INFO:Detectors:
Address.functionCall(address,bytes) (@openzeppelin/contracts/utils/Address.sol#89-91) is never used and should be removed
Address.functionCallWithValue(address,bytes,uint256) (@openzeppelin/contracts/utils/Address.sol#118-120) is never used and should be removed
Address.functionDelegateCall(address,bytes) (@openzeppelin/contracts/utils/Address.sol#170-172) is never used and should be removed
Address.functionDelegateCall(address,bytes,string) (@openzeppelin/contracts/utils/Address.sol#180-187) is never used and should be removed
Address.functionStaticCall(address,bytes) (@openzeppelin/contracts/utils/Address.sol#145-147) is never used and should be removed
Address.functionStaticCall(address,bytes,string) (@openzeppelin/contracts/utils/Address.sol#155-162) is never used and should be removed
Address.sendValue(address,uint256) (@openzeppelin/contracts/utils/Address.sol#64-69) is never used and should be removed
Address.verifyCallResult(bool,bytes,string) (@openzeppelin/contracts/utils/Address.sol#219-229) is never used and should be removed
AddressUpgradeable._revert(bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#231-243) is never used and should be removed
AddressUpgradeable.functionCall(address,bytes) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#89-91) is never used and should be removed
AddressUpgradeable.functionCall(address,bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#99-105) is never used and should be removed
AddressUpgradeable.functionCallWithValue(address,bytes,uint256) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#118-120) is never used and should be removed
AddressUpgradeable.functionCallWithValue(address,bytes,uint256,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#128-137) is never used and should be removed
AddressUpgradeable.functionDelegateCall(address,bytes) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#170-172) is never used and should be removed
AddressUpgradeable.functionDelegateCall(address,bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#180-187) is never used and should be removed
AddressUpgradeable.functionStaticCall(address,bytes) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#145-147) is never used and should be removed
AddressUpgradeable.functionStaticCall(address,bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#155-162) is never used and should be removed
AddressUpgradeable.sendValue(address,uint256) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#64-69) is never used and should be removed
AddressUpgradeable.verifyCallResult(bool,bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#219-229) is never used and should be removed
AddressUpgradeable.verifyCallResultFromTarget(address,bool,bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#195-211) is never used and should be removed
BeaconChainProofs.getBalanceFromBalanceRoot(uint40,bytes32) (contracts/EigenLayer/libraries/BeaconChainProofs.sol#139-144) is never used and should be removed
BeaconChainProofs.verifyValidatorBalance(uint40,bytes32,bytes,bytes32) (contracts/EigenLayer/libraries/BeaconChainProofs.sol#182-198) is never used and should be removed
BeaconChainProofs.verifyValidatorFields(uint40,bytes32,bytes,bytes32[]) (contracts/EigenLayer/libraries/BeaconChainProofs.sol#153-173) is never used and should be removed
BeaconChainProofs.verifyWithdrawalProofs(bytes32,BeaconChainProofs.WithdrawalProofs,bytes32[]) (contracts/EigenLayer/libraries/BeaconChainProofs.sol#206-261) is never used and should be removed
Endian.fromLittleEndianUint64(bytes32) (contracts/EigenLayer/libraries/Endian.sol#12-26) is never used and should be removed
Initializable._getInitializedVersion() (@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#156-158) is never used and should be removed
Initializable._isInitializing() (@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#163-165) is never used and should be removed
Merkle.merkleizeSha256(bytes32[]) (contracts/EigenLayer/libraries/Merkle.sol#131-155) is never used and should be removed
Merkle.processInclusionProofKeccak(bytes,bytes32,uint256) (contracts/EigenLayer/libraries/Merkle.sol#48-71) is never used and should be removed
Merkle.processInclusionProofSha256(bytes,bytes32,uint256) (contracts/EigenLayer/libraries/Merkle.sol#100-123) is never used and should be removed
Merkle.verifyInclusionKeccak(bytes,bytes32,bytes32,uint256) (contracts/EigenLayer/libraries/Merkle.sol#29-36) is never used and should be removed
Merkle.verifyInclusionSha256(bytes,bytes32,bytes32,uint256) (contracts/EigenLayer/libraries/Merkle.sol#81-88) is never used and should be removed
ReentrancyGuardUpgradeable._reentrancyGuardEntered() (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#79-81) is never used and should be removed
SafeERC20._callOptionalReturnBool(IERC20,bytes) (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#134-142) is never used and should be removed
SafeERC20.forceApprove(IERC20,address,uint256) (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#82-89) is never used and should be removed
SafeERC20.safeDecreaseAllowance(IERC20,address,uint256) (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#69-75) is never used and should be removed
SafeERC20.safeIncreaseAllowance(IERC20,address,uint256) (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#60-63) is never used and should be removed
SafeERC20.safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32) (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#95-109) is never used and should be removed
SafeERC20.safeTransfer(IERC20,address,uint256) (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#26-28) is never used and should be removed
SafeERC20Upgradeable._callOptionalReturn(IERC20Upgradeable,bytes) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#117-124) is never used and should be removed
SafeERC20Upgradeable._callOptionalReturnBool(IERC20Upgradeable,bytes) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#134-142) is never used and should be removed
SafeERC20Upgradeable.forceApprove(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#82-89) is never used and should be removed
SafeERC20Upgradeable.safeApprove(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#45-54) is never used and should be removed
SafeERC20Upgradeable.safeDecreaseAllowance(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#69-75) is never used and should be removed
SafeERC20Upgradeable.safeIncreaseAllowance(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#60-63) is never used and should be removed
SafeERC20Upgradeable.safePermit(IERC20PermitUpgradeable,address,address,uint256,uint256,uint8,bytes32,bytes32) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#95-109) is never used and should be removed
SafeERC20Upgradeable.safeTransfer(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#26-28) is never used and should be removed
SafeERC20Upgradeable.safeTransferFrom(IERC20Upgradeable,address,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#34-36) is never used and should be removed
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dead-code
INFO:Detectors:
Pragma version^0.8.2 (@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#4) allows old versions
Pragma version^0.8.1 (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts/token/ERC20/IERC20.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#4) allows old versions
Pragma version^0.8.1 (@openzeppelin/contracts/utils/Address.sol#4) allows old versions
Pragma version0.8.19 (contracts/Delegation/IOperatorDelegator.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Deposits/IDepositQueue.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IBeaconChainOracle.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IDelayedWithdrawalRouter.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IDelegationManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IDelegationTerms.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IEigenPod.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IEigenPodManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IPausable.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IPauserRegistry.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/ISlasher.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IStrategy.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/interfaces/IStrategyManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/libraries/BeaconChainProofs.sol#3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/libraries/Endian.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/EigenLayer/libraries/Merkle.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Errors/Errors.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/IRestakeManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Lock.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Oracle/IRenzoOracle.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Permissions/IRoleManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/RestakeManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/RestakeManagerStorage.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.9 (contracts/token/IEzEthToken.sol#2) allows old versions
solc-0.8.19 is not recommended for deployment
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
INFO:Detectors:
Low level call in SafeERC20Upgradeable._callOptionalReturnBool(IERC20Upgradeable,bytes) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#134-142):
	- (success,returndata) = address(token).call(data) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#139)
Low level call in AddressUpgradeable.sendValue(address,uint256) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#64-69):
	- (success) = recipient.call{value: amount}() (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#67)
Low level call in AddressUpgradeable.functionCallWithValue(address,bytes,uint256,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#128-137):
	- (success,returndata) = target.call{value: value}(data) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#135)
Low level call in AddressUpgradeable.functionStaticCall(address,bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#155-162):
	- (success,returndata) = target.staticcall(data) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#160)
Low level call in AddressUpgradeable.functionDelegateCall(address,bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#180-187):
	- (success,returndata) = target.delegatecall(data) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#185)
Low level call in SafeERC20._callOptionalReturnBool(IERC20,bytes) (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#134-142):
	- (success,returndata) = address(token).call(data) (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#139)
Low level call in Address.sendValue(address,uint256) (@openzeppelin/contracts/utils/Address.sol#64-69):
	- (success) = recipient.call{value: amount}() (@openzeppelin/contracts/utils/Address.sol#67)
Low level call in Address.functionCallWithValue(address,bytes,uint256,string) (@openzeppelin/contracts/utils/Address.sol#128-137):
	- (success,returndata) = target.call{value: value}(data) (@openzeppelin/contracts/utils/Address.sol#135)
Low level call in Address.functionStaticCall(address,bytes,string) (@openzeppelin/contracts/utils/Address.sol#155-162):
	- (success,returndata) = target.staticcall(data) (@openzeppelin/contracts/utils/Address.sol#160)
Low level call in Address.functionDelegateCall(address,bytes,string) (@openzeppelin/contracts/utils/Address.sol#180-187):
	- (success,returndata) = target.delegatecall(data) (@openzeppelin/contracts/utils/Address.sol#185)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#low-level-calls
INFO:Detectors:
Function ReentrancyGuardUpgradeable.__ReentrancyGuard_init() (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#40-42) is not in mixedCase
Function ReentrancyGuardUpgradeable.__ReentrancyGuard_init_unchained() (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#44-46) is not in mixedCase
Variable ReentrancyGuardUpgradeable.__gap (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#88) is not in mixedCase
Function IERC20PermitUpgradeable.DOMAIN_SEPARATOR() (@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#59) is not in mixedCase
Function IERC20Permit.DOMAIN_SEPARATOR() (@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#59) is not in mixedCase
Function IEigenPod.REQUIRED_BALANCE_GWEI() (contracts/EigenLayer/interfaces/IEigenPod.sol#53) is not in mixedCase
Function IEigenPod.REQUIRED_BALANCE_WEI() (contracts/EigenLayer/interfaces/IEigenPod.sol#56) is not in mixedCase
Enum IEigenPod.VALIDATOR_STATUS (contracts/EigenLayer/interfaces/IEigenPod.sol#28-33) is not in CapWords
Enum IEigenPod.PARTIAL_WITHDRAWAL_CLAIM_STATUS (contracts/EigenLayer/interfaces/IEigenPod.sol#46-50) is not in CapWords
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._roleManager (contracts/RestakeManager.sol#109) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._ezETH (contracts/RestakeManager.sol#110) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._renzoOracle (contracts/RestakeManager.sol#111) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._strategyManager (contracts/RestakeManager.sol#112) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._delegationManager (contracts/RestakeManager.sol#113) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._depositQueue (contracts/RestakeManager.sol#114) is not in mixedCase
Parameter RestakeManager.setPaused(bool)._paused (contracts/RestakeManager.sol#129) is not in mixedCase
Parameter RestakeManager.addOperatorDelegator(IOperatorDelegator,uint256)._newOperatorDelegator (contracts/RestakeManager.sol#140) is not in mixedCase
Parameter RestakeManager.addOperatorDelegator(IOperatorDelegator,uint256)._allocationBasisPoints (contracts/RestakeManager.sol#141) is not in mixedCase
Parameter RestakeManager.removeOperatorDelegator(IOperatorDelegator)._operatorDelegatorToRemove (contracts/RestakeManager.sol#171) is not in mixedCase
Parameter RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._operatorDelegator (contracts/RestakeManager.sol#204) is not in mixedCase
Parameter RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._allocationBasisPoints (contracts/RestakeManager.sol#205) is not in mixedCase
Parameter RestakeManager.setMaxDepositTVL(uint256)._maxDepositTVL (contracts/RestakeManager.sol#238) is not in mixedCase
Parameter RestakeManager.addCollateralToken(IERC20)._newCollateralToken (contracts/RestakeManager.sol#244) is not in mixedCase
Parameter RestakeManager.removeCollateralToken(IERC20)._collateralTokenToRemove (contracts/RestakeManager.sol#264) is not in mixedCase
Parameter RestakeManager.getCollateralTokenIndex(IERC20)._collateralToken (contracts/RestakeManager.sol#452) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256)._collateralToken (contracts/RestakeManager.sol#474) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256)._amount (contracts/RestakeManager.sol#475) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256,uint256)._collateralToken (contracts/RestakeManager.sol#495) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256,uint256)._amount (contracts/RestakeManager.sol#496) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256,uint256)._referralId (contracts/RestakeManager.sol#497) is not in mixedCase
Parameter RestakeManager.depositETH(uint256)._referralId (contracts/RestakeManager.sol#587) is not in mixedCase
Parameter RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)._token (contracts/RestakeManager.sol#640) is not in mixedCase
Parameter RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)._amount (contracts/RestakeManager.sol#641) is not in mixedCase
Parameter RestakeManager.setTokenTvlLimit(IERC20,uint256)._token (contracts/RestakeManager.sol#706) is not in mixedCase
Parameter RestakeManager.setTokenTvlLimit(IERC20,uint256)._limit (contracts/RestakeManager.sol#706) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
INFO:Detectors:
Variable RestakeManager.getCollateralTokenIndex(IERC20)._collateralToken (contracts/RestakeManager.sol#452) is too similar to RestakeManagerStorageV1.collateralTokens (contracts/RestakeManagerStorage.sol#48)
Variable RestakeManager.deposit(IERC20,uint256)._collateralToken (contracts/RestakeManager.sol#474) is too similar to RestakeManagerStorageV1.collateralTokens (contracts/RestakeManagerStorage.sol#48)
Variable RestakeManager.deposit(IERC20,uint256,uint256)._collateralToken (contracts/RestakeManager.sol#495) is too similar to RestakeManagerStorageV1.collateralTokens (contracts/RestakeManagerStorage.sol#48)
Variable RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._operatorDelegator (contracts/RestakeManager.sol#204) is too similar to RestakeManagerStorageV1.operatorDelegators (contracts/RestakeManagerStorage.sol#41)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#variable-names-too-similar
INFO:Detectors:
Endian.fromLittleEndianUint64(bytes32) (contracts/EigenLayer/libraries/Endian.sol#12-26) uses literals with too many digits:
	- (n >> 56) | ((0x00FF000000000000 & n) >> 40) | ((0x0000FF0000000000 & n) >> 24) | ((0x000000FF00000000 & n) >> 8) | ((0x00000000FF000000 & n) << 8) | ((0x0000000000FF0000 & n) << 24) | ((0x000000000000FF00 & n) << 40) | ((0x00000000000000FF & n) << 56) (contracts/EigenLayer/libraries/Endian.sol#17-25)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#too-many-digits
INFO:Detectors:
BeaconChainProofs.NUM_BEACON_BLOCK_HEADER_FIELDS (contracts/EigenLayer/libraries/BeaconChainProofs.sol#14) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.NUM_BEACON_BLOCK_BODY_FIELDS (contracts/EigenLayer/libraries/BeaconChainProofs.sol#17) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.NUM_BEACON_STATE_FIELDS (contracts/EigenLayer/libraries/BeaconChainProofs.sol#20) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.NUM_ETH1_DATA_FIELDS (contracts/EigenLayer/libraries/BeaconChainProofs.sol#23) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.ETH1_DATA_FIELD_TREE_HEIGHT (contracts/EigenLayer/libraries/BeaconChainProofs.sol#24) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.NUM_VALIDATOR_FIELDS (contracts/EigenLayer/libraries/BeaconChainProofs.sol#26) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.NUM_EXECUTION_PAYLOAD_HEADER_FIELDS (contracts/EigenLayer/libraries/BeaconChainProofs.sol#29) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.NUM_EXECUTION_PAYLOAD_FIELDS (contracts/EigenLayer/libraries/BeaconChainProofs.sol#33) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.EXECUTION_PAYLOAD_FIELD_TREE_HEIGHT (contracts/EigenLayer/libraries/BeaconChainProofs.sol#34) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.HISTORICAL_ROOTS_TREE_HEIGHT (contracts/EigenLayer/libraries/BeaconChainProofs.sol#38) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.HISTORICAL_BATCH_TREE_HEIGHT (contracts/EigenLayer/libraries/BeaconChainProofs.sol#41) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.STATE_ROOTS_TREE_HEIGHT (contracts/EigenLayer/libraries/BeaconChainProofs.sol#44) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.NUM_WITHDRAWAL_FIELDS (contracts/EigenLayer/libraries/BeaconChainProofs.sol#48) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.STATE_ROOT_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#63) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.PROPOSER_INDEX_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#64) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.STATE_ROOTS_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#68) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.HISTORICAL_ROOTS_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#70) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.ETH_1_ROOT_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#71) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.EXECUTION_PAYLOAD_HEADER_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#74) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.HISTORICAL_BATCH_STATE_ROOT_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#75) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.VALIDATOR_WITHDRAWAL_CREDENTIALS_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#78) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.VALIDATOR_BALANCE_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#79) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.VALIDATOR_SLASHED_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#80) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.VALIDATOR_WITHDRAWABLE_EPOCH_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#81) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.WITHDRAWALS_ROOT_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#85) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.WITHDRAWAL_VALIDATOR_INDEX_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#91) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.WITHDRAWAL_VALIDATOR_AMOUNT_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#92) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.HISTORICALBATCH_STATEROOTS_INDEX (contracts/EigenLayer/libraries/BeaconChainProofs.sol#95) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.SLOTS_PER_EPOCH (contracts/EigenLayer/libraries/BeaconChainProofs.sol#98) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
BeaconChainProofs.UINT64_MASK (contracts/EigenLayer/libraries/BeaconChainProofs.sol#100) is never used in BeaconChainProofs (contracts/EigenLayer/libraries/BeaconChainProofs.sol#12-264)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unused-state-variable
INFO:Detectors:
Lock.owner (contracts/Lock.sol#9) should be immutable 
Lock.unlockTime (contracts/Lock.sol#8) should be immutable 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-immutable
**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [unused-return](#unused-return) (2 results) (Medium)
 - [calls-loop](#calls-loop) (6 results) (Low)
 - [timestamp](#timestamp) (2 results) (Low)
 - [assembly](#assembly) (4 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [costly-loop](#costly-loop) (2 results) (Informational)
 - [dead-code](#dead-code) (48 results) (Informational)
 - [solc-version](#solc-version) (36 results) (Informational)
 - [low-level-calls](#low-level-calls) (10 results) (Informational)
 - [naming-convention](#naming-convention) (35 results) (Informational)
 - [similar-names](#similar-names) (4 results) (Informational)
 - [too-many-digits](#too-many-digits) (1 results) (Informational)
 - [unused-state](#unused-state) (30 results) (Informational)
 - [immutable-states](#immutable-states) (2 results) (Optimization)
## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-0
[RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)](contracts/RestakeManager.sol#L639-L669) ignores return value by [operatorDelegator.deposit(_token,_amount)](contracts/RestakeManager.sol#L668)

contracts/RestakeManager.sol#L639-L669


 - [ ] ID-1
[RestakeManager.deposit(IERC20,uint256,uint256)](contracts/RestakeManager.sol#L494-L570) ignores return value by [operatorDelegator.deposit(_collateralToken,_amount)](contracts/RestakeManager.sol#L556)

contracts/RestakeManager.sol#L494-L570


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-2
[RestakeManager.calculateTVLs()](contracts/RestakeManager.sol#L296-L362) has external calls inside a loop: [operatorBalance = operatorDelegators[i].getTokenBalanceFromStrategy(collateralTokens[j])](contracts/RestakeManager.sol#L325-L326)

contracts/RestakeManager.sol#L296-L362


 - [ ] ID-3
[RestakeManager.getTotalRewardsEarned()](contracts/RestakeManager.sol#L676-L704) has external calls inside a loop: [tokenRewardAmount = depositQueue.totalEarned(address(collateralTokens[i]))](contracts/RestakeManager.sol#L686)

contracts/RestakeManager.sol#L676-L704


 - [ ] ID-4
[RestakeManager.calculateTVLs()](contracts/RestakeManager.sol#L296-L362) has external calls inside a loop: [operatorEthBalance = operatorDelegators[i].getStakedETHBalance()](contracts/RestakeManager.sol#L341)

contracts/RestakeManager.sol#L296-L362


 - [ ] ID-5
[RestakeManager.getTotalRewardsEarned()](contracts/RestakeManager.sol#L676-L704) has external calls inside a loop: [totalRewards += address(operatorDelegators[i_scope_0].eigenPod()).balance + operatorDelegators[i_scope_0].pendingUnstakedDelayedWithdrawalAmount()](contracts/RestakeManager.sol#L699)

contracts/RestakeManager.sol#L676-L704


 - [ ] ID-6
[RestakeManager.getTotalRewardsEarned()](contracts/RestakeManager.sol#L676-L704) has external calls inside a loop: [totalRewards += renzoOracle.lookupTokenValue(collateralTokens[i],tokenRewardAmount)](contracts/RestakeManager.sol#L689)

contracts/RestakeManager.sol#L676-L704


 - [ ] ID-7
[RestakeManager.calculateTVLs()](contracts/RestakeManager.sol#L296-L362) has external calls inside a loop: [operatorValues[j] = renzoOracle.lookupTokenValue(collateralTokens[j],operatorBalance)](contracts/RestakeManager.sol#L329-L332)

contracts/RestakeManager.sol#L296-L362


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-8
[Lock.withdraw()](contracts/Lock.sol#L23-L33) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(block.timestamp >= unlockTime,You can't withdraw yet)](contracts/Lock.sol#L27)

contracts/Lock.sol#L23-L33


 - [ ] ID-9
[Lock.constructor(uint256)](contracts/Lock.sol#L13-L21) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(block.timestamp < _unlockTime,Unlock time should be in the future)](contracts/Lock.sol#L14-L17)

contracts/Lock.sol#L13-L21


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-10
[Address._revert(bytes,string)](@openzeppelin/contracts/utils/Address.sol#L231-L243) uses assembly
	- [INLINE ASM](@openzeppelin/contracts/utils/Address.sol#L236-L239)

@openzeppelin/contracts/utils/Address.sol#L231-L243


 - [ ] ID-11
[Merkle.processInclusionProofKeccak(bytes,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L48-L71) uses assembly
	- [INLINE ASM](contracts/EigenLayer/libraries/Merkle.sol#L54-L59)
	- [INLINE ASM](contracts/EigenLayer/libraries/Merkle.sol#L62-L67)

contracts/EigenLayer/libraries/Merkle.sol#L48-L71


 - [ ] ID-12
[AddressUpgradeable._revert(bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L231-L243) uses assembly
	- [INLINE ASM](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L236-L239)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L231-L243


 - [ ] ID-13
[Merkle.processInclusionProofSha256(bytes,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L100-L123) uses assembly
	- [INLINE ASM](contracts/EigenLayer/libraries/Merkle.sol#L106-L111)
	- [INLINE ASM](contracts/EigenLayer/libraries/Merkle.sol#L114-L119)

contracts/EigenLayer/libraries/Merkle.sol#L100-L123


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-14
Different versions of Solidity are used:
	- Version used: ['0.8.19', '=0.8.19', '^0.8.0', '^0.8.1', '^0.8.2', '^0.8.9']
	- [0.8.19](contracts/Delegation/IOperatorDelegator.sol#L2)
	- [0.8.19](contracts/Deposits/IDepositQueue.sol#L2)
	- [0.8.19](contracts/Errors/Errors.sol#L2)
	- [0.8.19](contracts/IRestakeManager.sol#L2)
	- [0.8.19](contracts/Lock.sol#L2)
	- [0.8.19](contracts/Oracle/IRenzoOracle.sol#L2)
	- [0.8.19](contracts/Permissions/IRoleManager.sol#L2)
	- [0.8.19](contracts/RestakeManager.sol#L2)
	- [0.8.19](contracts/RestakeManagerStorage.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IBeaconChainOracle.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IDelayedWithdrawalRouter.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IDelegationManager.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IDelegationTerms.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IEigenPod.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IEigenPodManager.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IPausable.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IPauserRegistry.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/ISlasher.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IStrategy.sol#L2)
	- [=0.8.19](contracts/EigenLayer/interfaces/IStrategyManager.sol#L2)
	- [=0.8.19](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L3)
	- [=0.8.19](contracts/EigenLayer/libraries/Endian.sol#L2)
	- [=0.8.19](contracts/EigenLayer/libraries/Merkle.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts/token/ERC20/IERC20.sol#L4)
	- [^0.8.0](@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4)
	- [^0.8.0](@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L4)
	- [^0.8.0](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L4)
	- [^0.8.1](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L4)
	- [^0.8.1](@openzeppelin/contracts/utils/Address.sol#L4)
	- [^0.8.2](@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L4)
	- [^0.8.9](contracts/token/IEzEthToken.sol#L2)

contracts/Delegation/IOperatorDelegator.sol#L2


## costly-loop
Impact: Informational
Confidence: Medium
 - [ ] ID-15
[RestakeManager.removeCollateralToken(IERC20)](contracts/RestakeManager.sol#L263-L285) has costly operations inside a loop:
	- [collateralTokens.pop()](contracts/RestakeManager.sol#L276)

contracts/RestakeManager.sol#L263-L285


 - [ ] ID-16
[RestakeManager.removeOperatorDelegator(IOperatorDelegator)](contracts/RestakeManager.sol#L170-L200) has costly operations inside a loop:
	- [operatorDelegators.pop()](contracts/RestakeManager.sol#L191)

contracts/RestakeManager.sol#L170-L200


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-17
[BeaconChainProofs.verifyWithdrawalProofs(bytes32,BeaconChainProofs.WithdrawalProofs,bytes32[])](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L206-L261) is never used and should be removed

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L206-L261


 - [ ] ID-18
[Initializable._isInitializing()](@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L163-L165) is never used and should be removed

@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L163-L165


 - [ ] ID-19
[Address.verifyCallResult(bool,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L219-L229) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L219-L229


 - [ ] ID-20
[AddressUpgradeable.functionCallWithValue(address,bytes,uint256)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L118-L120) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L118-L120


 - [ ] ID-21
[Merkle.processInclusionProofKeccak(bytes,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L48-L71) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L48-L71


 - [ ] ID-22
[SafeERC20Upgradeable._callOptionalReturnBool(IERC20Upgradeable,bytes)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L134-L142) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L134-L142


 - [ ] ID-23
[SafeERC20Upgradeable.safeApprove(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L45-L54) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L45-L54


 - [ ] ID-24
[Address.sendValue(address,uint256)](@openzeppelin/contracts/utils/Address.sol#L64-L69) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L64-L69


 - [ ] ID-25
[Address.functionCallWithValue(address,bytes,uint256)](@openzeppelin/contracts/utils/Address.sol#L118-L120) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L118-L120


 - [ ] ID-26
[SafeERC20Upgradeable.safeIncreaseAllowance(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L60-L63) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L60-L63


 - [ ] ID-27
[BeaconChainProofs.getBalanceFromBalanceRoot(uint40,bytes32)](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L139-L144) is never used and should be removed

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L139-L144


 - [ ] ID-28
[Address.functionDelegateCall(address,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L180-L187) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L180-L187


 - [ ] ID-29
[SafeERC20.safeTransfer(IERC20,address,uint256)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L26-L28) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L26-L28


 - [ ] ID-30
[AddressUpgradeable.functionCall(address,bytes)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L89-L91) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L89-L91


 - [ ] ID-31
[Merkle.verifyInclusionKeccak(bytes,bytes32,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L29-L36) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L29-L36


 - [ ] ID-32
[SafeERC20Upgradeable.safeTransferFrom(IERC20Upgradeable,address,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L34-L36) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L34-L36


 - [ ] ID-33
[Address.functionDelegateCall(address,bytes)](@openzeppelin/contracts/utils/Address.sol#L170-L172) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L170-L172


 - [ ] ID-34
[SafeERC20.safeIncreaseAllowance(IERC20,address,uint256)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L60-L63) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L60-L63


 - [ ] ID-35
[AddressUpgradeable.functionCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L99-L105) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L99-L105


 - [ ] ID-36
[SafeERC20.safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L95-L109) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L95-L109


 - [ ] ID-37
[AddressUpgradeable.sendValue(address,uint256)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L64-L69) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L64-L69


 - [ ] ID-38
[SafeERC20Upgradeable.forceApprove(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L82-L89) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L82-L89


 - [ ] ID-39
[BeaconChainProofs.verifyValidatorBalance(uint40,bytes32,bytes,bytes32)](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L182-L198) is never used and should be removed

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L182-L198


 - [ ] ID-40
[ReentrancyGuardUpgradeable._reentrancyGuardEntered()](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L79-L81) is never used and should be removed

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L79-L81


 - [ ] ID-41
[AddressUpgradeable.functionStaticCall(address,bytes)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L145-L147) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L145-L147


 - [ ] ID-42
[SafeERC20Upgradeable.safeDecreaseAllowance(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L69-L75) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L69-L75


 - [ ] ID-43
[Address.functionStaticCall(address,bytes)](@openzeppelin/contracts/utils/Address.sol#L145-L147) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L145-L147


 - [ ] ID-44
[SafeERC20Upgradeable.safePermit(IERC20PermitUpgradeable,address,address,uint256,uint256,uint8,bytes32,bytes32)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L95-L109) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L95-L109


 - [ ] ID-45
[Endian.fromLittleEndianUint64(bytes32)](contracts/EigenLayer/libraries/Endian.sol#L12-L26) is never used and should be removed

contracts/EigenLayer/libraries/Endian.sol#L12-L26


 - [ ] ID-46
[SafeERC20Upgradeable._callOptionalReturn(IERC20Upgradeable,bytes)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L117-L124) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L117-L124


 - [ ] ID-47
[Merkle.verifyInclusionSha256(bytes,bytes32,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L81-L88) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L81-L88


 - [ ] ID-48
[AddressUpgradeable.verifyCallResult(bool,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L219-L229) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L219-L229


 - [ ] ID-49
[SafeERC20._callOptionalReturnBool(IERC20,bytes)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L134-L142) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L134-L142


 - [ ] ID-50
[AddressUpgradeable._revert(bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L231-L243) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L231-L243


 - [ ] ID-51
[Initializable._getInitializedVersion()](@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L156-L158) is never used and should be removed

@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L156-L158


 - [ ] ID-52
[AddressUpgradeable.functionDelegateCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L180-L187) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L180-L187


 - [ ] ID-53
[SafeERC20.forceApprove(IERC20,address,uint256)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L82-L89) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L82-L89


 - [ ] ID-54
[SafeERC20.safeDecreaseAllowance(IERC20,address,uint256)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L69-L75) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L69-L75


 - [ ] ID-55
[AddressUpgradeable.functionStaticCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L155-L162) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L155-L162


 - [ ] ID-56
[SafeERC20Upgradeable.safeTransfer(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L26-L28) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L26-L28


 - [ ] ID-57
[Merkle.merkleizeSha256(bytes32[])](contracts/EigenLayer/libraries/Merkle.sol#L131-L155) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L131-L155


 - [ ] ID-58
[AddressUpgradeable.functionDelegateCall(address,bytes)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L170-L172) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L170-L172


 - [ ] ID-59
[Merkle.processInclusionProofSha256(bytes,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L100-L123) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L100-L123


 - [ ] ID-60
[Address.functionStaticCall(address,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L155-L162) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L155-L162


 - [ ] ID-61
[BeaconChainProofs.verifyValidatorFields(uint40,bytes32,bytes,bytes32[])](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L153-L173) is never used and should be removed

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L153-L173


 - [ ] ID-62
[AddressUpgradeable.verifyCallResultFromTarget(address,bool,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L195-L211) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L195-L211


 - [ ] ID-63
[AddressUpgradeable.functionCallWithValue(address,bytes,uint256,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L128-L137) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L128-L137


 - [ ] ID-64
[Address.functionCall(address,bytes)](@openzeppelin/contracts/utils/Address.sol#L89-L91) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L89-L91


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-65
Pragma version[0.8.19](contracts/Lock.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Lock.sol#L2


 - [ ] ID-66
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L4


 - [ ] ID-67
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#L4


 - [ ] ID-68
Pragma version[^0.8.9](contracts/token/IEzEthToken.sol#L2) allows old versions

contracts/token/IEzEthToken.sol#L2


 - [ ] ID-69
Pragma version[^0.8.2](@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L4


 - [ ] ID-70
Pragma version[0.8.19](contracts/Delegation/IOperatorDelegator.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Delegation/IOperatorDelegator.sol#L2


 - [ ] ID-71
Pragma version[0.8.19](contracts/Errors/Errors.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Errors/Errors.sol#L2


 - [ ] ID-72
Pragma version[^0.8.0](@openzeppelin/contracts/token/ERC20/IERC20.sol#L4) allows old versions

@openzeppelin/contracts/token/ERC20/IERC20.sol#L4


 - [ ] ID-73
Pragma version[^0.8.0](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L4) allows old versions

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L4


 - [ ] ID-74
Pragma version[0.8.19](contracts/Oracle/IRenzoOracle.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Oracle/IRenzoOracle.sol#L2


 - [ ] ID-75
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IStrategy.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IStrategy.sol#L2


 - [ ] ID-76
Pragma version[=0.8.19](contracts/EigenLayer/libraries/Endian.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/libraries/Endian.sol#L2


 - [ ] ID-77
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IEigenPod.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IEigenPod.sol#L2


 - [ ] ID-78
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IPausable.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IPausable.sol#L2


 - [ ] ID-79
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IStrategyManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IStrategyManager.sol#L2


 - [ ] ID-80
Pragma version[^0.8.0](@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4) allows old versions

@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4


 - [ ] ID-81
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IEigenPodManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IEigenPodManager.sol#L2


 - [ ] ID-82
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IPauserRegistry.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IPauserRegistry.sol#L2


 - [ ] ID-83
Pragma version[^0.8.1](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L4


 - [ ] ID-84
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L4


 - [ ] ID-85
Pragma version[^0.8.1](@openzeppelin/contracts/utils/Address.sol#L4) allows old versions

@openzeppelin/contracts/utils/Address.sol#L4


 - [ ] ID-86
Pragma version[^0.8.0](@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L4) allows old versions

@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L4


 - [ ] ID-87
Pragma version[=0.8.19](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L3


 - [ ] ID-88
Pragma version[0.8.19](contracts/Permissions/IRoleManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Permissions/IRoleManager.sol#L2


 - [ ] ID-89
Pragma version[0.8.19](contracts/RestakeManagerStorage.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/RestakeManagerStorage.sol#L2


 - [ ] ID-90
Pragma version[0.8.19](contracts/IRestakeManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/IRestakeManager.sol#L2


 - [ ] ID-91
solc-0.8.19 is not recommended for deployment

 - [ ] ID-92
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/ISlasher.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/ISlasher.sol#L2


 - [ ] ID-93
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IDelayedWithdrawalRouter.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IDelayedWithdrawalRouter.sol#L2


 - [ ] ID-94
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IDelegationTerms.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IDelegationTerms.sol#L2


 - [ ] ID-95
Pragma version[0.8.19](contracts/Deposits/IDepositQueue.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Deposits/IDepositQueue.sol#L2


 - [ ] ID-96
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IBeaconChainOracle.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IBeaconChainOracle.sol#L2


 - [ ] ID-97
Pragma version[0.8.19](contracts/RestakeManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/RestakeManager.sol#L2


 - [ ] ID-98
Pragma version[=0.8.19](contracts/EigenLayer/libraries/Merkle.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/libraries/Merkle.sol#L4


 - [ ] ID-99
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L4


 - [ ] ID-100
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IDelegationManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IDelegationManager.sol#L2


## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-101
Low level call in [Address.functionStaticCall(address,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L155-L162):
	- [(success,returndata) = target.staticcall(data)](@openzeppelin/contracts/utils/Address.sol#L160)

@openzeppelin/contracts/utils/Address.sol#L155-L162


 - [ ] ID-102
Low level call in [Address.functionDelegateCall(address,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L180-L187):
	- [(success,returndata) = target.delegatecall(data)](@openzeppelin/contracts/utils/Address.sol#L185)

@openzeppelin/contracts/utils/Address.sol#L180-L187


 - [ ] ID-103
Low level call in [Address.sendValue(address,uint256)](@openzeppelin/contracts/utils/Address.sol#L64-L69):
	- [(success) = recipient.call{value: amount}()](@openzeppelin/contracts/utils/Address.sol#L67)

@openzeppelin/contracts/utils/Address.sol#L64-L69


 - [ ] ID-104
Low level call in [AddressUpgradeable.sendValue(address,uint256)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L64-L69):
	- [(success) = recipient.call{value: amount}()](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L67)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L64-L69


 - [ ] ID-105
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](@openzeppelin/contracts/utils/Address.sol#L128-L137):
	- [(success,returndata) = target.call{value: value}(data)](@openzeppelin/contracts/utils/Address.sol#L135)

@openzeppelin/contracts/utils/Address.sol#L128-L137


 - [ ] ID-106
Low level call in [AddressUpgradeable.functionDelegateCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L180-L187):
	- [(success,returndata) = target.delegatecall(data)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L185)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L180-L187


 - [ ] ID-107
Low level call in [SafeERC20Upgradeable._callOptionalReturnBool(IERC20Upgradeable,bytes)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L134-L142):
	- [(success,returndata) = address(token).call(data)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L139)

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L134-L142


 - [ ] ID-108
Low level call in [AddressUpgradeable.functionStaticCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L155-L162):
	- [(success,returndata) = target.staticcall(data)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L160)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L155-L162


 - [ ] ID-109
Low level call in [AddressUpgradeable.functionCallWithValue(address,bytes,uint256,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L128-L137):
	- [(success,returndata) = target.call{value: value}(data)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L135)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L128-L137


 - [ ] ID-110
Low level call in [SafeERC20._callOptionalReturnBool(IERC20,bytes)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L134-L142):
	- [(success,returndata) = address(token).call(data)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L139)

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L134-L142


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-111
Parameter [RestakeManager.deposit(IERC20,uint256,uint256)._amount](contracts/RestakeManager.sol#L496) is not in mixedCase

contracts/RestakeManager.sol#L496


 - [ ] ID-112
Parameter [RestakeManager.depositETH(uint256)._referralId](contracts/RestakeManager.sol#L587) is not in mixedCase

contracts/RestakeManager.sol#L587


 - [ ] ID-113
Function [IERC20PermitUpgradeable.DOMAIN_SEPARATOR()](@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L59) is not in mixedCase

@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L59


 - [ ] ID-114
Parameter [RestakeManager.addOperatorDelegator(IOperatorDelegator,uint256)._newOperatorDelegator](contracts/RestakeManager.sol#L140) is not in mixedCase

contracts/RestakeManager.sol#L140


 - [ ] ID-115
Enum [IEigenPod.PARTIAL_WITHDRAWAL_CLAIM_STATUS](contracts/EigenLayer/interfaces/IEigenPod.sol#L46-L50) is not in CapWords

contracts/EigenLayer/interfaces/IEigenPod.sol#L46-L50


 - [ ] ID-116
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._renzoOracle](contracts/RestakeManager.sol#L111) is not in mixedCase

contracts/RestakeManager.sol#L111


 - [ ] ID-117
Parameter [RestakeManager.setMaxDepositTVL(uint256)._maxDepositTVL](contracts/RestakeManager.sol#L238) is not in mixedCase

contracts/RestakeManager.sol#L238


 - [ ] ID-118
Parameter [RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)._amount](contracts/RestakeManager.sol#L641) is not in mixedCase

contracts/RestakeManager.sol#L641


 - [ ] ID-119
Parameter [RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)._token](contracts/RestakeManager.sol#L640) is not in mixedCase

contracts/RestakeManager.sol#L640


 - [ ] ID-120
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._ezETH](contracts/RestakeManager.sol#L110) is not in mixedCase

contracts/RestakeManager.sol#L110


 - [ ] ID-121
Function [IEigenPod.REQUIRED_BALANCE_WEI()](contracts/EigenLayer/interfaces/IEigenPod.sol#L56) is not in mixedCase

contracts/EigenLayer/interfaces/IEigenPod.sol#L56


 - [ ] ID-122
Parameter [RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._allocationBasisPoints](contracts/RestakeManager.sol#L205) is not in mixedCase

contracts/RestakeManager.sol#L205


 - [ ] ID-123
Function [ReentrancyGuardUpgradeable.__ReentrancyGuard_init_unchained()](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L44-L46) is not in mixedCase

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L44-L46


 - [ ] ID-124
Parameter [RestakeManager.setTokenTvlLimit(IERC20,uint256)._token](contracts/RestakeManager.sol#L706) is not in mixedCase

contracts/RestakeManager.sol#L706


 - [ ] ID-125
Parameter [RestakeManager.getCollateralTokenIndex(IERC20)._collateralToken](contracts/RestakeManager.sol#L452) is not in mixedCase

contracts/RestakeManager.sol#L452


 - [ ] ID-126
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._depositQueue](contracts/RestakeManager.sol#L114) is not in mixedCase

contracts/RestakeManager.sol#L114


 - [ ] ID-127
Parameter [RestakeManager.deposit(IERC20,uint256)._amount](contracts/RestakeManager.sol#L475) is not in mixedCase

contracts/RestakeManager.sol#L475


 - [ ] ID-128
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._roleManager](contracts/RestakeManager.sol#L109) is not in mixedCase

contracts/RestakeManager.sol#L109


 - [ ] ID-129
Parameter [RestakeManager.setPaused(bool)._paused](contracts/RestakeManager.sol#L129) is not in mixedCase

contracts/RestakeManager.sol#L129


 - [ ] ID-130
Parameter [RestakeManager.deposit(IERC20,uint256)._collateralToken](contracts/RestakeManager.sol#L474) is not in mixedCase

contracts/RestakeManager.sol#L474


 - [ ] ID-131
Function [ReentrancyGuardUpgradeable.__ReentrancyGuard_init()](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L40-L42) is not in mixedCase

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L40-L42


 - [ ] ID-132
Parameter [RestakeManager.removeCollateralToken(IERC20)._collateralTokenToRemove](contracts/RestakeManager.sol#L264) is not in mixedCase

contracts/RestakeManager.sol#L264


 - [ ] ID-133
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._strategyManager](contracts/RestakeManager.sol#L112) is not in mixedCase

contracts/RestakeManager.sol#L112


 - [ ] ID-134
Variable [ReentrancyGuardUpgradeable.__gap](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L88) is not in mixedCase

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L88


 - [ ] ID-135
Function [IERC20Permit.DOMAIN_SEPARATOR()](@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L59) is not in mixedCase

@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L59


 - [ ] ID-136
Function [IEigenPod.REQUIRED_BALANCE_GWEI()](contracts/EigenLayer/interfaces/IEigenPod.sol#L53) is not in mixedCase

contracts/EigenLayer/interfaces/IEigenPod.sol#L53


 - [ ] ID-137
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._delegationManager](contracts/RestakeManager.sol#L113) is not in mixedCase

contracts/RestakeManager.sol#L113


 - [ ] ID-138
Parameter [RestakeManager.deposit(IERC20,uint256,uint256)._referralId](contracts/RestakeManager.sol#L497) is not in mixedCase

contracts/RestakeManager.sol#L497


 - [ ] ID-139
Enum [IEigenPod.VALIDATOR_STATUS](contracts/EigenLayer/interfaces/IEigenPod.sol#L28-L33) is not in CapWords

contracts/EigenLayer/interfaces/IEigenPod.sol#L28-L33


 - [ ] ID-140
Parameter [RestakeManager.setTokenTvlLimit(IERC20,uint256)._limit](contracts/RestakeManager.sol#L706) is not in mixedCase

contracts/RestakeManager.sol#L706


 - [ ] ID-141
Parameter [RestakeManager.removeOperatorDelegator(IOperatorDelegator)._operatorDelegatorToRemove](contracts/RestakeManager.sol#L171) is not in mixedCase

contracts/RestakeManager.sol#L171


 - [ ] ID-142
Parameter [RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._operatorDelegator](contracts/RestakeManager.sol#L204) is not in mixedCase

contracts/RestakeManager.sol#L204


 - [ ] ID-143
Parameter [RestakeManager.deposit(IERC20,uint256,uint256)._collateralToken](contracts/RestakeManager.sol#L495) is not in mixedCase

contracts/RestakeManager.sol#L495


 - [ ] ID-144
Parameter [RestakeManager.addOperatorDelegator(IOperatorDelegator,uint256)._allocationBasisPoints](contracts/RestakeManager.sol#L141) is not in mixedCase

contracts/RestakeManager.sol#L141


 - [ ] ID-145
Parameter [RestakeManager.addCollateralToken(IERC20)._newCollateralToken](contracts/RestakeManager.sol#L244) is not in mixedCase

contracts/RestakeManager.sol#L244


## similar-names
Impact: Informational
Confidence: Medium
 - [ ] ID-146
Variable [RestakeManager.getCollateralTokenIndex(IERC20)._collateralToken](contracts/RestakeManager.sol#L452) is too similar to [RestakeManagerStorageV1.collateralTokens](contracts/RestakeManagerStorage.sol#L48)

contracts/RestakeManager.sol#L452


 - [ ] ID-147
Variable [RestakeManager.deposit(IERC20,uint256,uint256)._collateralToken](contracts/RestakeManager.sol#L495) is too similar to [RestakeManagerStorageV1.collateralTokens](contracts/RestakeManagerStorage.sol#L48)

contracts/RestakeManager.sol#L495


 - [ ] ID-148
Variable [RestakeManager.deposit(IERC20,uint256)._collateralToken](contracts/RestakeManager.sol#L474) is too similar to [RestakeManagerStorageV1.collateralTokens](contracts/RestakeManagerStorage.sol#L48)

contracts/RestakeManager.sol#L474


 - [ ] ID-149
Variable [RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._operatorDelegator](contracts/RestakeManager.sol#L204) is too similar to [RestakeManagerStorageV1.operatorDelegators](contracts/RestakeManagerStorage.sol#L41)

contracts/RestakeManager.sol#L204


## too-many-digits
Impact: Informational
Confidence: Medium
 - [ ] ID-150
[Endian.fromLittleEndianUint64(bytes32)](contracts/EigenLayer/libraries/Endian.sol#L12-L26) uses literals with too many digits:
	- [(n >> 56) | ((0x00FF000000000000 & n) >> 40) | ((0x0000FF0000000000 & n) >> 24) | ((0x000000FF00000000 & n) >> 8) | ((0x00000000FF000000 & n) << 8) | ((0x0000000000FF0000 & n) << 24) | ((0x000000000000FF00 & n) << 40) | ((0x00000000000000FF & n) << 56)](contracts/EigenLayer/libraries/Endian.sol#L17-L25)

contracts/EigenLayer/libraries/Endian.sol#L12-L26


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-151
[BeaconChainProofs.VALIDATOR_WITHDRAWAL_CREDENTIALS_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L78) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L78


 - [ ] ID-152
[BeaconChainProofs.NUM_BEACON_BLOCK_BODY_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L17) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

INFO:Slither:. analyzed (35 contracts with 88 detectors), 183 result(s) found
contracts/EigenLayer/libraries/BeaconChainProofs.sol#L17


 - [ ] ID-153
[BeaconChainProofs.ETH_1_ROOT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L71) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L71


 - [ ] ID-154
[BeaconChainProofs.STATE_ROOTS_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L44) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L44


 - [ ] ID-155
[BeaconChainProofs.WITHDRAWALS_ROOT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L85) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L85


 - [ ] ID-156
[BeaconChainProofs.EXECUTION_PAYLOAD_FIELD_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L34) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L34


 - [ ] ID-157
[BeaconChainProofs.PROPOSER_INDEX_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L64) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L64


 - [ ] ID-158
[BeaconChainProofs.WITHDRAWAL_VALIDATOR_AMOUNT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L92) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L92


 - [ ] ID-159
[BeaconChainProofs.VALIDATOR_BALANCE_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L79) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L79


 - [ ] ID-160
[BeaconChainProofs.EXECUTION_PAYLOAD_HEADER_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L74) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L74


 - [ ] ID-161
[BeaconChainProofs.VALIDATOR_WITHDRAWABLE_EPOCH_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L81) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L81


 - [ ] ID-162
[BeaconChainProofs.STATE_ROOT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L63) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L63


 - [ ] ID-163
[BeaconChainProofs.NUM_VALIDATOR_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L26) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L26


 - [ ] ID-164
[BeaconChainProofs.NUM_WITHDRAWAL_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L48) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L48


 - [ ] ID-165
[BeaconChainProofs.HISTORICALBATCH_STATEROOTS_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L95) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L95


 - [ ] ID-166
[BeaconChainProofs.UINT64_MASK](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L100) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L100


 - [ ] ID-167
[BeaconChainProofs.VALIDATOR_SLASHED_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L80) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L80


 - [ ] ID-168
[BeaconChainProofs.HISTORICAL_BATCH_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L41) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L41


 - [ ] ID-169
[BeaconChainProofs.HISTORICAL_BATCH_STATE_ROOT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L75) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L75


 - [ ] ID-170
[BeaconChainProofs.HISTORICAL_ROOTS_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L70) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L70


 - [ ] ID-171
[BeaconChainProofs.WITHDRAWAL_VALIDATOR_INDEX_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L91) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L91


 - [ ] ID-172
[BeaconChainProofs.STATE_ROOTS_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L68) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L68


 - [ ] ID-173
[BeaconChainProofs.HISTORICAL_ROOTS_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L38) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L38


 - [ ] ID-174
[BeaconChainProofs.SLOTS_PER_EPOCH](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L98) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L98


 - [ ] ID-175
[BeaconChainProofs.ETH1_DATA_FIELD_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L24) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L24


 - [ ] ID-176
[BeaconChainProofs.NUM_BEACON_BLOCK_HEADER_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L14) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L14


 - [ ] ID-177
[BeaconChainProofs.NUM_ETH1_DATA_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L23) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L23


 - [ ] ID-178
[BeaconChainProofs.NUM_EXECUTION_PAYLOAD_HEADER_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L29) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L29


 - [ ] ID-179
[BeaconChainProofs.NUM_EXECUTION_PAYLOAD_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L33) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L33


 - [ ] ID-180
[BeaconChainProofs.NUM_BEACON_STATE_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L20) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L20


## immutable-states
Impact: Optimization
Confidence: High
 - [ ] ID-181
[Lock.unlockTime](contracts/Lock.sol#L8) should be immutable 

contracts/Lock.sol#L8


 - [ ] ID-182
[Lock.owner](contracts/Lock.sol#L9) should be immutable 

contracts/Lock.sol#L9


