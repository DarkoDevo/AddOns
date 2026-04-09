local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:DiminishDB()
    local scDiminishDB = {
        ["profileKeys"] = {
            [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
            ["Default"] = {
                ["categoryTextures"] = {
                },
                ["timerText"] = true,
                ["timerColors"] = false,
                ["timerSwipe"] = true,
                ["announceDRs"] = false,
                ["unitFrames"] = {
                    ["nameplate"] = {
                        ["enabled"] = false,
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = false,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["growDirection"] = "RIGHT",
                        ["offsetX"] = -33,
                        ["timerTextSize"] = 12,
                        ["iconSize"] = 22,
                        ["offsetY"] = 71,
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = true,
                            ["none"] = true,
                            ["raid"] = false,
                            ["arena"] = true,
                            ["pvp"] = true,
                        },
                        ["isEnabledForZone"] = false,
                    },
                    ["player"] = {
                        ["enabled"] = true,
                        ["anchorUIParent"] = false,
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = true,
                            ["none"] = true,
                            ["raid"] = false,
                            ["arena"] = true,
                            ["pvp"] = true,
                        },
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = true,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["timerTextSize"] = 12,
                        ["offsetX"] = -6,
                        ["growDirection"] = "RIGHT",
                        ["iconSize"] = 21,
                        ["offsetY"] = 40,
                        ["usePersonalNameplate"] = false,
                        ["isEnabledForZone"] = true,
                    },
                    ["focus"] = {
                        ["enabled"] = false,
                        ["anchorUIParent"] = false,
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = false,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = true,
                            ["pvp"] = true,
                            ["raid"] = false,
                            ["arena"] = false,
                            ["none"] = true,
                        },
                        ["offsetX"] = 104,
                        ["growDirection"] = "RIGHT",
                        ["iconSize"] = 22,
                        ["offsetY"] = 23,
                        ["timerTextSize"] = 12,
                        ["isEnabledForZone"] = false,
                    },
                    ["target"] = {
                        ["enabled"] = true,
                        ["anchorUIParent"] = false,
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = false,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = true,
                            ["pvp"] = true,
                            ["raid"] = false,
                            ["arena"] = false,
                            ["none"] = true,
                        },
                        ["offsetX"] = 104,
                        ["growDirection"] = "RIGHT",
                        ["iconSize"] = 22,
                        ["offsetY"] = 23,
                        ["timerTextSize"] = 12,
                        ["isEnabledForZone"] = true,
                    },
                    ["arena"] = {
                        ["enabled"] = false,
                        ["anchorUIParent"] = false,
                        ["iconPadding"] = 10,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["growDirection"] = "LEFT",
                        ["offsetX"] = -66,
                        ["timerTextSize"] = 12,
                        ["iconSize"] = 22,
                        ["offsetY"] = 20,
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = false,
                            ["none"] = false,
                            ["raid"] = false,
                            ["arena"] = true,
                            ["pvp"] = false,
                        },
                        ["isEnabledForZone"] = false,
                    },
                    ["party"] = {
                        ["enabled"] = false,
                        ["anchorUIParent"] = false,
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = true,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["growDirection"] = "RIGHT",
                        ["offsetX"] = 76,
                        ["timerTextSize"] = 12,
                        ["iconSize"] = 24,
                        ["offsetY"] = 7,
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = false,
                            ["none"] = true,
                            ["raid"] = false,
                            ["arena"] = true,
                            ["pvp"] = false,
                        },
                        ["isEnabledForZone"] = false,
                    },
                },
                ["border"] = {
                    ["layer"] = "BORDER",
                    ["edgeSize"] = 2.5,
                    ["name"] = "Default",
                    ["edgeFile"] = "Interface\\BUTTONS\\UI-Quickslot-Depress",
                },
                ["timerEdge"] = true,
                ["showCategoryText"] = false,
                ["timerStartAuraEnd"] = false,
                ["version"] = "1.11",
                ["timerTextOutline"] = "NONE",
                ["colorBlind"] = false,
                ["trackNPCs"] = true,
                ["categoryTextMaxLines"] = 2,
                ["categoryFont"] = {
                    ["x"] = 0,
                    ["size"] = 9,
                },
            },
            ["SkillCapped"] = {
                ["categoryTextures"] = {
                },
                ["trackNPCs"] = true,
                ["categoryTextMaxLines"] = 2,
                ["timerSwipe"] = true,
                ["timerEdge"] = true,
                ["unitFrames"] = {
                    ["nameplate"] = {
                        ["enabled"] = false,
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = false,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["timerTextSize"] = 12,
                        ["offsetX"] = -33,
                        ["growDirection"] = "RIGHT",
                        ["iconSize"] = 22,
                        ["offsetY"] = 71,
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = true,
                            ["pvp"] = true,
                            ["raid"] = false,
                            ["arena"] = true,
                            ["none"] = true,
                        },
                        ["isEnabledForZone"] = false,
                    },
                    ["player"] = {
                        ["enabled"] = true,
                        ["anchorUIParent"] = false,
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = true,
                            ["pvp"] = true,
                            ["raid"] = false,
                            ["arena"] = true,
                            ["none"] = true,
                        },
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = true,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["growDirection"] = "RIGHT",
                        ["offsetX"] = -6,
                        ["timerTextSize"] = 12,
                        ["iconSize"] = 21,
                        ["offsetY"] = 40,
                        ["usePersonalNameplate"] = false,
                        ["isEnabledForZone"] = true,
                    },
                    ["focus"] = {
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = true,
                            ["none"] = true,
                            ["raid"] = false,
                            ["arena"] = false,
                            ["pvp"] = true,
                        },
                        ["anchorUIParent"] = false,
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = false,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["enabled"] = false,
                        ["offsetX"] = 104,
                        ["growDirection"] = "RIGHT",
                        ["iconSize"] = 22,
                        ["offsetY"] = 23,
                        ["timerTextSize"] = 12,
                        ["isEnabledForZone"] = false,
                    },
                    ["target"] = {
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = true,
                            ["none"] = true,
                            ["raid"] = false,
                            ["arena"] = false,
                            ["pvp"] = true,
                        },
                        ["anchorUIParent"] = false,
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = false,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["enabled"] = false,
                        ["offsetX"] = 104,
                        ["growDirection"] = "RIGHT",
                        ["iconSize"] = 22,
                        ["offsetY"] = 23,
                        ["timerTextSize"] = 12,
                        ["isEnabledForZone"] = false,
                    },
                    ["arena"] = {
                        ["enabled"] = false,
                        ["anchorUIParent"] = false,
                        ["iconPadding"] = 10,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["timerTextSize"] = 12,
                        ["offsetX"] = -66,
                        ["growDirection"] = "LEFT",
                        ["iconSize"] = 22,
                        ["offsetY"] = 20,
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = false,
                            ["pvp"] = false,
                            ["raid"] = false,
                            ["arena"] = true,
                            ["none"] = false,
                        },
                        ["isEnabledForZone"] = false,
                    },
                    ["party"] = {
                        ["enabled"] = false,
                        ["anchorUIParent"] = false,
                        ["iconPadding"] = 10,
                        ["watchFriendly"] = true,
                        ["disabledCategories"] = {
                            ["Taunts"] = true,
                        },
                        ["timerTextSize"] = 12,
                        ["offsetX"] = 76,
                        ["growDirection"] = "RIGHT",
                        ["iconSize"] = 24,
                        ["offsetY"] = 7,
                        ["zones"] = {
                            ["party"] = false,
                            ["scenario"] = false,
                            ["pvp"] = false,
                            ["raid"] = false,
                            ["arena"] = true,
                            ["none"] = true,
                        },
                        ["isEnabledForZone"] = false,
                    },
                },
                ["border"] = {
                    ["edgeSize"] = 2.5,
                    ["layer"] = "BORDER",
                    ["name"] = "Default",
                    ["edgeFile"] = "Interface\\BUTTONS\\UI-Quickslot-Depress",
                },
                ["announceDRs"] = false,
                ["version"] = "1.11",
                ["timerStartAuraEnd"] = false,
                ["showCategoryText"] = true,
                ["timerTextOutline"] = "NONE",
                ["colorBlind"] = false,
                ["timerColors"] = false,
                ["timerText"] = true,
                ["categoryFont"] = {
                    ["size"] = 9,
                    ["x"] = 0,
                },
            },
        },
    }

    if not SkillCappedBackupDB.DiminishDB then
        SkillCappedBackupDB.DiminishDB = SC:DeepCopy(DiminishDB)
        SkillCappedBackupDB.addonBackupTimes["Diminish"] = SC:GetDateAndTime()
    end

    DiminishDB = scDiminishDB

    SC:UpdateDiminishProfile()
end

function SC:UpdateDiminishProfile()
    if not DiminishDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    DiminishDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        DiminishDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end