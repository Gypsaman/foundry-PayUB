//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// import {AggregatorV3Interface} from '@chainlink/src/v0.8/shared/interfaces/AggregatorV3Interface.sol';

contract MockAggregator  {
    uint8   _decimals;
    int256  _latestAnswer;

    constructor(int256 latestAnswer, uint8 decimals_ ) {
        _latestAnswer = latestAnswer;
        _decimals = decimals_;
    }

    function decimals() external view  returns (uint8) {
        return _decimals;
    }
    
    function latestRoundData() external view  returns (uint80, int256, uint256, uint256, uint80) {
        return (0, _latestAnswer, 0, 0, 0);
    }

}