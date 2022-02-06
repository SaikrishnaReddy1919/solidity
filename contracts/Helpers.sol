// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Helpers {
    uint count;

    uint[] public myArray;
    uint[10] public fixedArray;
    uint[] public initedArray = [1, 2, 3];

    function increment (uint _n) public {
        // simple for loop
        for(uint i=0; i < _n; i++){
            count += 1;
        }
    }


    function push(uint _num) public {
        // adds ele to the end of the array
        myArray.push(_num);
    }
    function pop() public {
        // removes last ele in the array. Length will affect
        myArray.pop();
    }
    function remove(uint _index) public {
        // this will not remove the ele at index, but sets the value to the 0. Length will not affect
        delete myArray[_index];
    }
    function getLength() public view returns (uint) {
        // returns length of array
        return myArray.length;
    }
}

contract CompactArray {
    // removing elements from array make array filled with all zeros. To avoid this and to have
    // clean and neat array after removing -> we can copy the last ele to the index that we
    // want to remove ele from. Then we can have assert statements to check everything is correct or not
    uint[] public myArray;

    function fillArray(uint _len) public {
        for(uint i = 1; i <= _len ; i++){
            myArray.push(i);

            // example _len = 3 then array will be
            // [1, 2, 3]
        }
    }
    
    function remove(uint _index) public {
        uint oldLength = myArray.length;
        myArray[_index] = myArray[oldLength- 1]; //copies last ele to the index that we want to remove element

        // last ele is copied, now pop last ele.
        myArray.pop();


        // say index is 1 -> then array should be [1,3] and after removing, length shud be 2
        // and myArray[0] = 1, myArray[1] = 3
        assert(myArray.length == oldLength - 1);
        assert(myArray[0] == 1);
        assert(myArray[1] == 3);
    }

    function genLength() public view returns (uint) {
        return myArray.length;
    }
}