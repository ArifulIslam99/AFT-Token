
const hre = require("hardhat");

async function main() {
  const AftToken = await hre.ethers.getContractFactory("AftToken");
  const aftToken = await  AftToken.deploy(100000000, 100);
  await aftToken.deployed();

  console.log("Deployed At", aftToken.address);
  
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
// Deployed At 0x0e38edd99c2A3Abc448E7FEEee3823cf2b8Ef338