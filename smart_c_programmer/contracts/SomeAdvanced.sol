//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//return multiple outputs
// Names outputes
//Destructuring assignment
contract SomeAdvanced {

    function output() public view returns (address, int) {
        return (address(this), 10);
    }

    function named_output() public view returns (address me, int age) {
        return (address(this), 10);
    }

    function assigned() public view returns (address me, int age) {
        me = address(this);
        age = 10;
    }

    function destructure() public view {
        (address myAdd, int256 age) = assigned();
    }

    //arrays
    //dynamic or fixed 

    uint[] public nums = [1, 2, 3]; //dynamic
    uint[5] public fixed_nums = [1, 2, 4]; //fixed - even if the values or not filled, you cant push if after

    function examples() public {
        nums.push(4); //[1, 2, 3, 4]
        uint x = nums[1];
        nums[2] = 22; // [1, 2, 22, 4]

        delete nums[1]; // [1, 0, 22, 4] -> ***** delete replaces the number with 0. Length will be same . To remove completly see below.
        nums.pop(); //[1, 0, 22]
        uint len = nums.length;

        //create array in memory
        // must be of fixed size.
        // you cant push or pop.
        // can only be updated
        uint[] memory a = new uint[](5);
    }

    function returnArray() external view returns (uint[] memory) {
        return nums;
    }


    // remove an element from array
    // shift the elements to the left starting from the index then pop the last one.
    //Ex : [1, 2, 3, 4] -> remove at index 2 -> [1, 2, 4, 4] -> then pop -> [1, 2, 4]
    //This is very gas expensive
    uint[] public arr;
    function remove(uint _index) public  {
        require(_index < arr.length, "Index out of bounds");

        for(uint i = _index; i < arr.length -1 ; i++){
            arr[i] = arr[i+1];
        }
        arr.pop();
    }

    function test() public {
        arr = [1, 2, 3, 4, 5];
        remove(2);

        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);

        assert(arr.length == 4);

        arr = [1];
        remove(0);
        assert(arr.length == 0);
    }

    //gas defiecient way.
    //replace the element that you want to remove with the last element and pop the lost one
    //no shifting so less gas expensive. But the last element will be copied to removed ele
    uint[] public demo_arr = [1, 2, 3, 4, 5];
    function arrayReplaceLast(uint _index) public {
        //remove ele at index 2
        demo_arr[_index] = demo_arr[demo_arr.length - 1];
        demo_arr.pop();
    }
    function returnarr() public view returns(uint[] memory) {
        return demo_arr;
    }


    //mappings
    mapping(address => uint) public balances;
    mapping(address => mapping(address => bool)) public isFriend;

    function mapping_demo() public {
        balances[msg.sender] = 100;

        uint bal_of_unset_address = balances[address(1)]; //0

        delete balances[msg.sender]; //0
        isFriend[msg.sender][address(this)] = true;
    }
}
