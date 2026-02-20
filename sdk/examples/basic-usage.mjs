import { ethers } from 'ethers';
import { GamlrOnchainSDK } from '../src/index.js';

const rpcUrl = process.env.RPC_URL;
const privateKey = process.env.PRIVATE_KEY;
const contractAddress = process.env.REGISTRY_ADDRESS;
const playerAddress = process.env.PLAYER_ADDRESS; // from plasmmer/accounts

const provider = new ethers.JsonRpcProvider(rpcUrl);
const signer = new ethers.Wallet(privateKey, provider);

const sdk = new GamlrOnchainSDK({ ethers, contractAddress, signerOrProvider: signer });

// Minimal lifecycle
await sdk.registerPlayer(playerAddress);
await sdk.setProfile(playerAddress, {
  avatarURI: 'ipfs://bafy.../avatar.png',
  settingsURI: 'ipfs://bafy.../player-settings.json'
});
await sdk.addScore(playerAddress, {
  leaderboard: 'global-high-score',
  value: 9001n
});

console.log('Player:', await sdk.getPlayer(playerAddress));
