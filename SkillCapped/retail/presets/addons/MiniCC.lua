local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:MiniCCDB()
    local scMiniCCDB = {
    ["ConfigureBlizzardNameplates"] = true,
    ["FontScale"] = 1,
    ["GlowType"] = "Proc Glow",
    ["IconSpacing"] = 2,
    ["WhatsNew"] = {
    },
    ["Modules"] = {
    ["HealerCCModule"] = {
    ["Offset"] = {
    ["Y"] = -135.8233337402344,
    ["X"] = 9.336480434285477e-05,
    },
    ["RelativeTo"] = "UIParent",
    ["Point"] = "TOP",
    ["Icons"] = {
    ["Enabled"] = true,
    ["Glow"] = false,
    ["ColorByDispelType"] = true,
    ["ReverseCooldown"] = true,
    ["Size"] = 40,
    },
    ["ShowWarningText"] = true,
    ["ShowTooltips"] = false,
    ["Font"] = {
    ["Flags"] = "OUTLINE",
    ["File"] = "Fonts\\FRIZQT__.TTF",
    ["Size"] = 16,
    },
    ["RelativePoint"] = "TOP",
    ["Sound"] = {
    ["Enabled"] = true,
    ["File"] = "Sonar.ogg",
    ["Channel"] = "Master",
    },
    ["Enabled"] = {
    ["BattleGrounds"] = true,
    ["Raid"] = true,
    ["Dungeons"] = true,
    ["Arena"] = true,
    ["World"] = true,
    },
    },
    ["NameplatesModule"] = {
    ["Enabled"] = {
    ["BattleGrounds"] = true,
    ["Raid"] = true,
    ["Dungeons"] = true,
    ["Arena"] = true,
    ["World"] = true,
    },
    ["ScaleWithNameplate"] = false,
    ["Friendly"] = {
    ["Combined"] = {
    ["Offset"] = {
    ["Y"] = 0,
    ["X"] = 2,
    },
    ["Enabled"] = false,
    ["Icons"] = {
    ["MaxIcons"] = 5,
    ["Glow"] = true,
    ["ColorByCategory"] = true,
    ["ReverseCooldown"] = true,
    ["Size"] = 50,
    },
    ["Grow"] = "RIGHT",
    },
    ["Important"] = {
    ["Grow"] = "LEFT",
    ["Offset"] = {
    ["Y"] = 0,
    ["X"] = -2,
    },
    ["Icons"] = {
    ["MaxIcons"] = 5,
    ["Glow"] = true,
    ["ColorByCategory"] = true,
    ["ReverseCooldown"] = true,
    ["Size"] = 50,
    },
    ["Enabled"] = false,
    },
    ["CC"] = {
    ["Grow"] = "RIGHT",
    ["Offset"] = {
    ["Y"] = 0,
    ["X"] = 2,
    },
    ["Icons"] = {
    ["MaxIcons"] = 5,
    ["Glow"] = true,
    ["ColorByCategory"] = true,
    ["ReverseCooldown"] = true,
    ["Size"] = 50,
    },
    ["Enabled"] = false,
    },
    ["IgnorePets"] = true,
    },
    ["Enemy"] = {
    ["Combined"] = {
    ["Offset"] = {
    ["Y"] = 0,
    ["X"] = 2,
    },
    ["Enabled"] = false,
    ["Icons"] = {
    ["MaxIcons"] = 5,
    ["Glow"] = true,
    ["ColorByCategory"] = true,
    ["ReverseCooldown"] = true,
    ["Size"] = 50,
    },
    ["Grow"] = "RIGHT",
    },
    ["Important"] = {
    ["Grow"] = "LEFT",
    ["Offset"] = {
    ["Y"] = 0,
    ["X"] = 8,
    },
    ["Icons"] = {
    ["MaxIcons"] = 5,
    ["Glow"] = false,
    ["ColorByCategory"] = false,
    ["ReverseCooldown"] = true,
    ["Size"] = 35,
    },
    ["Enabled"] = true,
    },
    ["CC"] = {
    ["Grow"] = "RIGHT",
    ["Offset"] = {
    ["Y"] = 0,
    ["X"] = -8,
    },
    ["Icons"] = {
    ["MaxIcons"] = 5,
    ["Glow"] = false,
    ["ColorByCategory"] = false,
    ["ReverseCooldown"] = true,
    ["Size"] = 35,
    },
    ["Enabled"] = true,
    },
    ["IgnorePets"] = true,
    },
    },
    ["PetCCModule"] = {
    ["Grow"] = "CENTER",
    ["ShowTooltips"] = false,
    ["Enabled"] = {
    ["BattleGrounds"] = false,
    ["Raid"] = false,
    ["Dungeons"] = false,
    ["Arena"] = false,
    ["World"] = false,
    },
    ["Icons"] = {
    ["Glow"] = true,
    ["Count"] = 3,
    ["ReverseCooldown"] = true,
    ["ColorByDispelType"] = true,
    ["Size"] = 30,
    },
    ["Offset"] = {
    ["Y"] = 0,
    ["X"] = 0,
    },
    },
    ["FriendlyCooldownTrackerModule"] = {
    ["Enabled"] = {
    ["BattleGrounds"] = false,
    ["World"] = false,
    ["Arena"] = true,
    ["Raid"] = false,
    ["Dungeons"] = true,
    },
    ["Raid"] = {
    ["ShowTooltips"] = true,
    ["ExcludeSelf"] = false,
    ["ShowOffensiveCooldowns"] = true,
    ["Grow"] = "CENTER",
    ["ShowTrinket"] = true,
    ["Offset"] = {
    ["Y"] = 0,
    ["X"] = -2,
    },
    ["Icons"] = {
    ["MaxIcons"] = 5,
    ["ReverseCooldown"] = true,
    ["Rows"] = 1,
    ["Size"] = 20,
    },
    ["ShowDefensiveCooldowns"] = true,
    },
    ["Default"] = {
    ["ShowTooltips"] = false,
    ["ExcludeSelf"] = true,
    ["ShowOffensiveCooldowns"] = true,
    ["Grow"] = "LEFT",
    ["ShowTrinket"] = true,
    ["Offset"] = {
    ["Y"] = 16,
    ["X"] = -2,
    },
    ["Icons"] = {
    ["MaxIcons"] = 10,
    ["ReverseCooldown"] = true,
    ["Rows"] = 1,
    ["Size"] = 24,
    },
    ["ShowDefensiveCooldowns"] = true,
    },
    },
    ["CCModule"] = {
    ["Enabled"] = {
    ["BattleGrounds"] = true,
    ["Raid"] = true,
    ["Dungeons"] = true,
    ["Arena"] = true,
    ["World"] = true,
    },
    ["Raid"] = {
    ["Offset"] = {
    ["Y"] = 0,
    ["X"] = -2,
    },
    ["ShowTooltips"] = false,
    ["ExcludePlayer"] = false,
    ["Icons"] = {
    ["Glow"] = false,
    ["ColorByDispelType"] = true,
    ["ReverseCooldown"] = true,
    ["Count"] = 3,
    ["Size"] = 34,
    },
    ["Grow"] = "CENTER",
    },
    ["Default"] = {
    ["Offset"] = {
    ["Y"] = -17,
    ["X"] = -2,
    },
    ["ShowTooltips"] = false,
    ["ExcludePlayer"] = false,
    ["Icons"] = {
    ["Glow"] = false,
    ["ColorByDispelType"] = true,
    ["ReverseCooldown"] = true,
    ["Count"] = 3,
    ["Size"] = 38,
    },
    ["Grow"] = "LEFT",
    },
    },
    ["PortraitModule"] = {
    ["Enabled"] = {
    ["Always"] = true,
    },
    ["ReverseCooldown"] = true,
    },
    ["AlertsModule"] = {
    ["Offset"] = {
    ["Y"] = -87.11115264892578,
    ["X"] = -0.7111164331436157,
    },
    ["RelativeTo"] = "UIParent",
    ["Point"] = "TOP",
    ["Icons"] = {
    ["MaxIcons"] = 8,
    ["Glow"] = false,
    ["Enabled"] = true,
    ["ReverseCooldown"] = true,
    ["ColorByClass"] = false,
    ["Size"] = 40,
    },
    ["ShowTooltips"] = false,
    ["Enabled"] = {
    ["BattleGrounds"] = true,
    ["Raid"] = true,
    ["Dungeons"] = true,
    ["Arena"] = true,
    ["World"] = true,
    },
    ["RelativePoint"] = "TOP",
    ["TTS"] = {
    ["VoiceID"] = 0,
    ["Volume"] = 100,
    ["Important"] = {
    ["Enabled"] = false,
    },
    ["Defensive"] = {
    ["Enabled"] = false,
    },
    ["SpeechRate"] = 0,
    },
    ["IncludeDefensives"] = false,
    ["Sound"] = {
    ["Defensive"] = {
    ["Enabled"] = false,
    ["File"] = "AlertToastWarm.ogg",
    ["Channel"] = "Master",
    },
    ["Important"] = {
    ["Enabled"] = false,
    ["File"] = "AirHorn.ogg",
    ["Channel"] = "Master",
    },
    },
    ["TargetFocusOnly"] = false,
    },
    ["PrecogGuesserModule"] = {
    ["Enabled"] = {
    ["Always"] = true,
    },
    ["RelativeTo"] = "UIParent",
    ["Point"] = "CENTER",
    ["RelativePoint"] = "CENTER",
    ["Icons"] = {
    ["Glow"] = true,
    ["ReverseCooldown"] = true,
    ["Size"] = 24,
    },
    ["Offset"] = {
    ["Y"] = 33.02221298217773,
    ["X"] = 9.337138180853799e-05,
    },
    },
    ["KickTimerModule"] = {
    ["Offset"] = {
    ["Y"] = -164.0885467529297,
    ["X"] = 0.0003267998399678618,
    },
    ["RelativeTo"] = "UIParent",
    ["Point"] = "CENTER",
    ["RelativePoint"] = "CENTER",
    ["Icons"] = {
    ["Glow"] = false,
    ["ReverseCooldown"] = true,
    ["Size"] = 40,
    },
    ["Enabled"] = {
    ["Always"] = true,
    ["Caster"] = true,
    ["Healer"] = true,
    },
    },
    ["FriendlyIndicatorModule"] = {
    ["Enabled"] = {
    ["BattleGrounds"] = true,
    ["Raid"] = true,
    ["Dungeons"] = true,
    ["Arena"] = true,
    ["World"] = true,
    },
    ["Raid"] = {
    ["ExcludePlayer"] = false,
    ["ShowTooltips"] = false,
    ["ShowDefensives"] = true,
    ["ShowImportant"] = true,
    ["Grow"] = "CENTER",
    ["Offset"] = {
    ["Y"] = 6,
    ["X"] = 0,
    },
    ["Icons"] = {
    ["MaxIcons"] = 1,
    ["Glow"] = false,
    ["ColorByDispelType"] = true,
    ["ReverseCooldown"] = true,
    ["Size"] = 22,
    },
    ["ShowCC"] = false,
    },
    ["Default"] = {
    ["ExcludePlayer"] = false,
    ["ShowTooltips"] = false,
    ["ShowDefensives"] = true,
    ["ShowImportant"] = true,
    ["Grow"] = "CENTER",
    ["Offset"] = {
    ["Y"] = 6,
    ["X"] = 0,
    },
    ["Icons"] = {
    ["MaxIcons"] = 1,
    ["Glow"] = false,
    ["ColorByDispelType"] = true,
    ["ReverseCooldown"] = true,
    ["Size"] = 22,
    },
    ["ShowCC"] = false,
    },
    },
    ["TrinketsModule"] = {
    ["Enabled"] = {
    ["Always"] = true,
    },
    ["Font"] = {
    ["File"] = "GameFontHighlightSmall",
    },
    ["Point"] = "RIGHT",
    ["RelativePoint"] = "LEFT",
    ["Offset"] = {
    ["Y"] = 16,
    ["X"] = -2,
    },
    ["Icons"] = {
    ["Glow"] = false,
    ["ReverseCooldown"] = false,
    ["ShowText"] = true,
    ["Size"] = 24,
    },
    ["ExcludePlayer"] = true,
    },
    },
    ["PvPTalentCache"] = {},
    ["Version"] = 35,
    ["DisableSwipe"] = false,
    ["TalentCache"] = {},
    ["CCNativeOrder"] = false,
    ["NotifiedChanges"] = true,
    }

    if not SkillCappedBackupDB.MiniCCDB then
        SkillCappedBackupDB.MiniCCDB = SC:DeepCopy(MiniCCDB)
        SkillCappedBackupDB.addonBackupTimes["MiniCC"] = SC:GetDateAndTime()
    end

    C_CVar.SetCVarBitfield("nameplateEnemyPlayerAuraDisplay", Enum.NamePlateEnemyPlayerAuraDisplay.Buffs, false)
    C_CVar.SetCVarBitfield("nameplateEnemyPlayerAuraDisplay", Enum.NamePlateEnemyPlayerAuraDisplay.Debuffs, true)
    C_CVar.SetCVarBitfield("nameplateEnemyPlayerAuraDisplay", Enum.NamePlateEnemyPlayerAuraDisplay.LossOfControl, false)
    C_CVar.SetCVarBitfield("nameplateEnemyNpcAuraDisplay", Enum.NamePlateEnemyNpcAuraDisplay.Buffs, false)
    C_CVar.SetCVarBitfield("nameplateEnemyNpcAuraDisplay", Enum.NamePlateEnemyNpcAuraDisplay.Debuffs, true)
    C_CVar.SetCVarBitfield("nameplateEnemyNpcAuraDisplay", Enum.NamePlateEnemyNpcAuraDisplay.CrowdControl, false)
    C_CVar.SetCVar("raidFramesCenterBigDefensive", "0")

    MiniCCDB = scMiniCCDB
end