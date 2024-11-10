//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {MockAggregator} from '../src/Mocks/MockAggregator.sol';

contract NetworkConfig {

    uint8 constant DECIMALS = 8;
    int256 constant PRICE = 257643000000; 
    mapping(uint256 => address) public priceFeeds;

    function addNetworkAggregator(uint256 networkId, address aggregator) external {
        priceFeeds[networkId] = aggregator;
    }

    function getNetworkAggregator(uint256 networkId) external returns (address) {
        if (priceFeeds[networkId] == address(0)) {
            address mock = deployMock();
            priceFeeds[networkId] = mock;
        }

        return priceFeeds[networkId];
    }

    function deployMock() private returns (address) {
        MockAggregator mock = new MockAggregator(PRICE, DECIMALS);
        return address(mock);
    }

}