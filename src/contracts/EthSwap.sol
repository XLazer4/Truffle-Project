// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import "./Token.sol";

contract EthSwap {
    string public name = "Exchange";
    Token public token; // for getting da code
    uint public rate = 100;

    constructor(Token _token) public {
        token = _token; //for getting da address
    }
    
    event TokenPurchased(
        address account,
        address token,
        uint amount,
        uint rate
    );

    function buytokens() public payable {
        uint tokenamount = msg.value * rate; // amount of ether used by user * rate of our token

        //checking if ethswap has enough tokens
        require(token.balanceOf(address(this)) >= tokenamount);

        token.transfer(msg.sender,tokenamount);

        emit TokenPurchased(msg.sender,address(token),tokenamount,rate);
    }

    function selltokens(uint _amount) public payable {
        uint etheramount = _amount/rate;

        require(token.balanceOf(msg.sender) >= _amount);

        require((address(this).balance) >= etheramount);
        //transferring tokens to this contract
        token.transferFrom(msg.sender, address(this), _amount);
        //transferring ether
        msg.sender.transfer(etheramount);


    }
}