// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Test} from 'forge-std/Test.sol';
import '../src/Mocks/MockAggregator.sol';

contract TestMock is Test {

    MockAggregator mock;
    uint8 constant DECIMALS = 8;
    int256 constant PRICE = 257643000000;  // 257643 * 10**(DECIMALS-2)

    function setUp() public {
        mock = new MockAggregator(PRICE, DECIMALS);
    }

    function test_MOCK_decimals() public view {
        assertEq(mock.decimals(), DECIMALS);
    }

    function test_MOCK_latestRoundDate() public view {
        (,int price,,,) = mock.latestRoundData();
        assertEq(price, PRICE);
    }
}