// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Event {
    /**
        * if in future if you want search for logs fired by some specific address -> keyword 'indexed'
            will be helpful here. 
        * then all you have to do is send a request to Eth full node to search in the logs for
            specific address.
     */  

    event Log(address indexed sender, string message);

    function fireEvent() public {
        emit Log(msg.sender, "Hello world!...");
        emit Log(msg.sender, "Hello Ethereum Devs...");
    }
}