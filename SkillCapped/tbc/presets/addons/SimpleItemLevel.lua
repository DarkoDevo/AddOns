local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:SimpleItemLevelDB()
    local scSimpleItemLevelDB = {
        ["gdbdefaults"] = {
        ["SimpleItemLevelHideAtZeroChecked"] = {
        ["SetChecked"] = true,
        },
        ["DCS_SettingsShowCharacterChecked"] = {
        ["settingsShowCharacterChecked"] = true,
        },
        ["SimpleItemLevelShowDecimalsChecked"] = {
        ["SetChecked"] = true,
        },
        ["DCS_SetItemTooltipScaleSliderValue"] = {
        ["DCS_ItemTooltipScaleSliderValue"] = 1,
        },
        ["SimpleItemLevelDCSZeroChecked"] = {
        ["SetChecked"] = false,
        },
        ["SimpleItemLevelExpandButtonChecked"] = {
        ["ExpandButtonSetChecked"] = true,
        },
        ["SimpleItemLevelShowAverageRepairChecked"] = {
        ["ShowAverageRepairSetChecked"] = false,
        },
        ["SimpleItemLevelShowDuraChecked"] = {
        ["ShowDuraSetChecked"] = false,
        },
        ["DCS_CenterItemTooltips"] = {
        ["DCS_CenterItemTooltipScale"] = 1,
        ["centerItemTooltips"] = false,
        },
        ["SimpleItemLevelShowItemRepairChecked"] = {
        ["ShowItemRepairSetChecked"] = false,
        },
        ["SimpleItemLevelShowItemLevelChecked"] = {
        ["ShowItemLevelSetChecked"] = false,
        },
        ["SimpleItemLevelShowDuraTextureChecked"] = {
        ["ShowDuraTextureSetChecked"] = false,
        },
        ["SimpleItemLevelSimpleItemColorChecked"] = {
        ["SimpleItemColorChecked"] = false,
        ["DarkerItemColorChecked"] = false,
        },
        ["SimpleItemLevelHideMasteryChecked"] = {
        ["SetChecked"] = true,
        },
        ["SimpleItemLevelItemLevelChecked"] = {
        ["ItemLevelTwoDecimalsSetChecked"] = true,
        ["ItemLevelEQ_AV_SetChecked"] = true,
        ["ItemLevelClassColorSetChecked"] = true,
        ["ItemLevelDecimalsSetChecked"] = false,
        },
        ["SimpleItemLevelClassBackgroundChecked"] = {
        ["ClassBackgroundChecked"] = false,
        },
        ["SimpleItemLevelConfigButtonChecked"] = {
        ["ConfigButtonSetChecked"] = true,
        },
        ["SimpleItemLevelExpandChecked"] = {
        ["ExpandSetChecked"] = true,
        },
        ["SimpleItemLevelAlternateInfoPlacement"] = {
        ["AlternateInfoPlacementChecked"] = false,
        },
        ["SimpleItemLevelScrollbarChecked"] = {
        ["ScrollbarSetChecked"] = true,
        },
        },
    }

    if not SkillCappedBackupDB.SimpleItemLevelDB then
        SkillCappedBackupDB.SimpleItemLevelDB = SC:DeepCopy(SimpleItemLevelDB)
        SkillCappedBackupDB.addonBackupTimes["SimpleItemLevel"] = SC:GetDateAndTime()
    end

    SimpleItemLevelDB = scSimpleItemLevelDB
end