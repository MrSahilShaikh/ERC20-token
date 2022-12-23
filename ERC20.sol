//SPDX-License-Identifier:Mit
pragma solidity ^0.8.9;
interface IERC20{
    //to view totalsupply of coins
    function totalSupply() external view returns(uint);
    //to check balance of account
    function balanceOf(address account) external view returns(uint);
    //to transfer token
    function transfer(address recepient,uint amount) external returns(bool);
    //
    function allowance(address owner , address spender) external returns(uint);
    //
    function approve(address spender,uint amount)external returns(bool);
    //
    function transferFrom(address sender,address recepient,uint amount)external returns(bool);
    //
    event Transfer(address indexed from,address indexed to,uint amount);
    //
    event Approval(address indexed owner,address indexed spender,uint amount);
}

contract ERC20 is IERC20{
    uint public totalSupply;
    //
    mapping(address => uint)public balanceOf;
    //owner alow to spender to approve certain amount
    mapping(address => mapping(address => uint )) public allowance;
    //token name
    string public name="Biz";
    //token symbol
    string public sysmbol="BIZ";
    //how many zero use to represent 1 token
    uint8 public decimals=18;

    
    function transfer(address recepient,uint amount) external returns(bool){
        require(amount <= balanceOf[msg.sender],"low amount");
        balanceOf[msg.sender] -=amount;
        balanceOf[recepient] +=amount;
        emit Transfer(msg.sender,recepient,amount);
        //true is for function executed succefully
        return true;

    }
    //
    function approve(address spender,uint amount)external returns(bool){
        allowance[msg.sender][spender]=amount;
        emit Approval(msg.sender,spender,amount);
        return true;

    }
    //
    function transferFrom(address sender,address recepient,uint amount)external returns(bool){
        require(amount <= balanceOf[msg.sender],"low amount");
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -=amount;
        balanceOf[recepient] +=amount;
        emit Transfer(sender,recepient,amount);
        return true;
    }

    function mint(uint amount) external{
        balanceOf[msg.sender] +=amount;
        totalSupply +=amount;
        emit Transfer(address(0),msg.sender,amount);

    }

    function burn(uint amount) external{
        balanceOf[msg.sender] -=amount;
        totalSupply -=amount;
        emit Transfer(msg.sender,address(0),amount);
    }
}