/*
Escribir un contrato Lottery que permita a múltiples direcciones depositar una cantidad de ether en una lotería. 
El contrato debería tener una función que seleccione una dirección aleatoria que recibirá todo el ether depositado.
*/

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Random.sol";

contract Lottery {
    address[] public players;
    address public winner;

    function deposit() external payable {
        require(msg.value > 0, "Amount must be greater than 0");
        players.push(msg.sender);
    }

    function selectWinner() external {
        uint256 playersCount = players.length;
        require(playersCount > 0, "No players in the lottery");

        uint256 randomIndex = Random.uniform(playersCount);
        winner = players[randomIndex];

        uint256 prize = address(this).balance;
        payable(winner).transfer(prize);

        delete players;
    }
}

