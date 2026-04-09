local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:BattlegroundWinConditionsDB()
    local scBattlegroundWinConditionsDB = {
        ["onlyShowWhenNewVersion"] = true,
        ["lastReadVersion"] = "9.8.1",
        ["global"] = {
        ["lastFlagCapBy"] = "",
        ["general"] = {
        ["info"] = false,
        ["lock"] = true,
        ["infogroup"] = {
        ["infofontsize"] = 12,
        ["infobg"] = false,
        ["infotextcolor"] = {
        ["a"] = 1,
        ["b"] = 1,
        ["g"] = 1,
        ["r"] = 1,
        },
        ["infobgcolor"] = {
        ["a"] = 0.5,
        ["b"] = 0,
        ["g"] = 0,
        ["r"] = 0,
        },
        ["infofont"] = "Friz Quadrata TT",
        },
        ["test"] = false,
        ["banner"] = false,
        ["bannergroup"] = {
        ["wintextcolor"] = {
        ["a"] = 1,
        ["b"] = 1,
        ["g"] = 1,
        ["r"] = 1,
        },
        ["tiebgcolor"] = {
        ["a"] = 1,
        ["b"] = 0,
        ["g"] = 0,
        ["r"] = 0,
        },
        ["winbgcolor"] = {
        ["a"] = 1,
        ["b"] = 0.1411764705882353,
        ["g"] = 0.4941176470588236,
        ["r"] = 0.1411764705882353,
        },
        ["bannerfont"] = "Friz Quadrata TT",
        ["resettextcolor"] = {
        ["a"] = 1,
        ["b"] = 1,
        ["g"] = 1,
        ["r"] = 1,
        },
        ["losetextcolor"] = {
        ["a"] = 1,
        ["b"] = 1,
        ["g"] = 1,
        ["r"] = 1,
        },
        ["resetbgcolor"] = {
        ["a"] = 1,
        ["b"] = 0.4666666666666667,
        ["g"] = 0.4666666666666667,
        ["r"] = 0.4666666666666667,
        },
        ["tietextcolor"] = {
        ["a"] = 1,
        ["b"] = 1,
        ["g"] = 1,
        ["r"] = 1,
        },
        ["bannerscale"] = 1.04,
        ["losebgcolor"] = {
        ["a"] = 1,
        ["b"] = 0.1843137254901961,
        ["g"] = 0.1333333333333333,
        ["r"] = 0.6862745098039216,
        },
        },
        },
        ["position"] = {
        "TOPLEFT",
        "TOPLEFT",
        3.555547714233398,
        -78.2220458984375,
        },
        ["version"] = 9622,
        ["maps"] = {
        ["silvershardmines"] = {
        ["enabled"] = false,
        },
        ["arathibasin"] = {
        ["enabled"] = true,
        },
        ["warsonggulch"] = {
        ["enabled"] = true,
        ["showdebuffinfo"] = true,
        },
        ["templeofkotmogu"] = {
        ["showbuffinfo"] = true,
        ["enabled"] = true,
        ["showorbinfo"] = true,
        },
        ["deephaulravine"] = {
        ["enabled"] = false,
        },
        ["deepwindgorge"] = {
        ["enabled"] = true,
        },
        ["twinpeaks"] = {
        ["enabled"] = true,
        ["showdebuffinfo"] = true,
        },
        ["thebattleforgilneas"] = {
        ["enabled"] = true,
        },
        ["eyeofthestorm"] = {
        ["showflaginfo"] = true,
        ["showflagvalue"] = true,
        ["enabled"] = true,
        },
        },
        ["debug"] = false,
        },
    }

    if not SkillCappedBackupDB.BattlegroundWinConditionsDB then
        SkillCappedBackupDB.BattlegroundWinConditionsDB = SC:DeepCopy(BattlegroundWinConditionsDB)
        SkillCappedBackupDB.addonBackupTimes["BattlegroundWinConditions"] = SC:GetDateAndTime()
    end

    BattlegroundWinConditionsDB = scBattlegroundWinConditionsDB
end