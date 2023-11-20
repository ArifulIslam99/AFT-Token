require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()
/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: '0.8.20',
  networks: {
    sepolia: {
      url: 'https://eth-sepolia.g.alchemy.com/v2/5N-4regG-0_aCxgDKJz4Zt_U8gVc8atH',
      accounts: ['a7a9bfc914c4f13e4df85a73f2a336fc51ac7ff7104ba53c339c13a738dc1b31']
    }
  }
}