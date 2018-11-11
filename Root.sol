// Solution to https://www.chainshot.com/challenges/5be18681626daf0f9392cf39/stage/5be18729626daf0f9392cf3a
pragma solidity ^0.4.19;

contract Root {
  
  function findRoot(bytes bytesArr) public pure returns (bytes32) {
      uint i;
      bytes32 ans;

      for (i = 0; i < 32; i++) {
        ans = bytes32((uint256(ans) * 256) + uint256(bytesArr[i]));
      }

      // Case 1: Only one 32-byte hash in the bytesArr.
      // Handle == 32 bytes case first, since rest of the code assumes at least 64 bytes of array.
      if (bytesArr.length == 32) {
          return ans;
      }

      // Note: Using byte[32] does not work here, I am not fully sure why though.
      bytes32 tmpArr;
      // Init
      for (i = 32; i < 64; i++) {
          tmpArr = bytes32((uint256(tmpArr) * 256) + uint256(bytesArr[i]));
      }
      ans = keccak256(uint256(ans), uint256(tmpArr));

      // Case 2: Only two 32-bytes hashes in the bytesArr.
      if (bytesArr.length == 64) {
          return ans;
      }
 
      // Case 3: More than two 32-bytes hashes in the bytesArr.
      uint j;
      for (i = 64; i < bytesArr.length; i += 32) {
        tmpArr = bytes32(0);
        for (j = 0; j < 32; j++) {
            tmpArr = bytes32((uint256(tmpArr) * 256) + uint256(bytesArr[i + j]));
        }
        ans = keccak256(uint256(ans), uint256(tmpArr));
      }
      return ans;
  }
}
