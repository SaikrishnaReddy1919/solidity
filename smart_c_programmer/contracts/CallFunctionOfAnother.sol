// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "./ContractB.sol";

contract Sample {
    //1. call function of other contract
    //2. import keyword
    //3. contract interface
    //4. error propagation
    address addressB;
    address addressContractB;

    //to call B's function, we need interface and address of B contract

    //-----------------if contract is in same file --------------------
    function setAddressB(address _addressB) external {
        addressB = _addressB;
    }

    function callHelloWorld() external view returns (string memory) {
        //instance of B
        B b_contract = B(addressB);
        return b_contract.helloWorld();
    }

    //-----------------if contract is in different file --------------------
    //using import is also same
    function setAddressContractB(address _addressContractB) external {
        addressContractB = _addressContractB;
    }

    function callHelloWorldB() external view returns (string memory) {
        //instance of B
        ContractB contractB = ContractB(addressContractB);
        return contractB.helloWorldB();
    }

    //To call a function of other contract, we actually dont need the reference to full contract. Interface also works fine.
}

contract B {
    function helloWorld() external pure returns (string memory) {
        return "Helloworld";
    }
}
