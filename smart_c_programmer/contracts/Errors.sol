// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract Errors {
    //throw is deprecated
    //1. revert
    //2. require
    //3. assert

    uint num;

    constructor() {
        num = 10;
    }

    function foo() external view {
        if (num == 10) {
            revert("num cant be 10");
        }
        //same with require
        require(num != 10, "num cant be 10.");

        //is assert is used, then the condition must be true otherwise txn will fail. (no error msg)
        assert(num != 10);
    }

    function willThrowError() external returns (bool, bytes memory) {
        B b = new B();
        // b.bar(); // will fail - uncomment and see

        // if want to avoid failed condition then use 'call' (possible reentrancy attack, so be careful)
        //this return true | false based on the result
        (bool success, bytes memory data) = address(b).call(
            abi.encodePacked("bar()")
        );

        return (success, data);
    }
}

contract B {
    constructor() {}

    function bar() external pure {
        revert("This error will be propagated to parent contract");
    }
}
