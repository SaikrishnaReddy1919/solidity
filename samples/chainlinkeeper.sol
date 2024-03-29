// Now, we are going to learn how to make event driven transactions in a decentralized context.

// So... What does that even mean? We'll let's think about this...

// Let's say, you have bought an asset or token, and you want to sell it when the price hits a certain level.
//Someone at some point is going to have to make a transaction to sell your asset/token.
// The blockchain can't initiate state changes without someone paying the gas. This means, we are going to have to
//give someone the power to make transactions on our behalf. But who do we give this power to?

// You could do a few things to make sure this happens.

// 1. Build an infrastructure of centralized servers to react and create a transaction on your behalf when the price hits that point.

// 2. Rely on someone else's infrastructure (maybe paid) to do so.

// The above two are great routes to go, but you're now at the mercy of centralization.
//Even more-so, if you're a decentralized protocol looking to trigger event based transactions,
//you shouldn't rely on a centralized infrastructure since you don't have to!

// Use the collaborative decentralized Chainlink Keepers.
// Chainlink Keepers allow us to trigger event driven transactions in a decentralized context.

// Setting up a Keeper Compatible Contract
// In order to set up our Keeper compatible contract, we need to do the follow.

// 1. Import the Keeper Compatible Interface
// 2. Register our contract with the Keeper Registry

// The keeper registry is an on-chain contract that connects all the Chainlink Keepers to all the jobs they are working on.
// In order to register our jobs to be triggered by Chainlink nodes, we have to fund something called a "job" from the keeper compatible
// contract and fund it with LINK. Unlike the Chainlink VRF, which follows a request model, Chainlink Keepers follows a subscription model.
// As long as your "job" on the keeper contract contains LINK, it is funded and will execute jobs!

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/KeeperCompatibleInterface.sol";

contract Capsule is KeeperCompatibleInterface {
    uint256 lockedUntil;
    address payable despositor;

    function deposit(uint256 _lockedUntil) external payable {
        require(lockedUntil == 0);
        despositor = payable(msg.sender);
        lockedUntil = _lockedUntil;
    }

    function checkUpkeep(bytes calldata)
        external
        view
        override
        returns (bool, bytes memory)
    {
        bool upkeepNeeded = lockedUntil > 0 && block.timestamp > lockedUntil;
        return (upkeepNeeded, "0x");
    }

    function performUpkeep(bytes calldata) external override {
        require(block.timestamp > lockedUntil);
        despositor.transfer(address(this).balance);
        delete lockedUntil;
    }
}
