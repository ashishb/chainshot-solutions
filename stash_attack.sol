// Solution to https://www.chainshot.com/challenges/5b256f43d9f997a91fff3d01/stage/5b2729e8d9f9970e8ed24191
pragma solidity ^0.4.19;

contract Stash {
    mapping(address => uint) public balances;

    function addToBalance() public payable {
        balances[msg.sender] = balances[msg.sender] + msg.value;
    }

    function withdrawBalance() public {
        uint amountToWithdraw = balances[msg.sender];
        balances[msg.sender] = 0;
        if(!msg.sender.call.value(amountToWithdraw)()) {
            revert();
        }
    }
}
