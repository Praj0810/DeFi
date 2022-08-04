// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Neo is ERC20 {
    constructor(string memory _name, string memory _symbol) ERC20(_name ,_symbol){
    }

    function _mint(uint _amount) public {
        _mint(msg.sender, _amount);
    }

}