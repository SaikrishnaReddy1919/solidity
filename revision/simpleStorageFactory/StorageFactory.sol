// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// this contract creates a simplestorage contract by calling a method and also stores, retrives a number by calling store and retrive method on created contracts.

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage(); //new -> deployes new contract
        simpleStorageArray.push(simpleStorage);
    }

    //sf -> storage factory
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //address, ABI
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_simpleStorageNumber);

        //or
        //simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        return simpleStorage.retrieve();

        //or
        // return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}