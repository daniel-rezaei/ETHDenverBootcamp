// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;


contract VolcanoCoin{
    uint totalSupply = 10000;
    address owner;
    event totalSupplyChange(uint newValue);
    event tokenTransfered(uint amount, address recipient);
    mapping (address => uint) public balances;
    struct Payment {
        uint amount;
        address recipient;
    }
    mapping (address => Payment[]) public payments;


    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner of contract can call this function.");
        _;
    }

    function getTotalSupply() public view returns(uint){
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner{
        totalSupply += 1000;
        emit totalSupplyChange(totalSupply);
    }

    function transferToken(uint _amount, address _recipient) public {
        //TODO: check sender credit. it was not mentioned in homework!
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit tokenTransfered(_amount, _recipient);
        payments[msg.sender].push( Payment(_amount, _recipient) );
    }

}