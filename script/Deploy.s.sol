//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Script,console} from "forge-std/Script.sol";
import {PayUB} from "../src/payUB.sol";
import {MockAggregator} from '../src/Mocks/MockAggregator.sol';

contract DeployPayUB is Script {
    PayUB payUB;
    uint8 constant DECIMALS = 8;
    int256 constant PRICE = 257643000000; 
    address pricefeed;

    function run() public {
        vm.startBroadcast();
        uint256 chainID = block.chainid;
        console.log("ChainID: ",chainID);
        if (chainID == 11155111) {
            console.log("Using Sepolia PriceFeed");
            pricefeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        }
        else {
            console.log("Using Mock PriceFeed");
            MockAggregator mock = new MockAggregator(PRICE, DECIMALS);
            pricefeed = address(mock);
            console.log("Mock PriceFeed Address: ",pricefeed);
        }
        payUB = new PayUB(address(pricefeed));
        vm.stopBroadcast();
    }

}