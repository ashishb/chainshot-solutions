// Solution to https://www.chainshot.com/challenges/5baaf085929d249ffe952a51/stage/5baaf12c929d249ffe952a52
pragma solidity ^0.4.19;

import "./EIP20.sol";

contract TreasureChest {
  
    function withdraw(address[] _addresses) public {
        for (uint i = 0; i < _addresses.length; i++) {
            EIP20 c1 = EIP20(_addresses[i]);
            c1.transfer(msg.sender, c1.balanceOf(this));
        }
    }
}
