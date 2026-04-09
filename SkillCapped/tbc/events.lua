local AddonName, SkillCapped = ...
local SC = SkillCapped

local coloredAddonName = "|cFFFFFFFFSkill|r|cff7ba4fcCapped|r"

SC:RegisterEvent("PLAYER_LOGIN", function()
    local tocversion = select(4, GetBuildInfo())
    C_CVar.SetCVar("checkAddonVersion", "0")
    C_CVar.SetCVar("lastAddonVersion", tocversion)

    if not SkillCappedDB then
        SkillCappedDB = SC:DefaultSettings()
    else
        -- Update existing settings if new entries
        local defaults = SC:DefaultSettings()
        for key, value in pairs(defaults) do
            if SkillCappedDB[key] == nil then
                SkillCappedDB[key] = value
            end
        end
    end

    local currentAddonVersion = C_AddOns.GetAddOnMetadata(AddonName, "Version")
    local db = SkillCappedDB

    if not db.version then
        db.version = currentAddonVersion
    end

    if not db.characters then
        db.characters = {}
    end

    if not db.profileUpdates then
        db.profileUpdates = {}
    end

    if not db.weakauraToggles then
        db.weakauraToggles = {}
    end

    -- Store GUID for AddonList
    local playerGUID = UnitGUID("player")
    if not SkillCappedDB.characterGUIDs then
        SkillCappedDB.characterGUIDs = {}
    end
    if playerGUID then
        if not SkillCappedDB.characterGUIDs[playerGUID] then
            SkillCappedDB.characterGUIDs[playerGUID] = true
        end
    end

    if not SkillCappedBackupDB then
        SkillCappedBackupDB = {}
    end

    if not db.enabledAddons then
        db.enabledAddons = {}
    end

    if not SkillCappedBackupDB.addonBackupTimes then
        SkillCappedBackupDB.addonBackupTimes = {}
    end

    if SkillCappedBackupDB.FrameColorDB and not SkillCappedBackupDB.FrameColorDB then
        SkillCappedBackupDB.FrameColorDB = SC:DeepCopy(FrameColorDB)
        SkillCappedBackupDB.addonBackupTimes["FrameColor"] = SC:GetDateAndTime()
    end

    SC:TempVariableCleanup()

    local playerNameAndRealm = SC:GetPlayerNameAndRealm()

    if db.characters[playerNameAndRealm] then
        if db.characters[playerNameAndRealm] == true then
            db.characters[playerNameAndRealm] = "PvP"
        end
        db.mainContent = db.characters[playerNameAndRealm]
        if db.characterGUIDs[playerGUID] == true then
            db.characterGUIDs[playerGUID] = db.mainContent
        end
        if db.secondaryContent ~= "None" then
            if db.mainContent == "PvP" then
                db.secondaryContent = "PvE"
            elseif db.mainContent == "PvE" then
                db.secondaryContent = "PvP"
            end
        end
        local cvarsToApply = SkillCappedDB.mainContent == "PvP" and "uiScaleCVars" or "uiScaleCVarsPvE"
        SC:ApplyCVarPreset(cvarsToApply)
    end

    if db.completedSetup and not db.tbcInitialized then
        SC.newSeasonLaunch = true
        -- Popup Pve updated
        -- db.twwS3WAUpdate = true
        StaticPopupDialogs["SC_TBC_UPDATE"] = {
            text = SC.Logo.."\n\nThe SkillCapped addon has been updated for TBC!\n\nIn order to install the new updated UI we will first clean up all saved SkillCapped specific settings and do a fresh start.\n\nThis will *not* delete your other addon settings, just SkillCapped's settings.\n\nOn the new install it will backup your current addon settings again and overwrite any selected profiles with the new profiles as before.\n",
            button1 = "Reload & Start",
            button2 = "Close",
            OnAccept = function()
                -- if InCombatLockdown() then
                --     SC:Print("Leave combat to enter Setup. Make sure you are out of combat while installing.")
                --     return
                -- end
                SkillCappedDB = nil
                SkillCappedDB = SC:DefaultSettings()
                SkillCappedBackupDB = nil
                SkillCappedWeakAurasDB = nil
                SkillCappedDB.tbcInitialized = true
                SC:ToggleAddons()
                --SkillCappedDB.reOpenToAddonConfig = true
                SC:ApplyAddonChanges()
                ReloadUI()
                --SC.setupActive = true
                --SC:MakeGUI(true)
            end,
            timeout = 0,
            whileDead = true,
        }
        StaticPopup_Show("SC_TBC_UPDATE")
    end

    SC:CreateBlizzGUI()
    -- if not SC:IsRetail() then
    --     SC:ImportGUI()
    -- end
    SC:LoadConfigs()

    --if db.mainContent == "PvP" and UnitLevel("player") >= 10 then
        C_Timer.After(0.5, function()
            SC:BisGearPanel()
        end)
    --end

    -- if db.openInstallerOnLaunch then
    --     SC.newMopLaunch = true
    --     SC.setupActive = true
    --     SC:MakeGUI()
    --     db.openInstallerOnLaunch = nil
    -- else
        C_Timer.After(4, function()
            SC:CheckForAddonManagers()
            if db.editModeIsFull then
                StaticPopup_Show("SC_EDITMODE_FULL")
                db.editModeIsFull = nil
                db.editModeFullButHasProfile = nil
            elseif SkillCappedDB.editModeFullButHasProfile then
                local existingProfile = db.editModeFullButHasProfile
                StaticPopup_Show("SC_EDITMODE_FULL_HAS_PROFILE", existingProfile)
                db.editModeFullButHasProfile = nil
                db.editModeIsFull = nil
            end
        end)
    --end
end)

SC.PlayerEnteringWorld = SC:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    C_Timer.After(0.8, function() --TODO: Better method
        if not SC:OnCinematicEvent() then
            SC:RunAfterCombat(function()
                SC:SetupSettingsAndGUI()
            end)
        end
        if true then --IsRetail
            C_Timer.After(3, function()
                local cvarListener = CreateFrame("Frame")
                cvarListener:RegisterEvent("CVAR_UPDATE")
                cvarListener:SetScript("OnEvent", function(self, event, cvarName, cvarValue)
                    if SkillCappedDB[cvarName] then
                        SkillCappedDB[cvarName] = cvarValue
                    end
                    if (cvarName == "uiScale" or cvarName == "useUiScale") and not SC.changingCVars then
                        local setName = SC:GetSetName()
                        local contentType = SkillCappedDB.mainContent
                        SkillCappedDB.cvarSets[setName].uiScale = C_CVar.GetCVar("uiScale")
                        SkillCappedDB.cvarSets[setName].useUiScale = C_CVar.GetCVar("useUiScale")

                        if cvarName == "uiScale" then
                            local roundedValue = math.floor(cvarValue * 100 + 0.5) / 100
                            SC:Print("UI Scale ("..roundedValue..") saved to "..contentType.." UI.")
                        end
                    end
                end)

                if SC:IsRetail() then
                    local function SaveEditModeProfile()
                        local setName = SC:GetSetName()
                        local activeLayout = SC:GetActiveEditModeLayout()
                        local contentType = SkillCappedDB.mainContent
                        SkillCappedDB.editmodeSets[setName] = activeLayout

                        if contentType == "PvP" and activeLayout ~= "SkillCapped" then
                            SkillCappedDB.enabledAddons["EditModePvP"] = nil
                        elseif contentType == "PvE" and activeLayout ~= "SkillCapped PvE" then
                            SkillCappedDB.enabledAddons["EditModePvE"] = nil
                        end

                        SC:Print("EditMode Profile \""..activeLayout.."\" saved to "..contentType.." UI.")
                    end
                    hooksecurefunc(EditModeManagerFrame, "SelectLayout", function()
                        SaveEditModeProfile()
                    end)

                    hooksecurefunc(EditModeManagerFrame, "SaveLayouts", function()
                        C_Timer.After(0.5, function()
                            SaveEditModeProfile()
                        end)
                    end)
                end
            end)
        -- else -- Cataclysm
        --     if SkillCappedDB.toggleFriendlyNameplates then
        --         SC:ToggleFriendlyNameplates()
        --     end
        end
        SC:UnregisterEvent("PLAYER_ENTERING_WORLD", SC.PlayerEnteringWorld)
    end)

    if SkillCappedDB.swappedAddonSet then
        SkillCappedDB.swappedAddonSet = nil
        -- if SkillCappedDB.mainContent == "PvE" then
        --     C_CVar.SetCVar("NamePlateHorizontalScale", "1")
        --     C_CVar.SetCVar("NamePlateVerticalScale", "1")
        -- end
        C_Timer.After(4, function()
            SC:CreateAddonSetNotification()
        end)
    end
end)

-- if not SC:IsRetail() then
--     local toggle = CreateFrame("Frame")
--     toggle:RegisterEvent("PLAYER_ENTERING_WORLD")
--     toggle:RegisterEvent("ZONE_CHANGED_NEW_AREA")
--     toggle:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
--     toggle:SetScript("OnEvent", function()
--         if SkillCappedDB.toggleFriendlyNameplates then
--             C_Timer.After(0.5, function()
--                 SC:ToggleFriendlyNameplates()
--             end)
--         end
--     end)
-- end

-- if not SC:IsRetail() then
--     SC:RegisterEvent("GROUP_ROSTER_UPDATE", function()
--         if SC:IsInLargeGroup() then
--             SC:SetRaidProfile("SkillCappedRaid")
--         else
--             SC:SetRaidProfile("SkillCapped")
--         end
--     end)
-- end

-- Define the static popup without placeholders
StaticPopupDialogs["SC_SWAP_PROFILE"] = {
    button1 = "Yes",
    button2 = "No",
    OnAccept = function(self, data)
        SC:LoadAddonSet(data.currentContent)
    end,
    OnShow = function(self)
        if not self.checkbox then
            self.checkbox = CreateFrame("CheckButton", nil, self, "UICheckButtonTemplate")
            self.checkbox:SetSize(30, 30)
            self.checkbox:SetPoint("LEFT", self.ButtonContainer.Button2, "RIGHT", -2, -0.3)
            self.checkbox:HookScript("OnEnter", function()
                GameTooltip:SetOwner(self.checkbox, "ANCHOR_CURSOR")
                GameTooltip:SetText("Don't show this popup again. This setting will reset if you re-install with the setup process.", nil, nil, nil, nil, true)
                GameTooltip:Show()
            end)
            self.checkbox:HookScript("OnLeave", function()
                GameTooltip:Hide()
            end)
        end
        self.checkbox:SetChecked(SkillCappedDB.dontShowUISwapMessage or false)
        self.checkbox:SetScript("OnClick", function(checkbox)
            SkillCappedDB.dontShowUISwapMessage = checkbox:GetChecked() or nil
        end)
        self.checkbox:SetPoint("LEFT", self.ButtonContainer.Button2, "RIGHT", -2, -0.3)
        self.checkbox:Show()
    end,
    OnHide = function(self)
        if self.checkbox then
            self.checkbox:Hide()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

-- Helper function to determine content type
function SC:GetCurrentInstanceType()
    local inInstance, instanceType = IsInInstance()
    if inInstance then
        return (instanceType == "arena" or instanceType == "pvp") and "PvP" or "PvE"
    end
    return nil
end

-- Function to dynamically set and show the popup
function SC:ShowProfileSwapConfirmation(currentContent, mainContent)
    local scIcon = "|TInterface/AddOns/SkillCapped/media/icon.blp:16:16:0:0|t"
    local coloredAddonName = "|cFFFFFFFFSkill|r|cff7ba4fcCapped|r"
    local text = string.format(
        "%s%s\n\nYou have entered %s content, but the SkillCapped mode is set to %s.\n\nDo you want to swap profiles to the content you are in?",
        scIcon,
        coloredAddonName,
        currentContent,
        mainContent
    )
    StaticPopupDialogs["SC_SWAP_PROFILE"].text = text
    StaticPopup_Show("SC_SWAP_PROFILE", nil, nil, { currentContent = currentContent })
end

-- Function to check and show the popup
function SC:CheckAndPromptProfileSwap()
    local currentContent = SC:GetCurrentInstanceType()
    if not currentContent or not SkillCappedDB.mainContent then return end

    -- Only prompt if the current content differs from the set mode
    if (currentContent ~= SkillCappedDB.mainContent) and (SkillCappedDB.secondaryContent ~= "None") then
        SC:ShowProfileSwapConfirmation(currentContent, SkillCappedDB.mainContent)
    end
end

-- Hook into PLAYER_ENTERING_WORLD
SC:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    if SkillCappedDB.dontShowUISwapMessage then return end
    SC:CheckAndPromptProfileSwap()
end)