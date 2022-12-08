// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Token.sol";

contract A {
    Token token;
    address admin;

    constructor() {
        admin = msg.sender;
    }

    function updateToken(address tokenAddress) external {
        require(msg.sender == admin, "Only owner!.");
        token = Token(tokenAddress);
    }

    /**
     * If you use ERC-20's transfer, then the contract(this) needs to hold tokens.
     * If you use transferFrom, then the token holder needs to have approved an allowance of tokens for the contract(this) to transfer.
     */

    // before executing this, transfer some amount of ERC-20 to this contract, otherwise you will get error: "ERC20: transfer amount exceeds balance"
    function transfer(address to) external {
        require(msg.sender == admin, "Only owner!.");
        token.transfer(to, 500);
    }
}
