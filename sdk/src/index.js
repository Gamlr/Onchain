import { GAMLR_ONCHAIN_REGISTRY_ABI } from './abi.js';

/**
 * JS SDK for integrating games with GamlrOnchainRegistry.
 *
 * The playerAddress should come from https://github.com/plasmmer/accounts,
 * as requested by the repository task.
 */
export class GamlrOnchainSDK {
  /**
   * @param {object} deps
   * @param {object} deps.ethers - ethers v6 namespace.
   * @param {string} deps.contractAddress - deployed registry address.
   * @param {object} deps.signerOrProvider - signer for writes and provider for reads.
   */
  constructor({ ethers, contractAddress, signerOrProvider }) {
    if (!ethers?.Contract) {
      throw new Error('ethers dependency is required');
    }

    this.contract = new ethers.Contract(
      contractAddress,
      GAMLR_ONCHAIN_REGISTRY_ABI,
      signerOrProvider
    );
  }

  // -- Write methods --

  registerPlayer(playerAddress) {
    return this.contract.registerPlayer(playerAddress);
  }

  setProfile(playerAddress, { avatarURI, settingsURI }) {
    return this.contract.setProfile(playerAddress, avatarURI, settingsURI);
  }

  setSaveSlot(playerAddress, payload) {
    return this.contract.setSaveSlot(
      playerAddress,
      payload.coverImageURI,
      payload.dataURI,
      payload.dataFormat,
      payload.metadataURI,
      payload.nameDataURI,
      payload.nameDataFormat
    );
  }

  addScore(playerAddress, { leaderboard, value }) {
    return this.contract.addScore(playerAddress, leaderboard, value);
  }

  addAchievement(playerAddress, key) {
    return this.contract.addAchievement(playerAddress, key);
  }

  upsertMission(playerAddress, { key, status }) {
    return this.contract.upsertMission(playerAddress, key, status);
  }

  addExperienceEvent(playerAddress, { amount, reason }) {
    return this.contract.addExperienceEvent(playerAddress, amount, reason);
  }

  setPlaytime(playerAddress, totalPlaytimeSeconds) {
    return this.contract.setPlaytime(playerAddress, totalPlaytimeSeconds);
  }

  setStreak(playerAddress, { current, best }) {
    return this.contract.setStreak(playerAddress, current, best);
  }

  addLinkedAccount(playerAddress, accountRef) {
    return this.contract.addLinkedAccount(playerAddress, accountRef);
  }

  addFollowing(playerAddress, followedAddress) {
    return this.contract.addFollowing(playerAddress, followedAddress);
  }

  // -- Read methods --

  getPlayer(playerAddress) {
    return this.contract.getPlayer(playerAddress);
  }

  getSaveSlot(playerAddress) {
    return this.contract.getSaveSlot(playerAddress);
  }

  getScores(playerAddress) {
    return this.contract.getScores(playerAddress);
  }

  getAchievements(playerAddress) {
    return this.contract.getAchievements(playerAddress);
  }

  getMissions(playerAddress) {
    return this.contract.getMissions(playerAddress);
  }

  getExperienceEvents(playerAddress) {
    return this.contract.getExperienceEvents(playerAddress);
  }
}

export { GAMLR_ONCHAIN_REGISTRY_ABI };
