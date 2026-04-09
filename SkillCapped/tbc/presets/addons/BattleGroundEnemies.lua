local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:BattleGroundEnemies()
    local scBattleGroundEnemiesDB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["SkillCapped"] = {
        ["ShowBGEInArena"] = false,
        ["onlyShowWhenNewVersion"] = true,
        ["Allies"] = {
        ["Enabled"] = false,
        },
        ["lastReadVersion"] = "11.2.0.6",
        ["Enemies"] = {
        ["playerCountConfigs"] = {
        {
        ["Enabled"] = false,
        },
        {
        ["Position_Y"] = 507.2023024797782,
        ["Position_X"] = 995.8180812450955,
        },
        {
        ["BarColumns"] = 2,
        ["Position_Y"] = 506.0639723846907,
        ["Position_X"] = 889.9243296671557,
        },
        },
        },
        ["dbVersion"] = 2,
        },
        },
    }

    if not SkillCappedBackupDB.BattleGroundEnemiesDB then
        SkillCappedBackupDB.BattleGroundEnemiesDB = SC:DeepCopy(BattleGroundEnemiesDB)
        SkillCappedBackupDB.addonBackupTimes["BattleGroundEnemies"] = SC:GetDateAndTime()
    end

    BattleGroundEnemiesDB = scBattleGroundEnemiesDB

    --SC:UpdateAddonProfileKeysToSkillCapped("BattleGroundEnemiesDB")
end