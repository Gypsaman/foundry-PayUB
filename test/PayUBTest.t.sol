//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Test} from 'forge-std/Test.sol';
import {PayUB} from '../src/payUB.sol';

contract PayUBTest is Test {
    PayUB payUB;
    uint256 constant BILL_AMT = 100;
    address constant STUDENT = address(1);
    address constant OWNER = address(2);

    function setUp() public {
        vm.prank(OWNER);
        payUB = new PayUB();
    }

    function testOwner() public view {
        assertEq(payUB.owner(), OWNER);
    }
}