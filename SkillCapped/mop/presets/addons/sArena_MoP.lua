local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:sArena_MoPDB()
    local scsArena_MoPDB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["SkillCapped"] = {
        ["layoutSettings"] = {
        ["Gladiuish"] = {
        ["dr"] = {
        ["posY"] = 0.6,
        ["posX"] = -122,
        ["size"] = 34,
        ["drCategorySizeOffsets"] = {
        },
        },
        ["racial"] = {
        ["scale"] = 1.01,
        ["posY"] = 0.5,
        ["posX"] = 162,
        },
        ["scale"] = 1.2,
        ["specIcon"] = {
        ["posY"] = 0,
        ["posX"] = 0,
        },
        ["castBar"] = {
        ["iconPosY"] = 0,
        ["posY"] = -16.9,
        ["iconPosX"] = 5,
        ["scale"] = 2.28,
        ["posX"] = 8.9,
        ["hideBorderShield"] = true,
        ["width"] = 71,
        },
        ["posX"] = 382.9,
        ["cropIcons"] = false,
        ["powerBarHeight"] = 16,
        ["trinket"] = {
        ["scale"] = 1.01,
        ["posY"] = 0.5,
        ["posX"] = 121,
        },
        ["spacing"] = 32,
        ["width"] = 203,
        ["height"] = 45,
        ["posY"] = 109.7,
        },
        },
        ["drTextOn"] = true,
        ["swapHumanTrinket"] = true,
        ["colorTrinket"] = false,
        ["statusText"] = {
        ["usePercentage"] = true,
        },
        ["drSwipeOff"] = false,
        ["invertDRCooldown"] = false,
        ["hideClassIcon"] = false,
        ["disableDRBorder"] = true,
        },
        },
    }

    if not SkillCappedBackupDB.sArena_MoPDB then
        SkillCappedBackupDB.sArena_MoPDB = SC:DeepCopy(sArena_MoPDB)
        SkillCappedBackupDB.addonBackupTimes["sArena_MoP"] = SC:GetDateAndTime()
    end

    sArena_MoPDB = scsArena_MoPDB

    SC:UpdatesArena_MoPProfile()
end

function SC:UpdatesArena_MoPProfile()
    if not sArena_MoPDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    sArena_MoPDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        sArena_MoPDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end