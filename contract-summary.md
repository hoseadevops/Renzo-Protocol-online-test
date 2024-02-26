 slither contracts/RestakeManager.sol --print contract-summary
'solc --version' running
'solc contracts/RestakeManager.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --allow-paths .,/Users/hosea/work/audit/evaluate/Renzo-Protocol-online/contracts' running
INFO:Printers:
+ Contract Initializable
  - From Initializable
    - _disableInitializers() (internal)
    - _getInitializedVersion() (internal)
    - _isInitializing() (internal)

+ Contract ReentrancyGuardUpgradeable (Upgradeable)
  - From Initializable
    - _disableInitializers() (internal)
    - _getInitializedVersion() (internal)
    - _isInitializing() (internal)
  - From ReentrancyGuardUpgradeable
    - __ReentrancyGuard_init() (internal)
    - __ReentrancyGuard_init_unchained() (internal)
    - _nonReentrantAfter() (private)
    - _nonReentrantBefore() (private)
    - _reentrancyGuardEntered() (internal)

+ Contract IERC20Upgradeable (Upgradeable)
  - From IERC20Upgradeable
    - allowance(address,address) (external)
    - approve(address,uint256) (external)
    - balanceOf(address) (external)
    - totalSupply() (external)
    - transfer(address,uint256) (external)
    - transferFrom(address,address,uint256) (external)

+ Contract IERC20PermitUpgradeable (Upgradeable) (Most derived contract)
  - From IERC20PermitUpgradeable
    - DOMAIN_SEPARATOR() (external)
    - nonces(address) (external)
    - permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (external)

+ Contract SafeERC20Upgradeable (Upgradeable) (Most derived contract)
  - From SafeERC20Upgradeable
    - _callOptionalReturn(IERC20Upgradeable,bytes) (private)
    - _callOptionalReturnBool(IERC20Upgradeable,bytes) (private)
    - forceApprove(IERC20Upgradeable,address,uint256) (internal)
    - safeApprove(IERC20Upgradeable,address,uint256) (internal)
    - safeDecreaseAllowance(IERC20Upgradeable,address,uint256) (internal)
    - safeIncreaseAllowance(IERC20Upgradeable,address,uint256) (internal)
    - safePermit(IERC20PermitUpgradeable,address,address,uint256,uint256,uint8,bytes32,bytes32) (internal)
    - safeTransfer(IERC20Upgradeable,address,uint256) (internal)
    - safeTransferFrom(IERC20Upgradeable,address,address,uint256) (internal)

+ Contract AddressUpgradeable (Upgradeable) (Most derived contract)
  - From AddressUpgradeable
    - _revert(bytes,string) (private)
    - functionCall(address,bytes) (internal)
    - functionCall(address,bytes,string) (internal)
    - functionCallWithValue(address,bytes,uint256) (internal)
    - functionCallWithValue(address,bytes,uint256,string) (internal)
    - functionDelegateCall(address,bytes) (internal)
    - functionDelegateCall(address,bytes,string) (internal)
    - functionStaticCall(address,bytes) (internal)
    - functionStaticCall(address,bytes,string) (internal)
    - isContract(address) (internal)
    - sendValue(address,uint256) (internal)
    - verifyCallResult(bool,bytes,string) (internal)
    - verifyCallResultFromTarget(address,bool,bytes,string) (internal)

+ Contract IERC20
  - From IERC20
    - allowance(address,address) (external)
    - approve(address,uint256) (external)
    - balanceOf(address) (external)
    - totalSupply() (external)
    - transfer(address,uint256) (external)
    - transferFrom(address,address,uint256) (external)

+ Contract IERC20Metadata (Most derived contract)
  - From IERC20
    - allowance(address,address) (external)
    - approve(address,uint256) (external)
    - balanceOf(address) (external)
    - totalSupply() (external)
    - transfer(address,uint256) (external)
    - transferFrom(address,address,uint256) (external)
  - From IERC20Metadata
    - decimals() (external)
    - name() (external)
    - symbol() (external)

+ Contract IERC20Permit (Most derived contract)
  - From IERC20Permit
    - DOMAIN_SEPARATOR() (external)
    - nonces(address) (external)
    - permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (external)

+ Contract SafeERC20 (Most derived contract)
  - From SafeERC20
    - _callOptionalReturn(IERC20,bytes) (private)
    - _callOptionalReturnBool(IERC20,bytes) (private)
    - forceApprove(IERC20,address,uint256) (internal)
    - safeApprove(IERC20,address,uint256) (internal)
    - safeDecreaseAllowance(IERC20,address,uint256) (internal)
    - safeIncreaseAllowance(IERC20,address,uint256) (internal)
    - safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32) (internal)
    - safeTransfer(IERC20,address,uint256) (internal)
    - safeTransferFrom(IERC20,address,address,uint256) (internal)

+ Contract Address (Most derived contract)
  - From Address
    - _revert(bytes,string) (private)
    - functionCall(address,bytes) (internal)
    - functionCall(address,bytes,string) (internal)
    - functionCallWithValue(address,bytes,uint256) (internal)
    - functionCallWithValue(address,bytes,uint256,string) (internal)
    - functionDelegateCall(address,bytes) (internal)
    - functionDelegateCall(address,bytes,string) (internal)
    - functionStaticCall(address,bytes) (internal)
    - functionStaticCall(address,bytes,string) (internal)
    - isContract(address) (internal)
    - sendValue(address,uint256) (internal)
    - verifyCallResult(bool,bytes,string) (internal)
    - verifyCallResultFromTarget(address,bool,bytes,string) (internal)

+ Contract IOperatorDelegator (Most derived contract)
  - From IOperatorDelegator
    - completeWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20,uint256,address) (external)
    - deposit(IERC20,uint256) (external)
    - eigenPod() (external)
    - getStakedETHBalance() (external)
    - getTokenBalanceFromStrategy(IERC20) (external)
    - pendingUnstakedDelayedWithdrawalAmount() (external)
    - stakeEth(bytes,bytes,bytes32) (external)
    - startWithdrawal(IERC20,uint256) (external)

+ Contract IDepositQueue (Most derived contract)
  - From IDepositQueue
    - depositETHFromProtocol() (external)
    - totalEarned(address) (external)

+ Contract IBeaconChainOracle (Most derived contract)
  - From IBeaconChainOracle
    - addOracleSigners(address[]) (external)
    - beaconStateRootAtBlockNumber(uint64) (external)
    - hasVoted(uint64,address) (external)
    - isOracleSigner(address) (external)
    - latestConfirmedOracleBlockNumber() (external)
    - removeOracleSigners(address[]) (external)
    - setThreshold(uint256) (external)
    - stateRootVotes(uint64,bytes32) (external)
    - threshold() (external)
    - totalOracleSigners() (external)
    - voteForBeaconChainStateRoot(uint64,bytes32) (external)

+ Contract IDelayedWithdrawalRouter (Most derived contract)
  - From IDelayedWithdrawalRouter
    - canClaimDelayedWithdrawal(address,uint256) (external)
    - claimDelayedWithdrawals(address,uint256) (external)
    - claimDelayedWithdrawals(uint256) (external)
    - createDelayedWithdrawal(address,address) (external)
    - getClaimableUserDelayedWithdrawals(address) (external)
    - getUserDelayedWithdrawals(address) (external)
    - setWithdrawalDelayBlocks(uint256) (external)
    - userDelayedWithdrawalByIndex(address,uint256) (external)
    - userWithdrawals(address) (external)
    - userWithdrawalsLength(address) (external)
    - withdrawalDelayBlocks() (external)

+ Contract IDelegationManager (Most derived contract)
  - From IDelegationManager
    - decreaseDelegatedShares(address,IStrategy[],uint256[]) (external)
    - delegateTo(address) (external)
    - delegateToBySignature(address,address,uint256,bytes) (external)
    - delegatedTo(address) (external)
    - delegationTerms(address) (external)
    - increaseDelegatedShares(address,IStrategy,uint256) (external)
    - isDelegated(address) (external)
    - isNotDelegated(address) (external)
    - isOperator(address) (external)
    - operatorShares(address,IStrategy) (external)
    - registerAsOperator(IDelegationTerms) (external)
    - undelegate(address) (external)

+ Contract IDelegationTerms (Most derived contract)
  - From IDelegationTerms
    - onDelegationReceived(address,IStrategy[],uint256[]) (external)
    - onDelegationWithdrawn(address,IStrategy[],uint256[]) (external)
    - payForService(IERC20,uint256) (external)

+ Contract IEigenPod (Most derived contract)
  - From IEigenPod
    - REQUIRED_BALANCE_GWEI() (external)
    - REQUIRED_BALANCE_WEI() (external)
    - delayedWithdrawalRouter() (external)
    - eigenPodManager() (external)
    - hasRestaked() (external)
    - initialize(address) (external)
    - mostRecentWithdrawalBlockNumber() (external)
    - podOwner() (external)
    - provenPartialWithdrawal(uint40,uint64) (external)
    - restakedExecutionLayerGwei() (external)
    - stake(bytes,bytes,bytes32) (external)
    - validatorStatus(uint40) (external)
    - verifyAndProcessWithdrawal(BeaconChainProofs.WithdrawalProofs,bytes,bytes32[],bytes32[],uint256,uint64) (external)
    - verifyOvercommittedStake(uint40,BeaconChainProofs.ValidatorFieldsAndBalanceProofs,bytes32[],uint256,uint64) (external)
    - verifyWithdrawalCredentialsAndBalance(uint64,uint40,BeaconChainProofs.ValidatorFieldsAndBalanceProofs,bytes32[]) (external)
    - withdrawBeforeRestaking() (external)
    - withdrawRestakedBeaconChainETH(address,uint256) (external)

+ Contract IEigenPodManager (Most derived contract)
  - From IPausable
    - pause(uint256) (external)
    - pauseAll() (external)
    - paused() (external)
    - paused(uint8) (external)
    - pauserRegistry() (external)
    - setPauserRegistry(IPauserRegistry) (external)
    - unpause(uint256) (external)
  - From IEigenPodManager
    - beaconChainOracle() (external)
    - createPod() (external)
    - getBeaconChainStateRoot(uint64) (external)
    - getPod(address) (external)
    - hasPod(address) (external)
    - ownerToPod(address) (external)
    - recordOvercommittedBeaconChainETH(address,uint256,uint256) (external)
    - restakeBeaconChainETH(address,uint256) (external)
    - slasher() (external)
    - stake(bytes,bytes,bytes32) (external)
    - strategyManager() (external)
    - updateBeaconChainOracle(IBeaconChainOracle) (external)
    - withdrawRestakedBeaconChainETH(address,address,uint256) (external)

+ Contract IPausable
  - From IPausable
    - pause(uint256) (external)
    - pauseAll() (external)
    - paused() (external)
    - paused(uint8) (external)
    - pauserRegistry() (external)
    - setPauserRegistry(IPauserRegistry) (external)
    - unpause(uint256) (external)

+ Contract IPauserRegistry (Most derived contract)
  - From IPauserRegistry
    - isPauser(address) (external)
    - unpauser() (external)

+ Contract ISlasher (Most derived contract)
  - From ISlasher
    - canSlash(address,address) (external)
    - canWithdraw(address,uint32,uint256) (external)
    - contractCanSlashOperatorUntilBlock(address,address) (external)
    - freezeOperator(address) (external)
    - getCorrectValueForInsertAfter(address,uint32) (external)
    - getMiddlewareTimesIndexBlock(address,uint32) (external)
    - getMiddlewareTimesIndexServeUntilBlock(address,uint32) (external)
    - isFrozen(address) (external)
    - latestUpdateBlock(address,address) (external)
    - middlewareTimesLength(address) (external)
    - operatorToMiddlewareTimes(address,uint256) (external)
    - operatorWhitelistedContractsLinkedListEntry(address,address) (external)
    - operatorWhitelistedContractsLinkedListSize(address) (external)
    - optIntoSlashing(address) (external)
    - recordFirstStakeUpdate(address,uint32) (external)
    - recordLastStakeUpdateAndRevokeSlashingAbility(address,uint32) (external)
    - recordStakeUpdate(address,uint32,uint32,uint256) (external)
    - resetFrozenStatus(address[]) (external)

+ Contract IStrategy (Most derived contract)
  - From IStrategy
    - deposit(IERC20,uint256) (external)
    - explanation() (external)
    - sharesToUnderlying(uint256) (external)
    - sharesToUnderlyingView(uint256) (external)
    - totalShares() (external)
    - underlyingToShares(uint256) (external)
    - underlyingToSharesView(uint256) (external)
    - underlyingToken() (external)
    - userUnderlying(address) (external)
    - userUnderlyingView(address) (external)
    - withdraw(address,IERC20,uint256) (external)

+ Contract IStrategyManager (Most derived contract)
  - From IStrategyManager
    - addStrategiesToDepositWhitelist(IStrategy[]) (external)
    - beaconChainETHStrategy() (external)
    - calculateWithdrawalRoot(IStrategyManager.QueuedWithdrawal) (external)
    - completeQueuedWithdrawal(IStrategyManager.QueuedWithdrawal,IERC20[],uint256,bool) (external)
    - completeQueuedWithdrawals(IStrategyManager.QueuedWithdrawal[],IERC20[][],uint256[],bool[]) (external)
    - delegation() (external)
    - depositBeaconChainETH(address,uint256) (external)
    - depositIntoStrategy(IStrategy,IERC20,uint256) (external)
    - depositIntoStrategyWithSignature(IStrategy,IERC20,uint256,address,uint256,bytes) (external)
    - getDeposits(address) (external)
    - numWithdrawalsQueued(address) (external)
    - queueWithdrawal(uint256[],IStrategy[],uint256[],address,bool) (external)
    - recordOvercommittedBeaconChainETH(address,uint256,uint256) (external)
    - removeStrategiesFromDepositWhitelist(IStrategy[]) (external)
    - slashQueuedWithdrawal(address,IStrategyManager.QueuedWithdrawal,IERC20[],uint256[]) (external)
    - slashShares(address,address,IStrategy[],IERC20[],uint256[],uint256[]) (external)
    - slasher() (external)
    - stakerStrategyList(address,uint256) (external)
    - stakerStrategyListLength(address) (external)
    - stakerStrategyShares(address,IStrategy) (external)
    - withdrawalDelayBlocks() (external)

+ Contract BeaconChainProofs (Most derived contract)
  - From BeaconChainProofs
    - getBalanceFromBalanceRoot(uint40,bytes32) (internal)
    - verifyValidatorBalance(uint40,bytes32,bytes,bytes32) (internal)
    - verifyValidatorFields(uint40,bytes32,bytes,bytes32[]) (internal)
    - verifyWithdrawalProofs(bytes32,BeaconChainProofs.WithdrawalProofs,bytes32[]) (internal)

+ Contract Endian (Most derived contract)
  - From Endian
    - fromLittleEndianUint64(bytes32) (internal)

+ Contract Merkle (Most derived contract)
  - From Merkle
    - merkleizeSha256(bytes32[]) (internal)
    - processInclusionProofKeccak(bytes,bytes32,uint256) (internal)
    - processInclusionProofSha256(bytes,bytes32,uint256) (internal)
    - verifyInclusionKeccak(bytes,bytes32,bytes32,uint256) (internal)
    - verifyInclusionSha256(bytes,bytes32,bytes32,uint256) (internal)

+ Contract IRestakeManager
  - From IRestakeManager
    - calculateTVLs() (external)
    - depositQueue() (external)
    - depositTokenRewardsFromProtocol(IERC20,uint256) (external)
    - stakeEthInOperatorDelegator(IOperatorDelegator,bytes,bytes,bytes32) (external)

+ Contract IRenzoOracle (Most derived contract)
  - From IRenzoOracle
    - calculateMintAmount(uint256,uint256,uint256) (external)
    - calculateRedeemAmount(uint256,uint256,uint256) (external)
    - lookupTokenAmountFromValue(IERC20,uint256) (external)
    - lookupTokenValue(IERC20,uint256) (external)
    - lookupTokenValues(IERC20[],uint256[]) (external)

+ Contract IRoleManager (Most derived contract)
  - From IRoleManager
    - isDepositWithdrawPauser(address) (external)
    - isERC20RewardsAdmin(address) (external)
    - isEzETHMinterBurner(address) (external)
    - isNativeEthRestakeAdmin(address) (external)
    - isOperatorDelegatorAdmin(address) (external)
    - isOracleAdmin(address) (external)
    - isRestakeManagerAdmin(address) (external)
    - isRoleManagerAdmin(address) (external)
    - isTokenAdmin(address) (external)

+ Contract RestakeManager (Upgradeable) (Most derived contract)
  - From IRestakeManager
    - depositQueue() (external)
  - From ReentrancyGuardUpgradeable
    - __ReentrancyGuard_init() (internal)
    - __ReentrancyGuard_init_unchained() (internal)
    - _nonReentrantAfter() (private)
    - _nonReentrantBefore() (private)
    - _reentrancyGuardEntered() (internal)
  - From Initializable
    - _disableInitializers() (internal)
    - _getInitializedVersion() (internal)
    - _isInitializing() (internal)
  - From RestakeManager
    - addCollateralToken(IERC20) (external)
    - addOperatorDelegator(IOperatorDelegator,uint256) (external)
    - calculateTVLs() (public)
    - chooseOperatorDelegatorForDeposit(uint256[],uint256) (public)
    - chooseOperatorDelegatorForWithdraw(uint256,uint256,uint256[][],uint256[],uint256) (public)
    - constructor() (public)
    - deposit(IERC20,uint256) (external)
    - deposit(IERC20,uint256,uint256) (public)
    - depositETH() (external)
    - depositETH(uint256) (public)
    - depositTokenRewardsFromProtocol(IERC20,uint256) (external)
    - getCollateralTokenIndex(IERC20) (public)
    - getCollateralTokensLength() (external)
    - getOperatorDelegatorsLength() (external)
    - getTotalRewardsEarned() (external)
    - initialize(IRoleManager,IEzEthToken,IRenzoOracle,IStrategyManager,IDelegationManager,IDepositQueue) (public)
    - removeCollateralToken(IERC20) (external)
    - removeOperatorDelegator(IOperatorDelegator) (external)
    - setMaxDepositTVL(uint256) (external)
    - setOperatorDelegatorAllocation(IOperatorDelegator,uint256) (external)
    - setPaused(bool) (external)
    - setTokenTvlLimit(IERC20,uint256) (external)
    - stakeEthInOperatorDelegator(IOperatorDelegator,bytes,bytes,bytes32) (external)

+ Contract RestakeManagerStorageV1
  - From IRestakeManager
    - calculateTVLs() (external)
    - depositQueue() (external)
    - depositTokenRewardsFromProtocol(IERC20,uint256) (external)
    - stakeEthInOperatorDelegator(IOperatorDelegator,bytes,bytes,bytes32) (external)

+ Contract RestakeManagerStorageV2
  - From IRestakeManager
    - calculateTVLs() (external)
    - depositQueue() (external)
    - depositTokenRewardsFromProtocol(IERC20,uint256) (external)
    - stakeEthInOperatorDelegator(IOperatorDelegator,bytes,bytes,bytes32) (external)

+ Contract IEzEthToken (Upgradeable) (Most derived contract)
  - From IERC20Upgradeable
    - allowance(address,address) (external)
    - approve(address,uint256) (external)
    - balanceOf(address) (external)
    - totalSupply() (external)
    - transfer(address,uint256) (external)
    - transferFrom(address,address,uint256) (external)
  - From IEzEthToken
    - burn(address,uint256) (external)
    - mint(address,uint256) (external)

INFO:Slither:contracts/RestakeManager.sol analyzed (34 contracts)