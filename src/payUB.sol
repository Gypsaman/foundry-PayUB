// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import {AggregatorV3Interface} from "chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {console} from 'forge-std/Test.sol';

contract PayUB {

    address public owner;
    address[] studentsBilled;
    mapping(address => uint256) public billsToPay;

    modifier OnlyOwner () {
        require(msg.sender==owner,"You are not Authorized");
        _;
    }

    event billAdded(address indexed student, uint256 amount);

    constructor(){
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
        billsToPay[msg.sender] -= amountPaid;

        return amountPaid;

    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();

        uint256 ethAmountInUSD = (ethPrice/10**18 * ethAmount/10**18);
        console.log("Conversion",ethAmountInUSD);
        return ethAmountInUSD;
    }

    function getPrice() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        int256 multiplier = int256(10**(18-priceFeed.decimals()));
        return uint256(price*multiplier);
    }


}