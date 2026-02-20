// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title GamlrOnchainRegistry
 * @notice Web3 implementation inspired by Play Games profile/save surfaces.
 * @dev Games should store content-addressed URIs (ipfs://, ar://, https:// gateway) instead of raw binaries.
 */
contract GamlrOnchainRegistry {
    struct Activity {
        uint64 firstPlayedAt;
        uint64 lastPlayedAt;
    }

    struct SaveSlot {
        string coverImageURI; // PNG/JPG screenshot URI
        string dataURI; // data.bin URI
        string dataFormat; // original format description
        string metadataURI; // save metadata URI
        string nameDataURI; // nome.bin URI
        string nameDataFormat; // original format description
        uint64 updatedAt;
    }

    struct Score {
        string leaderboard;
        uint256 value;
        uint64 recordedAt;
    }

    struct Achievement {
        string key;
        uint64 unlockedAt;
    }

    struct Mission {
        string key;
        string status;
        uint64 updatedAt;
    }

    struct ExperienceEvent {
        uint256 amount;
        string reason;
        uint64 recordedAt;
    }

    struct Streak {
        uint32 current;
        uint32 best;
        uint64 updatedAt;
    }

    struct Player {
        bool exists;
        string avatarURI; // avatar.png
        string playerSettingsURI; // profile settings payload URI
        uint256 totalPlaytimeSeconds;
        Activity activity;
        Streak streak;
        string[] linkedAccounts;
        address[] following;
    }

    address public immutable owner;

    mapping(address => Player) private players;
    mapping(address => SaveSlot) private saveSlots;
    mapping(address => Score[]) private scores;
    mapping(address => Achievement[]) private achievements;
    mapping(address => Mission[]) private missions;
    mapping(address => ExperienceEvent[]) private experienceEvents;

    event PlayerRegistered(address indexed player);
    event PlayerProfileUpdated(address indexed player, string avatarURI, string settingsURI);
    event SaveSlotUpdated(address indexed player, string dataURI, string metadataURI);
    event ScoreRecorded(address indexed player, string leaderboard, uint256 value);
    event AchievementUnlocked(address indexed player, string key);
    event MissionUpdated(address indexed player, string key, string status);
    event ExperienceRecorded(address indexed player, uint256 amount, string reason);
    event LinkedAccountAdded(address indexed player, string accountRef);
    event FollowingAdded(address indexed player, address indexed followed);

    modifier onlyPlayerOrOwner(address player) {
        require(msg.sender == player || msg.sender == owner, "not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerPlayer(address player) external onlyPlayerOrOwner(player) {
        Player storage p = players[player];
        if (!p.exists) {
            p.exists = true;
            uint64 nowTs = uint64(block.timestamp);
            p.activity.firstPlayedAt = nowTs;
            p.activity.lastPlayedAt = nowTs;
            emit PlayerRegistered(player);
        }
    }

    function setProfile(address player, string calldata avatarURI, string calldata settingsURI) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        Player storage p = players[player];
        p.avatarURI = avatarURI;
        p.playerSettingsURI = settingsURI;
        p.activity.lastPlayedAt = uint64(block.timestamp);
        emit PlayerProfileUpdated(player, avatarURI, settingsURI);
    }

    function setSaveSlot(
        address player,
        string calldata coverImageURI,
        string calldata dataURI,
        string calldata dataFormat,
        string calldata metadataURI,
        string calldata nameDataURI,
        string calldata nameDataFormat
    ) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        saveSlots[player] = SaveSlot({
            coverImageURI: coverImageURI,
            dataURI: dataURI,
            dataFormat: dataFormat,
            metadataURI: metadataURI,
            nameDataURI: nameDataURI,
            nameDataFormat: nameDataFormat,
            updatedAt: uint64(block.timestamp)
        });
        players[player].activity.lastPlayedAt = uint64(block.timestamp);
        emit SaveSlotUpdated(player, dataURI, metadataURI);
    }

    function addScore(address player, string calldata leaderboard, uint256 value) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        scores[player].push(Score({leaderboard: leaderboard, value: value, recordedAt: uint64(block.timestamp)}));
        emit ScoreRecorded(player, leaderboard, value);
    }

    function addAchievement(address player, string calldata key) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        achievements[player].push(Achievement({key: key, unlockedAt: uint64(block.timestamp)}));
        emit AchievementUnlocked(player, key);
    }

    function upsertMission(address player, string calldata key, string calldata status) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        missions[player].push(Mission({key: key, status: status, updatedAt: uint64(block.timestamp)}));
        emit MissionUpdated(player, key, status);
    }

    function addExperienceEvent(address player, uint256 amount, string calldata reason) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        experienceEvents[player].push(ExperienceEvent({amount: amount, reason: reason, recordedAt: uint64(block.timestamp)}));
        emit ExperienceRecorded(player, amount, reason);
    }

    function setPlaytime(address player, uint256 totalPlaytimeSeconds) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        players[player].totalPlaytimeSeconds = totalPlaytimeSeconds;
        players[player].activity.lastPlayedAt = uint64(block.timestamp);
    }

    function setStreak(address player, uint32 current, uint32 best) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        players[player].streak = Streak({current: current, best: best, updatedAt: uint64(block.timestamp)});
        players[player].activity.lastPlayedAt = uint64(block.timestamp);
    }

    function addLinkedAccount(address player, string calldata accountRef) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        players[player].linkedAccounts.push(accountRef);
        emit LinkedAccountAdded(player, accountRef);
    }

    function addFollowing(address player, address followed) external onlyPlayerOrOwner(player) {
        _ensureRegistered(player);
        players[player].following.push(followed);
        emit FollowingAdded(player, followed);
    }

    function getPlayer(address player) external view returns (Player memory) {
        return players[player];
    }

    function getSaveSlot(address player) external view returns (SaveSlot memory) {
        return saveSlots[player];
    }

    function getScores(address player) external view returns (Score[] memory) {
        return scores[player];
    }

    function getAchievements(address player) external view returns (Achievement[] memory) {
        return achievements[player];
    }

    function getMissions(address player) external view returns (Mission[] memory) {
        return missions[player];
    }

    function getExperienceEvents(address player) external view returns (ExperienceEvent[] memory) {
        return experienceEvents[player];
    }

    function _ensureRegistered(address player) internal view {
        require(players[player].exists, "player not registered");
    }
}
