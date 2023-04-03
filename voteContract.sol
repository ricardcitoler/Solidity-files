// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Voting {
    struct Voter {
        address voterAddress; // Dirección del votante
        uint8 vote; // Opción elegida (1 o 2)
    }
    
    Voter[] voters; // Array que contiene los votos emitidos
    uint8 public option1Votes; // Contador de votos para la opción 1
    uint8 public option2Votes; // Contador de votos para la opción 2
    
    function vote(uint8 option) public { //esta función comprueva la direccion de todos los votantes, y si la direccion del nuevo votante coincide con alguna de las ya registradas, no se le permite votar
        for (uint i = 0; i < voters.length; i++) {
            require(voters[i].voterAddress != msg.sender, "Voter already voted"); // Verifica que el votante no haya votado previamente
        }
        
        Voter memory newVoter; // Crea una nueva instancia de la estructura Voter
        newVoter.voterAddress = msg.sender; // Asigna la dirección del votante a la nueva instancia
        newVoter.vote = option; // Asigna la opción elegida a la nueva instancia
        
        voters.push(newVoter); // Agrega la nueva instancia al array de votos
        
        if (option == 1) { // Si la opción elegida es 1
            option1Votes++; // Incrementa el contador de votos para la opción 1
        } else if (option == 2) { // Si la opción elegida es 2
            option2Votes++; // Incrementa el contador de votos para la opción 2
        }
    }
    
    function getResult() public view returns (uint8, uint8) {
        return (option1Votes, option2Votes); // Devuelve el número de votos emitidos por cada opción
    }
}
