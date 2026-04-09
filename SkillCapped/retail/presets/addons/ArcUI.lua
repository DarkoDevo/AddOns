local AddonName, SkillCapped = ...
local SC = SkillCapped

local function GetClassSpecString()
    local _, _, classIndex = UnitClass("player")
    local specIndex = GetSpecialization()
    return "class_" .. classIndex .. "_spec_" .. specIndex
end

local classRealmKeys = {
    ["DRUID"] = "Druid - Realm",
    ["WARRIOR"] = "Warrior - Realm",
    ["ROGUE"] = "Rogue - Realm",
    ["SHAMAN"] = "Shaman - Realm",
    ["DEATHKNIGHT"] = "DeathKnight - Realm",
    ["PRIEST"] = "Priest - Realm",
    ["PALADIN"] = "Paladin - Realm",
    ["MAGE"] = "Mage - Realm",
    ["MONK"] = "Monk - Realm",
    ["DEMONHUNTER"] = "DemonHunter - Realm",
    ["EVOKER"] = "Evoker - Realm",
    ["HUNTER"] = "Hunter - Realm",
    ["WARLOCK"] = "Warlock - Realm",
}

local function GetClassRealmString()
    local _, classFile = UnitClass("player")
    return classRealmKeys[classFile]
end

local function GetCharacterName()
    return UnitName("player")
end

function SC:ArcUIDB()
    local scArcUIDB = {
    ["char"] = {
    ["Warlock - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["positions"] = {
    },
    ["trackedItems"] = {
    },
    ["autoTrackEquippedTrinkets"] = false,
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["b"] = 1,
    ["g"] = 1,
    ["r"] = 1,
    },
    ["achLevel"] = 5,
    ["achShowBurst"] = true,
    ["achStyle"] = "ants",
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["r"] = 0.95,
    ["g"] = 0.95,
    ["b"] = 0.32,
    },
    ["useCustomColor"] = false,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["r"] = 0.2,
    ["g"] = 0.6,
    ["b"] = 1,
    },
    ["txLeft"] = 0,
    ["useMasqueShapes"] = false,
    ["mode"] = "flash",
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["txTop"] = 0,
    ["txRight"] = 1,
    ["txBottom"] = 1,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_9_spec_2"] = {
    ["characterName"] = "Warlock",
    ["createdAt"] = 1774007133,
    ["activeProfile"] = "Demonology",
    ["layoutProfiles"] = {
    ["Demonology"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769933755,
    ["savedPositions"] = {
    [5837] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [84224] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [143038] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 6,
    ["sortIndex"] = 6,
    },
    [84182] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [84183] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [135606] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    [9426] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [181090] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Buffs",
    ["row"] = 1,
    ["viewerType"] = "aura",
    },
    [9425] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [9472] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [5653] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 4,
    },
    [92732] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [5809] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 5,
    ["col"] = 0,
    },
    [8285] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 1,
    ["col"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["showBorder"] = false,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["iconSize"] = 34,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["showBorder"] = false,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["iconSize"] = 34,
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_9_spec_1"] = {
    ["characterName"] = "Warlock",
    ["createdAt"] = 1774007132,
    ["layoutProfiles"] = {
    ["Affliction"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769935364,
    ["savedPositions"] = {
    [9953] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [92673] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 0,
    },
    [128510] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [92674] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 3,
    },
    [83991] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [9952] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 2,
    },
    [83992] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [9950] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 4,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    [9957] = {
    ["y"] = 84.219360351562,
    ["x"] = -129.060546875,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Affliction",
    },
    ["class_9_spec_3"] = {
    ["characterName"] = "Warlock",
    ["createdAt"] = 1774007133,
    ["activeProfile"] = "Destruction",
    ["layoutProfiles"] = {
    ["Destruction"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769934076,
    ["savedPositions"] = {
    [84354] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [18796] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["sortIndex"] = 3,
    ["row"] = 3,
    ["viewerType"] = "aura",
    },
    [18797] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["sortIndex"] = 2,
    ["row"] = 2,
    ["viewerType"] = "aura",
    },
    [92734] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 5,
    ["sortIndex"] = 5,
    },
    [130897] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [18818] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 4,
    },
    [133583] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 8,
    ["col"] = 0,
    },
    [18820] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 2,
    },
    [26230] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [92735] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [18822] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 5,
    ["col"] = 0,
    },
    [18823] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 7,
    ["col"] = 0,
    },
    [18824] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 6,
    ["col"] = 0,
    },
    [18794] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["sortIndex"] = 0,
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [84355] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 9,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_9_spec_2"] = 1774007225,
    ["class_9_spec_1"] = 1774007225,
    ["class_9_spec_3"] = 1774007225,
    },
    ["lastActiveSpec"] = "class_9_spec_2",
    ["firstInitialized"] = 1774007129,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_9_spec_2"] = true,
    ["class_9_spec_1"] = true,
    ["class_9_spec_3"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    },
    ["Monk - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["trackedItems"] = {
    },
    ["positions"] = {
    },
    ["autoTrackEquippedTrinkets"] = false,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["r"] = 0.95,
    ["g"] = 0.95,
    ["b"] = 0.32,
    },
    ["useCustomColor"] = false,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["r"] = 0.2,
    ["g"] = 0.6,
    ["b"] = 1,
    },
    ["txLeft"] = 0,
    ["useMasqueShapes"] = false,
    ["mode"] = "flash",
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["txTop"] = 0,
    ["txRight"] = 1,
    ["txBottom"] = 1,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_10_spec_2"] = {
    ["characterName"] = "Monk",
    ["createdAt"] = 1774007028,
    ["activeProfile"] = "Mistweaver",
    ["layoutProfiles"] = {
    ["Mistweaver"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769834559,
    ["savedPositions"] = {
    [92322] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [49627] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 2,
    },
    [122504] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 3,
    },
    [61614] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 0,
    },
    [61652] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [111574] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [114757] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    [92320] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [49566] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_10_spec_1"] = {
    ["characterName"] = "Monk",
    ["createdAt"] = 1774007027,
    ["layoutProfiles"] = {
    ["Brewmaster"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769834719,
    ["savedPositions"] = {
    [90080] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 3,
    },
    [10486] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [10245] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [73761] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [10484] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [10487] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Brewmaster",
    },
    ["class_10_spec_3"] = {
    ["characterName"] = "Monk",
    ["createdAt"] = 1774007028,
    ["layoutProfiles"] = {
    ["Windwalker"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769834383,
    ["savedPositions"] = {
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    [121325] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [71137] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [92332] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [30505] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["viewerType"] = "aura",
    },
    [49805] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["viewerType"] = "aura",
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [122454] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [122407] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 1,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 5,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Windwalker",
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_10_spec_2"] = 1774007114,
    ["class_10_spec_1"] = 1774007114,
    ["class_10_spec_3"] = 1774007114,
    },
    ["lastActiveSpec"] = "class_10_spec_3",
    ["firstInitialized"] = 1774007024,
    ["showBorderInEditMode"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_10_spec_2"] = true,
    ["class_10_spec_1"] = true,
    ["class_10_spec_3"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["b"] = 1,
    ["g"] = 1,
    ["r"] = 1,
    },
    ["achStyle"] = "ants",
    ["achShowBurst"] = true,
    ["achLevel"] = 5,
    },
    },
    ["DemonHunter - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["autoTrackEquippedTrinkets"] = false,
    ["trackedItems"] = {
    },
    ["positions"] = {
    },
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achLevel"] = 5,
    ["achStyle"] = "ants",
    ["achShowBurst"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["r"] = 1,
    ["g"] = 1,
    ["b"] = 1,
    },
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["b"] = 0.32,
    ["g"] = 0.95,
    ["r"] = 0.95,
    },
    ["txBottom"] = 1,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["b"] = 1,
    ["g"] = 0.6,
    ["r"] = 0.2,
    },
    ["txRight"] = 1,
    ["useMasqueShapes"] = false,
    ["txTop"] = 0,
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["mode"] = "flash",
    ["txLeft"] = 0,
    ["useCustomColor"] = false,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_12_spec_2"] = {
    ["characterName"] = "DemonHunter",
    ["createdAt"] = 1774006305,
    ["layoutProfiles"] = {
    ["Vengeance"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769917660,
    ["savedPositions"] = {
    [11432] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [132973] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [151710] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 5,
    ["col"] = 0,
    },
    [183197] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 0,
    },
    [132336] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [11431] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [11528] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 2,
    ["col"] = 0,
    },
    [20811] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 4,
    },
    [11527] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [30599] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [90455] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [30668] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 1,
    ["col"] = 0,
    },
    [11361] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Vengeance",
    },
    ["class_12_spec_1"] = {
    ["characterName"] = "DemonHunter",
    ["createdAt"] = 1774006305,
    ["layoutProfiles"] = {
    ["Havoc"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769916581,
    ["savedPositions"] = {
    [40889] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    [130563] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [92001] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [90490] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 1,
    ["col"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [90489] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [40888] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [193970] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [129324] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    [92000] = {
    ["y"] = 113.88586425781,
    ["x"] = -233.72747802734,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Havoc",
    },
    ["class_12_spec_3"] = {
    ["characterName"] = "DemonHunter",
    ["createdAt"] = 1774006303,
    ["activeProfile"] = "Devourer",
    ["layoutProfiles"] = {
    ["Devourer"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769918679,
    ["savedPositions"] = {
    [101982] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [101820] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [90273] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [91115] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [101903] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [168619] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    [101981] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [168618] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_12_spec_2"] = 1774006664,
    ["class_12_spec_1"] = 1774006664,
    ["class_12_spec_3"] = 1774006664,
    },
    ["lastActiveSpec"] = "class_12_spec_1",
    ["firstInitialized"] = 1774006300,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_12_spec_2"] = true,
    ["class_12_spec_1"] = true,
    ["class_12_spec_3"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    },
    ["Shaman - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["positions"] = {
    },
    ["trackedItems"] = {
    },
    ["autoTrackEquippedTrinkets"] = false,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["r"] = 0.95,
    ["g"] = 0.95,
    ["b"] = 0.32,
    },
    ["useCustomColor"] = false,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["r"] = 0.2,
    ["g"] = 0.6,
    ["b"] = 1,
    },
    ["txLeft"] = 0,
    ["useMasqueShapes"] = false,
    ["mode"] = "flash",
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["txTop"] = 0,
    ["txRight"] = 1,
    ["txBottom"] = 1,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_7_spec_2"] = {
    ["characterName"] = "Shaman",
    ["createdAt"] = 1774005766,
    ["layoutProfiles"] = {
    ["Enhancement"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769832188,
    ["savedPositions"] = {
    [82392] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [82618] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [112545] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [13163] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [82398] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [82363] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [82621] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [82615] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [82377] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 4,
    },
    [82628] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 5,
    ["col"] = 0,
    },
    [82404] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 6,
    ["col"] = 0,
    },
    [82405] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 8,
    ["col"] = 0,
    },
    [82406] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 7,
    ["col"] = 0,
    },
    [92502] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 3,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 9,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 1,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 5,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Enhancement",
    },
    ["class_7_spec_1"] = {
    ["characterName"] = "Shaman",
    ["createdAt"] = 1774005766,
    ["layoutProfiles"] = {
    ["Elemental"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769831837,
    ["savedPositions"] = {
    [80173] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [80174] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [80075] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [25449] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 6,
    ["col"] = 0,
    },
    [95405] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 4,
    },
    [79896] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [80167] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [79883] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 5,
    ["sortIndex"] = 5,
    },
    [79884] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    [24093] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [79869] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [92350] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Elemental",
    },
    ["class_7_spec_3"] = {
    ["characterName"] = "Shaman",
    ["createdAt"] = 1774005765,
    ["activeProfile"] = "Restoration",
    ["layoutProfiles"] = {
    ["Restoration"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769831453,
    ["savedPositions"] = {
    [33157] = {
    ["type"] = "group",
    ["col"] = 5,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 5,
    },
    [33226] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    ["arc_trinket_13"] = {
    ["y"] = 158,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -147,
    },
    [78149] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    [78151] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    [30041] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 7,
    },
    [77973] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 1,
    },
    [77357] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [175914] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [33365] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [78150] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 5,
    ["col"] = 0,
    },
    ["arc_trinket_14"] = {
    ["y"] = 200,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 21,
    },
    [30039] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [33121] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 4,
    },
    [77372] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 6,
    ["sortIndex"] = 6,
    },
    [32869] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [77964] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [30040] = {
    ["type"] = "group",
    ["col"] = 6,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 6,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 8,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -53.018215603299,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_7_spec_1"] = 1774006040,
    ["class_7_spec_2"] = 1774006040,
    ["class_7_spec_3"] = 1774006040,
    },
    ["lastActiveSpec"] = "class_7_spec_2",
    ["firstInitialized"] = 1774005762,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_7_spec_1"] = true,
    ["class_7_spec_2"] = true,
    ["class_7_spec_3"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["b"] = 1,
    ["g"] = 1,
    ["r"] = 1,
    },
    ["achLevel"] = 5,
    ["achShowBurst"] = true,
    ["achStyle"] = "ants",
    },
    },
    ["Hunter - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["trackedItems"] = {
    },
    ["positions"] = {
    },
    ["autoTrackEquippedTrinkets"] = false,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["r"] = 0.95,
    ["g"] = 0.95,
    ["b"] = 0.32,
    },
    ["useCustomColor"] = false,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["r"] = 0.2,
    ["g"] = 0.6,
    ["b"] = 1,
    },
    ["txLeft"] = 0,
    ["useMasqueShapes"] = false,
    ["mode"] = "flash",
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["txTop"] = 0,
    ["txRight"] = 1,
    ["txBottom"] = 1,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_3_spec_1"] = {
    ["characterName"] = "Hunter",
    ["createdAt"] = 1774006058,
    ["layoutProfiles"] = {
    ["Beast Mastery"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769830824,
    ["savedPositions"] = {
    [169029] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Buffs",
    ["row"] = 1,
    ["viewerType"] = "aura",
    },
    [92792] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [92796] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [92797] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [96353] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [92799] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    ["arc_trinket_13"] = {
    ["y"] = 200,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 105,
    },
    ["arc_trinket_14"] = {
    ["y"] = 158,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -147,
    },
    [31396] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["showBorder"] = false,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["iconSize"] = 34,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["showBorder"] = false,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["iconSize"] = 34,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Beast Mastery",
    },
    ["class_3_spec_2"] = {
    ["characterName"] = "Hunter",
    ["createdAt"] = 1774006058,
    ["layoutProfiles"] = {
    ["Marksmanship"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769830976,
    ["savedPositions"] = {
    [92802] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [3604] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [3584] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [92807] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [92803] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [3664] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [92805] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 2,
    },
    [3644] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Marksmanship",
    },
    ["class_3_spec_3"] = {
    ["characterName"] = "Hunter",
    ["createdAt"] = 1774006057,
    ["activeProfile"] = "Survival",
    ["layoutProfiles"] = {
    ["Survival"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769831156,
    ["savedPositions"] = {
    [8178] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [92813] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [156300] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [8177] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [92816] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [156301] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [169100] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [92814] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_3_spec_2"] = 1774006179,
    ["class_3_spec_1"] = 1774006179,
    ["class_3_spec_3"] = 1774006179,
    },
    ["lastActiveSpec"] = "class_3_spec_1",
    ["firstInitialized"] = 1774006054,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_3_spec_2"] = true,
    ["class_3_spec_1"] = true,
    ["class_3_spec_3"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["b"] = 1,
    ["g"] = 1,
    ["r"] = 1,
    },
    ["achStyle"] = "ants",
    ["achShowBurst"] = true,
    ["achLevel"] = 5,
    },
    },
    ["Evoker - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["positions"] = {
    },
    ["trackedItems"] = {
    },
    ["autoTrackEquippedTrinkets"] = false,
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["b"] = 1,
    ["g"] = 1,
    ["r"] = 1,
    },
    ["achLevel"] = 5,
    ["achShowBurst"] = true,
    ["achStyle"] = "ants",
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["r"] = 0.95,
    ["g"] = 0.95,
    ["b"] = 0.32,
    },
    ["useCustomColor"] = false,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["r"] = 0.2,
    ["g"] = 0.6,
    ["b"] = 1,
    },
    ["txLeft"] = 0,
    ["useMasqueShapes"] = false,
    ["mode"] = "flash",
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["txTop"] = 0,
    ["txRight"] = 1,
    ["txBottom"] = 1,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_13_spec_1"] = {
    ["characterName"] = "Evoker",
    ["createdAt"] = 1774006197,
    ["layoutProfiles"] = {
    ["Devastation"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769832973,
    ["savedPositions"] = {
    [57345] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [92071] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [94352] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 5,
    ["sortIndex"] = 5,
    },
    [89674] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 6,
    ["sortIndex"] = 6,
    },
    [92075] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [94356] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [1732] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [92072] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [117054] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [57508] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [57378] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [92074] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 4,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Devastation",
    },
    ["class_13_spec_3"] = {
    ["characterName"] = "Evoker",
    ["createdAt"] = 1774006199,
    ["activeProfile"] = "Augmentation",
    ["layoutProfiles"] = {
    ["Augmentation"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769832814,
    ["savedPositions"] = {
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [92281] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [92278] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [56880] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [56777] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    [92280] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 3,
    },
    [1773] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_13_spec_2"] = {
    ["characterName"] = "Evoker",
    ["createdAt"] = 1774006199,
    ["activeProfile"] = "Preservation",
    ["layoutProfiles"] = {
    ["Preservation"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769832617,
    ["savedPositions"] = {
    [94033] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [1100] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [64313] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [92251] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    ["arc_trinket_14"] = {
    ["y"] = 200,
    ["type"] = "free",
    ["iconSize"] = 36,
    ["x"] = 21,
    },
    [92253] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 4,
    },
    [92254] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 3,
    },
    [147775] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    ["arc_trinket_13"] = {
    ["y"] = 200,
    ["type"] = "free",
    ["iconSize"] = 36,
    ["x"] = 105,
    },
    [1129] = {
    ["type"] = "group",
    ["col"] = 5,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 5,
    },
    [93911] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [4255] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 6,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -18.907104492187,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_13_spec_1"] = 1774006283,
    ["class_13_spec_3"] = 1774006283,
    ["class_13_spec_2"] = 1774006283,
    },
    ["lastActiveSpec"] = "class_13_spec_1",
    ["firstInitialized"] = 1774006195,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_13_spec_1"] = true,
    ["class_13_spec_3"] = true,
    ["class_13_spec_2"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    },
    ["Mage - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["autoTrackEquippedTrinkets"] = false,
    ["trackedItems"] = {
    },
    ["positions"] = {
    },
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achLevel"] = 5,
    ["achStyle"] = "ants",
    ["achShowBurst"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["r"] = 1,
    ["g"] = 1,
    ["b"] = 1,
    },
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["b"] = 0.32,
    ["g"] = 0.95,
    ["r"] = 0.95,
    },
    ["txBottom"] = 1,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["b"] = 1,
    ["g"] = 0.6,
    ["r"] = 0.2,
    },
    ["txRight"] = 1,
    ["useMasqueShapes"] = false,
    ["txTop"] = 0,
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["mode"] = "flash",
    ["txLeft"] = 0,
    ["useCustomColor"] = false,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_8_spec_3"] = {
    ["characterName"] = "Mage",
    ["createdAt"] = 1774007242,
    ["activeProfile"] = "Frost",
    ["layoutProfiles"] = {
    ["Frost"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769942699,
    ["savedPositions"] = {
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    [146196] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [113855] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [80871] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [122569] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [80876] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [80875] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [26467] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [116140] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_8_spec_2"] = {
    ["characterName"] = "Mage",
    ["createdAt"] = 1774007243,
    ["layoutProfiles"] = {
    ["Fire"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769943684,
    ["savedPositions"] = {
    [113683] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [6213] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [80819] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [80823] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [35689] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [154602] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [6210] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    [80824] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Fire",
    },
    ["class_8_spec_1"] = {
    ["characterName"] = "Mage",
    ["createdAt"] = 1774007243,
    ["layoutProfiles"] = {
    ["Arcane"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769944557,
    ["savedPositions"] = {
    [91122] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [111661] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [6756] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    [122628] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [80314] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [80315] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [53326] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [80671] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Arcane",
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_8_spec_1"] = 1774007443,
    ["class_8_spec_3"] = 1774007443,
    ["class_8_spec_2"] = 1774007443,
    },
    ["lastActiveSpec"] = "class_8_spec_3",
    ["firstInitialized"] = 1774007239,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_8_spec_1"] = true,
    ["class_8_spec_3"] = true,
    ["class_8_spec_2"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    },
    ["Warrior - Realm"] = {
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["trackedItems"] = {
    },
    ["positions"] = {
    },
    ["autoTrackEquippedTrinkets"] = false,
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["r"] = 0.95,
    ["g"] = 0.95,
    ["b"] = 0.32,
    },
    ["useCustomColor"] = false,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["r"] = 0.2,
    ["g"] = 0.6,
    ["b"] = 1,
    },
    ["txLeft"] = 0,
    ["useMasqueShapes"] = false,
    ["mode"] = "flash",
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["txTop"] = 0,
    ["txRight"] = 1,
    ["txBottom"] = 1,
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_1_spec_1"] = {
    ["characterName"] = "Warrior",
    ["createdAt"] = 1774005520,
    ["layoutProfiles"] = {
    ["Arms"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769829015,
    ["savedPositions"] = {
    [91932] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [91937] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    },
    [91938] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [91939] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [47606] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [91928] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [33985] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [78319] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["iconHeight"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["spacing"] = 2,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["iconHeight"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["spacing"] = 2,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Arms",
    },
    ["class_1_spec_2"] = {
    ["characterName"] = "Warrior",
    ["createdAt"] = 1774005518,
    ["activeProfile"] = "Fury",
    ["layoutProfiles"] = {
    ["Fury"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1773180940,
    ["savedPositions"] = {
    [91962] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [91963] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["viewerType"] = "aura",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [91951] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["viewerType"] = "aura",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [98464] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["viewerType"] = "aura",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [17728] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [91942] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [91948] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["viewerType"] = "aura",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [48538] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 5,
    ["sortIndex"] = 5,
    },
    [78775] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [79111] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [48610] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 6,
    ["sortIndex"] = 6,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["iconHeight"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["spacing"] = 2,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["iconHeight"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["spacing"] = 2,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_1_spec_3"] = {
    ["characterName"] = "Warrior",
    ["createdAt"] = 1774005520,
    ["activeProfile"] = "Protection",
    ["layoutProfiles"] = {
    ["Protection"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769829400,
    ["savedPositions"] = {
    [79347] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["viewerType"] = "aura",
    },
    [79438] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["viewerType"] = "aura",
    },
    [18469] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    [59162] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [91985] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [79257] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["viewerType"] = "aura",
    },
    [91983] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [47907] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [18468] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [59387] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [79392] = {
    ["type"] = "group",
    ["col"] = 5,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    },
    ["freeIcons"] = {
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["showBorder"] = false,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["iconSize"] = 34,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 6,
    ["showBorder"] = false,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -18.907104492187,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["iconSize"] = 34,
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_1_spec_2"] = 1774803211,
    ["class_1_spec_1"] = 1774803211,
    ["class_1_spec_3"] = 1774803211,
    },
    ["lastActiveSpec"] = "class_1_spec_1",
    ["firstInitialized"] = 1774005516,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_1_spec_2"] = true,
    ["class_1_spec_1"] = true,
    ["class_1_spec_3"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["b"] = 1,
    ["g"] = 1,
    ["r"] = 1,
    },
    ["achStyle"] = "ants",
    ["achShowBurst"] = true,
    ["achLevel"] = 5,
    },
    },
    ["Druid - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["positions"] = {
    },
    ["trackedItems"] = {
    },
    ["autoTrackEquippedTrinkets"] = false,
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["b"] = 1,
    ["g"] = 1,
    ["r"] = 1,
    },
    ["achLevel"] = 5,
    ["achShowBurst"] = true,
    ["achStyle"] = "ants",
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["r"] = 0.95,
    ["g"] = 0.95,
    ["b"] = 0.32,
    },
    ["useCustomColor"] = false,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["r"] = 0.2,
    ["g"] = 0.6,
    ["b"] = 1,
    },
    ["txLeft"] = 0,
    ["useMasqueShapes"] = false,
    ["mode"] = "flash",
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["txTop"] = 0,
    ["txRight"] = 1,
    ["txBottom"] = 1,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_11_spec_3"] = {
    ["characterName"] = "Druid",
    ["createdAt"] = 1774006682,
    ["activeProfile"] = "Guardian",
    ["layoutProfiles"] = {
    ["Guardian"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769915162,
    ["savedPositions"] = {
    [175987] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [92608] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["sortIndex"] = 1,
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [2912] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [3168] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["sortIndex"] = 2,
    ["row"] = 2,
    ["viewerType"] = "aura",
    },
    [2321] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 0,
    },
    [3229] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [141029] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 4,
    },
    [2887] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [149268] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 1,
    ["col"] = 0,
    },
    [90206] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [2791] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["sortIndex"] = 2,
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    },
    ["freeIcons"] = {
    [2272] = {
    ["y"] = -175.00024414062,
    ["x"] = -603.66696166992,
    ["iconSize"] = 36,
    },
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    [2321] = {
    ["y"] = -37.000274658203,
    ["x"] = -703.00018310547,
    ["iconSize"] = 36,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_11_spec_1"] = {
    ["characterName"] = "Druid",
    ["createdAt"] = 1774006682,
    ["activeProfile"] = "Balance",
    ["layoutProfiles"] = {
    ["Balance"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769911424,
    ["savedPositions"] = {
    [152304] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [597] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 8,
    ["sortIndex"] = 8,
    },
    [323] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [526] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 6,
    ["sortIndex"] = 6,
    },
    [78] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [88309] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [88310] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [88516] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 5,
    ["col"] = 0,
    },
    [88342] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [301] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 5,
    ["sortIndex"] = 5,
    },
    [76] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [525] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 7,
    ["sortIndex"] = 7,
    },
    [88364] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [88366] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 9,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_11_spec_4"] = {
    ["characterName"] = "Druid",
    ["createdAt"] = 1774006681,
    ["layoutProfiles"] = {
    ["Restoration"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769913770,
    ["savedPositions"] = {
    [144997] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [145067] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    [150529] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 6,
    ["sortIndex"] = 6,
    },
    [145206] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 4,
    },
    [9185] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [9442] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 2,
    ["col"] = 0,
    },
    [144297] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [10447] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 5,
    ["sortIndex"] = 5,
    },
    [61884] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [90850] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [145475] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [166309] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Restoration",
    },
    ["class_11_spec_2"] = {
    ["characterName"] = "Druid",
    ["createdAt"] = 1774006682,
    ["activeProfile"] = "Feral",
    ["layoutProfiles"] = {
    ["Feral"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769851659,
    ["savedPositions"] = {
    [152137] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 4,
    },
    [1520] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [88291] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [71402] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [71403] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [1443] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [71512] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [1687] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [71357] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [1686] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_11_spec_3"] = 1774006913,
    ["class_11_spec_1"] = 1774006913,
    ["class_11_spec_4"] = 1774006913,
    ["class_11_spec_2"] = 1774006913,
    },
    ["lastActiveSpec"] = "class_11_spec_2",
    ["firstInitialized"] = 1774006678,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_11_spec_3"] = true,
    ["class_11_spec_1"] = true,
    ["class_11_spec_4"] = true,
    ["class_11_spec_2"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    },
    ["Priest - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["trackedItems"] = {
    },
    ["positions"] = {
    },
    ["autoTrackEquippedTrinkets"] = false,
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["b"] = 1,
    ["g"] = 1,
    ["r"] = 1,
    },
    ["achStyle"] = "ants",
    ["achShowBurst"] = true,
    ["achLevel"] = 5,
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["r"] = 0.95,
    ["g"] = 0.95,
    ["b"] = 0.32,
    },
    ["useCustomColor"] = false,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["r"] = 0.2,
    ["g"] = 0.6,
    ["b"] = 1,
    },
    ["txLeft"] = 0,
    ["useMasqueShapes"] = false,
    ["mode"] = "flash",
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["txTop"] = 0,
    ["txRight"] = 1,
    ["txBottom"] = 1,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_5_spec_1"] = {
    ["characterName"] = "Priest",
    ["createdAt"] = 1774007461,
    ["activeProfile"] = "Discipline",
    ["layoutProfiles"] = {
    ["Discipline"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769946477,
    ["savedPositions"] = {
    [77097] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [76933] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["viewerType"] = "aura",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [77099] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [145680] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    [56372] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [76939] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["viewerType"] = "aura",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [4136] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [76943] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [76946] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 5,
    ["col"] = 0,
    },
    [76932] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_5_spec_3"] = {
    ["characterName"] = "Priest",
    ["createdAt"] = 1774007461,
    ["activeProfile"] = "Shadow",
    ["layoutProfiles"] = {
    ["Shadow"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769945358,
    ["savedPositions"] = {
    [100167] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [11464] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 5,
    ["sortIndex"] = 5,
    },
    [108424] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [100172] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 1,
    },
    [149749] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 6,
    ["sortIndex"] = 6,
    },
    [108049] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [108102] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [150027] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [100177] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [100178] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [25741] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [25921] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 7,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 1,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 5,
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_5_spec_2"] = {
    ["characterName"] = "Priest",
    ["createdAt"] = 1774007460,
    ["layoutProfiles"] = {
    ["Holy"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769947308,
    ["savedPositions"] = {
    [75554] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 2,
    },
    [75000] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [75856] = {
    ["type"] = "group",
    ["col"] = 5,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 5,
    },
    [75857] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [75050] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["sortIndex"] = 1,
    ["row"] = 1,
    ["viewerType"] = "aura",
    },
    [5951] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [5322] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [29506] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    [74950] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [4815] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    [100100] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 4,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 6,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -18.907104492187,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Holy",
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_5_spec_1"] = 1774007525,
    ["class_5_spec_3"] = 1774007525,
    ["class_5_spec_2"] = 1774007525,
    },
    ["lastActiveSpec"] = "class_5_spec_3",
    ["firstInitialized"] = 1774007457,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_5_spec_1"] = true,
    ["class_5_spec_3"] = true,
    ["class_5_spec_2"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    },
    ["DeathKnight - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = false,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["autoTrackEquippedTrinkets"] = false,
    ["positions"] = {
    },
    ["trackedItems"] = {
    ["arc_item_230641"] = {
    ["enabled"] = true,
    ["type"] = "item",
    ["itemID"] = 230641,
    ["isAutoTrackSlot"] = false,
    ["hideWhenUnequipped"] = false,
    ["isPassive"] = false,
    },
    ["arc_item_230639"] = {
    ["enabled"] = true,
    ["type"] = "item",
    ["itemID"] = 230639,
    ["isAutoTrackSlot"] = false,
    ["hideWhenUnequipped"] = false,
    ["isPassive"] = true,
    },
    },
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achStyle"] = "ants",
    ["achLevel"] = 5,
    ["achShowBurst"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["r"] = 1,
    ["g"] = 1,
    ["b"] = 1,
    },
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["b"] = 0.32,
    ["g"] = 0.95,
    ["r"] = 0.95,
    },
    ["txBottom"] = 1,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["b"] = 1,
    ["g"] = 0.6,
    ["r"] = 0.2,
    },
    ["txRight"] = 1,
    ["useMasqueShapes"] = false,
    ["txTop"] = 0,
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["mode"] = "flash",
    ["txLeft"] = 0,
    ["useCustomColor"] = false,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_6_spec_1"] = {
    ["characterName"] = "DeathKnight",
    ["createdAt"] = 1773180055,
    ["activeProfile"] = "Blood",
    ["layoutProfiles"] = {
    ["Blood"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769835240,
    ["savedPositions"] = {
    [50002] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["viewerType"] = "aura",
    },
    [92534] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [9126] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [133836] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["viewerType"] = "aura",
    },
    [92535] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [9153] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    ["arc_item_230639"] = {
    ["y"] = 150,
    ["x"] = -50,
    ["iconSize"] = 36,
    ["type"] = "free",
    },
    [92533] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [9039] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["viewerType"] = "aura",
    },
    [90610] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [148430] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["viewerType"] = "aura",
    },
    ["arc_item_230641"] = {
    ["y"] = 150,
    ["x"] = 0,
    ["iconSize"] = 36,
    ["type"] = "free",
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_6_spec_2"] = {
    ["characterName"] = "DeathKnight",
    ["createdAt"] = 1773180055,
    ["activeProfile"] = "Frost",
    ["layoutProfiles"] = {
    ["Frost"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769835123,
    ["savedPositions"] = {
    [27650] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [92575] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [104640] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [86136] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [92573] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [27648] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [27652] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [92576] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_6_spec_3"] = {
    ["characterName"] = "DeathKnight",
    ["createdAt"] = 1773179852,
    ["layoutProfiles"] = {
    ["Unholy"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769834923,
    ["savedPositions"] = {
    ["arc_item_230639"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["x"] = -50,
    ["iconSize"] = 36,
    },
    [141686] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [92913] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [155151] = {
    ["target"] = "Defensives",
    ["type"] = "group",
    ["row"] = 0,
    ["col"] = 4,
    },
    [70805] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [70806] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [27925] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [103071] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    ["arc_item_230641"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["x"] = 0,
    ["iconSize"] = 36,
    },
    [27922] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 2,
    ["col"] = 0,
    },
    [92923] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["viewerType"] = "aura",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    },
    ["freeIcons"] = {
    ["arc_item_230639"] = {
    ["y"] = 150,
    ["x"] = -50,
    ["iconSize"] = 36,
    },
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    ["arc_item_230641"] = {
    ["y"] = 150,
    ["x"] = 0,
    ["iconSize"] = 36,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Unholy",
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_6_spec_3"] = 1774007559,
    ["class_6_spec_2"] = 1774007559,
    ["class_6_spec_1"] = 1774007559,
    },
    ["lastActiveSpec"] = "class_6_spec_3",
    ["firstInitialized"] = 1773179852,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["sharedSyncDisabled"] = {
    },
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_6_spec_1"] = true,
    ["class_6_spec_2"] = true,
    ["class_6_spec_3"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    },
    ["Rogue - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["autoTrackEquippedTrinkets"] = false,
    ["trackedItems"] = {
    },
    ["positions"] = {
    },
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achLevel"] = 5,
    ["achStyle"] = "ants",
    ["achShowBurst"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["r"] = 1,
    ["g"] = 1,
    ["b"] = 1,
    },
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["b"] = 0.32,
    ["g"] = 0.95,
    ["r"] = 0.95,
    },
    ["txBottom"] = 1,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["b"] = 1,
    ["g"] = 0.6,
    ["r"] = 0.2,
    },
    ["txRight"] = 1,
    ["useMasqueShapes"] = false,
    ["txTop"] = 0,
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["mode"] = "flash",
    ["txLeft"] = 0,
    ["useCustomColor"] = false,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_4_spec_1"] = {
    ["characterName"] = "Rogue",
    ["createdAt"] = 1774006931,
    ["layoutProfiles"] = {
    ["Assassination"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769833450,
    ["savedPositions"] = {
    [105492] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [35257] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 6,
    ["col"] = 0,
    },
    [92992] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [42046] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    ["arc_trinket_14"] = {
    ["y"] = 158,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -63,
    },
    [92973] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    [31044] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 158,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -105,
    },
    [92991] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [35224] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 5,
    ["col"] = 0,
    },
    [92993] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [31334] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [107200] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 4,
    },
    [105493] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [104957] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["showBorder"] = false,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["iconSize"] = 34,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["showBorder"] = false,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["iconSize"] = 34,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Assassination",
    },
    ["class_4_spec_3"] = {
    ["characterName"] = "Rogue",
    ["createdAt"] = 1774006931,
    ["activeProfile"] = "Subtlety",
    ["layoutProfiles"] = {
    ["Subtlety"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769833995,
    ["savedPositions"] = {
    [92865] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [92866] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [36647] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 6,
    ["col"] = 0,
    },
    [36970] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    [42633] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 5,
    ["sortIndex"] = 5,
    },
    [92871] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [92872] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [92873] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [31518] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [36827] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 2,
    ["col"] = 0,
    },
    [44087] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    },
    ["class_4_spec_2"] = {
    ["characterName"] = "Rogue",
    ["createdAt"] = 1774006931,
    ["layoutProfiles"] = {
    ["Outlaw"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["position"] = {
    },
    ["procGlow"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769833731,
    ["savedPositions"] = {
    [112602] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [93044] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [93045] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [11858] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    [113748] = {
    ["type"] = "group",
    ["col"] = 4,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 4,
    },
    [42743] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [43579] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [41689] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 6,
    ["sortIndex"] = 6,
    },
    [93046] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [41750] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 5,
    ["sortIndex"] = 5,
    },
    [11873] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [90341] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    [41569] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 7,
    ["gridCols"] = 1,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["gridCols"] = 5,
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["showBackground"] = false,
    ["iconHeight"] = 34,
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["dynamicLayout"] = true,
    ["autoReflow"] = true,
    ["visibility"] = "always",
    ["showBorder"] = false,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Outlaw",
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_4_spec_1"] = 1774007009,
    ["class_4_spec_2"] = 1774007009,
    ["class_4_spec_3"] = 1774007009,
    },
    ["lastActiveSpec"] = "class_4_spec_1",
    ["firstInitialized"] = 1774006928,
    ["showBorderInEditMode"] = true,
    ["showPlaceholders"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_4_spec_1"] = true,
    ["class_4_spec_2"] = true,
    ["class_4_spec_3"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    },
    ["Paladin - Realm"] = {
    ["arcAuras"] = {
    ["enabled"] = true,
    ["autoTrackSlots"] = {
    [13] = true,
    [14] = true,
    },
    ["trackedSpells"] = {
    },
    ["globalSettings"] = {
    },
    ["onlyOnUseTrinkets"] = false,
    ["positions"] = {
    },
    ["trackedItems"] = {
    },
    ["autoTrackEquippedTrinkets"] = false,
    },
    ["achSettings"] = {
    ["achOnArcAuras"] = false,
    ["achStrata"] = "INHERIT",
    ["achCombatOnly"] = false,
    ["assistedCombatHighlight"] = false,
    ["achAlwaysAnimate"] = false,
    ["achScale"] = 1,
    ["_migrated"] = true,
    ["achColor"] = {
    ["a"] = 1,
    ["b"] = 1,
    ["g"] = 1,
    ["r"] = 1,
    },
    ["achLevel"] = 5,
    ["achShowBurst"] = true,
    ["achStyle"] = "ants",
    },
    ["bphSettings"] = {
    ["enabled"] = false,
    ["textureType"] = 1,
    ["color"] = {
    ["a"] = 0.45,
    ["r"] = 0.95,
    ["g"] = 0.95,
    ["b"] = 0.32,
    },
    ["useCustomColor"] = false,
    ["flashDuration"] = 0.1,
    ["customColor"] = {
    ["a"] = 0.5,
    ["r"] = 0.2,
    ["g"] = 0.6,
    ["b"] = 1,
    },
    ["txLeft"] = 0,
    ["useMasqueShapes"] = false,
    ["mode"] = "flash",
    ["customTexture"] = "",
    ["onArcAuras"] = false,
    ["txTop"] = 0,
    ["txRight"] = 1,
    ["txBottom"] = 1,
    },
    ["bars"] = {
    },
    ["cdmGroups"] = {
    ["enabled"] = true,
    ["showControlButtons"] = true,
    ["specData"] = {
    ["class_2_spec_1"] = {
    ["layoutProfiles"] = {
    ["Holy"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769830456,
    ["savedPositions"] = {
    [61409] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [90509] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [92820] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [92822] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [61075] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 3,
    ["col"] = 0,
    },
    [92819] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = 0,
    },
    ["arc_trinket_14"] = {
    ["y"] = 150,
    ["type"] = "free",
    ["viewerType"] = "cooldown",
    ["iconSize"] = 36,
    ["x"] = -50,
    },
    [29268] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 1,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 5,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["createdAt"] = 1774007579,
    ["activeProfile"] = "Holy",
    },
    ["class_2_spec_3"] = {
    ["characterName"] = "Paladin",
    ["createdAt"] = 1774007578,
    ["layoutProfiles"] = {
    ["Retribution"] = {
    ["iconSettings"] = {
    },
    ["createdAt"] = 1769830204,
    ["savedPositions"] = {
    [96973] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    [109337] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    [92839] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [68661] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["sortIndex"] = 0,
    ["row"] = 0,
    ["viewerType"] = "aura",
    },
    [92843] = {
    ["type"] = "group",
    ["col"] = 3,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 3,
    },
    [69174] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 1,
    ["sortIndex"] = 1,
    },
    [85121] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["sortIndex"] = 2,
    ["row"] = 2,
    ["viewerType"] = "aura",
    },
    [19387] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 4,
    ["col"] = 0,
    },
    [92837] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 5,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 1,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["gridRows"] = 1,
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 5,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["activeProfile"] = "Retribution",
    },
    ["class_2_spec_2"] = {
    ["layoutProfiles"] = {
    ["Protection"] = {
    ["iconSettings"] = {
    ["19387"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    ["68661"] = {
    ["rangeIndicator"] = {
    },
    ["cooldownText"] = {
    },
    ["cooldownStateVisuals"] = {
    ["readyState"] = {
    ["glow"] = true,
    },
    ["cooldownState"] = {
    },
    },
    ["alertEvents"] = {
    ["onChargeGained"] = {
    },
    ["onAvailable"] = {
    },
    ["onPandemic"] = {
    },
    ["onUnavailable"] = {
    },
    },
    ["border"] = {
    },
    ["cooldownSwipe"] = {
    },
    ["procGlow"] = {
    },
    ["position"] = {
    },
    ["chargeText"] = {
    },
    ["auraActiveState"] = {
    },
    },
    },
    ["createdAt"] = 1769830045,
    ["savedPositions"] = {
    [90192] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 2,
    ["sortIndex"] = 2,
    },
    [30075] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 4,
    ["sortIndex"] = 4,
    },
    [92835] = {
    ["type"] = "group",
    ["col"] = 1,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 1,
    },
    ["arc_trinket_14"] = {
    ["y"] = 200,
    ["type"] = "free",
    ["x"] = -21,
    ["iconSize"] = 36,
    },
    [12425] = {
    ["type"] = "group",
    ["col"] = 2,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 2,
    },
    [58913] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    ["arc_trinket_13"] = {
    ["y"] = 200,
    ["type"] = "free",
    ["x"] = 63,
    ["iconSize"] = 36,
    },
    [12431] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Defensives",
    ["row"] = 0,
    ["sortIndex"] = 0,
    },
    [58806] = {
    ["target"] = "Offensives",
    ["type"] = "group",
    ["row"] = 1,
    ["col"] = 0,
    },
    [30705] = {
    ["type"] = "group",
    ["col"] = 0,
    ["target"] = "Offensives",
    ["row"] = 3,
    ["sortIndex"] = 3,
    },
    },
    ["freeIcons"] = {
    [111052] = {
    ["y"] = 147.6184387207,
    ["x"] = -12.877807617188,
    ["iconSize"] = 34,
    },
    },
    ["groupLayouts"] = {
    ["Offensives"] = {
    ["horizontalGrowth"] = "RIGHT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 5,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.89203898112,
    ["x"] = 100.27258300781,
    },
    ["verticalGrowth"] = "UP",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 1,
    },
    ["Defensives"] = {
    ["horizontalGrowth"] = "LEFT",
    ["containerPadding"] = 0,
    ["bgColor"] = {
    ["a"] = 0.6,
    ["b"] = 0,
    ["g"] = 0,
    ["r"] = 0,
    },
    ["gridRows"] = 1,
    ["borderColor"] = {
    ["a"] = 1,
    ["b"] = 0.3,
    ["g"] = 0.8,
    ["r"] = 0.3,
    },
    ["iconSize"] = 34,
    ["lockGridSize"] = true,
    ["frameLevel"] = 1,
    ["iconWidth"] = 34,
    ["showBorder"] = false,
    ["spacing"] = 2,
    ["frameStrata"] = "MEDIUM",
    ["autoReflow"] = true,
    ["position"] = {
    ["y"] = -47.893615722656,
    ["x"] = -1.8515489366319,
    },
    ["verticalGrowth"] = "DOWN",
    ["alignment"] = "center",
    ["iconHeight"] = 34,
    ["dynamicLayout"] = true,
    ["showBackground"] = false,
    ["visibility"] = "always",
    ["gridCols"] = 5,
    },
    },
    ["matchMode"] = "all",
    },
    },
    ["createdAt"] = 1774007579,
    ["activeProfile"] = "Protection",
    },
    },
    ["masqueSettings"] = {
    },
    ["sharedSyncTimestamp"] = {
    ["class_2_spec_1"] = 1774007601,
    ["class_2_spec_3"] = 1774007601,
    ["class_2_spec_2"] = 1774007601,
    },
    ["lastActiveSpec"] = "class_2_spec_3",
    ["firstInitialized"] = 1774007575,
    ["showBorderInEditMode"] = true,
    ["clickThrough"] = true,
    ["migratedProfileIconSettings"] = true,
    ["sharedSync"] = {
    ["class_2_spec_1"] = true,
    ["class_2_spec_3"] = true,
    ["class_2_spec_2"] = true,
    },
    ["specInheritedFrom"] = {
    },
    ["disableTooltips"] = true,
    },
    ["cooldownBarSetup"] = {
    ["hiddenSpells"] = {
    },
    ["manualSpells"] = {
    },
    ["activeCooldowns"] = {
    },
    ["activeResources"] = {
    },
    ["activeCharges"] = {
    },
    },
    },
    },
    ["profileKeys"] = {
    ["Warlock - Realm"] = "Default",
    ["Monk - Realm"] = "Default",
    ["DemonHunter - Realm"] = "Default",
    ["Shaman - Realm"] = "Default",
    ["Hunter - Realm"] = "Default",
    ["Evoker - Realm"] = "Default",
    ["Mage - Realm"] = "Default",
    ["Warrior - Realm"] = "Default",
    ["Druid - Realm"] = "Default",
    ["Priest - Realm"] = "Default",
    ["DeathKnight - Realm"] = "Default",
    ["Rogue - Realm"] = "Default",
    ["Paladin - Realm"] = "Default",
    },
    ["global"] = {
    ["sharedSyncDisabled"] = {
    },
    ["migratedDefaultNames"] = true,
    ["minimap"] = {
    ["minimapPos"] = 82.55620346503996,
    },
    ["sharedProfiles"] = {
    ["class_7_spec_1"] = {
    ["timestamp"] = 1774006040,
    ["sourceChar"] = "Shaman - Realm",
    ["profileName"] = "Elemental",
    },
    ["class_6_spec_3"] = {
    ["timestamp"] = 1774007559,
    ["sourceChar"] = "DeathKnight - Realm",
    ["profileName"] = "Unholy",
    },
    ["class_7_spec_3"] = {
    ["timestamp"] = 1774006040,
    ["sourceChar"] = "Shaman - Realm",
    ["profileName"] = "Restoration",
    },
    ["class_1_spec_1"] = {
    ["timestamp"] = 1774803211,
    ["profileName"] = "Arms",
    ["sourceChar"] = "Warrior - Realm",
    },
    ["class_8_spec_2"] = {
    ["timestamp"] = 1774007443,
    ["sourceChar"] = "Mage - Realm",
    ["profileName"] = "Fire",
    },
    ["class_10_spec_2"] = {
    ["timestamp"] = 1774007114,
    ["sourceChar"] = "Monk - Realm",
    ["profileName"] = "Mistweaver",
    },
    ["class_11_spec_2"] = {
    ["timestamp"] = 1774006913,
    ["profileName"] = "Feral",
    ["sourceChar"] = "Druid - Realm",
    },
    ["class_13_spec_2"] = {
    ["timestamp"] = 1774006283,
    ["profileName"] = "Preservation",
    ["sourceChar"] = "Evoker - Realm",
    },
    ["class_11_spec_3"] = {
    ["timestamp"] = 1774006913,
    ["profileName"] = "Guardian",
    ["sourceChar"] = "Druid - Realm",
    },
    ["class_6_spec_2"] = {
    ["timestamp"] = 1774007559,
    ["sourceChar"] = "DeathKnight - Realm",
    ["profileName"] = "Frost",
    },
    ["class_4_spec_3"] = {
    ["timestamp"] = 1774007009,
    ["sourceChar"] = "Rogue - Realm",
    ["profileName"] = "Subtlety",
    },
    ["class_13_spec_1"] = {
    ["timestamp"] = 1774006283,
    ["profileName"] = "Devastation",
    ["sourceChar"] = "Evoker - Realm",
    },
    ["class_12_spec_1"] = {
    ["timestamp"] = 1774006664,
    ["sourceChar"] = "DemonHunter - Realm",
    ["profileName"] = "Havoc",
    },
    ["class_2_spec_3"] = {
    ["timestamp"] = 1774007601,
    ["profileName"] = "Retribution",
    ["sourceChar"] = "Paladin - Realm",
    },
    ["class_2_spec_2"] = {
    ["timestamp"] = 1774007601,
    ["profileName"] = "Protection",
    ["sourceChar"] = "Paladin - Realm",
    },
    ["class_2_spec_1"] = {
    ["timestamp"] = 1774007601,
    ["profileName"] = "Holy",
    ["sourceChar"] = "Paladin - Realm",
    },
    ["class_9_spec_1"] = {
    ["timestamp"] = 1774007225,
    ["profileName"] = "Affliction",
    ["sourceChar"] = "Warlock - Realm",
    },
    ["class_3_spec_2"] = {
    ["timestamp"] = 1774006179,
    ["sourceChar"] = "Hunter - Realm",
    ["profileName"] = "Marksmanship",
    },
    ["class_11_spec_4"] = {
    ["timestamp"] = 1774006913,
    ["profileName"] = "Restoration",
    ["sourceChar"] = "Druid - Realm",
    },
    ["class_3_spec_3"] = {
    ["timestamp"] = 1774006179,
    ["sourceChar"] = "Hunter - Realm",
    ["profileName"] = "Survival",
    },
    ["class_10_spec_3"] = {
    ["timestamp"] = 1774007114,
    ["sourceChar"] = "Monk - Realm",
    ["profileName"] = "Windwalker",
    },
    ["class_12_spec_2"] = {
    ["timestamp"] = 1774006664,
    ["sourceChar"] = "DemonHunter - Realm",
    ["profileName"] = "Vengeance",
    },
    ["class_10_spec_1"] = {
    ["timestamp"] = 1774007114,
    ["sourceChar"] = "Monk - Realm",
    ["profileName"] = "Brewmaster",
    },
    ["class_7_spec_2"] = {
    ["timestamp"] = 1774006040,
    ["sourceChar"] = "Shaman - Realm",
    ["profileName"] = "Enhancement",
    },
    ["class_9_spec_2"] = {
    ["timestamp"] = 1774007225,
    ["profileName"] = "Demonology",
    ["sourceChar"] = "Warlock - Realm",
    },
    ["class_13_spec_3"] = {
    ["timestamp"] = 1774006283,
    ["profileName"] = "Augmentation",
    ["sourceChar"] = "Evoker - Realm",
    },
    ["class_8_spec_3"] = {
    ["timestamp"] = 1774007443,
    ["sourceChar"] = "Mage - Realm",
    ["profileName"] = "Frost",
    },
    ["class_6_spec_1"] = {
    ["timestamp"] = 1774007559,
    ["sourceChar"] = "DeathKnight - Realm",
    ["profileName"] = "Blood",
    },
    ["class_5_spec_1"] = {
    ["timestamp"] = 1774007525,
    ["profileName"] = "Discipline",
    ["sourceChar"] = "Priest - Realm",
    },
    ["class_3_spec_1"] = {
    ["timestamp"] = 1774006179,
    ["sourceChar"] = "Hunter - Realm",
    ["profileName"] = "Beast Mastery",
    },
    ["class_1_spec_2"] = {
    ["timestamp"] = 1774803211,
    ["profileName"] = "Fury",
    ["sourceChar"] = "Warrior - Realm",
    },
    ["class_4_spec_2"] = {
    ["timestamp"] = 1774007009,
    ["sourceChar"] = "Rogue - Realm",
    ["profileName"] = "Outlaw",
    },
    ["class_1_spec_3"] = {
    ["timestamp"] = 1774803211,
    ["profileName"] = "Protection",
    ["sourceChar"] = "Warrior - Realm",
    },
    ["class_11_spec_1"] = {
    ["timestamp"] = 1774006913,
    ["profileName"] = "Balance",
    ["sourceChar"] = "Druid - Realm",
    },
    ["class_12_spec_3"] = {
    ["timestamp"] = 1774006664,
    ["sourceChar"] = "DemonHunter - Realm",
    ["profileName"] = "Devourer",
    },
    ["class_5_spec_2"] = {
    ["timestamp"] = 1774007525,
    ["profileName"] = "Holy",
    ["sourceChar"] = "Priest - Realm",
    },
    ["class_4_spec_1"] = {
    ["timestamp"] = 1774007009,
    ["sourceChar"] = "Rogue - Realm",
    ["profileName"] = "Assassination",
    },
    ["class_9_spec_3"] = {
    ["timestamp"] = 1774007225,
    ["profileName"] = "Destruction",
    ["sourceChar"] = "Warlock - Realm",
    },
    ["class_8_spec_1"] = {
    ["timestamp"] = 1774007443,
    ["sourceChar"] = "Mage - Realm",
    ["profileName"] = "Arcane",
    },
    ["class_5_spec_3"] = {
    ["timestamp"] = 1774007525,
    ["profileName"] = "Shadow",
    ["sourceChar"] = "Priest - Realm",
    },
    },
    ["groupLayouts"] = {
    },
    ["optionsPanelSize"] = {
    ["height"] = 654.6663818359375,
    ["width"] = 823.3338623046875,
    },
    ["optionsPanelPos"] = {
    ["top"] = 915.33447265625,
    ["left"] = 690.666015625,
    },
    },
    ["profiles"] = {
    ["Default"] = {
    ["groupTemplates"] = {
    ["Default"] = {
    ["createdAt"] = 1773179852,
    ["description"] = "Default 3-group layout (Buffs, Essential, Utility)",
    ["displayName"] = "Default",
    ["groups"] = {
    ["Buffs"] = {
    ["gridCols"] = 4,
    ["lockGridSize"] = false,
    ["iconWidth"] = 36,
    ["showBackground"] = false,
    ["containerPadding"] = 0,
    ["iconSize"] = 36,
    ["position"] = {
    ["y"] = 200,
    ["x"] = 0,
    },
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["iconHeight"] = 36,
    ["gridRows"] = 2,
    ["spacing"] = 2,
    ["showBorder"] = false,
    ["autoReflow"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.8,
    ["b"] = 0.3,
    },
    },
    ["Essential"] = {
    ["gridCols"] = 4,
    ["lockGridSize"] = false,
    ["iconWidth"] = 36,
    ["showBackground"] = false,
    ["containerPadding"] = 0,
    ["iconSize"] = 36,
    ["position"] = {
    ["y"] = 100,
    ["x"] = 0,
    },
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["iconHeight"] = 36,
    ["gridRows"] = 2,
    ["spacing"] = 2,
    ["showBorder"] = false,
    ["autoReflow"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.8,
    ["g"] = 0.6,
    ["b"] = 0.2,
    },
    },
    ["Utility"] = {
    ["gridCols"] = 4,
    ["lockGridSize"] = false,
    ["iconWidth"] = 36,
    ["showBackground"] = false,
    ["containerPadding"] = 0,
    ["iconSize"] = 36,
    ["position"] = {
    ["y"] = 0,
    ["x"] = 0,
    },
    ["bgColor"] = {
    ["a"] = 0.6,
    ["r"] = 0,
    ["g"] = 0,
    ["b"] = 0,
    },
    ["iconHeight"] = 36,
    ["gridRows"] = 2,
    ["spacing"] = 2,
    ["showBorder"] = false,
    ["autoReflow"] = false,
    ["visibility"] = "always",
    ["borderColor"] = {
    ["a"] = 1,
    ["r"] = 0.3,
    ["g"] = 0.6,
    ["b"] = 0.9,
    },
    },
    },
    ["createdBy"] = "System",
    },
    },
    ["cdmEnhance"] = {
    ["globalAuraSettings"] = {
    ["cooldownStateVisuals"] = {
    ["cooldownState"] = {
    ["alpha"] = 0,
    },
    },
    ["cooldownText"] = {
    ["size"] = 13,
    },
    ["cooldownSwipe"] = {
    ["reverse"] = true,
    ["showSwipe"] = true,
    },
    ["chargeText"] = {
    ["offsetY"] = 0,
    ["offsetX"] = 0,
    ["size"] = 9,
    },
    },
    ["globalCooldownSettings"] = {
    ["rangeIndicator"] = {
    ["enabled"] = false,
    },
    ["border"] = {
    ["enabled"] = true,
    ["color"] = {
    0,
    0,
    0,
    1,
    },
    ["inset"] = 0,
    ["thickness"] = 1,
    },
    ["cooldownSwipe"] = {
    ["noGCDSwipe"] = true,
    },
    ["hideShadow"] = true,
    },
    ["settingsVersion"] = 7,
    ["_firstTimeDefaultsApplied"] = true,
    ["lockGridSize"] = false,
    ["disableRightClickSelect"] = false,
    },
    ["cdmGroups"] = {
    ["containerSync"] = {
    ["Buffs"] = true,
    ["Essential"] = true,
    ["Utility"] = true,
    },
    ["initializedCharacters"] = {
    ["Druid-Realm"] = true,
    ["Shaman-Realm"] = true,
    ["DeathKnight-Realm"] = true,
    ["Hunter-Realm"] = true,
    ["Warrior-Realm"] = true,
    ["Paladin-Realm"] = true,
    ["Warlock-Realm"] = true,
    ["Rogue-Realm"] = true,
    ["Evoker-Realm"] = true,
    ["Priest-Realm"] = true,
    ["Monk-Realm"] = true,
    ["Mage-Realm"] = true,
    ["DemonHunter-Realm"] = true,
    },
    },
    ["cdmSetupMigrationVersion"] = 1,
    },
    },
    }

    local charProfile = scArcUIDB["char"][GetClassRealmString()]
    scArcUIDB["char"][SC:GetPlayerNameAndRealm()] = charProfile
    scArcUIDB["profileKeys"][SC:GetPlayerNameAndRealm()] = "Default"
    scArcUIDB["profiles"]["Default"]["cdmGroups"]["initializedCharacters"][SC:GetPlayerNameAndRealmNoSpace()] = true

    if not SkillCappedBackupDB.ArcUIDB then
        SkillCappedBackupDB.ArcUIDB = SC:DeepCopy(ArcUIDB)
        SkillCappedBackupDB.addonBackupTimes["ArcUI"] = SC:GetDateAndTime()
    end

    ArcUIDB = scArcUIDB

    C_CVar.SetCVar("cooldownViewerEnabled", "1")

    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_LOGOUT")
    f:SetScript("OnEvent", function()
        ArcUIDB = scArcUIDB
    end)
end

function SC:UpdateArcUIProfile()
    -- if not ArcUIDB then return end
    -- local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    -- ArcUIDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    -- for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
    --     ArcUIDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    -- end
end