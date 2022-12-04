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
    //--->    Function VISIBILITY     <---//
    //------------------------------------//
    /**
     * Trick(Least previlage principle) : order for using function visibily is : private > internal > external > public.
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

    //------------------------------------//
    //--->    Variable VISIBILITY     <---//
    //------------------------------------//
    //?Trick(Least previlage principle)
    /**
     * private :
     *      - can only be read from within the contract.
     *      - and also it is not entirely true. As blockchains are public, these variables can be read by using some tools like Mythil. So, do not keep anything which is imp in a private variable. (//TODO : do some indepth stuff about this.)
     */
    uint private va;
    //same as function internal keyword
    uint internal inte;
    //same as public for func. default. sol creates getter function for all public variables.
    uint public pub;

    //------------------------------------//
    //--->  Some BUILT-IN Variables   <---//
    //------------------------------------//

    /**
     * 1. Transaction
     *      -  tx.origin - ethereum address that sends a txn.
     * 2. msg - gives info about calling environment of the function.
     *      - msg.value - amount of eth that was sent to SC. (in units : wei)
     *      - msg.sender : eth address that calls the txn
     *
     * 3. block
     *      - block.timestamp / now -> in seconds
     */

    /**
     * Diff b/w tx.origin and msg.sender
     *
     * Let's take two smart contracts A and B. Say, Alice calls a function X() which is in contract A and inside this, function X() calls another function Y() in contract B.
     *
     * Now inside function X() - Contract A :
     *      tx.origin  -> Alice. (as Alice made a call)
     *      msg.sender -> Alice.
     *
     * Inside function Y() - Contract B :
     *      tx.origin  -> Alice. (as Alice was the one who originated the txn)
     *      msg.sender -> Contract A. (as Contract A made a call to function Y())
     */

    //------------------------------------//
    //--->           ARRAYS           <---//
    //------------------------------------//

    /**
     * Only same type.
     * Two types :
     *      1. storage arrays   - stored inside the blockchain.
     *      2. memory arrays    - temporary. while executing function. after that it will disappear
     */

    //Storage array.
    //type followed by name.
    uint[] myArray; //dynamic as we did declare the size. uint[5] myArray;(fixed)

    //crud
    function operationsOnArray() external {
        //create
        myArray.push(2);
        myArray.push(3);

        //read
        uint number = myArray[0];

        //update
        myArray[0] = 100;

        //delete => it replaces the value at index 0 to its default type value. So length will be same.after
        delete myArray[0];

        uint counter = 0;
        //iterate
        for (uint i = 0; i < myArray.length; i++) {
            counter += myArray[i];
        }
    }

    //Memory arrays - not saved inside a blockchain.
    function memoryArray() external pure {
        //there is no dynamic arrays in memory arrays.
        uint[] memory memArray = new uint[](5);

        //push is not allowed as size is fixed.
        //remaining all ops are same as dynamic arrays.
    }

    //accept and return array
    //TODO: research
    function foo(uint[] memory myArr) internal view returns (uint[] memory) {}

    //------------------------------------//
    //--->          MAPPINGS          <---//
    //------------------------------------//
    /**
     *Default values :
            - Every keys are accessible even the keys do not exist.
            - So for the key which doesn't exist, we will get default value. (see below)
     */

    //declare
    mapping(address => uint256) balances;

    //nested
    //Ex: ERC20...approve to spend coin on behalf.
    mapping(address => mapping(address => bool)) approved;

    //array inside mapping
    mapping(address => uint[]) scores;

    function fooMapping(address spender) external {
        //add
        balances[msg.sender] = 100;
        //read
        uint256 userBal = balances[msg.sender];
        //update
        balances[msg.sender] = 200;
        //delete
        delete balances[msg.sender];

        //Default values :
        // balances[some_address] => will give 0. as return value type is uint. if return value type is bool then will get false.(as false is the default for bool.)

        //Nested mappings
        approved[msg.sender][spender] = true; //set
        bool isApproved = approved[msg.sender][spender]; //read
        approved[msg.sender][spender] = false; //update
        delete approved[msg.sender][spender];

        //array inside mapping
        scores[msg.sender].push(100);
        scores[msg.sender].push(200);

        scores[msg.sender][0]; //read
        scores[msg.sender][0] = 500; //update
        delete scores[msg.sender][0]; //delete
    }

    //------------------------------------//
    //--->          STRUCTS           <---//
    //------------------------------------//

    //when ? if you think you are using too many variables then think about using struct.
    struct User {
        address addr;
        uint score;
        string name;
    }

    //structs itself cannot be stored in storage so they need containers ...arrays || mappings
    User[] usersList;

    //struct inside mapping
    mapping(address => User) userDetails;

    function fooStruct(string calldata _name) external {
        //way-1
        User memory user1 = User(msg.sender, 0, _name);

        //way-2
        User memory user2 = User({name: _name, score: 0, addr: msg.sender});

        user2.addr; //read
        user2.score = 100; //update
        delete user1; //deletes user1 from memory

        usersList.push(user2); //array
        userDetails[msg.sender] = user2;
    }

    //------------------------------------//
    //--->           ENUMS            <---//
    //------------------------------------//

    enum STATE {
        INACTIVE,
        ACTIVE,
        CANCELLED
    }
    STATE state;

    function fooEnums() external {
        state = STATE.ACTIVE;
    }

    function fooMe() external {
        if (state == STATE.ACTIVE) {
            //do something
        }
    }

    //from outside its not possible to pass states so instead we can pass integers.
    //ex : if we pass 0, it means INACTIVE. If we pass 1, it means ACTIVE.

    function enumAsArg(STATE _state) external {}

    struct User5 {
        STATE state;
    }

    //------------------------------------//
    //--->       MEMROY Locations     <---//
    //------------------------------------//
    // storage, memory, stack, calldata

    /**
     * storage :
     *      - inside the blockchain.
     *      - all state variables has memory location as storage. (default)(all outside functions variables)
     *
     * memory :
     *      - not stored on blockchain
     *      - so tempararoy and not persistent
     *      - only accessbile during the execution of the function after that memory data will be destoryed.
     *
     * stack :
     *      - not stored on chain
     *      - all the variables declared inside the function has stack as a storage.
     *      - has the lifetime as same as the functions.
     *
     * calldata :
     *      - not stored on chain
     *      - has lifetime as same as the functioms.
     *      - when called these with complex types as inputs like array and if the function is external or public then storage location must be 'calldata'
     *
     * TODO : do more research on this.
     */

    //-----------------storage---------------------
    struct UserDemo {
        string name;
    }
    UserDemo[] usersDe;

    function fooUsers() external {
        UserDemo storage userA = usersDe[1];
    }

    //-----------------memory----------------------
    function fooMem() internal {
        UserDemo memory _user = usersDe[0];

        //this line only changes the name for the execution of this function only. It wont change inside the storage value.
        _user.name = "ELon";
        fooMemA(_user);
    }

    function fooMemA(UserDemo memory _user) internal {}

    //-----------------stack----------------------
    function fooStack() external {
        uint b;
    }

    //-----------------calldata----------------------
    function fooCallData(uint[] calldata scoresList) external {}

    //------------------------------------//
    //--->            Events          <---//
    //------------------------------------//

    /**
     * if you want filter events then use 'indexed' keywords to the fields inside the event for which you want to filter by.💡
     * max 3 'indexed' keywords can be used.💰
     * more expensive if used 'indexed' - extra work indexing.
     *
     * events emitted cannot be accessed from within in the contract.😆
     *
     * As events are not stored using storage varible, these uses lower gas compared to stroage variables. So use events, if you dont want to store variables inside smart contract.
     * TODO : DO OR.
     */

    event NewTrade(uint date, address from, address to, uint amount);

    function trade(address to, uint amount) external {
        emit NewTrade(block.timestamp, msg.sender, to, amount);
    }
}

contract Inherited is RefreshSolidity {
    function callIncreaseBalance(uint256 amount) public {
        _increaseBalanceInternal(amount);
    }
}
