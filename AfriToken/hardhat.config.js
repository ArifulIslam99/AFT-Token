require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.20", // Specifies the default Solidity compiler version
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};