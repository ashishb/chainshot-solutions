// Solution to https://www.chainshot.com/challenges/5b8df76ce6b0b0577be62801/stage/5b8df954e6b0b0577be62802

pragma solidity ^0.4.18;

contract Investment {
    address public owner;
    uint256 public exchangeRate = 5;
    uint public tokens = 1000000;
    address[] public validInvestors;
    uint256[] public investorTokens;
    mapping (address => uint256) private balances;
    
    uint unlockTime;
    bool withdrawalApproved;
    mapping (address => uint256) private investorToTokenMap;

    function Investment(uint _unlockTimeInDays) public {
        owner = msg.sender;
        unlockTime = _unlockTimeInDays * 24 * 3600 * 1000 + now;
    }

    /* 
    @dev The purpose of this function is for
        investors to put Ether into the contract
        in exchange for some tokens when a distribution occurs.
    */
    function invest() public payable {
        require(msg.value * exchangeRate < tokens);
        validInvestors.push(msg.sender);
        investorTokens.push(msg.value * exchangeRate);
        investorToTokenMap[msg.sender] = investorToTokenMap[msg.sender] + msg.value * exchangeRate;
    }

    function transferToken(address _investor, uint _investorToken) public {
        balances[_investor] = _investorToken;
        tokens -= _investorToken;
        investorToTokenMap[_investor] -= _investorToken;
    }
    /*
    @dev The purpose of this function is to distribute tokens
        to investors once an owner has decided to initiate a distribution.
    */
    function distribute() public {
        require(msg.sender == owner);
        for(uint i = 0; i < validInvestors.length; i++) {
            transferToken(validInvestors[i], investorTokens[i]);
        }
    }

    function approveWithdraw() public {
        require(msg.sender == owner || (now > unlockTime));
        withdrawalApproved = true;
    }

    function withdraw() public {
        require(withdrawalApproved == true);
        require(investorToTokenMap[msg.sender] > 0);
        transferToken(msg.sender, investorToTokenMap[msg.sender]);
    }
}
