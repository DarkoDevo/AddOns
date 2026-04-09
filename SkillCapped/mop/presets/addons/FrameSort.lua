local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:FrameSortDB()
    local scFrameSortDB = {
        ["Options"] = {
            ["AutoLeader"] = {
                ["Enabled"] = true,
            },
            ["Version"] = 20,
            ["Spacing"] = {
                ["Party"] = {
                    ["Horizontal"] = 0,
                    ["Vertical"] = 0,
                },
                ["Raid"] = {
                    ["Horizontal"] = 0,
                    ["Vertical"] = 0,
                },
                ["EnemyArena"] = {
                    ["Horizontal"] = 0,
                    ["Vertical"] = 0,
                },
            },
            ["Logging"] = {
                ["Enabled"] = false,
            },
            ["Sorting"] = {
                ["Dungeon"] = {
                    ["PlayerSortMode"] = "Top",
                    ["Enabled"] = true,
                    ["GroupSortMode"] = "Role",
                    ["Reverse"] = false,
                },
                ["RoleOrdering"] = 1,
                ["EnemyArena"] = {
                    ["GroupSortMode"] = "Group",
                    ["Enabled"] = false,
                    ["Reverse"] = false,
                },
                ["Arena"] = {
                    ["Default"] = {
                        ["PlayerSortMode"] = "Bottom",
                        ["Enabled"] = true,
                        ["GroupSortMode"] = "Group",
                        ["Reverse"] = false,
                    },
                    ["Twos"] = {
                        ["PlayerSortMode"] = "Bottom",
                        ["Enabled"] = true,
                        ["GroupSortMode"] = "Group",
                        ["Reverse"] = false,
                    },
                },
                ["Raid"] = {
                    ["PlayerSortMode"] = "Top",
                    ["Enabled"] = false,
                    ["GroupSortMode"] = "Role",
                    ["Reverse"] = false,
                },
                ["Method"] = "Secure",
                ["World"] = {
                    ["PlayerSortMode"] = "Top",
                    ["Enabled"] = true,
                    ["GroupSortMode"] = "Group",
                    ["Reverse"] = false,
                },
            },
        },
    }

    if not SkillCappedBackupDB.FrameSortDB then
        SkillCappedBackupDB.FrameSortDB = SC:DeepCopy(FrameSortDB)
        SkillCappedBackupDB.addonBackupTimes["FrameSort"] = SC:GetDateAndTime()
    end

    FrameSortDB = scFrameSortDB
end