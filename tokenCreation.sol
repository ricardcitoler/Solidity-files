// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/*
Crea un contrato llamado "Token" que permita a un usuario crear tokens y transferirlos a otras cuentas. 
El contrato debe tener las siguientes características:

El token debe tener un nombre, un símbolo y una cantidad máxima de tokens que se pueden crear.
Los usuarios deben ser capaces de crear nuevos tokens y transferirlos a otras cuentas.
El número total de tokens en circulación debe actualizarse cada vez que se crean o transfieren tokens.
Los usuarios deben ser capaces de consultar su saldo de tokens.
El contrato debe emitir un evento cada vez que se transfieren tokens.
*/
// no tiene demasiado sentindo crear un contrato para crear tokens, ya que todos los tokens son iguales, 
// ademas cada usuario puede crear tantos tokens como quiera mientras no supere el total de tokens que se pueden crear
// asi que el primer usuario se podria quedar con el total de los tokens que se pueden crear. Pero bueno es solo un ejercicio para
// practicar, asi que lo hago asi que es lo que me ha pedido chatGPT.
contract Token {
    uint256 totalSupply;
    string name;
    string symbol;


    mapping(address => uint256) balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _amount);

    constructor (string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        totalSupply = 1000;
    }

    function createTokens(uint256 _amount) public {
        require(totalSupply >= _amount, "Not enough tokens available");
        balances[msg.sender] += _amount;
        totalSupply -= _amount;
    }

    function transferTokens(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough tokens available");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
    }

    function getTokensCreated() public view returns (uint256) {
        return 1000 - totalSupply;   
}

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}