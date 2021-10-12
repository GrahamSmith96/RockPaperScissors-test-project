//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./interfaces/IERC20.sol";

contract RockPaperScissors {
    IERC20 dai;
    address public Alice;
    address public Bob;
    enum Hand{Rock, Paper, Scissors}
    Hand aliceHand;
    Hand bobHand;

    constructor(address _Alice, address _Bob, IERC20 _dai, uint _amount) payable {
        dai = _dai;
        Alice = _Alice;
        Bob = _Bob;
        dai.transferFrom(_Alice, address(this), _amount);
        dai.transferFrom(_Bob, address(this), _amount);
        console.log("Deploying a Game with player addresses:", _Alice, _Bob);

    }
    function rock() external {
        require(msg.sender == Alice || msg.sender == Bob);
        if(msg.sender == Alice) {
            aliceHand = Hand.Rock;
        }
        else if(msg.sender == Bob) {
            bobHand = Hand.Rock;
        }
    }

    function paper() external {
        require(msg.sender == Alice || msg.sender == Bob);
        if(msg.sender == Alice) {
            aliceHand = Hand.Paper;
        }
        else if(msg.sender == Bob) {
            bobHand = Hand.Paper;
        }
    }

    function scissors() external {
        require(msg.sender == Alice || msg.sender == Bob);
        if(msg.sender == Alice) {
            aliceHand = Hand.Scissors;
        }
        else if(msg.sender == Bob) {
            bobHand = Hand.Scissors;
        }
    }

    function rock() external {
        require(msg.sender == Alice || msg.sender == Bob);
        if(msg.sender == Alice) {
            aliceHand = Hand.Rock;
        }
        else if(msg.sender == Bob) {
            bobHand = Hand.Rock;
        }
    }

    event Winner(address _player, uint _amount); 
    function play() external {
        uint balance = dai.balanceOf(address(this));

        if(aliceHand == Hand.Rock && bobHand == Hand.Scissors) {
            dai.transferFrom(address(this), Alice, balance);
            emit Winner(Alice, balance);

        }

        if(aliceHand == Hand.Paper && bobHand == Hand.Rock) {
            dai.transferFrom(address(this), Alice, balance);
            emit Winner(Alice, balance);
        }

        if(aliceHand == Hand.Scissors && bobHand == Hand.Paper) {
            dai.transferFrom(address(this), Alice, balance);
            emit Winner(Alice, balance);
        }

        if(aliceHand == Hand.Paper && bobHand == Hand.Scissors) {
            dai.transferFrom(address(this), Bob, balance);
            emit Winner(Bob, balance);
        }

        if(aliceHand == Hand.Rock && bobHand == Hand.Paper) {
            dai.transferFrom(address(this), Bob, balance);
            emit Winner(Bob, balance);
        }

        if(aliceHand == Hand.Scissors && bobHand == Hand.Rock) {
            address(Bob).transfer(address(this).balance);
            emit Winner(Bob, balance);
        }
    }
    
}
