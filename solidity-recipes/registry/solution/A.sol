// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Token.sol";
import "./Registry.sol";

contract A {
    Registry registry;
    address admin;

    constructor() {
        admin = msg.sender;
    }

    // here you just need to update the registry when this contract is deployed. This action you do only once.
    // where in case of updating token address, you have to do it multiple times and across multiple contracts. (may be across 100 or 100 or many more contracts)
    function updateRegistry(address registryAddr) external {
        require(msg.sender == admin, "Only owner!.");
        registry = Registry(registryAddr);
    }

    function transfer(address to, string calldata id) external {
        require(msg.sender == admin, "Only owner!.");
        Token token = Token(registry.tokens(id));
        token.transfer(to, 500);
    }
}
