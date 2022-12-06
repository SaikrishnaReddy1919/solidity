// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract SendEther {
    function invest() external payable {}

    function balanceOf() external view returns (uint) {
        return address(this).balance;
    }

    //send ether from smart contract another contract/address
    //using transfer . 1
    function sendEther(address payable to) external {
        //address must be payable to sc to transfer ether
        to.transfer(1 ether); //this means transfer 1 ether to 'to' address from smart contract.

        //type casting. address payable -> address✅ ... address -> address payable✅

        address a = to;

        payable(a).transfer(100); //wont wort. caz 'to' type cased to address

        //send vs transfer
        //send : when used to send ether to another smartcontract B, if B has some error in it then send returns false. If it succeeds send returns true.
        //transfer : but with transfer, if there is a error in contract B, then that error will be propagated to main contract and the whole transaction will be reverted.
    }
}
