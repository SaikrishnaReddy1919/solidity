// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract Modifiers {
    /**
        -> Modifiers helps in restricting the write access
        -> validating the inputs
        -> prevents Reentrancy hack (reentrancy guard)


        Reentrancy Hack : a function that calls another function or calls itslef continously
         while executing.
     */

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        _;
    }

    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not a valid address");
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

    // example of reentrancy hacks
    uint public x = 10;

    // below function calls itself before the actual excution of function is completed.
    function decrement(uint _i) public {
        x -= _i;
        if(_i > 1) {
            decrement(_i - 1); //at this line, func calls itself (other func in other contract can also be called here)
        }
    }


    // example to prevent above of hack is :
    bool locked = false;

    modifier noReEntracnyHack() {
        require(!locked == false, "Cannot call");

        locked = true;
        _;
        locked = false;
    }

    function decrement2(uint _i) public noReEntracnyHack {
        x -= _i;
        if(_i > 1) {
            decrement2(_i - 1);
        }
    }


}