// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Practice {
    struct User {
        uint id;
        string name;
    }

    User[] users;

    constructor() {
        User memory user1 = User(0, "sai");
        users.push(user1);

        User memory user2 = User(1, "krishna");
        users.push(user2);

        User memory user3 = User(2, "reddy");
        users.push(user3);
    }

    /**answer:
     * 0:string[]: sai,krishna,reddy
     * 1:uint256[]: 0,1,2
     */
    function getNames() external view returns (string[] memory, uint[] memory) {
        string[] memory names = new string[](users.length);
        uint[] memory ids = new uint[](users.length);

        for (uint i = 0; i < users.length; i++) {
            names[i] = users[i].name;
            ids[i] = users[i].id;
        }
        return (names, ids);
    }

    /**answer
     * 0:tuple(uint256,string)[]: 0,sai,1,krishna,2,reddy
     */
    function getUsers() external view returns (User[] memory) {
        return users;
    }
}
