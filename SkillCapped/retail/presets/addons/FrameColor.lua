local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:FrameColorDB()
    local scFrameColor4DB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["SkillCapped"] = {
        ["_LFDMicroButton"] = {
        ["enabled"] = false,
        },
        ["_PlayerSpellsFrame"] = {
        ["toggles"] = {
        ["follow_unit_class_or_reaction_color"] = {
        ["isChecked"] = false,
        },
        },
        },
        ["_TargetFrame"] = {
        ["enabled"] = true,
        ["colors"] = {
        ["cast_bar"] = {
        ["lockedColor"] = false,
        },
        ["buff_border"] = {
        ["lockedColor"] = false,
        ["followClassColor"] = false,
        },
        },
        ["toggles"] = {
        ["show_buff_border"] = {
        ["isChecked"] = false,
        },
        },
        },
        ["_BuffFrame"] = {
        ["enabled"] = true,
        },
        ["_PlayerSpellsMicroButton"] = {
        ["enabled"] = false,
        },
        ["_CharacterFrame"] = {
        ["colors"] = {
        ["background"] = {
        ["followClassColor"] = false,
        },
        },
        },
        ["_AchievementMicroButton"] = {
        ["enabled"] = false,
        },
        ["_QuestLogMicroButton"] = {
        ["enabled"] = false,
        },
        ["_CharacterMicroButton"] = {
        ["enabled"] = false,
        },
        ["_ProfessionMicroButton"] = {
        ["enabled"] = false,
        },
        ["_EJMicroButton"] = {
        ["enabled"] = false,
        },
        ["_FocusFrame"] = {
        ["enabled"] = true,
        ["toggles"] = {
        ["show_buff_border"] = {
        ["isChecked"] = false,
        },
        },
        },
        ["_CollectionsMicroButton"] = {
        ["enabled"] = false,
        },
        ["_StoreMicroButton"] = {
        ["enabled"] = false,
        },
        ["_MainMenuMicroButton"] = {
        ["enabled"] = false,
        },
        ["_GameMenuFrame"] = {
        ["enabled"] = false,
        },
        ["_GuildMicroButton"] = {
        ["enabled"] = false,
        },
        ["_CooldownViewerSettings"] = {
        ["colors"] = {
        ["background"] = {
        ["followClassColor"] = false,
        },
        },
        },
        ["_PlayerFrame"] = {
        ["enabled"] = true,
        },
        ["_HousingMicroButton"] = {
        ["enabled"] = false,
        },
        ["_FriendsFrame"] = {
        ["toggles"] = {
        ["update_bg_to_online_status"] = {
        ["isChecked"] = false,
        },
        },
        },
        ["_TargetFrameToT"] = {
        ["enabled"] = true,
        },
        ["_FocusFrameToT"] = {
        ["enabled"] = true,
        },
        },
        ["Default"] = {
        },
        },
    }

    if not SkillCappedBackupDB.FrameColorDB then
        SkillCappedBackupDB.FrameColorDB = SC:DeepCopy(FrameColor4DB)
        SkillCappedBackupDB.addonBackupTimes["FrameColor"] = SC:GetDateAndTime()
    end

    if not SkillCappedBackupDB.FrameColor4DB then
        SkillCappedBackupDB.FrameColor4DB = SC:DeepCopy(FrameColor4DB)
        SkillCappedBackupDB.addonBackupTimes["FrameColor"] = SC:GetDateAndTime()
    end

    FrameColor4DB = scFrameColor4DB

    SC:UpdateFrameColorProfile()
end

function SC:UpdateFrameColorProfile()
    if not FrameColor4DB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    FrameColor4DB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        FrameColor4DB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end