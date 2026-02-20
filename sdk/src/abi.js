export const GAMLR_ONCHAIN_REGISTRY_ABI = [
  'function registerPlayer(address player)',
  'function setProfile(address player, string avatarURI, string settingsURI)',
  'function setSaveSlot(address player, string coverImageURI, string dataURI, string dataFormat, string metadataURI, string nameDataURI, string nameDataFormat)',
  'function addScore(address player, string leaderboard, uint256 value)',
  'function addAchievement(address player, string key)',
  'function upsertMission(address player, string key, string status)',
  'function addExperienceEvent(address player, uint256 amount, string reason)',
  'function setPlaytime(address player, uint256 totalPlaytimeSeconds)',
  'function setStreak(address player, uint32 current, uint32 best)',
  'function addLinkedAccount(address player, string accountRef)',
  'function addFollowing(address player, address followed)',
  'function getPlayer(address player) view returns ((bool exists, string avatarURI, string playerSettingsURI, uint256 totalPlaytimeSeconds, (uint64 firstPlayedAt, uint64 lastPlayedAt) activity, (uint32 current, uint32 best, uint64 updatedAt) streak, string[] linkedAccounts, address[] following))',
  'function getSaveSlot(address player) view returns ((string coverImageURI, string dataURI, string dataFormat, string metadataURI, string nameDataURI, string nameDataFormat, uint64 updatedAt))',
  'function getScores(address player) view returns ((string leaderboard, uint256 value, uint64 recordedAt)[])',
  'function getAchievements(address player) view returns ((string key, uint64 unlockedAt)[])',
  'function getMissions(address player) view returns ((string key, string status, uint64 updatedAt)[])',
  'function getExperienceEvents(address player) view returns ((uint256 amount, string reason, uint64 recordedAt)[])'
];
