//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    address payable public owner;
    event Occupy(address _customer, uint _value);

    enum Statuses {
        Vacant,
        Occupied
    }

    Statuses public currentStatus;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant(){
        require(currentStatus == Statuses.Vacant, "Currenlty occupied.");
        _;
    }

    modifier enoughtEther(uint _amount){
        require(_amount >= 2 ether, "Not enough ether provided.");
        _;
    }

    function bookRoom() payable public onlyWhileVacant enoughtEther(msg.value) {
        currentStatus = Statuses.Occupied;
        //owner.transfer(msg.value) -> doesnt give status. so

        (bool sent, bytes memory data) = owner.call{value : msg.value}("");
        require(sent == true);

        emit Occupy(msg.sender, msg.value);
    }
}