//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Script} from "forge-std/Script.sol";
import {PayUB} from "../src/payUB.sol";

contract DeployPayUB is Script {
    PayUB payUB;

    function run() public {
        vm.broadcast();
        payUB = new PayUB();
    }

}