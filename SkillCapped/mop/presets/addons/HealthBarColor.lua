local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:HealthBarColorDB()
    if not SkillCappedBackupDB.HealthBarColorDB then
        SkillCappedBackupDB.HealthBarColorDB = true
        SkillCappedBackupDB.addonBackupTimes["HealthBarColor"] = SC:GetDateAndTime()
    end

    --HealthBarColorDB = scHealthBarColorDB

    SC:UpdateHealthBarColorProfile()
end

function SC:UpdateHealthBarColorProfile()
    if BetterBlizzFramesDB then
        BetterBlizzFramesDB["classColorFrames"] = true
    end
    -- if not HealthBarColorDB then return end
    -- local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    -- HealthBarColorDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    -- for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
    --     HealthBarColorDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    -- end
end