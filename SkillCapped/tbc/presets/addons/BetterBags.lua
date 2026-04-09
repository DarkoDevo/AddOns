local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:BetterBagsDB()
    local scBetterBagsDB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "Default",
        },
        ["profiles"] = {
        ["Default"] = {
        ["__profileSystemMigrated"] = true,
        ["size"] = {
        nil,
        {
        {
        ["itemsPerRow"] = 12,
        ["scale"] = 95,
        },
        [0] = {
        ["scale"] = 95,
        },
        },
        },
        ["ephemeralCategoryFilters"] = {
        ["Inscription"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Inscription",
        ["dynamic"] = true,
        },
        ["Armor - Miscellaneous"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Armor - Miscellaneous",
        ["dynamic"] = true,
        },
        ["Consumable - Flasks & Phials"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Consumable - Flasks & Phials",
        ["dynamic"] = true,
        },
        ["Back"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Back",
        ["dynamic"] = true,
        },
        ["Profession"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Profession",
        ["dynamic"] = true,
        },
        ["Quest"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Quest",
        ["dynamic"] = true,
        },
        ["Tailoring"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tailoring",
        ["dynamic"] = true,
        },
        ["Tradeskill"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tradeskill",
        ["dynamic"] = true,
        },
        ["Elemental"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Elemental",
        ["dynamic"] = true,
        },
        ["Gem - Multiple Stats"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Gem - Multiple Stats",
        ["dynamic"] = true,
        },
        ["Miscellaneous - Other"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Miscellaneous - Other",
        ["dynamic"] = true,
        },
        ["Item Enhancement - Chest"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Item Enhancement - Chest",
        ["dynamic"] = true,
        },
        ["Item Enhancement - Feet"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Item Enhancement - Feet",
        ["dynamic"] = true,
        },
        ["Item Enhancement"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Item Enhancement",
        ["dynamic"] = true,
        },
        ["Jewelcrafting"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Jewelcrafting",
        ["dynamic"] = true,
        },
        ["Neck"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Neck",
        ["dynamic"] = true,
        },
        ["Tradeskill - Metal & Stone"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tradeskill - Metal & Stone",
        ["dynamic"] = true,
        },
        ["Item Enhancement - Legs"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Item Enhancement - Legs",
        ["dynamic"] = true,
        },
        ["Tradeskill - Cooking"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tradeskill - Cooking",
        ["dynamic"] = true,
        },
        ["Other"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Other",
        ["dynamic"] = true,
        },
        ["Tradeskill - Optional Reagents"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tradeskill - Optional Reagents",
        ["dynamic"] = true,
        },
        ["Consumable - Potions"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Consumable - Potions",
        ["dynamic"] = true,
        },
        ["Finger"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Finger",
        ["dynamic"] = true,
        },
        ["Item Enhancement - Wrist"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Item Enhancement - Wrist",
        ["dynamic"] = true,
        },
        ["Item Enhancement - Cloak"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Item Enhancement - Cloak",
        ["dynamic"] = true,
        },
        ["Tradeskill - Elemental"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tradeskill - Elemental",
        ["dynamic"] = true,
        },
        ["Recipe"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Recipe",
        ["dynamic"] = true,
        },
        ["Miscellaneous - Junk"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Miscellaneous - Junk",
        ["dynamic"] = true,
        },
        ["Tradeskill - Jewelcrafting"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tradeskill - Jewelcrafting",
        ["dynamic"] = true,
        },
        ["Key"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Key",
        ["dynamic"] = true,
        },
        ["Tradeskill - Inscription"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tradeskill - Inscription",
        ["dynamic"] = true,
        },
        ["Armor"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Armor",
        ["dynamic"] = true,
        },
        ["Recent Items"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Recent Items",
        ["dynamic"] = true,
        },
        ["Armor - Cloth"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Armor - Cloth",
        ["dynamic"] = true,
        },
        ["Container"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Container",
        ["dynamic"] = true,
        },
        ["Everything"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Everything",
        ["dynamic"] = true,
        },
        ["Quest - Quest"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Quest - Quest",
        ["dynamic"] = true,
        },
        ["Held In Off-hand"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Held In Off-hand",
        ["dynamic"] = true,
        },
        ["Tradeskill - Other"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tradeskill - Other",
        ["dynamic"] = true,
        },
        ["Junk"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Junk",
        ["dynamic"] = true,
        },
        ["Mining"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Mining",
        ["dynamic"] = true,
        },
        ["Optional Reagents"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Optional Reagents",
        ["dynamic"] = true,
        },
        ["Miscellaneous"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Miscellaneous",
        ["dynamic"] = true,
        },
        ["Free Space"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Free Space",
        ["dynamic"] = true,
        },
        ["Consumable"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Consumable",
        ["dynamic"] = true,
        },
        ["Gem"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Gem",
        ["dynamic"] = true,
        },
        ["Cooking"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Cooking",
        ["dynamic"] = true,
        },
        ["Weapon"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Weapon",
        ["dynamic"] = true,
        },
        ["Tradeskill - Cloth"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Tradeskill - Cloth",
        ["dynamic"] = true,
        },
        ["Gem - Other"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Gem - Other",
        ["dynamic"] = true,
        },
        ["Item Enhancement - Finger"] = {
        ["enabled"] = {
        true,
        [0] = true,
        },
        ["itemList"] = {
        },
        ["name"] = "Item Enhancement - Finger",
        ["dynamic"] = true,
        },
        },
        ["categoryFilters"] = {
        {
        ["EquipmentLocation"] = false,
        ["RecentItems"] = false,
        },
        [0] = {
        ["EquipmentLocation"] = false,
        },
        },
        ["itemSort"] = {
        {
        nil,
        3,
        },
        [0] = {
        nil,
        3,
        },
        },
        ["positions"] = {
        {
        ["y"] = -23.50546982143715,
        ["x"] = 18.52898250217208,
        ["point"] = "TOPLEFT",
        ["scale"] = 0.949999988079071,
        },
        [0] = {
        ["y"] = -111.7966442540878,
        ["x"] = -81.94583609052643,
        ["point"] = "RIGHT",
        ["scale"] = 0.949999988079071,
        },
        },
        ["anchorPositions"] = {
        [0] = {
        ["y"] = 0.706207275390625,
        ["x"] = -0.38421630859375,
        ["point"] = "CENTER",
        ["scale"] = 1,
        },
        },
        ["firstTimeMenu"] = false,
        ["showAllFreeSpace"] = {
        true,
        },
        ["categoryOptions"] = {
        ["Inscription"] = {
        ["shown"] = true,
        },
        ["Armor - Miscellaneous"] = {
        ["shown"] = true,
        },
        ["Consumable - Flasks & Phials"] = {
        ["shown"] = true,
        },
        ["Tradeskill - Cloth"] = {
        ["shown"] = true,
        },
        ["Profession"] = {
        ["shown"] = true,
        },
        ["Quest"] = {
        ["shown"] = true,
        },
        ["Tailoring"] = {
        ["shown"] = true,
        },
        ["Tradeskill"] = {
        ["shown"] = true,
        },
        ["Elemental"] = {
        ["shown"] = true,
        },
        ["Gem - Multiple Stats"] = {
        ["shown"] = true,
        },
        ["Miscellaneous - Other"] = {
        ["shown"] = true,
        },
        ["Quest - Quest"] = {
        ["shown"] = true,
        },
        ["Gem - Other"] = {
        ["shown"] = true,
        },
        ["Item Enhancement"] = {
        ["shown"] = true,
        },
        ["Item Enhancement - Cloak"] = {
        ["shown"] = true,
        },
        ["Item Enhancement - Chest"] = {
        ["shown"] = true,
        },
        ["Tradeskill - Metal & Stone"] = {
        ["shown"] = true,
        },
        ["Item Enhancement - Legs"] = {
        ["shown"] = true,
        },
        ["Tradeskill - Cooking"] = {
        ["shown"] = true,
        },
        ["Other"] = {
        ["shown"] = true,
        },
        ["Tradeskill - Optional Reagents"] = {
        ["shown"] = true,
        },
        ["Consumable - Potions"] = {
        ["shown"] = true,
        },
        ["Finger"] = {
        ["shown"] = true,
        },
        ["Item Enhancement - Wrist"] = {
        ["shown"] = true,
        },
        ["Recipe"] = {
        ["shown"] = true,
        },
        ["Tradeskill - Elemental"] = {
        ["shown"] = true,
        },
        ["Cooking"] = {
        ["shown"] = true,
        },
        ["Miscellaneous - Junk"] = {
        ["shown"] = true,
        },
        ["Consumable"] = {
        ["shown"] = true,
        },
        ["Key"] = {
        ["shown"] = true,
        },
        ["Tradeskill - Inscription"] = {
        ["shown"] = true,
        },
        ["Armor"] = {
        ["shown"] = true,
        },
        ["Recent Items"] = {
        ["shown"] = true,
        },
        ["Junk"] = {
        ["shown"] = true,
        },
        ["Container"] = {
        ["shown"] = true,
        },
        ["Everything"] = {
        ["shown"] = true,
        },
        ["Held In Off-hand"] = {
        ["shown"] = true,
        },
        ["Back"] = {
        ["shown"] = true,
        },
        ["Tradeskill - Other"] = {
        ["shown"] = true,
        },
        ["Neck"] = {
        ["shown"] = true,
        },
        ["Mining"] = {
        ["shown"] = true,
        },
        ["Optional Reagents"] = {
        ["shown"] = true,
        },
        ["Miscellaneous"] = {
        ["shown"] = true,
        },
        ["Free Space"] = {
        ["shown"] = true,
        },
        ["Tradeskill - Jewelcrafting"] = {
        ["shown"] = true,
        },
        ["Gem"] = {
        ["shown"] = true,
        },
        ["Armor - Cloth"] = {
        ["shown"] = true,
        },
        ["Jewelcrafting"] = {
        ["shown"] = true,
        },
        ["Weapon"] = {
        ["shown"] = true,
        },
        ["Item Enhancement - Feet"] = {
        ["shown"] = true,
        },
        ["Item Enhancement - Finger"] = {
        ["shown"] = true,
        },
        },
        ["newItems"] = {
        {
        ["markRecentItems"] = false,
        },
        },
        ["itemLevelColor"] = {
        ["maxItemLevelByCharacter"] = {
        ["Mýstíc-Ravencrest"] = 98,
        },
        },
        ["enterToMakeCategory"] = false,
        },
        },
    }

    if not SkillCappedBackupDB.BetterBagsDB then
        SkillCappedBackupDB.BetterBagsDB = SC:DeepCopy(BetterBagsDB)
        SkillCappedBackupDB.addonBackupTimes["BetterBags"] = SC:GetDateAndTime()
    end

    BetterBagsDB = scBetterBagsDB

    SC:UpdateBetterBagsProfile()
end

function SC:UpdateBetterBagsProfile()
    if not BetterBagsDB then return end
    if not SkillCappedBackupDB.BetterBagsDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    BetterBagsDB.profileKeys[playerNameAndRealm] = "Default"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        BetterBagsDB.profileKeys[savedPlayerNameAndRealm] = "Default"
    end
end