local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:DejaCharacterStatsDB()
    local scDejaCharacterStatsDB = {
        ["gdbdefaults"] = {
        ["dejacharacterstatsHideAtZeroChecked"] = {
        ["SetChecked"] = true,
        },
        ["DCS_SettingsShowCharacterChecked"] = {
        ["settingsShowCharacterChecked"] = true,
        },
        ["dejacharacterstatsShowDecimalsChecked"] = {
        ["SetChecked"] = true,
        },
        ["DCS_SetItemTooltipScaleSliderValue"] = {
        ["DCS_ItemTooltipScaleSliderValue"] = 1,
        },
        ["dejacharacterstatsDCSZeroChecked"] = {
        ["SetChecked"] = false,
        },
        ["dejacharacterstatsExpandButtonChecked"] = {
        ["ExpandButtonSetChecked"] = true,
        },
        ["dejacharacterstatsShowAverageRepairChecked"] = {
        ["ShowAverageRepairSetChecked"] = false,
        },
        ["dejacharacterstatsShowDuraChecked"] = {
        ["ShowDuraSetChecked"] = false,
        },
        ["DCS_CenterItemTooltips"] = {
        ["DCS_CenterItemTooltipScale"] = 1,
        ["centerItemTooltips"] = false,
        },
        ["dejacharacterstatsShowItemRepairChecked"] = {
        ["ShowItemRepairSetChecked"] = false,
        },
        ["dejacharacterstatsShowItemLevelChecked"] = {
        ["ShowItemLevelSetChecked"] = false,
        },
        ["dejacharacterstatsShowDuraTextureChecked"] = {
        ["ShowDuraTextureSetChecked"] = false,
        },
        ["dejacharacterstatsSimpleItemColorChecked"] = {
        ["SimpleItemColorChecked"] = false,
        ["DarkerItemColorChecked"] = false,
        },
        ["dejacharacterstatsHideMasteryChecked"] = {
        ["SetChecked"] = true,
        },
        ["dejacharacterstatsItemLevelChecked"] = {
        ["ItemLevelTwoDecimalsSetChecked"] = true,
        ["ItemLevelEQ_AV_SetChecked"] = true,
        ["ItemLevelClassColorSetChecked"] = true,
        ["ItemLevelDecimalsSetChecked"] = false,
        },
        ["dejacharacterstatsClassBackgroundChecked"] = {
        ["ClassBackgroundChecked"] = false,
        },
        ["dejacharacterstatsConfigButtonChecked"] = {
        ["ConfigButtonSetChecked"] = true,
        },
        ["dejacharacterstatsExpandChecked"] = {
        ["ExpandSetChecked"] = true,
        },
        ["dejacharacterstatsAlternateInfoPlacement"] = {
        ["AlternateInfoPlacementChecked"] = false,
        },
        ["dejacharacterstatsScrollbarChecked"] = {
        ["ScrollbarSetChecked"] = true,
        },
        },
    }

    if not SkillCappedBackupDB.DejaCharacterStatsDB then
        SkillCappedBackupDB.DejaCharacterStatsDB = SC:DeepCopy(DejaCharacterStatsDB)
        SkillCappedBackupDB.addonBackupTimes["DejaCharacterStats"] = SC:GetDateAndTime()
    end

    DejaCharacterStatsDB = scDejaCharacterStatsDB
end