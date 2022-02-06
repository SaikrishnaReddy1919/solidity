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
 */
contract Error {
    uint public balance;

    function deposit(uint _amount) public{
        uint oldBalance = balance;
        balance += _amount;

        // when balance gets updated, updated balance should be greater or equal to old bal
        assert(oldBalance >= balance);
    }

    function withdraw(uint _amount) public {
        uint oldBalance = balance;
        balance -= _amount;

        // when udpated , udpated balance should less than or equal to old bal.
        assert(oldBalance <= balance);
    }
}