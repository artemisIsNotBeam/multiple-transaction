// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "token/ERC20/ERC20.sol";
import "token/ERC20/IERC20.sol";


interface ERC20 {
    function balanceOf(address owner) external view returns (unit);
    function allowance(address owner, address spender) external view returns (unit);
    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool); 

    //If you want to interact with other functions
    // you need to put them up there
}

contract Interact{

    function Transfer(address _owner, address _token, unit _amount, address _who) public {
        ERC20(_token).transferFrom(_owner, _who, _amount);
    }
    function getBalanceOfToken(address _address, address _tokenAdd) public view returns (unit) {
        return ERC20(_address).balanceOf(address(this));
    }
}