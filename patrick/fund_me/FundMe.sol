//get funds from users
//withdraw funds
//set a mini funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUSD = 50 * 1e18; // usd with 18 decimals

    address[] public funders;
    mapping(address => uint256) public addressToAmountFounded;


    function fund() public payable {
        //set min fund amount
        require(getConversionRate(msg.value) >= minimumUSD , "didn't send enough funds!"); //1e18 = 1 * 10 **18 == 1000000000000000000
        funders.push(msg.sender); // push sender to funded array.
        addressToAmountFounded[msg.sender] = msg.value; // keeps track of how much amount sent for each address.
    }

    function getPrice() public view returns (uint256) {
        // ABI => when compiled(line 29) interface will give minimalistic ABI, then using this we can call functions at address.
        // address = 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e (ETH/USD - goreli testnet) -> as we are interacting with other contract - chainlink contract
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        
        // (uint80 roundId, int256 price, uint startedAt, uint timeStamp, uint80 answeredInRound) = priceFeed.latestRoundData();
        (,int256 price,,,) = priceFeed.latestRoundData(); //as we only care  about price
        //will get price of eth in usd
        // price will have 8 decimal s but the value at msg.value has 18 decimals. So to equal them do power of to price with 10.
        // and typecast int256 to uint256
        return uint256(price * 1e10); // 1**10 = 10000000000
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 _ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();

        // 3000_000000000000000000 = ETH/USD price - 18 decimals -> ethPrice
        // 1_000000000000000000 -> _ethAmount
        // 3000.000000000000000000 -> ethAmopuntInUsd

        uint256 ethAmountInUsd = (ethPrice * _ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}