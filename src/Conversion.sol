// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;


import {AggregatorV3Interface} from "chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Conversion {
    uint8 public  decimals = 8;

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint precision = 10**(18-decimals);
        
        uint256 ethAmountInUSD = (ethPrice/10**18 * ethAmount/10**18);

        return ethAmountInUSD;
    }

    function getPrice() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        int256 multiplier = int256(10**(18-priceFeed.decimals()));
        return uint256(price*multiplier);
    }
}