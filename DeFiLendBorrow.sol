// SPDX-License-Identifier: GPL-3.0

/****
 *@title A Smart Contract of DeFi Lending and Borrowing
 *@author Prajakta Mohite
 *@dev Functionality of lending and Borrowing is shown
 *@notice In this contract user is despositing ether and getting Neo token in return also 
 *user is Borrowing ether and despositing Neotokens
 */
pragma solidity >=0.7.0 <0.9.0;
//Import Neo contarct consist of ERC20 contract
import "./Neo.sol";

contract DeFiLendBorrow is Neo {
    mapping(address => uint256) public balancetoken;
    address public contractOwner;

    constructor(string memory _name, string memory _symbol) 
        Neo(_name, _symbol)
    {
        contractOwner = msg.sender;
    }
    // 1 ether = 100 neo tokens
    // check for minimum value of ether to lend
    modifier minimumEth() {
        require(msg.value >= 1 ether, " Amount to lend should be 1 ether");
        _;
    }

    modifier miniNeotoken(uint256 _tokens){
        require(balanceOf(msg.sender) >= _tokens , "tokens are less than 100");
        _;
    }
    /**
     *@notice - This function is payable will lend ether and gets Neo token
     *@dev In tnis function only if the User has ether to desposit then only the neo 
     * tokens are minted
     */
    function lendingEther() public payable minimumEth{
        uint NeotokenPrice = msg.value/ 10 ** 16; //100 tokens
        _mint(NeotokenPrice);
    }
    /**
    *@notice - This function will desposit the neo Token and the user with get the ether.
    *Minimum count of token must be 100.
    *@param _tokens this is used to as a count of Neo token available with the user.
    */
    function withdrawEth(uint _tokens) public miniNeotoken(_tokens) {
      transfer(address(this),_tokens);
      uint EthAmount = _tokens * 10**16;
      payable(msg.sender).transfer(EthAmount);
  }
    /**
    *@notice This function gives the balance of the ether desposited 
    *@return balance of ether of the contract
    */
    function getBalance() public view returns(uint){
        return address(this).balance;
     }

}
