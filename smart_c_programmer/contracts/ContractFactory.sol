// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

/**
 * 1. Creating child contracts
 * 2. Store child contract addresses.
 * 3. Cast contract pointer to address.
 * 4. Call functions of child contract
 * 5. Caveat when admin is contract. (Here loan factory.)
 */

contract LoanFactory {
    struct LoanDetails {
        uint amount;
        uint period; //days
    }

    address admin;
    mapping(address => LoanDetails) public loans;

    event LoanCreated(address loanAddress);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == admin, "Only owner");
        _;
    }

    function createLoan() external onlyOwner {
        Loan loan = new Loan(100); //loan here is the pointer to contract
        LoanDetails memory details = LoanDetails(100, 10);
        loans[address(loan)] = details; //here address(loan) -> casting contract pointer to address.
        emit LoanCreated(address(loan));
    }

    function getLoan(
        address _loanAddress
    ) external view returns (LoanDetails memory) {
        return loans[_loanAddress];
    }

    //Caveat when admin is contract
    /**
     * this withdraw function must be available in the factory contract. Otherwise there will be now way to call withdraw on child.
     * withdraw on the child can only be called by the owner. In this case owner will be LoanFactory. So, only loanfactory can call the withdraw on Loan contract.
     * Deploy on remix, play with it and have fun😉.
     */
    function withdraw(
        address loanAddress
    ) external view returns (string memory) {
        Loan loan = Loan(loanAddress);
        string memory result = loan.withdraw();
        return result;
    }

    function getAdmin(address loanAddress) external view returns (address) {
        Loan loan = Loan(loanAddress);
        address result = loan.getAdmin();
        return result;
    }
}

contract Loan {
    address admin;
    uint amount;

    constructor(uint _amount) {
        admin = msg.sender;
        amount = _amount;
    }

    modifier onlyOwner() {
        require(msg.sender == admin, "Only owner");
        _;
    }

    function getAdmin() external view returns (address) {
        return admin;
    }

    function withdraw() external view onlyOwner returns (string memory) {
        //withdraw logic
        return "Withdraw Success!";
    }
}
