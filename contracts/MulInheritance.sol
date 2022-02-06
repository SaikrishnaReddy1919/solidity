// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


/**
    *Ex : contract C inherits from A & B
    * when a contract inherits from multiple other contracts, then it inherits all of the differet
        functions from all contracts.
    * If there are same functions (foo() in contract B overrides foo() in contract A) then contract C
        inherits foo() from contract B.
    * above is the when the order of contracts is -> contract C is A, B.
    * But if the order is -> contract C is B, A -> then contract C inherits foo() from A.
    * This behaviuor is because, solidity looks for the functions from right to left.
 */
contract A {
    function foo() virtual public pure returns (string memory){
        return 'am from Contract A';
    }
}
contract B {
    function foo() virtual public pure returns (string memory){
        return 'am from Contract B';
    }
}

contract C is A, B {
    // derives from multiple base contracts A and B so we must explicitly
    // override foo()

    function foo() override(A, B) public pure returns (string memory){}
}


// <----------------- mul functions inherits ------------->
contract D {
    function bar() public pure returns (string memory) {
        return "bar from contract D";
    }
}
contract E {
    function eBar() public pure returns (string memory){
        return "bar from contract E";
    }
}

contract F is D, E {
    // has both bar() and eBar()
}




// <-----------calling parent contract function ----------->

contract AA {
    event Log(string message);

    function foo() virtual public {
        emit Log("AA.foo called");
    }
}

contract BB is AA {
    function foo() override public {
        emit Log("BB.foo called");
        AA.foo();
    }
}



