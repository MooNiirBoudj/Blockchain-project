const hre = require("hardhat");

async function main() {
  console.log("🚀 Starting ClubGov deployment...\n");

  // Get the contract factory
  const ClubGov = await hre.ethers.getContractFactory("ClubGov");
  
  // Deploy the contract
  console.log("📝 Deploying ClubGov contract...");
  const clubGov = await ClubGov.deploy();
  
  await clubGov.waitForDeployment();
  
  const contractAddress = await clubGov.getAddress();
  console.log(`✅ ClubGov deployed to: ${contractAddress}\n`);

  // Get deployer address
  const [deployer] = await hre.ethers.getSigners();
  const deployerAddress = await deployer.getAddress();
  console.log(`👤 Deployed by: ${deployerAddress}`);
  console.log(`💰 Deployer balance: ${hre.ethers.formatEther(await hre.ethers.provider.getBalance(deployerAddress))} ETH\n`);

  // Fund the treasury with some initial ETH
  console.log("💵 Funding treasury with 10 ETH...");
  const fundTx = await deployer.sendTransaction({
    to: contractAddress,
    value: hre.ethers.parseEther("10.0")
  });
  await fundTx.wait();
  
  const treasuryBalance = await clubGov.getTreasuryBalance();
  console.log(`✅ Treasury funded: ${hre.ethers.formatEther(treasuryBalance)} ETH\n`);

  // Add some initial members (optional)
  const accounts = await hre.ethers.getSigners();
  if (accounts.length > 1) {
    console.log("👥 Adding initial members...");
    for (let i = 1; i < Math.min(4, accounts.length); i++) {
      const memberAddress = await accounts[i].getAddress();
      const tx = await clubGov.addMember(memberAddress);
      await tx.wait();
      console.log(`   ✓ Added member: ${memberAddress}`);
    }
    
    const memberCount = await clubGov.memberCount();
    console.log(`✅ Total members: ${memberCount}\n`);
  }

  // Display contract information
  console.log("📋 Contract Information:");
  console.log("─────────────────────────────────────────────────────────────");
  console.log(`Contract Address: ${contractAddress}`);
  console.log(`Owner: ${await clubGov.owner()}`);
  console.log(`Member Count: ${await clubGov.memberCount()}`);
  console.log(`Treasury Balance: ${hre.ethers.formatEther(await clubGov.getTreasuryBalance())} ETH`);
  console.log(`Required Votes: ${await clubGov.getRequiredVotes()}`);
  console.log("─────────────────────────────────────────────────────────────\n");

  // Save contract address to file
  const fs = require("fs");
  const contractData = {
    address: contractAddress,
    deployer: deployer.address,
    network: hre.network.name,
    deployedAt: new Date().toISOString()
  };

  const deploymentPath = "./frontend/src/contracts/deployment.json";
  fs.mkdirSync("./frontend/src/contracts", { recursive: true });
  fs.writeFileSync(deploymentPath, JSON.stringify(contractData, null, 2));
  console.log(`💾 Contract address saved to: ${deploymentPath}`);

  // Save ABI
  const artifact = await hre.artifacts.readArtifact("ClubGov");
  fs.writeFileSync(
    "./frontend/src/contracts/ClubGov.json",
    JSON.stringify(artifact, null, 2)
  );
  console.log(`💾 Contract ABI saved to: ./frontend/src/contracts/ClubGov.json\n`);

  console.log("🎉 Deployment complete!\n");
  console.log("📌 Next steps:");
  console.log("   1. Copy the contract address above");
  console.log("   2. Update your frontend with the contract address");
  console.log("   3. Start your frontend: cd frontend && npm start");
  console.log("   4. Connect MetaMask to localhost:8545\n");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });