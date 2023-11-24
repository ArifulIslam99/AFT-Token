// contracts/AftToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface IERC20 {
    function transfer(address to, uint256 amount) external view returns (bool);

    function balanceOf(address account) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract Faucet {
    address payable manager;
    IERC20 public token;
    uint256 public withDrawlAmount = 50 * (10 ** 18);
    uint256 public lockTime = 1 minutes;
    mapping(address => uint256) nextAccessTime;

    event Deposit(address indexed from, uint256 indexed amount);
    event WithDrawl(address indexed from, uint256 indexed amount);

    constructor(address tokenAddress) payable {
        token = IERC20(tokenAddress);
        manager = payable(msg.sender);
    }

    function requestToken() public {
        require(msg.sender != address(0), "Need a valid account to withdraw");
        require(
            token.balanceOf(address(this)) > withDrawlAmount,
            "Insufficient Balance in Fauchet"
        );
        require(
            block.timestamp >= nextAccessTime[msg.sender],
            "Too Quick Request, Try Later!"
        );
        nextAccessTime[msg.sender] = block.timestamp + lockTime;
        token.transfer(msg.sender, withDrawlAmount);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function getBalance() external view returns (uint256) {
       return token.balanceOf(address(this));
    }

    function withDrawl() external onlyManager {
        emit WithDrawl(msg.sender, token.balanceOf(address(this)));
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }

    modifier onlyManager() {
        require(msg.sender == manager, "Only the owner can call this function");
        _;
    }
}
