// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import "chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import './Conversion.sol';
import {console} from 'forge-std/Test.sol';

contract PayUB is Conversion {

    address public owner;
    address[] studentsBilled;
    mapping(address => uint256) public billsToPay;


    modifier OnlyOwner () {
        require(msg.sender==owner,"You are not Authorized");
        _;
    }

    event billAdded(address indexed student, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function addBill(address _student, uint256 _billAmount) external OnlyOwner {
        emit billAdded(_student,_billAmount);
        studentsBilled.push(_student);
        billsToPay[_student] += _billAmount;

    }
    function viewBill() external view returns(uint256) {
        return billsToPay[msg.sender];

    }
    function withdraw() external payable OnlyOwner {
        
        payable(owner).transfer(address(this).balance);

    }

    function payBill() external payable returns(uint256) {
        
        uint256 amountPaid = getConversionRate(msg.value);
        console.log(amountPaid);
        billsToPay[msg.sender] -= amountPaid;

        return amountPaid;

    }

}