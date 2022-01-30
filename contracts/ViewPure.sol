// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/**
        * Functions :
            * visibility -> public, private, internal and external
            * behaviour -> view, pure, payable

        * Modifying the state means :
            -> writing to state variables,
            -> emitting events,
            -> creating other contracts,
            -> using 'selfdestruct' -> to remove the contrac the blockchain,
            -> sending ether via calls,
            -> calling functions that are not marked with 'view' or 'pure'.
            -> using low-level calls,
            -> using inline assembly that contains certain opcodes

        * Reading from the state :
            -> reading state variables
            -> accessing 'address(this).balance' or '<address>.balance'
            -> accessing any of the members of 'block', 'tx', 'msg' (with the exception of msg.sig and msg.data)
            -> calling any function not marked 'pure',
            -> using inline assembly that contains certain opcodes.


        * View -> functions do not modify the state (check above what modifying the state means) and can read the state
        * Pure -> function do not modify the state and do not read the state.
*/

contract ViewPure {

    uint public x = 0;

    // Valid view function.
    function addToX(uint _y) public view returns (uint){
        return x + _y;
    }

    // valid pure function.
    function add(uint _x, uint _y) public pure returns (uint) {
        return _x + _y ;
    }


    // try compiling below code in remix to see the errors.


    //<------------------ run below code in remix --------------------->


    // view function cannot call non-view function inside it.
    function nonViewFunction() public pure returns (uint) {
        return 1;
    }
    function viewFunction() public view returns (uint) {
        return x + nonViewFunction();
    }


    // like above pure function cannot call non-pure function inside it.
    function nonPureFunction() public view returns (uint) {
        return x;
    }

    function purefunction() public pure returns (uint) {
        return 2 + nonPureFunction();
    }


    // <-----------------correct code for above functions is (comment above and uncomment below for correct code) ----------------->

    // function nonViewFunction() public view returns (uint) {
    //     return x;
    // }
    // function viewFunction() public view returns (uint) {
    //     return x + nonViewFunction();
    // }


    // function nonPureFunction() public view returns (uint) {
    //     return x;
    // }
    // function purefunction() public view returns (uint) {
    //     return 2 + nonPureFunction();
    // }

}