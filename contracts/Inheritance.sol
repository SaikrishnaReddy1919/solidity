// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract A {
    // function which can allowed to be overrided by other contract function must be defined with 
    // keyword 'virtual'
    function getMyName() virtual public pure returns (string memory) {
        return 'Am Contract A';
    }
}

// inherting contract A
contract B is A {

}
// deploy the contract B in remix and see that deployed code will have getMyName functione.



// <----- Overriding ----->
contract C is A {
    // function which overrides the other contract functions must be defined with keyword 'override'
    // and when overriding, function signature must be same otherwise new function will created along with
    // the function from inherited contract.
    function getMyName() override public pure returns (string memory) {
        return 'Am Contract A';
    }
}




// <------ Passing params to parent constructor-------->

contract D {
    string public name;
    constructor(string memory _name) {
        name = _name;
    }
}

// There are three ways to pass name param to parent constructor.
// Way : 1

contract E is D("krishna"){

}
// deploy above E contract and see the value of 'name'

// Way 2 : 
contract F is D {
    constructor() D("krishna") {}
}
// Way 3 : Pass the name to childs constructor while deploying to set the value to parent constructor.
contract G is D {
    constructor(string memory _name) D(_name){}
}


