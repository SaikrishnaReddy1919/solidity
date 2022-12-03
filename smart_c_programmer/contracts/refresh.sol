// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract RefreshSolidity {
    //------------------------------------//
    //--->          VARIABLES         <---//
    //------------------------------------//
    //1. Fixed-size
    bool isReady;
    uint a;
    address user;
    bytes32 data; //any arbitrary binary data

    //2. Varible size
    string name;
    bytes _data;
    uint[] amounts;
    mapping(address => string) users; //users[some_address] = "some_name"

    //3. User defined
    struct user_details {
        uint id;
        string name;
        uint[] friendIds;
    }
    enum Age {
        ABOVE_20,
        ABOVE_40,
        ABOVE_60
    }

    //------------------------------------//
    //--->          MODIFIERS         <---//
    //------------------------------------//
    /**
     * There are two apis to interact with smart contract :
     *  1. eth_sendTransaction
     *      - used when function dooesn't have either pure/view
     *  2. eth_call
     *      - used when function uses either pure/view
     */

    //------------------------------------//
    //--->         VISIBILITY         <---//
    //------------------------------------//
    /**
     * Trick : order for using function visibily is : private > internal > external > public.
     *      - first use private, then see if contracts works, if not then use internal.
     *      - if internal dont works, then use external.
     *      - if external also wont work, then use public as the last option.
     *
     *      --this way we can avoid some of the security vulnerabilities
     */
    /**
     * private :
     *      - function can only be called from inside the contract.
     *      - _getValue() -> convention.
     *      - cannot be called when deployed. (Try deploying on remix - you cant see the private    function.)
     *      - cannot be called from contract which is inherited main contract
     */
    uint256 private myBalance = 100;

    function _increaseBalance(uint256 amount) private {
        myBalance += amount;
    }

    function doTrick(uint256 _amount) public {
        _increaseBalance(_amount);
    }

    /**
     * internal :
     *      - function can be called from inside the contract. and
     *      - can also be called from the contract which is inherited from main contract.
     */

    function _increaseBalanceInternal(uint256 amount) internal {
        myBalance += amount;
    }

    //**see contract "Inherited" at the end of this contract */

    /**
     * external :
     *      - from outside the contract only.
     *      - cannot be called inside the contract. (cannot call external function from another function or anywhere inside the contract.)
     *      - cannot be called from contract which is inherited main contract. (remember OUTSIDE only. NOT ANYWHERE INSIDE THE CONTRACT)
     *
     */
    function _increaseBalanceExternal(uint256 amount) external {
        myBalance += amount;
    }

    function doTrickExternal(uint256 _amount) public {
        // _increaseBalanceExternal(_amount); //this line throws an error. uncomment and see.
    }

    /**
     * public :
     *      - from outside as well as inside the contract
     *      - means, this function call also be called from inherited contract.
     */
    function _increaseBalancPublic(uint256 amount) public {
        myBalance += amount;
    }

    function doTrickPublic(uint256 _amount) public {
        _increaseBalancPublic(_amount); //this line throws an error. uncomment and see.
    }
}

contract Inherited is RefreshSolidity {
    function callIncreaseBalance(uint256 amount) public {
        _increaseBalanceInternal(amount);
    }
}
