// Solution to https://www.chainshot.com/challenges/5bcf95321cf372448c2e26af/stage/5bcfef901cf372e300ff2b7a
pragma solidity ^0.4.19;

contract Party {
  
  uint256 minAmount;
  address[] partyGoers;

  function Party(uint256 minAmount_) public {
    minAmount = minAmount_;
  }

  function rsvp() payable public {
    if (msg.value < minAmount) {
      msg.sender.transfer(msg.value);
      return;
    }

    if (msg.value > minAmount) {
      msg.sender.transfer(msg.value - minAmount);
    }
    partyGoers.push(msg.sender);
  }

  function payBill(uint256 amount_) public {
    require(amount_ <= minAmount * partyGoers.length);
    uint256 refundAmount = (minAmount * partyGoers.length - amount_) / partyGoers.length;
    for (uint i = 0; i < partyGoers.length; i++) {
      partyGoers[i].transfer(refundAmount);
    }
  }
}
