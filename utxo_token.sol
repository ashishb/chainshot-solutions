// Solution to https://www.chainshot.com/challenges/5beb40b11cf372546bb72917/stage/5beb41081cf372546bb7291a
pragma solidity ^0.4.19;

contract Token {
  
  address owner;
  mapping(uint256 => address) utxoIdToUtxoOwner;
  mapping(uint256 => uint256) utxoIdToAmount;
  uint256 utxoIdCount;

  modifier ownerOnly() {
      require(msg.sender == owner);
      _;
  }

  event NewUTXO(address owner, bytes32 id, uint256 value);

  function Token() public {
      owner = msg.sender;
  }

  function initialize(address _utxoOwner, uint _numTokens) ownerOnly public {
      _createUtxo(_utxoOwner, _numTokens);
  }

  function spend(bytes32 utxoId, uint256 amount, address receiver) public {
      // Confirm ownership
      require(msg.sender == utxoIdToUtxoOwner[uint(utxoId)]);
      // Confirm amount
      require(utxoIdToAmount[uint(utxoId)] >= amount);
      _createUtxo(receiver, amount);
      // return change
      if (amount < utxoIdToAmount[uint(utxoId)]) {
        _createUtxo(msg.sender,  utxoIdToAmount[uint(utxoId)] - amount);
      }
      // Kill previous UTXO
      utxoIdToAmount[uint(utxoId)] = 0;
  }

  function _createUtxo(address _utxoOwner, uint _numTokens) internal {
      // Create the new UTXO
      utxoIdToUtxoOwner[utxoIdCount] = _utxoOwner;
      utxoIdToAmount[utxoIdCount] = _numTokens;
      // Emit the event
      NewUTXO(_utxoOwner, bytes32(utxoIdCount), _numTokens);
      // Increment for the next UTXO creation
      utxoIdCount += 1;
  }
}
