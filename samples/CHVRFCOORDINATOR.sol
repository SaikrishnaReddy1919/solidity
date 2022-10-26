// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract RandomNumberConsumer is VRFConsumerBase {
    bytes32 public keyHash;
    uint256 public fee;
    uint256 public randomResult;
    
    // vrf coordingator address and LINK token address
    // can be found here : https://docs.chain.link/docs/vrf-contracts/v1/
    constructor() VRFConsumerBase(
        0xf0d54349aDdcf704F77AE15b96510dEA15cb7952, 0x514910771AF9Ca656af840dff83E8264EcF986CA
    ) {
       keyHash = 0xAA77729D3466CA35AE8D28B3BBAC7CC36A5031EFDC430821C02BC31A238AF445;
        fee = 2000000000000000000;
    }
    
    function getRandomNumber() public returns (bytes32) {
        bytes32 req_id = requestRandomness(keyHash, fee);
        return req_id;
    }
    
    function fulfillRandomness(bytes32, uint256 _randomResult) internal override {
        randomResult = _randomResult;
    }
}