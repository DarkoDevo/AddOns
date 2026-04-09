local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:ReforgeLiteDB()
    local scReforgeLiteDB = {
    ["char"] = {},
    ["class"] = {
    ["HUNTER"] = {
    ["customPresets"] = {
    ["SkillCapped Marksmanship Hunter"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 1020,
    ["preset"] = 2,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 7,
    ["points"] = {
    {
    ["value"] = 1020,
    ["preset"] = 5,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    60,
    40,
    80,
    20,
    },
    },
    },
    },
    ["WARRIOR"] = {
    ["customPresets"] = {
    ["SkillCapped Arms Warrior PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 1,
    ["preset"] = 2,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 7,
    ["points"] = {
    {
    ["value"] = 1,
    ["preset"] = 5,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    60,
    20,
    80,
    40,
    },
    },
    },
    },
    ["ROGUE"] = {
    ["customPresets"] = {
    ["SkillCapped Subtlety Rogue PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 1020,
    ["preset"] = 2,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 7,
    ["points"] = {
    {
    ["value"] = 1020,
    ["preset"] = 5,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    40,
    20,
    80,
    60,
    },
    },
    },
    },
    ["MAGE"] = {
    ["customPresets"] = {
    ["SkillCapped Frost Mage PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 1,
    ["preset"] = 3,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    80,
    60,
    0,
    40,
    },
    },
    },
    },
    ["PRIEST"] = {
    ["customPresets"] = {
    ["SkillCapped Shadow Priest PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 1,
    ["preset"] = 3,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    60,
    80,
    0,
    40,
    },
    },
    ["SkillCapped Holy Priest PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 6,
    ["points"] = {
    {
    ["value"] = 3400,
    ["preset"] = 1,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    },
    ["weights"] = {
    80,
    0,
    0,
    0,
    60,
    100,
    0,
    40,
    },
    },
    },
    },
    ["WARLOCK"] = {
    ["customPresets"] = {
    ["SkillCapped Affliction Warlock PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 2040,
    ["preset"] = 3,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    40,
    80,
    0,
    60,
    },
    },
    },
    },
    ["PALADIN"] = {
    ["customPresets"] = {
    ["SkillCapped Retribution Paladin PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 0,
    ["preset"] = 2,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 7,
    ["points"] = {
    {
    ["value"] = 0,
    ["preset"] = 5,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    40,
    60,
    80,
    20,
    },
    },
    ["SkillCapped Holy Paladin PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    },
    ["weights"] = {
    80,
    0,
    0,
    0,
    100,
    40,
    0,
    60,
    },
    },
    },
    },
    ["SHAMAN"] = {
    ["customPresets"] = {
    ["SkillCapped Elemental Shaman PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 2040,
    ["preset"] = 3,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    40,
    80,
    0,
    60,
    },
    },
    ["SkillCapped Restoration Shaman PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    },
    ["weights"] = {
    80,
    0,
    0,
    0,
    100,
    40,
    0,
    60,
    },
    },
    ["SkillCapped Enhancement Shaman PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 0,
    ["preset"] = 2,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 7,
    ["points"] = {
    {
    ["value"] = 0,
    ["preset"] = 5,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    40,
    20,
    80,
    60,
    },
    },
    },
    },
    ["DRUID"] = {
    ["customPresets"] = {
    ["SkillCapped Restoration Druid PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 6,
    ["points"] = {
    {
    ["value"] = 5321,
    ["preset"] = 1,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    },
    ["weights"] = {
    60,
    0,
    0,
    0,
    40,
    100,
    0,
    80,
    },
    },
    },
    },
    ["MONK"] = {
    ["customPresets"] = {
    ["SkillCapped Mistweaver Monk PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    {
    ["stat"] = 0,
    ["points"] = {
    },
    },
    },
    ["weights"] = {
    80,
    0,
    0,
    0,
    100,
    40,
    0,
    60,
    },
    },
    ["SkillCapped Windwalker Monk PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 0,
    ["preset"] = 2,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 7,
    ["points"] = {
    {
    ["value"] = 0,
    ["preset"] = 5,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    40,
    60,
    80,
    20,
    },
    },
    },
    },
    ["DEATHKNIGHT"] = {
    ["customPresets"] = {
    ["SkillCapped Unholy DK PvP"] = {
    ["caps"] = {
    {
    ["stat"] = 4,
    ["points"] = {
    {
    ["value"] = 1020,
    ["preset"] = 2,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    {
    ["stat"] = 7,
    ["points"] = {
    {
    ["value"] = 1020,
    ["preset"] = 5,
    ["method"] = 1,
    ["after"] = 0,
    },
    },
    },
    },
    ["weights"] = {
    0,
    0,
    0,
    100,
    40,
    20,
    80,
    60,
    },
    },
    },
    },
    },
    ["profileKeys"] = {
    ["Beckenbauer - Benediction"] = "SkillCapped",
    ["Laudren - Benediction"] = "SkillCapped",
    ["Abbadøn - Benediction"] = "SkillCapped",
    ["Tallyman - Benediction"] = "SkillCapped",
    ["Yawgmøth - Benediction"] = "SkillCapped",
    ["Sevatariøn - Benediction"] = "SkillCapped",
    ["Theløn - Benediction"] = "SkillCapped",
    ["Førge - Benediction"] = "SkillCapped",
    ["Rylanør - Benediction"] = "SkillCapped",
    ["Køth - Benediction"] = "SkillCapped",
    },
    ["global"] = {
    ["windowHeight"] = 577.3333740234375,
    ["windowY"] = 830.0007934570312,
    ["windowX"] = 620.0009155273438,
    ["windowWidth"] = 780,
    ["methodWindowY"] = 624,
    ["methodWindowX"] = 1377.000610351563,
    },
    }

    if not SkillCappedBackupDB.ReforgeLiteDB then
        SkillCappedBackupDB.ReforgeLiteDB = SC:DeepCopy(ReforgeLiteDB)
        SkillCappedBackupDB.addonBackupTimes["ReforgeLite"] = SC:GetDateAndTime()
    end

    ReforgeLiteDB = scReforgeLiteDB

    SC:UpdateReforgeLiteProfile()
end

function SC:UpdateReforgeLiteProfile()
    if not ReforgeLiteDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    ReforgeLiteDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        ReforgeLiteDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end