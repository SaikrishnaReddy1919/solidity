// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


/**
    * storage - data stored is permanent
    * memory - data is avaliable while function call only
    * calldata - 

    @dev :
    
    STATE VARIABLES :
        * variables stored inside contract are 'state variables' and are stored on blockchain,
          variables stored inside function are only available inside that function, during the 
          function call only and not stored on blockchain.

    FUNCTIONS :
        * functions are two types in solidity,
        1. functions that creates a transation.
            -> these type of functions will change the value of 'state variable' which results in changing
            the state of the blockchain.
            -> EX : trasferring ether between two accounts results in changing the value of the accounts balance

        2. function that dont create a transaction.
            -> these functions dont change the value of the state variables and these do not change the
            state of the blockchain.
            -> EX : a function that returns the value of a state variable.

    VIEW AND PURE :
        * View : view does not write to blockchain.
        * Pure  : Pure also does not write to blockchain and does not read state variables.

    Two ways to read state variables:
        1. write a getter function of our own.
        2. or put 'public' keyword to a variable that you want solidity to create getter function automatically.
        (function will be created with the name of 'state variable').

 */


contract SimpleStorage {
    string public text;

    function set(string memory _text) public {
        text = _text;
    }
    function get() public view returns (string memory){
        return text;
    }
}