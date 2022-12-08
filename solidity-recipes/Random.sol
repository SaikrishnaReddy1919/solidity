// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Random {
    /**
     * 0:bytes: 0x000000000000000000000000000000000000000000000000000000
     * 00639167dd0000000000000000000000000000000000000000000000000000405b
     * bd86ca285b38da6a701c568545dcfcb03fcb875f56beddc4
     */
    function getEncodePacked() external view returns (bytes memory) {
        return abi.encodePacked(block.timestamp, block.difficulty, msg.sender);
    }

    /**
     * 0:bytes32: 0x68808e70c7c589c87f34aa0611421b8a8c9cf85a9ce89c9f17b7e30a6f35c5d4
     */
    function getHash() external view returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(block.timestamp, block.difficulty, msg.sender)
            );
    }

    function getRandom(uint range) external view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.difficulty,
                        msg.sender
                    )
                )
            ) % range;
    }
}
