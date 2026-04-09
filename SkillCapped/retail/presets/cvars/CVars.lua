local AddonName, SkillCapped = ...
local SC = SkillCapped

local cvars = {
    ActionButtonUseKeyHeldSpell = "0",
    cameraDistanceMaxZoomFactor = "2.5999999046326",
    cameraSmoothStyle = "0",
    chatBubbles = "0",
    chatBubblesParty = "0",
    combinedBags = "1",
    deselectOnClick = "0",
    enableFloatingCombatText = "0",
    graphicsProjectedTextures = "1",
    lootUnderMouse = "1",
    autoLootDefault = "1",
    nameplateGlobalScale = "1",
    nameplateOtherAtBase = "0",
    projectedTextures = "1",
    RAIDweatherDensity = "1",
    scriptErrors = "0",
    secureAbilityToggle = "1",
    showTargetOfTarget = "1",
    Sound_EnableErrorSpeech = "0",
    statusText = "1",
    statusTextDisplay = "BOTH",
    UnitNameEnemyGuardianName = "1",
    UnitNameEnemyMinionName = "1",
    UnitNameEnemyPetName = "1",
    UnitNameEnemyPlayerName = "1",
    UnitNameEnemyTotemName = "1",
    UnitNameFriendlyPlayerName = "1",
    UnitNameFriendlySpecialNPCName = "1",
    UnitNameHostleNPC = "1",
    UnitNameInteractiveNPC = "1",
    UnitNameNonCombatCreatureName = "1",
    UnitNameNPC = "1",
    UnitNameOwn = "1",
    UnitNamePlayerPVPTitle = "1",
    weatherDensity = "1",
    autoDismountFlying = "1",
    ReplaceOtherPlayerPortraits = "1",
    ReplaceMyPlayerPortrait = "1",
    lockActionBars = "0",
    countdownForCooldowns = "1",
    UnitNameFriendlyPetName = "0",
    UnitNameFriendlyGuardianName = "0",
    UnitNameFriendlyTotemName = "0",
    UnitNameFriendlyMinionName = "0",
    doNotFlashLowHealthWarning = "1",
    ShakeStrengthCamera = "0.25",
    ShakeStrengthUI = "0.25",
    nameplateShowSelf = "1",
    nameplateStyle = "0",
    SoftTargetIconInteract = "0",
    nameplateShowFriendlyPlayers = "0",
    nameplateShowEnemies = "1",
    nameplateShowFriendlyNpcs = "0",
    -- for backup only
    nameplateResourceOnTarget = "tempValue",
    SpellQueueWindow = "tempValue",
    vsync = "tempValue",
    cooldownViewerEnabled = "tempValue", -- char cvar (no per char backup)
}

local charCVars = {
    autoSelfCast = "1",
    lossOfControl = "1",
    nameplateShowAll = "1",
    nameplateShowEnemyMinions = "0",
    nameplateShowEnemyGuardians = "1",
    nameplateShowEnemyMinus = "0",
    nameplateShowEnemyPets = "1",
    nameplateShowEnemyTotems = "1",
    nameplateShowFriendlyPlayerMinions = "0",
    nameplateShowFriendlyPlayerGuardians = "0",
    nameplateShowFriendlyPlayerPets = "0",
    nameplateShowFriendlyPlayerTotems = "0",
    --NamePlateClassificationScale = "1.25",
    --NamePlateHorizontalScale = "1.4",
    --NamePlateVerticalScale = "2.7",
    noBuffDebuffFilterOnTarget = "0",
    raidFramesDisplayClassColor = "1",
    raidFramesDisplayDebuffs = "1",
    raidFramesDisplayIncomingHeals = "1",
    raidFramesDisplayOnlyDispellableDebuffs = "0",
    raidFramesDisplayPowerBars = "1",
    raidFramesHealthText = "none",
    raidOptionDisplayMainTankAndAssist = "0",
    raidOptionDisplayPets = "1",
    nameplateShowClassColor = "1",
    stopAutoAttackOnTargetChange = "0",
    enableMultiActionBars = "15", --127
    externalDefensivesEnabled = "1",
    nameplateShowSelf = "1",
    spellDiminishPVPEnemiesEnabled = "1",
    raidFramesCenterBigDefensive = "0",
}

local bitCVars = {
    nameplateEnemyPlayerAuraDisplay = {
        {index = Enum.NamePlateEnemyPlayerAuraDisplay.Buffs, value = false},
        {index = Enum.NamePlateEnemyPlayerAuraDisplay.Debuffs, value = true},
        {index = Enum.NamePlateEnemyPlayerAuraDisplay.LossOfControl, value = false},
    },
    nameplateEnemyNpcAuraDisplay = {
        {index = Enum.NamePlateEnemyNpcAuraDisplay.Buffs, value = false},
        {index = Enum.NamePlateEnemyNpcAuraDisplay.Debuffs, value = true},
        {index = Enum.NamePlateEnemyNpcAuraDisplay.CrowdControl, value = false},
    },
    nameplateFriendlyPlayerAuraDisplay = {
        {index = Enum.NamePlateFriendlyPlayerAuraDisplay.Buffs, value = false},
        {index = Enum.NamePlateFriendlyPlayerAuraDisplay.Debuffs, value = false},
        {index = Enum.NamePlateFriendlyPlayerAuraDisplay.LossOfControl, value = false},
    },
    nameplateInfoDisplay = {
        {index = Enum.NamePlateInfoDisplay.CurrentHealthPercent, value = false},
        {index = Enum.NamePlateInfoDisplay.CurrentHealthValue, value = false},
        {index = Enum.NamePlateInfoDisplay.RarityIcon, value = true},
    },
    nameplateThreatDisplay = {
        {index = Enum.NamePlateThreatDisplay.Progressive, value = false},
        {index = Enum.NamePlateThreatDisplay.Flash, value = false},
        {index = Enum.NamePlateThreatDisplay.HealthBarColor, value = false},
    },
    nameplateCastBarDisplay = {
        {index = Enum.NamePlateCastBarDisplay.SpellName, value = true},
        {index = Enum.NamePlateCastBarDisplay.SpellIcon, value = true},
        {index = Enum.NamePlateCastBarDisplay.SpellTarget, value = false},
        {index = Enum.NamePlateCastBarDisplay.HighlightImportantCasts, value = true},
        {index = Enum.NamePlateCastBarDisplay.HighlightWhenCastTarget, value = true},
    },
    nameplateSimplifiedTypes = {
        {index = Enum.NamePlateSimplifiedType.Minion, value = false},
        {index = Enum.NamePlateSimplifiedType.MinusMob, value = false},
        {index = Enum.NamePlateSimplifiedType.FriendlyPlayer, value = false},
        {index = Enum.NamePlateSimplifiedType.FriendlyNpc, value = false},
    },
    nameplateStackingTypes = {
        {index = Enum.NamePlateStackType.Enemy, value = true},
        {index = Enum.NamePlateStackType.Friendly, value = false},
    },
}

local cvarsPvE = cvars
local charCVarsPvE = charCVars

local uiScaleCVars = {
    uiScale = "0.8",
    useUiScale = "1",
}

local uiScaleCVarsPvE = {
    uiScale = "0.71",
    useUiScale = "1",
}

local platerCVars = {
    nameplateShowAll = "1",
    nameplateShowEnemyMinions = "1",
    nameplateShowEnemyGuardians = "1",
    nameplateShowEnemyMinus = "1",
    nameplateShowEnemyPets = "1",
    nameplateShowEnemyTotems = "1",
    nameplateShowFriendlyPlayerMinions = "0",
    nameplateShowFriendlyPlayerGuardians = "0",
    nameplateShowFriendlyPlayerPets = "0",
    nameplateShowFriendlyPlayerTotems = "0",
    --NamePlateClassificationScale = "1",
    --NamePlateHorizontalScale = "1",
    --NamePlateVerticalScale = "1",
}

function SC:BackupCVars(cvarSet)
    if cvarSet == "CVars" then
        if not SkillCappedBackupDB.CVars then
            if not SkillCappedBackupDB.CVarsPvE then
                SkillCappedBackupDB.CVars = {}
            else
                SkillCappedBackupDB.CVars = true
            end
            SkillCappedBackupDB.addonBackupTimes["CVars"] = date("%d/%m/%y %I:%M %p")
        end
        if type(SkillCappedBackupDB.CVars) == "table" then
            for cvar, _ in pairs(cvars) do
                if SkillCappedBackupDB.CVars[cvar] == nil then
                    local currentValue = C_CVar.GetCVar(cvar)
                    SkillCappedBackupDB.CVars[cvar] = currentValue
                end
            end
            for cvar, _ in pairs(charCVars) do
                if SkillCappedBackupDB.CVars[cvar] == nil then
                    local currentValue = C_CVar.GetCVar(cvar)
                    SkillCappedBackupDB.CVars[cvar] = currentValue
                end
            end
            if not SkillCappedBackupDB.CVars.bitfields then
                SkillCappedBackupDB.CVars.bitfields = {}
            end
            for cvarName, bitfields in pairs(bitCVars) do
                if not SkillCappedBackupDB.CVars.bitfields[cvarName] then
                    SkillCappedBackupDB.CVars.bitfields[cvarName] = {}
                end
                for _, bitfield in ipairs(bitfields) do
                    local key = tostring(bitfield.index)
                    if SkillCappedBackupDB.CVars.bitfields[cvarName][key] == nil then
                        local currentValue = C_CVar.GetCVarBitfield(cvarName, bitfield.index)
                        SkillCappedBackupDB.CVars.bitfields[cvarName][key] = currentValue
                    end
                end
            end
        end
    elseif cvarSet == "CVarsPvE" then
        if not SkillCappedBackupDB.CVarsPvE then
            if not SkillCappedBackupDB.CVars then
                SkillCappedBackupDB.CVarsPvE = {}
            else
                SkillCappedBackupDB.CVarsPvE = true
            end
            SkillCappedBackupDB.addonBackupTimes["CVarsPvE"] = date("%d/%m/%y %I:%M %p")
        end
        if type(SkillCappedBackupDB.CVarsPvE) == "table" then
            for cvar, _ in pairs(cvarsPvE) do
                if SkillCappedBackupDB.CVarsPvE[cvar] == nil then
                    local currentValue = C_CVar.GetCVar(cvar)
                    SkillCappedBackupDB.CVarsPvE[cvar] = currentValue
                end
            end
            for cvar, _ in pairs(charCVarsPvE) do
                if SkillCappedBackupDB.CVarsPvE[cvar] == nil then
                    local currentValue = C_CVar.GetCVar(cvar)
                    SkillCappedBackupDB.CVarsPvE[cvar] = currentValue
                end
            end
            if not SkillCappedBackupDB.CVarsPvE.bitfields then
                SkillCappedBackupDB.CVarsPvE.bitfields = {}
            end
            for cvarName, bitfields in pairs(bitCVars) do
                if not SkillCappedBackupDB.CVarsPvE.bitfields[cvarName] then
                    SkillCappedBackupDB.CVarsPvE.bitfields[cvarName] = {}
                end
                for _, bitfield in ipairs(bitfields) do
                    local key = tostring(bitfield.index)
                    if SkillCappedBackupDB.CVarsPvE.bitfields[cvarName][key] == nil then
                        local currentValue = C_CVar.GetCVarBitfield(cvarName, bitfield.index)
                        SkillCappedBackupDB.CVarsPvE.bitfields[cvarName][key] = currentValue
                    end
                end
            end
        end
    elseif cvarSet == "uiScaleCVars" then
        if not SkillCappedBackupDB.uiScaleCVars then
            if not SkillCappedBackupDB.uiScaleCVarsPvE then
                SkillCappedBackupDB.uiScaleCVars = {}
            else
                SkillCappedBackupDB.uiScaleCVars = true
            end
        end
        if type(SkillCappedBackupDB.uiScaleCVars) == "table" then
            for cvar, _ in pairs(uiScaleCVars) do
                if SkillCappedBackupDB.uiScaleCVars[cvar] == nil then
                    local currentValue = C_CVar.GetCVar(cvar)
                    SkillCappedBackupDB.uiScaleCVars[cvar] = currentValue
                end
            end
        end
    elseif cvarSet == "uiScaleCVarsPvE" then
        if not SkillCappedBackupDB.uiScaleCVarsPvE then
            if not SkillCappedBackupDB.uiScaleCVars then
                SkillCappedBackupDB.uiScaleCVarsPvE = {}
            else
                SkillCappedBackupDB.uiScaleCVarsPvE = true
            end
        end
        if type(SkillCappedBackupDB.uiScaleCVarsPvE) == "table" then
            for cvar, _ in pairs(uiScaleCVarsPvE) do
                if SkillCappedBackupDB.uiScaleCVarsPvE[cvar] == nil then
                    local currentValue = C_CVar.GetCVar(cvar)
                    SkillCappedBackupDB.uiScaleCVarsPvE[cvar] = currentValue
                end
            end
        end
    end
end

function SC:GetUIScaleCVars(contentType)
    if contentType == "PvP" then
        return uiScaleCVars
    elseif contentType == "PvE" then
        return uiScaleCVarsPvE
    end
end

function SC:RestoreCVars(cvarSet)
    SC.changingCVars = true
    if cvarSet == "CVars" then
        if SkillCappedBackupDB.CVars and type(SkillCappedBackupDB.CVars) == "table" then
            for cvar, value in pairs(SkillCappedBackupDB.CVars) do
                if cvar ~= "bitfields" then
                    C_CVar.SetCVar(cvar, value)
                    if cvar == "nameplateShowEnemyMinions" then
                        C_CVar.SetCVar("nameplateShowEnemyGuardians", SkillCappedBackupDB.CVars.nameplateShowEnemyGuardians)
                        C_CVar.SetCVar("nameplateShowEnemyMinus", SkillCappedBackupDB.CVars.nameplateShowEnemyMinus)
                        C_CVar.SetCVar("nameplateShowEnemyPets", SkillCappedBackupDB.CVars.nameplateShowEnemyPets)
                        C_CVar.SetCVar("nameplateShowEnemyTotems", SkillCappedBackupDB.CVars.nameplateShowEnemyTotems)
                    elseif cvar == "nameplateShowFriendlyPlayerMinions" then
                        C_CVar.SetCVar("nameplateShowFriendlyPlayerGuardians", SkillCappedBackupDB.CVars.nameplateShowFriendlyPlayerGuardians)
                        C_CVar.SetCVar("nameplateShowFriendlyPlayerPets", SkillCappedBackupDB.CVars.nameplateShowFriendlyPlayerPets)
                        C_CVar.SetCVar("nameplateShowFriendlyPlayerTotems", SkillCappedBackupDB.CVars.nameplateShowFriendlyPlayerTotems)
                    end
                end
            end
            -- Restore bitfield CVars
            if SkillCappedBackupDB.CVars.bitfields then
                for cvarName, bitfields in pairs(SkillCappedBackupDB.CVars.bitfields) do
                    for indexKey, value in pairs(bitfields) do
                        C_CVar.SetCVarBitfield(cvarName, tonumber(indexKey), value)
                    end
                end
            end
        end
    elseif cvarSet == "CVarsPvE" then
        if SkillCappedBackupDB.CVarsPvE and type(SkillCappedBackupDB.CVarsPvE) == "table" then
            for cvar, value in pairs(SkillCappedBackupDB.CVarsPvE) do
                if cvar ~= "bitfields" then
                    C_CVar.SetCVar(cvar, value)
                    if cvar == "nameplateShowEnemyMinions" then
                        C_CVar.SetCVar("nameplateShowEnemyGuardians", SkillCappedBackupDB.CVarsPvE.nameplateShowEnemyGuardians)
                        C_CVar.SetCVar("nameplateShowEnemyMinus", SkillCappedBackupDB.CVarsPvE.nameplateShowEnemyMinus)
                        C_CVar.SetCVar("nameplateShowEnemyPets", SkillCappedBackupDB.CVarsPvE.nameplateShowEnemyPets)
                        C_CVar.SetCVar("nameplateShowEnemyTotems", SkillCappedBackupDB.CVarsPvE.nameplateShowEnemyTotems)
                    elseif cvar == "nameplateShowFriendlyPlayerMinions" then
                        C_CVar.SetCVar("nameplateShowFriendlyPlayerGuardians", SkillCappedBackupDB.CVarsPvE.nameplateShowFriendlyPlayerGuardians)
                        C_CVar.SetCVar("nameplateShowFriendlyPlayerPets", SkillCappedBackupDB.CVarsPvE.nameplateShowFriendlyPlayerPets)
                        C_CVar.SetCVar("nameplateShowFriendlyPlayerTotems", SkillCappedBackupDB.CVarsPvE.nameplateShowFriendlyPlayerTotems)
                    end
                end
            end
            -- Restore bitfield CVars
            if SkillCappedBackupDB.CVarsPvE.bitfields then
                for cvarName, bitfields in pairs(SkillCappedBackupDB.CVarsPvE.bitfields) do
                    for indexKey, value in pairs(bitfields) do
                        C_CVar.SetCVarBitfield(cvarName, tonumber(indexKey), value)
                    end
                end
            end
        end
    elseif cvarSet == "uiScaleCVars" then
        if SkillCappedBackupDB.uiScaleCVars and type(SkillCappedBackupDB.uiScaleCVars) == "table" then
            for cvar, value in pairs(SkillCappedBackupDB.uiScaleCVars) do
                C_CVar.SetCVar(cvar, value)
            end
        end
    elseif cvarSet == "uiScaleCVarsPvE" then
        if SkillCappedBackupDB.uiScaleCVarsPvE and type(SkillCappedBackupDB.uiScaleCVarsPvE) == "table" then
            for cvar, value in pairs(SkillCappedBackupDB.uiScaleCVarsPvE) do
                C_CVar.SetCVar(cvar, value)
            end
        end
    end
    SC.changingCVars = nil
end

function SC:ApplyCVarPreset(cvarSet)
    SC.changingCVars = true
    SC:BackupCVars(cvarSet)
    if cvarSet == "CVars" then
        for cvar, value in pairs(cvars) do
            if value ~= "tempValue" then
                C_CVar.SetCVar(cvar, value)
            end
        end
        for cvar, value in pairs(charCVars) do
            C_CVar.SetCVar(cvar, value)
        end
        C_CVar.SetCVar("nameplateShowEnemyGuardians", charCVars.nameplateShowEnemyGuardians)
        C_CVar.SetCVar("nameplateShowEnemyMinus", charCVars.nameplateShowEnemyMinus)
        C_CVar.SetCVar("nameplateShowEnemyPets", charCVars.nameplateShowEnemyPets)
        C_CVar.SetCVar("nameplateShowEnemyTotems", charCVars.nameplateShowEnemyTotems)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerGuardians", charCVars.nameplateShowFriendlyPlayerGuardians)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerPets", charCVars.nameplateShowFriendlyPlayerPets)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerTotems", charCVars.nameplateShowFriendlyPlayerTotems)
        for cvarName, bitfields in pairs(bitCVars) do
            for _, bitfield in ipairs(bitfields) do
                C_CVar.SetCVarBitfield(cvarName, bitfield.index, bitfield.value)
            end
        end
        SC:MeasureLatencyAndAdjustSpellQueue()
    elseif cvarSet == "CVarsPvE" then
        for cvar, value in pairs(cvarsPvE) do
            if value ~= "tempValue" then
                C_CVar.SetCVar(cvar, value)
            end
        end
        for cvar, value in pairs(charCVarsPvE) do
            C_CVar.SetCVar(cvar, value)
        end
        C_CVar.SetCVar("nameplateShowEnemyGuardians", charCVarsPvE.nameplateShowEnemyGuardians)
        C_CVar.SetCVar("nameplateShowEnemyMinus", charCVarsPvE.nameplateShowEnemyMinus)
        C_CVar.SetCVar("nameplateShowEnemyPets", charCVarsPvE.nameplateShowEnemyPets)
        C_CVar.SetCVar("nameplateShowEnemyTotems", charCVarsPvE.nameplateShowEnemyTotems)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerGuardians", charCVarsPvE.nameplateShowFriendlyPlayerGuardians)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerPets", charCVarsPvE.nameplateShowFriendlyPlayerPets)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerTotems", charCVarsPvE.nameplateShowFriendlyPlayerTotems)
        for cvarName, bitfields in pairs(bitCVars) do
            for _, bitfield in ipairs(bitfields) do
                C_CVar.SetCVarBitfield(cvarName, bitfield.index, bitfield.value)
            end
        end
        SC:MeasureLatencyAndAdjustSpellQueue()
    elseif cvarSet == "uiScaleCVars" then
        local targetCVars = (SkillCappedDB.cvarSets and SkillCappedDB.cvarSets["SkillCapped PvP"]) or uiScaleCVars
        for cvar, value in pairs(targetCVars) do
            C_CVar.SetCVar(cvar, value)
        end
    elseif cvarSet == "uiScaleCVarsPvE" then
        local targetCVars = (SkillCappedDB.cvarSets and SkillCappedDB.cvarSets["SkillCapped PvE"]) or uiScaleCVarsPvE
        for cvar, value in pairs(targetCVars) do
            C_CVar.SetCVar(cvar, value)
        end
    end
    SC.changingCVars = nil
end

function SC:ApplyCharacterCVarPreset(contentType)
    if contentType == "PvP" then
        for cvar, value in pairs(charCVars) do
            C_CVar.SetCVar(cvar, value)
        end
        C_CVar.SetCVar("nameplateShowEnemyGuardians", charCVars.nameplateShowEnemyGuardians)
        C_CVar.SetCVar("nameplateShowEnemyMinus", charCVars.nameplateShowEnemyMinus)
        C_CVar.SetCVar("nameplateShowEnemyPets", charCVars.nameplateShowEnemyPets)
        C_CVar.SetCVar("nameplateShowEnemyTotems", charCVars.nameplateShowEnemyTotems)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerGuardians", charCVars.nameplateShowFriendlyPlayerGuardians)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerPets", charCVars.nameplateShowFriendlyPlayerPets)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerTotems", charCVars.nameplateShowFriendlyPlayerTotems)
    elseif contentType == "PvE" then
        for cvar, value in pairs(charCVars) do
            C_CVar.SetCVar(cvar, value)
        end
        C_CVar.SetCVar("nameplateShowEnemyGuardians", charCVars.nameplateShowEnemyGuardians)
        C_CVar.SetCVar("nameplateShowEnemyMinus", charCVars.nameplateShowEnemyMinus)
        C_CVar.SetCVar("nameplateShowEnemyPets", charCVars.nameplateShowEnemyPets)
        C_CVar.SetCVar("nameplateShowEnemyTotems", charCVars.nameplateShowEnemyTotems)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerGuardians", charCVars.nameplateShowFriendlyPlayerGuardians)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerPets", charCVars.nameplateShowFriendlyPlayerPets)
        C_CVar.SetCVar("nameplateShowFriendlyPlayerTotems", charCVars.nameplateShowFriendlyPlayerTotems)
        for cvar, value in pairs (platerCVars) do
            C_CVar.SetCVar(cvar, value)
        end
    end
end