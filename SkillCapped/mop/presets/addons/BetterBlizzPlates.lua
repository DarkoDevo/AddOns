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
        ["useCustomTextureForEnemy"] = true,
        ["hideNPCArenaOnly"] = false,
        ["nameplateKeyAuraScale"] = 1,
        ["NamePlateClassificationScale"] = 1,
        ["hideNPCHideSecondaryPets"] = true,
        ["healerIndicatorArenaOnly"] = false,
        ["auraColor"] = false,
        ["friendlyNpdeBuffFilterLessMinite"] = false,
        ["friendlyNpBuffFilterLessMinite"] = false,
        ["otherNpdeBuffFilterWatchList"] = true,
        ["castBarInterruptHighlighterColorDontInterrupt"] = false,
        ["castBarRecolorInterrupt"] = false,
        ["customTextureFriendly"] = "Dragonflight (BBP)",
        ["classIndicatorXPos"] = 0,
        ["partyPointer"] = true,
        ["hideCastbarWhitelist"] = {
        },
        ["colorNPCName"] = false,
        ["questIndicatorTestMode"] = false,
        ["targetIndicatorYPos"] = 0,
        ["executeIndicatorScale"] = 1,
        ["petIndicatorColorHealthbarRGB"] = {
        0.03,
        0.35,
        0,
        },
        ["focusTargetIndicatorTexture"] = "Shattered DF (BBP)",
        ["defaultFadeOutNPCsList"] = {
        {
        ["id"] = 24207,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Army of the Dead",
        ["comment"] = "",
        },
        {
        ["id"] = 62005,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Beast (Hunter)",
        ["comment"] = "",
        },
        {
        ["id"] = 136408,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Darkhound",
        ["comment"] = "",
        },
        {
        ["id"] = 105419,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Dire Basilisk (Hunter)",
        ["comment"] = "",
        },
        {
        ["id"] = 26125,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "DK pet",
        ["comment"] = "",
        },
        {
        ["id"] = 95072,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Earth Elemental (Shaman)",
        ["comment"] = "",
        },
        {
        ["id"] = 136398,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Illidari Satyr",
        ["comment"] = "",
        },
        {
        ["id"] = 163366,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Magus(Army of the Dead)",
        ["comment"] = "",
        },
        {
        ["id"] = 31216,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Mirror Images (Mage)",
        ["comment"] = "",
        },
        {
        ["id"] = 29264,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Spirit Wolves (Enha Shaman)",
        ["comment"] = "",
        },
        {
        ["id"] = 54983,
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
        ["id"] = 192337,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Void Tendril (Spriest)",
        ["comment"] = "",
        },
        {
        ["id"] = 136403,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Void Terror",
        ["comment"] = "",
        },
        },
        ["friendlyClassColorName"] = false,
        ["castbarAlwaysOnTop"] = false,
        ["castbarEventsOn"] = true,
        ["targetIndicatorScale"] = 1,
        ["changeNameplateBorderColor"] = false,
        ["disableCompactedAurasOnSelf"] = true,
        ["questIndicatorAnchor"] = "LEFT",
        ["otherNpBuffFilterPurgeable"] = false,
        ["otherNpdeBuffEnable"] = true,
        ["otherNpBuffBlueBorder"] = false,
        ["combatIndicatorXPos"] = 0,
        ["customTexture"] = "Dragonflight (BBP)",
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
        ["NamePlateVerticalScale"] = 1.08,
        ["mopUpdated"] = true,
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
        ["targetIndicatorTestMode"] = false,
        ["importantBuffsDefensives"] = true,
        ["absorbIndicator"] = false,
        ["arenaIndicatorModeOff"] = false,
        ["friendlyNpBuffBlueBorder"] = false,
        ["nameplateShowEnemyGuardians"] = "1",
        ["cleanedScaleScale"] = true,
        ["castBarPixelBorder"] = false,
        ["nameplateEnemyHeight"] = 32,
        ["targetIndicatorChangeTexture"] = false,
        ["nameplateAurasYPos"] = -10,
        ["castBarEmphasisColor"] = false,
        ["petIndicatorHideSecondaryPets"] = true,
        ["nameplateShowFriendlyTotems"] = "0",
        ["nameplateAurasCenteredAnchor"] = false,
        ["classIconReactionBorder"] = false,
        ["targetIndicatorColorNameplateRGB"] = {
        1,
        0,
        0.44,
        },
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Windfury Totem",
        },
        },
        ["castBarTextScale"] = 1,
        ["otherNpdeBuffFilterAll"] = false,
        ["colorNPC"] = false,
        ["classIndicatorAnchor"] = "TOP",
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
        ["classIndicatorEnemy"] = true,
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
        ["nameplateLargerScale"] = 1.2,
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
        ["npAuraBuffsRGB"] = {
        0,
        0.67,
        1,
        },
        ["otherNpdeBuffFilterLessMinite"] = false,
        ["healthNumbersNotOnFullHp"] = false,
        ["classIndicatorYPos"] = 0,
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
        ["enlargeAllCC"] = true,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Fear",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Haymaker",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Hex",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Lightning Lasso",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Mass Polymorph",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Polymorph",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Repentance",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Ring of Frost",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Shadowfury",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        {
        ["name"] = "Sleep Walk",
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        },
        },
        ["nameplateShowEnemyMinus"] = "0",
        ["shortArenaSpecName"] = false,
        ["importantBuffsMobilityGlowRGB"] = {
        ["a"] = 1,
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 1,
        },
        ["darkModeNameplateResource"] = false,
        ["tankOffTankAggroColorRGB"] = {
        0,
        0.95,
        1,
        1,
        },
        ["fadeOutNPC"] = true,
        ["otherNpdeBuffFilterOnlyMe"] = false,
        ["enemyColorThreatCombatOnlyPlayer"] = false,
        ["partyPointerHighlightScale"] = 1,
        ["importantCCSilence"] = true,
        ["auraColorList"] = {
        },
        ["personalNpBuffFilterOnlyMe"] = false,
        ["separateAuraBuffRow"] = true,
        ["castBarEmphasisIcon"] = false,
        ["healerIndicatorAnchor"] = "TOPRIGHT",
        ["executeIndicatorShowDecimal"] = true,
        ["castBarEmphasisIconScale"] = 2,
        ["dpsOrHealTargetAggroColorRGB"] = {
        1,
        0,
        0,
        1,
        },
        ["nameplateShowFriendlyNPCs"] = "0",
        ["healthNumbersShowDecimal"] = false,
        ["hideNPCsList"] = {
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "Infernal",
        ["id"] = 89,
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
        ["comment"] = "Treant",
        ["id"] = 54983,
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
        ["comment"] = "",
        ["id"] = 24207,
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
        ["comment"] = "Spirit Wolves Enha Shaman",
        ["id"] = 29264,
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
        ["comment"] = "Primal Earth Elemental",
        ["id"] = 61056,
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
        ["comment"] = "Xuen",
        ["id"] = 63508,
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
        ["comment"] = "Greater Storm Elemental",
        ["id"] = 77936,
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
        ["comment"] = "Beast Hunter",
        ["id"] = 62005,
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
        ["comment"] = "mindbender",
        ["id"] = 62982,
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
        ["comment"] = "Greater Fire Elemental",
        ["id"] = 95061,
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
        ["comment"] = "Primal Fire Elemental",
        ["id"] = 61029,
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
        ["comment"] = "Earth Elemental Shaman",
        ["id"] = 95072,
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
        ["comment"] = "Darkglare",
        ["id"] = 103673,
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
        ["comment"] = "Greater Lightning Elemental",
        ["id"] = 97022,
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
        ["comment"] = "Dreadstalker",
        ["id"] = 98035,
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
        ["comment"] = "Vilefiend",
        ["id"] = 135816,
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
        ["comment"] = "Dire Basilisk Hunter",
        ["id"] = 105419,
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
        ["comment"] = "Darkhound",
        ["id"] = 136408,
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
        ["comment"] = "Illidari Satyr",
        ["id"] = 136398,
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
        ["comment"] = "Void Terror",
        ["id"] = 136403,
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
        ["comment"] = "Primal Storm Elemental",
        ["id"] = 77942,
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
        ["comment"] = "Raise Abomination",
        ["id"] = 149555,
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
        ["comment"] = "Magus Army of the Dead",
        ["id"] = 163366,
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
        ["comment"] = "Doomguard",
        ["id"] = 225493,
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
        ["comment"] = "Highlord Darion Mograine",
        ["id"] = 221632,
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
        ["comment"] = "Gloomhound",
        ["id"] = 226268,
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
        ["comment"] = "Water Elemental",
        ["id"] = 208441,
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
        ["comment"] = "Overfiend",
        ["id"] = 217429,
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
        ["comment"] = "Void Lasher",
        ["id"] = 198757,
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
        ["comment"] = "Voidwraith",
        ["id"] = 224466,
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
        ["comment"] = "Nazgrim",
        ["id"] = 221634,
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
        ["comment"] = "King Thoras Trollbane",
        ["id"] = 221635,
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
        ["comment"] = "High Inquisitor Whitemane",
        ["id"] = 221633,
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
        ["comment"] = "Pit Lord",
        ["id"] = 228574,
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
        ["comment"] = "Charhound",
        ["id"] = 226269,
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
        ["comment"] = "Bear - Pack Leader",
        ["id"] = 234018,
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
        ["comment"] = "Thing From Beyond",
        ["id"] = 189988,
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
        ["comment"] = "Mother of Chaos",
        ["id"] = 228576,
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
        ["comment"] = "Lesser Primal Storm Elemental",
        ["id"] = 229798,
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
        ["comment"] = "Overlord",
        ["id"] = 228575,
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
        ["comment"] = "Lesser Fire Elemental",
        ["id"] = 229800,
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
        ["comment"] = "Lesser Storm Elemental",
        ["id"] = 229801,
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
        ["comment"] = "Lesser Primal Fire Elemental",
        ["id"] = 229799,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Wild Imp (Warlock)",
        },
        },
        ["partyIndicatorModeOne"] = false,
        ["adjustPersonalBarPosition"] = false,
        ["classIndicator"] = false,
        ["alwaysHideEnemyCastbar"] = false,
        ["removeRealmNames"] = true,
        ["questIndicatorXPos"] = 0,
        ["otherNpdeBuffFilterBlacklist"] = true,
        ["castBarIconXPos"] = 0,
        ["classIndicatorFriendly"] = true,
        ["fadeNPCPvPOnly"] = false,
        ["sortCompactedAurasFirst"] = false,
        ["totemIndicatorNpcList"] = {
        [60561] = {
        ["duration"] = 20,
        ["name"] = "Earthgrab Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.7803922295570374,
        0.5098039507865906,
        0.388235330581665,
        },
        ["important"] = false,
        ["icon"] = 136100,
        ["size"] = 24,
        },
        [89] = {
        ["duration"] = 60,
        ["name"] = "Infernal",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.69,
        0,
        },
        ["important"] = false,
        ["icon"] = 136219,
        ["size"] = 24,
        },
        [62982] = {
        ["duration"] = 15,
        ["name"] = "Mindbender",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.69,
        0,
        },
        ["important"] = false,
        ["icon"] = 136214,
        ["size"] = 24,
        },
        [59764] = {
        ["duration"] = 10,
        ["name"] = "Healing Tide Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0,
        1,
        0.388235330581665,
        },
        ["important"] = true,
        ["icon"] = 538569,
        ["size"] = 30,
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
        [59398] = {
        ["important"] = false,
        ["name"] = "Demoralizing Banner",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.6901960968971252,
        0,
        },
        ["duration"] = 15,
        ["icon"] = 604449,
        ["size"] = 24,
        },
        [59390] = {
        ["important"] = false,
        ["name"] = "Mocking Banner",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.6901960968971252,
        0,
        },
        ["duration"] = 30,
        ["icon"] = 604450,
        ["size"] = 24,
        },
        [5913] = {
        ["duration"] = 6,
        ["name"] = "Tremor Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.5333333611488342,
        0.8980392813682556,
        0.0941176563501358,
        },
        ["important"] = true,
        ["icon"] = 136108,
        ["size"] = 30,
        },
        [19668] = {
        ["important"] = false,
        ["name"] = "Shadowfiend",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.69,
        0,
        },
        ["duration"] = 12,
        ["icon"] = 136199,
        ["size"] = 24,
        },
        [15430] = {
        ["important"] = false,
        ["name"] = "Earth Elemental Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.7803922295570374,
        0.5098039507865906,
        0.388235330581665,
        },
        ["duration"] = 60,
        ["icon"] = 136024,
        ["size"] = 24,
        },
        [5925] = {
        ["duration"] = 15,
        ["name"] = "Grounding Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0,
        1,
        },
        ["important"] = true,
        ["icon"] = 136039,
        ["size"] = 30,
        },
        [5929] = {
        ["duration"] = 60,
        ["name"] = "Magma Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.09019608050584793,
        0.02745098248124123,
        },
        ["important"] = false,
        ["icon"] = 135826,
        ["size"] = 24,
        },
        [2523] = {
        ["duration"] = 60,
        ["name"] = "Searing Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.09019608050584793,
        0.02745098248124123,
        },
        ["important"] = false,
        ["icon"] = 135825,
        ["size"] = 24,
        },
        [58997] = {
        ["duration"] = 60,
        ["name"] = "Abyssal",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.6901960968971252,
        0,
        },
        ["important"] = false,
        ["icon"] = 524350,
        ["size"] = 24,
        },
        [15439] = {
        ["duration"] = 60,
        ["name"] = "Fire Elemental Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.09019608050584793,
        0.02745098248124123,
        },
        ["important"] = false,
        ["icon"] = 135790,
        ["size"] = 24,
        },
        [59399] = {
        ["important"] = true,
        ["name"] = "Skull Banner",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0,
        1,
        },
        ["duration"] = 10,
        ["icon"] = 603532,
        ["size"] = 30,
        },
        [11859] = {
        ["duration"] = 60,
        ["name"] = "Doomguard",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.7176470756530762,
        0,
        },
        ["important"] = true,
        ["icon"] = 615103,
        ["size"] = 30,
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
        [59712] = {
        ["important"] = true,
        ["name"] = "Stone Bulwark Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.7803922295570374,
        0.5098039507865906,
        0.388235330581665,
        },
        ["duration"] = 30,
        ["icon"] = 538572,
        ["size"] = 30,
        },
        [59000] = {
        ["duration"] = 60,
        ["name"] = "Terrorguard",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.7098039388656616,
        0,
        },
        ["important"] = true,
        ["icon"] = 615098,
        ["size"] = 30,
        },
        [3527] = {
        ["duration"] = 15,
        ["name"] = "Healing Stream Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0,
        0.4745098352432251,
        1,
        },
        ["important"] = false,
        ["icon"] = 135127,
        ["size"] = 24,
        },
        [2630] = {
        ["duration"] = 20,
        ["name"] = "Earthbind Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.78,
        0.51,
        0.39,
        },
        ["important"] = false,
        ["icon"] = 136102,
        ["size"] = 24,
        },
        [59717] = {
        ["important"] = false,
        ["name"] = "Windwalk Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.1176470667123795,
        0.8313726186752319,
        0.7882353663444519,
        },
        ["duration"] = 6,
        ["icon"] = 538576,
        ["size"] = 24,
        },
        [59190] = {
        ["important"] = true,
        ["name"] = "Psyfiend",
        ["hideIcon"] = false,
        ["color"] = {
        0.4823529720306397,
        0,
        1,
        },
        ["duration"] = 10,
        ["icon"] = 537021,
        ["size"] = 30,
        },
        [27829] = {
        ["duration"] = 30,
        ["name"] = "Gargoyle",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.686274528503418,
        0,
        },
        ["important"] = true,
        ["icon"] = 458967,
        ["size"] = 30,
        },
        [62002] = {
        ["duration"] = 10,
        ["name"] = "Stormlash Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0.1019607931375504,
        0.8313726186752319,
        0.7882353663444519,
        },
        ["important"] = false,
        ["icon"] = 538575,
        ["size"] = 24,
        },
        [53006] = {
        ["duration"] = 6,
        ["name"] = "Spirit Link Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0,
        1,
        0.7529412508010864,
        },
        ["important"] = true,
        ["icon"] = 237586,
        ["size"] = 30,
        },
        [65282] = {
        ["duration"] = 8,
        ["name"] = "Void Tendril",
        ["hideIcon"] = false,
        ["color"] = {
        0.3294117748737335,
        0.3686274588108063,
        1,
        },
        ["important"] = false,
        ["icon"] = 537022,
        ["size"] = 24,
        },
        [10467] = {
        ["important"] = true,
        ["name"] = "Mana Tide Totem",
        ["hideIcon"] = false,
        ["color"] = {
        0,
        1,
        0.7568628191947937,
        },
        ["duration"] = 16,
        ["icon"] = 135861,
        ["size"] = 30,
        },
        [61245] = {
        ["duration"] = 5,
        ["name"] = "Capacitor Totem",
        ["hideIcon"] = false,
        ["color"] = {
        1,
        0.6784313917160034,
        0,
        },
        ["important"] = true,
        ["icon"] = 136013,
        ["size"] = 30,
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
        ["nameplateEnemyWidth"] = 130,
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
        ["sortEnlargedAurasFirst"] = true,
        ["castBarIconPosReset"] = true,
        ["classIndicatorFrameStrataHigh"] = false,
        ["absorbIndicatorXPos"] = 0,
        ["partyIndicatorModeFive"] = false,
        ["showGuildNames"] = false,
        ["healerIndicatorEnemyXPos"] = 0,
        ["hpHeightFriendly"] = 4,
        ["importantCCSilenceGlow"] = true,
        ["healerIndicatorEnemyAnchor"] = "TOPRIGHT",
        ["importantCCFullGlow"] = true,
        ["combatIndicatorAssumePalaCombat"] = false,
        ["hideCastbarText"] = false,
        ["hpHeightEnemy"] = 4,
        ["arenaIndicatorModeTwo"] = false,
        ["nameplateEnemyWidthScale"] = 130,
        ["castBarEmphasisHeight"] = false,
        ["otherNpBuffFilterAll"] = false,
        ["castBarIconYPos"] = 0,
        ["hideFriendlyNameText"] = true,
        ["nameplateResourceOnTarget"] = "0",
        ["fakeNameAnchor"] = "BOTTOM",
        ["nameplateDefaultEnemyWidth"] = 110,
        ["classIconBgOnly"] = false,
        ["classIconEnemyHealIcon"] = true,
        ["hideDefaultPersonalNameplateAuras"] = false,
        ["npcTitleColor"] = false,
        ["partyPointerTestMode"] = false,
        ["personalNpBuffFilterBlizzard"] = true,
        ["petIndicatorTestMode"] = false,
        ["personalNpBuffFilterLessMinite"] = false,
        ["nameplateKeyAurasHorizontalGap"] = 5,
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
        ["classIndicatorHealer"] = false,
        ["nameplateAuraRowFriendlyAmountScale"] = 6,
        ["hideNPCWhitelistOn"] = false,
        ["nameplateAuraTaller"] = false,
        ["petIndicatorYPos"] = 0,
        ["changeResourceStrata"] = false,
        ["raidmarkIndicator"] = false,
        ["defaultLargeNamePlateFont"] = "Fonts\\FRIZQT__.TTF",
        ["nameplateVerticalPosition"] = 0,
        ["executeIndicatorAnchor"] = "LEFT",
        ["arenaIdYPos"] = 0,
        ["dpsOrHealFullAggroColorRGB"] = {
        1,
        0,
        0,
        1,
        },
        ["classIndicatorHighlight"] = false,
        ["nameplateFriendlyWidthScale"] = 130,
        ["petIndicatorColorHealthbar"] = false,
        ["nameplateDefaultFriendlyHeight"] = 45,
        ["classIndicatorSpecIcon"] = false,
        ["castBarEmphasisSpark"] = false,
        ["totemIndicatorColorName"] = true,
        ["customFontSizeEnabled"] = false,
        ["partyPointerHideRaidmarker"] = true,
        ["alwaysShowPurgeTexture"] = true,
        ["friendlyNpBuffFilterBlacklist"] = true,
        ["castBarInterruptHighlighter"] = false,
        ["totemIndicatorHideHealthBar"] = false,
        ["friendlyNpBuffFilterAll"] = false,
        ["targetIndicatorColorNameplate"] = false,
        ["updates"] = "1.8.2h",
        ["classIndicatorFriendlyAnchor"] = "TOP",
        ["personalNpdeBuffEnable"] = false,
        ["hideNpcMurlocYPos"] = 0,
        ["nameplateDefaultEnemyHeight"] = 45,
        ["useCustomCastbarTexture"] = false,
        ["otherNpBuffFilterWatchList"] = true,
        ["nameplateShowEnemyTotems"] = "1",
        ["nameplateTargetBorderSize"] = 3,
        ["showNameplateCastbarTimer"] = false,
        ["levelFrameFontSize"] = 12,
        ["partyIndicatorModeOff"] = false,
        ["otherNpdeBuffPandemicGlow"] = false,
        ["useCustomTextureForSelf"] = false,
        ["useCustomTextureForFriendly"] = true,
        ["castBarShieldAnchor"] = "LEFT",
        ["enableNpNonTargetAlpha"] = false,
        ["partyPointerHighlightRGB"] = {
        1,
        0.71,
        0,
        },
        ["nameplateAuraTestMode"] = false,
        ["nameplateMinAlpha"] = 1,
        ["targetNameplateAuraScale"] = 1,
        ["showDefaultCooldownNumbersOnNpAuras"] = false,
        ["focusTargetIndicatorColorNameplate"] = false,
        ["reopenOptions"] = false,
        ["hasSaved"] = true,
        ["friendlyNpdeBuffFilterBlacklist"] = true,
        ["otherNpdeBuffFilterBlizzard"] = false,
        ["friendIndicator"] = false,
        ["defaultLargeFontSize"] = 12,
        ["keyAurasImportantBuffsEnabled"] = true,
        ["useFakeNameAnchorBottom"] = false,
        ["nameplateGeneralHeight"] = 32,
        ["enemyColorName"] = false,
        ["mopBetaUpdated3"] = true,
        ["friendlyNpBuffFilterOnlyMe"] = false,
        ["importantCCRootGlowRGB"] = {
        ["a"] = 1,
        ["r"] = 1,
        ["g"] = 0.874,
        ["b"] = 0,
        },
        ["auraWhitelist"] = {
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 131894,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "A Murder of Crows",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 126046,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Adaptation",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 980,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Agony",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 23335,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Alliance Flag",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 110909,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Alter Time",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114214,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Angelic Bulwark",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 48707,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Anti-Magic Shell",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 145629,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Anti-Magic Zone",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114919,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Arcing Light",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 31850,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Ardent Defender",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 108271,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Astral Shift",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 106996,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Astral Storm",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 31821,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Aura Mastery",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 116198,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Aura of Enfeeblement",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 116202,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Aura of the Elements",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 115213,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Avert Harm",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 22812,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Barkskin",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 18499,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Berserker Rage",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 3674,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Black Arrow",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 11113,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Blast Wave",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "",
        ["id"] = 1044,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Blessing of Freedom",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 1022,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Blessing of Protection",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 6940,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Blessing of Sacrifice",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 111397,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Blood Horror",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 55078,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Blood Plague",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 147531,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Bloodbath",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 123725,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Breath of Fire",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 110300,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Burden of Guilt",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "",
        ["id"] = 111400,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Burning Rush",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 102351,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Cenarion Ward",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 31803,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Censure",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 45524,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Chains of Ice",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 124915,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Chaos Wave",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 31230,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Cheat Death",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 45182,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Cheating Death",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 50435,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Chilblains",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 12486,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Chilled",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 31224,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Cloak of Shadows",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 86346,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Colossus Smash",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 74001,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Combat Readiness",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = false,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 83853,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Combustion",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 35101,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Concussive Barrage",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 5116,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Concussive Shot",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 120,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Cone of Cold",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 17962,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Conflagrate",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 108685,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Conflagrate",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 146739,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Corruption",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 122233,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Crimson Tempest",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 109466,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Enfeeblement",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 109468,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Enfeeblement",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 18223,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Exhaustion",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 104223,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of Exhaustion",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = false,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 104225,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of the Elements",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = false,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 1490,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Curse of the Elements",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 122278,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Dampen Harm",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 81256,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Dancing Rune Weapon",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114168,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Dark Apotheosis",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 108416,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Dark Pact",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 108359,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Dark Regeneration",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 77606,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Dark Simulacrum",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 50259,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Dazed",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 63529,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Dazed - Avenger's Shield",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 26679,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Deadly Throw",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 96268,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Death's Advance",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 115196,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Debilitating Poison",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 47897,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Demonic Breath",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = false,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 1160,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Demoralizing Shout",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 2812,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Denounce",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 19236,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Desperate Prayer",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 2944,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Devouring Plague",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 118038,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Die by the Sword",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 122783,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Diffuse Magic",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 116095,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Disable",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 47585,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Dispersion",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 498,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Divine Protection",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 116330,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Dizzying Haze",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 123727,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Dizzying Haze",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 603,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Doom",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 3600,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Earthbind",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 77478,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Earthquake",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 115308,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Elusive Brew",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 55694,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Enraged Regeneration",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 5277,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Evasion",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = false,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114916,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Execution Sentence",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = false,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 770,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Faerie Fire",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = false,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 102355,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Faerie Swarm",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 6346,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Fear Ward",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 5384,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Feign Death",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 1966,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Feint",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 91021,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Find Weakness",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 8050,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Flame Shock",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 123586,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Flying Serpent Kick",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 120954,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Fortifying Brew",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 124769,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Frenzied Regeneration",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = false,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 112948,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Frost Bomb",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 113092,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Frost Bomb",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 55095,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Frost Fever",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 8056,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Frost Shock",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 116,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Frostbolt",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 44614,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Frostfire Bolt",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 84721,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Frozen Orb",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 61394,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Frozen Wake",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 81281,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Fungal Growth",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 119839,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Fury Ward",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 703,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Garrote",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 121414,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Glaive Toss",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 115760,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Glyph of Ice Block",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 113862,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Greater Invisibility",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 89523,
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
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 8178,
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
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 86659,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Guardian of Ancient Kings",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 47788,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Guardian Spirit",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 1715,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Hamstring",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114039,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Hand of Purity",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 48181,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Haunt",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 80240,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Havoc",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 14914,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Holy Fire",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 23333,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Horde Flag",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 16914,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Hurricane",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 135299,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Ice Trap",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 111264,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Ice Ward",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 48792,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Icebound Fortitude",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 413841,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Ignite",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 108686,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Immolate",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 348,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Immolate",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 58180,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Infected Wounds",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 96267,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Inner Focus",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 29166,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Innervate",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 147833,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Intervene",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 102342,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Ironbark",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 33745,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Lacerate",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 12975,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Last Stand",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 118585,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Leer of the Ox",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 49039,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Lichborne",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 116849,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Life Cocoon",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "",
        ["id"] = 33763,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Lifebloom",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 44457,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Living Bomb",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 137619,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Marked for Death",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114028,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Mass Spell Reflection",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "",
        ["id"] = 54216,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Master's Call",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 106922,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Might of Ursoc",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = false,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 115194,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Mind Paralysis",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 8921,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Moonfire",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 16689,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Nature's Grasp",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 132158,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Nature's Swiftness",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 73975,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Necrotic Strike",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 112947,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Nerve Strike",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114923,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Nether Tempest",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 34976,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Netherstorm Flag",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 60947,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Nightmare",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 137562,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Nimble Brew",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 33206,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Pain Suppression",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 113952,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Paralytic Poison",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114239,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Phantasm",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 12323,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Piercing Howl",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 9007,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Pounce Bleed",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 81782,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Power Word: Barrier",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 11366,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Pyroblast",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 132210,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Pyromaniac",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 1822,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Rake",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 97463,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Rallying Cry",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 118347,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Reinforce",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 115000,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Remorseless Winter",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 84617,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Revealing Strike",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 1079,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Rip",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 53480,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Roar of Sacrifice",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 1943,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Rupture",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114029,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Safeguard",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 132402,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Savage Defense",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 20170,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Seal of Justice",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 114790,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Seed of Corruption",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 27243,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Seed of Corruption",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 118253,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Serpent Sting",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 132413,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shadow Bulwark",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 589,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shadow Word: Pain",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 47960,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Shadowflame",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 58984,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shadowmeld",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 30823,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Shamanistic Rage",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 64382,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Shattering Throw",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 871,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Shield Wall",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 115307,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shuffle",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 31589,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Slow",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 129923,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Sluggish",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 88611,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Smoke Bomb",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 130735,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Soul Reaper",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 114866,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Soul Reaper",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 130736,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Soul Reaper",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "",
        ["id"] = 79438,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Soulburn: Demonic Circle",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 23920,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Spell Reflection",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 98007,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Spirit Link Totem",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 17364,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Stormstrike",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        },
        ["comment"] = "",
        ["id"] = 115192,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Subterfuge",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 93402,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Sunfire",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 61336,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Survival Instincts",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 115610,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Temporal Shield",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 77758,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Thrash",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 106830,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Thrash",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 51490,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Thunderstorm",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 122470,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Touch of Karma",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 125174,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Touch of Karma",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 126697,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Tremendous Fortitude",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 61391,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Typhoon",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 104773,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Unending Resolve",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 73682,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Unleash Frost",
        },
        {
        ["flags"] = {
        ["compacted"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 118475,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Unleashed Fury",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 118470,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Unleashed Fury",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 30108,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Unstable Affliction",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 127797,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Ursol's Vortex",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 55233,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Vampiric Blood",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 15286,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Vampiric Embrace",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 34914,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Vampiric Touch",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["onlyMine"] = true,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 79140,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Vendetta",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 114030,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Vigilance",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 137637,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Warbringer",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 113746,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Weakened Armor",
        },
        {
        ["flags"] = {
        ["onlyMine"] = true,
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 82654,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Widow Venom",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 81162,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Will of the Necropolis",
        },
        {
        ["flags"] = {
        ["important"] = false,
        ["pandemic"] = false,
        },
        ["comment"] = "",
        ["id"] = 114896,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Windwalk Totem",
        },
        {
        ["flags"] = {
        ["pandemic"] = false,
        ["important"] = false,
        ["enlarged"] = true,
        ["compacted"] = false,
        },
        ["comment"] = "",
        ["id"] = 115176,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Zen Meditation",
        },
        },
        ["disableEnlargedAurasOnSelf"] = true,
        ["nameplateAurasYPosYPos"] = -10,
        ["hideNameplateAuraTooltip"] = false,
        ["nameplatePlayerLargerScale"] = 1.8,
        ["totemListUpdateTWW4"] = true,
        ["castBarHeightHeight"] = 15,
        ["importantBuffsOffensives"] = true,
        ["nameplateResourceDoNotRaiseAuras"] = false,
        ["nameplateMotion"] = "0",
        ["classIndicatorFriendlyXPos"] = 0,
        ["castBarInterruptHighlighterEndPercentage"] = 80,
        ["arenaIndicatorModeOne"] = true,
        ["nameplateDefaultLargeFriendlyHeight"] = 64.125,
        ["absorbIndicatorScale"] = 1,
        ["nameplateBorderSize"] = 1,
        ["arenaIndicatorModeFour"] = false,
        ["nameplateAuraSquare"] = false,
        ["partyPointerHealerScaleScale"] = 1.25,
        ["partyPointerYPos"] = -40,
        ["anonMode"] = false,
        ["auraColorPvEOnly"] = false,
        ["executeIndicator"] = false,
        ["onlyShowHighlightedNpShadow"] = false,
        ["friendlyNameplateNonstackable"] = true,
        ["totemListUpdateTWW3"] = true,
        ["healerIndicatorEnemyYPos"] = 0,
        ["personalBarPosition"] = 0.5,
        ["healthNumbersOnlyInCombat"] = false,
        ["hidePetCastbars"] = false,
        ["enableCastbarCustomization"] = true,
        ["healthNumbersHideSelf"] = false,
        ["customTextureSelfMana"] = "Solid",
        ["customFontSize"] = 12,
        ["hideEliteDragon"] = false,
        ["castBarEmphasisTextScale"] = 2,
        ["targetHighlightFix"] = false,
        ["npBorderNonTargetColorRGB"] = {
        0,
        0,
        0,
        1,
        },
        ["totemListUpdateTWW5"] = true,
        ["skipCVarsPlater"] = true,
        ["nameplateMinAlphaScale"] = 1,
        ["nameplateGlobalScale"] = 1,
        ["fadeOutNPCOnlyFadeSecondaryPets"] = true,
        ["classIndicatorCCAuras"] = true,
        ["mopBetaData"] = {
        ["spells"] = {
        },
        ["auras"] = {
        },
        ["npcs"] = {
        },
        },
        ["hpHeightSelf"] = 10.8,
        ["bgIndicatorShowFlags"] = true,
        ["healthNumbersScale"] = 1,
        ["castBarShieldYPos"] = 0,
        ["totemIndicatorHideAuras"] = true,
        ["useCustomTextureForSelfMana"] = false,
        ["nameplateDefaultLargeEnemyHeight"] = 64.125,
        ["keepNpShadowTargetHighlighted"] = false,
        ["classIconAlwaysShowBgObj"] = true,
        ["showNameplateShadow"] = false,
        ["raidmarkIndicatorRaiseStrata"] = false,
        ["classIconAlwaysShowHealer"] = true,
        ["hideCastbarWhitelistOn"] = false,
        ["importantBuffsMobilityGlow"] = true,
        ["disableImportantAurasOnSelf"] = true,
        ["tankNoAggroColorRGB"] = {
        1,
        0,
        0,
        1,
        },
        ["bgIndicatorYPos"] = 0,
        ["hideTempHpLoss"] = false,
        ["customFontOutline"] = "THINOUTLINE",
        ["nameplateResourceYPosYPos"] = 0,
        ["classIndicatorHighlightColor"] = false,
        ["focusTargetIndicatorScale"] = 1,
        ["hideNameDuringCast"] = false,
        ["enemyColorThreatHideSolo"] = false,
        ["useCustomTextureForBars"] = false,
        ["useCustomTextureForExtraBars"] = false,
        ["partyPointerWidthScale"] = 36,
        ["showNameplateTargetText"] = false,
        ["classIndicatorTank"] = true,
        ["nameplateNonTargetAlpha"] = 0.5,
        ["personalNpdeBuffFilterLessMinite"] = false,
        ["friendlyNpBuffEmphasisedBorder"] = false,
        ["blizzardDefaultFilterOnlyMine"] = false,
        ["partyIDScale"] = 1,
        ["customHpFriendlyHeight"] = 0,
        ["classIndicatorHideName"] = false,
        ["arenaIdAnchorRaiseStrata"] = false,
        ["exportVersion"] = "BBP: 1.8.2h WoW: 5.5.0",
        ["petIndicator"] = true,
        ["enemyNameplateHealthbarHeight"] = 11,
        ["alwaysHideFriendlyCastbar"] = false,
        ["customFont"] = "Prototype",
        ["nameplateSelfHeight"] = 32,
        ["ShowClassColorInNameplate"] = "1",
        ["fakeNameAnchorRelative"] = "TOP",
        ["enableNpVerticalPos"] = false,
        ["importantCCFullGlowRGB"] = {
        ["a"] = 1,
        ["r"] = 1,
        ["g"] = 0.874,
        ["b"] = 0,
        },
        ["nameplateAurasXPosXPos"] = 0,
        ["nameplateAuraEnlargedScaleScale"] = 1,
        ["personalNpBuffEnable"] = true,
        ["auraWhitelistAlphaUpdated"] = true,
        ["raidmarkIndicatorAnchor"] = "TOP",
        ["hideNPCPetsOnly"] = false,
        ["npBorderClassColor"] = false,
        ["partyPointerScaleScale"] = 1.25,
        ["executeIndicatorTestMode"] = false,
        ["npBorderTargetColorRGB"] = {
        1,
        1,
        1,
        1,
        },
        ["totemIndicatorAnchor"] = "TOP",
        ["partyPointerHealerReplace"] = true,
        ["totemIndicatorYPos"] = 0,
        ["nameplateNotSelectedAlpha"] = "0.5",
        ["hideCastbarIcon"] = false,
        ["tankLosingAggroColorRGB"] = {
        1,
        0.47,
        0,
        1,
        },
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
        ["enemyHealthBarColorNpcOnly"] = false,
        ["nameplateShowFriendlyPets"] = "0",
        ["npAuraOtherRGB"] = {
        0,
        0,
        0,
        },
        ["doNotHideFriendlyHealthbarInPve"] = false,
        ["totemIndicatorNoAnimation"] = false,
        ["toggleNamesOffDuringPVE"] = false,
        ["nameplateResourceUnderCastbar"] = true,
        ["classIndicatorFriendlyYPos"] = 0,
        ["friendlyColorName"] = false,
        ["hideNpAuraSwipe"] = false,
        ["healerIndicatorBgOnly"] = false,
        ["nameplateAuraPlayersOnly"] = false,
        ["changeNameplateBorderSize"] = false,
        ["nameplateAuraCompactedScale"] = 1,
        ["arenaIndicatorIDColorRGB"] = {
        1,
        0.819607,
        0,
        1,
        },
        ["customTextureSelf"] = "Solid",
        ["nameplateMotionSpeedScale"] = 0.03,
        ["defaultFontSize"] = 9,
        ["combatIndicatorAnchor"] = "CENTER",
        ["nameplateAuraHeightGap"] = 4,
        ["hideNpcCastbar"] = false,
        ["npBorderDesaturate"] = true,
        ["fakeNameScaleWithParent"] = false,
        ["npBorderTargetColor"] = false,
        ["npColorAuraBorder"] = false,
        ["bgIndicatorAnchor"] = "BOTTOM",
        ["classColorPersonalNameplate"] = false,
        ["enemyColorThreatCombatOnly"] = false,
        ["absorbIndicatorTestMode"] = false,
        ["normalCastbarForEmpoweredCasts"] = true,
        ["executeIndicatorFriendly"] = false,
        ["castBarInterruptHighlighterStartTime"] = 0.8,
        ["totemIndicatorHideNameAndShiftIconDown"] = false,
        ["threatColorAlwaysOn"] = false,
        ["showInterruptsOnNameplateAuras"] = false,
        ["combatIndicatorPlayersOnly"] = true,
        ["highlightNpShadowOnMouseover"] = false,
        ["nameplateMotionSpeed"] = 0.025,
        ["totemIndicatorDefaultCooldownTextSize"] = 0.85,
        ["nameplateMinAlphaDistanceScale"] = 10.1,
        ["healthNumbersSwapped"] = false,
        ["arenaModeSettingKey"] = "1: Replace name with Arena ID",
        ["classIconSquareBorder"] = false,
        ["nameplateResourceScaleScale"] = 0.7,
        ["friendlyNpdeBuffFilterAll"] = false,
        ["personalNpBuffFilterWatchList"] = true,
        ["combatIndicatorArenaOnly"] = false,
        ["bgIndicatorEnemyOnly"] = true,
        ["focusTargetIndicatorYPos"] = 0,
        ["personalNpdeBuffFilterBlacklist"] = true,
        ["mopBetaUpdated2"] = true,
        ["castBarIconPixelBorder"] = false,
        ["healerIndicatorEnemyScale"] = 1,
        ["healthNumbersTestMode"] = false,
        ["useCustomCastbarBGTexture"] = false,
        ["hideCastbarBorderShield"] = false,
        ["smallPetsInPvP"] = false,
        ["healthNumbersCombined"] = false,
        ["friendlyNpBuffPurgeGlow"] = false,
        ["fakeNameYPos"] = 0,
        ["onlyShowInterruptableCasts"] = false,
        ["personalNpdeBuffFilterAll"] = false,
        ["hideNPCHideOthersPets"] = false,
        ["importantBuffsOffensivesGlowRGB"] = {
        ["a"] = 1,
        ["r"] = 1,
        ["g"] = 0.5,
        ["b"] = 0,
        },
        ["totemIndicatorTestMode"] = false,
        ["partyPointerHighlight"] = false,
        ["friendlyNameplatesOnlyInDungeons"] = false,
        ["importantBuffsDefensivesGlow"] = true,
        ["nameplateResourceXPos"] = 0,
        ["nameplateAuraScale"] = 1,
        ["npBorderNeutralColorRGB"] = {
        1,
        1,
        0,
        1,
        },
        ["castBarIconScaleScale"] = 1,
        ["targetIndicatorXPos"] = 0,
        ["importantBuffsOffensivesGlow"] = true,
        ["fakeNameXPos"] = 0,
        ["enemyHealthBarColorRGB"] = {
        1,
        0,
        0,
        },
        ["keyAurasImportantGlowOn"] = true,
        ["healthNumbersFriendly"] = false,
        ["personalNpdeBuffFilterCC"] = false,
        ["nameplateShowEnemyPets"] = "1",
        ["nameplateKeyAurasXPos"] = 0,
        ["combatIndicatorScale"] = 1,
        ["personalNpBuffFilterAll"] = false,
        ["castbarQuickHide"] = true,
        ["nameplateOverlapHScale"] = 0.8,
        ["hideTargetHighlight"] = false,
        ["castBarInterruptHighlighterDontInterruptRGB"] = {
        0,
        0,
        0,
        },
        ["nameplateAuraEnlargedSquare"] = true,
        ["nameplateAuraEnlargedScale"] = 1,
        ["nameplateOverlapVScale"] = 0.8,
        ["npAuraPoisonRGB"] = {
        0,
        0.52,
        0.031,
        },
        ["focusTargetIndicatorXPos"] = 0,
        ["executeIndicatorUseTexture"] = false,
        ["arenaIndicatorModeFive"] = false,
        ["partyIndicatorModeFour"] = false,
        ["colorNpcList"] = {
        },
        ["npcTitleScale"] = 1,
        ["friendlyNpdeBuffEnable"] = false,
        ["partyPointerTargetIndicator"] = true,
        ["scTotem"] = true,
        ["combatIndicatorYPos"] = 0,
        ["showCircleOnArenaID"] = false,
        ["enableCastbarEmphasis"] = false,
        ["healerIndicator"] = true,
        ["partyPointerHealer"] = true,
        ["useFakeName"] = false,
        ["defaultNamePlateFont"] = "Fonts\\FRIZQT__.TTF",
        ["focusTargetIndicatorColorName"] = false,
        ["npcTitleColorRGB"] = {
        1,
        0.85,
        0,
        },
        ["importantCCRoot"] = true,
        ["setCVarAcrossAllCharacters"] = true,
        ["friendlyNameplateClickthrough"] = false,
        ["enableNameplateAuraCustomisation"] = true,
        ["healthNumbersTargetOnly"] = false,
        ["healthNumbersPercentSymbol"] = false,
        ["nameplateAuraBuffScale"] = 1,
        ["totemIndicatorColorHealthBar"] = true,
        ["arenaIndicatorTestMode"] = false,
        ["recolorTempHpLoss"] = false,
        ["nameplateAuraRowAmountScale"] = 6,
        ["healthNumbersAnchor"] = "CENTER",
        ["nameplateDefaultLargeFriendlyWidth"] = 154,
        ["importantBuffsMobility"] = true,
        ["personalNpdeBuffFilterWatchList"] = true,
        ["healthNumbersClassColor"] = false,
        ["fakeNameFriendlyYPos"] = 0,
        ["castBarEmphasisSparkHeight"] = 35,
        ["npAuraMagicRGB"] = {
        0.13,
        0.44,
        1,
        },
        ["hideNPCAllNeutral"] = false,
        ["classIndicatorAlpha"] = 1,
        ["castBarShieldXPos"] = 0,
        ["largeNameplates"] = false,
        ["absorbIndicatorEnemyOnly"] = false,
        ["absorbIndicatorAnchor"] = "LEFT",
        ["raidmarkerPvPOnly"] = false,
        ["healerIndicatorRedCrossEnemy"] = false,
        ["healthNumbers"] = false,
        ["showLastNameNpc"] = false,
        ["onlyPandemicAuraMine"] = true,
        ["nameplateShowEnemyMinions"] = "1",
        ["nameplateSelfWidth"] = 110,
        ["targetIndicatorHideIcon"] = false,
        ["enlargeAllImportantBuffs"] = true,
        ["petIndicatorAnchor"] = "CENTER",
        ["nameplateKeyAurasFriendlyAnchor"] = "RIGHT",
        ["importantCCFull"] = true,
        ["executeIndicatorTargetOnly"] = false,
        ["classIconSquareBorderFriendly"] = false,
        ["importantBuffsDefensivesGlowRGB"] = {
        ["a"] = 1,
        ["r"] = 1,
        ["g"] = 0.662,
        ["b"] = 0.945,
        },
        ["enemyNameScale"] = 1,
        ["testAllEnabledFeatures"] = false,
        ["raidmarkIndicatorScale"] = 1,
        ["nameplateSelfBottomInset"] = ".2",
        ["healerIndicatorXPos"] = 0,
        ["executeIndicatorAlwaysOn"] = false,
        ["healthNumbersFontSize"] = 9,
        ["combatIndicatorSap"] = false,
        ["hideNPCSecondaryShowMurloc"] = true,
        ["healthNumbersPlayers"] = true,
        ["nameplateAuraWidthGap"] = 4,
        ["overShields"] = true,
        ["castBarDragonflightShield"] = true,
        ["nameplateAuraCountScale"] = 1,
        ["wasOnLoadingScreen"] = false,
        ["executeIndicatorNotOnFullHp"] = false,
        ["focusTargetIndicatorAnchor"] = "TOPRIGHT",
        ["partyPointerHealerScale"] = 1.25,
        ["nameplateAuraPlayersOnlyShowTarget"] = false,
        ["enableNpNonTargetAlphaTargetOnly"] = true,
        ["petIndicatorShowMurloc"] = true,
        ["enemyNeutralHealthBarColorRGB"] = {
        1,
        1,
        0,
        },
        ["partyIndicatorModeThree"] = false,
        ["absorbIndicatorYPos"] = 0,
        ["friendlyNpBuffFilterImportantBuffs"] = false,
        ["nameplateDefaultFriendlyWidth"] = 110,
        ["castBarHeight"] = 16,
        ["friendlyHideHealthBar"] = false,
        ["healerIndicatorTestMode"] = false,
        ["hideResourceFrame"] = false,
        ["friendlyNpdeBuffFilterWatchList"] = false,
        ["nameplateKeyAurasYPos"] = 0,
        ["castBarEmphasisHealthbarColor"] = false,
        ["fadeOutNPCWhitelistOn"] = false,
        ["totemIndicator"] = true,
        ["nameplateAurasNoNameYPos"] = 0,
        ["ShowClassColorInFriendlyNameplate"] = "0",
        ["castBarCastColor"] = {
        1,
        0.8431373238563538,
        0.2000000178813934,
        },
        ["personalNpBuffFilterBlacklist"] = true,
        ["totemIndicatorScale"] = 1,
        ["sortDurationAuras"] = false,
        ["classIconHealerIconType"] = 2,
        ["guildNameColor"] = false,
        ["raidmarkIndicatorYPos"] = 0,
        ["executeIndicatorPercentSymbol"] = false,
        ["healthNumbersNpcs"] = true,
        ["healthNumbersCurrentFull"] = false,
        ["nameplateResourcePositionFix"] = true,
        ["showTotemIndicatorCooldownSwipe"] = true,
        ["nameplateMaxScale"] = 0.9,
        ["nameplateSelfTopInset"] = ".5",
        ["friendlyHideHealthBarNpc"] = false,
        ["nameplateDefaultLargeEnemyWidth"] = 154,
        ["partyPointerAnchor"] = "TOP",
        ["enemyColorThreat"] = false,
        ["healthNumbersPercentage"] = false,
        ["enemyClassColorName"] = false,
        ["hideLevelFrame"] = true,
        ["fakeNameFriendlyXPos"] = 0,
        ["totemIndicatorXPos"] = 0,
        ["useCustomFont"] = true,
        ["executeIndicatorXPos"] = 0,
        ["nameplateMinAlphaDistance"] = 10,
        ["nameplateOverlapH"] = 0.8,
        ["enemyColorNameRGB"] = {
        1,
        0,
        0,
        },
        ["hideCastbarEnemy"] = false,
        ["targetIndicatorTexture"] = "Checkered (BBP)",
        ["friendlyHealthBarColor"] = false,
        ["importantCCSilenceGlowRGB"] = {
        ["a"] = 1,
        ["r"] = 1,
        ["g"] = 0.874,
        ["b"] = 0,
        },
        ["partyPointerBgOnly"] = true,
        ["friendlyNameScale"] = 1,
        ["otherNpBuffEnable"] = true,
        ["nameplateCastbarTestMode"] = false,
        ["partyIndicatorModeTwo"] = false,
        ["bgIndicatorXPos"] = 0,
        ["nameplateAuraDebuffScale"] = 1,
        ["castBarEmphasisSelfColor"] = false,
        ["targetIndicatorAnchor"] = "TOP",
        ["hideNPC"] = true,
        ["nameplateOverlapV"] = 0.8,
        ["hideCastbarFriendly"] = false,
        ["nameplateAuraKeyAuraPositionEnabled"] = false,
        ["questIndicatorYPos"] = 0,
        ["arenaIndicatorIDColor"] = false,
        ["friendlyNpdeBuffFilterCC"] = false,
        ["enableCustomFontOutline"] = false,
        ["nameplateOccludedAlphaMult"] = 0.4,
        ["arenaIDScale"] = 1,
        ["focusTargetIndicator"] = false,
        ["castBarInterruptHighlighterStartPercentage"] = 15,
        ["npAuraCurseRGB"] = {
        0.47,
        0,
        0.78,
        },
        ["fadeOutNPCsWhitelist"] = {
        {
        ["id"] = 104818,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Ancestral Protection Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 61245,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Capacitor Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 78001,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Cloudburst Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 105451,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Counterstrike Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 2630,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Earthbind Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 100943,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Earthen Wall Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 60561,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Earthgrab Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 17252,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Felguard (Demo Pet)",
        ["comment"] = "",
        },
        {
        ["id"] = 417,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Felhunter (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 5925,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Grounding Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 114565,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Guardian Queen (prot pala)",
        ["comment"] = "",
        },
        {
        ["id"] = 3527,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Healing Stream Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 59764,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Healing Tide Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 165189,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Hunter Pet (they all have same ID)",
        ["comment"] = "",
        },
        {
        ["id"] = 89,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Infernal (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 97369,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Liquid Magma Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 10467,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Mana Tide Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 62982,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Monk Image (Red)",
        },
        {
        ["id"] = 107100,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Observer (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 5923,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Poison Cleansing Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 101398,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Psyfiend (Spriest)",
        ["comment"] = "",
        },
        {
        ["id"] = 225672,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Shadowfiend",
        },
        {
        ["id"] = 53006,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Spirit Link Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 179867,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Static Field Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 59712,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Stone Bulwark Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 194117,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Stoneskin Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 1863,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Surging Totem",
        },
        {
        ["id"] = 105427,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Totem of Wrath",
        ["comment"] = "",
        },
        {
        ["id"] = 194118,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Tranquil Air Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 5913,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Tremor Totem",
        ["comment"] = "",
        },
        {
        ["id"] = 135002,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
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
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Voidwrath (Priest)",
        },
        {
        ["id"] = 119052,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "War Banner",
        ["comment"] = "",
        },
        {
        ["id"] = 97285,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Wind Rush Totem",
        ["comment"] = "",
        },
        },
        ["nameplateAurasFriendlyCenteredAnchor"] = false,
        ["friendlyNpdeBuffFilterOnlyMe"] = false,
        ["nameplateKeyAurasAnchor"] = "RIGHT",
        ["changeNpHpBgColor"] = false,
        ["importantCCDisarmGlowRGB"] = {
        ["a"] = 1,
        ["r"] = 1,
        ["g"] = 0.874,
        ["b"] = 0,
        },
        ["partyPointerScale"] = 1.25,
        ["arenaSpecYPos"] = 0,
        ["fadeOutNPCsList"] = {
        {
        ["id"] = 226269,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Charhound (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 26125,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "DK pet",
        ["comment"] = "",
        },
        {
        ["id"] = 228224,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Fenryr (Hunter)",
        ["comment"] = "",
        },
        {
        ["id"] = 226268,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Gloomhound (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 228226,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Hati (Hunter)",
        ["comment"] = "",
        },
        {
        ["id"] = 221632,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Mograine (DK)",
        ["comment"] = "",
        },
        {
        ["id"] = 69792,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Monk SEF Image (Green)",
        ["comment"] = "",
        },
        {
        ["id"] = 69791,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Monk SEF Image (Red)",
        ["comment"] = "",
        },
        {
        ["id"] = 221634,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Nazgrim (DK)",
        ["comment"] = "",
        },
        {
        ["id"] = 103822,
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
        ["id"] = 221635,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Trollbane (DK)",
        ["comment"] = "",
        },
        {
        ["id"] = 135816,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Vilefiend (Warlock)",
        ["comment"] = "",
        },
        {
        ["id"] = 192337,
        ["entryColors"] = {
        ["text"] = {
        ["r"] = 0,
        ["g"] = 1,
        ["b"] = 0,
        },
        },
        ["name"] = "Void Tendril (Spriest)",
        ["comment"] = "",
        },
        {
        ["id"] = 208441,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Water Elemental (Mage)",
        ["comment"] = "",
        },
        {
        ["id"] = 221633,
        ["entryColors"] = {
        ["text"] = {
        ["b"] = 0,
        ["g"] = 1,
        ["r"] = 0,
        },
        },
        ["name"] = "Whitemane (DK)",
        ["comment"] = "",
        },
        },
        ["npBorderFocusColorRGB"] = {
        0,
        0,
        0,
        1,
        },
        ["otherNpBuffPurgeGlow"] = false,
        ["friendlyNpBuffEnable"] = false,
        ["version"] = "1.00",
        ["guildNameColorRGB"] = {
        0,
        1,
        0,
        },
        ["hideCastbar"] = false,
        ["petIndicatorXPos"] = 0,
        ["nameplateCenterAllRows"] = false,
        ["nameplateResourceXPosXPos"] = 0,
        ["smallPetsWidth"] = 20,
        ["totemListUpdateTWW2"] = true,
        ["nameplateSelectedAlpha"] = "1",
        ["friendlyNameplatesOnlyInEpicBgs"] = false,
        ["bgIndicatorTestMode"] = false,
        ["showCastBarIconWhenNoninterruptible"] = true,
        ["friendlyHealthBarColorNpc"] = false,
        ["defaultNpAuraCdSize"] = 0.5,
        ["focusTargetIndicatorColorNameplateRGB"] = {
        1,
        1,
        1,
        },
        ["nameplateAuraAnchor"] = "BOTTOMLEFT",
        ["totemIndicatorShieldType"] = 1,
        ["druidOverstacks"] = true,
        ["nameplateAuraRowFriendlyAmount"] = 6,
        ["nameplateMaxAlphaDistance"] = 40,
        ["castBarEmphasisHeightValue"] = 24,
        ["partyPointerClassColor"] = true,
        ["nameplateAuraDebuffSelfScale"] = 1,
        ["castBarIconAnchor"] = "LEFT",
        ["friendlyColorNameRGB"] = {
        1,
        1,
        1,
        },
        ["totemIndicatorEnemyOnly"] = true,
        ["questIndicatorScale"] = 1,
        ["customHpHeight"] = 0,
        ["friendlyNpdeBuffFilterBlizzard"] = false,
        ["nameplateAurasXPos"] = 0,
        ["castBarTextScaleScale"] = 1,
        ["totemListUpdateTWW1"] = true,
        ["targetIndicator"] = false,
        ["castBarShieldScale"] = 1,
        ["maxAurasOnNameplate"] = 12,
        ["friendlyNameplatesOnlyInArena"] = true,
        ["firstSaveComplete"] = true,
        ["nameplateNotSelectedAlphaScale"] = 1,
    }

    if not SkillCappedBackupDB.BetterBlizzPlatesDB then
        SkillCappedBackupDB.BetterBlizzPlatesDB = SC:DeepCopy(BetterBlizzPlatesDB)
        SkillCappedBackupDB.addonBackupTimes["BetterBlizzPlates"] = SC:GetDateAndTime()
    end

    BetterBlizzPlatesDB = scBetterBlizzPlatesDB
    BetterBlizzPlatesDB.scStart = true
    BetterBlizzPlatesDB.skipCVarsPlater = true
end