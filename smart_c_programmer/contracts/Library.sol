// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

library PlayerLibrary {
    struct Player {
        uint score;
    }

    // memory location storage means, it will modify the state on calling contract
    //if it is memory, then state will not be modifed
    function incrementScore(Player storage _player, uint points) external {
        _player.score += points;
    }
}

contract Library {
    // there are two ways to call a function in library
    // way - 1 :
    mapping(uint => PlayerLibrary.Player) players;

    function increment() public {
        PlayerLibrary.incrementScore(players[0], 10);
    }

    //way - 2 : using...for
    using PlayerLibrary for PlayerLibrary.Player;

    function incrementWay2() external {
        players[0].incrementScore(10);
    }

    function getPoints() external view returns (uint) {
        return players[0].score;
    }

    /**
     * Deployed vs Embedded
     *  - there are two ways that libraries can be deployed.
     *  - Deployed :
     *      - if functions inside library has 'public' modifer, then that library will have its own address. i.e, this library will be deployed on diff address than the contract.
     *      - So, if contract 'A' calls a function on library then this library will modify the storage on 'A' contract only. And if contract 'B' calls a function on library then this library will modify the storage on 'B' contract only. So, on...
     *
     *  - Embedded :
     *      - if function inside library has 'internal' modifer, then this library will be deployed inside same address as the contract.
     *
     *  Libraries are meant as a way to split your contract into smaller components. They have no state so there should be no need to have more than one instance.
     */
}
