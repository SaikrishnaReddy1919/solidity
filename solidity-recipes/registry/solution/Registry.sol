// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
* Maintaining a central registry helps in many ways. 
* This registry below, maintains a registry of all the token addresses deployed.
    (EX : DAI = 0x56a2777e796eF23399e9E1d791E1A0410a75E31b)
* Import this to any contract, use these updated addresses to perform any action.
* This helps you to avoid maintaining a token/tokens addresses across your contracts(A.sol, B.sol ...) and removes the burden
    of updating token addresses each time when new token is deployed.
* Thus, You have unbreakable system.
*/

contract Registry {
    // EX : DAI = 0x56a2777e796eF23399e9E1d791E1A0410a75E31b
    mapping(string => address) public tokens;
    address admin;

    constructor() {
        admin = msg.sender;
    }

    function updateTokenAddress(string calldata id, address tokenAddress) external {
        require(msg.sender == admin, "only owner!.");
        tokens[id] = tokenAddress;
    }
}