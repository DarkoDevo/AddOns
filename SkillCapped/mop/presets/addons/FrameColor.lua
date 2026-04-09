local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:FrameColorDB()
    local scFrameColorDB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["SkillCapped"] = {
        ["ActionBars"] = {
        ["ClassTalentFrame"] = {
        },
        ["CharacterFrame"] = {
        },
        ["Ace3_Skin"] = {
        },
        ["InspectFrame"] = {
        },
        ["TargetFrame"] = {
        },
        ["FrameColor_Skin"] = {
        },
        ["FriendsFrame"] = {
        },
        ["DelvesFrame"] = {
        },
        ["PlayerSpellsFrame"] = {
        },
        ["PlayerFrame"] = {
        },
        },
        ["Group"] = {
        ["InspectFrame"] = {
        },
        ["TargetFrame"] = {
        },
        ["CharacterFrame"] = {
        },
        ["FriendsFrame"] = {
        },
        ["DelvesFrame"] = {
        },
        ["Ace3_Skin"] = {
        },
        ["PlayerFrame"] = {
        },
        ["ClassTalentFrame"] = {
        },
        ["FrameColor_Skin"] = {
        },
        ["PlayerSpellsFrame"] = {
        },
        },
        ["UnitFrames"] = {
        ["InspectFrame"] = {
        },
        ["TargetFrame"] = {
        },
        ["CharacterFrame"] = {
        },
        ["FriendsFrame"] = {
        },
        ["DelvesFrame"] = {
        },
        ["Ace3_Skin"] = {
        },
        ["PlayerFrame"] = {
        },
        ["ClassTalentFrame"] = {
        },
        ["FrameColor_Skin"] = {
        },
        ["PlayerSpellsFrame"] = {
        },
        },
        ["modules"] = {
        ["ProfessionMicroButton"] = {
        ["enabled"] = false,
        },
        ["EJMicroButton"] = {
        ["enabled"] = false,
        },
        ["LFDMicroButton"] = {
        ["enabled"] = false,
        },
        ["GuildMicroButton"] = {
        ["enabled"] = false,
        },
        ["CollectionsMicroButton"] = {
        ["enabled"] = false,
        },
        ["QuestLogMicroButton"] = {
        ["enabled"] = false,
        },
        ["PlayerSpellsMicroButton"] = {
        ["enabled"] = false,
        },
        ["MainMenuMicroButton"] = {
        ["enabled"] = false,
        },
        ["AchievementMicroButton"] = {
        ["enabled"] = false,
        },
        ["CharacterMicroButton"] = {
        ["enabled"] = false,
        },
        ["StoreMicroButton"] = {
        ["enabled"] = false,
        },
        },
        ["Master"] = {
        ["InspectFrame"] = {
        },
        ["DelvesFrame"] = {
        },
        ["PlayerSpellsFrame"] = {
        },
        ["Ace3_Skin"] = {
        },
        ["PlayerFrame"] = {
        },
        ["FrameColor_Skin"] = {
        },
        ["CharacterFrame"] = {
        },
        ["TargetFrame"] = {
        },
        ["FriendsFrame"] = {
        },
        ["ClassTalentFrame"] = {
        },
        },
        ["Windows"] = {
        ["ClassTalentFrame"] = {
        },
        ["CharacterFrame"] = {
        ["classcolored2"] = false,
        },
        ["Ace3_Skin"] = {
        },
        ["PlayerFrame"] = {
        },
        ["TradeFrame"] = {
        ["classcolored2"] = false,
        },
        ["InspectFrame"] = {
        ["classcolored2"] = false,
        },
        ["TargetFrame"] = {
        },
        ["FrameColor_Skin"] = {
        },
        ["FriendsFrame"] = {
        },
        ["DelvesFrame"] = {
        },
        ["PlayerSpellsFrame"] = {
        ["classcolored2"] = false,
        },
        },
        ["Skins"] = {
        ["InspectFrame"] = {
        },
        ["DelvesFrame"] = {
        },
        ["PlayerSpellsFrame"] = {
        },
        ["Ace3_Skin"] = {
        },
        ["PlayerFrame"] = {
        },
        ["FrameColor_Skin"] = {
        },
        ["CharacterFrame"] = {
        },
        ["TargetFrame"] = {
        },
        ["FriendsFrame"] = {
        },
        ["ClassTalentFrame"] = {
        },
        },
        ["HUD"] = {
        ["InspectFrame"] = {
        },
        ["TargetFrame"] = {
        },
        ["CharacterFrame"] = {
        },
        ["FriendsFrame"] = {
        },
        ["DelvesFrame"] = {
        },
        ["Ace3_Skin"] = {
        },
        ["PlayerFrame"] = {
        },
        ["ClassTalentFrame"] = {
        },
        ["PlayerSpellsFrame"] = {
        },
        ["FrameColor_Skin"] = {
        },
        },
        },
        },
    }

    if not SkillCappedBackupDB.FrameColorDB then
        SkillCappedBackupDB.FrameColorDB = SC:DeepCopy(FrameColorDB)
        SkillCappedBackupDB.addonBackupTimes["FrameColor"] = SC:GetDateAndTime()
    end

    if not SkillCappedBackupDB.FrameColorDB then
        SkillCappedBackupDB.FrameColorDB = SC:DeepCopy(FrameColorDB)
        SkillCappedBackupDB.addonBackupTimes["FrameColor"] = SC:GetDateAndTime()
    end

    FrameColorDB = scFrameColorDB

    SC:UpdateFrameColorProfile()
end

function SC:UpdateFrameColorProfile()
    if not FrameColorDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    FrameColorDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        FrameColorDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end