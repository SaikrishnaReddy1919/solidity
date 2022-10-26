//SPDX-License-Identifier : UNLICENSED
pragma solidity ^0.8.0;


contract GlobalVariables {

    // these are some global varibles.
    address public _sender = msg.sender;
    bytes public msg_data = msg.data;
    uint public blockNumber = block.number;
    bytes32 public blockHash = blockhash(3);
    address public minerAddress = block.coinbase;
    uint public _gasLimit = block.gaslimit;
    uint public _timeStamp = block.timestamp;
    uint public _gasleft = gasleft();
    address public txOrigin = tx.origin;
}