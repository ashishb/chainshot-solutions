// Solution to https://www.chainshot.com/challenges/5ba1c494e6b0b01133b453b2/stage/5ba1c57de6b0b01133b453b3
pragma solidity ^0.4.18;

import "./ERC721.sol";

contract Marketplace is ERC721 {
    address public owner;
    uint256 public itemId = 1;

    mapping(uint => GameItem) public gameItems;

    struct GameItem {
        string name;
        uint256 attackPower;
    }

    function Marketplace() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function createItem(string _name, uint256 _attackPower, address _to) public onlyOwner {
        _mint(_to, itemId);
        GameItem memory game = GameItem(_name, _attackPower);
        gameItems[itemId] = game;
        itemId++;
    }

    function tradeItem(uint256 _itemId, address _to) public canOperate(_itemId) {
        _safeTransferFrom(msg.sender, _to, _itemId, "");
    }
}
