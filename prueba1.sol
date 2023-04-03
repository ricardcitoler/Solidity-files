
//@notice this is a test contract to practice the use of the solidity language
// the purpose of this script is just to create a simple smart contract that allows users to create tasks
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract TaskList {
    struct Task {
        string description;
        bool completed;
        address owner;
    }

    Task[] public tasks;

    function createTask(string memory _description) public {
        tasks.push(Task({
            description: _description,
            completed: false,
            owner: msg.sender
        }));
    }

    function completeTask(uint _index) public {
        require(tasks[_index].owner == msg.sender, "Only the owner can complete the task");
        tasks[_index].completed = true;
    }

    function getTasks() public view returns (Task[] memory) {
        return tasks;
    }
}
