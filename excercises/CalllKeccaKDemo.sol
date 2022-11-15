// SPDX-License-Identifier: MIT

/**
 * this problem is taken from contracts/CallAnything.sol
 * Problem :
 *  - Identify and fix the problem why s_someAddress and s_amount cant be updated when called callTransferFunctionDirectly with params.?
 *  - Solution : 
 *      - in line 43 : getSelectorOne() -> returns the selector for transfer function. But if you   check correctly, in 26 line : transfer(address, uint256) at here, there is a space between params.
 *      - this results in returning the diff keccak hash which inturn has diff selector.
 *      - so, the transfer function will never be called.
 *      - remove the space ->transfer(address,uint256), then it works.
 */

pragma solidity ^0.8.7;

contract CallAnything {
    address public s_someAddress;
    uint256 public s_amount;

    function transfer(address someAddress, uint256 amount) public {
        // Some code
        s_someAddress = someAddress;
        s_amount = amount;
    }
    function getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address, uint256)")));
    }
    function getDataToCallTransfer(address someAddress, uint256 amount)
        public
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(getSelectorOne(), someAddress, amount);
    }

    // So... How can we use the selector to call our transfer function now then?
    function callTransferFunctionDirectly(address someAddress, uint256 amount)
        public
        returns (bytes4, bool)
    {
        (bool success, bytes memory returnData) = address(this).call(
            // getDataToCallTransfer(someAddress, amount);
            abi.encodeWithSelector(getSelectorOne(), someAddress, amount)
        );
        return (bytes4(returnData), success);
    }

}
