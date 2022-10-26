pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
interface IPlonkVerifier {
    function verifyProof(bytes memory proof, uint[] memory pubSignals) external view returns (bool);
}

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

/// @title An example airdrop contract utilizing a zk-proof of MerkleTree inclusion.

// PROBLEM :
// Distributing an airdrop to users is simple if you already have their public keys, but protocols may want to do so according to off-chain activities. 
// Although one could request addresses from users over a public or private channel, many users would prefer not to disclose their public keys.

// This repo demonstrates a strategy for distributing tokens where users can provide a message (known as the 'commitment') 
// over a public channel and later claim their portion of the airdrop by providing a zero-knowledge proof that they belong in the Merkle tree. 
// Claiming tokens in this manner mixes them with all other users entitled to an airdrop, protecting their anonymity.

//SOLUTION
// Users create a key and a secret, and concatenate hash(key + secret) to create the commitment.
// The commitment can then be transmitted across a public or private channel without leaking information.
// An admin assembles a Merkle tree of these commitments and deploys the smart contracts.
// Users can then redeem with a zero-knoweldge proof that they belong in the Merkle tree without revealing which commitment is associated with their public key.
// Note that on-chain verification requires ~350k gas.

//check image -> merkel_proof
//link -> https://github.com/a16z/zkp-merkle-airdrop-contracts
contract PrivateAirdrop is Ownable {
    IERC20 public airdropToken;
    uint public amountPerRedemption;
    IPlonkVerifier verifier;

    bytes32 public root;

    mapping(bytes32 => bool) public nullifierSpent;

    uint256 constant SNARK_FIELD = 21888242871839275222246405745257275088548364400416034343698204186575808495617;

    constructor(
        IERC20 _airdropToken,
        uint _amountPerRedemption,
        IPlonkVerifier _verifier,
        bytes32 _root
    ) {
        airdropToken = _airdropToken;
        amountPerRedemption = _amountPerRedemption;
        verifier = _verifier;
        root = _root;
    }

    /// @notice verifies the proof, collects the airdrop if valid, and prevents this proof from working again.
    function collectAirdrop(bytes calldata proof, bytes32 nullifierHash) public {
        require(uint256(nullifierHash) < SNARK_FIELD ,"Nullifier is not within the field");
        require(!nullifierSpent[nullifierHash], "Airdrop already redeemed");

        uint[] memory pubSignals = new uint[](3);
        pubSignals[0] = uint256(root);
        pubSignals[1] = uint256(nullifierHash);
        pubSignals[2] = uint256(uint160(msg.sender));
        require(verifier.verifyProof(proof, pubSignals), "Proof verification failed");

        nullifierSpent[nullifierHash] = true;
        airdropToken.transfer(msg.sender, amountPerRedemption);
    }

    /// @notice Allows the owner to update the root of the merkle tree.
    /// @dev Function can be removed to make the merkle tree immutable. If removed, the ownable extension can also be removed for gas savings.
    function updateRoot(bytes32 newRoot) public onlyOwner {
        root = newRoot;
    }
}
