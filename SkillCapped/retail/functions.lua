local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:PlayerElite(mode)
    if not PlayerFrame.PlayerFrameContainer.PlayerElite then
        PlayerFrame.PlayerFrameContainer.PlayerElite = PlayerFrame.PlayerFrameContainer:CreateTexture(nil, "OVERLAY")
        PlayerFrame.PlayerFrameContainer.PlayerElite:SetTexCoord(1, 0, 0, 1)
        PetPortrait:GetParent():SetFrameLevel(4)
        RuneFrame:SetFrameLevel(4)
    end
    local playerElite = PlayerFrame.PlayerFrameContainer.PlayerElite
    local alpha = SkillCappedDB.playerElite and 1 or 0
    playerElite:SetDesaturated(false)
    -- Set Elite style according to value
    if mode == 1 then -- Elite (Gold)
        playerElite:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold", true)
        playerElite:ClearAllPoints()
        playerElite:SetPoint("TOPLEFT", 8, -9)
        playerElite:SetVertexColor(1, 1, 1, alpha)
    elseif mode == 2 then -- Boss (Gold Winged)
        playerElite:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold-Winged", true)
        playerElite:ClearAllPoints()
        playerElite:SetPoint("TOPLEFT", -11, -8)
        playerElite:SetVertexColor(1, 1, 1, alpha)
    elseif mode == 3 then -- Rare (Silver)
        playerElite:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Boss-Rare-Silver", true)
        playerElite:ClearAllPoints()
        playerElite:SetPoint("TOPLEFT", 8, -9)
        playerElite:SetVertexColor(1, 1, 1, alpha)
    elseif mode == 4 then -- Boss (Silver Winged)
        playerElite:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold-Winged", true)
        playerElite:ClearAllPoints()
        playerElite:SetPoint("TOPLEFT", -11, -8)
        playerElite:SetVertexColor(1, 1, 1, alpha)
        playerElite:SetDesaturated(true)
    end
end

function SC:HideHitIndicator()
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator:Hide()
    hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Hide)
end

function SC:HideErrorFrame()
    --	Error message events
    local OrigErrHandler = UIErrorsFrame:GetScript('OnEvent')
    UIErrorsFrame:SetScript('OnEvent', function (self, event, id, err, ...)
        if event == "UI_ERROR_MESSAGE" then
            -- Hide error messages
            if 	err == ERR_INV_FULL or
                err == ERR_QUEST_LOG_FULL or
                err == ERR_RAID_GROUP_ONLY	or
                err == ERR_PARTY_LFG_BOOT_LIMIT or
                err == ERR_PARTY_LFG_BOOT_DUNGEON_COMPLETE or
                err == ERR_PARTY_LFG_BOOT_IN_COMBAT or
                err == ERR_PARTY_LFG_BOOT_IN_PROGRESS or
                err == ERR_PARTY_LFG_BOOT_LOOT_ROLLS or
                err == ERR_PARTY_LFG_TELEPORT_IN_COMBAT or
                err == ERR_PET_SPELL_DEAD or
                err == ERR_PLAYER_DEAD or
                err == SPELL_FAILED_TARGET_NO_POCKETS or
                err == ERR_ALREADY_PICKPOCKETED or
                err:find(format(ERR_PARTY_LFG_BOOT_NOT_ELIGIBLE_S, ".+")) then
                    return OrigErrHandler(self, event, id, err, ...)
            end
        elseif event == 'UI_INFO_MESSAGE'  then
            -- Show information messages
            return OrigErrHandler(self, event, id, err, ...)
        end
    end)

    -- Hide ping system errors
    UIParent:UnregisterEvent("PING_SYSTEM_ERROR")
end

function SC:QueuePopNotification()
    if PVPReadyDialog_Display then
        hooksecurefunc("PVPReadyDialog_Display", function()
            PlaySound(12867, "Master")
        end)
    end

    SC:RegisterEvent("LFG_PROPOSAL_SHOW", function()
        local proposalExists, _, _, _, _, _, _, hasResponded = GetLFGProposal()
        if proposalExists and not hasResponded then
            PlaySoundFile(567458, "master")
        end
    end)
end

function SC:FadeStatusBar()
    local bar = MainStatusTrackingBarContainer
    local updaterFrame = CreateFrame("Frame")

    -- Setup hooks for mouse enter and leave
    bar:HookScript("OnEnter", function()
        --bar:SetAlpha(1)
        SC:FadeInFrame(bar, 0.1)
    end)
    bar:HookScript("OnLeave", function()
        --bar:SetAlpha(0)
        SC:FadeOutFrame(bar, 1.2)
    end)

    bar:HookScript("OnShow", function()
        if not bar:IsMouseOver() then
            bar:SetAlpha(0)
        end
    end)

    --This function checks if the bar is visible and hides it if it is
    local function UpdateHandler(self, elapsed)
        if bar and bar:GetAlpha() ~= 0 then
            bar:SetAlpha(0)
            self:SetScript("OnUpdate", nil)
        end
    end

    -- Register the update handler
    updaterFrame:SetScript("OnUpdate", UpdateHandler)
end

function SC:FadeBagsAndMicroMenu()
    local fadeTimer = nil -- Holds the current fade-out timer
    local gracePeriod = 0.5 -- Grace period before fading out
    local isFadedIn = false -- Tracks whether elements are already faded in

    -- Fade helper for multiple frames
    local function FadeElements(fadeType, duration)
        local frames = {BagsBar, MicroMenu, MicroMenuContainer}
        for _, child in ipairs({MicroMenu:GetChildren()}) do
            table.insert(frames, child)
        end

        for _, frame in ipairs(frames) do
            local adjustedDuration = duration

            -- Make BagsBar fade out 0.2 seconds faster
            if frame == BagsBar and fadeType == "out" then
                adjustedDuration = math.max(duration - 0.6, 0) -- Ensure non-negative duration
            end

            if EditModeManagerFrame:IsEditModeActive() then
                SC:FadeInFrame(frame, 0) -- Force full alpha if Edit Mode is active
            else
                if fadeType == "in" then
                    SC:FadeInFrame(frame, adjustedDuration)
                elseif fadeType == "out" then
                    SC:FadeOutFrame(frame, adjustedDuration)
                end
            end
        end
    end

    -- Mouseover detection
    local function IsAnyMouseOver()
        if BagsBar:IsMouseOver() or MicroMenu:IsMouseOver() or MicroMenuContainer:IsMouseOver() then
            return true
        end
        for _, child in ipairs({BagsBar:GetChildren(), MicroMenu:GetChildren()}) do
            if child:IsMouseOver() then
                return true
            end
        end
        return false
    end

    -- Show elements (fade in)
    local function ShowElements()
        if not isFadedIn and not EditModeManagerFrame:IsEditModeActive() then -- Only fade in if not already visible and Edit Mode inactive
            if fadeTimer then
                fadeTimer:Cancel() -- Cancel any pending fade-out
                fadeTimer = nil
            end
            FadeElements("in", 0.1) -- Smooth fade-in
            isFadedIn = true
        end
    end

    -- Hide elements (fade out with grace period)
    local function HideElements()
        if fadeTimer then
            fadeTimer:Cancel() -- Reset any existing timer
        end

        fadeTimer = C_Timer.NewTimer(gracePeriod, function()
            if not IsAnyMouseOver() and not EditModeManagerFrame:IsEditModeActive() then
                FadeElements("out", 1.1) -- Smooth fade-out
                isFadedIn = false -- Mark as faded out
            end
        end)
    end

    -- Reset alpha on Edit Mode toggle
    local function ResetAlphaOnEditMode()
        if EditModeManagerFrame:IsEditModeActive() then
            -- Force all frames to full alpha
            FadeElements("in", 0)
        else
            -- Fade out frames instantly if Edit Mode is closed
            FadeElements("out", 0)
            isFadedIn = false
        end
    end

    -- Initial state: start hidden if not in Edit Mode
    if not EditModeManagerFrame:IsEditModeActive() then
        FadeElements("out", 0) -- Instantly fade out all elements
        isFadedIn = false
    else
        FadeElements("in", 0) -- Full alpha when Edit Mode is active
    end

    -- Apply hooks only once
    if not BagsBar.scHooked then
        -- Hooks for BagsBar and its children
        BagsBar:HookScript("OnEnter", ShowElements)
        BagsBar:HookScript("OnLeave", HideElements)

        for _, child in ipairs({BagsBar:GetChildren()}) do
            child:HookScript("OnEnter", ShowElements)
            child:HookScript("OnLeave", HideElements)
        end

        BagsBar.scHooked = true
    end

    if not MicroMenu.scHooked then
        -- Hooks for MicroMenu, MicroMenuContainer, and its children
        MicroMenu:HookScript("OnEnter", ShowElements)
        MicroMenu:HookScript("OnLeave", HideElements)

        MicroMenuContainer:HookScript("OnEnter", ShowElements)
        MicroMenuContainer:HookScript("OnLeave", HideElements)

        for _, child in ipairs({MicroMenu:GetChildren()}) do
            child:HookScript("OnEnter", ShowElements)
            child:HookScript("OnLeave", HideElements)
        end

        -- Special case for QueueStatusButton if required
        QueueStatusButton:SetParent(UIParent)
        QueueStatusButton:SetFrameLevel(10)

        MicroMenu.scHooked = true
    end

    -- Hook into Edit Mode events to reset alpha
    hooksecurefunc(EditModeManagerFrame, "EnterEditMode", ResetAlphaOnEditMode)
    hooksecurefunc(EditModeManagerFrame, "ExitEditMode", ResetAlphaOnEditMode)
end

local function SmartTabTargeting()
    local pvpKeyAction = "TARGETNEARESTENEMYPLAYER"
    local pveKeyAction = "TARGETNEARESTENEMY"
    local isPvp = SC:GetCurrentInstanceType() == "PvP"

    -- Determine which action to bind
    local newAction, descriptor
    if isPvp then
        newAction = pvpKeyAction
        descriptor = "Target Nearest Enemy Player"
    else
        newAction = pveKeyAction
        descriptor = "Target Nearest Enemy"
    end

    -- Check existing keybindings for both actions
    local pveKey = GetBindingKey(pveKeyAction)
    local pvpKey = GetBindingKey(pvpKeyAction)

    -- Determine the key to use (reuse the current binding if either is already assigned)
    local keyToUse = pveKey or pvpKey

    if not keyToUse then
        SC:Print("No Tab Target keybind set. Keybind either \"Target Nearest Enemy\" or \"Target Nearest Enemy Player\" for Smart Tab Targeting to work.")
        return
    end

    if pveKey and pvpKey then
        SC:Print("Tab Targeting currently has two keybinds. Unbind either \"Target Nearest Enemy\" or \"Target Nearest Enemy Player\" for Smart Tab Targeting to work.")
        return
    end

    -- Check if the current binding matches the desired action
    local currentBinding = GetBindingAction(keyToUse)
    if currentBinding == newAction then
        return
    end

    -- Rebind the key to the new action
    SetBinding(keyToUse, newAction)
    SaveBindings(GetCurrentBindingSet())
    --SC:Print("Tab targeting set to \""..descriptor.."\".")
end

local function EnableSmartTabTargeting()
    if not SC.smartTabTargeting then
        SC.smartTabTargeting = SC:RegisterEvent("PLAYER_ENTERING_WORLD", function()
            SC:RunAfterCombat(function()
                SmartTabTargeting()
            end)
        end)
    end
end

local function HidePlayerPower()
    local classPowerFrames = {
        WARLOCK = { frame = WarlockPowerFrame, useParent = true },
        ROGUE = { frame = RogueComboPointBarFrame, useParent = true },
        DRUID = { frame = DruidComboPointBarFrame, useAlpha = true },
        PALADIN = { frame = PaladinPowerBarFrame, useParent = true },
        DEATHKNIGHT = { frame = RuneFrame, useParent = true },
        EVOKER = { frame = EssencePlayerFrame, useParent = true },
        MONK = { frame = MonkHarmonyBarFrame, useParent = true },
        MAGE = { frame = MageArcaneChargesFrame, useAlpha = true },
    }
    local _, englishClass = UnitClass("player")
    local data = classPowerFrames[englishClass]
    local hiddenFrame = CreateFrame("Frame")
    hiddenFrame:Hide()
    if data and data.frame then
        if data.useParent then
            data.frame:SetParent(hiddenFrame)
        elseif data.useAlpha then
            data.frame:SetAlpha(0)
        end
    end
end

-------------------------------
--  Set configurations
-------------------------------
function SC:LoadConfigs()
    local db = SkillCappedDB

    if db.newFonts then
        SC:SetFonts()
    end

    if db.playerElite then
        SC:PlayerElite(db.playerEliteMode)
    end

    if db.hidePlayerPower and SkillCappedDB.mainContent == "PvE" then
        HidePlayerPower()
    end

    if db.hideErrorFrame then
        SC:HideErrorFrame()
    end

    if db.hideHitIndicator then
        SC:HideHitIndicator()
    end

    if db.queuePopNotification then
        SC:QueuePopNotification()
    end

    if db.fadeStatusBar then
        SC:FadeStatusBar()
    end

    if db.fadeMicroMenu then
        SC:FadeBagsAndMicroMenu()
    end

    if db.smartTabTargeting then
        SC:RunAfterCombat(function()
            EnableSmartTabTargeting()
        end)
    end

    if db.completedSetup then -- wait for backup before applying cvars
        if db.combinedBags == "1" then C_CVar.SetCVar("combinedBags", db.combinedBags) end
        if db.ReplaceMyPlayerPortrait == "1" then
            C_CVar.SetCVar("ReplaceMyPlayerPortrait", db.ReplaceMyPlayerPortrait)
            C_CVar.SetCVar("ReplaceOtherPlayerPortraits", db.ReplaceMyPlayerPortrait)
        end
        --if db.nameplateShowSelf == "0" then C_CVar.SetCVar("nameplateShowSelf", db.nameplateShowSelf) end
        --if db.nameplateResourceOnTarget == "1" then C_CVar.SetCVar("nameplateResourceOnTarget", db.nameplateResourceOnTarget) end
    end
end