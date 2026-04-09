local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:BattleGroundEnemiesFixedDB()
    local scBattleGroundEnemiesDB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["Default"] = {
        ["dbVersion"] = 2,
        },
        ["SkillCapped"] = {
        ["Enemies"] = {
        ["playerCountConfigs"] = {
        nil,
        {
        ["Position_X"] = 958.4896889633092,
        ["ButtonModules"] = {
        ["RaidTargetIcon"] = {
        ["Enabled"] = false,
        ["Height"] = false,
        },
        ["Trinket"] = {
        ["Points"] = {
        {
        ["RelativePoint"] = "TOPRIGHT",
        ["OffsetY"] = 0,
        ["RelativeFrame"] = "Button",
        ["Point"] = "TOPLEFT",
        },
        },
        },
        ["ObjectiveAndRespawn"] = {
        ["Height"] = false,
        ["Points"] = {
        {
        ["OffsetX"] = 0,
        ["RelativePoint"] = "TOPRIGHT",
        ["OffsetY"] = 0,
        ["RelativeFrame"] = "Trinket",
        ["Point"] = "TOPLEFT",
        },
        },
        },
        ["SpecClassPriority"] = {
        ["Points"] = {
        {
        ["Point"] = "BOTTOMRIGHT",
        ["RelativePoint"] = "BOTTOMLEFT",
        ["OffsetY"] = 0,
        ["OffsetX"] = 0,
        },
        },
        },
        },
        ["Position_Y"] = 506.1335635820869,
        ["BarWidth"] = 240,
        },
        {
        ["Enabled"] = false,
        ["Position_X"] = 959.200212935204,
        ["Position_Y"] = 627.0221344224628,
        },
        },
        },
        ["dbVersion"] = 2,
        ["Locked"] = true,
        },
        ["Ravencrest"] = {
        ["dbVersion"] = 2,
        },
        },
    }

    if not SkillCappedBackupDB.BattleGroundEnemiesDB then
        SkillCappedBackupDB.BattleGroundEnemiesDB = SC:DeepCopy(BattleGroundEnemiesDB)
        SkillCappedBackupDB.addonBackupTimes["BattleGroundEnemiesFixed"] = SC:GetDateAndTime()
    end

    BattleGroundEnemiesDB = scBattleGroundEnemiesDB

    SC:UpdateBattleGroundEnemiesFixedProfile()
end

function SC:UpdateBattleGroundEnemiesFixedProfile()
    if not BattleGroundEnemiesDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    BattleGroundEnemiesDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        BattleGroundEnemiesDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end