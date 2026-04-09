local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:OmniBarDB()
    local scOmniBarDB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["global"] = {
        ["cooldowns"] = {
        [6346] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 120,
        },
        ["class"] = "PRIEST",
        ["icon"] = 135902,
        ["name"] = "Fear Ward",
        },
        [118038] = {
        ["name"] = "Die by the Sword",
        ["specID"] = {
        71,
        },
        ["class"] = "WARRIOR",
        ["icon"] = 132336,
        ["duration"] = {
        ["default"] = 120,
        },
        },
        [853] = {
        ["name"] = "Hammer of Justice",
        ["adjust"] = {
        ["Protection"] = -30,
        ["default"] = -20,
        },
        ["class"] = "PALADIN",
        ["icon"] = 135963,
        ["duration"] = {
        ["default"] = 60,
        },
        },
        [36554] = {
        ["name"] = "Shadowstep",
        ["adjust"] = -10,
        ["class"] = "ROGUE",
        ["icon"] = 132303,
        ["duration"] = {
        ["default"] = 24,
        },
        },
        [32379] = {
        ["class"] = "PRIEST",
        ["duration"] = {
        ["default"] = 8,
        },
        ["name"] = "Shadow Word: Death",
        ["icon"] = 136149,
        },
        [60192] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 30,
        },
        ["class"] = "HUNTER",
        ["icon"] = 135834,
        ["name"] = "Freezing Trap",
        },
        [115213] = {
        ["custom"] = true,
        ["name"] = "Avert Harm",
        ["class"] = "MONK",
        ["icon"] = 627605,
        ["duration"] = {
        ["default"] = 180,
        },
        },
        [90337] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 60,
        },
        ["class"] = "HUNTER",
        ["icon"] = 132159,
        ["name"] = "Bad Manner",
        },
        [5211] = {
        ["icon"] = 132114,
        ["class"] = "DRUID",
        ["name"] = "Mighty Bash",
        ["duration"] = {
        ["default"] = 50,
        },
        },
        [114039] = {
        ["custom"] = true,
        ["name"] = "Hand of Purity",
        ["duration"] = {
        ["default"] = 30,
        },
        ["icon"] = 135970,
        ["class"] = "PALADIN",
        },
        [119381] = {
        ["duration"] = {
        ["default"] = 45,
        },
        ["class"] = "MONK",
        ["icon"] = 642414,
        ["name"] = "Leg Sweep",
        },
        [116849] = {
        ["name"] = "Life Cocoon",
        ["specID"] = {
        270,
        },
        ["class"] = "MONK",
        ["icon"] = 627485,
        ["duration"] = {
        ["default"] = 120,
        },
        },
        [129176] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 8,
        },
        ["class"] = "PRIEST",
        ["icon"] = 136149,
        ["name"] = "Shadow Word: Death",
        },
        [147362] = {
        ["default"] = true,
        ["duration"] = {
        ["default"] = 24,
        },
        ["class"] = "HUNTER",
        ["specID"] = {
        253,
        254,
        },
        ["icon"] = 249170,
        ["name"] = "Counter Shot",
        },
        [57994] = {
        ["default"] = true,
        ["class"] = "SHAMAN",
        ["adjust"] = {
        ["Elemental"] = -1,
        ["Enhancement"] = -1,
        },
        ["duration"] = {
        ["default"] = 12,
        },
        ["icon"] = 136018,
        ["name"] = "Wind Shear",
        },
        [6552] = {
        ["default"] = true,
        ["class"] = "WARRIOR",
        ["duration"] = {
        ["default"] = 15,
        },
        ["icon"] = 132938,
        ["name"] = "Pummel",
        },
        [112833] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 30,
        },
        ["class"] = "PRIEST",
        ["icon"] = 775463,
        ["name"] = "Spectral Guise",
        },
        [80964] = {
        ["custom"] = true,
        ["name"] = "Skull Bash",
        ["class"] = "DRUID",
        ["icon"] = 133732,
        ["duration"] = {
        ["default"] = 15,
        },
        },
        [871] = {
        ["charges"] = 2,
        ["name"] = "Shield Wall",
        ["duration"] = {
        ["default"] = 180,
        },
        ["class"] = "WARRIOR",
        ["icon"] = 132362,
        ["specID"] = {
        73,
        },
        },
        [8143] = {
        ["icon"] = 136108,
        ["class"] = "SHAMAN",
        ["name"] = "Tremor Totem",
        ["duration"] = {
        ["default"] = 60,
        },
        },
        [1022] = {
        ["icon"] = 135964,
        ["class"] = "PALADIN",
        ["name"] = "Hand of Protection",
        ["duration"] = {
        ["default"] = 300,
        },
        },
        [44572] = {
        ["custom"] = true,
        ["class"] = "MAGE",
        ["duration"] = {
        ["default"] = 30,
        },
        ["icon"] = 236214,
        ["name"] = "Deep Freeze",
        },
        [115310] = {
        ["name"] = "Revival",
        ["specID"] = {
        270,
        },
        ["class"] = "MONK",
        ["icon"] = 237573,
        ["duration"] = {
        ["default"] = 180,
        },
        },
        [6940] = {
        ["icon"] = 135966,
        ["class"] = "PALADIN",
        ["name"] = "Hand of Sacrifice",
        ["duration"] = {
        ["default"] = 120,
        },
        },
        [110913] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 180,
        },
        ["class"] = "WARLOCK",
        ["icon"] = 538039,
        ["name"] = "Dark Bargain",
        },
        [80965] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 15,
        },
        ["class"] = "DRUID",
        ["icon"] = 236946,
        ["name"] = "Skull Bash",
        },
        [5484] = {
        ["name"] = "Howl of Terror",
        ["adjust"] = {
        ["Affliction"] = -8,
        },
        ["class"] = "WARLOCK",
        ["icon"] = 607852,
        ["duration"] = {
        ["default"] = 40,
        },
        },
        [642] = {
        ["name"] = "Divine Shield",
        ["adjust"] = {
        ["Protection"] = -60,
        },
        ["class"] = "PALADIN",
        ["icon"] = 524354,
        ["duration"] = {
        ["default"] = 300,
        },
        },
        [89808] = {
        ["duration"] = {
        ["default"] = 10,
        },
        ["class"] = "WARLOCK",
        ["name"] = "Singe Magic",
        ["icon"] = 135791,
        },
        [51514] = {
        ["duration"] = {
        ["default"] = 45,
        },
        ["class"] = "SHAMAN",
        ["icon"] = 237579,
        ["name"] = "Hex",
        },
        [47585] = {
        ["name"] = "Dispersion",
        ["class"] = "PRIEST",
        ["duration"] = {
        ["default"] = 120,
        },
        ["icon"] = 237563,
        ["specID"] = {
        258,
        },
        },
        [45438] = {
        ["name"] = "Ice Block",
        ["duration"] = {
        ["default"] = 300,
        },
        ["icon"] = 135841,
        ["class"] = "MAGE",
        },
        [498] = {
        ["name"] = "Divine Protection",
        ["adjust"] = {
        ["Protection"] = -60,
        },
        ["class"] = "PALADIN",
        ["icon"] = 524353,
        ["duration"] = {
        ["default"] = 30,
        },
        },
        [98008] = {
        ["name"] = "Spirit Link Totem",
        ["class"] = "SHAMAN",
        ["duration"] = {
        ["default"] = 180,
        },
        ["icon"] = 237586,
        ["specID"] = {
        264,
        },
        },
        [102342] = {
        ["name"] = "Ironbark",
        ["duration"] = {
        ["default"] = 60,
        },
        ["specID"] = {
        105,
        },
        ["icon"] = 572025,
        ["class"] = "DRUID",
        },
        [106922] = {
        ["custom"] = true,
        ["class"] = "DRUID",
        ["duration"] = {
        ["default"] = 180,
        },
        ["icon"] = 572036,
        ["name"] = "Might of Ursoc",
        },
        [74434] = {
        ["name"] = "Soulburn",
        ["adjust"] = -13.5,
        ["class"] = "WARLOCK",
        ["icon"] = 463286,
        ["duration"] = {
        ["default"] = 45,
        },
        },
        [31884] = {
        ["name"] = "Avenging Wrath",
        ["adjust"] = {
        ["Retribution"] = -60,
        },
        ["class"] = "PALADIN",
        ["icon"] = 135875,
        ["duration"] = {
        ["default"] = 120,
        },
        },
        [48792] = {
        ["duration"] = {
        ["default"] = 180,
        },
        ["class"] = "DEATHKNIGHT",
        ["icon"] = 237525,
        ["name"] = "Icebound Fortitude",
        },
        [19577] = {
        ["class"] = "HUNTER",
        ["duration"] = {
        ["default"] = 60,
        },
        ["name"] = "Intimidation",
        ["icon"] = 132111,
        },
        [108280] = {
        ["name"] = "Healing Tide Totem",
        ["class"] = "SHAMAN",
        ["duration"] = {
        ["default"] = 180,
        },
        ["icon"] = 538569,
        ["specID"] = {
        264,
        },
        },
        [5246] = {
        ["name"] = "Intimidating Shout",
        ["duration"] = {
        ["default"] = 90,
        },
        ["icon"] = 132154,
        ["class"] = "WARRIOR",
        },
        [55694] = {
        ["custom"] = true,
        ["name"] = "Enraged Regeneration",
        ["class"] = "WARRIOR",
        ["icon"] = 132345,
        ["duration"] = {
        ["default"] = 60,
        },
        },
        [54428] = {
        ["duration"] = {
        ["default"] = 120,
        },
        ["class"] = "PALADIN",
        ["icon"] = 237537,
        ["name"] = "Divine Plea",
        },
        [11958] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 180,
        },
        ["class"] = "MAGE",
        ["icon"] = 135865,
        ["name"] = "Cold Snap",
        },
        [107570] = {
        ["name"] = "Storm Bolt",
        ["duration"] = {
        ["default"] = 30,
        },
        ["icon"] = 613535,
        ["class"] = "WARRIOR",
        },
        [102060] = {
        ["custom"] = true,
        ["name"] = "Disrupting Shout",
        ["class"] = "WARRIOR",
        ["icon"] = 589118,
        ["duration"] = {
        ["default"] = 40,
        },
        },
        [14185] = {
        ["name"] = "Preparation",
        ["adjust"] = {
        ["Subtlety"] = -180,
        },
        ["class"] = "ROGUE",
        ["icon"] = 460693,
        ["duration"] = {
        ["default"] = 300,
        },
        },
        [77801] = {
        ["name"] = "Dark Soul",
        ["adjust"] = -36,
        ["class"] = "WARLOCK",
        ["icon"] = 463284,
        ["duration"] = {
        ["default"] = 120,
        },
        },
        [108416] = {
        ["class"] = "WARLOCK",
        ["duration"] = {
        ["default"] = 60,
        },
        ["name"] = "Sacrificial Pact",
        ["icon"] = 538538,
        },
        [5384] = {
        ["name"] = "Feign Death",
        ["adjust"] = -5,
        ["class"] = "HUNTER",
        ["icon"] = 132293,
        ["duration"] = {
        ["default"] = 25,
        },
        },
        [19236] = {
        ["class"] = "PRIEST",
        ["duration"] = {
        ["default"] = 120,
        },
        ["name"] = "Desperate Prayer",
        ["icon"] = 237550,
        },
        [47476] = {
        ["duration"] = {
        ["default"] = 60,
        },
        ["class"] = "DEATHKNIGHT",
        ["icon"] = 136214,
        ["name"] = "Strangulate",
        },
        [108194] = {
        ["custom"] = true,
        ["class"] = "DEATHKNIGHT",
        ["duration"] = {
        ["default"] = 30,
        },
        ["icon"] = 538558,
        ["name"] = "Asphyxiate",
        },
        [6544] = {
        ["name"] = "Heroic Leap",
        ["adjust"] = -20,
        ["class"] = "WARRIOR",
        ["icon"] = 236171,
        ["duration"] = {
        ["default"] = 60,
        },
        },
        [8177] = {
        ["name"] = "Grounding Totem",
        ["adjust"] = -2,
        ["class"] = "SHAMAN",
        ["icon"] = 136039,
        ["duration"] = {
        ["default"] = 25,
        },
        },
        [115203] = {
        ["name"] = "Fortifying Brew",
        ["duration"] = {
        ["default"] = 180,
        },
        ["icon"] = 615341,
        ["class"] = "MONK",
        },
        [408] = {
        ["name"] = "Kidney Shot",
        ["duration"] = {
        ["default"] = 20,
        },
        ["icon"] = 132298,
        ["class"] = "ROGUE",
        },
        [31661] = {
        ["duration"] = {
        ["default"] = 20,
        },
        ["class"] = "MAGE",
        ["icon"] = 134153,
        ["name"] = "Dragon's Breath",
        },
        [108978] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 180,
        },
        ["class"] = "MAGE",
        ["icon"] = 609811,
        ["name"] = "Alter Time",
        },
        [48020] = {
        ["duration"] = {
        ["default"] = 30,
        },
        ["class"] = "WARLOCK",
        ["icon"] = 237560,
        ["name"] = "Demonic Circle: Teleport",
        },
        [48707] = {
        ["duration"] = {
        ["default"] = 45,
        },
        ["class"] = "DEATHKNIGHT",
        ["icon"] = 136120,
        ["name"] = "Anti-Magic Shell",
        },
        [78675] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 60,
        },
        ["class"] = "DRUID",
        ["icon"] = 252188,
        ["name"] = "Solar Beam",
        },
        [23920] = {
        ["duration"] = {
        ["default"] = 25,
        },
        ["class"] = "WARRIOR",
        ["icon"] = 132361,
        ["name"] = "Spell Reflection",
        },
        [31224] = {
        ["name"] = "Cloak of Shadows",
        ["adjust"] = -30,
        ["class"] = "ROGUE",
        ["icon"] = 136177,
        ["duration"] = {
        ["default"] = 120,
        },
        },
        [122783] = {
        ["name"] = "Diffuse Magic",
        ["duration"] = {
        ["default"] = 90,
        },
        ["icon"] = 775460,
        ["class"] = "MONK",
        },
        [30823] = {
        ["custom"] = true,
        ["name"] = "Shamanistic Rage",
        ["duration"] = {
        ["default"] = 60,
        },
        ["icon"] = 136088,
        ["class"] = "SHAMAN",
        },
        [2139] = {
        ["default"] = true,
        ["name"] = "Counterspell",
        ["class"] = "MAGE",
        ["icon"] = 135856,
        ["duration"] = {
        ["default"] = 24,
        },
        },
        [31687] = {
        ["name"] = "Summon Water Elemental",
        ["adjust"] = -36,
        ["class"] = "MAGE",
        ["icon"] = 135862,
        ["duration"] = {
        ["default"] = 180,
        },
        },
        [32375] = {
        ["class"] = "PRIEST",
        ["duration"] = {
        ["default"] = 15,
        },
        ["name"] = "Mass Dispel",
        ["icon"] = 135739,
        },
        [57755] = {
        ["duration"] = {
        ["default"] = 30,
        },
        ["class"] = "WARRIOR",
        ["icon"] = 132453,
        ["name"] = "Heroic Throw",
        },
        [64044] = {
        ["duration"] = {
        ["default"] = 45,
        },
        ["class"] = "PRIEST",
        ["icon"] = 237568,
        ["name"] = "Psychic Horror",
        },
        [148467] = {
        ["charges"] = 2,
        ["custom"] = true,
        ["name"] = "Deterrence",
        ["duration"] = {
        ["default"] = 120,
        },
        ["icon"] = 132369,
        ["class"] = "HUNTER",
        },
        [6789] = {
        ["duration"] = {
        ["default"] = 45,
        },
        ["class"] = "WARLOCK",
        ["icon"] = 607853,
        ["name"] = "Mortal Coil",
        },
        [103150] = {
        ["custom"] = true,
        ["duration"] = {
        ["default"] = 10,
        },
        ["class"] = "WARLOCK",
        ["icon"] = 135791,
        ["name"] = "Imp: Singe Magic",
        },
        [132409] = {
        ["icon"] = 136174,
        ["duration"] = {
        ["default"] = 24,
        },
        ["name"] = "Spell Lock",
        ["class"] = "WARLOCK",
        },
        },
        },
        ["profiles"] = {
        ["Default"] = {
        ["bars"] = {
        ["OmniBar1"] = {
        ["glow"] = true,
        ["scenario"] = true,
        ["growUpward"] = true,
        ["tooltips"] = true,
        ["names"] = false,
        ["multiple"] = true,
        ["swipeAlpha"] = 0.65,
        ["center"] = false,
        ["showUnused"] = false,
        ["locked"] = false,
        ["world"] = true,
        ["iconSorting"] = "TIME_ADDED",
        ["size"] = 40,
        ["cooldownCount"] = true,
        ["highlightTarget"] = true,
        ["columns"] = 8,
        ["unusedAlpha"] = 0.45,
        ["align"] = "CENTER",
        ["padding"] = 2,
        ["border"] = true,
        ["adaptive"] = false,
        ["maxIcons"] = 32,
        ["ratedBattleground"] = true,
        ["name"] = "OmniBar",
        ["position"] = {
        ["relativeTo"] = "UIParent",
        ["point"] = "CENTER",
        ["relativePoint"] = "CENTER",
        ["yOfs"] = 0,
        ["xOfs"] = 0,
        ["frameStrata"] = "MEDIUM",
        },
        ["highlightFocus"] = false,
        ["arena"] = true,
        ["trackUnit"] = "ENEMY",
        ["battleground"] = true,
        },
        },
        },
        ["SkillCapped"] = {
        ["bars"] = {
        ["OmniBar4"] = {
        ["glow"] = true,
        ["scenario"] = true,
        ["tooltips"] = true,
        ["border"] = true,
        ["names"] = false,
        ["multiple"] = true,
        ["showUnused"] = false,
        ["highlightFocus"] = false,
        ["center"] = false,
        ["swipeAlpha"] = 0.65,
        ["growUpward"] = true,
        ["locked"] = true,
        ["size"] = 40,
        ["cooldownCount"] = true,
        ["highlightTarget"] = true,
        ["columns"] = 8,
        ["unusedAlpha"] = 0.45,
        ["align"] = "LEFT",
        ["spells"] = {
        [6346] = true,
        [8177] = true,
        [114039] = true,
        [77606] = false,
        [5384] = false,
        [89808] = true,
        [32379] = true,
        [6789] = false,
        [6940] = false,
        [32375] = true,
        [23920] = true,
        [8143] = true,
        [103150] = true,
        [129176] = true,
        [112833] = true,
        },
        ["trackUnit"] = "ENEMY",
        ["adaptive"] = false,
        ["maxIcons"] = 32,
        ["world"] = true,
        ["name"] = "Misc",
        ["position"] = {
        ["relativeTo"] = "UIParent",
        ["point"] = "CENTER",
        ["relativePoint"] = "CENTER",
        ["yOfs"] = 174,
        ["xOfs"] = 381,
        ["frameStrata"] = "MEDIUM",
        },
        ["ratedBattleground"] = true,
        ["arena"] = true,
        ["padding"] = 2,
        ["battleground"] = false,
        },
        ["OmniBar2"] = {
        ["glow"] = true,
        ["scenario"] = true,
        ["border"] = true,
        ["tooltips"] = true,
        ["names"] = false,
        ["multiple"] = true,
        ["padding"] = 2,
        ["highlightFocus"] = false,
        ["growUpward"] = true,
        ["swipeAlpha"] = 0.65,
        ["center"] = true,
        ["trackUnit"] = "ENEMY",
        ["world"] = true,
        ["cooldownCount"] = true,
        ["highlightTarget"] = true,
        ["columns"] = 16,
        ["unusedAlpha"] = 0.45,
        ["align"] = "CENTER",
        ["spells"] = {
        [47585] = true,
        [51052] = true,
        [14185] = false,
        [48792] = true,
        [19236] = true,
        [108416] = true,
        [97462] = true,
        [53480] = true,
        [498] = false,
        [11958] = true,
        [22842] = false,
        [33206] = true,
        [31224] = true,
        [45438] = true,
        [55694] = true,
        [118038] = true,
        [102342] = true,
        [49039] = false,
        [642] = true,
        [1022] = true,
        [108280] = true,
        [30823] = true,
        [122470] = true,
        [61336] = true,
        [6940] = true,
        [48020] = true,
        [106922] = true,
        [5277] = true,
        [148467] = true,
        [47788] = true,
        [1856] = true,
        [22812] = true,
        [115213] = true,
        [62618] = false,
        [115203] = false,
        [98008] = true,
        [116849] = true,
        [108978] = true,
        [871] = true,
        [122783] = true,
        [48707] = true,
        [104773] = true,
        [132158] = true,
        [36554] = false,
        [108271] = true,
        [115310] = true,
        [110913] = true,
        },
        ["locked"] = true,
        ["adaptive"] = false,
        ["maxIcons"] = 32,
        ["size"] = 40,
        ["name"] = "Defensives",
        ["position"] = {
        ["relativeTo"] = "UIParent",
        ["point"] = "CENTER",
        ["relativePoint"] = "CENTER",
        ["yOfs"] = -186.19,
        ["xOfs"] = 0,
        ["frameStrata"] = "MEDIUM",
        },
        ["ratedBattleground"] = true,
        ["showUnused"] = false,
        ["arena"] = true,
        ["battleground"] = false,
        },
        ["OmniBar1"] = {
        ["glow"] = true,
        ["scenario"] = true,
        ["border"] = true,
        ["tooltips"] = true,
        ["names"] = false,
        ["multiple"] = true,
        ["showUnused"] = false,
        ["highlightFocus"] = false,
        ["center"] = true,
        ["trackUnit"] = "ENEMY",
        ["growUpward"] = true,
        ["locked"] = true,
        ["world"] = true,
        ["cooldownCount"] = true,
        ["highlightTarget"] = true,
        ["columns"] = 8,
        ["unusedAlpha"] = 0.45,
        ["align"] = "CENTER",
        ["spells"] = {
        [96231] = true,
        [106839] = false,
        [57994] = true,
        [1766] = true,
        [2139] = true,
        [80964] = true,
        [147362] = true,
        [119910] = true,
        [132409] = true,
        [47528] = true,
        [15487] = false,
        [31935] = true,
        [80965] = true,
        [102060] = true,
        [78675] = true,
        [116705] = true,
        [6552] = true,
        },
        ["swipeAlpha"] = 0.65,
        ["adaptive"] = false,
        ["maxIcons"] = 32,
        ["size"] = 45,
        ["name"] = "Interrupts",
        ["position"] = {
        ["relativeTo"] = "UIParent",
        ["point"] = "CENTER",
        ["relativePoint"] = "CENTER",
        ["yOfs"] = -230,
        ["xOfs"] = 5.835711635882035e-05,
        ["frameStrata"] = "MEDIUM",
        },
        ["ratedBattleground"] = true,
        ["padding"] = 2,
        ["arena"] = true,
        ["battleground"] = false,
        },
        ["OmniBar3"] = {
        ["glow"] = true,
        ["scenario"] = true,
        ["border"] = true,
        ["tooltips"] = true,
        ["names"] = false,
        ["multiple"] = true,
        ["padding"] = 2,
        ["growUpward"] = true,
        ["center"] = true,
        ["trackUnit"] = "ENEMY",
        ["highlightFocus"] = false,
        ["locked"] = true,
        ["size"] = 40,
        ["cooldownCount"] = true,
        ["ratedBattleground"] = true,
        ["columns"] = 16,
        ["unusedAlpha"] = 0.45,
        ["align"] = "CENTER",
        ["spells"] = {
        [20066] = false,
        [90337] = true,
        [31661] = true,
        [2094] = true,
        [5211] = true,
        [5246] = true,
        [51514] = true,
        [99] = true,
        [853] = true,
        [6789] = true,
        [64044] = true,
        [19577] = true,
        [119381] = true,
        [108194] = true,
        [5484] = true,
        [15487] = true,
        [107570] = true,
        [408] = true,
        [8122] = true,
        [47476] = true,
        [60192] = true,
        [44572] = true,
        },
        ["swipeAlpha"] = 0.65,
        ["adaptive"] = false,
        ["maxIcons"] = 32,
        ["world"] = true,
        ["name"] = "Crowd Control",
        ["position"] = {
        ["relativeTo"] = "UIParent",
        ["point"] = "CENTER",
        ["relativePoint"] = "CENTER",
        ["yOfs"] = -143.44,
        ["xOfs"] = 5.835711635882035e-05,
        ["frameStrata"] = "MEDIUM",
        },
        ["highlightTarget"] = true,
        ["arena"] = true,
        ["showUnused"] = false,
        ["battleground"] = false,
        },
        },
        },
        },
    }

    if not SkillCappedBackupDB.OmniBarDB then
        SkillCappedBackupDB.OmniBarDB = SC:DeepCopy(OmniBarDB)
        SkillCappedBackupDB.addonBackupTimes["OmniBar"] = SC:GetDateAndTime()
    end

    OmniBarDB = scOmniBarDB

    SC:UpdateOmniBarProfile()
end

function SC:UpdateOmniBarProfile()
    if not OmniBarDB then return end
    if not SkillCappedBackupDB.OmniBarDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    OmniBarDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        OmniBarDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end