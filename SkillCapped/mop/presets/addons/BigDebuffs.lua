local AddonName, SkillCapped = ...
local SC = SkillCapped

local scBigDebuffsDB = {
    ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped"
    },
    ["profiles"] = {
        ["SkillCapped"] = {
            ["raidFrames"] = {
                ["dispellable"] = {
                    ["cc"] = 50,
                    ["roots"] = 40
                },
                ["maxDebuffs"] = 3,
                ["interrupts"] = 50,
                ["debuffs_offensive"] = 30,
                ["warning"] = 30,
                ["hideBliz"] = false,
                ["pve"] = 30,
                ["increaseBuffs"] = true,
                ["warningList"] = {
                    [30108] = true
                },
                ["buffs"] = 30,
                ["redirectBliz"] = true
            },
            ["nameplates"] = {
                ["tooltips"] = false,
                ["buffs_offensive"] = false,
                ["enemyAnchor"] = {
                    ["anchor"] = "RIGHT",
                    ["size"] = 27
                },
                ["buffs_defensive"] = false,
                ["friendly"] = false,
                ["debuffs_offensive"] = false,
                ["buffs_speed_boost"] = false,
                ["immunities_spells"] = false,
                ["buffs_other"] = false
            },
            ["spells"] = {
                [710] = {
                    ["priority"] = 61,
                    ["customPriority"] = true
                },
                [16621] = {
                    ["nameplates"] = 0
                },
                [13138] = {},
                [1714] = {
                    ["size"] = 30,
                    ["customPriority"] = true,
                    ["nameplates"] = 0,
                    ["priority"] = 15,
                    ["customSize"] = true,
                    ["unitFrames"] = 0
                },
                [47476] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [20066] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [24259] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [18425] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [5782] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [27827] = {
                    ["nameplates"] = 0
                },
                [55021] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [64058] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [34471] = {
                    ["nameplates"] = 0
                },
                [45524] = {
                    ["size"] = 30,
                    ["customPriority"] = true,
                    ["customSize"] = true,
                    ["priority"] = 15,
                    ["nameplates"] = 0,
                    ["unitFrames"] = 0
                },
                [48707] = {
                    ["nameplates"] = 0
                },
                [31661] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [3355] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [23920] = {},
                [18469] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [16566] = {},
                [1022] = {
                    ["nameplates"] = 0
                },
                [18223] = {
                    ["unitFrames"] = 0,
                    ["customPriority"] = true,
                    ["nameplates"] = 0,
                    ["priority"] = 15,
                    ["customSize"] = true,
                    ["size"] = 30
                },
                [7321] = {
                    ["size"] = 30,
                    ["customPriority"] = true,
                    ["nameplates"] = 0,
                    ["priority"] = 15,
                    ["customSize"] = true,
                    ["unitFrames"] = 0
                },
                [1513] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [12548] = {
                    ["size"] = 30,
                    ["customPriority"] = true,
                    ["nameplates"] = 0,
                    ["priority"] = 15,
                    ["customSize"] = true,
                    ["unitFrames"] = 0
                },
                [19386] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [5484] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [50613] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [51514] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [47585] = {
                    ["nameplates"] = 0
                },
                [2094] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [33786] = {
                    ["priority"] = 61,
                    ["customPriority"] = true
                },
                [2637] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [30457] = {
                    ["nameplates"] = 0
                },
                [64044] = {
                    ["customPriority"] = false
                },
                [43523] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [9484] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [8122] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [33961] = {
                    ["nameplates"] = 0
                },
                [6770] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [19503] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [1090] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [13099] = {},
                [20230] = {
                    ["nameplates"] = 0
                },
                [19306] = {
                    ["size"] = 30,
                    ["customPriority"] = true,
                    ["nameplates"] = 0,
                    ["priority"] = 15,
                    ["customSize"] = true,
                    ["unitFrames"] = 0
                },
                [1776] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [64346] = {
                    ["priority"] = 56,
                    ["customPriority"] = true
                },
                [6358] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [3169] = {
                    ["nameplates"] = 0
                },
                [118] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [605] = {
                    ["priority"] = 61,
                    ["customPriority"] = true
                },
                [18498] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [12487] = {
                    ["size"] = 30,
                    ["customPriority"] = true,
                    ["nameplates"] = 0,
                    ["priority"] = 15,
                    ["customSize"] = true,
                    ["unitFrames"] = 0
                },
                [12486] = {
                    ["size"] = 30,
                    ["customPriority"] = true,
                    ["nameplates"] = 0,
                    ["priority"] = 15,
                    ["customSize"] = true,
                    ["unitFrames"] = 0
                },
                [10326] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [5246] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [30153] = {
                    ["nameplates"] = 0
                },
                [49203] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [1330] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [82691] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [8178] = {},
                [49039] = {
                    ["nameplates"] = 0
                },
                [13119] = {},
                [13120] = {},
                [63529] = {
                    ["nameplates"] = 0,
                    ["customPriority"] = false,
                    ["customSize"] = true,
                    ["size"] = 30
                },
                [51722] = {
                    ["priority"] = 56,
                    ["customPriority"] = true
                },
                [44614] = {
                    ["unitFrames"] = 0,
                    ["priority"] = 15,
                    ["nameplates"] = 0,
                    ["customPriority"] = true,
                    ["customSize"] = true,
                    ["size"] = 30
                },
                [25046] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [5134] = {
                    ["priority"] = 59,
                    ["customPriority"] = true
                },
                [15487] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [3409] = {
                    ["size"] = 30,
                    ["customPriority"] = true,
                    ["nameplates"] = 0,
                    ["priority"] = 15,
                    ["customSize"] = true,
                    ["unitFrames"] = 0
                },
                [31224] = {
                    ["nameplates"] = 0
                },
                [20170] = {
                    ["nameplates"] = 0,
                    ["customPriority"] = false
                },
                [116] = {
                    ["unitFrames"] = 0,
                    ["priority"] = 15,
                    ["nameplates"] = 0,
                    ["customPriority"] = true,
                    ["customSize"] = true,
                    ["size"] = 30
                },
                [64695] = {
                    ["customSize"] = false,
                    ["customPriority"] = false
                },
                [34490] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [28730] = {
                    ["priority"] = 55,
                    ["customPriority"] = true
                },
                [120] = {
                    ["size"] = 30,
                    ["customPriority"] = true,
                    ["nameplates"] = 0,
                    ["priority"] = 15,
                    ["customSize"] = true,
                    ["unitFrames"] = 0
                },
                [13139] = {}
            }
        },
        ["Default"] = {}
    }
}

function SC:BigDebuffsDB()
    if not SkillCappedBackupDB.BigDebuffsDB then
        SkillCappedBackupDB.BigDebuffsDB = SC:DeepCopy(BigDebuffsDB)
        SkillCappedBackupDB.addonBackupTimes["BigDebuffs"] = SC:GetDateAndTime()
    end

    BigDebuffsDB = scBigDebuffsDB

    SC:UpdateBigDebuffsProfile()

    --SC:UpdateAddonProfileKeysToSkillCapped("BigDebuffsDB")
end

function SC:UpdateBigDebuffsProfile()
    if not BigDebuffsDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    BigDebuffsDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        BigDebuffsDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end