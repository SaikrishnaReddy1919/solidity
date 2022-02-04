// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract A {
    function getMyName() public pure returns (string memory) {
        return 'Am Contract A';
    }
}

// inherting contract A
contract B is A {

}
// deploy the contract B in remix and see that deployed code will have getMyName functione.
