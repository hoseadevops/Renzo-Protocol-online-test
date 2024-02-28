'npx hardhat clean' running (wd: /Users/hosea/work/audit/evaluate/Renzo-Protocol-online)
'npx hardhat clean --global' running (wd: /Users/hosea/work/audit/evaluate/Renzo-Protocol-online)
'npx hardhat compile --force' running (wd: /Users/hosea/work/audit/evaluate/Renzo-Protocol-online)
INFO:Detectors:
DepositQueue.stakeEthFromQueue(IOperatorDelegator,bytes,bytes,bytes32) (contracts/Deposits/DepositQueue.sol#154-161) sends eth to arbitrary user
	Dangerous calls:
	- restakeManager.stakeEthInOperatorDelegator{value: 32000000000000000000}(operatorDelegator,pubkey,signature,depositDataRoot) (contracts/Deposits/DepositQueue.sol#158)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#functions-that-send-ether-to-arbitrary-destinations
INFO:Detectors:
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) performs a multiplication on the result of a division:
	- denominator = denominator / twos (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#101)
	- inverse = (3 * denominator) ^ 2 (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#116)
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) performs a multiplication on the result of a division:
	- denominator = denominator / twos (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#101)
	- inverse *= 2 - denominator * inverse (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#120)
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) performs a multiplication on the result of a division:
	- denominator = denominator / twos (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#101)
	- inverse *= 2 - denominator * inverse (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#121)
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) performs a multiplication on the result of a division:
	- denominator = denominator / twos (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#101)
	- inverse *= 2 - denominator * inverse (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#122)
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) performs a multiplication on the result of a division:
	- denominator = denominator / twos (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#101)
	- inverse *= 2 - denominator * inverse (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#123)
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) performs a multiplication on the result of a division:
	- denominator = denominator / twos (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#101)
	- inverse *= 2 - denominator * inverse (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#124)
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) performs a multiplication on the result of a division:
	- denominator = denominator / twos (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#101)
	- inverse *= 2 - denominator * inverse (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#125)
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) performs a multiplication on the result of a division:
	- prod0 = prod0 / twos (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#104)
	- result = prod0 * inverse (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#131)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#divide-before-multiply
INFO:Detectors:
Contract locking ether found:
	Contract EigenPodManager (contracts/Mock/EigenPodManager.sol#183-184) has payable functions:
	 - baseEigenPodManager.stake(bytes,bytes,bytes32) (contracts/Mock/EigenPodManager.sol#32-35)
	But does not have a function to withdraw the ether
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#contracts-that-lock-ether
INFO:Detectors:
DepositQueue.sweepERC20(IERC20) (contracts/Deposits/DepositQueue.sol#166-192) ignores return value by token.approve(address(restakeManager),balance - feeAmount) (contracts/Deposits/DepositQueue.sol#182)
RenzoOracle.lookupTokenValue(IERC20,uint256) (contracts/Oracle/RenzoOracle.sol#73-93) ignores return value by (price,timestamp) = oracle.latestRoundData() (contracts/Oracle/RenzoOracle.sol#85)
RenzoOracle.lookupTokenAmountFromValue(IERC20,uint256) (contracts/Oracle/RenzoOracle.sol#97-107) ignores return value by (price,timestamp) = oracle.latestRoundData() (contracts/Oracle/RenzoOracle.sol#101)
RestakeManager.deposit(IERC20,uint256,uint256) (contracts/RestakeManager.sol#543-625) ignores return value by operatorDelegator.deposit(_collateralToken,_amount) (contracts/RestakeManager.sol#611)
RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256) (contracts/RestakeManager.sol#694-724) ignores return value by operatorDelegator.deposit(_token,_amount) (contracts/RestakeManager.sol#723)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unused-return
INFO:Detectors:
OperatorDelegator.stakeEth(bytes,bytes,bytes32) (contracts/Delegation/OperatorDelegator.sol#257-263) should emit an event for: 
	- stakedButNotVerifiedEth += msg.value (contracts/Delegation/OperatorDelegator.sol#262) 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-events-arithmetic
INFO:Detectors:
OperatorDelegator.getStrategyIndex(IStrategy) (contracts/Delegation/OperatorDelegator.sol#149-161) has external calls inside a loop: strategyManager.stakerStrategyList(address(this),i) == _strategy (contracts/Delegation/OperatorDelegator.sol#154)
RenzoOracle.lookupTokenValue(IERC20,uint256) (contracts/Oracle/RenzoOracle.sol#73-93) has external calls inside a loop: (price,timestamp) = oracle.latestRoundData() (contracts/Oracle/RenzoOracle.sol#85)
RestakeManager.calculateTVLs() (contracts/RestakeManager.sol#336-406) has external calls inside a loop: operatorBalance = operatorDelegators[i].getTokenBalanceFromStrategy(collateralTokens[j]) (contracts/RestakeManager.sol#368-369)
RestakeManager.calculateTVLs() (contracts/RestakeManager.sol#336-406) has external calls inside a loop: operatorValues[j] = renzoOracle.lookupTokenValue(collateralTokens[j],operatorBalance) (contracts/RestakeManager.sol#373-376)
RestakeManager.calculateTVLs() (contracts/RestakeManager.sol#336-406) has external calls inside a loop: operatorEthBalance = operatorDelegators[i].getStakedETHBalance() (contracts/RestakeManager.sol#385)
RestakeManager.getTotalRewardsEarned() (contracts/RestakeManager.sol#731-759) has external calls inside a loop: tokenRewardAmount = depositQueue.totalEarned(address(collateralTokens[i])) (contracts/RestakeManager.sol#741)
RestakeManager.getTotalRewardsEarned() (contracts/RestakeManager.sol#731-759) has external calls inside a loop: totalRewards += renzoOracle.lookupTokenValue(collateralTokens[i],tokenRewardAmount) (contracts/RestakeManager.sol#744)
RestakeManager.getTotalRewardsEarned() (contracts/RestakeManager.sol#731-759) has external calls inside a loop: totalRewards += address(operatorDelegators[i_scope_0].eigenPod()).balance + operatorDelegators[i_scope_0].pendingUnstakedDelayedWithdrawalAmount() (contracts/RestakeManager.sol#754)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation/#calls-inside-a-loop
INFO:Detectors:
Reentrancy in OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager) (contracts/Delegation/OperatorDelegator.sol#65-91):
	External calls:
	- eigenPodManager.createPod() (contracts/Delegation/OperatorDelegator.sol#87)
	State variables written after the call(s):
	- eigenPod = IEigenPod(eigenPodManager.ownerToPod(address(this))) (contracts/Delegation/OperatorDelegator.sol#90)
Reentrancy in OperatorDelegator.receive() (contracts/Delegation/OperatorDelegator.sol#316-335):
	External calls:
	- msg.sender == address(eigenPod.delayedWithdrawalRouter()) (contracts/Delegation/OperatorDelegator.sol#320)
	State variables written after the call(s):
	- pendingUnstakedDelayedWithdrawalAmount -= msg.value (contracts/Delegation/OperatorDelegator.sol#323)
	- pendingUnstakedDelayedWithdrawalAmount = 0 (contracts/Delegation/OperatorDelegator.sol#326)
Reentrancy in DepositQueue.receive() (contracts/Deposits/DepositQueue.sol#130-148):
	External calls:
	- (success) = feeAddress.call{value: feeAmount}() (contracts/Deposits/DepositQueue.sol#136)
	State variables written after the call(s):
	- totalEarned[address(0x0)] = totalEarned[address(0x0)] + msg.value - feeAmount (contracts/Deposits/DepositQueue.sol#144)
Reentrancy in OperatorDelegator.stakeEth(bytes,bytes,bytes32) (contracts/Delegation/OperatorDelegator.sol#257-263):
	External calls:
	- eigenPodManager.stake{value: msg.value}(pubkey,signature,depositDataRoot) (contracts/Delegation/OperatorDelegator.sol#259)
	State variables written after the call(s):
	- stakedButNotVerifiedEth += msg.value (contracts/Delegation/OperatorDelegator.sol#262)
Reentrancy in OperatorDelegator.startDelayedWithdrawUnstakedETH() (contracts/Delegation/OperatorDelegator.sol#294-305):
	External calls:
	- eigenPod.withdrawBeforeRestaking() (contracts/Delegation/OperatorDelegator.sol#301)
	State variables written after the call(s):
	- pendingUnstakedDelayedWithdrawalAmount += (beforeEigenPodBalance - address(eigenPod).balance) (contracts/Delegation/OperatorDelegator.sol#304)
Reentrancy in DepositQueue.sweepERC20(IERC20) (contracts/Deposits/DepositQueue.sol#166-192):
	External calls:
	- IERC20(token).safeTransfer(feeAddress,feeAmount) (contracts/Deposits/DepositQueue.sol#175)
	- token.approve(address(restakeManager),balance - feeAmount) (contracts/Deposits/DepositQueue.sol#182)
	- restakeManager.depositTokenRewardsFromProtocol(token,balance - feeAmount) (contracts/Deposits/DepositQueue.sol#183)
	State variables written after the call(s):
	- totalEarned[address(token)] = totalEarned[address(token)] + balance - feeAmount (contracts/Deposits/DepositQueue.sol#187)
Reentrancy in OperatorDelegator.verifyWithdrawalCredentials(uint64,uint40,BeaconChainProofs.ValidatorFieldsAndBalanceProofs,bytes32[]) (contracts/Delegation/OperatorDelegator.sol#271-287):
	External calls:
	- eigenPod.verifyWithdrawalCredentialsAndBalance(oracleBlockNumber,validatorIndex,proofs,validatorFields) (contracts/Delegation/OperatorDelegator.sol#277-282)
	State variables written after the call(s):
	- stakedButNotVerifiedEth -= (validatorCurrentBalanceGwei * GWEI_TO_WEI) (contracts/Delegation/OperatorDelegator.sol#286)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-2
INFO:Detectors:
Reentrancy in DepositQueue.stakeEthFromQueue(IOperatorDelegator,bytes,bytes,bytes32) (contracts/Deposits/DepositQueue.sol#154-161):
	External calls:
	- restakeManager.stakeEthInOperatorDelegator{value: 32000000000000000000}(operatorDelegator,pubkey,signature,depositDataRoot) (contracts/Deposits/DepositQueue.sol#158)
	Event emitted after the call(s):
	- ETHStakedFromQueue(operatorDelegator,pubkey,32000000000000000000,address(this).balance) (contracts/Deposits/DepositQueue.sol#160)
Reentrancy in DepositQueue.sweepERC20(IERC20) (contracts/Deposits/DepositQueue.sol#166-192):
	External calls:
	- IERC20(token).safeTransfer(feeAddress,feeAmount) (contracts/Deposits/DepositQueue.sol#175)
	Event emitted after the call(s):
	- ProtocolFeesPaid(token,feeAmount,feeAddress) (contracts/Deposits/DepositQueue.sol#177)
Reentrancy in DepositQueue.sweepERC20(IERC20) (contracts/Deposits/DepositQueue.sol#166-192):
	External calls:
	- IERC20(token).safeTransfer(feeAddress,feeAmount) (contracts/Deposits/DepositQueue.sol#175)
	- token.approve(address(restakeManager),balance - feeAmount) (contracts/Deposits/DepositQueue.sol#182)
	- restakeManager.depositTokenRewardsFromProtocol(token,balance - feeAmount) (contracts/Deposits/DepositQueue.sol#183)
	Event emitted after the call(s):
	- RewardsDeposited(IERC20(address(token)),balance - feeAmount) (contracts/Deposits/DepositQueue.sol#190)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-3
INFO:Detectors:
Lock.constructor(uint256) (contracts/Lock.sol#13-21) uses timestamp for comparisons
	Dangerous comparisons:
	- require(bool,string)(block.timestamp < _unlockTime,Unlock time should be in the future) (contracts/Lock.sol#14-17)
Lock.withdraw() (contracts/Lock.sol#23-33) uses timestamp for comparisons
	Dangerous comparisons:
	- require(bool,string)(block.timestamp >= unlockTime,You can't withdraw yet) (contracts/Lock.sol#27)
RenzoOracle.lookupTokenValue(IERC20,uint256) (contracts/Oracle/RenzoOracle.sol#73-93) uses timestamp for comparisons
	Dangerous comparisons:
	- timestamp < block.timestamp - MAX_TIME_WINDOW (contracts/Oracle/RenzoOracle.sol#87)
RenzoOracle.lookupTokenAmountFromValue(IERC20,uint256) (contracts/Oracle/RenzoOracle.sol#97-107) uses timestamp for comparisons
	Dangerous comparisons:
	- timestamp < block.timestamp - MAX_TIME_WINDOW (contracts/Oracle/RenzoOracle.sol#102)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#block-timestamp
INFO:Detectors:
AddressUpgradeable._revert(bytes,string) (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#231-243) uses assembly
	- INLINE ASM (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#236-239)
StringsUpgradeable.toString(uint256) (@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#19-39) uses assembly
	- INLINE ASM (@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#25-27)
	- INLINE ASM (@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#31-33)
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) uses assembly
	- INLINE ASM (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#62-66)
	- INLINE ASM (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#85-92)
	- INLINE ASM (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#99-108)
Address._revert(bytes,string) (@openzeppelin/contracts/utils/Address.sol#231-243) uses assembly
	- INLINE ASM (@openzeppelin/contracts/utils/Address.sol#236-239)
Merkle.processInclusionProofKeccak(bytes,bytes32,uint256) (contracts/EigenLayer/libraries/Merkle.sol#48-71) uses assembly
	- INLINE ASM (contracts/EigenLayer/libraries/Merkle.sol#54-59)
	- INLINE ASM (contracts/EigenLayer/libraries/Merkle.sol#62-67)
Merkle.processInclusionProofSha256(bytes,bytes32,uint256) (contracts/EigenLayer/libraries/Merkle.sol#100-123) uses assembly
	- INLINE ASM (contracts/EigenLayer/libraries/Merkle.sol#106-111)
	- INLINE ASM (contracts/EigenLayer/libraries/Merkle.sol#114-119)
console._sendLogPayloadImplementation(bytes) (node_modules/hardhat/console.sol#8-23) uses assembly
	- INLINE ASM (node_modules/hardhat/console.sol#11-22)
console._castToPure(function(bytes)) (node_modules/hardhat/console.sol#25-31) uses assembly
	- INLINE ASM (node_modules/hardhat/console.sol#28-30)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage
INFO:Detectors:
Different versions of Solidity are used:
	- Version used: ['0.8.19', '=0.8.19', '>=0.4.22<0.9.0', '^0.8.0', '^0.8.1', '^0.8.2', '^0.8.9']
	- 0.8.19 (contracts/Delegation/IOperatorDelegator.sol#2)
	- 0.8.19 (contracts/Delegation/OperatorDelegator.sol#2)
	- 0.8.19 (contracts/Delegation/OperatorDelegatorStorage.sol#2)
	- 0.8.19 (contracts/Deposits/DepositQueue.sol#2)
	- 0.8.19 (contracts/Deposits/DepositQueueStorage.sol#2)
	- 0.8.19 (contracts/Deposits/IDepositQueue.sol#2)
	- 0.8.19 (contracts/Errors/Errors.sol#2)
	- 0.8.19 (contracts/IRestakeManager.sol#2)
	- 0.8.19 (contracts/Lock.sol#2)
	- 0.8.19 (contracts/Mock/ERC20Faucet.sol#2)
	- 0.8.19 (contracts/Oracle/IRenzoOracle.sol#2)
	- 0.8.19 (contracts/Oracle/RenzoOracle.sol#2)
	- 0.8.19 (contracts/Oracle/RenzoOracleStorage.sol#2)
	- 0.8.19 (contracts/Permissions/IRoleManager.sol#2)
	- 0.8.19 (contracts/Permissions/RoleManager.sol#2)
	- 0.8.19 (contracts/Permissions/RoleManagerStorage.sol#2)
	- 0.8.19 (contracts/RestakeManager.sol#2)
	- 0.8.19 (contracts/RestakeManagerStorage.sol#2)
	- 0.8.19 (contracts/token/EzEthTokenStorage.sol#2)
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
	- =0.8.19 (contracts/Mock/DelegationManager.sol#2)
	- =0.8.19 (contracts/Mock/EigenPodManager.sol#2)
	- =0.8.19 (contracts/Mock/StrategyManager.sol#2)
	- >=0.4.22<0.9.0 (node_modules/hardhat/console.sol#2)
	- ^0.8.0 (@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#2)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/access/IAccessControlUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/utils/introspection/IERC165Upgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#4)
	- ^0.8.0 (@openzeppelin/contracts/token/ERC20/IERC20.sol#4)
	- ^0.8.0 (@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
	- ^0.8.0 (@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#4)
	- ^0.8.0 (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#4)
	- ^0.8.1 (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#4)
	- ^0.8.1 (@openzeppelin/contracts/utils/Address.sol#4)
	- ^0.8.2 (@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#4)
	- ^0.8.9 (contracts/token/EzEthToken.sol#2)
	- ^0.8.9 (contracts/token/IEzEthToken.sol#2)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
RestakeManager.removeOperatorDelegator(IOperatorDelegator) (contracts/RestakeManager.sol#190-221) has costly operations inside a loop:
	- operatorDelegators.pop() (contracts/RestakeManager.sol#212)
RestakeManager.removeCollateralToken(IERC20) (contracts/RestakeManager.sol#302-324) has costly operations inside a loop:
	- collateralTokens.pop() (contracts/RestakeManager.sol#315)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#costly-operations-inside-a-loop
INFO:Detectors:
AccessControlUpgradeable.__AccessControl_init_unchained() (@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#55-56) is never used and should be removed
AccessControlUpgradeable._setRoleAdmin(bytes32,bytes32) (@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#221-225) is never used and should be removed
AccessControlUpgradeable._setupRole(bytes32,address) (@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#212-214) is never used and should be removed
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
BeaconChainProofs.verifyValidatorBalance(uint40,bytes32,bytes,bytes32) (contracts/EigenLayer/libraries/BeaconChainProofs.sol#182-198) is never used and should be removed
BeaconChainProofs.verifyValidatorFields(uint40,bytes32,bytes,bytes32[]) (contracts/EigenLayer/libraries/BeaconChainProofs.sol#153-173) is never used and should be removed
BeaconChainProofs.verifyWithdrawalProofs(bytes32,BeaconChainProofs.WithdrawalProofs,bytes32[]) (contracts/EigenLayer/libraries/BeaconChainProofs.sol#206-261) is never used and should be removed
ContextUpgradeable.__Context_init() (@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#18-19) is never used and should be removed
ContextUpgradeable.__Context_init_unchained() (@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#21-22) is never used and should be removed
ContextUpgradeable._msgData() (@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#27-29) is never used and should be removed
ERC165Upgradeable.__ERC165_init() (@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#24-25) is never used and should be removed
ERC165Upgradeable.__ERC165_init_unchained() (@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#27-28) is never used and should be removed
Initializable._disableInitializers() (@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#145-151) is never used and should be removed
Initializable._getInitializedVersion() (@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#156-158) is never used and should be removed
Initializable._isInitializing() (@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#163-165) is never used and should be removed
MathUpgradeable.average(uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#34-37) is never used and should be removed
MathUpgradeable.ceilDiv(uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#45-48) is never used and should be removed
MathUpgradeable.log10(uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#252-284) is never used and should be removed
MathUpgradeable.log10(uint256,MathUpgradeable.Rounding) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#290-295) is never used and should be removed
MathUpgradeable.log2(uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#199-235) is never used and should be removed
MathUpgradeable.log2(uint256,MathUpgradeable.Rounding) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#241-246) is never used and should be removed
MathUpgradeable.log256(uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#303-327) is never used and should be removed
MathUpgradeable.log256(uint256,MathUpgradeable.Rounding) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#333-338) is never used and should be removed
MathUpgradeable.max(uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#19-21) is never used and should be removed
MathUpgradeable.min(uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#26-28) is never used and should be removed
MathUpgradeable.mulDiv(uint256,uint256,uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#55-134) is never used and should be removed
MathUpgradeable.mulDiv(uint256,uint256,uint256,MathUpgradeable.Rounding) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#139-145) is never used and should be removed
MathUpgradeable.sqrt(uint256) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#152-183) is never used and should be removed
MathUpgradeable.sqrt(uint256,MathUpgradeable.Rounding) (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#188-193) is never used and should be removed
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
SafeERC20Upgradeable._callOptionalReturn(IERC20Upgradeable,bytes) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#117-124) is never used and should be removed
SafeERC20Upgradeable._callOptionalReturnBool(IERC20Upgradeable,bytes) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#134-142) is never used and should be removed
SafeERC20Upgradeable.forceApprove(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#82-89) is never used and should be removed
SafeERC20Upgradeable.safeApprove(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#45-54) is never used and should be removed
SafeERC20Upgradeable.safeDecreaseAllowance(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#69-75) is never used and should be removed
SafeERC20Upgradeable.safeIncreaseAllowance(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#60-63) is never used and should be removed
SafeERC20Upgradeable.safePermit(IERC20PermitUpgradeable,address,address,uint256,uint256,uint8,bytes32,bytes32) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#95-109) is never used and should be removed
SafeERC20Upgradeable.safeTransfer(IERC20Upgradeable,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#26-28) is never used and should be removed
SafeERC20Upgradeable.safeTransferFrom(IERC20Upgradeable,address,address,uint256) (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#34-36) is never used and should be removed
SignedMathUpgradeable.abs(int256) (@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#37-42) is never used and should be removed
SignedMathUpgradeable.average(int256,int256) (@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#28-32) is never used and should be removed
SignedMathUpgradeable.max(int256,int256) (@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#13-15) is never used and should be removed
SignedMathUpgradeable.min(int256,int256) (@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#20-22) is never used and should be removed
StringsUpgradeable.equal(string,string) (@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#82-84) is never used and should be removed
StringsUpgradeable.toHexString(uint256) (@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#51-55) is never used and should be removed
StringsUpgradeable.toString(int256) (@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#44-46) is never used and should be removed
StringsUpgradeable.toString(uint256) (@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#19-39) is never used and should be removed
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dead-code
INFO:Detectors:
Pragma version^0.8.0 (@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#2) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/access/IAccessControlUpgradeable.sol#4) allows old versions
Pragma version^0.8.2 (@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#4) allows old versions
Pragma version^0.8.1 (@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/utils/introspection/IERC165Upgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts/token/ERC20/IERC20.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#4) allows old versions
Pragma version^0.8.0 (@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#4) allows old versions
Pragma version^0.8.1 (@openzeppelin/contracts/utils/Address.sol#4) allows old versions
Pragma version0.8.19 (contracts/Delegation/IOperatorDelegator.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Delegation/OperatorDelegator.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Delegation/OperatorDelegatorStorage.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Deposits/DepositQueue.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Deposits/DepositQueueStorage.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
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
Pragma version=0.8.19 (contracts/Mock/DelegationManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Mock/ERC20Faucet.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/Mock/EigenPodManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version=0.8.19 (contracts/Mock/StrategyManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Oracle/IRenzoOracle.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Oracle/RenzoOracle.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Oracle/RenzoOracleStorage.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Permissions/IRoleManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Permissions/RoleManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/Permissions/RoleManagerStorage.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/RestakeManager.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.19 (contracts/RestakeManagerStorage.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.9 (contracts/token/EzEthToken.sol#2) allows old versions
Pragma version0.8.19 (contracts/token/EzEthTokenStorage.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.9 (contracts/token/IEzEthToken.sol#2) allows old versions
Pragma version>=0.4.22<0.9.0 (node_modules/hardhat/console.sol#2) is too complex
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
Low level call in OperatorDelegator.receive() (contracts/Delegation/OperatorDelegator.sol#316-335):
	- (success) = destination.call{value: msg.value}() (contracts/Delegation/OperatorDelegator.sol#331)
Low level call in DepositQueue.receive() (contracts/Deposits/DepositQueue.sol#130-148):
	- (success) = feeAddress.call{value: feeAmount}() (contracts/Deposits/DepositQueue.sol#136)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#low-level-calls
INFO:Detectors:
Function AccessControlUpgradeable.__AccessControl_init() (@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#52-53) is not in mixedCase
Function AccessControlUpgradeable.__AccessControl_init_unchained() (@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#55-56) is not in mixedCase
Variable AccessControlUpgradeable.__gap (@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#260) is not in mixedCase
Function ReentrancyGuardUpgradeable.__ReentrancyGuard_init() (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#40-42) is not in mixedCase
Function ReentrancyGuardUpgradeable.__ReentrancyGuard_init_unchained() (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#44-46) is not in mixedCase
Variable ReentrancyGuardUpgradeable.__gap (@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#88) is not in mixedCase
Function ERC20Upgradeable.__ERC20_init(string,string) (@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#55-57) is not in mixedCase
Function ERC20Upgradeable.__ERC20_init_unchained(string,string) (@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#59-62) is not in mixedCase
Variable ERC20Upgradeable.__gap (@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#376) is not in mixedCase
Function IERC20PermitUpgradeable.DOMAIN_SEPARATOR() (@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#59) is not in mixedCase
Function ContextUpgradeable.__Context_init() (@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#18-19) is not in mixedCase
Function ContextUpgradeable.__Context_init_unchained() (@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#21-22) is not in mixedCase
Variable ContextUpgradeable.__gap (@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#36) is not in mixedCase
Function ERC165Upgradeable.__ERC165_init() (@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#24-25) is not in mixedCase
Function ERC165Upgradeable.__ERC165_init_unchained() (@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#27-28) is not in mixedCase
Variable ERC165Upgradeable.__gap (@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#41) is not in mixedCase
Function IERC20Permit.DOMAIN_SEPARATOR() (@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#59) is not in mixedCase
Parameter OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._roleManager (contracts/Delegation/OperatorDelegator.sol#66) is not in mixedCase
Parameter OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._strategyManager (contracts/Delegation/OperatorDelegator.sol#67) is not in mixedCase
Parameter OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._restakeManager (contracts/Delegation/OperatorDelegator.sol#68) is not in mixedCase
Parameter OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._delegationManager (contracts/Delegation/OperatorDelegator.sol#69) is not in mixedCase
Parameter OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._eigenPodManager (contracts/Delegation/OperatorDelegator.sol#70) is not in mixedCase
Parameter OperatorDelegator.setTokenStrategy(IERC20,IStrategy)._token (contracts/Delegation/OperatorDelegator.sol#96) is not in mixedCase
Parameter OperatorDelegator.setTokenStrategy(IERC20,IStrategy)._strategy (contracts/Delegation/OperatorDelegator.sol#97) is not in mixedCase
Parameter OperatorDelegator.setDelegateAddress(address)._delegateAddress (contracts/Delegation/OperatorDelegator.sol#108) is not in mixedCase
Parameter OperatorDelegator.deposit(IERC20,uint256)._token (contracts/Delegation/OperatorDelegator.sol#127) is not in mixedCase
Parameter OperatorDelegator.deposit(IERC20,uint256)._tokenAmount (contracts/Delegation/OperatorDelegator.sol#128) is not in mixedCase
Parameter OperatorDelegator.getStrategyIndex(IStrategy)._strategy (contracts/Delegation/OperatorDelegator.sol#149) is not in mixedCase
Parameter OperatorDelegator.startWithdrawal(IERC20,uint256)._token (contracts/Delegation/OperatorDelegator.sol#168) is not in mixedCase
Parameter OperatorDelegator.startWithdrawal(IERC20,uint256)._tokenAmount (contracts/Delegation/OperatorDelegator.sol#169) is not in mixedCase
Parameter OperatorDelegator.completeWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20,uint256,address)._withdrawal (contracts/Delegation/OperatorDelegator.sol#216) is not in mixedCase
Parameter OperatorDelegator.completeWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20,uint256,address)._token (contracts/Delegation/OperatorDelegator.sol#217) is not in mixedCase
Parameter OperatorDelegator.completeWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20,uint256,address)._middlewareTimesIndex (contracts/Delegation/OperatorDelegator.sol#218) is not in mixedCase
Parameter OperatorDelegator.completeWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20,uint256,address)._sendToAddress (contracts/Delegation/OperatorDelegator.sol#219) is not in mixedCase
Parameter DepositQueue.initialize(IRoleManager)._roleManager (contracts/Deposits/DepositQueue.sol#77) is not in mixedCase
Parameter DepositQueue.setFeeConfig(address,uint256)._feeAddress (contracts/Deposits/DepositQueue.sol#87) is not in mixedCase
Parameter DepositQueue.setFeeConfig(address,uint256)._feeBasisPoints (contracts/Deposits/DepositQueue.sol#87) is not in mixedCase
Parameter DepositQueue.setRestakeManager(IRestakeManager)._restakeManager (contracts/Deposits/DepositQueue.sol#106) is not in mixedCase
Function IEigenPod.REQUIRED_BALANCE_GWEI() (contracts/EigenLayer/interfaces/IEigenPod.sol#53) is not in mixedCase
Function IEigenPod.REQUIRED_BALANCE_WEI() (contracts/EigenLayer/interfaces/IEigenPod.sol#56) is not in mixedCase
Enum IEigenPod.VALIDATOR_STATUS (contracts/EigenLayer/interfaces/IEigenPod.sol#28-33) is not in CapWords
Enum IEigenPod.PARTIAL_WITHDRAWAL_CLAIM_STATUS (contracts/EigenLayer/interfaces/IEigenPod.sol#46-50) is not in CapWords
Contract baseEigenPodManager (contracts/Mock/EigenPodManager.sol#15-181) is not in CapWords
Parameter RenzoOracle.initialize(IRoleManager)._roleManager (contracts/Oracle/RenzoOracle.sol#48) is not in mixedCase
Parameter RenzoOracle.setOracleAddress(IERC20,AggregatorV3Interface)._token (contracts/Oracle/RenzoOracle.sol#60) is not in mixedCase
Parameter RenzoOracle.setOracleAddress(IERC20,AggregatorV3Interface)._oracleAddress (contracts/Oracle/RenzoOracle.sol#60) is not in mixedCase
Parameter RenzoOracle.lookupTokenValue(IERC20,uint256)._token (contracts/Oracle/RenzoOracle.sol#73) is not in mixedCase
Parameter RenzoOracle.lookupTokenValue(IERC20,uint256)._balance (contracts/Oracle/RenzoOracle.sol#73) is not in mixedCase
Parameter RenzoOracle.lookupTokenAmountFromValue(IERC20,uint256)._token (contracts/Oracle/RenzoOracle.sol#97) is not in mixedCase
Parameter RenzoOracle.lookupTokenAmountFromValue(IERC20,uint256)._value (contracts/Oracle/RenzoOracle.sol#97) is not in mixedCase
Parameter RenzoOracle.lookupTokenValues(IERC20[],uint256[])._tokens (contracts/Oracle/RenzoOracle.sol#115) is not in mixedCase
Parameter RenzoOracle.lookupTokenValues(IERC20[],uint256[])._balances (contracts/Oracle/RenzoOracle.sol#115) is not in mixedCase
Parameter RenzoOracle.calculateMintAmount(uint256,uint256,uint256)._currentValueInProtocol (contracts/Oracle/RenzoOracle.sol#132) is not in mixedCase
Parameter RenzoOracle.calculateMintAmount(uint256,uint256,uint256)._newValueAdded (contracts/Oracle/RenzoOracle.sol#132) is not in mixedCase
Parameter RenzoOracle.calculateMintAmount(uint256,uint256,uint256)._existingEzETHSupply (contracts/Oracle/RenzoOracle.sol#132) is not in mixedCase
Parameter RenzoOracle.calculateRedeemAmount(uint256,uint256,uint256)._ezETHBeingBurned (contracts/Oracle/RenzoOracle.sol#156) is not in mixedCase
Parameter RenzoOracle.calculateRedeemAmount(uint256,uint256,uint256)._existingEzETHSupply (contracts/Oracle/RenzoOracle.sol#156) is not in mixedCase
Parameter RenzoOracle.calculateRedeemAmount(uint256,uint256,uint256)._currentValueInProtocol (contracts/Oracle/RenzoOracle.sol#156) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._roleManager (contracts/RestakeManager.sol#110) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._ezETH (contracts/RestakeManager.sol#111) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._renzoOracle (contracts/RestakeManager.sol#112) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._strategyManager (contracts/RestakeManager.sol#113) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._delegationManager (contracts/RestakeManager.sol#114) is not in mixedCase
Parameter RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._depositQueue (contracts/RestakeManager.sol#115) is not in mixedCase
Parameter RestakeManager.setPaused(bool)._paused (contracts/RestakeManager.sol#130) is not in mixedCase
Parameter RestakeManager.addOperatorDelegator(IOperatorDelegator,uint256)._newOperatorDelegator (contracts/RestakeManager.sol#149) is not in mixedCase
Parameter RestakeManager.addOperatorDelegator(IOperatorDelegator,uint256)._allocationBasisPoints (contracts/RestakeManager.sol#150) is not in mixedCase
Parameter RestakeManager.removeOperatorDelegator(IOperatorDelegator)._operatorDelegatorToRemove (contracts/RestakeManager.sol#191) is not in mixedCase
Parameter RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._operatorDelegator (contracts/RestakeManager.sol#232) is not in mixedCase
Parameter RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._allocationBasisPoints (contracts/RestakeManager.sol#233) is not in mixedCase
Parameter RestakeManager.setMaxDepositTVL(uint256)._maxDepositTVL (contracts/RestakeManager.sol#266) is not in mixedCase
Parameter RestakeManager.addCollateralToken(IERC20)._newCollateralToken (contracts/RestakeManager.sol#276) is not in mixedCase
Parameter RestakeManager.removeCollateralToken(IERC20)._collateralTokenToRemove (contracts/RestakeManager.sol#303) is not in mixedCase
Parameter RestakeManager.getCollateralTokenIndex(IERC20)._collateralToken (contracts/RestakeManager.sol#499) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256)._collateralToken (contracts/RestakeManager.sol#523) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256)._amount (contracts/RestakeManager.sol#524) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256,uint256)._collateralToken (contracts/RestakeManager.sol#544) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256,uint256)._amount (contracts/RestakeManager.sol#545) is not in mixedCase
Parameter RestakeManager.deposit(IERC20,uint256,uint256)._referralId (contracts/RestakeManager.sol#546) is not in mixedCase
Parameter RestakeManager.depositETH(uint256)._referralId (contracts/RestakeManager.sol#642) is not in mixedCase
Parameter RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)._token (contracts/RestakeManager.sol#695) is not in mixedCase
Parameter RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)._amount (contracts/RestakeManager.sol#696) is not in mixedCase
Parameter RestakeManager.setTokenTvlLimit(IERC20,uint256)._token (contracts/RestakeManager.sol#761) is not in mixedCase
Parameter RestakeManager.setTokenTvlLimit(IERC20,uint256)._limit (contracts/RestakeManager.sol#761) is not in mixedCase
Parameter EzEthToken.initialize(IRoleManager)._roleManager (contracts/token/EzEthToken.sol#38) is not in mixedCase
Parameter EzEthToken.setPaused(bool)._paused (contracts/token/EzEthToken.sol#56) is not in mixedCase
Contract console (node_modules/hardhat/console.sol#4-1552) is not in CapWords
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
INFO:Detectors:
Variable RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._operatorDelegator (contracts/RestakeManager.sol#232) is too similar to RestakeManagerStorageV1.operatorDelegators (contracts/RestakeManagerStorage.sol#48)
Variable RestakeManager.deposit(IERC20,uint256)._collateralToken (contracts/RestakeManager.sol#523) is too similar to RestakeManagerStorageV1.collateralTokens (contracts/RestakeManagerStorage.sol#57)
Variable RestakeManager.getCollateralTokenIndex(IERC20)._collateralToken (contracts/RestakeManager.sol#499) is too similar to RestakeManagerStorageV1.collateralTokens (contracts/RestakeManagerStorage.sol#57)
Variable RestakeManager.deposit(IERC20,uint256,uint256)._collateralToken (contracts/RestakeManager.sol#544) is too similar to RestakeManagerStorageV1.collateralTokens (contracts/RestakeManagerStorage.sol#57)
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
RenzoOracle.INVALID_0_INPUT (contracts/Oracle/RenzoOracle.sol#24) is never used in RenzoOracle (contracts/Oracle/RenzoOracle.sol#13-166)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unused-state-variable
INFO:Detectors:
ERC20Faucet.decimals (contracts/Mock/ERC20Faucet.sol#12) should be constant 
ERC20Faucet.name (contracts/Mock/ERC20Faucet.sol#10) should be constant 
ERC20Faucet.symbol (contracts/Mock/ERC20Faucet.sol#11) should be constant 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-constant
INFO:Detectors:
Lock.owner (contracts/Lock.sol#9) should be immutable 
Lock.unlockTime (contracts/Lock.sol#8) should be immutable 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-immutable
**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [arbitrary-send-eth](#arbitrary-send-eth) (1 results) (High)
 - [divide-before-multiply](#divide-before-multiply) (8 results) (Medium)
 - [locked-ether](#locked-ether) (1 results) (Medium)
 - [unused-return](#unused-return) (5 results) (Medium)
 - [events-maths](#events-maths) (1 results) (Low)
 - [calls-loop](#calls-loop) (8 results) (Low)
 - [reentrancy-benign](#reentrancy-benign) (7 results) (Low)
 - [reentrancy-events](#reentrancy-events) (3 results) (Low)
 - [timestamp](#timestamp) (4 results) (Low)
 - [assembly](#assembly) (8 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [costly-loop](#costly-loop) (2 results) (Informational)
 - [dead-code](#dead-code) (76 results) (Informational)
 - [solc-version](#solc-version) (62 results) (Informational)
 - [low-level-calls](#low-level-calls) (12 results) (Informational)
 - [naming-convention](#naming-convention) (87 results) (Informational)
 - [similar-names](#similar-names) (4 results) (Informational)
 - [too-many-digits](#too-many-digits) (1 results) (Informational)
 - [unused-state](#unused-state) (31 results) (Informational)
 - [constable-states](#constable-states) (3 results) (Optimization)
 - [immutable-states](#immutable-states) (2 results) (Optimization)
## arbitrary-send-eth
Impact: High
Confidence: Medium
 - [ ] ID-0
[DepositQueue.stakeEthFromQueue(IOperatorDelegator,bytes,bytes,bytes32)](contracts/Deposits/DepositQueue.sol#L154-L161) sends eth to arbitrary user
	Dangerous calls:
	- [restakeManager.stakeEthInOperatorDelegator{value: 32000000000000000000}(operatorDelegator,pubkey,signature,depositDataRoot)](contracts/Deposits/DepositQueue.sol#L158)

contracts/Deposits/DepositQueue.sol#L154-L161


## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-1
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L101)
	- [inverse *= 2 - denominator * inverse](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L120)

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


 - [ ] ID-2
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L101)
	- [inverse *= 2 - denominator * inverse](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L123)

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


 - [ ] ID-3
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L101)
	- [inverse = (3 * denominator) ^ 2](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L116)

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


 - [ ] ID-4
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L101)
	- [inverse *= 2 - denominator * inverse](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L124)

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


 - [ ] ID-5
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L101)
	- [inverse *= 2 - denominator * inverse](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L122)

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


 - [ ] ID-6
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L101)
	- [inverse *= 2 - denominator * inverse](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L121)

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


 - [ ] ID-7
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) performs a multiplication on the result of a division:
	- [prod0 = prod0 / twos](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L104)
	- [result = prod0 * inverse](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L131)

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


 - [ ] ID-8
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L101)
	- [inverse *= 2 - denominator * inverse](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L125)

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


## locked-ether
Impact: Medium
Confidence: High
 - [ ] ID-9
Contract locking ether found:
	Contract [EigenPodManager](contracts/Mock/EigenPodManager.sol#L183-L184) has payable functions:
	 - [baseEigenPodManager.stake(bytes,bytes,bytes32)](contracts/Mock/EigenPodManager.sol#L32-L35)
	But does not have a function to withdraw the ether

contracts/Mock/EigenPodManager.sol#L183-L184


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-10
[RenzoOracle.lookupTokenAmountFromValue(IERC20,uint256)](contracts/Oracle/RenzoOracle.sol#L97-L107) ignores return value by [(price,timestamp) = oracle.latestRoundData()](contracts/Oracle/RenzoOracle.sol#L101)

contracts/Oracle/RenzoOracle.sol#L97-L107


 - [ ] ID-11
[DepositQueue.sweepERC20(IERC20)](contracts/Deposits/DepositQueue.sol#L166-L192) ignores return value by [token.approve(address(restakeManager),balance - feeAmount)](contracts/Deposits/DepositQueue.sol#L182)

contracts/Deposits/DepositQueue.sol#L166-L192


 - [ ] ID-12
[RestakeManager.deposit(IERC20,uint256,uint256)](contracts/RestakeManager.sol#L543-L625) ignores return value by [operatorDelegator.deposit(_collateralToken,_amount)](contracts/RestakeManager.sol#L611)

contracts/RestakeManager.sol#L543-L625


 - [ ] ID-13
[RenzoOracle.lookupTokenValue(IERC20,uint256)](contracts/Oracle/RenzoOracle.sol#L73-L93) ignores return value by [(price,timestamp) = oracle.latestRoundData()](contracts/Oracle/RenzoOracle.sol#L85)

contracts/Oracle/RenzoOracle.sol#L73-L93


 - [ ] ID-14
[RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)](contracts/RestakeManager.sol#L694-L724) ignores return value by [operatorDelegator.deposit(_token,_amount)](contracts/RestakeManager.sol#L723)

contracts/RestakeManager.sol#L694-L724


## events-maths
Impact: Low
Confidence: Medium
 - [ ] ID-15
[OperatorDelegator.stakeEth(bytes,bytes,bytes32)](contracts/Delegation/OperatorDelegator.sol#L257-L263) should emit an event for: 
	- [stakedButNotVerifiedEth += msg.value](contracts/Delegation/OperatorDelegator.sol#L262) 

contracts/Delegation/OperatorDelegator.sol#L257-L263


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-16
[RestakeManager.calculateTVLs()](contracts/RestakeManager.sol#L336-L406) has external calls inside a loop: [operatorValues[j] = renzoOracle.lookupTokenValue(collateralTokens[j],operatorBalance)](contracts/RestakeManager.sol#L373-L376)

contracts/RestakeManager.sol#L336-L406


 - [ ] ID-17
[RestakeManager.getTotalRewardsEarned()](contracts/RestakeManager.sol#L731-L759) has external calls inside a loop: [tokenRewardAmount = depositQueue.totalEarned(address(collateralTokens[i]))](contracts/RestakeManager.sol#L741)

contracts/RestakeManager.sol#L731-L759


 - [ ] ID-18
[OperatorDelegator.getStrategyIndex(IStrategy)](contracts/Delegation/OperatorDelegator.sol#L149-L161) has external calls inside a loop: [strategyManager.stakerStrategyList(address(this),i) == _strategy](contracts/Delegation/OperatorDelegator.sol#L154)

contracts/Delegation/OperatorDelegator.sol#L149-L161


 - [ ] ID-19
[RestakeManager.calculateTVLs()](contracts/RestakeManager.sol#L336-L406) has external calls inside a loop: [operatorBalance = operatorDelegators[i].getTokenBalanceFromStrategy(collateralTokens[j])](contracts/RestakeManager.sol#L368-L369)

contracts/RestakeManager.sol#L336-L406


 - [ ] ID-20
[RenzoOracle.lookupTokenValue(IERC20,uint256)](contracts/Oracle/RenzoOracle.sol#L73-L93) has external calls inside a loop: [(price,timestamp) = oracle.latestRoundData()](contracts/Oracle/RenzoOracle.sol#L85)

contracts/Oracle/RenzoOracle.sol#L73-L93


 - [ ] ID-21
[RestakeManager.calculateTVLs()](contracts/RestakeManager.sol#L336-L406) has external calls inside a loop: [operatorEthBalance = operatorDelegators[i].getStakedETHBalance()](contracts/RestakeManager.sol#L385)

contracts/RestakeManager.sol#L336-L406


 - [ ] ID-22
[RestakeManager.getTotalRewardsEarned()](contracts/RestakeManager.sol#L731-L759) has external calls inside a loop: [totalRewards += address(operatorDelegators[i_scope_0].eigenPod()).balance + operatorDelegators[i_scope_0].pendingUnstakedDelayedWithdrawalAmount()](contracts/RestakeManager.sol#L754)

contracts/RestakeManager.sol#L731-L759


 - [ ] ID-23
[RestakeManager.getTotalRewardsEarned()](contracts/RestakeManager.sol#L731-L759) has external calls inside a loop: [totalRewards += renzoOracle.lookupTokenValue(collateralTokens[i],tokenRewardAmount)](contracts/RestakeManager.sol#L744)

contracts/RestakeManager.sol#L731-L759


## reentrancy-benign
Impact: Low
Confidence: Medium
 - [ ] ID-24
Reentrancy in [DepositQueue.sweepERC20(IERC20)](contracts/Deposits/DepositQueue.sol#L166-L192):
	External calls:
	- [IERC20(token).safeTransfer(feeAddress,feeAmount)](contracts/Deposits/DepositQueue.sol#L175)
	- [token.approve(address(restakeManager),balance - feeAmount)](contracts/Deposits/DepositQueue.sol#L182)
	- [restakeManager.depositTokenRewardsFromProtocol(token,balance - feeAmount)](contracts/Deposits/DepositQueue.sol#L183)
	State variables written after the call(s):
	- [totalEarned[address(token)] = totalEarned[address(token)] + balance - feeAmount](contracts/Deposits/DepositQueue.sol#L187)

contracts/Deposits/DepositQueue.sol#L166-L192


 - [ ] ID-25
Reentrancy in [OperatorDelegator.stakeEth(bytes,bytes,bytes32)](contracts/Delegation/OperatorDelegator.sol#L257-L263):
	External calls:
	- [eigenPodManager.stake{value: msg.value}(pubkey,signature,depositDataRoot)](contracts/Delegation/OperatorDelegator.sol#L259)
	State variables written after the call(s):
	- [stakedButNotVerifiedEth += msg.value](contracts/Delegation/OperatorDelegator.sol#L262)

contracts/Delegation/OperatorDelegator.sol#L257-L263


 - [ ] ID-26
Reentrancy in [OperatorDelegator.verifyWithdrawalCredentials(uint64,uint40,BeaconChainProofs.ValidatorFieldsAndBalanceProofs,bytes32[])](contracts/Delegation/OperatorDelegator.sol#L271-L287):
	External calls:
	- [eigenPod.verifyWithdrawalCredentialsAndBalance(oracleBlockNumber,validatorIndex,proofs,validatorFields)](contracts/Delegation/OperatorDelegator.sol#L277-L282)
	State variables written after the call(s):
	- [stakedButNotVerifiedEth -= (validatorCurrentBalanceGwei * GWEI_TO_WEI)](contracts/Delegation/OperatorDelegator.sol#L286)

contracts/Delegation/OperatorDelegator.sol#L271-L287


 - [ ] ID-27
Reentrancy in [OperatorDelegator.receive()](contracts/Delegation/OperatorDelegator.sol#L316-L335):
	External calls:
	- [msg.sender == address(eigenPod.delayedWithdrawalRouter())](contracts/Delegation/OperatorDelegator.sol#L320)
	State variables written after the call(s):
	- [pendingUnstakedDelayedWithdrawalAmount -= msg.value](contracts/Delegation/OperatorDelegator.sol#L323)
	- [pendingUnstakedDelayedWithdrawalAmount = 0](contracts/Delegation/OperatorDelegator.sol#L326)

contracts/Delegation/OperatorDelegator.sol#L316-L335


 - [ ] ID-28
Reentrancy in [OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)](contracts/Delegation/OperatorDelegator.sol#L65-L91):
	External calls:
	- [eigenPodManager.createPod()](contracts/Delegation/OperatorDelegator.sol#L87)
	State variables written after the call(s):
	- [eigenPod = IEigenPod(eigenPodManager.ownerToPod(address(this)))](contracts/Delegation/OperatorDelegator.sol#L90)

contracts/Delegation/OperatorDelegator.sol#L65-L91


 - [ ] ID-29
Reentrancy in [DepositQueue.receive()](contracts/Deposits/DepositQueue.sol#L130-L148):
	External calls:
	- [(success) = feeAddress.call{value: feeAmount}()](contracts/Deposits/DepositQueue.sol#L136)
	State variables written after the call(s):
	- [totalEarned[address(0x0)] = totalEarned[address(0x0)] + msg.value - feeAmount](contracts/Deposits/DepositQueue.sol#L144)

contracts/Deposits/DepositQueue.sol#L130-L148


 - [ ] ID-30
Reentrancy in [OperatorDelegator.startDelayedWithdrawUnstakedETH()](contracts/Delegation/OperatorDelegator.sol#L294-L305):
	External calls:
	- [eigenPod.withdrawBeforeRestaking()](contracts/Delegation/OperatorDelegator.sol#L301)
	State variables written after the call(s):
	- [pendingUnstakedDelayedWithdrawalAmount += (beforeEigenPodBalance - address(eigenPod).balance)](contracts/Delegation/OperatorDelegator.sol#L304)

contracts/Delegation/OperatorDelegator.sol#L294-L305


## reentrancy-events
Impact: Low
Confidence: Medium
 - [ ] ID-31
Reentrancy in [DepositQueue.sweepERC20(IERC20)](contracts/Deposits/DepositQueue.sol#L166-L192):
	External calls:
	- [IERC20(token).safeTransfer(feeAddress,feeAmount)](contracts/Deposits/DepositQueue.sol#L175)
	Event emitted after the call(s):
	- [ProtocolFeesPaid(token,feeAmount,feeAddress)](contracts/Deposits/DepositQueue.sol#L177)

contracts/Deposits/DepositQueue.sol#L166-L192


 - [ ] ID-32
Reentrancy in [DepositQueue.stakeEthFromQueue(IOperatorDelegator,bytes,bytes,bytes32)](contracts/Deposits/DepositQueue.sol#L154-L161):
	External calls:
	- [restakeManager.stakeEthInOperatorDelegator{value: 32000000000000000000}(operatorDelegator,pubkey,signature,depositDataRoot)](contracts/Deposits/DepositQueue.sol#L158)
	Event emitted after the call(s):
	- [ETHStakedFromQueue(operatorDelegator,pubkey,32000000000000000000,address(this).balance)](contracts/Deposits/DepositQueue.sol#L160)

contracts/Deposits/DepositQueue.sol#L154-L161


 - [ ] ID-33
Reentrancy in [DepositQueue.sweepERC20(IERC20)](contracts/Deposits/DepositQueue.sol#L166-L192):
	External calls:
	- [IERC20(token).safeTransfer(feeAddress,feeAmount)](contracts/Deposits/DepositQueue.sol#L175)
	- [token.approve(address(restakeManager),balance - feeAmount)](contracts/Deposits/DepositQueue.sol#L182)
	- [restakeManager.depositTokenRewardsFromProtocol(token,balance - feeAmount)](contracts/Deposits/DepositQueue.sol#L183)
	Event emitted after the call(s):
	- [RewardsDeposited(IERC20(address(token)),balance - feeAmount)](contracts/Deposits/DepositQueue.sol#L190)

contracts/Deposits/DepositQueue.sol#L166-L192


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-34
[Lock.withdraw()](contracts/Lock.sol#L23-L33) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(block.timestamp >= unlockTime,You can't withdraw yet)](contracts/Lock.sol#L27)

contracts/Lock.sol#L23-L33


 - [ ] ID-35
[RenzoOracle.lookupTokenAmountFromValue(IERC20,uint256)](contracts/Oracle/RenzoOracle.sol#L97-L107) uses timestamp for comparisons
	Dangerous comparisons:
	- [timestamp < block.timestamp - MAX_TIME_WINDOW](contracts/Oracle/RenzoOracle.sol#L102)

contracts/Oracle/RenzoOracle.sol#L97-L107


 - [ ] ID-36
[Lock.constructor(uint256)](contracts/Lock.sol#L13-L21) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(block.timestamp < _unlockTime,Unlock time should be in the future)](contracts/Lock.sol#L14-L17)

contracts/Lock.sol#L13-L21


 - [ ] ID-37
[RenzoOracle.lookupTokenValue(IERC20,uint256)](contracts/Oracle/RenzoOracle.sol#L73-L93) uses timestamp for comparisons
	Dangerous comparisons:
	- [timestamp < block.timestamp - MAX_TIME_WINDOW](contracts/Oracle/RenzoOracle.sol#L87)

contracts/Oracle/RenzoOracle.sol#L73-L93


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-38
[console._sendLogPayloadImplementation(bytes)](node_modules/hardhat/console.sol#L8-L23) uses assembly
	- [INLINE ASM](node_modules/hardhat/console.sol#L11-L22)

node_modules/hardhat/console.sol#L8-L23


 - [ ] ID-39
[StringsUpgradeable.toString(uint256)](@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L19-L39) uses assembly
	- [INLINE ASM](@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L25-L27)
	- [INLINE ASM](@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L31-L33)

@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L19-L39


 - [ ] ID-40
[Address._revert(bytes,string)](@openzeppelin/contracts/utils/Address.sol#L231-L243) uses assembly
	- [INLINE ASM](@openzeppelin/contracts/utils/Address.sol#L236-L239)

@openzeppelin/contracts/utils/Address.sol#L231-L243


 - [ ] ID-41
[console._castToPure(function(bytes))](node_modules/hardhat/console.sol#L25-L31) uses assembly
	- [INLINE ASM](node_modules/hardhat/console.sol#L28-L30)

node_modules/hardhat/console.sol#L25-L31


 - [ ] ID-42
[Merkle.processInclusionProofKeccak(bytes,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L48-L71) uses assembly
	- [INLINE ASM](contracts/EigenLayer/libraries/Merkle.sol#L54-L59)
	- [INLINE ASM](contracts/EigenLayer/libraries/Merkle.sol#L62-L67)

contracts/EigenLayer/libraries/Merkle.sol#L48-L71


 - [ ] ID-43
[AddressUpgradeable._revert(bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L231-L243) uses assembly
	- [INLINE ASM](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L236-L239)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L231-L243


 - [ ] ID-44
[Merkle.processInclusionProofSha256(bytes,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L100-L123) uses assembly
	- [INLINE ASM](contracts/EigenLayer/libraries/Merkle.sol#L106-L111)
	- [INLINE ASM](contracts/EigenLayer/libraries/Merkle.sol#L114-L119)

contracts/EigenLayer/libraries/Merkle.sol#L100-L123


 - [ ] ID-45
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) uses assembly
	- [INLINE ASM](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L62-L66)
	- [INLINE ASM](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L85-L92)
	- [INLINE ASM](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L99-L108)

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-46
Different versions of Solidity are used:
	- Version used: ['0.8.19', '=0.8.19', '>=0.4.22<0.9.0', '^0.8.0', '^0.8.1', '^0.8.2', '^0.8.9']
	- [0.8.19](contracts/Delegation/IOperatorDelegator.sol#L2)
	- [0.8.19](contracts/Delegation/OperatorDelegator.sol#L2)
	- [0.8.19](contracts/Delegation/OperatorDelegatorStorage.sol#L2)
	- [0.8.19](contracts/Deposits/DepositQueue.sol#L2)
	- [0.8.19](contracts/Deposits/DepositQueueStorage.sol#L2)
	- [0.8.19](contracts/Deposits/IDepositQueue.sol#L2)
	- [0.8.19](contracts/Errors/Errors.sol#L2)
	- [0.8.19](contracts/IRestakeManager.sol#L2)
	- [0.8.19](contracts/Lock.sol#L2)
	- [0.8.19](contracts/Mock/ERC20Faucet.sol#L2)
	- [0.8.19](contracts/Oracle/IRenzoOracle.sol#L2)
	- [0.8.19](contracts/Oracle/RenzoOracle.sol#L2)
	- [0.8.19](contracts/Oracle/RenzoOracleStorage.sol#L2)
	- [0.8.19](contracts/Permissions/IRoleManager.sol#L2)
	- [0.8.19](contracts/Permissions/RoleManager.sol#L2)
	- [0.8.19](contracts/Permissions/RoleManagerStorage.sol#L2)
	- [0.8.19](contracts/RestakeManager.sol#L2)
	- [0.8.19](contracts/RestakeManagerStorage.sol#L2)
	- [0.8.19](contracts/token/EzEthTokenStorage.sol#L2)
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
	- [=0.8.19](contracts/Mock/DelegationManager.sol#L2)
	- [=0.8.19](contracts/Mock/EigenPodManager.sol#L2)
	- [=0.8.19](contracts/Mock/StrategyManager.sol#L2)
	- [>=0.4.22<0.9.0](node_modules/hardhat/console.sol#L2)
	- [^0.8.0](@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#L2)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/access/IAccessControlUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/utils/introspection/IERC165Upgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L4)
	- [^0.8.0](@openzeppelin/contracts/token/ERC20/IERC20.sol#L4)
	- [^0.8.0](@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4)
	- [^0.8.0](@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L4)
	- [^0.8.0](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L4)
	- [^0.8.1](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L4)
	- [^0.8.1](@openzeppelin/contracts/utils/Address.sol#L4)
	- [^0.8.2](@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L4)
	- [^0.8.9](contracts/token/EzEthToken.sol#L2)
	- [^0.8.9](contracts/token/IEzEthToken.sol#L2)

contracts/Delegation/IOperatorDelegator.sol#L2


## costly-loop
Impact: Informational
Confidence: Medium
 - [ ] ID-47
[RestakeManager.removeCollateralToken(IERC20)](contracts/RestakeManager.sol#L302-L324) has costly operations inside a loop:
	- [collateralTokens.pop()](contracts/RestakeManager.sol#L315)

contracts/RestakeManager.sol#L302-L324


 - [ ] ID-48
[RestakeManager.removeOperatorDelegator(IOperatorDelegator)](contracts/RestakeManager.sol#L190-L221) has costly operations inside a loop:
	- [operatorDelegators.pop()](contracts/RestakeManager.sol#L212)

contracts/RestakeManager.sol#L190-L221


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-49
[StringsUpgradeable.toString(uint256)](@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L19-L39) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L19-L39


 - [ ] ID-50
[BeaconChainProofs.verifyWithdrawalProofs(bytes32,BeaconChainProofs.WithdrawalProofs,bytes32[])](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L206-L261) is never used and should be removed

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L206-L261


 - [ ] ID-51
[ContextUpgradeable._msgData()](@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L27-L29) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L27-L29


 - [ ] ID-52
[MathUpgradeable.log2(uint256,MathUpgradeable.Rounding)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L241-L246) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L241-L246


 - [ ] ID-53
[Initializable._isInitializing()](@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L163-L165) is never used and should be removed

@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L163-L165


 - [ ] ID-54
[Address.verifyCallResult(bool,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L219-L229) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L219-L229


 - [ ] ID-55
[AddressUpgradeable.functionCallWithValue(address,bytes,uint256)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L118-L120) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L118-L120


 - [ ] ID-56
[MathUpgradeable.ceilDiv(uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L45-L48) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L45-L48


 - [ ] ID-57
[Merkle.processInclusionProofKeccak(bytes,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L48-L71) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L48-L71


 - [ ] ID-58
[SafeERC20Upgradeable._callOptionalReturnBool(IERC20Upgradeable,bytes)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L134-L142) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L134-L142


 - [ ] ID-59
[MathUpgradeable.min(uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L26-L28) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L26-L28


 - [ ] ID-60
[SafeERC20Upgradeable.safeApprove(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L45-L54) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L45-L54


 - [ ] ID-61
[MathUpgradeable.sqrt(uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L152-L183) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L152-L183


 - [ ] ID-62
[Address.sendValue(address,uint256)](@openzeppelin/contracts/utils/Address.sol#L64-L69) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L64-L69


 - [ ] ID-63
[Address.functionCallWithValue(address,bytes,uint256)](@openzeppelin/contracts/utils/Address.sol#L118-L120) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L118-L120


 - [ ] ID-64
[SafeERC20Upgradeable.safeIncreaseAllowance(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L60-L63) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L60-L63


 - [ ] ID-65
[SignedMathUpgradeable.min(int256,int256)](@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L20-L22) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L20-L22


 - [ ] ID-66
[Address.functionDelegateCall(address,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L180-L187) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L180-L187


 - [ ] ID-67
[MathUpgradeable.log10(uint256,MathUpgradeable.Rounding)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L290-L295) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L290-L295


 - [ ] ID-68
[AddressUpgradeable.functionCall(address,bytes)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L89-L91) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L89-L91


 - [ ] ID-69
[StringsUpgradeable.equal(string,string)](@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L82-L84) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L82-L84


 - [ ] ID-70
[ContextUpgradeable.__Context_init_unchained()](@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L21-L22) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L21-L22


 - [ ] ID-71
[Merkle.verifyInclusionKeccak(bytes,bytes32,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L29-L36) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L29-L36


 - [ ] ID-72
[ERC165Upgradeable.__ERC165_init_unchained()](@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L27-L28) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L27-L28


 - [ ] ID-73
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L55-L134


 - [ ] ID-74
[SafeERC20Upgradeable.safeTransferFrom(IERC20Upgradeable,address,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L34-L36) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L34-L36


 - [ ] ID-75
[Address.functionDelegateCall(address,bytes)](@openzeppelin/contracts/utils/Address.sol#L170-L172) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L170-L172


 - [ ] ID-76
[SafeERC20.safeIncreaseAllowance(IERC20,address,uint256)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L60-L63) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L60-L63


 - [ ] ID-77
[AddressUpgradeable.functionCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L99-L105) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L99-L105


 - [ ] ID-78
[SafeERC20.safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L95-L109) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L95-L109


 - [ ] ID-79
[AddressUpgradeable.sendValue(address,uint256)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L64-L69) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L64-L69


 - [ ] ID-80
[SafeERC20Upgradeable.forceApprove(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L82-L89) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L82-L89


 - [ ] ID-81
[BeaconChainProofs.verifyValidatorBalance(uint40,bytes32,bytes,bytes32)](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L182-L198) is never used and should be removed

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L182-L198


 - [ ] ID-82
[ReentrancyGuardUpgradeable._reentrancyGuardEntered()](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L79-L81) is never used and should be removed

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L79-L81


 - [ ] ID-83
[AddressUpgradeable.functionStaticCall(address,bytes)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L145-L147) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L145-L147


 - [ ] ID-84
[MathUpgradeable.sqrt(uint256,MathUpgradeable.Rounding)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L188-L193) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L188-L193


 - [ ] ID-85
[MathUpgradeable.log2(uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L199-L235) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L199-L235


 - [ ] ID-86
[AccessControlUpgradeable._setRoleAdmin(bytes32,bytes32)](@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L221-L225) is never used and should be removed

@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L221-L225


 - [ ] ID-87
[MathUpgradeable.average(uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L34-L37) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L34-L37


 - [ ] ID-88
[StringsUpgradeable.toHexString(uint256)](@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L51-L55) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L51-L55


 - [ ] ID-89
[SignedMathUpgradeable.max(int256,int256)](@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L13-L15) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L13-L15


 - [ ] ID-90
[SafeERC20Upgradeable.safeDecreaseAllowance(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L69-L75) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L69-L75


 - [ ] ID-91
[Address.functionStaticCall(address,bytes)](@openzeppelin/contracts/utils/Address.sol#L145-L147) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L145-L147


 - [ ] ID-92
[MathUpgradeable.log10(uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L252-L284) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L252-L284


 - [ ] ID-93
[ERC165Upgradeable.__ERC165_init()](@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L24-L25) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L24-L25


 - [ ] ID-94
[StringsUpgradeable.toString(int256)](@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L44-L46) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L44-L46


 - [ ] ID-95
[SafeERC20Upgradeable.safePermit(IERC20PermitUpgradeable,address,address,uint256,uint256,uint8,bytes32,bytes32)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L95-L109) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L95-L109


 - [ ] ID-96
[MathUpgradeable.mulDiv(uint256,uint256,uint256,MathUpgradeable.Rounding)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L139-L145) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L139-L145


 - [ ] ID-97
[SafeERC20Upgradeable._callOptionalReturn(IERC20Upgradeable,bytes)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L117-L124) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L117-L124


 - [ ] ID-98
[Merkle.verifyInclusionSha256(bytes,bytes32,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L81-L88) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L81-L88


 - [ ] ID-99
[AddressUpgradeable.verifyCallResult(bool,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L219-L229) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L219-L229


 - [ ] ID-100
[AccessControlUpgradeable.__AccessControl_init_unchained()](@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L55-L56) is never used and should be removed

@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L55-L56


 - [ ] ID-101
[SafeERC20._callOptionalReturnBool(IERC20,bytes)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L134-L142) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L134-L142


 - [ ] ID-102
[AddressUpgradeable._revert(bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L231-L243) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L231-L243


 - [ ] ID-103
[Initializable._getInitializedVersion()](@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L156-L158) is never used and should be removed

@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L156-L158


 - [ ] ID-104
[SignedMathUpgradeable.average(int256,int256)](@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L28-L32) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L28-L32


 - [ ] ID-105
[AddressUpgradeable.functionDelegateCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L180-L187) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L180-L187


 - [ ] ID-106
[SafeERC20.forceApprove(IERC20,address,uint256)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L82-L89) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L82-L89


 - [ ] ID-107
[AccessControlUpgradeable._setupRole(bytes32,address)](@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L212-L214) is never used and should be removed

@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L212-L214


 - [ ] ID-108
[SafeERC20.safeDecreaseAllowance(IERC20,address,uint256)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L69-L75) is never used and should be removed

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L69-L75


 - [ ] ID-109
[SignedMathUpgradeable.abs(int256)](@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L37-L42) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L37-L42


 - [ ] ID-110
[AddressUpgradeable.functionStaticCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L155-L162) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L155-L162


 - [ ] ID-111
[Initializable._disableInitializers()](@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L145-L151) is never used and should be removed

@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L145-L151


 - [ ] ID-112
[SafeERC20Upgradeable.safeTransfer(IERC20Upgradeable,address,uint256)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L26-L28) is never used and should be removed

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L26-L28


 - [ ] ID-113
[Merkle.merkleizeSha256(bytes32[])](contracts/EigenLayer/libraries/Merkle.sol#L131-L155) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L131-L155


 - [ ] ID-114
[MathUpgradeable.log256(uint256,MathUpgradeable.Rounding)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L333-L338) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L333-L338


 - [ ] ID-115
[AddressUpgradeable.functionDelegateCall(address,bytes)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L170-L172) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L170-L172


 - [ ] ID-116
[Merkle.processInclusionProofSha256(bytes,bytes32,uint256)](contracts/EigenLayer/libraries/Merkle.sol#L100-L123) is never used and should be removed

contracts/EigenLayer/libraries/Merkle.sol#L100-L123


 - [ ] ID-117
[Address.functionStaticCall(address,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L155-L162) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L155-L162


 - [ ] ID-118
[MathUpgradeable.max(uint256,uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L19-L21) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L19-L21


 - [ ] ID-119
[BeaconChainProofs.verifyValidatorFields(uint40,bytes32,bytes,bytes32[])](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L153-L173) is never used and should be removed

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L153-L173


 - [ ] ID-120
[ContextUpgradeable.__Context_init()](@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L18-L19) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L18-L19


 - [ ] ID-121
[AddressUpgradeable.verifyCallResultFromTarget(address,bool,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L195-L211) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L195-L211


 - [ ] ID-122
[MathUpgradeable.log256(uint256)](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L303-L327) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L303-L327


 - [ ] ID-123
[AddressUpgradeable.functionCallWithValue(address,bytes,uint256,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L128-L137) is never used and should be removed

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L128-L137


 - [ ] ID-124
[Address.functionCall(address,bytes)](@openzeppelin/contracts/utils/Address.sol#L89-L91) is never used and should be removed

@openzeppelin/contracts/utils/Address.sol#L89-L91


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-125
Pragma version[0.8.19](contracts/Permissions/RoleManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Permissions/RoleManager.sol#L2


 - [ ] ID-126
Pragma version[0.8.19](contracts/Lock.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Lock.sol#L2


 - [ ] ID-127
Pragma version[0.8.19](contracts/token/EzEthTokenStorage.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/token/EzEthTokenStorage.sol#L2


 - [ ] ID-128
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L4


 - [ ] ID-129
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol#L4


 - [ ] ID-130
Pragma version[^0.8.9](contracts/token/IEzEthToken.sol#L2) allows old versions

contracts/token/IEzEthToken.sol#L2


 - [ ] ID-131
Pragma version[^0.8.2](@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol#L4


 - [ ] ID-132
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L4


 - [ ] ID-133
Pragma version[0.8.19](contracts/Deposits/DepositQueueStorage.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Deposits/DepositQueueStorage.sol#L2


 - [ ] ID-134
Pragma version[0.8.19](contracts/Delegation/IOperatorDelegator.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Delegation/IOperatorDelegator.sol#L2


 - [ ] ID-135
Pragma version[0.8.19](contracts/Errors/Errors.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Errors/Errors.sol#L2


 - [ ] ID-136
Pragma version[^0.8.0](@openzeppelin/contracts/token/ERC20/IERC20.sol#L4) allows old versions

@openzeppelin/contracts/token/ERC20/IERC20.sol#L4


 - [ ] ID-137
Pragma version[^0.8.0](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L4) allows old versions

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L4


 - [ ] ID-138
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/access/IAccessControlUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/access/IAccessControlUpgradeable.sol#L4


 - [ ] ID-139
Pragma version[0.8.19](contracts/Oracle/IRenzoOracle.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Oracle/IRenzoOracle.sol#L2


 - [ ] ID-140
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L4


 - [ ] ID-141
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IStrategy.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IStrategy.sol#L2


 - [ ] ID-142
Pragma version[=0.8.19](contracts/EigenLayer/libraries/Endian.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/libraries/Endian.sol#L2


 - [ ] ID-143
Pragma version[=0.8.19](contracts/Mock/EigenPodManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Mock/EigenPodManager.sol#L2


 - [ ] ID-144
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#L4


 - [ ] ID-145
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IEigenPod.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IEigenPod.sol#L2


 - [ ] ID-146
Pragma version[=0.8.19](contracts/Mock/StrategyManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Mock/StrategyManager.sol#L2


 - [ ] ID-147
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IPausable.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IPausable.sol#L2


 - [ ] ID-148
Pragma version[^0.8.0](@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#L2) allows old versions

@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#L2


 - [ ] ID-149
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IStrategyManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IStrategyManager.sol#L2


 - [ ] ID-150
Pragma version[^0.8.0](@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4) allows old versions

@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4


 - [ ] ID-151
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IEigenPodManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IEigenPodManager.sol#L2


 - [ ] ID-152
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/utils/math/SignedMathUpgradeable.sol#L4


 - [ ] ID-153
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol#L4


 - [ ] ID-154
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L4


 - [ ] ID-155
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IPauserRegistry.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IPauserRegistry.sol#L2


 - [ ] ID-156
Pragma version[^0.8.1](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L4


 - [ ] ID-157
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L4


 - [ ] ID-158
Pragma version[0.8.19](contracts/Delegation/OperatorDelegator.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Delegation/OperatorDelegator.sol#L2


 - [ ] ID-159
Pragma version[^0.8.1](@openzeppelin/contracts/utils/Address.sol#L4) allows old versions

@openzeppelin/contracts/utils/Address.sol#L4


 - [ ] ID-160
Pragma version[^0.8.9](contracts/token/EzEthToken.sol#L2) allows old versions

contracts/token/EzEthToken.sol#L2


 - [ ] ID-161
Pragma version[^0.8.0](@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L4) allows old versions

@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L4


 - [ ] ID-162
Pragma version[0.8.19](contracts/Deposits/DepositQueue.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Deposits/DepositQueue.sol#L2


 - [ ] ID-163
Pragma version[=0.8.19](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L3


 - [ ] ID-164
Pragma version[0.8.19](contracts/Permissions/IRoleManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Permissions/IRoleManager.sol#L2


 - [ ] ID-165
Pragma version[0.8.19](contracts/RestakeManagerStorage.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/RestakeManagerStorage.sol#L2


 - [ ] ID-166
Pragma version[=0.8.19](contracts/Mock/DelegationManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Mock/DelegationManager.sol#L2


 - [ ] ID-167
Pragma version[0.8.19](contracts/IRestakeManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/IRestakeManager.sol#L2


 - [ ] ID-168
Pragma version[0.8.19](contracts/Permissions/RoleManagerStorage.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Permissions/RoleManagerStorage.sol#L2


 - [ ] ID-169
solc-0.8.19 is not recommended for deployment

 - [ ] ID-170
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/ISlasher.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/ISlasher.sol#L2


 - [ ] ID-171
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/utils/math/MathUpgradeable.sol#L4


 - [ ] ID-172
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IDelayedWithdrawalRouter.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IDelayedWithdrawalRouter.sol#L2


 - [ ] ID-173
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IDelegationTerms.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IDelegationTerms.sol#L2


 - [ ] ID-174
Pragma version[0.8.19](contracts/Delegation/OperatorDelegatorStorage.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Delegation/OperatorDelegatorStorage.sol#L2


 - [ ] ID-175
Pragma version[0.8.19](contracts/Deposits/IDepositQueue.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Deposits/IDepositQueue.sol#L2


 - [ ] ID-176
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IBeaconChainOracle.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IBeaconChainOracle.sol#L2


 - [ ] ID-177
Pragma version[0.8.19](contracts/Mock/ERC20Faucet.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Mock/ERC20Faucet.sol#L2


 - [ ] ID-178
Pragma version[0.8.19](contracts/RestakeManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/RestakeManager.sol#L2


 - [ ] ID-179
Pragma version[0.8.19](contracts/Oracle/RenzoOracleStorage.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Oracle/RenzoOracleStorage.sol#L2


 - [ ] ID-180
Pragma version[=0.8.19](contracts/EigenLayer/libraries/Merkle.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/libraries/Merkle.sol#L4


 - [ ] ID-181
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/utils/introspection/IERC165Upgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/utils/introspection/IERC165Upgradeable.sol#L4


 - [ ] ID-182
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L4


 - [ ] ID-183
Pragma version[0.8.19](contracts/Oracle/RenzoOracle.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/Oracle/RenzoOracle.sol#L2


 - [ ] ID-184
Pragma version[^0.8.0](@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L4) allows old versions

@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol#L4


 - [ ] ID-185
Pragma version[>=0.4.22<0.9.0](node_modules/hardhat/console.sol#L2) is too complex

node_modules/hardhat/console.sol#L2


 - [ ] ID-186
Pragma version[=0.8.19](contracts/EigenLayer/interfaces/IDelegationManager.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

contracts/EigenLayer/interfaces/IDelegationManager.sol#L2


## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-187
Low level call in [Address.functionStaticCall(address,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L155-L162):
	- [(success,returndata) = target.staticcall(data)](@openzeppelin/contracts/utils/Address.sol#L160)

@openzeppelin/contracts/utils/Address.sol#L155-L162


 - [ ] ID-188
Low level call in [Address.functionDelegateCall(address,bytes,string)](@openzeppelin/contracts/utils/Address.sol#L180-L187):
	- [(success,returndata) = target.delegatecall(data)](@openzeppelin/contracts/utils/Address.sol#L185)

@openzeppelin/contracts/utils/Address.sol#L180-L187


 - [ ] ID-189
Low level call in [Address.sendValue(address,uint256)](@openzeppelin/contracts/utils/Address.sol#L64-L69):
	- [(success) = recipient.call{value: amount}()](@openzeppelin/contracts/utils/Address.sol#L67)

@openzeppelin/contracts/utils/Address.sol#L64-L69


 - [ ] ID-190
Low level call in [AddressUpgradeable.sendValue(address,uint256)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L64-L69):
	- [(success) = recipient.call{value: amount}()](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L67)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L64-L69


 - [ ] ID-191
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](@openzeppelin/contracts/utils/Address.sol#L128-L137):
	- [(success,returndata) = target.call{value: value}(data)](@openzeppelin/contracts/utils/Address.sol#L135)

@openzeppelin/contracts/utils/Address.sol#L128-L137


 - [ ] ID-192
Low level call in [AddressUpgradeable.functionDelegateCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L180-L187):
	- [(success,returndata) = target.delegatecall(data)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L185)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L180-L187


 - [ ] ID-193
Low level call in [SafeERC20Upgradeable._callOptionalReturnBool(IERC20Upgradeable,bytes)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L134-L142):
	- [(success,returndata) = address(token).call(data)](@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L139)

@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol#L134-L142


 - [ ] ID-194
Low level call in [AddressUpgradeable.functionStaticCall(address,bytes,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L155-L162):
	- [(success,returndata) = target.staticcall(data)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L160)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L155-L162


 - [ ] ID-195
Low level call in [OperatorDelegator.receive()](contracts/Delegation/OperatorDelegator.sol#L316-L335):
	- [(success) = destination.call{value: msg.value}()](contracts/Delegation/OperatorDelegator.sol#L331)

contracts/Delegation/OperatorDelegator.sol#L316-L335


 - [ ] ID-196
Low level call in [DepositQueue.receive()](contracts/Deposits/DepositQueue.sol#L130-L148):
	- [(success) = feeAddress.call{value: feeAmount}()](contracts/Deposits/DepositQueue.sol#L136)

contracts/Deposits/DepositQueue.sol#L130-L148


 - [ ] ID-197
Low level call in [AddressUpgradeable.functionCallWithValue(address,bytes,uint256,string)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L128-L137):
	- [(success,returndata) = target.call{value: value}(data)](@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L135)

@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol#L128-L137


 - [ ] ID-198
Low level call in [SafeERC20._callOptionalReturnBool(IERC20,bytes)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L134-L142):
	- [(success,returndata) = address(token).call(data)](@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L139)

@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol#L134-L142


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-199
Parameter [RestakeManager.deposit(IERC20,uint256,uint256)._amount](contracts/RestakeManager.sol#L545) is not in mixedCase

contracts/RestakeManager.sol#L545


 - [ ] ID-200
Parameter [RestakeManager.depositETH(uint256)._referralId](contracts/RestakeManager.sol#L642) is not in mixedCase

contracts/RestakeManager.sol#L642


 - [ ] ID-201
Parameter [OperatorDelegator.completeWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20,uint256,address)._middlewareTimesIndex](contracts/Delegation/OperatorDelegator.sol#L218) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L218


 - [ ] ID-202
Function [IERC20PermitUpgradeable.DOMAIN_SEPARATOR()](@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L59) is not in mixedCase

@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20PermitUpgradeable.sol#L59


 - [ ] ID-203
Parameter [RestakeManager.addOperatorDelegator(IOperatorDelegator,uint256)._newOperatorDelegator](contracts/RestakeManager.sol#L149) is not in mixedCase

contracts/RestakeManager.sol#L149


 - [ ] ID-204
Enum [IEigenPod.PARTIAL_WITHDRAWAL_CLAIM_STATUS](contracts/EigenLayer/interfaces/IEigenPod.sol#L46-L50) is not in CapWords

contracts/EigenLayer/interfaces/IEigenPod.sol#L46-L50


 - [ ] ID-205
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._renzoOracle](contracts/RestakeManager.sol#L112) is not in mixedCase

contracts/RestakeManager.sol#L112


 - [ ] ID-206
Function [AccessControlUpgradeable.__AccessControl_init_unchained()](@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L55-L56) is not in mixedCase

@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L55-L56


 - [ ] ID-207
Parameter [OperatorDelegator.setTokenStrategy(IERC20,IStrategy)._strategy](contracts/Delegation/OperatorDelegator.sol#L97) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L97


 - [ ] ID-208
Parameter [OperatorDelegator.completeWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20,uint256,address)._withdrawal](contracts/Delegation/OperatorDelegator.sol#L216) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L216


 - [ ] ID-209
Parameter [RestakeManager.setMaxDepositTVL(uint256)._maxDepositTVL](contracts/RestakeManager.sol#L266) is not in mixedCase

contracts/RestakeManager.sol#L266


 - [ ] ID-210
Parameter [RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)._amount](contracts/RestakeManager.sol#L696) is not in mixedCase

contracts/RestakeManager.sol#L696


 - [ ] ID-211
Parameter [RestakeManager.depositTokenRewardsFromProtocol(IERC20,uint256)._token](contracts/RestakeManager.sol#L695) is not in mixedCase

contracts/RestakeManager.sol#L695


 - [ ] ID-212
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._ezETH](contracts/RestakeManager.sol#L111) is not in mixedCase

contracts/RestakeManager.sol#L111


 - [ ] ID-213
Function [IEigenPod.REQUIRED_BALANCE_WEI()](contracts/EigenLayer/interfaces/IEigenPod.sol#L56) is not in mixedCase

contracts/EigenLayer/interfaces/IEigenPod.sol#L56


 - [ ] ID-214
Parameter [OperatorDelegator.completeWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20,uint256,address)._sendToAddress](contracts/Delegation/OperatorDelegator.sol#L219) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L219


 - [ ] ID-215
Parameter [OperatorDelegator.completeWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20,uint256,address)._token](contracts/Delegation/OperatorDelegator.sol#L217) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L217


 - [ ] ID-216
Parameter [OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._eigenPodManager](contracts/Delegation/OperatorDelegator.sol#L70) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L70


 - [ ] ID-217
Variable [ContextUpgradeable.__gap](@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L36) is not in mixedCase

@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L36


 - [ ] ID-218
Parameter [RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._allocationBasisPoints](contracts/RestakeManager.sol#L233) is not in mixedCase

contracts/RestakeManager.sol#L233


 - [ ] ID-219
Parameter [OperatorDelegator.startWithdrawal(IERC20,uint256)._tokenAmount](contracts/Delegation/OperatorDelegator.sol#L169) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L169


 - [ ] ID-220
Function [ReentrancyGuardUpgradeable.__ReentrancyGuard_init_unchained()](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L44-L46) is not in mixedCase

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L44-L46


 - [ ] ID-221
Variable [AccessControlUpgradeable.__gap](@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L260) is not in mixedCase

@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L260


 - [ ] ID-222
Parameter [OperatorDelegator.getStrategyIndex(IStrategy)._strategy](contracts/Delegation/OperatorDelegator.sol#L149) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L149


 - [ ] ID-223
Parameter [RestakeManager.setTokenTvlLimit(IERC20,uint256)._token](contracts/RestakeManager.sol#L761) is not in mixedCase

contracts/RestakeManager.sol#L761


 - [ ] ID-224
Parameter [RestakeManager.getCollateralTokenIndex(IERC20)._collateralToken](contracts/RestakeManager.sol#L499) is not in mixedCase

contracts/RestakeManager.sol#L499


 - [ ] ID-225
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._depositQueue](contracts/RestakeManager.sol#L115) is not in mixedCase

contracts/RestakeManager.sol#L115


 - [ ] ID-226
Parameter [RenzoOracle.calculateRedeemAmount(uint256,uint256,uint256)._currentValueInProtocol](contracts/Oracle/RenzoOracle.sol#L156) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L156


 - [ ] ID-227
Parameter [RenzoOracle.lookupTokenAmountFromValue(IERC20,uint256)._token](contracts/Oracle/RenzoOracle.sol#L97) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L97


 - [ ] ID-228
Contract [console](node_modules/hardhat/console.sol#L4-L1552) is not in CapWords

node_modules/hardhat/console.sol#L4-L1552


 - [ ] ID-229
Parameter [RestakeManager.deposit(IERC20,uint256)._amount](contracts/RestakeManager.sol#L524) is not in mixedCase

contracts/RestakeManager.sol#L524


 - [ ] ID-230
Parameter [RenzoOracle.lookupTokenValues(IERC20[],uint256[])._balances](contracts/Oracle/RenzoOracle.sol#L115) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L115


 - [ ] ID-231
Parameter [RenzoOracle.lookupTokenValue(IERC20,uint256)._token](contracts/Oracle/RenzoOracle.sol#L73) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L73


 - [ ] ID-232
Parameter [OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._roleManager](contracts/Delegation/OperatorDelegator.sol#L66) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L66


 - [ ] ID-233
Function [ERC20Upgradeable.__ERC20_init_unchained(string,string)](@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#L59-L62) is not in mixedCase

@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#L59-L62


 - [ ] ID-234
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._roleManager](contracts/RestakeManager.sol#L110) is not in mixedCase

contracts/RestakeManager.sol#L110


 - [ ] ID-235
Parameter [RestakeManager.setPaused(bool)._paused](contracts/RestakeManager.sol#L130) is not in mixedCase

contracts/RestakeManager.sol#L130


 - [ ] ID-236
Parameter [RestakeManager.deposit(IERC20,uint256)._collateralToken](contracts/RestakeManager.sol#L523) is not in mixedCase

contracts/RestakeManager.sol#L523


 - [ ] ID-237
Parameter [OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._strategyManager](contracts/Delegation/OperatorDelegator.sol#L67) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L67


 - [ ] ID-238
Contract [baseEigenPodManager](contracts/Mock/EigenPodManager.sol#L15-L181) is not in CapWords

contracts/Mock/EigenPodManager.sol#L15-L181


 - [ ] ID-239
Parameter [DepositQueue.setFeeConfig(address,uint256)._feeAddress](contracts/Deposits/DepositQueue.sol#L87) is not in mixedCase

contracts/Deposits/DepositQueue.sol#L87


 - [ ] ID-240
Function [ERC20Upgradeable.__ERC20_init(string,string)](@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#L55-L57) is not in mixedCase

@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#L55-L57


 - [ ] ID-241
Function [ReentrancyGuardUpgradeable.__ReentrancyGuard_init()](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L40-L42) is not in mixedCase

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L40-L42


 - [ ] ID-242
Parameter [RestakeManager.removeCollateralToken(IERC20)._collateralTokenToRemove](contracts/RestakeManager.sol#L303) is not in mixedCase

contracts/RestakeManager.sol#L303


 - [ ] ID-243
Parameter [RenzoOracle.setOracleAddress(IERC20,AggregatorV3Interface)._token](contracts/Oracle/RenzoOracle.sol#L60) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L60


 - [ ] ID-244
Function [ERC165Upgradeable.__ERC165_init_unchained()](@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L27-L28) is not in mixedCase

@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L27-L28


 - [ ] ID-245
Function [ContextUpgradeable.__Context_init_unchained()](@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L21-L22) is not in mixedCase

@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L21-L22


 - [ ] ID-246
Parameter [EzEthToken.setPaused(bool)._paused](contracts/token/EzEthToken.sol#L56) is not in mixedCase

contracts/token/EzEthToken.sol#L56


 - [ ] ID-247
Parameter [OperatorDelegator.startWithdrawal(IERC20,uint256)._token](contracts/Delegation/OperatorDelegator.sol#L168) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L168


 - [ ] ID-248
Parameter [RenzoOracle.setOracleAddress(IERC20,AggregatorV3Interface)._oracleAddress](contracts/Oracle/RenzoOracle.sol#L60) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L60


 - [ ] ID-249
Parameter [OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._restakeManager](contracts/Delegation/OperatorDelegator.sol#L68) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L68


 - [ ] ID-250
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._strategyManager](contracts/RestakeManager.sol#L113) is not in mixedCase

contracts/RestakeManager.sol#L113


 - [ ] ID-251
Variable [ERC20Upgradeable.__gap](@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#L376) is not in mixedCase

@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol#L376


 - [ ] ID-252
Variable [ReentrancyGuardUpgradeable.__gap](@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L88) is not in mixedCase

@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol#L88


 - [ ] ID-253
Parameter [OperatorDelegator.deposit(IERC20,uint256)._tokenAmount](contracts/Delegation/OperatorDelegator.sol#L128) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L128


 - [ ] ID-254
Function [IERC20Permit.DOMAIN_SEPARATOR()](@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L59) is not in mixedCase

@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol#L59


 - [ ] ID-255
Parameter [RenzoOracle.calculateMintAmount(uint256,uint256,uint256)._newValueAdded](contracts/Oracle/RenzoOracle.sol#L132) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L132


 - [ ] ID-256
Function [AccessControlUpgradeable.__AccessControl_init()](@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L52-L53) is not in mixedCase

@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol#L52-L53


 - [ ] ID-257
Parameter [DepositQueue.initialize(IRoleManager)._roleManager](contracts/Deposits/DepositQueue.sol#L77) is not in mixedCase

contracts/Deposits/DepositQueue.sol#L77


 - [ ] ID-258
Parameter [OperatorDelegator.initialize(IRoleManager,IStrategyManager,IRestakeManager,IDelegationManager,IEigenPodManager)._delegationManager](contracts/Delegation/OperatorDelegator.sol#L69) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L69


 - [ ] ID-259
Parameter [OperatorDelegator.setTokenStrategy(IERC20,IStrategy)._token](contracts/Delegation/OperatorDelegator.sol#L96) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L96


 - [ ] ID-260
Function [IEigenPod.REQUIRED_BALANCE_GWEI()](contracts/EigenLayer/interfaces/IEigenPod.sol#L53) is not in mixedCase

contracts/EigenLayer/interfaces/IEigenPod.sol#L53


 - [ ] ID-261
Parameter [RestakeManager.initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue)._delegationManager](contracts/RestakeManager.sol#L114) is not in mixedCase

contracts/RestakeManager.sol#L114


 - [ ] ID-262
Parameter [DepositQueue.setRestakeManager(IRestakeManager)._restakeManager](contracts/Deposits/DepositQueue.sol#L106) is not in mixedCase

contracts/Deposits/DepositQueue.sol#L106


 - [ ] ID-263
Parameter [EzEthToken.initialize(IRoleManager)._roleManager](contracts/token/EzEthToken.sol#L38) is not in mixedCase

contracts/token/EzEthToken.sol#L38


 - [ ] ID-264
Parameter [RestakeManager.deposit(IERC20,uint256,uint256)._referralId](contracts/RestakeManager.sol#L546) is not in mixedCase

contracts/RestakeManager.sol#L546


 - [ ] ID-265
Enum [IEigenPod.VALIDATOR_STATUS](contracts/EigenLayer/interfaces/IEigenPod.sol#L28-L33) is not in CapWords

contracts/EigenLayer/interfaces/IEigenPod.sol#L28-L33


 - [ ] ID-266
Parameter [RestakeManager.setTokenTvlLimit(IERC20,uint256)._limit](contracts/RestakeManager.sol#L761) is not in mixedCase

contracts/RestakeManager.sol#L761


 - [ ] ID-267
Variable [ERC165Upgradeable.__gap](@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L41) is not in mixedCase

@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L41


 - [ ] ID-268
Parameter [RenzoOracle.calculateMintAmount(uint256,uint256,uint256)._currentValueInProtocol](contracts/Oracle/RenzoOracle.sol#L132) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L132


 - [ ] ID-269
Parameter [RenzoOracle.lookupTokenValues(IERC20[],uint256[])._tokens](contracts/Oracle/RenzoOracle.sol#L115) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L115


 - [ ] ID-270
Parameter [RestakeManager.removeOperatorDelegator(IOperatorDelegator)._operatorDelegatorToRemove](contracts/RestakeManager.sol#L191) is not in mixedCase

contracts/RestakeManager.sol#L191


 - [ ] ID-271
Parameter [OperatorDelegator.deposit(IERC20,uint256)._token](contracts/Delegation/OperatorDelegator.sol#L127) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L127


 - [ ] ID-272
Parameter [RenzoOracle.lookupTokenAmountFromValue(IERC20,uint256)._value](contracts/Oracle/RenzoOracle.sol#L97) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L97


 - [ ] ID-273
Parameter [RenzoOracle.initialize(IRoleManager)._roleManager](contracts/Oracle/RenzoOracle.sol#L48) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L48


 - [ ] ID-274
Parameter [RenzoOracle.lookupTokenValue(IERC20,uint256)._balance](contracts/Oracle/RenzoOracle.sol#L73) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L73


 - [ ] ID-275
Parameter [DepositQueue.setFeeConfig(address,uint256)._feeBasisPoints](contracts/Deposits/DepositQueue.sol#L87) is not in mixedCase

contracts/Deposits/DepositQueue.sol#L87


 - [ ] ID-276
Parameter [OperatorDelegator.setDelegateAddress(address)._delegateAddress](contracts/Delegation/OperatorDelegator.sol#L108) is not in mixedCase

contracts/Delegation/OperatorDelegator.sol#L108


 - [ ] ID-277
Parameter [RenzoOracle.calculateRedeemAmount(uint256,uint256,uint256)._existingEzETHSupply](contracts/Oracle/RenzoOracle.sol#L156) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L156


 - [ ] ID-278
Parameter [RenzoOracle.calculateRedeemAmount(uint256,uint256,uint256)._ezETHBeingBurned](contracts/Oracle/RenzoOracle.sol#L156) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L156


 - [ ] ID-279
Parameter [RenzoOracle.calculateMintAmount(uint256,uint256,uint256)._existingEzETHSupply](contracts/Oracle/RenzoOracle.sol#L132) is not in mixedCase

contracts/Oracle/RenzoOracle.sol#L132


 - [ ] ID-280
Function [ContextUpgradeable.__Context_init()](@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L18-L19) is not in mixedCase

@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol#L18-L19


 - [ ] ID-281
Parameter [RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._operatorDelegator](contracts/RestakeManager.sol#L232) is not in mixedCase

contracts/RestakeManager.sol#L232


 - [ ] ID-282
Function [ERC165Upgradeable.__ERC165_init()](@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L24-L25) is not in mixedCase

@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol#L24-L25


 - [ ] ID-283
Parameter [RestakeManager.deposit(IERC20,uint256,uint256)._collateralToken](contracts/RestakeManager.sol#L544) is not in mixedCase

contracts/RestakeManager.sol#L544


 - [ ] ID-284
Parameter [RestakeManager.addOperatorDelegator(IOperatorDelegator,uint256)._allocationBasisPoints](contracts/RestakeManager.sol#L150) is not in mixedCase

contracts/RestakeManager.sol#L150


 - [ ] ID-285
Parameter [RestakeManager.addCollateralToken(IERC20)._newCollateralToken](contracts/RestakeManager.sol#L276) is not in mixedCase

contracts/RestakeManager.sol#L276


## similar-names
Impact: Informational
Confidence: Medium
 - [ ] ID-286
Variable [RestakeManager.getCollateralTokenIndex(IERC20)._collateralToken](contracts/RestakeManager.sol#L499) is too similar to [RestakeManagerStorageV1.collateralTokens](contracts/RestakeManagerStorage.sol#L57)

contracts/RestakeManager.sol#L499


 - [ ] ID-287
Variable [RestakeManager.deposit(IERC20,uint256,uint256)._collateralToken](contracts/RestakeManager.sol#L544) is too similar to [RestakeManagerStorageV1.collateralTokens](contracts/RestakeManagerStorage.sol#L57)

contracts/RestakeManager.sol#L544


 - [ ] ID-288
Variable [RestakeManager.deposit(IERC20,uint256)._collateralToken](contracts/RestakeManager.sol#L523) is too similar to [RestakeManagerStorageV1.collateralTokens](contracts/RestakeManagerStorage.sol#L57)

contracts/RestakeManager.sol#L523


 - [ ] ID-289
Variable [RestakeManager.setOperatorDelegatorAllocation(IOperatorDelegator,uint256)._operatorDelegator](contracts/RestakeManager.sol#L232) is too similar to [RestakeManagerStorageV1.operatorDelegators](contracts/RestakeManagerStorage.sol#L48)

contracts/RestakeManager.sol#L232


## too-many-digits
Impact: Informational
Confidence: Medium
 - [ ] ID-290
[Endian.fromLittleEndianUint64(bytes32)](contracts/EigenLayer/libraries/Endian.sol#L12-L26) uses literals with too many digits:
	- [(n >> 56) | ((0x00FF000000000000 & n) >> 40) | ((0x0000FF0000000000 & n) >> 24) | ((0x000000FF00000000 & n) >> 8) | ((0x00000000FF000000 & n) << 8) | ((0x0000000000FF0000 & n) << 24) | ((0x000000000000FF00 & n) << 40) | ((0x00000000000000FF & n) << 56)](contracts/EigenLayer/libraries/Endian.sol#L17-L25)

contracts/EigenLayer/libraries/Endian.sol#L12-L26


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-291
[BeaconChainProofs.VALIDATOR_WITHDRAWAL_CREDENTIALS_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L78) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L78


 - [ ] ID-292
[BeaconChainProofs.NUM_BEACON_BLOCK_BODY_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L17) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L17


 - [ ] ID-293
[BeaconChainProofs.ETH_1_ROOT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L71) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L71


 - [ ] ID-294
[BeaconChainProofs.STATE_ROOTS_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L44) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L44


 - [ ] ID-295
[BeaconChainProofs.WITHDRAWALS_ROOT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L85) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L85


 - [ ] ID-296
[BeaconChainProofs.EXECUTION_PAYLOAD_FIELD_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L34) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L34


 - [ ] ID-297
[BeaconChainProofs.PROPOSER_INDEX_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L64) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L64


 - [ ] ID-298
[BeaconChainProofs.WITHDRAWAL_VALIDATOR_AMOUNT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L92) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L92


 - [ ] ID-299
[BeaconChainProofs.VALIDATOR_BALANCE_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L79) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L79


 - [ ] ID-300
[BeaconChainProofs.EXECUTION_PAYLOAD_HEADER_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L74) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L74


 - [ ] ID-301
[BeaconChainProofs.VALIDATOR_WITHDRAWABLE_EPOCH_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L81) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L81


 - [ ] ID-302
[BeaconChainProofs.STATE_ROOT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L63) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L63


 - [ ] ID-303
[BeaconChainProofs.NUM_VALIDATOR_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L26) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L26


 - [ ] ID-304
[BeaconChainProofs.NUM_WITHDRAWAL_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L48) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L48


 - [ ] ID-305
[BeaconChainProofs.HISTORICALBATCH_STATEROOTS_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L95) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L95


 - [ ] ID-306
[BeaconChainProofs.UINT64_MASK](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L100) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L100


 - [ ] ID-307
[BeaconChainProofs.VALIDATOR_SLASHED_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L80) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L80


 - [ ] ID-308
[BeaconChainProofs.HISTORICAL_BATCH_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L41) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L41


 - [ ] ID-309
[BeaconChainProofs.HISTORICAL_BATCH_STATE_ROOT_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L75) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L75


 - [ ] ID-310
[BeaconChainProofs.HISTORICAL_ROOTS_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L70) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L70


 - [ ] ID-311
[RenzoOracle.INVALID_0_INPUT](contracts/Oracle/RenzoOracle.sol#L24) is never used in [RenzoOracle](contracts/Oracle/RenzoOracle.sol#L13-L166)

contracts/Oracle/RenzoOracle.sol#L24


 - [ ] ID-312
[BeaconChainProofs.WITHDRAWAL_VALIDATOR_INDEX_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L91) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L91


 - [ ] ID-313
[BeaconChainProofs.STATE_ROOTS_INDEX](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L68) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L68


 - [ ] ID-314
[BeaconChainProofs.HISTORICAL_ROOTS_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L38) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L38


 - [ ] ID-315
[BeaconChainProofs.SLOTS_PER_EPOCH](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L98) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L98


 - [ ] ID-316
[BeaconChainProofs.ETH1_DATA_FIELD_TREE_HEIGHT](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L24) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L24


 - [ ] ID-317
[BeaconChainProofs.NUM_BEACON_BLOCK_HEADER_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L14) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L14


 - [ ] ID-318
[BeaconChainProofs.NUM_ETH1_DATA_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L23) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L23


 - [ ] ID-319
[BeaconChainProofs.NUM_EXECUTION_PAYLOAD_HEADER_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L29) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L29


 - [ ] ID-320
[BeaconChainProofs.NUM_EXECUTION_PAYLOAD_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L33) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

contracts/EigenLayer/libraries/BeaconChainProofs.sol#L33


 - [ ] ID-321
[BeaconChainProofs.NUM_BEACON_STATE_FIELDS](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L20) is never used in [BeaconChainProofs](contracts/EigenLayer/libraries/BeaconChainProofs.sol#L12-L264)

INFO:Slither:. analyzed (65 contracts with 88 detectors), 327 result(s) found
contracts/EigenLayer/libraries/BeaconChainProofs.sol#L20


## constable-states
Impact: Optimization
Confidence: High
 - [ ] ID-322
[ERC20Faucet.name](contracts/Mock/ERC20Faucet.sol#L10) should be constant 

contracts/Mock/ERC20Faucet.sol#L10


 - [ ] ID-323
[ERC20Faucet.decimals](contracts/Mock/ERC20Faucet.sol#L12) should be constant 

contracts/Mock/ERC20Faucet.sol#L12


 - [ ] ID-324
[ERC20Faucet.symbol](contracts/Mock/ERC20Faucet.sol#L11) should be constant 

contracts/Mock/ERC20Faucet.sol#L11


## immutable-states
Impact: Optimization
Confidence: High
 - [ ] ID-325
[Lock.unlockTime](contracts/Lock.sol#L8) should be immutable 

contracts/Lock.sol#L8


 - [ ] ID-326
[Lock.owner](contracts/Lock.sol#L9) should be immutable 

contracts/Lock.sol#L9


