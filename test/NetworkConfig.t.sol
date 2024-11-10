//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Test} from 'forge-std/Test.sol';
import {NetworkConfig} from '../src/NetworkConfig.sol';

contract NetworkConfigTest is Test {
    NetworkConfig networkConfig;
    uint256 constant NETWORK_ID = 11155111;

    function setUp() public {
        networkConfig = new NetworkConfig();
    }

    function test_NC_AddNetworkAggregator() public {
        address aggregator = address(0x123);
        networkConfig.addNetworkAggregator(NETWORK_ID, aggregator);
        assertEq(networkConfig.priceFeeds(NETWORK_ID), aggregator);
    }

    function test_NC_GetNetworkAggregator() public {
        address aggregator = networkConfig.getNetworkAggregator(NETWORK_ID);
        assert(aggregator != address(0));
    }
    function test_NC_GetDefinedAggregator() public {
        address aggregator = address(0x123);
        networkConfig.addNetworkAggregator(NETWORK_ID, aggregator);
        assertEq(networkConfig.getNetworkAggregator(NETWORK_ID), aggregator);

    }
}