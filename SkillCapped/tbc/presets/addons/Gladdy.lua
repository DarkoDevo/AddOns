local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:GladdyXZ()
    local scGladdyXZ = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["SkillCapped"] = {
        ["drBorderColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["shadowsightTimerRelPoint1"] = "TOP",
        ["castBarBorderColor"] = {
        ["a"] = 0.3541660308837891,
        ["b"] = 0.2274509803921569,
        ["g"] = 0.2274509803921569,
        ["r"] = 0.2274509803921569,
        },
        ["drCooldownAlpha"] = 0.8,
        ["castBarBgColor"] = {
        ["a"] = 0.4000000357627869,
        ["b"] = 0.7372549019607844,
        ["g"] = 0.7372549019607844,
        ["r"] = 0.7372549019607844,
        },
        ["castBarHeight"] = 42,
        ["drFontScale"] = 0.9,
        ["trinketBorderColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["buffsBuffsCooldownGrowDirection"] = "LEFT",
        ["ciYOffset"] = -3.99993896484375,
        ["castBarFont"] = "Friz Quadrata TT",
        ["classIconXOffset"] = -47.99993896484375,
        ["cooldownFontScale"] = 0.6,
        ["cooldownYOffset"] = -0.872528076171875,
        ["nameplateEnabled"] = false,
        ["newLayout"] = true,
        ["racialWidthFactor"] = 1,
        ["buffsIconSize"] = 23,
        ["powerBarBorderColor"] = {
        ["b"] = 0.2274509803921569,
        ["g"] = 0.2274509803921569,
        ["r"] = 0.2274509803921569,
        },
        ["petPortraitBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_squared_blp",
        ["healthBarBorderStyle"] = "Gladdy Tooltip squared",
        ["castBarWidth"] = 192,
        ["auraDebuffBorderColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["cooldown"] = false,
        ["targetHealthTextLeftFontSize"] = 7.600000000000001,
        ["auraFont"] = "Friz Quadrata TT",
        ["trinketXOffset"] = 190.0000610351563,
        ["y"] = 508.5928786723744,
        ["x"] = 993.2237452689369,
        ["bottomMargin"] = 42,
        ["auraBuffBorderColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["petHeight"] = 19,
        ["ciXOffset"] = 85.00006103515625,
        ["powerBarHeight"] = 16,
        ["buffsCooldownGrowDirection"] = "LEFT",
        ["powerBarBgColor"] = {
        ["a"] = 0.3500000238418579,
        ["b"] = 0.8,
        ["g"] = 0.8,
        ["r"] = 0.8,
        },
        ["castBarIconStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_squared_blp",
        ["totemPulseEnabled"] = false,
        ["targetHealthBarBorderSize"] = 1,
        ["castBarColor"] = {
        ["g"] = 0.8980392156862745,
        ["b"] = 0.4274509803921568,
        },
        ["castBarIconColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["leaderBorder"] = false,
        ["cooldownCooldownAlpha"] = 0.6000000000000001,
        ["cooldownBorderColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["healthBarHeight"] = 30,
        ["petHealthBarBorderSize"] = 6,
        ["targetYOffset"] = -47.53353881835938,
        ["racialXOffset"] = 237.0000610351563,
        ["racialBorderColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["classIconSpecIcon"] = true,
        ["targetXOffset"] = 190.8892211914063,
        ["petWidth"] = 100,
        ["cooldownSize"] = 21.56016731262207,
        ["highlightInset"] = true,
        ["drGrowDirection"] = "LEFT",
        ["shadowsightTimerX"] = -1.70801568031311,
        ["buffsCooldownAlpha"] = 0.8,
        ["healthBarTexture"] = "Minimalist",
        ["ciBorderColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["castBarYOffset"] = -47.28841781616211,
        ["buffsBuffsIconSize"] = 19,
        ["racialSize"] = 47,
        ["drXOffset"] = -92.52110290527344,
        ["ciEnabled"] = false,
        ["targetHeight"] = 20.25,
        ["announcements"] = {
        ["resurrections"] = false,
        ["spellInterrupt"] = false,
        ["spec"] = false,
        ["spellInterruptSpellSchool"] = false,
        ["drinks"] = false,
        ["trinketUsed"] = false,
        },
        ["buffsYOffset"] = -32.49996948242188,
        ["targetEnabled"] = false,
        ["healthBarBorderSize"] = 0.5,
        ["focusBorder"] = false,
        ["petHealthBarBorderStyle"] = "Gladdy Tooltip squared",
        ["barWidth"] = 190,
        ["targetHealthTextRightFontSize"] = 8.65,
        ["cooldownMaxIconsPerLine"] = 5,
        ["buffsEnabled"] = false,
        ["targetBorder"] = false,
        ["targetHealthBarTexture"] = "Minimalist",
        ["buffsBuffsYOffset"] = -56.49990844726563,
        ["castBarTexture"] = "Minimalist",
        ["classIconWidthFactor"] = 1,
        ["petXOffset"] = -47.99993896484375,
        ["castBarIconSize"] = 43,
        ["drFont"] = "Friz Quadrata TT",
        ["cooldownXOffset"] = 285.0001831054688,
        ["highlightBorderSize"] = 2,
        ["healthBarFont"] = "Friz Quadrata TT",
        ["buffsFontScale"] = 0.7000000000000001,
        ["petEnabled"] = false,
        ["castBarXOffset"] = -0.3812864422798157,
        ["targetWidth"] = 71.6,
        ["powerBarBorderStyle"] = "Gladdy Tooltip squared",
        ["castBarBorderSize"] = 4,
        ["npTotems"] = false,
        ["drBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp",
        ["classIconSize"] = 48,
        ["petYOffset"] = 21.50006103515625,
        ["buffsXOffset"] = -49.9998779296875,
        ["totemPulseTotems"] = {
        ["totem5675"] = {
        ["enabled"] = false,
        },
        ["totem8190"] = {
        ["enabled"] = false,
        },
        ["totem2484"] = {
        ["enabled"] = false,
        },
        ["totem5394"] = {
        ["enabled"] = false,
        },
        ["totem8166"] = {
        ["enabled"] = false,
        },
        ["totem1535"] = {
        ["enabled"] = false,
        },
        },
        ["petHealthBarTexture"] = "Minimalist",
        ["castBarBorderStyle"] = "Gladdy Tooltip squared",
        ["buffsBuffsXOffset"] = -49.9998779296875,
        ["shadowsightTimerY"] = -13.9876823425293,
        ["classIconBorderColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["drYOffset"] = -1.92327880859375,
        ["version"] = 2.4,
        ["petHealthBarBorderColor"] = {
        ["b"] = 0.2274509803921569,
        ["g"] = 0.2274509803921569,
        ["r"] = 0.2274509803921569,
        },
        ["cooldownYGrowDirection"] = "DOWN",
        ["powerBarTexture"] = "Minimalist",
        ["shadowsightTimerRelPoint2"] = "TOP",
        ["targetPortraitSize"] = 19.5,
        ["buffsBorderColor"] = {
        ["b"] = 0.6666666666666666,
        ["g"] = 0.6666666666666666,
        ["r"] = 0.6666666666666666,
        },
        ["healthBarBorderColor"] = {
        ["b"] = 0.2274509803921569,
        ["g"] = 0.2274509803921569,
        ["r"] = 0.2274509803921569,
        },
        ["healthBarBgColor"] = {
        ["a"] = 0.5200000107288361,
        ["b"] = 0.7019607843137254,
        ["g"] = 0.6705882352941176,
        ["r"] = 0.6901960784313725,
        },
        ["cooldownFont"] = "Friz Quadrata TT",
        ["powerBarFont"] = "Friz Quadrata TT",
        ["targetHealthTextRightHOffset"] = 0,
        ["trinketSize"] = 47,
        ["trinketWidthFactor"] = 1,
        ["targetHealthBarBorderStyle"] = "Gladdy Tooltip squared",
        ["drIconSize"] = 44,
        ["powerBarBorderSize"] = 1,
        },
        },
    }

    if not SkillCappedBackupDB.GladdyXZ then
        SkillCappedBackupDB.GladdyXZ = SC:DeepCopy(GladdyXZ)
        SkillCappedBackupDB.addonBackupTimes["GladdyXZ"] = SC:GetDateAndTime()
    end

    GladdyXZ = scGladdyXZ

    SC:UpdateGladdyProfile()
end

function SC:UpdateGladdyProfile()
    if not GladdyXZ then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    GladdyXZ.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        GladdyXZ.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end