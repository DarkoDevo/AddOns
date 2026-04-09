local AddonName, SkillCapped = ...
local SC = SkillCapped
local coloredAddonName = "|cFFFFFFFFSkill|r|cff7ba4fcCapped|r"
local scIcon = "|TInterface/AddOns/SkillCapped/media/icon.blp:16:16:0:0|t"

local _, class = UnitClass("player")
local specIndex = C_SpecializationInfo.GetSpecialization()

local socketSlots = {
    ["head"] = 1,
    ["neck"] = 2,
    ["ring1"] = 2,
    ["ring2"] = 2,
    ["wrist"] = 1,
    ["waist"] = 1,
}

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

local function GetGemIDsForSlot(slot, _, gemsTable, bloodstoneID)
    local maxSockets = socketSlots[slot] or 0
    local gemIDs = {}

    -- Head slot: insert bloodstone first
    if slot == "head" and bloodstoneID then
        table.insert(gemIDs, bloodstoneID)
    end

    -- Insert regular gems for this slot
    if gemsTable and type(gemsTable[slot]) == "table" then
        for _, gemID in ipairs(gemsTable[slot]) do
            -- Avoid inserting bloodstone again if already added
            if gemID ~= bloodstoneID then
                table.insert(gemIDs, gemID)
            end
        end
    end

    -- Pad to 4 gem slots for item link format
    while #gemIDs < 4 do
        table.insert(gemIDs, 0)
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

local unavailableSpecs = {
    ["DEATHKNIGHT"] = {1, 2},
    ["DRUID"] = {3},
    ["HUNTER"] = {1, 3},
    ["MAGE"] = {1, 2},
    ["PALADIN"] = {2},
    ["ROGUE"] = {1, 2},
    ["WARLOCK"] = {2, 3},
    ["WARRIOR"] = {2, 3},
}

--enchantID - itemID
local BisGear = {
    ["enchantsToItemID"] = {
        [4806] = 87559,
        [4423] = 74712,
        [4419] = 74708,
        [4414] = 74703,
        [4430] = 74719,
        [5002] = 90046,
        [4825] = 82445,
        [4429] = 74718,
        [4442] = 74724,
        [4434] = 74729,
        [4826] = 82444,
        [4803] = 83006,
        [4424] = 74713,
        [4415] = 74704,
        [4432] = 74721,
        [4823] = 83765,
        [3365] = 53323,
        [4804] = 83007,
        [4416] = 74705,
        [4822] = 83764,
        [4428] = 74717,
        [4918] = 86597,
        [4444] = 74726,
        [4433] = 74722,
    },
    ["DEATHKNIGHT"] = {
        [1] = nil,
        [2] = nil,
        [3] = { -- Unholy
            ["statPriority"] = {"Strength", "3% Hit Rating", "3% Expertise Rating", "Mastery", "Critical Strike", "Haste"},
            ["professions"] = {"Tailoring", "Engineering"},
            ["gear"] = {
                ["head"] = 99808,
                ["neck"] = 99947,
                ["shoulders"] = 99810,
                ["back"] = 99945,
                ["chest"] = 100062,
                ["wrist"] = 99890,
                ["hands"] = 94364,
                ["waist"] = 99887,
                ["legs"] = 91153,
                ["feet"] = 99888,
                ["ring1"] = 99950,
                ["ring2"] = 99949,
                ["trinket1"] = 99943,
                ["trinket2"] = 100056,
                ["mainHand"] = 99972,
            },
            ["gems"] = {
                ["head"] = {76886, 76696},
                ["shoulders"] = {76674},
                ["chest"] = {76696, 76674},
                ["hands"] = {89674},
                ["waist"] = {89674, 76696},
                ["legs"] = {76696, 89674},
                ["feet"] = {76674},
                ["gem"] = {76696, 89674, 76674},
                ["bloodstone"] = 76886,
            },
            ["enchants"] = {
                ["shoulders"] = 4803,
                ["back"] = 4424,
                ["chest"] = 4419,
                ["wrist"] = 4415,
                ["hands"] = 4432,
                ["waist"] = 5002,
                ["legs"] = 4823,
                ["feet"] = 4429,
                ["mainHand"] = 3365,
            },
        },
    },
    ["WARRIOR"] = {
        [1] = { -- Arms
            ["statPriority"] = {"Strength", "3% Hit Rating", "3% Expertise Rating", "Critical Strike", "Mastery", "Haste"},
            ["professions"] = {"Tailoring", "BS/JC/Eng"},
            ["gear"] = {
                ["head"] = 99993,
                ["neck"] = 99946,
                ["shoulders"] = 99961,
                ["back"] = 99944,
                ["chest"] = 99957,
                ["wrist"] = 99890,
                ["hands"] = 94331,
                ["waist"] = 99887,
                ["legs"] = 94448,
                ["feet"] = 99888,
                ["ring1"] = 99949,
                ["ring2"] = 99950,
                ["trinket1"] = 99948,
                ["trinket2"] = 100056,
                ["mainHand"] = 99972,
            },
            ["gems"] = {
                ["head"] = {76886, 76661},
                ["shoulders"] = {76697},
                ["chest"] = {76661, 76697},
                ["hands"] = {76649},
                ["waist"] = {76649, 76661},
                ["legs"] = {76661, 76649},
                ["feet"] = {76697},
                ["gem"] = {76661, 76649, 76697},
                ["bloodstone"] = 76886,
            },
            ["enchants"] = {
                ["shoulders"] = 4803,
                ["back"] = 4424,
                ["chest"] = 4419,
                ["wrist"] = 4415,
                ["hands"] = 4432,
                ["waist"] = 5002,
                ["legs"] = 4823,
                ["feet"] = 4429,
                ["mainHand"] = 4444,
            },
        },
        [2] = nil,
        [3] = nil,
    },
    ["PALADIN"] = {
        [1] = { -- Holy
            ["statPriority"] = {"Intellect", "Critical Strike", "Spirit", "Mastery", "Haste"},
            ["professions"] = {"Tailoring", "BS/JC"},
            ["gear"] = {
                ["head"] = 91291,
                ["neck"] = 91137,
                ["shoulders"] = 94413,
                ["back"] = 91124,
                ["chest"] = 91287,
                ["wrist"] = 94481,
                ["hands"] = 91289,
                ["waist"] = 99876,
                ["legs"] = 91293,
                ["feet"] = 94352,
                ["ring1"] = 91140,
                ["ring2"] = 94390,
                ["trinket1"] = 91401,
                ["trinket2"] = 91400,
                ["mainHand"] = 91203,
                ["offHand"] = 91205,
            },
            ["gems"] = {
                ["head"] = {76890, 76694},
                ["shoulders"] = {76660},
                ["chest"] = {76694, 76660},
                ["hands"] = {76686},
                ["waist"] = {76686, 76694},
                ["legs"] = {76694, 76686},
                ["feet"] = {76660},
                ["gem"] = {76694, 76686, 76660},
                ["bloodstone"] = 76890,
            },
            ["enchants"] = {
                ["shoulders"] = 4806,
                ["back"] = 4423,
                ["chest"] = 4419,
                ["wrist"] = 4414,
                ["hands"] = 4433,
                ["waist"] = 5002,
                ["legs"] = 4826,
                ["feet"] = 4429,
                ["mainHand"] = 4442,
                ["offHand"] = 4434,
            },
        },
        [2] = nil,
        [3] = { -- Ret
            ["statPriority"] = {"Strength", "3% Hit Rating", "3% Expertise Rating", "Haste", "Critical Strike", "Mastery"},
            ["professions"] = {"Tailoring", "Herbalism"},
            ["gear"] = {
                ["head"] = 91272,
                ["neck"] = 99947,
                ["shoulders"] = 100130,
                ["back"] = 99944,
                ["chest"] = 99870,
                ["wrist"] = 99891,
                ["hands"] = 94343,
                ["waist"] = 99886,
                ["legs"] = 91273,
                ["feet"] = 99889,
                ["ring1"] = 99950,
                ["ring2"] = 99949,
                ["trinket1"] = 99943,
                ["trinket2"] = 100056,
                ["mainHand"] = 99972,
            },
            ["gems"] = {
                ["head"] = {76886, 76696},
                ["shoulders"] = {76699},
                ["chest"] = {76696, 76699},
                ["hands"] = {89674},
                ["waist"] = {89674, 76696},
                ["legs"] = {76696, 89674},
                ["feet"] = {76699},
                ["gem"] = {76696, 89674, 76699},
                ["bloodstone"] = 76886,
            },
            ["enchants"] = {
                ["shoulders"] = 4803,
                ["back"] = 4424,
                ["chest"] = 4419,
                ["wrist"] = 4415,
                ["hands"] = 4432,
                ["waist"] = 5002,
                ["legs"] = 4823,
                ["feet"] = 4429,
                ["mainHand"] = 4444,
            },
        },
    },
    ["MAGE"] = {
        [1] = nil,
        [2] = nil,
        [3] = { -- Frost
            ["statPriority"] = {"Intellect", "6% Hit Rating", "Critical Strike", "Haste", "Mastery"},
            ["professions"] = {"Tailoring", "Engineering"},
            ["gear"] = {
                ["head"] = 91234,
                ["neck"] = 94473,
                ["shoulders"] = 94389,
                ["back"] = 91124,
                ["chest"] = 91238,
                ["wrist"] = 91122,
                ["hands"] = 91232,
                ["waist"] = 91111,
                ["legs"] = 84875,
                ["feet"] = 94362,
                ["ring1"] = 91139,
                ["ring2"] = 94390,
                ["trinket1"] = 91401,
                ["trinket2"] = 91400,
                ["mainHand"] = 91398,
                ["offHand"] = 91127,
            },
            ["gems"] = {
                ["head"] = {76885, 76694},
                ["shoulders"] = {76668},
                ["chest"] = {76694, 76668},
                ["hands"] = {76685},
                ["waist"] = {76685, 76694},
                ["legs"] = {76694, 76685},
                ["feet"] = {76668},
                ["gem"] = {76694, 76685, 76668},
                ["bloodstone"] = 76885,
            },
            ["enchants"] = {
                ["shoulders"] = 4806,
                ["back"] = 4423,
                ["chest"] = 4419,
                ["wrist"] = 4414,
                ["hands"] = 4430,
                ["waist"] = 5002,
                ["legs"] = 4825,
                ["feet"] = 4429,
                ["mainHand"] = 4442,
                ["offHand"] = 4434,
            },
        },
    },
    ["PRIEST"] = {
        [1] = nil,
        [2] = { -- Holy
            ["statPriority"] = {"Intellect", "8% Haste", "Spirit", "Critical Strike", "Mastery"},
            ["gear"] = {
                ["head"] = 99894,
                ["neck"] = 100122,
                ["shoulders"] = 100136,
                ["back"] = 100142,
                ["chest"] = 99896,
                ["wrist"] = 99789,
                ["hands"] = 94423,
                ["waist"] = 91114,
                ["legs"] = 94420,
                ["feet"] = 99786,
                ["ring1"] = 99802,
                ["ring2"] = 100060,
                ["trinket1"] = 100152,
                ["trinket2"] = 100056,
                ["mainHand"] = 91134,
            },
            ["gems"] = {
                ["head"] = {76890, 76694},
                ["shoulders"] = {76668},
                ["chest"] = {76694, 76668},
                ["hands"] = {76686},
                ["waist"] = {76686, 76694},
                ["legs"] = {76694, 76686},
                ["feet"] = {76668},
                ["gem"] = {76694, 76686, 76668},
                ["bloodstone"] = 76890,
            },
            ["enchants"] = {
                ["shoulders"] = 4806,
                ["back"] = 4423,
                ["chest"] = 4419,
                ["wrist"] = 4414,
                ["hands"] = 4430,
                ["waist"] = 5002,
                ["legs"] = 4826,
                ["feet"] = 4429,
                ["mainHand"] = 4442,
                ["offHand"] = 4434,
            },
        },
        [3] = { -- Shadow
            ["statPriority"] = {"Intellect", "6% Hit Rating", "Haste", "Critical Strike", "Mastery"},
            ["professions"] = {"Tailoring", "Herbalism"},
            ["gear"] = {
                ["head"] = 91322,
                ["neck"] = 100122,
                ["shoulders"] = 91328,
                ["back"] = 91124,
                ["chest"] = 91326,
                ["wrist"] = 91122,
                ["hands"] = 94328,
                ["waist"] = 91114,
                ["legs"] = 94334,
                ["feet"] = 91118,
                ["ring1"] = 99802,
                ["ring2"] = 99801,
                ["trinket1"] = 97532,
                ["trinket2"] = 100056,
                ["mainHand"] = 91134,
            },
            ["gems"] = {
                ["head"] = {76885, 76668},
                ["shoulders"] = {76699},
                ["chest"] = {76668, 76699},
                ["hands"] = {76651},
                ["waist"] = {76651, 76668},
                ["legs"] = {76668, 76651},
                ["feet"] = {76699},
                ["gem"] = {76668, 76651, 76699},
                ["bloodstone"] = 76885,
            },
            ["enchants"] = {
                ["shoulders"] = 4806,
                ["back"] = 4423,
                ["chest"] = 4419,
                ["wrist"] = 4414,
                ["hands"] = 4430,
                ["waist"] = 5002,
                ["legs"] = 4826,
                ["feet"] = 4429,
                ["mainHand"] = 4442,
                ["offHand"] = 4434,
            },
        },
    },
    ["HUNTER"] = {
        [1] = nil,
        [2] = { -- MM
            ["statPriority"] = {"Agility", "3% Hit Rating", "3% Expertise Rating", "Critical Strike", "Haste", "Mastery"},
            ["professions"] = {"Tailoring", "Engineering"},
            ["gear"] = {
                ["head"] = 91226,
                ["neck"] = 99775,
                ["shoulders"] = 91231,
                ["back"] = 91100,
                ["chest"] = 94405,
                ["wrist"] = 100139,
                ["hands"] = 94453,
                ["waist"] = 91212,
                ["legs"] = 91228,
                ["feet"] = 91218,
                ["ring1"] = 94357,
                ["ring2"] = 91106,
                ["trinket1"] = 91099,
                ["trinket2"] = 91104,
                ["mainHand"] = 91145,
            },
            ["gems"] = {
                ["head"] = {76884, 76692},
                ["shoulders"] = {76658},
                ["chest"] = {76692, 76658},
                ["hands"] = {76680},
                ["waist"] = {76680, 76692},
                ["legs"] = {76692, 76680},
                ["feet"] = {76658},
                ["gem"] = {76692, 76680, 76658},
                ["bloodstone"] = 76884,
            },
            ["enchants"] = {
                ["shoulders"] = 4804,
                ["back"] = 4424,
                ["chest"] = 4419,
                ["wrist"] = 4416,
                ["hands"] = 4430,
                ["waist"] = 5002,
                ["legs"] = 4822,
                ["feet"] = 4428,
                ["mainHand"] = 4918,
            },
        },
        [3] = nil,
    },
    ["WARLOCK"] = {
        [1] = { -- Affliction
            ["statPriority"] = {"Intellect", "6% Hit Rating", "Haste", "Mastery", "Critical Strike"},
            ["professions"] = {"Tailoring", "Herbalism"},
            ["gear"] = {
                ["head"] = 91422,
                ["neck"] = 94473,
                ["shoulders"] = 91428,
                ["back"] = 91125,
                ["chest"] = 91426,
                ["wrist"] = 91122,
                ["hands"] = 94441,
                ["waist"] = 91111,
                ["legs"] = 91424,
                ["feet"] = 91117,
                ["ring1"] = 91139,
                ["ring2"] = 94390,
                ["trinket1"] = 91401,
                ["trinket2"] = 91400,
                ["mainHand"] = 91398,
                ["offHand"] = 91127,
            },
            ["gems"] = {
                ["head"] = {76885, 76668},
                ["shoulders"] = {76699},
                ["chest"] = {76668, 76699},
                ["hands"] = {76642},
                ["waist"] = {76642, 76668},
                ["legs"] = {76668, 76642},
                ["feet"] = {76699},
                ["gem"] = {76668, 76642, 76699},
                ["bloodstone"] = 76885,
            },
            ["enchants"] = {
                ["shoulders"] = 4806,
                ["back"] = 4423,
                ["chest"] = 4419,
                ["wrist"] = 4414,
                ["hands"] = 4430,
                ["waist"] = 5002,
                ["legs"] = 4825,
                ["feet"] = 4429,
                ["mainHand"] = 4442,
                ["offHand"] = 4434,
            },
        },
        [2] = nil,
        [3] = nil,
    },
    ["ROGUE"] = {
        [1] = nil,
        [2] = nil,
        [3] = { -- Sub
            ["statPriority"] = {"Agility", "3% Hit Rating", "3% Expertise Rating", "Mastery", "Critical Strike", "Haste"},
            ["professions"] = {"Tailoring", "Engineering"},
            ["gear"] = {
                ["head"] = 100096,
                ["neck"] = 100064,
                ["shoulders"] = 99910,
                ["back"] = 99774,
                ["chest"] = 100113,
                ["wrist"] = 100140,
                ["hands"] = 91342,
                ["waist"] = 91243,
                ["legs"] = 94446,
                ["feet"] = 99904,
                ["ring1"] = 99779,
                ["ring2"] = 99778,
                ["trinket1"] = 99772,
                ["trinket2"] = 100056,
                ["mainHand"] = 99932,
                ["offHand"] = 99932,
            },
            ["gems"] = {
                ["head"] = {76884, 76692},
                ["shoulders"] = {76670},
                ["chest"] = {76692, 76670},
                ["hands"] = {76680},
                ["waist"] = {76680, 76692},
                ["legs"] = {76692.76680},
                ["feet"] = {76670},
                ["gem"] = {76692, 76680, 76670},
                ["bloodstone"] = 76884,
            },
            ["enchants"] = {
                ["shoulders"] = 4804,
                ["back"] = 4424,
                ["chest"] = 4419,
                ["wrist"] = 4416,
                ["waist"] = 5002,
                ["legs"] = 4822,
                ["feet"] = 4428,
                ["mainHand"] = 4918,
            },
        },
    },
    ["DRUID"] = {
        [1] = nil,
        [2] = nil,
        [3] = nil,
        [4] = { -- Resto
            ["statPriority"] = {"Intellect", "12.52% Haste", "Mastery", "Spirit", "Critical Strike"},
            ["professions"] = {"Alch/Ench/Inscrip/JC/LW"},
            ["gear"] = {
                ["head"] = 99820,
                ["neck"] = 100143,
                ["shoulders"] = 99823,
                ["back"] = 99791,
                ["chest"] = 100107,
                ["wrist"] = 99827,
                ["hands"] = 94371,
                ["waist"] = 100161,
                ["legs"] = 94483,
                ["feet"] = 99913,
                ["ring1"] = 99802,
                ["ring2"] = 100060,
                ["trinket1"] = 100152,
                ["trinket2"] = 100006,
                ["mainHand"] = 99795,
                ["offHand"] = 100169,
            },
            ["gems"] = {
                ["head"] = {76890, 76694},
                ["shoulders"] = {76668},
                ["chest"] = {76694, 76668},
                ["hands"] = {76686},
                ["waist"] = {76686, 76694},
                ["legs"] = {76694, 76686},
                ["feet"] = {76668},
                ["gem"] = {76694, 76686, 76668},
                ["bloodstone"] = 76890,
            },
            ["enchants"] = {
                ["shoulders"] = 4806,
                ["back"] = 4423,
                ["chest"] = 4419,
                ["wrist"] = 4414,
                ["hands"] = 4430,
                ["waist"] = 5002,
                ["legs"] = 4826,
                ["feet"] = 4429,
                ["mainHand"] = 4442,
                ["offHand"] = 4434,
            },
        },
    },
    ["MONK"] = {
        [1] = nil,
        [2] = { -- Mistweaver
            ["statPriority"] = {"Intellect", "Critical Strike", "Spirit", "Haste", "Mastery"},
            ["professions"] = {"Blacksmithing", "Jewelcrafting"},
            ["gear"] = {
                ["head"] = 91260,
                ["neck"] = 100159,
                ["shoulders"] = 91263,
                ["back"] = 100142,
                ["chest"] = 91266,
                ["wrist"] = 99818,
                ["hands"] = 91257,
                ["waist"] = 91184,
                ["legs"] = 100148,
                ["feet"] = 99826,
                ["ring1"] = 100060,
                ["ring2"] = 99802,
                ["trinket1"] = 99772,
                ["trinket2"] = 100057,
                ["mainHand"] = 91398,
                ["offHand"] = 91127,
            },
            ["gems"] = {
                ["head"] = {76890, 76660},
                ["shoulders"] = {76697},
                ["chest"] = {76660, 76697},
                ["hands"] = {76640},
                ["waist"] = {76640, 76660},
                ["legs"] = {76660, 76640},
                ["feet"] = {76697},
                ["gem"] = {76660, 76640, 76697},
                ["bloodstone"] = 76890,
            },
            ["enchants"] = {
                ["shoulders"] = 4806,
                ["back"] = 4423,
                ["wrist"] = 4414,
                ["hands"] = 4433,
                ["feet"] = 4429,
                ["mainHand"] = 4442,
                ["offHand"] = 4434,
            },
        },
        [3] = { -- Windwalker
            ["statPriority"] = {"Agility", "3% Hit Rating", "3% Expertise Rating", "12% Haste", "Critical Strike", "Mastery"},
            ["professions"] = {"Tailoring", "Engineering"},
            ["gear"] = {
                ["head"] = 94428,
                ["neck"] = 99775,
                ["shoulders"] = 99775,
                ["back"] = 91100,
                ["chest"] = 91256,
                ["wrist"] = 100097,
                ["hands"] = 91248,
                ["waist"] = 100094,
                ["legs"] = 91251,
                ["feet"] = 100102,
                ["ring1"] = 99779,
                ["ring2"] = 94357,
                ["trinket1"] = 91099,
                ["trinket2"] = 91104,
                ["mainHand"] = 91097,
                ["offHand"] = 91097,
            },
            ["gems"] = {
                ["head"] = {76884, 76692},
                ["shoulders"] = {76666},
                ["chest"] = {76692, 76666},
                ["hands"] = {76680},
                ["waist"] = {76680, 76692},
                ["legs"] = {76692, 76680},
                ["feet"] = {76666},
                ["gem"] = {76692, 76680, 76666},
                ["bloodstone"] = 76884,
            },
            ["enchants"] = {
                ["shoulders"] = 4804,
                ["back"] = 4424,
                ["chest"] = 4419,
                ["wrist"] = 4416,
                ["hands"] = 4430,
                ["waist"] = 5002,
                ["legs"] = 4822,
                ["feet"] = 4428,
                ["mainHand"] = 4444,
                ["offHand"] = 4444,
            },
        },
    },
    ["SHAMAN"] = {
        [1] = { -- Ele
            ["statPriority"] = {"Intellect", "6% Hit Rating", "Haste", "Mastery", "Critical Strike"},
            ["professions"] = {"Tailoring", "Engineering"},
            ["gear"] = {
                ["head"] = 99929,
                ["neck"] = 100143,
                ["shoulders"] = 100020,
                ["back"] = 99791,
                ["chest"] = 100129,
                ["wrist"] = 100049,
                ["hands"] = 91360,
                ["waist"] = 100052,
                ["legs"] = 91386,
                ["feet"] = 99912,
                ["ring1"] = 99802,
                ["ring2"] = 99801,
                ["trinket1"] = 100152,
                ["trinket2"] = 100056,
                ["mainHand"] = 99795,
                ["offHand"] = 100168,
            },
            ["gems"] = {
                ["head"] = {76885, 76694},
                ["shoulders"] = {76668},
                ["chest"] = {76694, 76668},
                ["hands"] = {76685},
                ["waist"] = {76685, 76694},
                ["legs"] = {76694, 76685},
                ["feet"] = {76668},
                ["gem"] = {76694, 76685, 76668},
                ["bloodstone"] = 76885,
            },
            ["enchants"] = {
                ["shoulders"] = 4806,
                ["back"] = 4423,
                ["chest"] = 4419,
                ["wrist"] = 4414,
                ["hands"] = 4430,
                ["waist"] = 5002,
                ["legs"] = 4825,
                ["feet"] = 4429,
                ["mainHand"] = 4442,
                ["offHand"] = 4434,
            },
        },
        [2] = { -- Enh
            ["statPriority"] = {"Agility", "3% Hit Rating", "3% Expertise Rating", "Mastery", "Critical Strike", "Haste"},
            ["professions"] = {"Tailoring", "Engineering"},
            ["gear"] = {
                ["head"] = 99923,
                ["neck"] = 99776,
                ["shoulders"] = 99925,
                ["back"] = 99774,
                ["chest"] = 100145,
                ["wrist"] = 100139,
                ["hands"] = 91370,
                ["waist"] = 100028,
                ["legs"] = 94494,
                ["feet"] = 99843,
                ["ring1"] = 99779,
                ["ring2"] = 99778,
                ["trinket1"] = 99772,
                ["trinket2"] = 100057,
                ["mainHand"] = 99973,
                ["offHand"] = 99973,
            },
            ["gems"] = {
                ["head"] = {76884, 76692},
                ["shoulders"] = {76670},
                ["chest"] = {76692, 76670},
                ["hands"] = {89680},
                ["waist"] = {89680, 76692},
                ["legs"] = {76692, 89680},
                ["feet"] = {76670},
                ["gem"] = {76692, 89680, 76670},
                ["bloodstone"] = 76884,
            },
            ["enchants"] = {
                ["shoulders"] = 4804,
                ["back"] = 4424,
                ["chest"] = 4419,
                ["wrist"] = 4416,
                ["hands"] = 4433,
                ["waist"] = 5002,
                ["legs"] = 4822,
                ["feet"] = 4428,
                ["mainHand"] = 4444,
                ["offHand"] = 4918,
            },
        },
        [3] = { -- Resto
            ["statPriority"] = {"Intellect", "Critical Strike", "Spirit", "Mastery", "Haste"},
            ["professions"] = {"Blacksmithing", "Jewelcrafting"},
            ["gear"] = {
                ["head"] = 100104,
                ["neck"] = 100159,
                ["shoulders"] = 100039,
                ["back"] = 100142,
                ["chest"] = 99916,
                ["wrist"] = 100004,
                ["hands"] = 94408,
                ["waist"] = 91243,
                ["legs"] = 91364,
                ["feet"] = 99912,
                ["ring1"] = 99802,
                ["ring2"] = 100060,
                ["trinket1"] = 100066,
                ["trinket2"] = 100056,
                ["mainHand"] = 99795,
                ["offHand"] = 100171,
            },
            ["gems"] = {
                ["head"] = {76890, 76660},
                ["shoulders"] = {76697},
                ["chest"] = {76660, 76697},
                ["hands"] = {76640},
                ["waist"] = {76640, 76660},
                ["legs"] = {76660, 76640},
                ["feet"] = {76697},
                ["gem"] = {76660, 76640, 76697},
                ["bloodstone"] = 76890,
            },
            ["enchants"] = {
                ["shoulders"] = 4806,
                ["back"] = 4423,
                ["chest"] = 4419,
                ["wrist"] = 4414,
                ["hands"] = 4433,
                ["waist"] = 5002,
                ["legs"] = 4826,
                ["feet"] = 4429,
                ["mainHand"] = 4442,
                ["offHand"] = 4434,
            },
        },
    },
}

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
                for slot, gemData in pairs(specData.gems) do
                    if type(gemData) == "table" then
                        for _, gemID in ipairs(gemData) do
                            itemIDs[gemID] = true
                        end
                    elseif type(gemData) == "number" then
                        itemIDs[gemData] = true
                    end
                end
            end

            -- Enchants mapped to items
            if specData.enchants then
                for _, enchantID in pairs(specData.enchants) do
                    local enchantItemID = BisGear.enchantsToItemID[enchantID]
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

    for enchantID, itemID in pairs(BisGear["enchantsToItemID"]) do
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
        [2] = {1540, 12029}, -- Honor Gear (Uncommon) ilvl 665
        [3] = {1550, 12019}, -- Warmonger (Rare) ilvl 675
        [4] = {1553, 12030}  -- Conquest (Epic) ilvl 678
    }

    -- bonus ids: itemLevel, PvP EquipBonus itemLevel

    return qualityBonusMap[itemQuality] or {}
end

local bisgearComingSoon = true

local embellishmentsAdded = 0
local embellishSlots = {}
local function CreateItemLink(gearSlot, bonusIDs, bloodstone, isCrafted)
    if not gearSlot then
        return nil
    end

    _, class = UnitClass("player")
    specIndex = C_SpecializationInfo.GetSpecialization()
    local specData = BisGear[class][specIndex]

    local itemID = specData.gear[gearSlot]
    if not itemID then
        return nil
    end

    local enchantID = specData.enchants and specData.enchants[gearSlot] or ""
    local gemIDs = GetGemIDsForSlot(gearSlot, bloodstone, specData.gems, specData.gems.bloodstone)
    local embellishmentData = specData.embellishment or {}
    local linkLevel = 80
    local specializationID = nil
    local itemContext = 8

    local itemName = C_Item.GetItemNameByID(itemID) or "Unknown Item"

    local itemQuality = C_Item.GetItemQualityByID(itemID)
    if isCrafted then
        itemQuality = 4
    end
    -- Fetch the bonus IDs for the given item quality
    -- local itemExtraBonusIDs = GetItemQualityBonusID(itemQuality)

    -- -- Insert all bonus IDs from the table into bonusIDs
    -- for _, bonusID in ipairs(itemExtraBonusIDs) do
    --     table.insert(bonusIDs, bonusID)
    -- end

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
        --tostring(#bonusIDs), -- Number of bonus IDs
        --table.concat(bonusIDs, ":") -- Bonus IDs
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

    if true then return end -- needs fixing for tbc as char panel is different


    local equipmentTab = PaperDollFrame
    -- local a,b,c,d,e = equipmentTab:GetPoint()
    -- equipmentTab:SetPoint(a,b,c,d-20,e)

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

    function SC:UpdateNoDataTooltip(frame, wontHaveData)
        frame:SetScript("OnEnter", function()
            GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(scIcon..coloredAddonName.." BIS List", 1, 1, 1)
            if wontHaveData then
                GameTooltip:AddLine("No data available for this spec.")
            else
                GameTooltip:AddLine("Coming soon to MoP!")
            end
            GameTooltip:Show()
        end)
    end


    local noDataOverlay = frame:CreateTexture(nil, "OVERLAY")
    noDataOverlay:SetAtlas("communities-icon-redx")
    noDataOverlay:SetSize(14,14)
    noDataOverlay:SetPoint("CENTER", icon, "CENTER", 0,0)
    SC:UpdateNoDataTooltip(noDataOverlay)

    noDataOverlay:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    frame.noData = noDataOverlay

    local comingSoonOverlay = frame:CreateTexture(nil, "OVERLAY")
    comingSoonOverlay:SetAtlas("worldquest-icon-clock")
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
        --GameTooltip:AddLine("Coming soon to MoP")
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
            customPanel:SetSize(590, characterFrame:GetHeight())
            customPanel:SetPoint("TOPLEFT", characterFrame, "TOPRIGHT", 0, 0)
            if customPanel:GetHeight() == 0 then
                customPanel:SetHeight(424)
                customPanel.needsUpdate = true
            end

            local bg = customPanel:CreateTexture(nil, "BACKGROUND")
            bg:SetAtlas("loottab-background")
            bg:SetPoint("TOPLEFT", customPanel, "TOPLEFT", 6, -3)
            bg:SetPoint("BOTTOMRIGHT", customPanel, "BOTTOMRIGHT", -3, 6)
            bg:SetDesaturated(true)
            bg:SetVertexColor(0.25,0.25,0.25)
            bg:SetTexCoord(0.07, 0.93, 0.15, 1)

            if CharacterFrame.Bg then
                local desaturated = CharacterFrame.Bg:GetDesaturation()
                -- if desaturated == 1 then
                --     bg:SetDesaturated(true)
                -- end
                -- bg:SetTexCoord(CharacterFrameBg:GetTexCoord())
                -- bg:SetVertexColor(CharacterFrameBg:GetVertexColor())

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
                specIndex = C_SpecializationInfo.GetSpecialization()
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
            closeButton:SetPoint("TOPRIGHT", customPanel, "TOPRIGHT", 4, 4)
            closeButton:SetScript("OnClick", function()
                customPanel:Hide()
                UpdateTabBg()
                keepOpen = false
                SkillCappedDB.bisListShown = false
            end)
            closeButton:SetFrameStrata("DIALOG")

            SyncNineSliceColors(customPanel, CharacterFrame)

            frame.bisList = customPanel
            UpdateTabBg()

            local textGap = 4
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
            bestBloodstoneText:SetPoint("TOPLEFT", bestEmbellishmentsText, "BOTTOMLEFT", 0, -textGap)


            -- 11.1
            -- local version = GetBuildInfo()
            -- if version and version == "11.1.5" then
            --     local newSeasonIcon = customPanel:CreateTexture(nil, "OVERLAY")
            --     newSeasonIcon:SetAtlas("Ping_Marker_Icon_Warning")
            --     newSeasonIcon:SetSize(38,38)
            --     newSeasonIcon:SetPoint("TOPRIGHT", customPanel, "TOPRIGHT", -15, -40)

            --     newSeasonIcon:SetScript("OnEnter", function(self)
            --         GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            --         GameTooltip:AddLine("|A:Ping_Chat_Warning:16:16|a A new season has started!", 1, 1, 1, true)
            --         GameTooltip:AddLine("The BiS list will not be fully completed until later in the season.", nil, nil, nil, true)
            --         GameTooltip:Show()
            --     end)
            --     newSeasonIcon:SetScript("OnLeave", function()
            --         GameTooltip:Hide()
            --     end)

            --     local newSeason = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            --     newSeason:SetPoint("BOTTOM", customPanel, "BOTTOM", 12, 5)
            --     newSeason:SetText("New season: The BiS list will not be fully completed until later in the season.")
            --     local font = newSeason:GetFont()
            --     newSeason:SetFont(font, 9)
            --     newSeason:SetTextColor(1,1,1)

            --     local newSeasonIcon = customPanel:CreateTexture(nil, "OVERLAY")
            --     newSeasonIcon:SetAtlas("Ping_Chat_Warning")
            --     newSeasonIcon:SetSize(16,16)
            --     newSeasonIcon:SetPoint("RIGHT", newSeason, "LEFT", -1, 2)
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
                specIndex = C_SpecializationInfo.GetSpecialization()

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
                        local label = "|cffffff00Best Professions:|r "
                        local embellishment1 = specData.embellishment.embellishment1
                        local embellishment2 = specData.embellishment.embellishment2

                        GetSpellNameWithRetries(embellishment1, 10, 0.1, function(name1)
                            GetSpellNameWithRetries(embellishment2, 10, 0.1, function(name2)
                                if embellishment1 == embellishment2 then
                                    -- If both embellishments are the same
                                    bestEmbellishmentsText:SetText(label .. "|cffffffff" .. name1 .. " x 2|r")
                                    bestEmbellishmentsText2:SetText("")
                                    ItemTooltip(bestEmbellishmentsText, embellishItemIDs[embellishment1], "ANCHOR_RIGHT")
                                else
                                    -- If embellishments are different
                                    bestEmbellishmentsText:SetText(label .. "|cffffffff" .. name1 .. ", |r")
                                    bestEmbellishmentsText2:SetText("|cffffffff" .. name2 .. "|r")

                                    ItemTooltip(bestEmbellishmentsText, embellishItemIDs[embellishment1], "ANCHOR_RIGHT")
                                    ItemTooltip(bestEmbellishmentsText2, embellishItemIDs[embellishment2], "ANCHOR_RIGHT")
                                end
                            end)
                        end)
                    else
                        bestEmbellishmentsText:SetText("|cffffff00Best Professions:|r |cffffffffN/A|r")
                        bestEmbellishmentsText2:SetText("")
                    end

                    if specData.professions and #specData.professions > 0 then
                        local label = "|cffffff00Best Professions:|r "
                        local profText = "|cffffffff" .. table.concat(specData.professions, " & ") .. "|r"
                        bestEmbellishmentsText:SetText(label .. profText)
                    else
                        bestEmbellishmentsText:SetText("|cffffff00Best Professions:|r |cffffffffN/A|r")
                    end
                    bestEmbellishmentsText2:SetText("")

                    -- Update Best Gem
                    if specData.gems and specData.gems.gem then
                        local label = "|cffffff00Best Gem:|r "
                        local gemID = specData.gems.gem
                        -- GetItemNameWithRetries(gemID, 10, 0.1, function(name)
                        --     bestGemText:SetText(label .. "|cffffffff" .. name .. "|r")
                        --     ItemTooltip(bestGemText, gemID, "ANCHOR_RIGHT")
                        -- end)
                    else
                        bestGemText:SetText("|cffffff00Best Gem:|r |cffffffffN/A|r")
                    end

                    -- Update Best Metagem
                    if specData.gems and specData.gems.bloodstone then
                        local label = "|cffffff00Best Metagem:|r "
                        local bloodstoneID = specData.gems.bloodstone
                        GetItemNameWithRetries(bloodstoneID, 10, 0.1, function(name)
                            bestBloodstoneText:SetText(label .. "|cffffffff" .. name .. "|r")
                            ItemTooltip(bestBloodstoneText, bloodstoneID, "ANCHOR_RIGHT")
                        end)
                    else
                        bestBloodstoneText:SetText("|cffffff00Best Metagem:|r |cffffffffN/A|r")
                    end
                else
                    -- Default values if no data is found
                    statPriorityText:SetText("|cffffff00Stat Priority:|r |cffffffffN/A|r")
                    bestEmbellishmentsText:SetText("|cffffff00Best Professions:|r |cffffffffN/A|r")
                    bestGemText:SetText("|cffffff00Best Gem:|r |cffffffffN/A|r")
                    bestBloodstoneText:SetText("|cffffff00Best Metagem:|r |cffffffffN/A|r")
                end
            end

            local gearFrame = CreateFrame("Frame", nil, customPanel, "BackdropTemplate")
            gearFrame:SetSize(customPanel:GetWidth()-15, 325)
            gearFrame:SetPoint("TOPLEFT", bestBloodstoneText, "BOTTOMLEFT", 0, -5)
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
                    local enchantItemID = BisGear["enchantsToItemID"][enchantOnItem]
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
                            local qualityColor = (oldItemQuality == 2) and "|cff1eff00" or "|cffa335ee"
                            text = qualityColor..(itemName or "*MISSING*")
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
                specIndex = C_SpecializationInfo.GetSpecialization()

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
                specIndex = C_SpecializationInfo.GetSpecialization()

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
                    local wontHaveData = unavailableSpecs[class] and tContains(unavailableSpecs[class], specIndex)
                    SC:UpdateNoDataTooltip(noDataOverlay, wontHaveData)
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

            specIndex = C_SpecializationInfo.GetSpecialization()

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
                local wontHaveData = unavailableSpecs[class] and tContains(unavailableSpecs[class], specIndex)
                SC:UpdateNoDataTooltip(noDataOverlay, wontHaveData)
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
--         local gearSlot = "ring1"
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
--CheckItemLevelForBonusIDRange(10, 100000, 665)