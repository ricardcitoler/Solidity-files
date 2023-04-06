// SPDX-License-Identifier: UNLICENCED

pragma solidity ^0.8.0;

contract Inventory{

    struct Item{
        string name;
        uint quantity;
    }

    Item [] inventory;

    function addItem (string memory _name, uint _quantity) public {
        inventory.push(Item({
            name: _name,
            quantity: _quantity
        }));
    }

    function getInventory() public view returns (Item[] memory){
        return inventory;
    }
}