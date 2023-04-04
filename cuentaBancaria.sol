
/*
Crear un contrato que permita a los usuarios depositar Ether y mantener un registro de sus saldos. 
El contrato debe tener las siguientes funciones:

Una función deposit() que permita a los usuarios depositar Ether en su cuenta.
Una función balanceOf(address user) que permita a los usuarios consultar su saldo actual.
Una función withdraw(uint256 amount) que permita a los usuarios retirar una cantidad específica de Ether de su cuenta.
*/

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract BalanceKeeper{
    mapping(address => uint256) private balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function balanceOf(address user) public view returns (uint256) {
        return balances[user];
    }

    function withraw(uint256 amount) public {
        require (balances[msg.sender] >= amount, "Insufficient funds");
        balances[msg.sender]-= amount;
        payable(msg.sender).transfer(amount);
    }
}