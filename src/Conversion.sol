//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Test,console} from 'forge-std/Test.sol';
import {Conversion} from '../src/Conversion.sol';

contract TestConversion is Test, Conversion {

    constructor() Conversion(0x694AA1769357215DE4FAC081bf1f309aDC325306,2) {
    }

    function test_00_Conversion() public view {
        uint256 price = getPrice();
        console.log("Price",price);
        uint256 ethAmount = getConversionRate(10 ether);
        uint256 ethAmountInUSD = (price * 10 ether)/10**18;
        ethAmountInUSD = ethAmountInUSD/10**(18-2);
        assertEq(ethAmount, ethAmountInUSD);
    }
}