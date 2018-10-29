// Solution to https://www.chainshot.com/challenges/5b8332b6d9f99799d09d5bdf/stage/5b847293d9f9972c8de2efa0
pragma solidity ^0.4.19;

contract BananaStand {
  uint8 public bananas;

  function addBananas(uint8 newBananas) public {
      if (bananas + newBananas > bananas) {
        bananas += newBananas;
      }
  }

  function removeBananas(uint8 newBananas) public {
      if (bananas - newBananas < bananas) {
        bananas -= newBananas;
      }
  }
}
