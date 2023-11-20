// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract AfriCoin is ERC20Capped, ERC20Burnable {
    address payable public manager;
    uint256 public blockReward;

    constructor(
        uint256 cap,
        uint256 reward
    ) ERC20("AfriToken", "AFT") ERC20Capped(cap * (10 ** decimals())) {
        manager = payable(msg.sender);
        _mint(manager, 70000000 * (10 ** decimals()));
        blockReward = reward * (10 ** decimals());
    }

    function setBlockReward(uint256 reward) public onlyManager {
        blockReward = reward * (10 ** decimals());
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 value
    ) internal virtual {
        if (
            from != address(0) &&
            to != block.coinbase &&
            block.coinbase != address(0)
        ) {
            _mintMinerReward();
        }
        // super._beforeTokenTransfer();
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual override(ERC20, ERC20Capped) {
        super._update(from, to, value);

        if (from == address(0)) {
            uint256 maxSupply = cap();
            uint256 supply = totalSupply();
            if (supply > maxSupply) {
                revert ERC20ExceededCap(supply, maxSupply);
            }
        }
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function destroyToken() internal onlyManager {
        selfdestruct(manager);
    }

    modifier onlyManager() {
        require(msg.sender == manager, "Only Manager Can Invoke!");
        _;
    }
}

//***Token Design Plan***//
// Planned Max Total Supply 100 Million   (100000000000000000000000000)
// Initial Supply to the owner 70 Million (70000000000000000000000000)
// Tokens are burnable
// BlockRewards to reward new supply to distributor
