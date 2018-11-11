// Solution to https://www.chainshot.com/challenges/5bd4f35d626daf1162be4c1d/stage/5bd4f3be626daf1162be4c1e
pragma solidity ^0.4.18;

contract Parity {
  
  event Even();
  event Odd();

  function check(bytes32 byteArr) public {
      if (uint256(byteArr) % 2 == 1) {
          Odd();
      } else {
          Even();
      }
  }
}
