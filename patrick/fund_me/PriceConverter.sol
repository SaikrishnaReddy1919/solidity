// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; 

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Libraries are similar to contracts, but you can't declare any state variable and you can't send ether.
// A library is embedded into the contract if all library functions are internal.
// Otherwise the library must be deployed and then linked before the contract is deployed.

library PriceConverter {
    function getPrice() internal view returns (uint256) {
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

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 _ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();

        // 3000_000000000000000000 = ETH/USD price - 18 decimals -> ethPrice
        // 1_000000000000000000 -> _ethAmount
        // 3000.000000000000000000 -> ethAmopuntInUsd

        uint256 ethAmountInUsd = (ethPrice * _ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}