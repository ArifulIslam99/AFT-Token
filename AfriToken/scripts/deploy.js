const hre = require("hardhat");

async function main() {
    const AfriToken = await hre.ethers.getContractFactory("AfriToken");
    const afritoken = await AfriToken.deploy(100000000, 50000);

    // await afritoken.waitForDeployment();
    console.log("Token Deployed At", afritoken.target);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
