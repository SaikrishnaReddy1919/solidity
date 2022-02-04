// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


/**
    * @dev : Constructor -> when a contract is created, then a function declared with 'contructor'
        will be executed only once. And this optional and there can be only constructor.
 */
contract Constructor {
    uint public x;
    uint public y;

    address public owner;
    uint public createdAt;

    constructor(uint _x, uint _y){
        x = _x;
        y = _y;

        owner = msg.sender;
        createdAt = block.timestamp;
    }
}