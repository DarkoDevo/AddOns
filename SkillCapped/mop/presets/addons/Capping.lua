local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:CappingDB()
    local scCappingSettings = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["SkillCapped"] = {
        ["barOnAlt"] = "INSTANCE_CHAT",
        ["barOnShift"] = "INSTANCE_CHAT",
        ["useMasterForQueue"] = false,
        ["width"] = 182,
        ["position"] = {
        "TOPLEFT",
        "TOPLEFT",
        },
        ["queueBars"] = false,
        ["lock"] = true,
        },
        },
    }

    if not SkillCappedBackupDB.CappingSettings then
        SkillCappedBackupDB.CappingSettings = SC:DeepCopy(CappingSettings)
        SkillCappedBackupDB.addonBackupTimes["Capping"] = SC:GetDateAndTime()
    end

    CappingSettings = scCappingSettings

    SC:UpdateCappingProfile()
end

function SC:UpdateCappingProfile()
    if not CappingSettings then return end
    if not SkillCappedBackupDB.CappingSettings then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    CappingSettings.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        CappingSettings.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end

function SC:AddCappingProfile()
    if not CappingSettings then return end
    local newProfileKey = SC:GetPlayerNameAndRealm()
    local newProfile = {
        ["barOnAlt"] = "INSTANCE_CHAT",
        ["lock"] = true,
        ["barOnShift"] = "INSTANCE_CHAT",
        ["useMasterForQueue"] = false,
        ["width"] = 182,
        ["queueBars"] = false,
        ["position"] = {
            "TOPLEFT",
            "TOPLEFT",
        },
    }

    if not CappingSettings.profileKeys then
        CappingSettings.profileKeys = {}
    end

    if not CappingSettings.profiles then
        CappingSettings.profiles = {}
    end

    CappingSettings.profileKeys[newProfileKey] = "SkillCapped"

    if not CappingSettings.profiles["SkillCapped"] then
        CappingSettings.profiles["SkillCapped"] = newProfile
    end

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        CappingSettings.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end