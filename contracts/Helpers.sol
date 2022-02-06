// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Helpers {
    uint count;

    function increment (uint _n) public {
        // simple for loop
        for(uint i=0; i < _n; i++){
            count += 1;
        }
    }
}