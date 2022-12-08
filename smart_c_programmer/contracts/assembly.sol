// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract Assembly {
    uint a;
    uint b;
    uint c;

    function foo() external {
        c = a + b;

        // syntax assembly

        assembly {
            // to do add in assembly
            let d := add(1, 2)

            //------- read and store data in assembly -------
            //read -> load address where f is stored
            let f := mload(0x40)
            // to store in temporary storage - memory
            mstore(f, 2)
            //to store in permanent storage. i.e, on chain
            sstore(f, 2)
        }
    }

    //detect if address is smart contract or not
    //TODO: snippet
    function isSmartContract(address _address) external view returns (bool) { 
        uint size;
        assembly {
            size := extcodesize(_address)
        }

        return size > 0 ? true : false;
    }
}
