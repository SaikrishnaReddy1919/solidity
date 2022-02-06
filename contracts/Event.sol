// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Event {
    event Log(address sender, string message);

    function fireEvent() public {
        emit Log(msg.sender, "Hello world!...");
        emit Log(msg.sender, "Hello Ethereum Devs...");
    }
}