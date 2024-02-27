// SPDX-License-Identifier: BUSL-1.1
pragma solidity =0.8.19;

import "../EigenLayer/interfaces/IStrategyManager.sol";
import "../EigenLayer/interfaces/IEigenPod.sol";
import "../EigenLayer/interfaces/IBeaconChainOracle.sol";
import "../EigenLayer/interfaces/IPausable.sol";

/**
 * @title Interface for factory that creates and manages solo staking pods that have their withdrawal credentials pointed to EigenLayer.
 * @author Layr Labs, Inc.
 * @notice Terms of Service: https://docs.eigenlayer.xyz/overview/terms-of-service
 */

abstract contract baseEigenPodManager is IPausable {
    /**
     * @notice Creates an EigenPod for the sender.
     * @dev Function will revert if the `msg.sender` already has an EigenPod.
     */
    function createPod() external
    {

    }

    /**
     * @notice Stakes for a new beacon chain validator on the sender's EigenPod. 
     * Also creates an EigenPod for the sender if they don't have one already.
     * @param pubkey The 48 bytes public key of the beacon chain validator.
     * @param signature The validator's signature of the deposit data.
     * @param depositDataRoot The root/hash of the deposit data for the validator's deposit.
     */
    function stake(bytes calldata pubkey, bytes calldata signature, bytes32 depositDataRoot) external payable
    {

    }

    /**
     * @notice Deposits/Restakes beacon chain ETH in EigenLayer on behalf of the owner of an EigenPod.
     * @param podOwner The owner of the pod whose balance must be deposited.
     * @param amount The amount of ETH to 'deposit' (i.e. be credited to the podOwner).
     * @dev Callable only by the podOwner's EigenPod contract.
     */
    function restakeBeaconChainETH(address podOwner, uint256 amount) external
    {

    }

    /**
     * @notice Removes beacon chain ETH from EigenLayer on behalf of the owner of an EigenPod, when the
     *         balance of a validator is lower than how much stake they have committed to EigenLayer
     * @param podOwner The owner of the pod whose balance must be removed.
     * @param beaconChainETHStrategyIndex is the index of the beaconChainETHStrategy for the pod owner for the callback to 
     *                                    the StrategyManager in case it must be removed from the list of the podOwner's strategies
     * @param amount The amount of ETH to remove.
     * @dev Callable only by the podOwner's EigenPod contract.
     */
    function recordOvercommittedBeaconChainETH(address podOwner, uint256 beaconChainETHStrategyIndex, uint256 amount) external
    {

    }
    
    /**
     * @notice Withdraws ETH from an EigenPod. The ETH must have first been withdrawn from the beacon chain.
     * @param podOwner The owner of the pod whose balance must be withdrawn.
     * @param recipient The recipient of the withdrawn ETH.
     * @param amount The amount of ETH to withdraw.
     * @dev Callable only by the StrategyManager contract.
     */
    function withdrawRestakedBeaconChainETH(address podOwner, address recipient, uint256 amount) external
    {

    }

    /**
     * @notice Updates the oracle contract that provides the beacon chain state root
     * @param newBeaconChainOracle is the new oracle contract being pointed to
     * @dev Callable only by the owner of this contract (i.e. governance)
     */
    function updateBeaconChainOracle(IBeaconChainOracle newBeaconChainOracle) external
    {

    }

    /// @notice Returns the address of the `podOwner`'s EigenPod if it has been deployed.
    function ownerToPod(address podOwner) external view returns(IEigenPod)
    {

    }

    /// @notice Returns the address of the `podOwner`'s EigenPod (whether it is deployed yet or not).
    function getPod(address podOwner) external view returns(IEigenPod)
    {

    }

    /// @notice Oracle contract that provides updates to the beacon chain's state
    function beaconChainOracle() external view returns(IBeaconChainOracle)
    {

    }

    /// @notice Returns the Beacon Chain state root at `blockNumber`. Reverts if the Beacon Chain state root at `blockNumber` has not yet been finalized.
    function getBeaconChainStateRoot(uint64 blockNumber) external view returns(bytes32)
    {

    }

    /// @notice EigenLayer's StrategyManager contract
    function strategyManager() external view returns(IStrategyManager)
    {

    }

    /// @notice EigenLayer's Slasher contract
    function slasher() external view returns(ISlasher)
    {

    }

    function hasPod(address podOwner) external view returns (bool)
    {

    }


    // --------- --------- --------- --------- --------- --------- ---------


    function pauserRegistry() external view returns (IPauserRegistry)
    {

    }

    /**
     * @notice This function is used to pause an EigenLayer contract's functionality.
     * It is permissioned to the `pauser` address, which is expected to be a low threshold multisig.
     * @param newPausedStatus represents the new value for `_paused` to take, which means it may flip several bits at once.
     * @dev This function can only pause functionality, and thus cannot 'unflip' any bit in `_paused` from 1 to 0.
     */
    function pause(uint256 newPausedStatus) external
    {

    }

    /**
     * @notice Alias for `pause(type(uint256).max)`.
     */
    function pauseAll() external
    {

    }

    /**
     * @notice This function is used to unpause an EigenLayer contract's functionality.
     * It is permissioned to the `unpauser` address, which is expected to be a high threshold multisig or governance contract.
     * @param newPausedStatus represents the new value for `_paused` to take, which means it may flip several bits at once.
     * @dev This function can only unpause functionality, and thus cannot 'flip' any bit in `_paused` from 0 to 1.
     */
    function unpause(uint256 newPausedStatus) external
    {

    }

    /// @notice Returns the current paused status as a uint256.
    function paused() external view returns (uint256)
    {

    }

    /// @notice Returns 'true' if the `indexed`th bit of `_paused` is 1, and 'false' otherwise
    function paused(uint8 index) external view returns (bool)
    {

    }

    /// @notice Allows the unpauser to set a new pauser registry
    function setPauserRegistry(IPauserRegistry newPauserRegistry) external
    {

    }
}

contract EigenPodManager is baseEigenPodManager {}