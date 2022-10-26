//SPDX-License-Identifier : UNLICENSED
pragma solidity ^0.8.0;

contract Ref {
    struct Employee {
        string name;
        uint8 age;
        uint8[] ids;
    }

    Employee public employee;
    Employee[] employess;

    function addEmployee() public {
        employee.age = 12;
        employee.name = "krishna";
        employee.ids.push(21);
    }

    function getEmplyess() public view returns (Employee[] memory) {
        return employess;
    }

    // -------STRING CONCAT--------
    function concat(string memory _a, string memory _b)
        public
        pure
        returns (string memory result)
    {
        return string(abi.encodePacked(_a, " ", _b));
    }

    // ----- ARRAYS ----
    // Two types - fixed and dynamic
    // dynamic ops are - push, pop, length, deleteAtIndex
    // fixed ops are - length, deleteAtIndex

    uint256[8] public fixedArray;
    uint256[] public dynamicArray;

    function push(uint256 _num) public {
        dynamicArray.push(_num);
    }

    function pop() public {
        dynamicArray.pop();
    }

    function length() public view returns (uint256) {
        return dynamicArray.length;
    }

    function deleteAtIndex(uint256 _index) public {
        delete dynamicArray[_index];
    }

    // ----enums-----

    enum loanStatus {
        Applied,
        InProgress,
        Verified,
        Approved
    }

    loanStatus employeeLoanStatus;

    function applyLoan() public {
        employeeLoanStatus = loanStatus.Applied;
    }
    function makeInProgress() public {
        employeeLoanStatus = loanStatus.InProgress;
    }
    function isLoanInProgress() public view returns(bool){
        require(employeeLoanStatus == loanStatus.InProgress, "Loan not in progress");
        return(true);
    }
}
