local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:BetterBlizzPlatesDB()
    local scBetterBlizzPlatesDB = {
        ["npBgColorRGB"] = {
        1,
        1,
        1,
        1,
        },
        ["classIndicatorFriendlyScale"] = 1,
        ["otherNpdeBuffFilterCC"] = false,
        ["doNotHideFriendlyHealthbarInPve"] = false,
        ["hideNPCArenaOnly"] = false,
        ["nameplateKeyAuraScale"] = 1,
        ["NamePlateClassificationScale"] = 1,
        ["hideNPCHideSecondaryPets"] = true,
        ["nameplateSelfWidth"] = 110,
        ["auraColor"] = false,
        ["totemListUpdateMop1"] = true,
        ["nameplatePlayerLargerScale"] = 1.8,
        ["friendlyNpBuffFilterLessMinite"] = false,
        ["otherNpdeBuffFilterWatchList"] = true,
        ["castBarInterruptHighlighterColorDontInterrupt"] = false,
        ["enableNameplateAuraCustomisation"] = true,
        ["customTextureFriendly"] = "Dragonflight (BBP)",
        ["classIndicatorXPos"] = 0,
        ["partyPointer"] = true,
        ["hideCastbarWhitelist"] = {
        },
        ["colorNPCName"] = false,
        ["questIndicatorTestMode"] = false,
        ["targetIndicatorYPos"] = 0,
        ["executeIndicatorScale"] = 1,
        ["healerIndicatorRedCrossEnemy"] = false,
        ["focusTargetIndicatorTexture"] = "Shattered DF (BBP)",
        ["defaultFadeOutNPCsList"] = {
        {
        ["id"] = 24207,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Army of the Dead",
        ["comment"] = "",
        },
        {
        ["id"] = 62005,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Beast (Hunter)",
        ["comment"] = "",
        },
        {
        ["id"] = 136408,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Darkhound",
        ["comment"] = "",
        },
        {
        ["id"] = 105419,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Dire Basilisk (Hunter)",
        ["comment"] = "",
        },
        {
        ["id"] = 26125,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "DK pet",
        ["comment"] = "",
        },
        {
        ["id"] = 95072,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Earth Elemental (Shaman)",
        ["comment"] = "",
        },
        {
        ["id"] = 136398,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Illidari Satyr",
        ["comment"] = "",
        },
        {
        ["id"] = 163366,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Magus(Army of the Dead)",
        ["comment"] = "",
        },
        {
        ["id"] = 31216,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mirror Images (Mage)",
        ["comment"] = "",
        },
        {
        ["id"] = 29264,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Spirit Wolves (Enha Shaman)",
        ["comment"] = "",
        },
        {
        ["id"] = 54983,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Treant",
        ["comment"] = "",
        },
        {
        ["id"] = 192337,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Void Tendril (Spriest)",
        ["comment"] = "",
        },
        {
        ["id"] = 136403,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Void Terror",
        ["comment"] = "",
        },
        },
        ["friendlyClassColorName"] = false,
        ["castbarAlwaysOnTop"] = false,
        ["enemyNeutralHealthBarColorRGB"] = {
        1,
        1,
        0,
        },
        ["targetIndicatorScale"] = 1,
        ["changeNameplateBorderColor"] = false,
        ["disableCompactedAurasOnSelf"] = true,
        ["old_defaultLargeFontSize"] = 12,
        ["questIndicatorAnchor"] = "LEFT",
        ["otherNpBuffFilterPurgeable"] = false,
        ["otherNpdeBuffEnable"] = true,
        ["scStart"] = true,
        ["healthNumbersFriendly"] = false,
        ["combatIndicatorXPos"] = 0,
        ["friendlyNpdeBuffFilterWatchList"] = false,
        ["auraWhitelistColorsUpdated"] = true,
        ["hideCastbarList"] = {
        },
        ["nameplateAurasEnemyCenteredAnchor"] = false,
        ["classIndicatorScale"] = 1,
        ["hpHeightSelfMana"] = 10.8,
        ["showNpcTitle"] = false,
        ["partyPointerCCAuras"] = true,
        ["arenaIdAnchor"] = "TOP",
        ["importantCCDisarm"] = true,
        ["hideNameplateAuraTooltip"] = false,
        ["mopUpdated"] = true,
        ["nameplateAurasPersonalYPos"] = 0,
        ["castBarNoninterruptibleColor"] = {
        0.4,
        0.4,
        0.4,
        },
        ["npAuraDiseaseRGB"] = {
        1,
        0.53,
        0.14,
        },
        ["healthNumbersUseMillions"] = false,
        ["focusTargetIndicatorTestMode"] = false,
        ["disableCVarForceOnLogin"] = false,
        ["old_defaultFontSize"] = 9,
        ["partyIndicatorModeThree"] = false,
        ["importantBuffsDefensives"] = true,
        ["partyPointerUpdated"] = true,
        ["absorbIndicator"] = false,
        ["arenaIndicatorModeOff"] = false,
        ["nameplateAuraRightToLeft"] = false,
        ["nameplateOverlapHScale"] = 0.8,
        ["nameplateShowEnemyGuardians"] = "1",
        ["castBarEmphasisSparkHeight"] = 35,
        ["nameplateAurasXPosXPos"] = 0,
        ["nameplateEnemyHeight"] = 32,
        ["targetIndicatorChangeTexture"] = false,
        ["nameplateAurasYPos"] = -10,
        ["castBarEmphasisColor"] = false,
        ["petIndicatorHideSecondaryPets"] = true,
        ["nameplateShowFriendlyTotems"] = "0",
        ["nameplateAurasNoNameYPos"] = 0,
        ["classIconReactionBorder"] = false,
        ["questIndicatorYPos"] = 0,
        ["bgIndicatorShowOrbs"] = true,
        ["enemyHealthBarColor"] = false,
        ["nameplateShowFriendlyMinions"] = "0",
        ["arenaIdXPos"] = 0,
        ["friendlyNameplatesOnlyInBgs"] = false,
        ["arenaIndicatorModeThree"] = false,
        ["hideNPCsWhitelist"] = {
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 104818,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Ancestral Protection Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 61245,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Capacitor Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 78001,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Cloudburst Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 105451,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Counterstrike Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 2630,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Earthbind Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 100943,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Earthen Wall Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 60561,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Earthgrab Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 179193,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Fel Obelisk (Warlock)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 17252,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Felguard (Demo Pet)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 417,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Felhunter (Warlock)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 5925,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Grounding Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 114565,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Guardian Queen (prot pala)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 3527,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Healing Stream Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 59764,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Healing Tide Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 165189,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Hunter Pet (they all have same ID)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 89,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Infernal (Warlock)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 97369,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Liquid Magma Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 10467,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mana Tide Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 62982,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mindbender",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 69792,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Monk Image (Green)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 69791,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Monk Image (Red)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 107100,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Observer (Warlock)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 185800,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Past Self (Evoker)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 5923,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Poison Cleansing Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 101398,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Psyfiend (Spriest)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 225672,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shadow (Priest Re-Fear)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 19668,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Shadowfiend",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 105427,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Skyfury Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 53006,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Spirit Link Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 179867,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Static Field Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 59712,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Stone Bulwark Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 194117,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Stoneskin Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 1863,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Succubus (Warlock)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 225409,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Surging Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 194118,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Tranquil Air Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 5913,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Tremor Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 135002,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Tyrant (Warlock)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 224466,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Voidwrath (Priest)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 119052,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "War Banner",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 97285,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Wind Rush Totem",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 6112,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Windfury Totem",
        },
        },
        ["castBarTextScale"] = 1,
        ["otherNpdeBuffFilterAll"] = false,
        ["colorNPC"] = false,
        ["classIndicatorAnchor"] = "TOP",
        ["druidAlwaysShowCombos"] = false,
        ["healthNumbersXPos"] = 0,
        ["arenaSpecAnchor"] = "TOP",
        ["questIndicator"] = true,
        ["nameplateFriendlyHeight"] = 32,
        ["partySpecScale"] = 1,
        ["nameplateMinScale"] = 0.9,
        ["otherNpBuffEmphasisedBorder"] = false,
        ["personalNpBuffFilterImportantBuffs"] = false,
        ["castBarIconScale"] = 1,
        ["nameplateShowFriendlyGuardians"] = "0",
        ["totemIndicatorHideNameAndShiftIconDown"] = false,
        ["nameplateAuraKeyAuraPositionFriendly"] = false,
        ["nameplateAuraRowAmount"] = 6,
        ["dpsOrHealNoAggroColorRGB"] = {
        0,
        1,
        0,
        1,
        },
        ["defaultLargeNamePlateFontFlags"] = "",
        ["castBarInterruptHighlighterEndTime"] = 0.6,
        ["nameplateAuraRelativeAnchor"] = "TOPLEFT",
        ["combatIndicatorEnemyOnly"] = false,
        ["partyPointerArenaOnly"] = true,
        ["healerIndicatorYPos"] = 0,
        ["npBorderNpcColorRGB"] = {
        0,
        0,
        0,
        1,
        },
        ["partyPointerHideAll"] = true,
        ["customHpFriendlyHeight"] = 0,
        ["hideEnemyNameText"] = false,
        ["darkModeNameplateColor"] = 0.2,
        ["npBorderEnemyColorRGB"] = {
        1,
        0,
        0,
        1,
        },
        ["hideRaidmarkIndicator"] = false,
        ["nameplateMaxAlpha"] = 1,
        ["changeHealthbarHeight"] = false,
        ["nameplateAuraEnlargedScale"] = 1,
        ["otherNpdeBuffFilterLessMinite"] = false,
        ["healthNumbersNotOnFullHp"] = false,
        ["enableCustomFontOutline"] = false,
        ["castBarInterruptHighlighterInterruptRGB"] = {
        0,
        1,
        0,
        },
        ["auraBlacklist"] = {
        },
        ["partyPointerWidth"] = 36,
        ["nameplateResourceScale"] = 0.7,
        ["nameplateHorizontalScale"] = 1,
        ["healerIndicatorEnemyOnly"] = false,
        ["hideNpcMurlocScale"] = 1,
        ["old_defaultLargeNamePlateFontFlags"] = "",
        ["npBorderFriendFoeColor"] = false,
        ["healthNumbersFontOutline"] = "THICKOUTLINE",
        ["hideNameplateAuras"] = false,
        ["hidePersonalBarManaFrame"] = false,
        ["arenaIndicatorBg"] = true,
        ["arenaSpecScale"] = 1,
        ["focusTargetIndicatorChangeTexture"] = false,
        ["classIndicatorHideRaidMarker"] = true,
        ["partyPointerXPos"] = 0,
        ["classIconArenaOnly"] = false,
        ["classIconAlwaysShowTank"] = true,
        ["castBarEmphasisText"] = false,
        ["nameplateFriendlyWidth"] = 130,
        ["classicNameplates"] = false,
        ["skipGUI"] = true,
        ["castBarInterruptHighlighterStartPercentage"] = 15,
        ["petIndicatorScale"] = 1,
        ["nameplateOccludedAlphaMultScale"] = 0.4,
        ["otherNpBuffFilterImportantBuffs"] = false,
        ["fakeNameRaiseStrata"] = true,
        ["executeIndicatorThreshold"] = 40,
        ["totemIndicatorScaleUpImportant"] = false,
        ["npBorderFriendlyColorRGB"] = {
        0,
        1,
        0,
        1,
        },
        ["interruptedByIndicator"] = true,
        ["tankFullAggroColorRGB"] = {
        0,
        1,
        0,
        1,
        },
        ["healerIndicatorScale"] = 1,
        ["castBarEmphasisOnlyInterruptable"] = false,
        ["totemListUpdateTWW6"] = true,
        ["arenaSpecXPos"] = 0,
        ["castEmphasisList"] = {
        {
        ["name"] = "Cyclone",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Fear",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Haymaker",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Hex",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Lightning Lasso",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Mass Polymorph",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Polymorph",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Repentance",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Ring of Frost",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Shadowfury",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        {
        ["name"] = "Sleep Walk",
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        },
        },
        ["nameplateShowEnemyMinus"] = "0",
        ["shortArenaSpecName"] = false,
        ["classColorPersonalNameplate"] = false,
        ["darkModeNameplateResource"] = false,
        ["hideLevelFrame"] = true,
        ["fadeOutNPC"] = true,
        ["otherNpdeBuffFilterOnlyMe"] = false,
        ["enemyColorThreatCombatOnlyPlayer"] = false,
        ["smallPetsWidth"] = 20,
        ["importantCCSilence"] = true,
        ["auraColorList"] = {
        },
        ["personalNpBuffFilterOnlyMe"] = false,
        ["separateAuraBuffRow"] = true,
        ["castBarEmphasisIcon"] = false,
        ["healerIndicatorAnchor"] = "TOPRIGHT",
        ["executeIndicatorShowDecimal"] = true,
        ["castBarEmphasisIconScale"] = 2,
        ["alwaysHideFriendlyCastbar"] = false,
        ["nameplateShowFriendlyNPCs"] = "0",
        ["healthNumbersShowDecimal"] = false,
        ["hideNPCsList"] = {
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Infernal",
        ["id"] = 89,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Nazgrim",
        ["id"] = 221634,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "King Thoras Trollbane",
        ["id"] = 221635,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Voidwraith",
        ["id"] = 224466,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Highlord Darion Mograine",
        ["id"] = 221632,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Overfiend",
        ["id"] = 217429,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Pit Lord",
        ["id"] = 228574,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Gloomhound",
        ["id"] = 226268,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Water Elemental",
        ["id"] = 208441,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Bear - Pack Leader",
        ["id"] = 234018,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Void Lasher",
        ["id"] = 198757,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Lesser Primal Fire Elemental",
        ["id"] = 229799,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Overlord",
        ["id"] = 228575,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Lesser Fire Elemental",
        ["id"] = 229800,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Lesser Storm Elemental",
        ["id"] = 229801,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Thing From Beyond",
        ["id"] = 189988,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Charhound",
        ["id"] = 226269,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Doomguard",
        ["id"] = 225493,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Mother of Chaos",
        ["id"] = 228576,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Lesser Primal Storm Elemental",
        ["id"] = 229798,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "High Inquisitor Whitemane",
        ["id"] = 221633,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Raise Abomination",
        ["id"] = 149555,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Magus Army of the Dead",
        ["id"] = 163366,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Primal Earth Elemental",
        ["id"] = 61056,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Beast Hunter",
        ["id"] = 62005,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Earth Elemental Shaman",
        ["id"] = 95072,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Greater Fire Elemental",
        ["id"] = 95061,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Greater Storm Elemental",
        ["id"] = 77936,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "mindbender",
        ["id"] = 62982,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Spirit Wolves Enha Shaman",
        ["id"] = 29264,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Treant",
        ["id"] = 54983,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 24207,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Xuen",
        ["id"] = 63508,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Darkglare",
        ["id"] = 103673,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Dire Basilisk Hunter",
        ["id"] = 105419,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Vilefiend",
        ["id"] = 135816,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Primal Fire Elemental",
        ["id"] = 61029,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Illidari Satyr",
        ["id"] = 136398,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Void Terror",
        ["id"] = 136403,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Primal Storm Elemental",
        ["id"] = 77942,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Greater Lightning Elemental",
        ["id"] = 97022,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Dreadstalker",
        ["id"] = 98035,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "Darkhound",
        ["id"] = 136408,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 31216,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mirror Images (Mage)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 55659,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Wild Imp (Warlock)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 143622,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Wild Imp (Warlock)",
        },
        },
        ["partyIndicatorModeOne"] = false,
        ["adjustPersonalBarPosition"] = false,
        ["classIndicator"] = false,
        ["alwaysHideEnemyCastbar"] = false,
        ["castBarEmphasisHeightValue"] = 24,
        ["questIndicatorXPos"] = 0,
        ["otherNpdeBuffFilterBlacklist"] = true,
        ["castBarIconXPos"] = 0,
        ["nameplateOccludedAlphaMult"] = 0.4,
        ["fadeNPCPvPOnly"] = false,
        ["sortCompactedAurasFirst"] = false,
        ["totemIndicatorNpcList"] = {
        [60561] = {
        ["important"] = false,
        ["name"] = "Earthgrab Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.7803922295570374,
        0.5098039507865906,
        0.388235330581665,
        },
        ["duration"] = 20,
        ["icon"] = 136100,
        ["size"] = 24,
        },
        [89] = {
        ["important"] = false,
        ["name"] = "Infernal",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.69,
        0,
        },
        ["duration"] = 60,
        ["icon"] = 136219,
        ["size"] = 24,
        },
        [62982] = {
        ["important"] = false,
        ["name"] = "Mindbender",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.69,
        0,
        },
        ["duration"] = 15,
        ["icon"] = 136214,
        ["size"] = 24,
        },
        [19668] = {
        ["duration"] = 12,
        ["name"] = "Shadowfiend",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.69,
        0,
        },
        ["important"] = false,
        ["icon"] = 136199,
        ["size"] = 24,
        },
        [10467] = {
        ["duration"] = 16,
        ["name"] = "Mana Tide Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0,
        1,
        0.7568628191947937,
        },
        ["important"] = true,
        ["icon"] = 135861,
        ["size"] = 30,
        },
        [59764] = {
        ["important"] = true,
        ["name"] = "Healing Tide Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0,
        1,
        0.388235330581665,
        },
        ["duration"] = 10,
        ["icon"] = 538569,
        ["size"] = 30,
        },
        [59390] = {
        ["duration"] = 30,
        ["name"] = "Mocking Banner",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.6901960968971252,
        0,
        },
        ["important"] = false,
        ["icon"] = 604450,
        ["size"] = 24,
        },
        [5913] = {
        ["important"] = true,
        ["name"] = "Tremor Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.5333333611488342,
        0.8980392813682556,
        0.0941176563501358,
        },
        ["duration"] = 6,
        ["icon"] = 136108,
        ["size"] = 30,
        },
        [53006] = {
        ["important"] = true,
        ["name"] = "Spirit Link Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0,
        1,
        0.7529412508010864,
        },
        ["duration"] = 6,
        ["icon"] = 237586,
        ["size"] = 30,
        },
        [15430] = {
        ["duration"] = 60,
        ["name"] = "Earth Elemental Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.7803922295570374,
        0.5098039507865906,
        0.388235330581665,
        },
        ["important"] = false,
        ["icon"] = 136024,
        ["size"] = 24,
        },
        [5925] = {
        ["important"] = true,
        ["name"] = "Grounding Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0,
        1,
        },
        ["duration"] = 15,
        ["icon"] = 136039,
        ["size"] = 30,
        },
        [5929] = {
        ["important"] = false,
        ["name"] = "Magma Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.09019608050584793,
        0.02745098248124123,
        },
        ["duration"] = 60,
        ["icon"] = 135826,
        ["size"] = 24,
        },
        [61245] = {
        ["important"] = true,
        ["name"] = "Capacitor Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.6784313917160034,
        0,
        },
        ["duration"] = 5,
        ["icon"] = 136013,
        ["size"] = 30,
        },
        [62002] = {
        ["important"] = false,
        ["name"] = "Stormlash Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.1019607931375504,
        0.8313726186752319,
        0.7882353663444519,
        },
        ["duration"] = 10,
        ["icon"] = 538575,
        ["size"] = 24,
        },
        [59398] = {
        ["duration"] = 15,
        ["name"] = "Demoralizing Banner",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.6901960968971252,
        0,
        },
        ["important"] = false,
        ["icon"] = 604449,
        ["size"] = 24,
        },
        [59399] = {
        ["duration"] = 10,
        ["name"] = "Skull Banner",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0,
        1,
        },
        ["important"] = true,
        ["icon"] = 603532,
        ["size"] = 30,
        },
        [58997] = {
        ["important"] = false,
        ["name"] = "Abyssal",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.6901960968971252,
        0,
        },
        ["duration"] = 60,
        ["icon"] = 524350,
        ["size"] = 24,
        },
        [27829] = {
        ["important"] = true,
        ["name"] = "Gargoyle",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.686274528503418,
        0,
        },
        ["duration"] = 30,
        ["icon"] = 458967,
        ["size"] = 30,
        },
        [59712] = {
        ["duration"] = 30,
        ["name"] = "Stone Bulwark Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.7803922295570374,
        0.5098039507865906,
        0.388235330581665,
        },
        ["important"] = true,
        ["icon"] = 538572,
        ["size"] = 30,
        },
        [59000] = {
        ["important"] = true,
        ["name"] = "Terrorguard",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.7098039388656616,
        0,
        },
        ["duration"] = 60,
        ["icon"] = 615098,
        ["size"] = 30,
        },
        [3527] = {
        ["important"] = false,
        ["name"] = "Healing Stream Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0,
        0.4745098352432251,
        1,
        },
        ["duration"] = 15,
        ["icon"] = 135127,
        ["size"] = 24,
        },
        [2630] = {
        ["important"] = false,
        ["name"] = "Earthbind Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.78,
        0.51,
        0.39,
        },
        ["duration"] = 20,
        ["icon"] = 136102,
        ["size"] = 24,
        },
        [59190] = {
        ["duration"] = 10,
        ["name"] = "Psyfiend",
        ["hideIcon"] = false,
        ["color"] = {
        0.4823529720306397,
        0,
        1,
        },
        ["important"] = true,
        ["icon"] = 537021,
        ["size"] = 30,
        },
        [59717] = {
        ["duration"] = 6,
        ["name"] = "Windwalk Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.1176470667123795,
        0.8313726186752319,
        0.7882353663444519,
        },
        ["important"] = false,
        ["icon"] = 538576,
        ["size"] = 24,
        },
        [14465] = {
        ["name"] = "Alliance Battle Standard",
        ["hideIcon"] = false,
        ["color"] = {
        0,
        0.22,
        1,
        },
        ["important"] = true,
        ["icon"] = 132486,
        ["size"] = 24,
        },
        [11859] = {
        ["important"] = true,
        ["name"] = "Doomguard",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.7176470756530762,
        0,
        },
        ["duration"] = 60,
        ["icon"] = 615103,
        ["size"] = 30,
        },
        [15439] = {
        ["important"] = false,
        ["name"] = "Fire Elemental Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.09019608050584793,
        0.02745098248124123,
        },
        ["duration"] = 60,
        ["icon"] = 135790,
        ["size"] = 24,
        },
        [2523] = {
        ["important"] = false,
        ["name"] = "Searing Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.09019608050584793,
        0.02745098248124123,
        },
        ["duration"] = 60,
        ["icon"] = 135825,
        ["size"] = 24,
        },
        [14466] = {
        ["name"] = "Horde Battle Standard",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0,
        0,
        },
        ["important"] = true,
        ["icon"] = 132485,
        ["size"] = 24,
        },
        [65282] = {
        ["important"] = false,
        ["name"] = "Void Tendril",
        ["hideIcon"] = false,
        ["color"] = {
        0.3294117748737335,
        0.3686274588108063,
        1,
        },
        ["duration"] = 8,
        ["icon"] = 537022,
        ["size"] = 24,
        },
        },
        ["classIconColorBorder"] = true,
        ["enemyNeutralColorNameRGB"] = {
        1,
        1,
        0,
        },
        ["targetIndicatorColorName"] = false,
        ["classIconHealthNumbers"] = false,
        ["partyPointerHealerOnly"] = false,
        ["nameplateAuraRowAbove"] = true,
        ["totemIndicatorWidthEnabled"] = false,
        ["nameplateEnemyWidth"] = 133,
        ["classIndicatorShowPet"] = true,
        ["nameplateAuraCompactedSquare"] = false,
        ["nameplateShowAll"] = "1",
        ["absorbIndicatorOnPlayersOnly"] = true,
        ["fadeAllButTarget"] = false,
        ["healthNumbersYPos"] = 0,
        ["raidmarkIndicatorXPos"] = 0,
        ["bgIndicator"] = false,
        ["targetNameplateAuraScaleEnabled"] = false,
        ["castBarDelayedInterruptColor"] = {
        1,
        0.4784314036369324,
        0.9568628072738647,
        },
        ["executeIndicatorYPos"] = 0,
        ["otherNpBuffFilterLessMinite"] = false,
        ["hideResourceOnFriend"] = true,
        ["skipAdjustingFixedFonts"] = false,
        ["friendlyNameplatesOnlyInWorld"] = false,
        ["friendlyNpBuffFilterWatchList"] = false,
        ["showCastbarIfTarget"] = false,
        ["partyPointerAlwaysShowPet"] = false,
        ["sortEnlargedAurasFirst"] = true,
        ["castBarIconPosReset"] = true,
        ["classIndicatorFrameStrataHigh"] = false,
        ["absorbIndicatorXPos"] = 0,
        ["partyIndicatorModeFive"] = false,
        ["showGuildNames"] = false,
        ["healerIndicatorEnemyXPos"] = 0,
        ["hpHeightFriendly"] = 4,
        ["targetIndicator"] = false,
        ["nameplateDefaultLargeFriendlyHeight"] = 64.125,
        ["npBorderTargetColor"] = false,
        ["npBorderClassColor"] = false,
        ["hideCastbarText"] = false,
        ["hpHeightEnemy"] = 4,
        ["arenaIndicatorModeTwo"] = false,
        ["nameplateEnemyWidthScale"] = 133,
        ["castBarEmphasisHeight"] = false,
        ["otherNpBuffFilterAll"] = false,
        ["castBarIconYPos"] = 0,
        ["hideFriendlyNameText"] = true,
        ["nameplateResourceOnTarget"] = "0",
        ["fakeNameAnchor"] = "BOTTOM",
        ["castBarShieldScale"] = 1,
        ["classIconBgOnly"] = false,
        ["classIconEnemyHealIcon"] = true,
        ["hideDefaultPersonalNameplateAuras"] = false,
        ["npcTitleColor"] = false,
        ["partyPointerTestMode"] = false,
        ["personalNpBuffFilterBlizzard"] = true,
        ["friendlyNpBuffFilterOnlyMe"] = false,
        ["personalNpBuffFilterLessMinite"] = false,
        ["npBorderNonTargetColorRGB"] = {
        0,
        0,
        0,
        1,
        },
        ["nameplateResourceYPos"] = 0,
        ["nameplateSelectedScale"] = 1.2,
        ["castBarBackgroundColor"] = {
        0.33,
        0.33,
        0.33,
        1,
        },
        ["friendlyNameplatesOnlyInRaids"] = false,
        ["nameplateAuraSelfScale"] = 1,
        ["friendlyHealthBarColorPlayer"] = false,
        ["castBarNoInterruptColor"] = {
        1,
        0,
        0.01568627543747425,
        },
        ["guildNameScale"] = 1,
        ["hidePersonalBarExtraFrame"] = false,
        ["friendlyHealthBarColorRGB"] = {
        0,
        1,
        0,
        },
        ["classIndicatorCCAuras"] = true,
        ["classIndicatorHealer"] = false,
        ["nameplateAuraRowFriendlyAmountScale"] = 6,
        ["hideNPCWhitelistOn"] = false,
        ["enableNpVerticalPos"] = false,
        ["friendlyColorNameRGB"] = {
        1,
        1,
        1,
        },
        ["nameplateAuraTaller"] = false,
        ["classIndicatorOnlyFriends"] = false,
        ["petIndicatorYPos"] = 0,
        ["hideCastbarBorderShield"] = false,
        ["changeResourceStrata"] = false,
        ["raidmarkIndicator"] = false,
        ["defaultLargeNamePlateFont"] = "Fonts\\FRIZQT__.TTF",
        ["onlyShowHighlightedNpShadow"] = false,
        ["cleanedScaleScale"] = true,
        ["nameplateVerticalPosition"] = 0,
        ["castBarHeightHeight"] = 15,
        ["arenaIdYPos"] = 0,
        ["partyPointerWidthScale"] = 36,
        ["classIndicatorHighlight"] = false,
        ["nameplateFriendlyWidthScale"] = 130,
        ["castBarHeight"] = 16,
        ["nameplateDefaultFriendlyHeight"] = 45,
        ["classIndicatorSpecIcon"] = false,
        ["npBorderTargetColorRGB"] = {
        1,
        1,
        1,
        1,
        },
        ["castBarEmphasisSpark"] = false,
        ["partyPointerShowOthersPets"] = false,
        ["totemIndicatorColorName"] = true,
        ["friendlyNameplatesOnlyInEpicBgs"] = false,
        ["nameplateAurasXPos"] = 0,
        ["friendlyNameplateNonstackable"] = true,
        ["customFontSizeEnabled"] = false,
        ["partyPointerHideRaidmarker"] = true,
        ["alwaysShowPurgeTexture"] = true,
        ["instantComboPoints"] = true,
        ["friendlyNpBuffFilterBlacklist"] = true,
        ["importantCCFullGlow"] = true,
        ["castBarInterruptHighlighter"] = false,
        ["petIndicatorShowMurloc"] = true,
        ["castBarEmphasisSelfColorRGB"] = {
        1,
        0,
        0,
        },
        ["castBarIconAnchor"] = "LEFT",
        ["totemIndicatorHideHealthBar"] = false,
        ["fakeNameScaleWithParent"] = false,
        ["executeIndicatorAnchor"] = "LEFT",
        ["targetIndicatorColorNameplate"] = false,
        ["classicExport"] = true,
        ["updates"] = "v1.9.5f",
        ["totemIndicatorUseNicknames"] = false,
        ["castBarRecolorInterrupt"] = false,
        ["healthNumbersTestMode"] = false,
        ["personalNpdeBuffEnable"] = false,
        ["castBarEmphasisTextScale"] = 2,
        ["ghostAuras"] = {
        },
        ["hideNpcMurlocYPos"] = 0,
        ["combatIndicatorAssumePalaCombat"] = false,
        ["nameplateDefaultEnemyHeight"] = 45,
        ["useCustomCastbarTexture"] = false,
        ["anonMode"] = false,
        ["otherNpBuffFilterWatchList"] = true,
        ["focusTargetIndicatorColorNameplateRGB"] = {
        1,
        1,
        1,
        },
        ["otherNpBuffBlueBorder"] = false,
        ["nameplateShowEnemyTotems"] = "1",
        ["arenaIndicatorIDColor"] = false,
        ["nameplateShadowRGB"] = {
        0,
        0,
        0,
        1,
        },
        ["nameplateTargetBorderSize"] = 3,
        ["showNameplateCastbarTimer"] = false,
        ["levelFrameFontSize"] = 12,
        ["partyPointerShowPet"] = true,
        ["mopBetaUpdated2"] = true,
        ["partyIndicatorModeOff"] = false,
        ["tankOffTankAggroColorRGB"] = {
        0,
        0.95,
        1,
        1,
        },
        ["otherNpdeBuffPandemicGlow"] = false,
        ["useCustomTextureForSelf"] = false,
        ["partyPointerHighlightScale"] = 1,
        ["useCustomTextureForFriendly"] = true,
        ["castBarShieldAnchor"] = "LEFT",
        ["showNameplateShadowOnlyTarget"] = false,
        ["showNameplateShadow"] = false,
        ["enableNpNonTargetAlpha"] = false,
        ["petIndicatorColorHealthbarRGB"] = {
        0.03,
        0.35,
        0,
        },
        ["classIndicatorEnemy"] = true,
        ["partyPointerHighlightRGB"] = {
        1,
        0.71,
        0,
        },
        ["nameplateNonTargetAlpha"] = 0.5,
        ["nameplateAuraTestMode"] = false,
        ["nameplateMinAlpha"] = 1,
        ["classIndicatorBackgroundRGB"] = {
        0,
        0,
        0,
        1,
        },
        ["targetIndicatorHideIcon"] = false,
        ["showDefaultCooldownNumbersOnNpAuras"] = false,
        ["focusTargetIndicatorColorNameplate"] = false,
        ["reopenOptions"] = false,
        ["hasSaved"] = true,
        ["friendlyNpdeBuffFilterBlacklist"] = true,
        ["npBorderFocusColorRGB"] = {
        0,
        0,
        0,
        1,
        },
        ["otherNpdeBuffFilterBlizzard"] = false,
        ["nameplateAurasPersonalXPos"] = 0,
        ["friendIndicator"] = false,
        ["mopBetaUpdated3"] = true,
        ["defaultLargeFontSize"] = 12,
        ["nameplatePersonalBorderSize"] = 1,
        ["healerIndicatorEnemyAnchor"] = "TOPRIGHT",
        ["castBarDragonflightShield"] = true,
        ["useFakeNameAnchorBottom"] = false,
        ["importantCCSilenceGlow"] = true,
        ["nameplateGeneralHeight"] = 32,
        ["old_defaultLargeNamePlateFont"] = "Fonts\\FRIZQT__.TTF",
        ["enemyColorName"] = false,
        ["keyAurasImportantBuffsEnabled"] = true,
        ["fadeOutNPCsList"] = {
        {
        ["id"] = 226269,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Charhound (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 26125,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "DK pet",
        ["comment"] = "",
        },
        {
        ["id"] = 228224,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Fenryr (Hunter)",
        ["comment"] = "",
        },
        {
        ["id"] = 226268,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Gloomhound (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 228226,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Hati (Hunter)",
        ["comment"] = "",
        },
        {
        ["id"] = 221632,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Mograine (DK)",
        ["comment"] = "",
        },
        {
        ["id"] = 69792,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Monk SEF Image (Green)",
        ["comment"] = "",
        },
        {
        ["id"] = 69791,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Monk SEF Image (Red)",
        ["comment"] = "",
        },
        {
        ["id"] = 221634,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Nazgrim (DK)",
        ["comment"] = "",
        },
        {
        ["id"] = 103822,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Treant",
        ["comment"] = "",
        },
        {
        ["id"] = 221635,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Trollbane (DK)",
        ["comment"] = "",
        },
        {
        ["id"] = 135816,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Vilefiend (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 192337,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Void Tendril (Spriest)",
        ["comment"] = "",
        },
        {
        ["id"] = 208441,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Water Elemental (Mage)",
        ["comment"] = "",
        },
        {
        ["id"] = 221633,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Whitemane (DK)",
        ["comment"] = "",
        },
        },
        ["importantCCRootGlowRGB"] = {
        ["a"] = 1,
        ["b"] = 0,
        ["g"] = 0.874,
        ["r"] = 1,
        },
        ["auraWhitelist"] = {
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Aftermath",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Alliance Flag",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Avenger's Shield",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Barkskin",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Berserker Rage",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Blast Wave",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Blessing of Freedom",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Blessing of Protection",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Blessing of Sacrifice",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Cheat Death",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Chilled",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Cloak of Shadows",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Concussive Barrage",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Concussive Shot",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Cone of Cold",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Corruption",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Agony",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Doom",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Exhaustion",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Recklessness",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of the Elements",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Tongues",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Weakness",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Demoralizing Shout",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Deterrence",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Devouring Plague",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Divine Intervention",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Earthbind Totem",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Elune's Grace",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Evasion",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Expose Armor",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Expose Weakness",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Faerie Fire",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Faerie Fire Feral",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Fear Ward",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Feedback",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Find Weakness",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Fire Ward",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Flame Shock",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Frenzied Regeneration",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Frost Shock",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Frost Trap",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Frost Ward",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Frostbite",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Frostbolt",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Garrote",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Grounding Totem",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Hamstring",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Hemorrhage",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Hex of Weakness",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Holy Fire",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Horde Flag",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Hunter's Mark",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Ice Barrier",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Immolate",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Insect Swarm",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Intervene",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Judgement",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Lacerate",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Last Stand",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mana Shield",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mangle",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mangle Bear",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mangle Cat",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mind Flay",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Moonfire",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mortal Strike",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Nature's Grasp",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Nether Protection",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Netherstorm Flag",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Pain Suppression",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Piercing Howl",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Rake",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Rend",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Retaliation",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Righteous Defense",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Rip",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Rupture",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Scorpid Sting",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Seal of Corruption",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Seal of Light",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Seal of Vengeance",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Seed of Corruption",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Serpent Sting",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shadow Ward",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shadow Weaving",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shadow Word: Pain",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shamanistic Rage",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shield Wall",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Siphon Life",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Slow",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Spell Reflection",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Stoneskin Totem",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Sunder Armor",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Thunder Clap",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Touch of Weakness",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Unstable Affliction",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Vampiric Touch",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Viper Sting",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Windwall Totem",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Wing Clip",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Winter's Chill",
        ["comment"] = "",
        },
        },
        ["enlargeAllCC"] = true,
        ["partyPointerScale"] = 1.25,
        ["hidePersonalManaFX"] = false,
        ["nameplateShadowHighlightRGB"] = {
        1,
        1,
        1,
        1,
        },
        ["totemListUpdateTWW4"] = true,
        ["classIndicatorPinMode"] = false,
        ["nameplateResourceUnderCastbar"] = false,
        ["nameplateResourceDoNotRaiseAuras"] = false,
        ["nameplateMotion"] = "1",
        ["classIndicatorFriendlyXPos"] = 0,
        ["nameplateKeyAurasAnchor"] = "RIGHT",
        ["partyPointerTexture"] = 1,
        ["castBarPixelBorder"] = false,
        ["absorbIndicatorScale"] = 1,
        ["executeIndicatorTestMode"] = false,
        ["personalNpTRP3Color"] = false,
        ["nameplateAuraSquare"] = false,
        ["arenaIndicatorModeFour"] = false,
        ["classIndicatorHideName"] = false,
        ["enemyHealthBarColorNpcOnly"] = false,
        ["auraColorPvEOnly"] = false,
        ["nameplateShowFriendlyPets"] = "0",
        ["petIndicatorColorHealthbar"] = false,
        ["npAuraBuffsRGB"] = {
        0,
        0.67,
        1,
        },
        ["totemListUpdateTWW3"] = true,
        ["castBarEmphasisHealthbarColor"] = false,
        ["personalBarPosition"] = 0.5,
        ["healthNumbersOnlyInCombat"] = false,
        ["totemListUpdateTWW2"] = true,
        ["arenaIdAnchorRaiseStrata"] = false,
        ["useCustomTextureForEnemy"] = true,
        ["customTextureSelfMana"] = "Solid",
        ["customFontSize"] = 12,
        ["hideEliteDragon"] = false,
        ["nameplateCastbarTestMode"] = false,
        ["fadeOutNPCOnlyFadeSecondaryPets"] = true,
        ["nameplateResourceXPosXPos"] = 0,
        ["nameplateOverlapV"] = 0.8,
        ["skipCVarsPlater"] = true,
        ["nameplateMinAlphaScale"] = 1,
        ["friendlyNpdeBuffFilterLessMinite"] = false,
        ["friendlyNpBuffPurgeGlow"] = false,
        ["personalBarTweaks"] = false,
        ["totemListUpdateTWW5"] = true,
        ["healthNumbersJustify"] = "CENTER",
        ["healthNumbersScale"] = 1,
        ["castBarShieldYPos"] = 0,
        ["totemIndicatorHideAuras"] = true,
        ["showCastBarIconWhenNoninterruptible"] = true,
        ["nameplateDefaultLargeEnemyHeight"] = 64.125,
        ["healthNumbersSwapped"] = false,
        ["importantBuffsOffensives"] = true,
        ["otherNpBuffEnable"] = true,
        ["raidmarkIndicatorRaiseStrata"] = false,
        ["nameplateAuraDebuffSelfScale"] = 1,
        ["hideCastbarWhitelistOn"] = false,
        ["importantBuffsMobilityGlow"] = true,
        ["raidmarkerPvPOnly"] = false,
        ["tankNoAggroColorRGB"] = {
        1,
        0,
        0,
        1,
        },
        ["nameplateResourceYPosYPos"] = 0,
        ["hideTempHpLoss"] = false,
        ["customFontOutline"] = "THINOUTLINE",
        ["classIndicatorBackground"] = false,
        ["classIndicatorHighlightColor"] = false,
        ["nameplateCenterAllRows"] = false,
        ["disableEnlargedAurasOnSelf"] = true,
        ["enemyColorThreatHideSolo"] = false,
        ["useCustomTextureForBars"] = false,
        ["useCustomTextureForExtraBars"] = false,
        ["enemyColorThreat"] = false,
        ["showNameplateTargetText"] = false,
        ["classIconSquareBorder"] = false,
        ["friendlyNpBuffEmphasisedBorder"] = false,
        ["personalNpdeBuffFilterLessMinite"] = false,
        ["executeIndicatorUseTexture"] = false,
        ["blizzardDefaultFilterOnlyMine"] = false,
        ["partyIDScale"] = 1,
        ["nameplateMinAlphaDistance"] = 10,
        ["bgIndicatorXPos"] = 0,
        ["friendlyNpBuffFilterAll"] = false,
        ["nameplateSelfAlpha"] = "1",
        ["petIndicator"] = true,
        ["enemyNameplateHealthbarHeight"] = 11,
        ["totemIndicatorXPos"] = 0,
        ["customFont"] = "Prototype",
        ["nameplateSelfHeight"] = 32,
        ["ShowClassColorInNameplate"] = "1",
        ["fakeNameAnchorRelative"] = "TOP",
        ["nameplateAuraBuffScale"] = 1,
        ["importantCCFullGlowRGB"] = {
        ["a"] = 1,
        ["b"] = 0,
        ["g"] = 0.874,
        ["r"] = 1,
        },
        ["threatColorAlwaysOn"] = false,
        ["petIndicatorTestMode"] = false,
        ["personalNpBuffEnable"] = true,
        ["old_defaultNamePlateFontFlags"] = "",
        ["friendlyHideHealthBar"] = false,
        ["hideNPCPetsOnly"] = false,
        ["tankLosingAggroColorRGB"] = {
        1,
        0.47,
        0,
        1,
        },
        ["partyPointerScaleScale"] = 1.25,
        ["executeIndicatorInRangeColor"] = false,
        ["hideNPCHideOthersPets"] = false,
        ["totemIndicatorAnchor"] = "TOP",
        ["partyPointerHealerReplace"] = true,
        ["totemIndicatorYPos"] = 0,
        ["nameplateNotSelectedAlpha"] = "0.5",
        ["hideCastbarIcon"] = false,
        ["nameplateAuraCompactedScale"] = 1,
        ["castBarRecolor"] = false,
        ["bgIndicatorScale"] = 1,
        ["defaultNamePlateFontFlags"] = "",
        ["fadeOutNPCsAlpha"] = 0.2,
        ["nameplateExtraClickHeight"] = 0,
        ["nameplateAuraBuffSelfScale"] = 1,
        ["castBarChanneledColor"] = {
        0.4862745404243469,
        1,
        0.294117659330368,
        },
        ["otherNpBuffFilterBlacklist"] = true,
        ["combatIndicator"] = false,
        ["friendlyNameplatesOnlyInDungeons"] = false,
        ["nameplateResourceXPos"] = 0,
        ["npAuraOtherRGB"] = {
        0,
        0,
        0,
        },
        ["showTotemIndicatorCooldownSwipe"] = true,
        ["totemIndicatorNoAnimation"] = false,
        ["nameplateAuraPlayersOnly"] = false,
        ["healerIndicatorBgOnly"] = false,
        ["classIndicatorFriendlyYPos"] = 0,
        ["friendlyColorName"] = false,
        ["personalNpdeBuffFilterCC"] = false,
        ["classIndicatorHideFriendlyHealthbar"] = false,
        ["nameplateAuraKeyAuraPositionEnabled"] = false,
        ["nameplateAurasCenteredAnchor"] = false,
        ["npcTitleColorRGB"] = {
        1,
        0.85,
        0,
        },
        ["arenaIndicatorIDColorRGB"] = {
        1,
        0.819607,
        0,
        1,
        },
        ["customTextureSelf"] = "Solid",
        ["nameplateMotionSpeed"] = 0.025,
        ["defaultFontSize"] = 9,
        ["combatIndicatorAnchor"] = "CENTER",
        ["nameplateAuraHeightGap"] = 4,
        ["sortDurationAuras"] = false,
        ["hideNPC"] = true,
        ["partyPointerYPos"] = -40,
        ["nameplateKeyAurasYPos"] = 0,
        ["healthNumbersHideSelf"] = false,
        ["nameplateMaxScale"] = 0.9,
        ["nameplateAuraDebuffScale"] = 1,
        ["totemIndicatorScale"] = 1,
        ["enableNpNonTargetAlphaFullAlphaCasting"] = false,
        ["normalCastbarForEmpoweredCasts"] = true,
        ["executeIndicatorFriendly"] = false,
        ["healthNumbersCurrentFull"] = false,
        ["bgIndicatorShowFlags"] = true,
        ["friendlyNameScale"] = 1,
        ["showInterruptsOnNameplateAuras"] = false,
        ["combatIndicatorPlayersOnly"] = true,
        ["highlightNpShadowOnMouseover"] = false,
        ["useCustomFont"] = true,
        ["hideResourceFrame"] = false,
        ["nameplateMinAlphaDistanceScale"] = 10.1,
        ["healthNumbersPercentage"] = false,
        ["arenaModeSettingKey"] = "1: Replace name with Arena ID",
        ["castBarInterruptHighlighterEndPercentage"] = 80,
        ["nameplateResourceScaleScale"] = 0.7,
        ["targetIndicatorTestMode"] = false,
        ["nameplateOverlapH"] = 0.8,
        ["combatIndicatorArenaOnly"] = false,
        ["bgIndicatorEnemyOnly"] = true,
        ["focusTargetIndicatorYPos"] = 0,
        ["personalNpdeBuffFilterBlacklist"] = true,
        ["friendlyNpBuffBlueBorder"] = false,
        ["executeIndicatorInRangeColorRGB"] = {
        0,
        1,
        0.8,
        1,
        },
        ["healerIndicatorEnemyScale"] = 1,
        ["classIndicatorOnlyParty"] = false,
        ["useCustomCastbarBGTexture"] = false,
        ["healerIndicatorArenaOnly"] = false,
        ["executeIndicatorPercentSymbol"] = false,
        ["overShields"] = true,
        ["targetIndicatorTexture"] = "Checkered (BBP)",
        ["castBarFullTextWidth"] = false,
        ["fakeNameYPos"] = 0,
        ["personalNpdeBuffFilterAll"] = false,
        ["nameplateAuraPlayersOnlyShowTarget"] = false,
        ["partyIndicatorModeTwo"] = false,
        ["importantBuffsOffensivesGlowRGB"] = {
        ["a"] = 1,
        ["b"] = 0,
        ["g"] = 0.5,
        ["r"] = 1,
        },
        ["friendlyHideHealthBarNpc"] = false,
        ["importantBuffsOffensivesGlow"] = true,
        ["importantBuffsDefensivesGlow"] = true,
        ["enemyHealthBarColorRGB"] = {
        1,
        0,
        0,
        },
        ["nameplateAuraScale"] = 1,
        ["npBorderNeutralColorRGB"] = {
        1,
        1,
        0,
        1,
        },
        ["wasOnLoadingScreen"] = false,
        ["targetIndicatorXPos"] = 0,
        ["nameplateResourcePositionFix"] = true,
        ["fakeNameXPos"] = 0,
        ["friendlyNpdeBuffFilterAll"] = false,
        ["keyAurasImportantGlowOn"] = true,
        ["focusTargetIndicatorScale"] = 1,
        ["guildNameColorRGB"] = {
        0,
        1,
        0,
        },
        ["removeRealmNames"] = true,
        ["nameplateKeyAurasXPos"] = 0,
        ["combatIndicatorScale"] = 1,
        ["personalNpBuffFilterAll"] = false,
        ["castbarQuickHide"] = true,
        ["partyPointerHighlight"] = false,
        ["raidmarkIndicatorAnchor"] = "TOP",
        ["guildNameColor"] = false,
        ["nameplateAuraEnlargedSquare"] = true,
        ["castBarInterruptHighlighterStartTime"] = 0.8,
        ["ShowClassColorInFriendlyNameplate"] = "0",
        ["npAuraPoisonRGB"] = {
        0,
        0.52,
        0.031,
        },
        ["classIconHealerIconType"] = 2,
        ["executeIndicatorAlwaysOn"] = false,
        ["healerIndicatorXPos"] = 0,
        ["partyIndicatorModeFour"] = false,
        ["colorNpcList"] = {
        },
        ["partyPointerTargetIndicator"] = true,
        ["friendlyNpdeBuffEnable"] = false,
        ["arenaIndicatorModeFive"] = false,
        ["npcTitleScale"] = 1,
        ["combatIndicatorYPos"] = 0,
        ["customHpHeight"] = 0,
        ["enableCastbarEmphasis"] = false,
        ["healerIndicator"] = true,
        ["partyPointerHealer"] = true,
        ["useFakeName"] = false,
        ["focusTargetIndicatorXPos"] = 0,
        ["nameplateBorderSize"] = 1,
        ["targetIndicatorAnchor"] = "TOP",
        ["importantCCRoot"] = true,
        ["friendlyNameplateClickthrough"] = false,
        ["setCVarAcrossAllCharacters"] = true,
        ["classIndicatorYPos"] = 0,
        ["healthNumbersTargetOnly"] = false,
        ["healthNumbersPercentSymbol"] = false,
        ["healthNumbersAnchor"] = "CENTER",
        ["totemIndicatorColorHealthBar"] = true,
        ["arenaIndicatorTestMode"] = false,
        ["nameplateKeyAurasFriendlyAnchor"] = "RIGHT",
        ["nameplateAuraRowAmountScale"] = 6,
        ["healthNumbersClassColor"] = false,
        ["nameplateDefaultLargeFriendlyWidth"] = 154,
        ["importantBuffsMobility"] = true,
        ["personalNpdeBuffFilterWatchList"] = true,
        ["enemyNameScale"] = 1,
        ["fakeNameFriendlyYPos"] = 0,
        ["executeIndicatorXPos"] = 0,
        ["npAuraMagicRGB"] = {
        0.13,
        0.44,
        1,
        },
        ["hideNPCSecondaryShowMurloc"] = true,
        ["classIndicatorAlpha"] = 1,
        ["hideNPCAllNeutral"] = false,
        ["largeNameplates"] = false,
        ["absorbIndicatorEnemyOnly"] = false,
        ["nameplateShowEnemyPets"] = "1",
        ["onlyShowInterruptableCasts"] = false,
        ["targetNameplateAuraScale"] = 1,
        ["healthNumbers"] = false,
        ["showLastNameNpc"] = false,
        ["onlyPandemicAuraMine"] = true,
        ["nameplateShowEnemyMinions"] = "1",
        ["castBarShieldXPos"] = 0,
        ["raidmarkIndicatorFullAlpha"] = false,
        ["scTotem"] = true,
        ["petIndicatorAnchor"] = "CENTER",
        ["enlargeAllImportantBuffs"] = true,
        ["importantCCFull"] = true,
        ["castBarInterruptHighlighterDontInterruptRGB"] = {
        0,
        0,
        0,
        },
        ["classIconSquareBorderFriendly"] = false,
        ["importantBuffsDefensivesGlowRGB"] = {
        ["a"] = 1,
        ["b"] = 0.945,
        ["g"] = 0.662,
        ["r"] = 1,
        },
        ["focusTargetIndicatorColorName"] = false,
        ["testAllEnabledFeatures"] = false,
        ["targetIndicatorColorNameplateRGB"] = {
        1,
        0,
        0.44,
        },
        ["partyPointerOnlyParty"] = false,
        ["partyPointerHealerScale"] = 1.25,
        ["nameplateSelfBottomInset"] = ".2",
        ["healthNumbersFontSize"] = 9,
        ["raidmarkIndicatorScale"] = 1,
        ["hideTargetHighlight"] = false,
        ["changeNpHpBgColorSolid"] = false,
        ["classIndicatorFriendly"] = true,
        ["nameplateDefaultEnemyWidth"] = 110,
        ["customTexture"] = "Dragonflight (BBP)",
        ["nameplateAuraCountScale"] = 1,
        ["combatIndicatorSap"] = false,
        ["executeIndicatorNotOnFullHp"] = false,
        ["focusTargetIndicatorAnchor"] = "TOPRIGHT",
        ["totemIndicatorTestMode"] = false,
        ["executeIndicatorTargetOnly"] = false,
        ["enableNpNonTargetAlphaTargetOnly"] = true,
        ["changeNpHpBgColor"] = false,
        ["dpsOrHealFullAggroColorRGB"] = {
        1,
        0,
        0,
        1,
        },
        ["absorbIndicatorAnchor"] = "LEFT",
        ["classIndicatorUpdated2"] = true,
        ["friendlyNpBuffFilterImportantBuffs"] = false,
        ["nameplateDefaultFriendlyWidth"] = 110,
        ["defaultNamePlateFont"] = "Fonts\\FRIZQT__.TTF",
        ["useCustomTextureForSelfMana"] = false,
        ["healerIndicatorTestMode"] = false,
        ["recolorTempHpLoss"] = false,
        ["totemIndicatorDefaultCooldownTextSize"] = 0.85,
        ["absorbIndicatorYPos"] = 0,
        ["changeNameplateBorderSize"] = false,
        ["fadeOutNPCWhitelistOn"] = false,
        ["totemIndicator"] = true,
        ["hideNpcCastbar"] = false,
        ["totemListUpdateTWW1"] = true,
        ["castBarCastColor"] = {
        1,
        0.8431373238563538,
        0.2000000178813934,
        },
        ["personalNpBuffFilterBlacklist"] = true,
        ["classIndicatorAlwaysShowPet"] = false,
        ["nameplateOverlapVScale"] = 0.8,
        ["npBorderDesaturate"] = true,
        ["enableCastbarCustomization"] = true,
        ["raidmarkIndicatorYPos"] = 0,
        ["NamePlateVerticalScale"] = 1.08,
        ["healthNumbersNpcs"] = true,
        ["bgIndicatorYPos"] = 0,
        ["nameplateAurasFriendlyCenteredAnchor"] = false,
        ["castBarIconScaleScale"] = 1,
        ["totemListUpdateMop2"] = true,
        ["nameplateSelfTopInset"] = ".5",
        ["castBarEmphasisSelfColor"] = false,
        ["nameplateDefaultLargeEnemyWidth"] = 154,
        ["partyPointerAnchor"] = "TOP",
        ["questIndicatorScale"] = 1,
        ["healthNumbersPlayers"] = true,
        ["enemyClassColorName"] = false,
        ["smallPetsInPvP"] = false,
        ["fakeNameFriendlyXPos"] = 0,
        ["old_defaultNamePlateFont"] = "Fonts\\FRIZQT__.TTF",
        ["toggleNamesOffDuringPVE"] = false,
        ["bgIndicatorTestMode"] = false,
        ["personalNpBuffFilterWatchList"] = true,
        ["classIndicatorFriendlyAnchor"] = "TOP",
        ["enemyColorNameRGB"] = {
        1,
        0,
        0,
        },
        ["hideCastbarEnemy"] = false,
        ["hideNameDuringCast"] = false,
        ["friendlyHealthBarColor"] = false,
        ["importantCCSilenceGlowRGB"] = {
        ["a"] = 1,
        ["b"] = 0,
        ["g"] = 0.874,
        ["r"] = 1,
        },
        ["partyPointerBgOnly"] = true,
        ["classIconAlwaysShowHealer"] = true,
        ["absorbIndicatorTestMode"] = false,
        ["hideNpAuraSwipe"] = false,
        ["nameplateLargerScale"] = 1.2,
        ["bgIndicatorAnchor"] = "BOTTOM",
        ["hpHeightSelf"] = 10.8,
        ["classIndicatorTank"] = true,
        ["hidePetCastbars"] = false,
        ["healerIndicatorEnemyYPos"] = 0,
        ["nameplateMotionSpeedScale"] = 0.03,
        ["hideCastbarFriendly"] = false,
        ["importantBuffsMobilityGlowRGB"] = {
        ["a"] = 1,
        ["b"] = 1,
        ["g"] = 1,
        ["r"] = 0,
        },
        ["enableNpNonFocusAlpha"] = false,
        ["druidOverstacks"] = true,
        ["healthNumbersCombined"] = false,
        ["nameplateKeyAurasHorizontalGap"] = 5,
        ["dpsOrHealTargetAggroColorRGB"] = {
        1,
        0,
        0,
        1,
        },
        ["arenaIDScale"] = 1,
        ["focusTargetIndicator"] = false,
        ["castBarIconPixelBorder"] = false,
        ["nameplateAurasYPosYPos"] = -10,
        ["fadeOutNPCsWhitelist"] = {
        {
        ["id"] = 104818,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Ancestral Protection Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 61245,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Capacitor Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 78001,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Cloudburst Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 105451,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Counterstrike Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 2630,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Earthbind Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 100943,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Earthen Wall Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 60561,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Earthgrab Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 17252,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Felguard (Demo Pet)",
        ["comment"] = "",
        },
        {
        ["id"] = 417,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Felhunter (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 5925,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Grounding Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 114565,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Guardian Queen (prot pala)",
        ["comment"] = "",
        },
        {
        ["id"] = 3527,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Healing Stream Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 59764,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Healing Tide Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 165189,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Hunter Pet (they all have same ID)",
        ["comment"] = "",
        },
        {
        ["id"] = 89,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Infernal (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 97369,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Liquid Magma Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 10467,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mana Tide Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 62982,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mindbender",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 69792,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Monk Image (Green)",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 69791,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Monk Image (Red)",
        },
        {
        ["id"] = 107100,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Observer (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 5923,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Poison Cleansing Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 101398,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Psyfiend (Spriest)",
        ["comment"] = "",
        },
        {
        ["id"] = 225672,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shadow (Priest Re-Fear)",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 19668,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Shadowfiend",
        },
        {
        ["id"] = 53006,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Spirit Link Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 179867,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Static Field Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 59712,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Stone Bulwark Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 194117,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Stoneskin Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 1863,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Succubus (Warlock)",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 225409,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Surging Totem",
        },
        {
        ["id"] = 105427,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Totem of Wrath",
        ["comment"] = "",
        },
        {
        ["id"] = 194118,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Tranquil Air Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 5913,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Tremor Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 135002,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Tyrant (Warlock)",
        ["comment"] = "",
        },
        {
        ["flags"] = {
        ["murloc"] = false,
        },
        ["comment"] = "",
        ["id"] = 224466,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Voidwrath (Priest)",
        },
        {
        ["id"] = 119052,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "War Banner",
        ["comment"] = "",
        },
        {
        ["id"] = 97285,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Wind Rush Totem",
        ["comment"] = "",
        },
        },
        ["nameplateAuraWidthGap"] = 4,
        ["friendlyNpdeBuffFilterOnlyMe"] = false,
        ["auraWhitelistAlphaUpdated"] = true,
        ["partyPointerUpdated2"] = true,
        ["importantCCDisarmGlowRGB"] = {
        ["a"] = 1,
        ["b"] = 0,
        ["g"] = 0.874,
        ["r"] = 1,
        },
        ["nameplateAuraTooltip"] = false,
        ["arenaSpecYPos"] = 0,
        ["exportVersion"] = "BBP: 1.8.4c WoW: 5.5.3",
        ["npColorAuraBorder"] = false,
        ["otherNpBuffPurgeGlow"] = false,
        ["friendlyNpBuffEnable"] = false,
        ["version"] = "1.00",
        ["nameplateAurasPersonalCenteredAnchor"] = false,
        ["hideCastbar"] = false,
        ["petIndicatorXPos"] = 0,
        ["fixedFriendlyHealthbarHide"] = true,
        ["classIndicatorOnlyHealer"] = false,
        ["castbarEventsOn"] = true,
        ["enemyColorThreatCombatOnly"] = false,
        ["nameplateSelectedAlpha"] = "1",
        ["nameplateAuraTypeGap"] = 0,
        ["totemListUpdateMop3"] = true,
        ["classIndicatorBackgroundSize"] = 1,
        ["friendlyHealthBarColorNpc"] = false,
        ["defaultNpAuraCdSize"] = 0.5,
        ["nameplateGlobalScale"] = 1,
        ["nameplateAuraAnchor"] = "BOTTOMLEFT",
        ["totemIndicatorShieldType"] = 1,
        ["targetHighlightFix"] = false,
        ["nameplateAuraRowFriendlyAmount"] = 6,
        ["nameplateMaxAlphaDistance"] = 40,
        ["nameplateAuraEnlargedScaleScale"] = 1,
        ["partyPointerClassColor"] = true,
        ["castBarTextScaleScale"] = 1,
        ["executeIndicator"] = false,
        ["showCircleOnArenaID"] = false,
        ["partyPointerHealerScaleScale"] = 1.25,
        ["nameplateNotSelectedAlphaScale"] = 1,
        ["npAuraCurseRGB"] = {
        0.47,
        0,
        0.78,
        },
        ["friendlyNpdeBuffFilterBlizzard"] = false,
        ["arenaIndicatorModeOne"] = true,
        ["disableImportantAurasOnSelf"] = true,
        ["classIconAlwaysShowBgObj"] = true,
        ["friendlyNpdeBuffFilterCC"] = false,
        ["totemIndicatorEnemyOnly"] = true,
        ["maxAurasOnNameplate"] = 12,
        ["friendlyNameplatesOnlyInArena"] = true,
        ["firstSaveComplete"] = true,
        ["keepNpShadowTargetHighlighted"] = false,
    }

    if not SkillCappedBackupDB.BetterBlizzPlatesDB then
        SkillCappedBackupDB.BetterBlizzPlatesDB = SC:DeepCopy(BetterBlizzPlatesDB)
        SkillCappedBackupDB.addonBackupTimes["BetterBlizzPlates"] = SC:GetDateAndTime()
    end

    BetterBlizzPlatesDB = scBetterBlizzPlatesDB
    BetterBlizzPlatesDB.scStart = true
    BetterBlizzPlatesDB.skipCVarsPlater = true
end