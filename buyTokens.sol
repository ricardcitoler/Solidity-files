// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
/*Crear un contrato en Solidity que permita a los usuarios comprar tokens. 
Cada token tendrá un precio fijo de 0.01 ether. El contrato debe llevar un registro de los compradores y la cantidad de tokens que han comprado. 
También debe permitir a los usuarios transferir sus tokens a otras direcciones.*/
contract TokenSale {
    uint256 public tokenPrice = 0.01 ether;
    uint256 public totalSupply = 1000;
    mapping(address => uint256) public balances;
    
    function buyTokens(uint256 amount) public payable {
        require(msg.value == amount * tokenPrice, "Insufficient funds");
        require(amount <= totalSupply, "Not enough tokens available");
        balances[msg.sender] += amount;
        totalSupply -= amount;
    }
    
    function transferTokens(address recipient, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }
}

