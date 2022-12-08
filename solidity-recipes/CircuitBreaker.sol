//its a feature that we can add to smart contract which allows us to temparorily disable the contract due to some hack or
// market condition which can cause the contract to malfunction.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract MyContract {
    address public admin;
    bool public isActive = true;

    constructor() {
        admin = msg.sender;
    }

    modifier isContractActive() {
        require(isActive == true, "Contract is inactive!.");
        _;
    }

    function toggleIsActive() external {
        require(msg.sender == admin, "Only owner!.");
        isActive = !isActive;
    }

    //lets we want to disable this contract. So, that there will no money flow from the contract and no money comes into the contract
    function withdraw() external isContractActive {
        //do something
    }

    receive() external payable isContractActive {
        //do something
    }
}

// above contracts works fine if you have one or very few verisons of same contract deployed.
//Let's say you have 1000 of users and a wallet for each user, then you have to go and call toggleIsActive() every time and on every wallet.
// Instead we can maintain a factory contract, then keep toggleIsActive() inside the factory contract. Then import this factory contract in all 1000 wallet contracts.
// Doing this way, you dont need to call toggleIsActive() on every wallet(contract).
// Again you have some problem here. i.e, toggleIsActive() function in this factory contract can only be called by admin. That means centralized.
// Instead, here 'admin' can be another smart contract, controlled by several people using multisig wallet. Ex. Gnosis.
// Now, only this admin smart contract can trigger toggleIsActive().

//Doing factory way

contract Factory {
    bool public isActive = true;
    address public admin; //assume this as smart contract address controlled by multisig

    constructor(address _admin) {
        admin = _admin;
    }

    function toggleIsActive() external {
        require(msg.sender == admin, "Only owner!.");
        isActive = !isActive;
    }
}

//now the same contract can be :

contract MyContractNew {
    address public admin;
    Factory factory;

    constructor(address _factoryAddr) {
        admin = msg.sender;
        factory = Factory(_factoryAddr);
    }

    modifier isContractActive() {
        require(factory.isActive() == true, "Contract is inactive!.");
        _;
    }

    //lets we want to disable this contract. So, that there will no money flow from the contract and no money comes into the contract
    function withdraw() external isContractActive() {
        //do something
    }

    receive() external payable isContractActive {
        //do something
    }
}