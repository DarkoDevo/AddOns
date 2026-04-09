local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:BigDebuffsDB()
    local scBigDebuffsDB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["profiles"] = {
        ["SkillCapped"] = {
        ["raidFrames"] = {
        ["dispellable"] = {
        ["cc"] = 50,
        ["roots"] = 40,
        },
        ["maxDebuffs"] = 3,
        ["interrupts"] = 50,
        ["debuffs_offensive"] = 30,
        ["warning"] = 30,
        ["hideBliz"] = false,
        ["pve"] = 30,
        ["increaseBuffs"] = true,
        ["warningList"] = {
        [30405] = true,
        },
        ["buffs"] = 30,
        ["redirectBliz"] = true,
        },
        ["nameplates"] = {
        ["buffs_speed_boost"] = false,
        ["enemyAnchor"] = {
        ["anchor"] = "RIGHT",
        ["size"] = 27,
        },
        ["buffs_defensive"] = false,
        ["debuffs_offensive"] = false,
        ["buffs_offensive"] = false,
        ["immunities_spells"] = false,
        ["buffs_other"] = false,
        },
        ["unitFrames"] = {
        ["party3"] = {
        },
        ["party4"] = {
        },
        ["party2"] = {
        },
        ["party1"] = {
        },
        },
        },
        },
    }

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