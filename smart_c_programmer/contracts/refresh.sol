// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract RefreshSolidity {
    //------------------------------------//
    //--->          VARIABLES         <---//
    //------------------------------------//
    //1. Fixed-size
    bool isReady;
    uint a;
    address user;
    bytes32 data; //any arbitrary binary data

    //2. Varible size
    string name;
    bytes _data;
    uint[] amounts;
    mapping(address => string) users; //users[some_address] = "some_name"

    //3. User defined
    struct user_details {
        uint id;
        string name;
        uint[] friendIds;
    }
    enum Age {
        ABOVE_20,
        ABOVE_40,
        ABOVE_60
    }
}
