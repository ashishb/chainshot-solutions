// Solution to https://www.chainshot.com/challenges/5bc74dce1cf372ed6d4125aa/stage/5bc750351cf372ed6d4125b4
pragma solidity ^0.4.19;

contract Voting {
  
  address public owner;
  uint public totalVotes;
  mapping(address => uint) public voters;

  function Voting() public {
      owner = msg.sender;
  }

  modifier ownerOnly() {
      require (msg.sender == owner);
      _;
  }

  function register(address _voter) ownerOnly public {
      voters[_voter] = 1;
      totalVotes += 1;
  }

  function vote(bool _support) public {
      require(voters[msg.sender] == 1);
      if (_support) {
          voters[msg.sender] = 3;
      } else {
          voters[msg.sender] = 2;
      }
  }

  function numberVotes() public view returns (uint) {
      return totalVotes;
  }

  function myVote() public view returns (int) {
      if (voters[msg.sender] <= 1) {
          return -1;
      } else if (voters[msg.sender] == 2) {
          return 0;
      } else {
          return 1;
      }
  }
}
