// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract Utils {
    address public addrA;
    address public addrB;
    uint public topAmount;

    function setAddresses(address _aadrA, address _addrB) external {
        addrA = _aadrA;
        addrB = _addrB;
    }

    // grouping txns - if there is any error in any of grouped contracts(calls) then all the txns(inside the group) will fail and state(in all contracts) will be reverted.
    // when grouped, either both of calls will succeed or both will fail.
    // here, contract B's bar() function is throwing an error, so 'topAmount' in this contract
    // and amountA in contract A will be reveted to initial state. Deploy and play!.
    function groupTxns(uint argA, uint argB) external {
        topAmount += 100;
        A(addrA).foo(argA);
        B(addrB).bar(argB);
    }
}

contract A {
    uint public amountA = 10;
    function foo(uint arg) external {
        amountA += arg;
    }
}

contract B {
    uint public amountB = 10;
    function bar(uint arg) external {
        amountB += arg;
        revert('failed at B');
    }
}
