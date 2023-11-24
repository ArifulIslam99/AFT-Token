const hre = require("hardhat");

async function main() {
  const Faucet = await hre.ethers.getContractFactory("Faucet");
  const faucet = await  Faucet.deploy('0x0e38edd99c2A3Abc448E7FEEee3823cf2b8Ef338');
  await faucet.deployed();

  console.log("Faucet Deployed At", faucet.address);
  
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


// Faucet Deployed At 0xc51aeEf21d2bb2552eDd03359E7056bB42cef367