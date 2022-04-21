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
}

contract payout {
    //ok now for explaining
    uint WeiToETH = 1e18;

    event Deposit(address sender, uint amount);
    event Transfer(address sender, address receiver, uint amount);

    function splitETH(address[] calldata _wallets, uint _howmuchInEth) payable public{
        require(_howmuchInEth < msg.value * WeiToETH, "You don't have that much money");
        // find how much if an equal split
        uint muchPer = _howmuchInEth / _wallets.length;
        // loop through
        for (uint i=0;i<_wallets.length;i++){
            address walletTo = _wallets[i];
            emit Transfer(msg.sender, walletTo, muchPer);
        }
    }

    // for refrence check for mat in Example ExampleEnter.sol

    function payCheck(address[] calldata _addressPay, uint[] calldata _amountPay) payable public{
        //if they're not the same length thats gonna cause a serious probblem
        require(_addressPay.length == _amountPay.length);
        //we're gonna add them up so we make sure they have enough  money
        uint totalNow = 0;
        for (uint j=0; j<_addressPay.length;j++){
            uint amount = _amountPay[j];
            //make sure they have enough
            totalNow += amount;
        }
        require(msg.value >= totalNow,"You don't have that much money");
        //running it 4 real now
        for (uint j=0; j<_addressPay.length;j++){
            uint much = _amountPay[j];
            address daWallet = _addressPay[j];
            //send them the money
            emit Transfer(msg.sender, daWallet, much);
        }
    }

    // TODO do this link https://stackoverflow.com/questions/65846335/how-to-send-erc20-token-to-smart-contract-balance
    // ALso, whenever they use this in code its refrencing its own address

    function Transfer(address _owner, address _token, unit _amount, address _who) public {
        ERC20(_token).transferFrom(_owner, _who, _amount);
    }
    // need these two functions before the other 2
    function getBalanceOfToken(address _address, address _tokenAdd) public view returns (unit) {
        return ERC20(_address).balanceOf(address(this));
    }

}