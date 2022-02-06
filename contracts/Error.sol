// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


/**
    * The convenience functions assert and require can be used to check for conditions and 
        throw an exception if the condition is not met.
    * 'assert' statements should not throw any error is the code is properly functioning. If it
        throw any error, then there is a bug in your contract code.
        -> Means, 'assert' statement should always evaluate to true.
    * 'require' should be used to ensure valid conditions that cannot be detected until execution time. 
        This includes conditions on inputs or return values from calls to external contracts.

    * OVERFLOW AND UNDERFLOW IN SIMPLE :
        overflow : the max uint in solidity is 2^256-1 and min is 0
            -> so any uint should be in range of 0 <= x <= 2^256-1
            -> if x + y > 2^256-1 -> overflow occurs(x will set to 0). if x+y => x -> no overflow.
            -> if x - y < 0 -> underflow occurs. if x >= y then no underflow.


    * Deploy below contract and add and subtract max int value to the balance to see overflow
        and underflow statements.
 */
contract Error {
    uint public balance;
    uint public constant MAX_INT = 2 ** 256 - 1;

    function deposit(uint _amount) public{
        // if we use assert statement here to check overflow and underflow then there may a 
        // possiblity that the statement may fails. So this will be a bug in the code.
        // we dont want this. So use require statement here to check the inputs.

        // check overflow :
        require(balance + _amount >= balance, "sum cant be more than max uint");
        uint oldBalance = balance;
        balance += _amount;

        // when balance gets updated, updated balance should be greater or equal to old bal
        assert(balance >= oldBalance);
    }

    function withdraw(uint _amount) public {

        // check underflow
        require(balance >= _amount, "withdrawn amount cant be more than balance");
        // revert is same as require but it accepts one argument which is a message and uses if.
        // the only diff is, with require we write the condition what we need to satisfy and with
        // the revert we write condition saying what is this conditions mets.
        if(balance <= _amount){
            revert("underflow");
        }
        uint oldBalance = balance;
        balance -= _amount;

        // when udpated , udpated balance should less than or equal to old bal.
        assert(balance <= oldBalance);
    }
}