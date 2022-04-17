// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract payout {
    //ok now for explaining
    uint WeiToETH = 1e18;

    event Deposit(address sender, uint amount);
    event Transfer(address sender, address receiver, uint amount);

    function splitETH(address[] calldata _wallets, uint _howmuchInEth) payable public{
        require(_howmuchInEth < msg.value * WeiToETH);
        // find how much if an equal split
        uint muchPer = _howmuchInEth / _wallets.length;
        // loop through
        for (uint i=0;i<_wallets.length;i++){
            address walletTo = _wallets[i];
            emit Transfer(msg.sender, walletTo, muchPer);
        }
    }

    // for refrence check for mat in Example Enter.js

    function payCheck(address[] calldata _addressPay, uint[] calldata _amountPay) payable public{
        require(_addressPay.length == _amountPay.length);
        uint totalNow = 0;
        for (uint j=0; j<_addressPay.length;j++){
            uint amount = _amountPay[j];
            address daAdd = _addressPay[j];

            totalNow += amount;
        }
        require(msg.value >= totalNow);
    }
}