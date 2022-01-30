// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Functions {

    // uncomment below code to check what the error it has

    // function mapInput(mapping(uint => uint) memory map) public {
    // }


    function multiDimFixedSizeArrayInput(uint[10][10] memory _arr) public {

    }

    // deploy this contract on remix to see the error throw by below function
    // function multiDimDynamizSizeInput(uint[][] memory _arr) public {

    // }

    uint MAX_ARR_LENGTH = 10;

    // array can also take dynamic sized array but its recommended to have upper bound for tha array.
    function arrayInput(uint[] memory _arr) public view {
        if(_arr.length > MAX_ARR_LENGTH){
            // throw error
        }
    }



    // <------------------- Function OUTPUTS --------------->

    mapping(uint => uint) map;
    uint[] arr;
    uint[10][10] arr2DFixed;
    uint[][] arr2D;

    // funtion cannot return a map

    // function mapOutput() public returns (mapping(uint => uint) memory) {
    //     return map;
    // }

    function multiDimFixedSizeArrayOutput() public view returns (uint[10][10] memory) {
        return arr2DFixed;
    }

    function multiDimDynamizSizeOutput() public view returns (uint[][] memory) {
        return arr2D;
    }

    // TODO: study more here -> what will happen when function returns array of dynamic size?
    function arrayOutput() public view returns (uint[] memory) {
        return arr;
    }


    // function can return multiple values
    function returnMultipleValues() public pure returns (uint, bool, uint) {
        return (1, false, 1);
    }

    // function can also returns named values
    function namedReturns() public pure returns (uint x, bool isOwner, uint y) {
        return (1, true, 2);
    }




    function a() public pure returns (uint){
        return 1;
    }
    function b() public pure returns (uint){
        return 2;
    }

    function c() public pure returns (uint, uint){
        return (a(), b());
    }



    // destructuring retuned values
    function destructureValues() public pure returns (uint, bool, uint, uint, uint) {
        (uint x, bool isOwner, uint y) = returnMultipleValues();

        (uint _a, , uint _c) = (4, 5, 6);

        return (x, isOwner, y, _a, _c);
    }


    
}