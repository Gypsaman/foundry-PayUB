//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Test,console} from 'forge-std/Test.sol';
import {PayUB} from '../src/payUB.sol';

contract PayUBTest is Test {
    PayUB payUB;
    uint256 constant BILL_AMT = 10000;
    address constant STUDENT = address(1); 
    address OWNER = vm.addr(uint256(keccak256("OWNER")));  

    modifier addBill() {
        vm.prank(OWNER);
        payUB.addBill(STUDENT, BILL_AMT);
        _;
    }

    modifier payBill() {
        vm.deal(STUDENT, 1 ether);
        vm.prank(STUDENT);
        payUB.payBill{value: 0.005 ether}();
        _;
    }

    function setUp() public {
        vm.prank(OWNER);
        payUB = new PayUB();
    }

    function test_01_Owner() public view {
        assertEq(payUB.owner(), OWNER);
    }

    function test_02_AddBill() public addBill{

        assertEq(payUB.billsToPay(STUDENT), BILL_AMT);
    }

    function test_03_viewBill() public addBill {
        vm.prank(STUDENT);
        assertEq(payUB.viewBill(), BILL_AMT);
    }

    function test_04_PayBill() public addBill{
        vm.deal(STUDENT, 1 ether);
        vm.prank(STUDENT);
        uint256 amountPaid = payUB.payBill{value: 0.005 ether}();
        assertEq(payUB.billsToPay(STUDENT), BILL_AMT - amountPaid);
    }

    function test_05_withdraw() public addBill payBill{

        vm.prank(OWNER);
        console.log(OWNER);
        assertEq(address(OWNER).balance, 0.0 ether);
        payUB.withdraw();
        assertEq(address(payUB).balance, 0);

        assertEq(address(OWNER).balance, 0.005 ether);
    }
}