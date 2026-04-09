local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:FrameSortDB()
    local scFrameSortDB = {
        ["Log"] = {
        ["Max"] = 5000,
        ["Buffer"] = {},
        ["Size"] = 1816,
        ["Head"] = 1817,
        },
        ["Options"] = {
        ["Locale"] = "",
        ["Version"] = 25,
        ["Spacing"] = {
        ["Party"] = {
        ["Vertical"] = 0,
        ["Horizontal"] = 0,
        },
        ["Raid"] = {
        ["Vertical"] = 0,
        ["Horizontal"] = 0,
        },
        ["EnemyArena"] = {
        ["Vertical"] = 0,
        ["Horizontal"] = 0,
        },
        },
        ["Nameplates"] = {
        ["EnemyFormat"] = "$framenumber",
        ["FriendlyEnabled"] = false,
        ["EnemyEnabled"] = false,
        ["FriendlyFormat"] = "$framenumber",
        },
        ["AutoLeader"] = {
        ["Enabled"] = true,
        },
        ["Sorting"] = {
        ["Method"] = "Secure",
        ["Ordering"] = {
        ["Tanks"] = 1,
        ["Casters"] = 3,
        ["Hunters"] = 4,
        ["Melee"] = 5,
        ["Healers"] = 2,
        },
        ["Miscellaneous"] = {
        ["PlayerRoleSort"] = "None",
        },
        ["Dungeon"] = {
        ["PlayerSortMode"] = "Top",
        ["Enabled"] = true,
        ["GroupSortMode"] = "Role",
        ["Reverse"] = false,
        },
        ["EnemyArena"] = {
        ["GroupSortMode"] = "Group",
        ["Enabled"] = false,
        ["Reverse"] = false,
        },
        ["Raid"] = {
        ["PlayerSortMode"] = "Top",
        ["Enabled"] = false,
        ["GroupSortMode"] = "Role",
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
        ["SpecPriority"] = {
        ["Tanks"] = {
        },
        ["Melee"] = {
        },
        ["Hunters"] = {
        },
        ["Casters"] = {
        },
        ["Healers"] = {
        },
        },
        ["World"] = {
        ["PlayerSortMode"] = "Top",
        ["Enabled"] = true,
        ["GroupSortMode"] = "Group",
        ["Reverse"] = false,
        },
        },
        },
        ["SpecCache"] = {
        },
    }

    if not SkillCappedBackupDB.FrameSortDB then
        SkillCappedBackupDB.FrameSortDB = SC:DeepCopy(FrameSortDB)
        SkillCappedBackupDB.addonBackupTimes["FrameSort"] = SC:GetDateAndTime()
    end

    FrameSortDB = scFrameSortDB
end