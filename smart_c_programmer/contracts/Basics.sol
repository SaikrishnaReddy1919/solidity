//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Basics {
    bool public b = true;
    uint public u = 123; //uint = unit256 0 to 2**256 - 1
    //uint8 = 0 to 2**8 - 1
    //uint16 = 0 to 2**16 - 1
    int public i = -123; // int = int256 -2**256 to 2**256 - 1
    // int = int128 -2**128 to 2**128 - 1
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0x2821adDd7D2feBd4b3D98012356A922DedB5752A;
    bytes32 public b32 =
        0x2821adDd7D2feBd4b3D98012356A922DedB5752AeBd4b3D98012356A922DedB5;

    //default values
    bool public boo; //false
    uint public de; // 0
    int public in_default; //0
    address public add; //0x000...00(40 zeros)
    bytes32 public byt; //0x000...00(64 zeros)

    //Error
    // revert, assert, require
    // when error is throw, gas(unused) will be refunded and any changes to state
    //variables will be reverted/undone.
    // custom errors - save gas

    function test_require(uint _i) public pure {
        require(_i < 10, "i must be greated than 10.");
        //code
    }

    //revert and require both does the same but
    //revert is better option when having nested if conditions
    function test_revert(uint _i) public pure {
        if (_i > 10) {
            revert("i > 10");
        }
        if (_i > 1) {
            //code
            if (_i > 2) {
                //code
                if (_i > 10) {
                    revert("i > 10");
                }
            }
        }
        //code
    }

    /**
     * assert : use assert when the condition must always evaluates to true.
     * Ex: say you have num state variable and you want it always to be equal
     *      - to 10. If some function changes its value then assert will be failed and it
     *      - means there is a some bug in the code.
     */

    uint public num = 10;
    uint public count = 10;

    function test_assert() public view {
        assert(num == 10); // this must be true
    }

    // modifers
    modifier whenNotPaused() {
        require(!false, "Paused.");
        _;
    }

    modifier sandwich(uint _x) {
        count += 10;
        _;
        // below code runs after calling function excution completion
        count *= 2;
    }

    function check_pauesd_and_x(uint _x) public whenNotPaused sandwich(_x) {
        count += 5;
    }
}
