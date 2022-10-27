// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

//inheritance and override examplw

contract ExtraStorage is SimpleStorage {
    // lets do someting diff here -> +10
    //override
    //virtual override

    function store(uint256 _favoriteNumber) public override{
        favoriteNumber = _favoriteNumber + 10;
    }
}