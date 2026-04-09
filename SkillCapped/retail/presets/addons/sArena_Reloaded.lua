local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:sArena_ReloadedDB()
    local scsArena_ReloadedDB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["SkillCapped"] = {
        ["layoutSettings"] = {
        ["Gladiuish"] = {
        ["dr"] = {
        ["blackDRBorder"] = false,
        ["fontSize"] = 16,
        ["showDRText"] = false,
        ["drCategorySizeOffsets"] = {
        },
        ["drBorderGlowOff"] = false,
        ["posX"] = -126,
        ["thickPixelBorder"] = false,
        ["brightDRBorder"] = false,
        ["disableDRBorder"] = false,
        ["thinPixelBorder"] = false,
        ["size"] = 35,
        },
        ["racial"] = {
        ["scale"] = 1,
        ["posX"] = 167,
        },
        ["castBar"] = {
        ["posY"] = -17,
        ["recolorCastbar"] = true,
        ["scale"] = 2.3,
        ["iconScale"] = 1.09,
        ["iconPosY"] = 0,
        ["useModernCastbars"] = false,
        ["interruptStatusColorOn"] = false,
        ["posX"] = 9,
        ["hideCastbarSpark"] = false,
        ["hideCastbarIcon"] = false,
        ["width"] = 74,
        ["hideBorderShield"] = true,
        },
        ["posX"] = 403.8,
        ["cropIcons"] = false,
        ["posY"] = 113.7,
        ["powerBarHeight"] = 14,
        ["trinket"] = {
        ["posX"] = 126,
        },
        ["widgets"] = {
        ["enabled"] = false,
        ["focusIndicator"] = {
        ["enabled"] = false,
        },
        ["combatIndicator"] = {
        ["enabled"] = false,
        },
        ["partyTargetIndicators"] = {
        ["enabled"] = false,
        },
        },
        ["width"] = 210,
        ["textSettings"] = {
        ["nameSize"] = 1.1,
        ["drTextSize"] = 1.1,
        ["castbarSize"] = 0.49,
        ["healthSize"] = 1.1,
        ["specNameSize"] = 1.1,
        ["castbarOffsetX"] = 0,
        ["powerSize"] = 1.1,
        },
        },
        },
        ["replaceHealerIcon"] = false,
        ["classColorFrameTexture"] = false,
        ["swapRacialTrinket"] = false,
        ["showArenaNumber"] = false,
        ["darkMode"] = false,
        ["disableSwipeEdge"] = false,
        ["removeUnequippedTrinketTexture"] = false,
        ["colorMysteryGray"] = false,
        ["classColorNames"] = false,
        ["hidePowerText"] = false,
        ["colorTrinket"] = false,
        ["statusText"] = {
        ["formatNumbers"] = false,
        ["usePercentage"] = true,
        },
        ["invertTrinketRacialCooldown"] = false,
        ["reverseBarsFill"] = false,
        ["hideClassIcon"] = false,
        ["disableAurasOnClassIcon"] = false,
        ["disableOvershields"] = false,
        ["invertDRCooldown"] = false,
        ["shadowSightTimer"] = false,
        },
        ["Default"] = {
        },
        },
    }

    if not SkillCappedBackupDB.sArena_ReloadedDB then
        SkillCappedBackupDB.sArena_ReloadedDB = SC:DeepCopy(sArena_ReloadedDB)
        SkillCappedBackupDB.addonBackupTimes["sArena_Reloaded"] = SC:GetDateAndTime()
    end

    sArena_ReloadedDB = scsArena_ReloadedDB

    SC:UpdatesArenaReloadedProfile()
end

function SC:UpdatesArenaReloadedProfile()
    if not sArena_ReloadedDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    sArena_ReloadedDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        sArena_ReloadedDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end