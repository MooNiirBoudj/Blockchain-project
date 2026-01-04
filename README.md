Decentralized Autonomous Organization for Scientific Club Treasury Management

📋 Table of Contents

Overview
Prerequisites
Project Structure
Installation
Running the Application
MetaMask Configuration
Using the Application
Troubleshooting
Testing
Deployment
Technical Specifications

🎯 Overview
ClubGov DAO is a blockchain-based decentralized autonomous organization that enables transparent and democratic treasury management for scientific clubs and research organizations. Members can:

💰 Manage a shared treasury
📝 Create spending proposals
🗳️ Vote democratically (51% majority)
⚡ Execute approved proposals automatically
🔍 View complete transaction history

📦 Prerequisites
Before you begin, ensure you have the following installed:
Required Software

Node.js (v16 or higher) - Download
npm (v7 or higher, comes with Node.js)
MetaMask browser extension - Install

Verify Installation
bashnode --version # Should show v16.x.x or higher
npm --version # Should show v7.x.x or higher
Optional (Recommended)

Git - Download
VS Code or any code editor

📁 Project Structure
clubgov-dao/
├── contracts/ # Smart contracts
│ └── ClubGov.sol # Main DAO contract
├── scripts/ # Deployment scripts
│ └── deploy.js # Automated deployment
├── frontend/ # React frontend
│ ├── public/
│ │ └── index.html # HTML with CDN scripts
│ ├── src/
│ │ ├── App.js # Main React component
│ │ └── index.js # React entry point
│ └── package.json # Frontend dependencies
├── hardhat.config.js # Hardhat configuration
├── package.json # Project dependencies
└── README.md # This file

🚀 Installation
Step 1: Clone or Download the Project
Option A: Using Git
bashgit clone [your-repository-url]
cd clubgov-dao
Option B: Download ZIP

Download and extract the project ZIP file
Open terminal/command prompt
Navigate to the project folder:

bash cd path/to/clubgov-dao
Step 2: Install Backend Dependencies
Install Hardhat and blockchain development tools:
bashnpm install
Expected output:
added 500+ packages in 30s
Step 3: Install Frontend Dependencies
Navigate to the frontend folder and install React dependencies:
bashcd frontend
npm install
cd ..
Expected output:
added 1400+ packages in 45s

🎮 Running the Application
You need THREE terminal windows open simultaneously. Follow these steps in order:
Terminal 1: Start Local Blockchain
Open your first terminal and run:
bashnpx hardhat node
✅ Expected Output:
Started HTTP and WebSocket JSON-RPC server at http://127.0.0.1:8545/

# Accounts

WARNING: These accounts, and their private keys, are publicly known.
Any funds sent to them on Mainnet or any other live network WILL BE LOST.

Account #0: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 (10000 ETH)
Private Key: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

Account #1: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 (10000 ETH)
Private Key: 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d

[... more accounts ...]
⚠️ IMPORTANT: Keep this terminal running! This is your local Ethereum blockchain.
📝 Copy the private keys - you'll need them for MetaMask!

Terminal 2: Deploy Smart Contract
Open a NEW terminal window (keep Terminal 1 running) and run:
bashnpx hardhat run scripts/deploy.js --network localhost
✅ Expected Output:
🚀 Starting ClubGov deployment...

📝 Deploying ClubGov contract...
✅ ClubGov deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3

👤 Deployed by: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
💰 Deployer balance: 9999.998537342658203125 ETH

💵 Funding treasury with 10 ETH...
✅ Treasury funded: 10.0 ETH

👥 Adding initial members...
✓ Added member: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
✓ Added member: 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
✓ Added member: 0x90F79bf6EB2c4f870365E785982E1f101E93b906
✅ Total members: 4

📋 Contract Information:
─────────────────────────────────────────────────────────────
Contract Address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Owner: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Member Count: 4
Treasury Balance: 10.0 ETH
Required Votes: 2
─────────────────────────────────────────────────────────────

💾 Contract address saved to: ./frontend/src/contracts/deployment.json
💾 Contract ABI saved to: ./frontend/src/contracts/ClubGov.json

🎉 Deployment complete!
📋 COPY THE CONTRACT ADDRESS! You'll need it if you have to update the frontend.

Terminal 3: Start Frontend
Open a THIRD terminal window and run:
bashcd frontend
npm start
✅ Expected Output:
Compiled successfully!

You can now view frontend in the browser.

Local: http://localhost:3000
On Your Network: http://192.168.1.x:3000

webpack compiled with 0 warnings
🌐 The browser should automatically open to: http://localhost:3000
If it doesn't, manually navigate to: http://localhost:3000

🦊 MetaMask Configuration
Step 1: Add Localhost Network to MetaMask

Open MetaMask extension in your browser
Click the network dropdown at the top (shows "Ethereum Mainnet" by default)
Click "Add network" → "Add a network manually"
Fill in the following details:

Network Name: Localhost 8545
New RPC URL: http://127.0.0.1:8545
Chain ID: 31337
Currency Symbol: ETH
Block Explorer: (leave blank)

Click "Save"
Select "Localhost 8545" from the network dropdown

✅ You should now see "Localhost 8545" at the top of MetaMask

Step 2: Import Test Accounts
You need to import at least 3-4 accounts for full functionality testing.
🔐 Account #0 - ADMIN/OWNER (Most Important!)
This is the main admin account. Import this first!

Click the account icon (top right) in MetaMask
Click "Import Account"
Select "Private Key"
Paste this private key:

0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

Click "Import"

✅ Success! This account has:

Address: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Balance: 10,000 ETH
Role: Admin/Owner
Powers: Add members, cancel proposals, vote, create proposals

💡 Tip: Right-click the account → Account details → Edit → Rename to "Admin Account"

🔐 Account #1 - Member

Click account icon → "Import Account"
Paste private key:

0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d

Click "Import"

Address: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

🔐 Account #2 - Member

Import Account again
Paste private key:

0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a

Click "Import"

Address: 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

🔐 Account #3 - Member

Import Account again
Paste private key:

0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6

Click "Import"

Address: 0x90F79bf6EB2c4f870365E785982E1f101E93b906

Step 3: Clear MetaMask Activity
⚠️ CRITICAL STEP - Do this every time you restart Hardhat!

Open MetaMask → Click the three dots (⋮)
Go to Settings → Advanced
Scroll down and click "Clear activity tab data"
Click "Clear" to confirm

Why? MetaMask caches blockchain data. When you restart Hardhat, the blockchain resets, so MetaMask needs to clear its cache.

🎯 Using the Application
First Connection

Open http://localhost:3000 in your browser
Make sure MetaMask is on "Localhost 8545" network
Select Account #0 (Admin) in MetaMask
Click "Connect Wallet" button in the app
Approve the connection in MetaMask popup

✅ You should now see:

Your wallet address: 0xf39F...92266
"✓ Member" badge (green)
"👑 Admin" badge (blue)
Treasury: 10.0 ETH
Members: 4
Proposals: 0
Required Votes: 2
Admin Panel section

Features Guide
🔐 As Admin (Account #0)

1. Add a New Member

Scroll to "👑 Admin Panel" section
Click "Add Member"
Paste an address (e.g., Account #4: 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65)
Click "Add Member"
Approve the transaction in MetaMask
Wait for confirmation
See member count increase from 4 to 5

📝 As Member (Any Account) 2. Create a Spending Proposal

Click "New Proposal" button
Fill in the form:

Description: "Purchase spectrophotometer for chemistry lab"
Amount (ETH): 2
Recipient Address: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

Click "Create Proposal"
Approve in MetaMask
Wait for confirmation
See proposal appear in the "Proposals" section

💡 Tip: The recipient can be any Ethereum address. For testing, use one of your imported accounts.

🗳️ Voting on Proposals 3. Vote Yes or No

Find the proposal in the list
You'll see two buttons: "Vote Yes" and "Vote No"
Click your choice
Approve in MetaMask
Wait for confirmation
See vote count update (e.g., "1 Yes, 0 No")

⚠️ Rules:

Each member can vote only once per proposal
After voting, you'll see "✓ You have voted on this proposal"
Need 51% of members to pass (with 4 members = 2 votes required)

4. Vote from Multiple Accounts
   To test the full voting system:

Vote with Account #1:

Switch to Account #1 in MetaMask
Page refreshes automatically
Click "Vote Yes"
Approve in MetaMask

Vote with Account #2:

Switch to Account #2 in MetaMask
Click "Vote Yes"
Approve in MetaMask

Check the vote count: Should now show "2 Yes, 0 No"

⚡ Executing Proposals 5. Execute Approved Proposal
Once a proposal reaches the required votes (2 out of 4 = 51%):

An "Execute Proposal" button appears
Click "Execute Proposal" (any member can do this)
Approve in MetaMask
Wait for confirmation

✅ Results:

Proposal status changes to "Executed"
Treasury balance decreases (e.g., 10 ETH → 8 ETH)
Funds transferred to recipient address
Transaction recorded permanently on blockchain

Switching Between Accounts
To test different member roles:

Click MetaMask extension
Click the account dropdown at the top
Select a different account
The app will automatically refresh
If prompted, click "Connect Wallet" again

💡 Each account shows different information:

Admin Account: Shows Admin Panel + all member features
Member Accounts: Can create proposals, vote, execute
Non-Member Accounts: Can only view (no interaction buttons)

🐛 Troubleshooting
❌ Error: "Failed to connect wallet"
Solutions:

✅ Verify MetaMask is on "Localhost 8545" network
✅ Check Terminal 1 - is npx hardhat node still running?
✅ Refresh the browser page (F5)
✅ Try disconnecting and reconnecting MetaMask

❌ Error: "Failed to load contract data"
Symptoms: Dashboard shows 0 ETH, 0 members, errors in console
Solutions:

✅ Check if Hardhat node is running (Terminal 1)
✅ Verify contract was deployed (Terminal 2 should show "✅ ClubGov deployed")
✅ Check if CONTRACT_ADDRESS in frontend/src/App.js matches deployed address
✅ Clear MetaMask activity: Settings → Advanced → "Clear activity tab data"
✅ Hard refresh browser: Ctrl+Shift+R (Windows) or Cmd+Shift+R (Mac)

If still failing:
bash# Terminal 1: Restart Hardhat (Ctrl+C, then):
npx hardhat node

# Terminal 2: Redeploy

npx hardhat run scripts/deploy.js --network localhost

# Copy the NEW contract address

# Update frontend/src/App.js line ~24:

const CONTRACT_ADDRESS = "YOUR_NEW_ADDRESS_HERE";

# Terminal 3: Restart frontend (Ctrl+C, then):

cd frontend
npm start

# MetaMask: Clear activity tab data

# Browser: Hard refresh (Ctrl+Shift+R)

❌ Error: "Nonce too high" or Transaction Failures
Cause: MetaMask has cached data from previous blockchain state
Solution:

Open MetaMask
Click Settings → Advanced
Click "Clear activity tab data"
Click "Clear"
Refresh browser page

💡 Do this EVERY TIME you restart Hardhat node!

❌ MetaMask Not Connecting / Wrong Network
Solutions:

✅ Click MetaMask network dropdown
✅ Select "Localhost 8545"
✅ If not there, re-add the network:

RPC URL: http://127.0.0.1:8545
Chain ID: 31337

❌ Account Not a Member / No Vote Buttons
Symptoms: Connected but can't interact, no "✓ Member" badge
Cause: You're using an account that wasn't added as a member
Solution Option 1 - Use Default Members:
Switch to one of these accounts:

Account #0: 0xf39Fd6...92266 (Admin)
Account #1: 0x70997...c79C8 (Member)
Account #2: 0x3C44C...293BC (Member)
Account #3: 0x90F79...b906 (Member)

Solution Option 2 - Add Your Account:

Switch to Account #0 (Admin) in MetaMask
Use Admin Panel to add your current account
Switch back to your account

❌ "Cannot read properties of undefined (reading 'providers')"
Cause: Ethers.js CDN not loaded
Solution:

Open frontend/public/index.html
Verify this line exists in <head>:

html <script src="https://cdnjs.cloudflare.com/ajax/libs/ethers/5.7.2/ethers.umd.min.js"></script>

Save and hard refresh: Ctrl+Shift+R

❌ Contract Address Changed After Restarting
This is NORMAL! Hardhat generates new addresses when restarted.
Solution:

Copy the new address from Terminal 2 deployment output
Update frontend/src/App.js line ~24
Clear MetaMask activity
Refresh browser

🧪 Testing
Manual Testing Workflow
Test 1: Member Management

1. Connect as Admin (Account #0)
2. Add Account #4 as member
3. Verify member count increases to 5
4. Switch to Account #4
5. Verify "✓ Member" badge appears
   Test 2: Proposal Creation
6. Connect as Member (Account #1)
7. Create proposal for 2 ETH
8. Verify proposal appears in list
9. Verify treasury still shows 10 ETH
   Test 3: Voting
10. Vote Yes with Account #1
11. Switch to Account #2, vote Yes
12. Verify vote counts: 2 Yes, 0 No
13. Verify "Execute Proposal" button appears
    Test 4: Execution
14. Click "Execute Proposal"
15. Verify treasury decreases to 8 ETH
16. Verify proposal status: "Executed"
17. Check recipient address balance increased
    Test 5: Voting Restrictions
18. Vote with Account #1
19. Try to vote again with Account #1
20. Verify buttons disabled
21. Verify message: "You have voted"

🚀 Deployment
Local Development (Current Setup)
✅ Already configured! Running on:

Blockchain: http://localhost:8545
Frontend: http://localhost:3000
Contract: Deployed to local Hardhat network

Deploy to Testnet (e.g., Sepolia)
Step 1: Get Testnet ETH

Visit Sepolia Faucet
Enter your wallet address
Receive free testnet ETH

Step 2: Get Infura/Alchemy API Key

Sign up at Infura or Alchemy
Create a new project
Copy your API key

Step 3: Update hardhat.config.js
javascriptnetworks: {
sepolia: {
url: `https://sepolia.infura.io/v3/YOUR_INFURA_KEY`,
accounts: ['YOUR_PRIVATE_KEY_WITH_TESTNET_ETH']
}
}
Step 4: Deploy
bashnpx hardhat run scripts/deploy.js --network sepolia
Step 5: Update Frontend

Copy the deployed contract address
Update CONTRACT_ADDRESS in frontend/src/App.js
Configure MetaMask to Sepolia network
Deploy frontend to Vercel/Netlify

📊 Technical Specifications
Smart Contract
PropertyValueNameClubGov.solLanguageSolidity ^0.8.0LicenseMITLines of Code~350Gas OptimizationEnabled (200 runs)Functions15+Events6
Frontend
PropertyValueFrameworkReact.js 18.xWeb3 LibraryEthers.js 5.7StylingTailwind CSS (CDN)IconsLucide ReactBundle Size~500KBResponsive✅ Yes
Network Configuration
PropertyValueNetworkEthereum-compatibleChain ID31337 (Hardhat Local)RPC URLhttp://127.0.0.1:8545Block Time~1 secondGas Limit16,777,216
Initial State
PropertyValueTreasury Balance10 ETHDefault Members4Required Votes2 (51% of 4)AdminAccount #0

📝 Quick Reference Commands
bash# Start blockchain
npx hardhat node

# Deploy contract

npx hardhat run scripts/deploy.js --network localhost

# Start frontend

cd frontend && npm start

# Compile contracts

npx hardhat compile

# Clean artifacts

npx hardhat clean

# Run Hardhat console

npx hardhat console --network localhost

🔗 Useful Resources

Hardhat Documentation: https://hardhat.org/docs
Ethers.js v5 Docs: https://docs.ethers.org/v5/
Solidity Docs: https://docs.soliditylang.org/
React Documentation: https://react.dev/
MetaMask Guide: https://metamask.io/faqs/
Sepolia Faucet: https://sepoliafaucet.com/

⚠️ Important Security Notes
For Local Development:

✅ These are test private keys - publicly known
✅ Safe for local testing only
❌ NEVER use these on mainnet or with real funds

For Production:

🔐 Generate new, secure private keys
🔐 Never commit private keys to Git
🔐 Use environment variables for secrets
🔐 Audit smart contracts before mainnet deployment
🔐 Consider multi-signature wallets for admin functions
