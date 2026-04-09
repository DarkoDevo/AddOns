local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:HealthBarColorDB()
    local scHealthBarColorDB = {
        ["namespaces"] = {
        },
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["SkillCapped"] = {
        ["HealthBarColor_pet"] = {
        },
        ["Font_target"] = {
        },
        ["HealthBarColor_boss5"] = {
        },
        ["Glow_player"] = {
        ["colorModeGlow"] = 3,
        ["enabled"] = true,
        },
        ["Glow_focus"] = {
        ["colorModeGlow"] = 5,
        ["enabled"] = true,
        },
        ["PersonalResourceDisplay"] = {
        ["colorMode"] = 2,
        },
        ["addonColors"] = {
        },
        ["HealthBarColor_focus"] = {
        },
        ["HealthBarColor_target"] = {
        },
        ["Glow_target"] = {
        ["colorModeGlow"] = 5,
        ["enabled"] = true,
        },
        ["HealthBarColor_boss3"] = {
        },
        ["HealthBarColor_boss4"] = {
        },
        ["MinimapButton"] = {
        ["minimapPos"] = 159.695823262595,
        ["enabled"] = false,
        },
        },
        ["Default"] = {
        ["HealthBarColor_boss5"] = {
        },
        ["HealthBarColor_boss3"] = {
        },
        ["HealthBarColor_pet"] = {
        },
        ["HealthBarColor_focus"] = {
        },
        ["HealthBarColor_boss4"] = {
        },
        ["addonColors"] = {
        },
        ["HealthBarColor_target"] = {
        },
        ["Font_target"] = {
        },
        },
        },
    }

    if not SkillCappedBackupDB.HealthBarColorDB then
        SkillCappedBackupDB.HealthBarColorDB = SC:DeepCopy(HealthBarColorDB)
        SkillCappedBackupDB.addonBackupTimes["HealthBarColor"] = SC:GetDateAndTime()
    end

    HealthBarColorDB = scHealthBarColorDB

    SC:UpdateHealthBarColorProfile()
end

function SC:UpdateHealthBarColorProfile()
    if not HealthBarColorDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    HealthBarColorDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        HealthBarColorDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end