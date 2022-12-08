// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//simple blog - Solidity string manipulation

//NOTE : string manipulation is expensive, so dont do any of these.
contract Strings {

    //abi.encodePacked -> bytes
    function getLength(string calldata str) external pure returns(uint) {
        return abi.encodePacked(str).length;
    }

    //abi.encodePacked -> bytes -> string(cast)
    function concatenate(string calldata str1, string calldata str2) external pure returns (string memory) {
        return string(abi.encodePacked(str1, str2));
    }


    function reverse(string calldata str) external pure returns(string memory) {
        bytes memory byt = abi.encodePacked(str);

        string memory temp = new string(byt.length);

        bytes memory reverseStr = bytes(temp);

        for(uint i = 0 ; i < byt.length ; i++){
            reverseStr[i] = byt[byt.length - i - 1];
        }

        //strange : even if temp is not modifed here, try returning it. It will also give 
        // the reverse of the string. But how?
        //return string(temp);
        return string(reverseStr);
    }

    function compare(string calldata str1, string calldata str2) external pure returns(bool) {
        //direct comparision of string, bytes is not possible. So, compare hashes
        return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
    }
}