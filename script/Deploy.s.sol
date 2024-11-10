//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Script,console} from "forge-std/Script.sol";
import {PayUB} from "../src/payUB.sol";
//import {MockAggregator} from '../src/Mocks/MockAggregator.sol';
import {NetworkConfig} from "../src/NetworkConfig.sol";


contract DeployPayUB is Script {
    PayUB payUB;
    NetworkConfig networkConfig;


    function run() public {
        vm.startBroadcast();
        uint256 chainID = block.chainid;
        console.log("ChainID: ",chainID);

        networkConfig = new NetworkConfig();

        networkConfig.addNetworkAggregator(11155111,0x694AA1769357215DE4FAC081bf1f309aDC325306);
        networkConfig.addNetworkAggregator(1,0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);

        payUB = new PayUB(networkConfig.getNetworkAggregator(chainID));

        vm.stopBroadcast();
    }

}