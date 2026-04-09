local AddonName, SkillCapped = ...
local SC = SkillCapped
local coloredAddonName = "|cFFFFFFFFSkill|r|cff7ba4fcCapped|r"
local scIcon = "|TInterface/AddOns/SkillCapped/media/icon.blp:16:16:0:0|t"

local _, class = UnitClass("player")
local specIndex = GetSpecialization()

local socketSlots = {
    ["head"] = 1,
    ["neck"] = 1,
    ["ring1"] = 1,
    ["ring2"] = 1,
    ["wrist"] = 1,
    ["waist"] = 1,
}

local fiberGemExists = false
local legendaryCloakID = 235499

local bonusIds = { -- [SpellID] = BonusID
    [458573] = 11300, -- Ascendence (226024 itemid)
    [443902] = 11109, -- Writhing (219504 itemid)
    [461177] = 10520, -- Elemental Focusing Lens
    [457677] = 11304, -- Vers above 80%
    [455147] = 11226, -- Energy Redistribution Beacon
}
-- MISSING: Crit above 80%

local embellishItemIDs = {
    [458573] = 226024,
    [443902] = 219504,
    [461177] = 213770,
    [457677] = 222873,
    [455147] = 221943,
}

local function ItemTooltip(frame, id, anchor)
    frame:SetScript("OnEnter", function()
        GameTooltip:SetOwner(frame, anchor)
        GameTooltip:SetItemByID(id)
        GameTooltip:Show()
    end)
    frame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

local function GetGemIDsForSlot(slot, bloodstone, gemID, bloodstoneID, fiberID, itemID)
    local maxSockets = socketSlots[slot] or 0 -- Check how many sockets the slot can have

    -- Dynamically create gemIDs based on the number of sockets
    local gemIDs = {}

    local uniqueLegendaryCloak = fiberGemExists and slot == "back" and itemID == legendaryCloakID and fiberID

    if uniqueLegendaryCloak then
        table.insert(gemIDs, fiberID)
    else
        -- Handle the specific number of sockets
        if maxSockets >= 1 then
            table.insert(gemIDs, bloodstone and bloodstoneID or gemID)
        end
        if maxSockets >= 2 then
            table.insert(gemIDs, gemID)
        end
        if maxSockets >= 3 then
            table.insert(gemIDs, gemID)
        end
        if maxSockets >= 4 then
            table.insert(gemIDs, gemID)
        end
    end

    return gemIDs
end

local wepOnlyEmbellishment = 458573--226024
local secondEmbellishment = 443902--219504

local spellEnchants = {
    [3370] = 53343, -- Rune of Razorice
    [6241] = 326805, -- Rune of Sanguination
    [6242] = 326855, -- Rune of Spellwarding
    [3368] = 53344, -- Rune of the Fallen Crusader
    [3847] = 62158, -- Rune of the Stoneskin Gargoyle
}

-- 7388 leech (wrist) -> 223719
-- 7410 speed (back) -> 223800
-- 7393 speed (wrist) -> 223725
-- 7337 haste (ring) -> 223674
-- 7396 speed (wrist) - > 223725

local enchantsToItemID = {
    [7409] = 223737,
    [7364] = 223692,
    [7391] = 223719,
    [7601] = 219911,
    [7418] = 223653,
    [7352] = 223680,
    [7463] = 223781,
    [7415] = 223800,
    [7397] = 223724,
    [7534] = 222893,
    [7358] = 223686,
    [7531] = 222896,
    [7479] = 223793,
    [7445] = 223765,
    [7454] = 223778,
    [7340] = 223674,
    [7355] = 223683,
    [7346] = 223677,
    [3368] = 53344,
    [3370] = 53343,
    [6241] = 326805,
    [7424] = 223656,
    [7448] = 223768,

    -- Big ones
    [7914] = 238405, -- Twilight Devastation
    [7917] = 238680, -- Echoing Void
    [7924] = 239080, -- Infinite Stars
    [7927] = 239086, -- Gushing Wound
    [7930] = 239090, -- Twisted Appendage
    [7933] = 239095, -- Void Ritual

    -- Lesser ones
    [7912] = 238405, -- Twilight Devastation (238403 lesser)
    [7915] = 238680, -- Echoing Void (238678 lesser)
    [7922] = 239080, -- Infinite Stars (239078 lesser)
    [7925] = 239086, -- Gushing Wound (239084 lesser)
    [7928] = 239090, -- Twisted Appendage (239088 lesser)
    [7931] = 239095, -- Void Ritual (239093 lesser)

    [7935] = 240133, -- Sunfire Silk Spellthread

    [7936] = 240155, --Arcanoweave Spellthread (240154)
    [7937] = 240155, --Arcanoweave Spellthread (240155)
    [7938] = 240157, --Bright Linen Spellthread (240156)
    [7939] = 240157, --Bright Linen Spellthread (240157)
    [7956] = 243947, --Mark of Nalorakk (243946)
    [7957] = 243947, --Mark of Nalorakk (243947)
    [7958] = 243951, --Hex of Leeching (243948)
    [7959] = 243951, --Hex of Leeching (243949)
    [7961] = 243951, --Hex of Leeching (243951)
    [7962] = 243953, --Lynx's Dexterity (243952)
    [7963] = 243953, --Lynx's Dexterity (243953)
    [7964] = 243955, --Amani Mastery (243954)
    [7965] = 243955, --Amani Mastery (243955)
    [7969] = 243959, --Zul'jin's Mastery (243959)
    [7970] = 243961, --Flight of the Eagle (243960)
    [7971] = 243961, --Flight of the Eagle (243961)
    [7972] = 243963, --Akil'zon's Swiftness (243962)
    [7973] = 243963, --Akil'zon's Swiftness (243963)
    [7979] = 243969, --Strength of Halazzi (243969)
    [7980] = 243971, --Jan'alai's Precision (243970)
    [7981] = 243971, --Jan'alai's Precision (243971)
    [7982] = 243973, --Berserker's Rage (243972)
    [7983] = 243973, --Berserker's Rage (243973)
    [7985] = 243975, --Mark of the Rootwarden (243975)
    [7986] = 243977, --Mark of the Worldsoul (243976)
    [7987] = 243977, --Mark of the Worldsoul (243977)
    [7988] = 243981, --Blessing of Speed (243978)
    [7989] = 243981, --Blessing of Speed (243979)
    [7991] = 243981, --Empowered Blessing of Speed (243981)
    [7992] = 243983, --Shaladrassil's Roots (243982)
    [7993] = 243983, --Shaladrassil's Roots (243983)
    [7994] = 243985, --Nature's Wrath (243986)
    [7995] = 243985, --Nature's Wrath (243985)
    [7998] = 243989, --Nature's Grace (243988)
    [7999] = 243989, --Nature's Grace (243989)
    [8008] = 243999, --Worldsoul Aegis (243998)
    [8009] = 243999, --Worldsoul Aegis (243999)
    [8011] = 244001, --Worldsoul Tenacity (244001)
    [8012] = 244003, --Mark of the Magister (244002)
    [8013] = 244003, --Mark of the Magister (244003)
    [8014] = 244007, --Rune of Avoidance (244004)
    [8015] = 244007, --Rune of Avoidance (244005)
    [8018] = 244009, --Farstrider's Hunt (244008)
    [8019] = 244009, --Farstrider's Hunt (244009)
    [8020] = 244011, --Thalassian Haste (244010)
    [8021] = 244011, --Thalassian Haste (244011)
    [8022] = 244013, --Thalassian Versatility (244012)
    [8023] = 244013, --Thalassian Versatility (244013)
    [8025] = 244015, --Silvermoon's Alacrity (244014)
    [8026] = 244015, --Silvermoon's Alacrity (244015)
    [8028] = 244019, --Thalassian Recovery (244018)
    [8029] = 244019, --Thalassian Recovery (244019)
    [8030] = 244021, --Silvermoon's Mending (244020)
    [8031] = 244021, --Silvermoon's Mending (244021)
    [8037] = 244027, --Flames of the Sin'dorei (244027)
    [8038] = 244029, --Acuity of the Ren'dorei (244028)
    [8039] = 244029, --Acuity of the Ren'dorei (244029)
    [8040] = 244031, --Arcane Mastery (244030)
    [8041] = 244031, --Arcane Mastery (244031)
    [8158] = 244641, --Forest Hunter's Armor Kit (244640)
    [8159] = 244641, --Forest Hunter's Armor Kit (244641)
    [8160] = 244645, --Thalassian Scout Armor Kit (244644)
    [8161] = 244645, --Thalassian Scout Armor Kit (244645)
    [8163] = 244643, --Blood Knight's Armor Kit (244643)
    [8612] = 257748, --Smuggler's Lynxeye (257747)
    [8613] = 257748, --Smuggler's Lynxeye (257748)
    [8614] = 257746, --Farstrider's Lynxeye (257745)
    [8615] = 257746, --Farstrider's Lynxeye (257746)
}

--enchantID - itemID
local BisGear = {
    ["ENCHANTS"] = {
        [7973] = 243963,
        [7991] = 243981,
        [7987] = 243977,
        [8159] = 244641,
        [8019] = 244009,
        [7969] = 243959,
        [8039] = 244029,
        [7935] = 240133,
        [8025] = 244015,
        [8013] = 244003,
        [7937] = 240155,
        [7957] = 243947,
        [7362] = 223692,
        [7418] = 223653,
        [7474] = 223796,
        [7462] = 223781,
        [8030] = 244021,
        [7961] = 243951,
        [7971] = 243961,
        [7959] = 243949,
        [7355] = 223683,
        [7965] = 243954,
        [8008] = 243998,
        [8029] = 244019,
        [7364] = 223692,
        [8023] = 244014,
        [7448] = 223768,
    },
    ["DEATHKNIGHT"] = {
        [1] = nil,
        [2] = { -- Frost
            ["statPriority"] = {"Versatility", "Mastery", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 249970,
                ["neck"] = 240952,
                ["shoulders"] = 249968,
                ["back"] = 239678,
                ["chest"] = 249973,
                ["wrist"] = 237908,
                ["hands"] = 249971,
                ["waist"] = 255561,
                ["legs"] = 255557,
                ["feet"] = 255551,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255633,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7957,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Unholy
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 249970,
                ["neck"] = 240952,
                ["shoulders"] = 249968,
                ["back"] = 239678,
                ["chest"] = 249973,
                ["wrist"] = 237908,
                ["hands"] = 249971,
                ["waist"] = 255561,
                ["legs"] = 255557,
                ["feet"] = 255551,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255633,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7957,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["WARRIOR"] = {
        [1] = { -- Arms
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 249952,
                ["neck"] = 255610,
                ["shoulders"] = 249950,
                ["back"] = 239678,
                ["chest"] = 255588,
                ["wrist"] = 237908,
                ["hands"] = 249953,
                ["waist"] = 255601,
                ["legs"] = 249951,
                ["feet"] = 255590,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 265601,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = { -- Fury
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 249952,
                ["neck"] = 255610,
                ["shoulders"] = 249950,
                ["back"] = 239678,
                ["chest"] = 255588,
                ["wrist"] = 237908,
                ["hands"] = 249953,
                ["waist"] = 255601,
                ["legs"] = 249951,
                ["feet"] = 255590,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 265601,
                ["offHand"] = 265601,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
                ["offHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
                ["offHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Prot
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 255262,
                ["neck"] = 255334,
                ["shoulders"] = 255315,
                ["back"] = 255338,
                ["chest"] = 255264,
                ["wrist"] = 255323,
                ["hands"] = 255304,
                ["waist"] = 255318,
                ["legs"] = 255278,
                ["feet"] = 255267,
                ["ring1"] = 255331,
                ["ring2"] = 255333,
                ["trinket1"] = 255327,
                ["trinket2"] = 255328,
                ["mainHand"] = 255343,
                ["offHand"] = 255350,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
                ["offHand"] = 8792,
            },
            ["gems"] = {
                ["bloodstone"] = 213747,
            },
            ["enchants"] = {
                ["shoulder"] = 8029,
                ["head"] = 7959,
                ["chest"] = 7364,
                ["feet"] = 7418,
                ["ring1"] = 8023,
                ["ring2"] = 8023,
                ["mainHand"] = 7448,
            },
            ["embellishment"] = {
                ["embellishment1"] = 457677,
                ["embellishment2"] = 1217091,
            },
        },
    },
    ["PALADIN"] = {
        [1] = { -- Holy
            ["statPriority"] = {"Mastery", "Versatility", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 249961,
                ["neck"] = 240952,
                ["shoulders"] = 249959,
                ["back"] = 239678,
                ["chest"] = 249964,
                ["wrist"] = 237908,
                ["hands"] = 249962,
                ["waist"] = 237907,
                ["legs"] = 237905,
                ["feet"] = 237902,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255624,
                ["offHand"] = 255632,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
                ["offHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 8013,
                ["legs"] = 7937,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = nil,
        [3] = { -- Ret
            ["statPriority"] = {"Versatility", "Mastery", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 249961,
                ["neck"] = 255612,
                ["shoulders"] = 249959,
                ["back"] = 255587,
                ["chest"] = 249964,
                ["wrist"] = 237908,
                ["hands"] = 249962,
                ["waist"] = 255581,
                ["legs"] = 255578,
                ["feet"] = 237902,
                ["ring1"] = 255609,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255633,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["MAGE"] = {
        [1] = { -- Arcane
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 255364,
                ["neck"] = 240952,
                ["shoulders"] = 250058,
                ["back"] = 255374,
                ["chest"] = 239685,
                ["wrist"] = 239677,
                ["hands"] = 250061,
                ["waist"] = 239682,
                ["legs"] = 255365,
                ["feet"] = 239684,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = { -- Fire
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 250060,
                ["neck"] = 240952,
                ["shoulders"] = 250058,
                ["back"] = 255374,
                ["chest"] = 239685,
                ["wrist"] = 239677,
                ["hands"] = 250061,
                ["waist"] = 239682,
                ["legs"] = 250059,
                ["feet"] = 239684,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Frost
            ["statPriority"] = {"Haste", "Versatility", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 250060,
                ["neck"] = 240952,
                ["shoulders"] = 250058,
                ["back"] = 255374,
                ["chest"] = 239685,
                ["wrist"] = 239677,
                ["hands"] = 250061,
                ["waist"] = 239682,
                ["legs"] = 250059,
                ["feet"] = 239684,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["PRIEST"] = {
        [1] = { -- Disc
            ["statPriority"] = {"Mastery", "Versatility", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 250051,
                ["neck"] = 240952,
                ["shoulders"] = 239683,
                ["back"] = 239678,
                ["chest"] = 250054,
                ["wrist"] = 239677,
                ["hands"] = 239679,
                ["waist"] = 239682,
                ["legs"] = 239681,
                ["feet"] = 239684,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255631,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 8013,
                ["legs"] = 7937,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = { -- Holy
            ["statPriority"] = {"Mastery", "Versatility", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 250051,
                ["neck"] = 240952,
                ["shoulders"] = 239683,
                ["back"] = 239678,
                ["chest"] = 250054,
                ["wrist"] = 239677,
                ["hands"] = 250052,
                ["waist"] = 239682,
                ["legs"] = 250050,
                ["feet"] = 239684,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255631,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 8013,
                ["legs"] = 7937,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Shadow
            ["statPriority"] = {"Haste", "Versatility", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 250051,
                ["neck"] = 255610,
                ["shoulders"] = 255386,
                ["back"] = 239678,
                ["chest"] = 250054,
                ["wrist"] = 239677,
                ["hands"] = 250052,
                ["waist"] = 255388,
                ["legs"] = 250050,
                ["feet"] = 239684,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["EVOKER"] = {
        [1] = { -- Dev
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 249997,
                ["neck"] = 240952,
                ["shoulders"] = 244564,
                ["back"] = 239678,
                ["chest"] = 250000,
                ["wrist"] = 244568,
                ["hands"] = 249998,
                ["waist"] = 244565,
                ["legs"] = 249996,
                ["feet"] = 244561,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = { -- Pres
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 249997,
                ["neck"] = 240952,
                ["shoulders"] = 244564,
                ["back"] = 239678,
                ["chest"] = 250000,
                ["wrist"] = 244568,
                ["hands"] = 249998,
                ["waist"] = 244565,
                ["legs"] = 249996,
                ["feet"] = 244561,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 8013,
                ["legs"] = 7937,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = nil,
    },
    ["HUNTER"] = {
        [1] = { -- BM
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 249988,
                ["neck"] = 240952,
                ["shoulders"] = 249986,
                ["back"] = 239678,
                ["chest"] = 249991,
                ["wrist"] = 244568,
                ["hands"] = 249989,
                ["waist"] = 255523,
                ["legs"] = 255520,
                ["feet"] = 255513,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255623,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = { -- MM
            ["statPriority"] = {"Versatility", "Mastery", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 255517,
                ["neck"] = 240952,
                ["shoulders"] = 249986,
                ["back"] = 239678,
                ["chest"] = 255512,
                ["wrist"] = 244568,
                ["hands"] = 249989,
                ["waist"] = 244565,
                ["legs"] = 255519,
                ["feet"] = 255514,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255630,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Survival
            ["statPriority"] = {"Mastery", "Versatility", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 255517,
                ["neck"] = 240952,
                ["shoulders"] = 249986,
                ["back"] = 255529,
                ["chest"] = 255512,
                ["wrist"] = 255525,
                ["hands"] = 249989,
                ["waist"] = 244565,
                ["legs"] = 244566,
                ["feet"] = 255514,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255621,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["WARLOCK"] = {
        [1] = { -- Affli
            ["statPriority"] = {"Haste", "Versatility", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 255402,
                ["neck"] = 255610,
                ["shoulders"] = 250040,
                ["back"] = 255413,
                ["chest"] = 250045,
                ["wrist"] = 239677,
                ["hands"] = 250043,
                ["waist"] = 255408,
                ["legs"] = 250041,
                ["feet"] = 239684,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = { -- Demo
            ["statPriority"] = {"Haste", "Versatility", "Crit", "Mastery"},
            ["gear"] = {
                ["head"] = 255402,
                ["neck"] = 255610,
                ["shoulders"] = 250040,
                ["back"] = 255413,
                ["chest"] = 250045,
                ["wrist"] = 239677,
                ["hands"] = 250043,
                ["waist"] = 255408,
                ["legs"] = 250041,
                ["feet"] = 239684,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Destro
            ["statPriority"] = {"Haste", "Versatility", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 255402,
                ["neck"] = 255610,
                ["shoulders"] = 250040,
                ["back"] = 255413,
                ["chest"] = 250045,
                ["wrist"] = 239677,
                ["hands"] = 250043,
                ["waist"] = 255408,
                ["legs"] = 250041,
                ["feet"] = 239684,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["DEMONHUNTER"] = {
        [1] = { -- Havoc
            ["statPriority"] = {"Versatility", "Mastery", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 250033,
                ["neck"] = 240952,
                ["shoulders"] = 250031,
                ["back"] = 239678,
                ["chest"] = 250036,
                ["wrist"] = 244560,
                ["hands"] = 244559,
                ["waist"] = 244557,
                ["legs"] = 250032,
                ["feet"] = 244553,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255620,
                ["offHand"] = 255620,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
                ["offHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 8030,
                ["head"] = 7961,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
                ["offHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = nil,
        [3] = { -- Devourer
            ["statPriority"] = {"Haste", "Versatility", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 250033,
                ["neck"] = 240952,
                ["shoulders"] = 250031,
                ["back"] = 239678,
                ["chest"] = 250036,
                ["wrist"] = 244560,
                ["hands"] = 244559,
                ["waist"] = 244557,
                ["legs"] = 250032,
                ["feet"] = 244553,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255620,
                ["offHand"] = 255620,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
                ["offHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 8030,
                ["head"] = 7961,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
                ["offHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["ROGUE"] = {
        [1] = { -- Assa
            ["statPriority"] = {"Versatility", "Mastery", "Crit", "Haste"},
            ["gear"] = {
                ["head"] = 250006,
                ["neck"] = 240952,
                ["shoulders"] = 250004,
                ["back"] = 239678,
                ["chest"] = 250009,
                ["wrist"] = 244560,
                ["hands"] = 244559,
                ["waist"] = 244557,
                ["legs"] = 250005,
                ["feet"] = 244553,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255614,
                ["trinket2"] = 255616,
                ["mainHand"] = 255619,
                ["offHand"] = 255619,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
                ["offHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
                ["offHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = { -- Outlaw
            ["statPriority"] = {"Versatility", "Crit", "Haste", "Mastery"},
            ["gear"] = {
                ["head"] = 217128,
                ["neck"] = 218712,
                ["shoulders"] = 237662,
                ["back"] = 235499,
                ["chest"] = 237667,
                ["wrist"] = 217133,
                ["hands"] = 217132,
                ["waist"] = 217130,
                ["legs"] = 217131,
                ["feet"] = 217126,
                ["ring1"] = 215137,
                ["ring2"] = 215137,
                ["trinket1"] = 230639,
                ["trinket2"] = 230641,
                ["mainHand"] = 230661,
                ["offHand"] = 230661,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8795,
                ["neck"] = 8795,
                ["shoulders"] = 8795,
                ["back"] = 8795,
                ["chest"] = 8795,
                ["wrist"] = 8795,
                ["hands"] = 8795,
                ["waist"] = 8795,
                ["legs"] = 8795,
                ["feet"] = 8795,
                ["ring1"] = 8795,
                ["ring2"] = 8795,
                ["mainHand"] = 8795,
                ["offHand"] = 8795,
            },
            ["gems"] = {
                ["gem"] = 238042,
                ["bloodstone"] = 213747,
            },
            ["enchants"] = {
                ["chest"] = 7362,
                ["feet"] = 7418,
                ["ring1"] = 7474,
                ["ring2"] = 7474,
                ["mainHand"] = 7462,
                ["offHand"] = 7462,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Sub
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 250006,
                ["neck"] = 240952,
                ["shoulders"] = 250004,
                ["back"] = 239678,
                ["chest"] = 255473,
                ["wrist"] = 244560,
                ["hands"] = 250007,
                ["waist"] = 244557,
                ["legs"] = 250005,
                ["feet"] = 244553,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255614,
                ["trinket2"] = 255616,
                ["mainHand"] = 237910,
                ["offHand"] = 237910,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
                ["offHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
                ["offHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["DRUID"] = {
        [1] = { -- Balance
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 250024,
                ["neck"] = 255610,
                ["shoulders"] = 250022,
                ["back"] = 239678,
                ["chest"] = 255415,
                ["wrist"] = 244560,
                ["hands"] = 250025,
                ["waist"] = 255429,
                ["legs"] = 250023,
                ["feet"] = 255418,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = { -- Feral
            ["statPriority"] = {"Versatility", "Mastery", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 250024,
                ["neck"] = 240952,
                ["shoulders"] = 250022,
                ["back"] = 239678,
                ["chest"] = 244554,
                ["wrist"] = 244560,
                ["hands"] = 250025,
                ["waist"] = 244557,
                ["legs"] = 250023,
                ["feet"] = 244553,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255637,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Guardian
            ["statPriority"] = {"Versatility", "Mastery", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 255277,
                ["neck"] = 255336,
                ["shoulders"] = 255282,
                ["back"] = 255339,
                ["chest"] = 255266,
                ["wrist"] = 255325,
                ["hands"] = 255271,
                ["waist"] = 255289,
                ["legs"] = 255313,
                ["feet"] = 255302,
                ["ring1"] = 255333,
                ["ring2"] = 255331,
                ["trinket1"] = 255327,
                ["trinket2"] = 255329,
                ["mainHand"] = 255344,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["bloodstone"] = 213748,
            },
            ["enchants"] = {
                ["shoulder"] = 7971,
                ["head"] = 7959,
                ["chest"] = 7355,
                ["feet"] = 7418,
                ["ring1"] = 7965,
                ["ring2"] = 7965,
                ["mainHand"] = 8008,
            },
            ["embellishment"] = {
                ["embellishment1"] = 1217091,
                ["embellishment2"] = 461177,
            },
        },
        [4] = { -- Resto
            ["statPriority"] = {"Mastery", "Versatility", "Haste", "Crit"},
            ["gear"] = {
                ["head"] = 250024,
                ["neck"] = 240952,
                ["shoulders"] = 250022,
                ["back"] = 239678,
                ["chest"] = 244554,
                ["wrist"] = 244560,
                ["hands"] = 250025,
                ["waist"] = 244557,
                ["legs"] = 250023,
                ["feet"] = 244553,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255631,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 8013,
                ["legs"] = 7937,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["MONK"] = {
        [1] = nil,
        [2] = { -- Mistweaver
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 250015,
                ["neck"] = 240952,
                ["shoulders"] = 250013,
                ["back"] = 239678,
                ["chest"] = 250018,
                ["wrist"] = 244560,
                ["hands"] = 244559,
                ["waist"] = 244557,
                ["legs"] = 250014,
                ["feet"] = 244553,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255622,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 8013,
                ["legs"] = 7937,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Windwalker
            ["statPriority"] = {"Mastery", "Versatility", "Crit", "Haste"},
            ["gear"] = {
                ["head"] = 244555,
                ["neck"] = 240952,
                ["shoulders"] = 250013,
                ["back"] = 239678,
                ["chest"] = 250018,
                ["wrist"] = 244560,
                ["hands"] = 250016,
                ["waist"] = 244557,
                ["legs"] = 250014,
                ["feet"] = 244553,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255637,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
    ["SHAMAN"] = {
        [1] = { -- Ele
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 249979,
                ["neck"] = 255610,
                ["shoulders"] = 249977,
                ["back"] = 239678,
                ["chest"] = 249982,
                ["wrist"] = 244568,
                ["hands"] = 255535,
                ["waist"] = 255542,
                ["legs"] = 249978,
                ["feet"] = 255532,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 267371,
                ["offHand"] = 255626,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
                ["offHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 7935,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [2] = { -- Enh
            ["statPriority"] = {"Versatility", "Haste", "Mastery", "Crit"},
            ["gear"] = {
                ["head"] = 249979,
                ["neck"] = 255610,
                ["shoulders"] = 249977,
                ["back"] = 239678,
                ["chest"] = 249982,
                ["wrist"] = 244568,
                ["hands"] = 255535,
                ["waist"] = 255542,
                ["legs"] = 249978,
                ["feet"] = 255532,
                ["ring1"] = 255607,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255636,
                ["offHand"] = 255636,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8792,
                ["neck"] = 8792,
                ["shoulders"] = 8792,
                ["back"] = 8792,
                ["chest"] = 8792,
                ["wrist"] = 8792,
                ["hands"] = 8792,
                ["waist"] = 8792,
                ["legs"] = 8792,
                ["feet"] = 8792,
                ["ring1"] = 8792,
                ["ring2"] = 8792,
                ["mainHand"] = 8792,
                ["offHand"] = 8792,
            },
            ["gems"] = {
                ["gem"] = 240894,
                ["bloodstone"] = 241144,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 7987,
                ["legs"] = 8159,
                ["feet"] = 8019,
                ["ring1"] = 8025,
                ["ring2"] = 8025,
                ["mainHand"] = 8039,
                ["offHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
        [3] = { -- Resto
            ["statPriority"] = {"Mastery", "Versatility", "Crit", "Haste"},
            ["gear"] = {
                ["head"] = 249979,
                ["neck"] = 240952,
                ["shoulders"] = 244564,
                ["back"] = 239678,
                ["chest"] = 249982,
                ["wrist"] = 244568,
                ["hands"] = 249980,
                ["waist"] = 244565,
                ["legs"] = 249978,
                ["feet"] = 244561,
                ["ring1"] = 240951,
                ["ring2"] = 240951,
                ["trinket1"] = 255616,
                ["trinket2"] = 255614,
                ["mainHand"] = 255624,
                ["offHand"] = 255632,
            },
            ["gearBonusIDs"] = {
                ["head"] = 8794,
                ["neck"] = 8794,
                ["shoulders"] = 8794,
                ["back"] = 8794,
                ["chest"] = 8794,
                ["wrist"] = 8794,
                ["hands"] = 8794,
                ["waist"] = 8794,
                ["legs"] = 8794,
                ["feet"] = 8794,
                ["ring1"] = 8794,
                ["ring2"] = 8794,
                ["mainHand"] = 8794,
                ["offHand"] = 8794,
            },
            ["gems"] = {
                ["gem"] = 240902,
                ["bloodstone"] = 241143,
            },
            ["enchants"] = {
                ["shoulders"] = 7973,
                ["head"] = 7991,
                ["chest"] = 8013,
                ["legs"] = 7937,
                ["feet"] = 8019,
                ["ring1"] = 7969,
                ["ring2"] = 7969,
                ["mainHand"] = 8039,
            },
            ["embellishment"] = {
                ["embellishment1"] = 240166,
                ["embellishment2"] = 240166,
            },
        },
    },
}

local function CheckEnchants()
    for enchantID, itemID in pairs(BisGear["ENCHANTS"]) do
        if not enchantsToItemID[enchantID] then
            enchantsToItemID[enchantID] = itemID
        end
    end
end

CheckEnchants()

local function CacheBisGearItems()
    local itemIDs = {}
    local classData = BisGear[class]
    if not classData then return end

    -- Iterate through all specs of the player's class
    for specIndex, specData in pairs(classData) do
        if type(specData) == "table" then
            -- Gear items
            if specData.gear then
                for _, itemID in pairs(specData.gear) do
                    if itemID then
                        itemIDs[itemID] = true
                    end
                end
            end

            -- Gems
            if specData.gems then
                if specData.gems.gem then
                    itemIDs[specData.gems.gem] = true
                end
                if specData.gems.bloodstone then
                    itemIDs[specData.gems.bloodstone] = true
                end
            end

            -- Enchants mapped to items
            if specData.enchants then
                for _, enchantID in pairs(specData.enchants) do
                    local enchantItemID = BisGear.ENCHANTS[enchantID]
                    if enchantItemID then
                        itemIDs[enchantItemID] = true
                    end
                end
            end

            -- Embellishments
            if specData.embellishment then
                for _, embellishID in pairs(specData.embellishment) do
                    local embellishItemID = embellishItemIDs[embellishID]
                    if embellishItemID then
                        itemIDs[embellishItemID] = true
                    end
                end
            end
        end
    end

    for enchantID, itemID in pairs(enchantsToItemID) do
        itemIDs[itemID] = true
    end

    for itemID in pairs(itemIDs) do
        C_Item.GetItemInfo(itemID)
    end
    C_Timer.After(0.1, function()
        for itemID in pairs(itemIDs) do
            C_Item.GetItemInfo(itemID)
        end
    end)
end
CacheBisGearItems()


local function GetItemQualityBonusID(itemQuality)
    local qualityBonusMap = {
        [2] = {1585, 12806}, -- Honor Gear (Uncommon) ilvl        --665
        [3] = {1595, 12806}, -- Warmonger (Rare) ilvl         --675
        [4] = {13448, 12806},  -- Conquest (Epic) ilvl 289
        [6] = {}, -- Mythic (Legendary) ilvl 680
    }
    -- bonus ids: itemLevel, PvP EquipBonus itemLevel

    return qualityBonusMap[itemQuality] or {}
end

local bisgearComingSoon = false

local embellishmentsAdded = 0
local embellishSlots = {}
local function CreateItemLink(gearSlot, bonusIDs, bloodstone, isCrafted)
    if not gearSlot then
        return nil
    end

    _, class = UnitClass("player")
    specIndex = GetSpecialization()
    local specData = BisGear[class][specIndex]

    local itemID = specData.gear[gearSlot]
    if not itemID then
        return nil
    end

    local enchantID = specData.enchants and specData.enchants[gearSlot] or ""
    local gemIDs = GetGemIDsForSlot(gearSlot, bloodstone, specData.gems.gem, specData.gems.bloodstone, fiberGemExists and specData.gems.fiber or nil, itemID)
    local embellishmentData = specData.embellishment or {}
    local linkLevel = 80
    local specializationID = nil
    local itemContext = 8

    local itemName = C_Item.GetItemNameByID(itemID) or "Unknown Item"

    local itemQuality = C_Item.GetItemQualityByID(itemID)
    if itemQuality ~= 6 then
        itemQuality = 4
    end
    -- Fetch the bonus IDs for the given item quality
    local itemExtraBonusIDs = GetItemQualityBonusID(itemQuality)

    -- Insert all bonus IDs from the table into bonusIDs

    local legendaryCloak = gearSlot == "back" and itemID == 235499
    if legendaryCloak then
        --
    else
        for _, bonusID in ipairs(itemExtraBonusIDs) do
            table.insert(bonusIDs, bonusID)
        end
    end

    --print(itemQuality)

    -- Add embellishments if the gearSlot matches specified slots
    local embellishmentAddedToItem = false
    if embellishmentsAdded ~= 2 then
        if embellishmentData.embellishment1 then
            if embellishmentData.embellishment1 == wepOnlyEmbellishment then
                -- Always on mainHand
                if gearSlot == "mainHand" then
                    local mappedBonusID = bonusIds[embellishmentData.embellishment1]
                    if mappedBonusID and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                        table.insert(bonusIDs, mappedBonusID)
                        if not embellishSlots[gearSlot] then
                            embellishmentsAdded = embellishmentsAdded + 1
                            embellishSlots[gearSlot] = true
                        end
                        embellishmentAddedToItem = true
                    end
                end
            elseif embellishmentData.embellishment1 == secondEmbellishment then
                local mappedBonusID = bonusIds[embellishmentData.embellishment1]
                local addedEmbellishment = false

                if mappedBonusID then
                    -- Check the primary slot first (waist)
                    if gearSlot == "waist" and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                        table.insert(bonusIDs, mappedBonusID)
                        if not embellishSlots[gearSlot] then
                            embellishmentsAdded = embellishmentsAdded + 1
                            embellishSlots[gearSlot] = true
                        end
                        embellishmentAddedToItem = true
                        addedEmbellishment = true
                    end

                    -- If not added to the primary slot, try fallbacks
                    if not addedEmbellishment then
                        local fallbackSlots = { "chest", "shoulders", "legs", "feet", "hands" }
                        for _, fallbackSlot in ipairs(fallbackSlots) do
                            if gearSlot == fallbackSlot and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                                table.insert(bonusIDs, mappedBonusID)
                                if not embellishSlots[gearSlot] then
                                    embellishmentsAdded = embellishmentsAdded + 1
                                    embellishSlots[gearSlot] = true
                                end
                                embellishmentAddedToItem = true
                                addedEmbellishment = true
                                break
                            end
                        end
                    end
                end
            else
                -- Default to ring1
                local mappedBonusID = bonusIds[embellishmentData.embellishment1]
                local addedEmbellishment = false

                if mappedBonusID then
                    -- Check the primary slot first (ring1)
                    if gearSlot == "ring1" and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                        table.insert(bonusIDs, mappedBonusID)
                        if not embellishSlots[gearSlot] then
                            embellishmentsAdded = embellishmentsAdded + 1
                            embellishSlots[gearSlot] = true
                        end
                        embellishmentAddedToItem = true
                        addedEmbellishment = true
                    end

                    -- If not added to the primary slot, try fallbacks
                    if not addedEmbellishment then
                        local fallbackSlots = { "neck", "ring1", "ring2", "chest", "shoulders", "legs", "feet", "hands" }
                        for _, fallbackSlot in ipairs(fallbackSlots) do
                            if gearSlot == fallbackSlot and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                                table.insert(bonusIDs, mappedBonusID)
                                if not embellishSlots[gearSlot] then
                                    embellishmentsAdded = embellishmentsAdded + 1
                                    embellishSlots[gearSlot] = true
                                end
                                embellishmentAddedToItem = true
                                addedEmbellishment = true
                                break
                            end
                        end
                    end
                end
            end
        end

        if embellishmentData.embellishment2 and not embellishmentAddedToItem then
            if embellishmentData.embellishment2 == wepOnlyEmbellishment then
                -- Always on mainHand
                if gearSlot == "mainHand" then
                    local mappedBonusID = bonusIds[embellishmentData.embellishment2]
                    if mappedBonusID and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                        table.insert(bonusIDs, mappedBonusID)
                        if not embellishSlots[gearSlot] then
                            embellishmentsAdded = embellishmentsAdded + 1
                            embellishSlots[gearSlot] = true
                        end
                        embellishmentAddedToItem = true
                    end
                end
            elseif embellishmentData.embellishment2 == secondEmbellishment then
                local mappedBonusID = bonusIds[embellishmentData.embellishment2]
                local addedEmbellishment = false

                if mappedBonusID then
                    -- Check the primary slot first (waist)
                    if gearSlot == "waist" and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                        table.insert(bonusIDs, mappedBonusID)
                        if not embellishSlots[gearSlot] then
                            embellishmentsAdded = embellishmentsAdded + 1
                            embellishSlots[gearSlot] = true
                        end
                        embellishmentAddedToItem = true
                        addedEmbellishment = true
                    end

                    -- If not added to the primary slot, try fallbacks
                    if not addedEmbellishment then
                        local fallbackSlots = { "chest", "shoulders", "legs", "feet", "hands" }
                        for _, fallbackSlot in ipairs(fallbackSlots) do
                            if gearSlot == fallbackSlot and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                                table.insert(bonusIDs, mappedBonusID)
                                if not embellishSlots[gearSlot] then
                                    embellishmentsAdded = embellishmentsAdded + 1
                                    embellishSlots[gearSlot] = true
                                end
                                embellishmentAddedToItem = true
                                addedEmbellishment = true
                                break
                            end
                        end
                    end
                end
            else
                -- Default to ring2
                local mappedBonusID = bonusIds[embellishmentData.embellishment2]
                local addedEmbellishment = false

                if mappedBonusID then
                    -- Check the primary slot first (ring1)
                    if gearSlot == "ring2" and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                        table.insert(bonusIDs, mappedBonusID)
                        if not embellishSlots[gearSlot] then
                            embellishmentsAdded = embellishmentsAdded + 1
                            embellishSlots[gearSlot] = true
                        end
                        embellishmentAddedToItem = true
                        addedEmbellishment = true
                    end

                    -- If not added to the primary slot, try fallbacks
                    if not addedEmbellishment then
                        local fallbackSlots = { "neck", "ring1", "ring2", "chest", "shoulders", "legs", "feet", "hands" }
                        for _, fallbackSlot in ipairs(fallbackSlots) do
                            if gearSlot == fallbackSlot and BisGear[class][specIndex].gearBonusIDs and BisGear[class][specIndex].gearBonusIDs[gearSlot] then
                                table.insert(bonusIDs, mappedBonusID)
                                if not embellishSlots[gearSlot] then
                                    embellishmentsAdded = embellishmentsAdded + 1
                                    embellishSlots[gearSlot] = true
                                end
                                embellishmentAddedToItem = true
                                addedEmbellishment = true
                                break
                            end
                        end
                    end
                end
            end
        end
    end

    -- Construct the fields
    local fields = {
        "item", -- Type
        itemID or "", -- Item ID
        enchantID or "", -- Enchant ID
        gemIDs[1] or "", gemIDs[2] or "", gemIDs[3] or "", gemIDs[4] or "", -- Gem IDs
        "", -- Suffix ID
        "", -- Unique ID
        linkLevel or "", -- Link level
        specializationID or "", -- Specialization ID
        "", -- Modifiers Mask
        itemContext or "", -- Item context
        tostring(#bonusIDs), -- Number of bonus IDs
        table.concat(bonusIDs, ":") -- Bonus IDs
    }

    -- Add modifiers
    -- local numModifiers = 0
    -- if numModifiers > 0 then
    --     table.insert(fields, tostring(numModifiers))
    --     table.insert(fields, "8")
    --     table.insert(fields, "749")
    --     table.insert(fields, "24")
    --     table.insert(fields, "1")
    -- end

    -- Construct the item link
    -- local itemLink = table.concat(fields, ":")
    -- local formattedLink = string.format("|cffa335ee|H%s|h[%s]|h|r", itemLink, itemName)

    --     -- Construct the item link
    -- local itemLink = table.concat(fields, ":")
    -- local formattedLink = string.format("|cffa335ee|H%s|h[%s]|h|r", itemLink, itemName)

    -- -- Remove Blizzard's default color
    -- formattedLink = formattedLink:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")

    -- -- Apply our own color while keeping the full item link structure
    -- local qualityColor = (itemQuality == 2) and "|cff1eff00" or "|cffa335ee"
    -- formattedLink = string.format("%s|H%s|h[%s]|h|r", qualityColor, itemLink, itemName)

    --print(formattedLink)

    local itemLink = table.concat(fields, ":")
    local formattedLink = string.format("|cffa335ee|H%s|h[%s]|h|r", itemLink, itemName)

    local oldItemQuality = itemQuality


    return formattedLink, oldItemQuality
end

function SC:BisGearPanel()
    if not SkillCappedDB.WeakAura then return end
    local equipmentTab = PaperDollSidebarTab3
    local a,b,c,d,e = equipmentTab:GetPoint()
    equipmentTab:SetPoint(a,b,c,d-20,e)

    local frame = CreateFrame("Button", "SCBisList", equipmentTab:GetParent())
    frame:SetSize(equipmentTab:GetSize())
    frame:SetPoint("TOPLEFT", equipmentTab, "TOPRIGHT", 4, 0)

    frame:SetFrameStrata(equipmentTab:GetFrameStrata())
    frame:SetFrameLevel(equipmentTab:GetFrameLevel())
    frame.selected = false

    -- Function to copy position and size
    local function CopyPositionAndSize(source, target)
        target:SetSize(source:GetSize())
        local point, _, relativePoint, xOfs, yOfs = source:GetPoint()
        if point then
            target:SetPoint(point, frame, relativePoint, xOfs, yOfs)
        end
    end

    local tabBg = frame:CreateTexture(nil, "BACKGROUND")
    tabBg:SetTexture(equipmentTab.TabBg:GetTexture())
    CopyPositionAndSize(equipmentTab.TabBg, tabBg)
    --tabBg:SetTexCoord(0.015625, 0.796875, 0.7890625, 0.95703125) -- Selected coords
    tabBg:SetTexCoord(0.015625, 0.796875, 0.61328125, 0.78125) --unselected

    local hider = frame:CreateTexture(nil, "ARTWORK")
    hider:SetTexture(equipmentTab.Hider:GetTexture())
    CopyPositionAndSize(equipmentTab.Hider, hider)
    hider:SetTexCoord(0.015625, 0.546875, 0.11328125, 0.1875)

    local icon = frame:CreateTexture(nil, "ARTWORK", nil, 1)
    icon:SetTexture("Interface/AddOns/SkillCapped/media/icon64.tga")
    CopyPositionAndSize(equipmentTab.Icon, icon)
    icon:SetSize(23, 23)
    local a,b,c,d,e = icon:GetPoint()
    icon:SetPoint(a,b,c,d,e+6)

    local noDataOverlay = frame:CreateTexture(nil, "OVERLAY")
    noDataOverlay:SetAtlas("communities-icon-redx")
    noDataOverlay:SetSize(14,14)
    noDataOverlay:SetPoint("CENTER", icon, "CENTER", 0,0)
    noDataOverlay:SetScript("OnEnter", function()
        GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(scIcon..coloredAddonName.." BIS List:\nNo data available for this spec.", 1, 1, 1)
        GameTooltip:Show()
    end)

    noDataOverlay:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    frame.noData = noDataOverlay

    local comingSoonOverlay = frame:CreateTexture(nil, "OVERLAY")
    comingSoonOverlay:SetAtlas("characterupdate_clock-icon")
    comingSoonOverlay:SetSize(16,16)
    comingSoonOverlay:SetPoint("CENTER", icon, "CENTER", 0,0)
    comingSoonOverlay:SetScript("OnEnter", function()
        GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(scIcon..coloredAddonName.." BIS List:\nBIS List is coming soon.", 1, 1, 1)
        GameTooltip:Show()
    end)

    comingSoonOverlay:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    frame.comingSoon = comingSoonOverlay


    -- Copy Highlight texture
    local highlight = frame:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetTexture(equipmentTab.Highlight:GetTexture())
    CopyPositionAndSize(equipmentTab.Highlight, highlight)
    highlight:SetBlendMode("ADD")
    highlight:SetTexCoord(0.015625, 0.5, 0.1953125, 0.31640625)

    frame:SetScript("OnEnter", function()
        if not frame.selected then
            highlight:Show()
        end
        GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(scIcon..coloredAddonName.." BIS List", 1, 1, 1)
        GameTooltip:Show()
    end)

    frame:SetScript("OnLeave", function()
        if not frame.selected then
            highlight:Hide()
        end
        GameTooltip:Hide()
    end)
    highlight:Hide()
    frame:EnableMouse(true)

    -- Track movement status
    local hasMoved = false
    local keepOpen = true
    local initialPoint, initialRelativeTo, initialRelativePoint, initialX, initialY

    -- Function to update TabBg texture based on bisList visibility
    local function UpdateTabBg()
        if frame.bisList and frame.bisList:IsShown() then
            tabBg:SetTexCoord(0.015625, 0.796875, 0.7890625, 0.95703125) -- Selected coords
            frame.selected = true
        else
            tabBg:SetTexCoord(0.015625, 0.796875, 0.61328125, 0.78125) -- Unselected coords
            frame.selected = false
        end
        highlight:Hide()
    end

    -- Function to sync NineSlice color and desaturation
    local function SyncNineSliceColors(targetFrame, sourceFrame)
        if targetFrame.NineSlice and sourceFrame.NineSlice then
            for _, regionName in pairs({
                "TopEdge", "BottomEdge", "LeftEdge", "RightEdge",
                "TopLeftCorner", "TopRightCorner", "BottomLeftCorner", "BottomRightCorner",
            }) do
                local targetRegion = targetFrame.NineSlice[regionName]
                local sourceRegion = sourceFrame.NineSlice[regionName]

                if targetRegion and sourceRegion then
                    local r, g, b, a = sourceRegion:GetVertexColor()
                    local desaturation = sourceRegion:GetDesaturation()

                    targetRegion:SetVertexColor(r, g, b, a)
                    targetRegion:SetDesaturation(desaturation or 0)
                end
            end
        end
    end

    -- Function to create or toggle bisList
    local function CreateBisList()
        if bisgearComingSoon then
            return
        end
        keepOpen = SkillCappedDB.bisListShown
        if frame.bisList then
            frame.bisList:SetShown(not frame.bisList:IsShown())
            if frame.bisList:IsShown() then
                keepOpen = true
                SkillCappedDB.bisListShown = true
            else
                keepOpen = false
                SkillCappedDB.bisListShown = false
            end
            if frame.bisList.needsUpdate then
                frame.bisList:SetHeight(PaperDollFrame:GetHeight())
                frame.bisList.needsUpdate = nil
            end
            UpdateTabBg()
        else
            local characterFrame = PaperDollFrame
            local customPanel = CreateFrame("Frame", "SCBisListPanel", UIParent, "DefaultPanelFlatTemplate")
            customPanel:SetFrameStrata("HIGH")
            customPanel:SetSize(500, characterFrame:GetHeight())
            customPanel:SetPoint("TOPLEFT", characterFrame, "TOPRIGHT", 0, 0)
            if customPanel:GetHeight() == 0 then
                customPanel:SetHeight(424)
                customPanel.needsUpdate = true
            end

            local bg = customPanel:CreateTexture(nil, "BACKGROUND")
            bg:SetTexture(374155)
            bg:SetPoint("TOPLEFT", customPanel, "TOPLEFT", 6, -3)
            bg:SetPoint("BOTTOMRIGHT", customPanel, "BOTTOMRIGHT", -3, 3)

            if CharacterFrame.Bg then
                local desaturated = CharacterFrame.Bg:GetDesaturation()
                if desaturated == 1 then
                    bg:SetDesaturated(true)
                end
                bg:SetTexCoord(CharacterFrameBg:GetTexCoord())
                bg:SetVertexColor(CharacterFrameBg:GetVertexColor())

                local bg2 = customPanel:CreateTexture(nil, "BACKGROUND")
                bg2:SetAtlas(CharacterFrame.TopTileStreaks:GetAtlas())
                bg2:SetPoint("TOPLEFT", customPanel, "TOPLEFT", 6, -3)
                bg2:SetPoint("TOPRIGHT", customPanel, "TOPRIGHT", -3, -46)
                bg2:SetDrawLayer("BACKGROUND", 1)

                -- Flipped bottom-up texture
                local bg2Flipped = customPanel:CreateTexture(nil, "BACKGROUND")
                bg2Flipped:SetAtlas(CharacterFrame.TopTileStreaks:GetAtlas())
                bg2Flipped:SetPoint("BOTTOMLEFT", customPanel, "BOTTOMLEFT", 6, 3)
                bg2Flipped:SetPoint("BOTTOMRIGHT", customPanel, "BOTTOMRIGHT", -3, 46)
                bg2Flipped:SetDrawLayer("BACKGROUND", 1)

                -- Flip the texture vertically
                bg2Flipped:SetTexCoord(1, 0, 1, 0)
                bg2Flipped:SetAlpha(0.4)
            end

            -- Make the frame movable
            customPanel:SetMovable(true)
            customPanel:EnableMouse(true)
            customPanel:RegisterForDrag("LeftButton")
            customPanel:SetScript("OnDragStart", customPanel.StartMoving)
            customPanel:SetScript("OnDragStop", function()
                customPanel:StopMovingOrSizing()
                -- Check if the frame has been moved
                local point, relativeTo, relativePoint, xOfs, yOfs = customPanel:GetPoint()
                if point ~= initialPoint or xOfs ~= initialX or yOfs ~= initialY then
                    hasMoved = true
                end
            end)

            -- Close the panel when CharacterFrame closes, if not moved
            hooksecurefunc(CharacterFrame, "Hide", function()
                if not hasMoved and customPanel:IsShown() then
                    customPanel:Hide()
                end
            end)

            hooksecurefunc(CharacterFrame, "Show", function()
                if keepOpen and PaperDollFrame:IsShown() then
                    customPanel:Show()
                end
                local hasData = BisGear[class] and BisGear[class][specIndex]
                _, class = UnitClass("player")
                specIndex = GetSpecialization()
                if bisgearComingSoon then
                    SCBisList:EnableMouse(false)
                    SCBisList.comingSoon:Show()
                    SCBisList.noData:Hide()
                    customPanel:Hide()
                elseif hasData then
                    SCBisList:EnableMouse(true)
                    SCBisList.comingSoon:Hide()
                    SCBisList.noData:Hide()
                else
                    customPanel:Hide()
                    SCBisList:EnableMouse(false)
                    SCBisList.comingSoon:Hide()
                    SCBisList.noData:Show()
                end
            end)

            hooksecurefunc(PaperDollFrame, "Show", function()
                if keepOpen then
                    customPanel:Show()
                end
            end)

            hooksecurefunc(PaperDollFrame, "Hide", function()
                if not hasMoved and customPanel:IsShown() then
                    customPanel:Hide()
                end
            end)

            -- Reset position on Show
            customPanel:SetScript("OnShow", function()
                customPanel:ClearAllPoints()
                customPanel:SetPoint("TOPLEFT", characterFrame, "TOPRIGHT", 0, 0)
                hasMoved = false
                UpdateTabBg()
                SC:UpdateGearDisplay(frame.bisList.gearFrame)
            end)

            customPanel:SetScript("OnHide", UpdateTabBg)

            -- Set title
            customPanel.TitleContainer.TitleText:SetText("|TInterface/AddOns/SkillCapped/media/icon.blp:14:14:0:0|t" .. coloredAddonName .. " BIS List")
            customPanel.TitleContainer.TitleText:SetTextColor(1, 1, 1)

            -- Close button
            local closeButton = CreateFrame("Button", nil, customPanel, "UIPanelCloseButton")
            closeButton:SetPoint("TOPRIGHT", customPanel, "TOPRIGHT")
            closeButton:SetScript("OnClick", function()
                customPanel:Hide()
                UpdateTabBg()
                keepOpen = false
                SkillCappedDB.bisListShown = false
            end)

            SyncNineSliceColors(customPanel, CharacterFrame)

            frame.bisList = customPanel
            UpdateTabBg()

            local textGap = 3
            local textFrame = CreateFrame("Frame", nil, customPanel)
            customPanel.textFrame = textFrame

            local statPriorityText = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            statPriorityText:SetPoint("TOPLEFT", customPanel, "TOPLEFT", 12, -28)

            local bestEmbellishmentsText = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            bestEmbellishmentsText:SetPoint("TOPLEFT", statPriorityText, "BOTTOMLEFT", 0, -textGap)

            local bestEmbellishmentsText2 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            bestEmbellishmentsText2:SetPoint("LEFT", bestEmbellishmentsText, "RIGHT", 0, 0)

            local bestGemText = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            bestGemText:SetPoint("TOPLEFT", bestEmbellishmentsText, "BOTTOMLEFT", 0, -textGap)

            local bestBloodstoneText = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            bestBloodstoneText:SetPoint("TOPLEFT", bestGemText, "BOTTOMLEFT", 0, -textGap)

            local bestFiberText
            if fiberGemExists then
                bestFiberText = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                bestFiberText:SetPoint("TOPLEFT", bestBloodstoneText, "BOTTOMLEFT", 0, -textGap)
            end

            -- 11.2
            -- local version = GetBuildInfo()
            -- if version and version == "11.2.0" then
                -- local newSeasonIcon = customPanel:CreateTexture(nil, "OVERLAY")
                -- newSeasonIcon:SetAtlas("Ping_Marker_Icon_Warning")
                -- newSeasonIcon:SetSize(38,38)
                -- newSeasonIcon:SetPoint("TOPRIGHT", customPanel, "TOPRIGHT", -15, -40)

                -- newSeasonIcon:SetScript("OnEnter", function(self)
                --     GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                --     GameTooltip:AddLine("|A:Ping_Chat_Warning:16:16|a A new season has started!", 1, 1, 1, true)
                --     GameTooltip:AddLine("The BiS list will not be fully completed until later in the season.", nil, nil, nil, true)
                --     GameTooltip:Show()
                -- end)
                -- newSeasonIcon:SetScript("OnLeave", function()
                --     GameTooltip:Hide()
                -- end)

                -- local newSeason = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                -- newSeason:SetPoint("BOTTOM", customPanel, "BOTTOM", 12, 5)
                -- newSeason:SetText("New season: The BiS list will not be fully completed until later in the season.")
                -- local font = newSeason:GetFont()
                -- newSeason:SetFont(font, 9)
                -- newSeason:SetTextColor(1,1,1)

                -- local newSeasonIcon = customPanel:CreateTexture(nil, "OVERLAY")
                -- newSeasonIcon:SetAtlas("Ping_Chat_Warning")
                -- newSeasonIcon:SetSize(16,16)
                -- newSeasonIcon:SetPoint("RIGHT", newSeason, "LEFT", -1, 2)
            -- end

            local function GetItemNameWithRetries(itemID, retries, delay, callback)
                retries = retries or 10
                delay = delay or 0.1

                local function TryFetchItemName()
                    local itemName = C_Item.GetItemNameByID(itemID)
                    if itemName or retries <= 0 then
                        callback(itemName or "N/A")
                    else
                        retries = retries - 1
                        C_Timer.After(delay, TryFetchItemName)
                    end
                end

                TryFetchItemName()
            end

            local function GetSpellNameWithRetries(spellID, retries, delay, callback)
                retries = retries or 10
                delay = delay or 0.1

                local function TryFetchSpellName()
                    if spellID == wepOnlyEmbellishment then
                        local itemID = 226024
                        GetItemNameWithRetries(itemID, retries, delay, callback)
                        return
                    end

                    -- Default behavior for other spellIDs
                    local spellInfo = C_Spell.GetSpellInfo(spellID)
                    local spellName = spellInfo and spellInfo.name

                    if spellName or retries <= 0 then
                        callback(spellName or "N/A")
                    else
                        retries = retries - 1
                        C_Timer.After(delay, TryFetchSpellName)
                    end
                end

                TryFetchSpellName()
            end

            local function UpdateTextFields()
                _, class = UnitClass("player")
                specIndex = GetSpecialization()

                if BisGear[class] and BisGear[class][specIndex] then
                    local specData = BisGear[class][specIndex]

                    -- Update Stat Priority
                    if specData.statPriority then
                        local label = "|cffffff00Stat Priority:|r "
                        local stats = "|cffffffff" .. table.concat(specData.statPriority, ", ") .. "|r"
                        statPriorityText:SetText(label .. stats)
                    else
                        statPriorityText:SetText("|cffffff00Stat Priority:|r |cffffffffN/A|r")
                    end

                    -- Update Best Embellishments
                    if specData.embellishment then
                        local label = "|cffffff00Best Embellishments:|r "
                        local embellishment1 = specData.embellishment.embellishment1
                        local embellishment2 = specData.embellishment.embellishment2

                        if embellishment1 and embellishment2 then
                            GetItemNameWithRetries(embellishment1, 10, 0.1, function(name1)
                                GetItemNameWithRetries(embellishment2, 10, 0.1, function(name2)
                                    if embellishment1 == embellishment2 then
                                        -- If both embellishments are the same
                                        bestEmbellishmentsText:SetText(label .. "|cffffffff" .. name1 .. " x 2|r")
                                        bestEmbellishmentsText2:SetText("")
                                        ItemTooltip(bestEmbellishmentsText, embellishment1, "ANCHOR_RIGHT")
                                    else
                                        -- If embellishments are different
                                        bestEmbellishmentsText:SetText(label .. "|cffffffff" .. name1 .. ", |r")
                                        bestEmbellishmentsText2:SetText("|cffffffff" .. name2 .. "|r")

                                        ItemTooltip(bestEmbellishmentsText, embellishment1, "ANCHOR_RIGHT")
                                        ItemTooltip(bestEmbellishmentsText2, embellishment2, "ANCHOR_RIGHT")
                                    end
                                end)
                            end)
                        elseif embellishment1 then
                            GetItemNameWithRetries(embellishment1, 10, 0.1, function(name1)
                                bestEmbellishmentsText:SetText(label .. "|cffffffff" .. name1 .. "|r")
                                bestEmbellishmentsText2:SetText("")
                                ItemTooltip(bestEmbellishmentsText, embellishment1, "ANCHOR_RIGHT")
                            end)
                        elseif embellishment2 then
                            GetItemNameWithRetries(embellishment2, 10, 0.1, function(name2)
                                bestEmbellishmentsText:SetText(label .. "|cffffffff" .. name2 .. "|r")
                                bestEmbellishmentsText2:SetText("")
                                ItemTooltip(bestEmbellishmentsText, embellishment2, "ANCHOR_RIGHT")
                            end)
                        else
                            bestEmbellishmentsText:SetText("|cffffff00Best Embellishments:|r |cffffffffN/A|r")
                            bestEmbellishmentsText2:SetText("")
                        end
                    else
                        bestEmbellishmentsText:SetText("|cffffff00Best Embellishments:|r |cffffffffN/A|r")
                        bestEmbellishmentsText2:SetText("")
                    end

                    -- Update Best Gem
                    if specData.gems and specData.gems.gem then
                        local label = "|cffffff00Best Gem:|r "
                        local gemID = specData.gems.gem
                        GetItemNameWithRetries(gemID, 10, 0.1, function(name)
                            bestGemText:SetText(label .. "|cffffffff" .. name .. "|r")
                            ItemTooltip(bestGemText, gemID, "ANCHOR_RIGHT")
                        end)
                    else
                        bestGemText:SetText("|cffffff00Best Gem:|r |cffffffffN/A|r")
                    end

                    -- Update Best Bloodstone
                    if specData.gems and specData.gems.bloodstone then
                        local label = "|cffffff00Best Bloodstone:|r "
                        local bloodstoneID = specData.gems.bloodstone
                        GetItemNameWithRetries(bloodstoneID, 10, 0.1, function(name)
                            bestBloodstoneText:SetText(label .. "|cffffffff" .. name .. "|r")
                            ItemTooltip(bestBloodstoneText, bloodstoneID, "ANCHOR_RIGHT")
                        end)
                    else
                        bestBloodstoneText:SetText("|cffffff00Best Bloodstone:|r |cffffffffN/A|r")
                    end

                    -- Update Best Fiber
                    if fiberGemExists and bestFiberText then
                        if specData.gems and specData.gems.fiber then
                            local label = "|cffffff00Best Fiber:|r "
                            local fiberID = specData.gems.fiber
                            GetItemNameWithRetries(fiberID, 10, 0.1, function(name)
                                bestFiberText:SetText(label .. "|cffffffff" .. name .. "|r")
                                ItemTooltip(bestFiberText, fiberID, "ANCHOR_RIGHT")
                            end)
                        else
                            bestFiberText:SetText("|cffffff00Best Fiber:|r |cffffffffN/A|r")
                        end
                    end
                else
                    -- Default values if no data is found
                    statPriorityText:SetText("|cffffff00Stat Priority:|r |cffffffffN/A|r")
                    bestEmbellishmentsText:SetText("|cffffff00Best Embellishments:|r |cffffffffN/A|r")
                    bestGemText:SetText("|cffffff00Best Gem:|r |cffffffffN/A|r")
                    if fiberGemExists and bestFiberText then
                        bestFiberText:SetText("|cffffff00Best Fiber:|r |cffffffffN/A|r")
                    end
                end
            end

            local gearFrame = CreateFrame("Frame", nil, customPanel, "BackdropTemplate")
            gearFrame:SetSize(customPanel:GetWidth()-15, 325)
            gearFrame:SetPoint("TOPLEFT", bestBloodstoneText, "BOTTOMLEFT", 0, fiberGemExists and -7 or -2)
            customPanel.gearFrame = gearFrame
            gearFrame:Show()

            local displayGrayTwoHand = true

            -- Function to safely set item text with retries
            local function SetGearItemTextWithRetries(itemID, rowFrame, isRightColumn, retries, delay, flavorText, enchantID, gemIDs, isTwoHanded, slotName, oldItemQuality)
                retries = retries or 10
                delay = delay or 0.1

                local function TryFetchItemName()
                    local itemName, itemLink = C_Item.GetItemInfo(itemID)
                    local enchantOnItem = BisGear[class][specIndex]["enchants"][slotName]
                    local enchantItemID = enchantsToItemID[enchantOnItem]
                    local enchantNameX
                    local isSpell
                    if enchantItemID then
                        if spellEnchants[enchantOnItem] then
                            enchantNameX = C_Spell.GetSpellName(enchantItemID)
                            isSpell = true
                        else
                            enchantNameX = C_Item.GetItemInfo(enchantItemID)
                        end

                        if enchantNameX then
                            local function TrimEnchantName(enchantName)
                                -- Remove everything before and including " - "
                                return (enchantName:gsub("^.- %- ", "")) or enchantName
                            end
                            enchantNameX = TrimEnchantName(enchantNameX)
                        end
                    end

                    if itemName and (not enchantOnItem or (enchantOnItem and enchantNameX)) or retries <= 0 then
                        local text = itemLink or itemName or "N/A"
                        if not rowFrame.itemText then
                            local itemText = rowFrame:CreateFontString(nil, "OVERLAY", "SystemFont_Tiny")
                            local font, size, flags = itemText:GetFont()
                            itemText:SetFont(font, 10, flags)
                            rowFrame.itemText = itemText

                            if isRightColumn then
                                itemText:SetPoint("RIGHT", rowFrame.icon, "LEFT", -3, 8)
                            else
                                itemText:SetPoint("LEFT", rowFrame.icon, "RIGHT", 3, 8)
                            end
                            if isRightColumn then
                                -- Text to the left of the icon for the right column
                                itemText:SetPoint("RIGHT", rowFrame.icon, "LEFT", -3, 8)
                            else
                                -- Text to the right of the icon for the left column
                                itemText:SetPoint("LEFT", rowFrame.icon, "RIGHT", 3, 8)
                            end
                        end

                        -- Remove inline color codes if displayGrayTwoHand and isTwoHanded
                        if displayGrayTwoHand and isTwoHanded then
                            text = "|cff808080" .. "Off Hand" .. "|r" -- Wrap in gray color
                        else
                            local qualityColor = (oldItemQuality == 6) and "|cffe6cc80" or ((oldItemQuality == 2) and "|cff1eff00") or "|cffa335ee"
                            text = qualityColor..itemName
                        end

                        -- Set the text
                        rowFrame.itemText:SetText(text)

                        -- Position the flavor text beneath the item text
                        if flavorText then
                            local function GetGemIDsFromHyperlink(itemLink)
                                if not itemLink then return nil end

                                -- Match the parts of the item link
                                local _, _, gem1, gem2, gem3, gem4 = string.match(itemLink, "item:(%d*):(%d*):(%d*):(%d*):(%d*):(%d*):(%d*):")

                                -- Store gem IDs in a table
                                local gems = {}
                                if gem1 and gem1 ~= "0" then table.insert(gems, tonumber(gem1)) end
                                if gem2 and gem2 ~= "0" then table.insert(gems, tonumber(gem2)) end
                                if gem3 and gem3 ~= "0" then table.insert(gems, tonumber(gem3)) end
                                if gem4 and gem4 ~= "0" then table.insert(gems, tonumber(gem4)) end

                                return gems
                            end

                            if isRightColumn then
                                flavorText:SetPoint("TOPRIGHT", rowFrame.itemText, "BOTTOMRIGHT", -1, -4)
                            else
                                flavorText:SetPoint("TOPLEFT", rowFrame.itemText, "BOTTOMLEFT", 1, -4)
                            end

                            local gemNames = ""

                            local gemIDs = GetGemIDsFromHyperlink(itemLink)

                            if gemIDs then
                                for _, gemID in ipairs(gemIDs) do
                                    local gemName = C_Item.GetItemNameByID(gemID) or ""
                                    gemNames = gemNames .. (gemName ~= "" and gemName .. " " or "")
                                end
                            end

                            flavorText:SetText(enchantNameX)
                            if enchantNameX then
                                flavorText:SetScript("OnEnter", function()
                                    GameTooltip:SetOwner(flavorText, "ANCHOR_RIGHT")
                                    if isSpell then
                                        GameTooltip:SetSpellByID(enchantItemID)
                                    else
                                        GameTooltip:SetItemByID(enchantItemID)
                                    end
                                    GameTooltip:Show()
                                end)
                                flavorText:SetScript("OnLeave", function()
                                    GameTooltip:Hide()
                                end)
                            end
                            flavorText:SetTextColor(0,1,0)

                            if gemIDs and #gemIDs > 0 then
                                rowFrame.gemFrames = rowFrame.gemFrames or {}
                                local lastGemFrame = flavorText

                                for i, gemID in ipairs(gemIDs) do
                                    if gemID and gemID ~= 0 then
                                        local gemIcon = C_Item.GetItemIconByID(gemID)

                                        if gemIcon then
                                            local gemFrame = rowFrame.gemFrames[i]
                                            if not gemFrame then
                                                gemFrame = CreateFrame("Frame", nil, rowFrame)
                                                gemFrame:SetSize(15, 15)
                                                rowFrame.gemFrames[i] = gemFrame
                                            end

                                            if flavorText:GetText() ~= nil then
                                                gemFrame:SetPoint(
                                                    isRightColumn and "RIGHT" or "LEFT",
                                                    lastGemFrame,
                                                    isRightColumn and "LEFT" or "RIGHT",
                                                    isRightColumn and -2 or 3,
                                                    0
                                                )
                                            else
                                                gemFrame:SetPoint(
                                                    isRightColumn and "RIGHT" or "LEFT",
                                                    lastGemFrame,
                                                    isRightColumn and "LEFT" or "RIGHT",
                                                    isRightColumn and -1 or 3,
                                                    lastGemFrame == flavorText and -7 or 0
                                                )
                                            end

                                            -- Update or create the gem texture
                                            local gemTexture = gemFrame.texture or gemFrame:CreateTexture(nil, "ARTWORK")
                                            gemFrame.texture = gemTexture
                                            gemTexture:SetAllPoints(gemFrame)
                                            gemTexture:SetTexture(gemIcon)

                                            -- Update tooltip behavior
                                            gemFrame:SetScript("OnEnter", function()
                                                GameTooltip:SetOwner(gemFrame, "ANCHOR_RIGHT")
                                                GameTooltip:SetItemByID(gemID)
                                                GameTooltip:Show()
                                            end)
                                            gemFrame:SetScript("OnLeave", function()
                                                GameTooltip:Hide()
                                            end)
                                            gemFrame:Show()

                                            lastGemFrame = gemFrame
                                        end
                                    end
                                end

                                for i = #gemIDs + 1, #rowFrame.gemFrames do
                                    if rowFrame.gemFrames[i] then
                                        rowFrame.gemFrames[i]:Hide()
                                    end
                                end
                            end
                        end
                    else
                        retries = retries - 1
                        C_Timer.After(delay, TryFetchItemName)
                    end
                end

                TryFetchItemName()
            end

            -- Function to create a gear row
            local function CreateGearRow(parent, slotName, itemID, enchantID, gemIDs, posX, posY, isRightColumn, isTwoHanded, oldItemQuality)
                -- Ensure rowFrame and flavorText are initialized
                local rowFrame = parent[slotName.."Frame"] or CreateFrame("Frame", nil, parent)
                local flavorText = rowFrame.enchantText or rowFrame:CreateFontString(nil, "OVERLAY", "SystemFont_Tiny")

                -- Save references for reuse
                parent[slotName.."Frame"] = rowFrame
                rowFrame.enchantText = flavorText

                rowFrame:SetSize(parent:GetWidth() / 2 - 15, 40)
                if isRightColumn then
                    rowFrame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", posX, posY)
                else
                    rowFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", posX, posY)
                end

                -- Icon
                if not rowFrame.icon then
                    local icon = rowFrame:CreateTexture(nil, "ARTWORK")
                    icon:SetSize(32, 32)
                    rowFrame.icon = icon

                    if isRightColumn then
                        icon:SetPoint("RIGHT", rowFrame, "RIGHT", 0, 0)
                    else
                        icon:SetPoint("LEFT", rowFrame, "LEFT", 0, 0)
                    end
                end

                -- Update the icon texture
                rowFrame.icon:SetTexture(C_Item.GetItemIconByID(itemID))

                if displayGrayTwoHand and isTwoHanded then
                    rowFrame.icon:SetDesaturated(true)
                    rowFrame.icon:SetTexture(136524)
                end

                -- Set the item name and details with retries
                SetGearItemTextWithRetries(itemID, rowFrame, isRightColumn, 10, 0.1, flavorText, enchantID, gemIDs, isTwoHanded, slotName, oldItemQuality)

                -- Tooltip
                rowFrame:SetScript("OnEnter", function()
                    if isTwoHanded then
                        GameTooltip:SetOwner(rowFrame, "ANCHOR_CURSOR_RIGHT")
                        GameTooltip:AddLine("No Off Hand.\nTwo-Hand Weapon in use.", 1, 1, 1)
                    else
                        GameTooltip:SetOwner(rowFrame, "ANCHOR_RIGHT")
                        GameTooltip:SetHyperlink(itemID)
                    end
                    GameTooltip:Show()
                    if not isTwoHanded and oldItemQuality == 2 then
                        local numLines = GameTooltip:NumLines()
                        for i = 1, numLines do
                            local line = _G["GameTooltipTextLeft" .. i]
                            if line then
                                local text = line:GetText()
                                if text then
                                    local r, g, b = line:GetTextColor()
                                    if r > 0.6 and g < 0.3 and b > 0.8 then
                                        line:SetTextColor(0.118, 1.0, 0.0)
                                    end
                                end
                            end
                        end
                    end
                end)
                rowFrame:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                return rowFrame
            end

            -- Function to populate the gear panel
            local function PopulateGearPanel(parent, gearData, enchantData, gemData)
                local posYLeft = -10
                local posYRight = -10

                _, class = UnitClass("player")
                specIndex = GetSpecialization()

                local function CheckAndAddBonus(slotName, itemID)
                    local craftedBonusID
                    if BisGear[class] and BisGear[class][specIndex] and BisGear[class][specIndex].gearBonusIDs then
                        craftedBonusID = BisGear[class][specIndex].gearBonusIDs[slotName]
                    end

                    if craftedBonusID then
                        return craftedBonusID
                    end

                    return nil
                end

                -- Populate left column
                for _, slotName in ipairs({ "head", "neck", "shoulders", "back", "chest", "wrist", "mainHand", "offHand" }) do
                    local item = BisGear[class] and BisGear[class][specIndex] and BisGear[class][specIndex].gear and BisGear[class][specIndex].gear[slotName]
                    local bonusIDs = {11318, 10842} --replace 1514 with 1553 for new max conq ilvl 678, new honor gear is 665 ilvl max pvp, warmonger is 675
                    if slotName == "back" and BisGear[class][specIndex].gear[slotName] == legendaryCloakID then
                        bonusIDs = {12399, 9877, 12258}
                    end
                    local craftedBonusID = CheckAndAddBonus(slotName, item)
                    local isCrafted
                    if craftedBonusID then
                        table.insert(bonusIDs, craftedBonusID)
                        isCrafted = true
                    end
                    local bloodstone = slotName == "neck" and true or false
                    local itemID, oldItemQuality = CreateItemLink(slotName, bonusIDs, bloodstone, isCrafted)
                    local isTwoHanded = false

                    if slotName == "offHand" and not itemID then
                        itemID, oldItemQuality = CreateItemLink("mainHand", bonusIDs, bloodstone, isCrafted)
                        isTwoHanded = true
                    end

                    if itemID then
                        local enchantID = enchantData[slotName]
                        local gemIDs = gemData and gemData[slotName] or nil
                        CreateGearRow(parent, slotName, itemID, enchantID, gemIDs, 10, posYLeft, false, isTwoHanded, oldItemQuality)
                        posYLeft = posYLeft - 39
                    end
                end

                -- Populate right column
                for _, slotName in ipairs({ "hands", "waist", "legs", "feet", "ring1", "ring2", "trinket1", "trinket2" }) do
                    local item = BisGear[class] and BisGear[class][specIndex] and BisGear[class][specIndex].gear and BisGear[class][specIndex].gear[slotName]
                    local bonusIDs = {11318, 10842} --replace 1514 with 1553 for new max conq ilvl 678, new honor gear is 665 ilvl max pvp, warmonger is 675
                    local craftedBonusID = CheckAndAddBonus(slotName, item)
                    local isCrafted
                    if craftedBonusID then
                        table.insert(bonusIDs, craftedBonusID)
                        isCrafted = true
                    end
                    local bloodstone = slotName == "neck" and true or false
                    local itemID, oldItemQuality = CreateItemLink(slotName, bonusIDs, bloodstone, isCrafted)

                    if itemID then
                        local enchantID = enchantData[slotName]
                        local gemIDs = gemData and gemData[slotName] or nil
                        CreateGearRow(parent, slotName, itemID, enchantID, gemIDs, -10, posYRight, true, nil, oldItemQuality)
                        posYRight = posYRight - 39
                    end
                end
            end

            -- Function to dynamically update the gear display
            function SC:UpdateGearDisplay(parent)
                _, class = UnitClass("player")
                specIndex = GetSpecialization()

                local hasData = BisGear[class] and BisGear[class][specIndex]
                if hasData then
                    SCBisList:EnableMouse(true)
                    SCBisList.noData:Hide()
                end

                if hasData and parent.spec ~= specIndex then
                    parent:Hide()
                    parent:Show()
                    parent.spec = specIndex

                    UpdateTextFields()

                    local specData = BisGear[class][specIndex]
                    PopulateGearPanel(parent, specData.gear, specData.enchants, specData.gems)
                elseif not hasData then
                    customPanel:Hide()
                    SCBisList:EnableMouse(false)
                    SCBisList.noData:Show()
                end
            end

            SC:UpdateGearDisplay(gearFrame)
            customPanel:Hide()
        end
    end
    
    -- Set initial state
    if bisgearComingSoon then
        frame:EnableMouse(false)
        frame.comingSoon:Show()
        frame.noData:Hide()
    else
        local hasData = BisGear[class] and BisGear[class][specIndex]
        if hasData then
            frame.comingSoon:Hide()
            frame.noData:Hide()
            CreateBisList()
        else
            frame:EnableMouse(false)
            frame.comingSoon:Hide()
            frame.noData:Show()
        end
    end
    
    frame:SetScript("OnClick", CreateBisList)

    frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    frame:SetScript("OnEvent", function(self, event, unit)
        if event == "PLAYER_SPECIALIZATION_CHANGED" and unit == "player" then

            specIndex = GetSpecialization()

            local hasData = BisGear[class] and BisGear[class][specIndex]
            if bisgearComingSoon then
                self:EnableMouse(false)
                self.comingSoon:Show()
                self.noData:Hide()
            elseif hasData then
                self:EnableMouse(true)
                self.comingSoon:Hide()
                self.noData:Hide()
            else
                self:EnableMouse(false)
                self.comingSoon:Hide()
                self.noData:Show()
            end

            if self.bisList and self.bisList:IsShown() and self.bisList.gearFrame then
                SC:UpdateGearDisplay(self.bisList.gearFrame)
            end
        end
    end)
end



-- local function DumpBonusIDs()
--     -- Get the item link from the tooltip
--     local _, itemLink = GameTooltip:GetItem()
--     if not itemLink then
--         --print("No item found on the tooltip.")
--         return
--     end

--     -- Parse the item link to extract bonus IDs
--     local _, itemID, _, _, _, _, _, _, _, _, _, _, _, rest = strsplit(":", itemLink, 14)
--     if not rest then
--         --print("Failed to parse item link.")
--         return
--     end

--     -- Extract the number of bonus IDs and the IDs themselves
--     local numBonusIDs, bonusIDString = strsplit(":", rest, 2)
--     if numBonusIDs and tonumber(numBonusIDs) > 0 then
--         --print("Item ID:", itemID)
--         --print("Number of Bonus IDs:", numBonusIDs)

--         -- Extract individual bonus IDs
--         local bonusIDs = {strsplit(":", bonusIDString)}
--         for i, bonusID in ipairs(bonusIDs) do
--             print("Bonus ID [" .. i .. "]:", bonusID)
--         end
--     else
--         --print("No bonus IDs found on the item.")
--     end
-- end

-- local function GetMouseoverItemLink()
--     -- Retrieve item information from the tooltip
--     local _, itemLink = GameTooltip:GetItem()

--     if itemLink then
--         -- Print the item link to the chat for testing
--         print("Mouseover Item Link: " .. itemLink)
--         SkillCappedDB.mouseItem = itemLink
--         DumpBonusIDs()
--         return itemLink
--     else
--         print("No item detected under the mouse.")
--         return nil
--     end
-- end
-- SLASH_MOUSEOVERITEMLINK1 = "/mouseoveritem"
-- SlashCmdList.MOUSEOVERITEMLINK = function()
--     GetMouseoverItemLink()
-- end



-- local function CheckItemLevelForBonusIDRange(startBonusID, endBonusID, ilvl, bloodstone)
--     for bonusID = startBonusID, endBonusID do
--         -- Generate the item link for the given bonusID
--         local bonusIDs = {11318, bonusID, 10842} -- Replace other IDs if needed
--         local gearSlot = "head"
--         local itemLink = CreateItemLink(gearSlot, bonusIDs, bloodstone)

--         if itemLink then
--             -- Use Blizzard API to get item information, including item level
--             local itemInfo = {GetItemInfo(itemLink)}
--             local itemLevel = itemInfo[4] -- Item level is the 4th return value of GetItemInfo

--             --print(itemLevel)

--             if itemLevel == ilvl then
--                 print(string.format("SUCCESS: BONUSID: %d", bonusID))
--             end
--         else
--             print(string.format("Failed to create item link for BONUSID: %d", bonusID))
--         end
--     end
-- end
-- CheckItemLevelForBonusIDRange(1, 100000, 289)

-- -- Debug: Scan enchantIDs 7700-8300 on aff warlock legs for Intellect + Stamina
-- local function ScanEnchantIDs()
--     local itemID = 250041 -- Aff warlock legs

--     -- Create a hidden scanning tooltip
--     local scanTip = CreateFrame("GameTooltip", "SCEnchantScanTooltip", nil, "GameTooltipTemplate")
--     scanTip:SetOwner(WorldFrame, "ANCHOR_NONE")

--     local startID = 7700
--     local endID = 8300
--     local current = startID
--     local batchSize = 5

--     local function ProcessBatch()
--         for i = 1, batchSize do
--             if current > endID then
--                 print("|cff7ba4fcEnchant scan complete.|r")
--                 return
--             end

--             local enchantID = current
--             current = current + 1

--             -- Build minimal item link: item:itemID:enchantID:::::::linkLevel
--             local itemString = "item:" .. itemID .. ":" .. enchantID .. "::::::::80:::::"
--             scanTip:ClearLines()
--             scanTip:SetHyperlink(itemString)

--             local foundInt, foundStam = false, false
--             local intLine, stamLine

--             for line = 1, scanTip:NumLines() do
--                 local left = _G["SCEnchantScanTooltipTextLeft" .. line]
--                 if left then
--                     local text = left:GetText()
--                     if text then
--                         if text:find("Intellect") then
--                             foundInt = true
--                             intLine = text
--                         end
--                         if text:find("Stamina") then
--                             foundStam = true
--                             stamLine = text
--                         end
--                     end
--                 end
--             end

--             if foundInt and foundStam then
--                 print(string.format("|cff00ff00EnchantID %d:|r %s / %s", enchantID, intLine or "", stamLine or ""))
--             end
--         end

--         C_Timer.After(0.01, ProcessBatch)
--     end

--     print("|cff7ba4fcScanning enchantIDs " .. startID .. "-" .. endID .. " on item " .. itemID .. "...|r")
--     ProcessBatch()
-- end

-- SLASH_SCENCHSCAN1 = "/scenchscan"
-- SlashCmdList.SCENCHSCAN = ScanEnchantIDs