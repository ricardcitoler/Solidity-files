
/*
Crea un contrato de Solidity llamado Auction que tenga las siguientes características:

El contrato debe tener una estructura Bid que tenga los campos bidder (la dirección del ofertante) y amount (la cantidad de la oferta).
El contrato debe tener una variable highestBid que almacene la oferta más alta en la subasta.
El contrato debe tener una variable ended que indique si la subasta ha terminado o no.
El contrato debe tener una variable owner que almacene la dirección del propietario del contrato.
El contrato debe tener una variable duration que indique la duración de la subasta en segundos.
El contrato debe tener una función bid que permita a los usuarios realizar ofertas en la subasta.
La función bid debe comprobar que la subasta no ha terminado y que la oferta es mayor que la oferta más alta actual. 
Si la oferta cumple estas condiciones, debe actualizar la oferta más alta y la estructura Bid correspondiente.
El contrato debe tener una función endAuction que permita al propietario del contrato terminar la subasta. 
La función debe comprobar que la subasta ha finalizado y que la persona que llama a la función es el propietario del contrato. 
Si se cumplen estas condiciones, la función debe transferir la cantidad más alta al propietario del contrato.
*/

// SPDX-License-Identifier: UNLICENCED

pragma solidity ^0.8.0;

contract Auction {
    struct Bid {
        address bidder;
        uint256 amount;
    }
    
    address public owner;
    uint256 public duration;
    uint256 public startBlock;
    uint256 public endBlock;
    uint256 public highestBid;
    bool public ended;
    
    mapping(address => Bid) public bids;
    
    event HighestBidIncreased(address bidder, uint256 amount);
    event AuctionEnded(address winner, uint256 amount);

    constructor(uint256 _duration) {
        owner = msg.sender;
        duration = _duration;
        startBlock = block.number;
        endBlock = startBlock + duration;
    }
    
    function bid() public payable {
        require(block.number < endBlock, "Auction has ended");
        require(msg.value > highestBid, "Bid must be higher than highest bid");
        
        if (bids[msg.sender].amount > 0) {
            bids[msg.sender].amount += msg.value;
        } else {
            bids[msg.sender] = Bid(msg.sender, msg.value);
        }
        
        highestBid = bids[msg.sender].amount;
        emit HighestBidIncreased(msg.sender, msg.value);
    }
    
    function endAuction() public {
        require(block.number >= endBlock, "Auction not yet ended");
        require(!ended, "Auction has already ended");
        require(msg.sender == owner, "Only owner can end the auction");
        
        ended = true;
        emit AuctionEnded(bids[highestBidder].bidder, highestBid);
        
        payable(owner).transfer(highestBid);
    }
}



