//get funds from users
//withdraw funds
//set a mini funding value in usd


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";
contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUSD = 50 * 1e18; // usd with 18 decimals
    address[] public funders;
    mapping(address => uint256) public addressToAmountFounded;


    function fund() public payable {
        //set min fund amount
        // require(getConversionRate(msg.value) >= minimumUSD , "didn't send enough funds!"); //1e18 = 1 * 10 **18 == 1000000000000000000 -> use without library
        require(msg.value.getConversionRate() >= minimumUSD, "didn't send enough funds!.");
        funders.push(msg.sender); // push sender to funded array.
        addressToAmountFounded[msg.sender] = msg.value; // keeps track of how much amount sent for each address.
    }

    function withdraw() public{

    }
}