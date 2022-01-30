// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// 1 Ether = 10^18 Wei
// 1 GWei = 10^9 Wei

/**
    * Tx Fee = gas used * gas price
 */
contract EthUnits {
    uint public onwWei = 1 wei;
    uint public oneEther = 1 ether;

    // below two functions are not creating any txn and not reading any state vars so declared as 'pure'
    function testOneWei() public pure returns (bool){
        return 1 wei == 1;
    }

    function testOneEther() public pure returns (bool){
        return 1 ether == 1e18 wei;
    }
}