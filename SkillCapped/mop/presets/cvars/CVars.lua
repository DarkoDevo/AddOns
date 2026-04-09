local AddonName, SkillCapped = ...
local SC = SkillCapped

local cvars = {
    --ActionButtonUseKeyHeldSpell = "0",
    alwaysShowActionBars = "1",
    autoDismountFlying = "1",
    cameraDistanceMaxZoomFactor = "3.4000000953674",
    cameraSmoothStyle = "0",
    chatBubbles = "0",
    chatBubblesParty = "0",
    countdownForCooldowns = "0",
    deselectOnClick = "0",
    enableFloatingCombatText = "0",
    graphicsProjectedTextures = "1",
    lootUnderMouse = "1",
    instantQuestText = "1",
    Outline = "2",
    projectedTextures = "1",
    --RAIDweatherDensity = "1",
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
    --UnitNameFriendlyPlayerName = "1",
    --UnitNameFriendlySpecialNPCName = "1",
    --UnitNameHostleNPC = "1",
    --UnitNameInteractiveNPC = "1",
    --UnitNameNonCombatCreatureName = "1",
    UnitNameNPC = "1",
    UnitNameOwn = "1",
    --UnitNamePlayerPVPTitle = "1",
    --weatherDensity = "1",
    -- for backup only
    --combinedBags = "tempValue",
    SpellQueueWindow = "tempValue",
    vsync = "tempValue",
}

local charCVars = {
    autoLootDefault = "1",
    autoSelfCast = "1",
    --lossOfControl = "1",
    nameplateMinAlpha = "1",
    nameplateOccludedAlpha = "0.8",
    nameplateSelectedAlpha = "1",
    nameplateNotSelectedAlpha = "0.8",
    nameplateMinScale = "1",
    nameplateMaxScale = "1",
    nameplateGlobalScale = "1",
    nameplateSelectedScale = "1.3",
    nameplateShowAll = "1",
    nameplateMaxDistance = "41",
    nameplateShowEnemies = "1",
    nameplateMotion = "1",
    nameplateOverlapH = "0.8",
    nameplateOverlapV = "0.8",
    nameplateShowEnemyMinions = "1",
    nameplateShowEnemyGuardians = "1",
    nameplateShowEnemyMinus = "0",
    nameplateShowEnemyPets = "1",
    nameplateShowEnemyTotems = "1",
    nameplateShowFriendlyMinions = "0",
    nameplateShowFriendlyGuardians = "0",
    nameplateShowFriendlyPets = "0",
    nameplateShowFriendlyTotems = "0",
    ShowClassColorInNameplate = "1",
    SoftTargetEnemy = "0",
    -- NamePlateClassificationScale = "1.25",
    -- NamePlateHorizontalScale = "1.4",
    -- NamePlateVerticalScale = "2.7",
    -- noBuffDebuffFilterOnTarget = "0",
    raidFramesDisplayClassColor = "1",
    -- raidFramesDisplayDebuffs = "1",
    -- raidFramesDisplayIncomingHeals = "1",
    raidFramesDisplayOnlyDispellableDebuffs = "0",
    raidFramesDisplayPowerBars = "1",
    raidFramesHealthText = "none",
    raidOptionDisplayMainTankAndAssist = "0",
    raidOptionDisplayPets = "1",
    stopAutoAttackOnTargetChange = "0",
}

local cvarsPvE = cvars
local charCVarsPvE = charCVars

local uiScaleCVars = {
    uiScale = "0.8",
    useCompactPartyFrames = "1",
    useUiScale = "1",
}

local uiScaleCVarsPvE = {
    uiScale = "0.8",
    useCompactPartyFrames = "1",
    useUiScale = "1",
}

local platerCVars = {
    nameplateShowAll = "1",
    nameplateShowEnemyMinions = "1",
    nameplateShowEnemyGuardians = "1",
    nameplateShowEnemyMinus = "1",
    nameplateShowEnemyPets = "1",
    nameplateShowEnemyTotems = "1",
    nameplateShowFriendlyMinions = "0",
    nameplateShowFriendlyGuardians = "0",
    nameplateShowFriendlyPets = "0",
    nameplateShowFriendlyTotems = "0",
    NamePlateClassificationScale = "1",
    NamePlateHorizontalScale = "1",
    NamePlateVerticalScale = "1",
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
                C_CVar.SetCVar(cvar, value)
                if cvar == "nameplateShowEnemyMinions" then
                    C_CVar.SetCVar("nameplateShowEnemyGuardians", SkillCappedBackupDB.CVars.nameplateShowEnemyGuardians)
                    C_CVar.SetCVar("nameplateShowEnemyMinus", SkillCappedBackupDB.CVars.nameplateShowEnemyMinus)
                    C_CVar.SetCVar("nameplateShowEnemyPets", SkillCappedBackupDB.CVars.nameplateShowEnemyPets)
                    C_CVar.SetCVar("nameplateShowEnemyTotems", SkillCappedBackupDB.CVars.nameplateShowEnemyTotems)
                elseif cvar == "nameplateShowFriendlyMinions" then
                    C_CVar.SetCVar("nameplateShowFriendlyGuardians", SkillCappedBackupDB.CVars.nameplateShowFriendlyGuardians)
                    C_CVar.SetCVar("nameplateShowFriendlyPets", SkillCappedBackupDB.CVars.nameplateShowFriendlyPets)
                    C_CVar.SetCVar("nameplateShowFriendlyTotems", SkillCappedBackupDB.CVars.nameplateShowFriendlyTotems)
                end
            end
        end
    elseif cvarSet == "CVarsPvE" then
        if SkillCappedBackupDB.CVarsPvE and type(SkillCappedBackupDB.CVarsPvE) == "table" then
            for cvar, value in pairs(SkillCappedBackupDB.CVarsPvE) do
                C_CVar.SetCVar(cvar, value)
                if cvar == "nameplateShowEnemyMinions" then
                    C_CVar.SetCVar("nameplateShowEnemyGuardians", SkillCappedBackupDB.CVarsPvE.nameplateShowEnemyGuardians)
                    C_CVar.SetCVar("nameplateShowEnemyMinus", SkillCappedBackupDB.CVarsPvE.nameplateShowEnemyMinus)
                    C_CVar.SetCVar("nameplateShowEnemyPets", SkillCappedBackupDB.CVarsPvE.nameplateShowEnemyPets)
                    C_CVar.SetCVar("nameplateShowEnemyTotems", SkillCappedBackupDB.CVarsPvE.nameplateShowEnemyTotems)
                elseif cvar == "nameplateShowFriendlyMinions" then
                    C_CVar.SetCVar("nameplateShowFriendlyGuardians", SkillCappedBackupDB.CVarsPvE.nameplateShowFriendlyGuardians)
                    C_CVar.SetCVar("nameplateShowFriendlyPets", SkillCappedBackupDB.CVarsPvE.nameplateShowFriendlyPets)
                    C_CVar.SetCVar("nameplateShowFriendlyTotems", SkillCappedBackupDB.CVarsPvE.nameplateShowFriendlyTotems)
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
        C_CVar.SetCVar("nameplateShowFriendlyGuardians", charCVars.nameplateShowFriendlyGuardians)
        C_CVar.SetCVar("nameplateShowFriendlyPets", charCVars.nameplateShowFriendlyPets)
        C_CVar.SetCVar("nameplateShowFriendlyTotems", charCVars.nameplateShowFriendlyTotems)
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
        C_CVar.SetCVar("nameplateShowFriendlyGuardians", charCVarsPvE.nameplateShowFriendlyGuardians)
        C_CVar.SetCVar("nameplateShowFriendlyPets", charCVarsPvE.nameplateShowFriendlyPets)
        C_CVar.SetCVar("nameplateShowFriendlyTotems", charCVarsPvE.nameplateShowFriendlyTotems)
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
        C_CVar.SetCVar("nameplateShowFriendlyGuardians", charCVars.nameplateShowFriendlyGuardians)
        C_CVar.SetCVar("nameplateShowFriendlyPets", charCVars.nameplateShowFriendlyPets)
        C_CVar.SetCVar("nameplateShowFriendlyTotems", charCVars.nameplateShowFriendlyTotems)
    elseif contentType == "PvE" then
        for cvar, value in pairs(charCVars) do
            C_CVar.SetCVar(cvar, value)
        end
        C_CVar.SetCVar("nameplateShowEnemyGuardians", charCVars.nameplateShowEnemyGuardians)
        C_CVar.SetCVar("nameplateShowEnemyMinus", charCVars.nameplateShowEnemyMinus)
        C_CVar.SetCVar("nameplateShowEnemyPets", charCVars.nameplateShowEnemyPets)
        C_CVar.SetCVar("nameplateShowEnemyTotems", charCVars.nameplateShowEnemyTotems)
        C_CVar.SetCVar("nameplateShowFriendlyGuardians", charCVars.nameplateShowFriendlyGuardians)
        C_CVar.SetCVar("nameplateShowFriendlyPets", charCVars.nameplateShowFriendlyPets)
        C_CVar.SetCVar("nameplateShowFriendlyTotems", charCVars.nameplateShowFriendlyTotems)
        for cvar, value in pairs (platerCVars) do
            C_CVar.SetCVar(cvar, value)
        end
    end
end