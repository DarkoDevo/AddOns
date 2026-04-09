local AddonName, SkillCapped = ...
local SC = SkillCapped
local scIcon = "|TInterface/AddOns/SkillCapped/media/icon.blp:16:16:0:0|t"
local coloredAddonName = "|cFFFFFFFFSkill|r|cff7ba4fcCapped|r"

local screenHeight = UIParent:GetHeight() -- Get the screen height
local yOffset = screenHeight * -0.11 -- Calculate 13% from the top.
local checkboxes = {}
local pvpCheckboxes = {}
local pveCheckboxes = {}
local lookAndFeelCheckboxes = {}
local scCheckboxes = {}
local waCheckboxes = {}
local scFont = "Interface/AddOns/SkillCapped/media/fonts/Prototype.ttf"

local newUpdates = { -- addonName - profileVersion
    ["BattleGroundEnemiesFixed"] = 1,
    ["BetterBlizzPlates"] = 7,
    ["Cell"] = 5,
    ["ArcUI"] = 5,
    ["EditModePvE"] = 1,
    ["EditModePvP"] = 2,
    ["MiniCC"] = 3,
    ["OmniAuras"] = 4,
    ["OmniBar"] = 2,
    ["OmniCDPvP"] = 2,
    ["Plater"] = 2,
    ["TalentLoadoutsExPvE"] = 42,
    ["TalentLoadoutsExPvP"] = 42,
    ["CooldownManagerPvP"] = 1,

    -- WeakAuras
    --["WeakAurasPvE"] = 1,
    ["WeakAurasPvP"] = 17,
    ["Dungeons & Raids"] = 9,
    ["DEATHKNIGHT"] = 5,
    ["WARRIOR"] = 5,
    ["MAGE"] = 5,
    ["EVOKER"] = 5,
    ["HUNTER"] = 5,
    ["ROGUE"] = 5,
    ["PALADIN"] = 5,
    ["MONK"] = 5,
    ["DEMONHUNTER"] = 5,
    ["PRIEST"] = 5,
    ["WARLOCK"] = 5,
    ["DRUID"] = 5,
    ["SHAMAN"] = 5,
}

function SC:UpdateAllWeakAuraVersionNumbers()
    local pveWeakauras = {}
    pveWeakauras["Dungeons & Raids"] = true
    for classID = 1, GetNumClasses() do
        local _, className = GetClassInfo(classID)
        if className then
            pveWeakauras[className] = true
        end
    end
    for className in pairs(pveWeakauras) do
        if SkillCappedDB["pveWeakauras"] and SkillCappedDB["pveWeakauras"][className] then
            SkillCappedDB.profileUpdates[className] = newUpdates[className]
        end
    end
    SkillCappedDB.profileUpdates["WeakAurasPvP"] = newUpdates["WeakAurasPvP"]
end

function SC:UpdateTalentsVersionNumber()
    SkillCappedDB.profileUpdates["TalentLoadoutsExPvE"] = newUpdates["TalentLoadoutsExPvE"]
    SkillCappedDB.profileUpdates["TalentLoadoutsExPvP"] = newUpdates["TalentLoadoutsExPvP"]
end

local function SetUpPopupProperties(setupActive)
    for i = 1, 3 do
        local popup = _G["StaticPopup" .. i]
        if popup then
            if setupActive then
                popup:ClearAllPoints()
                popup:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
                popup:SetParent(SkillCappedBackupWarning)
                popup:SetFrameLevel(9999)
            else
                popup:ClearAllPoints()
                popup:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
                popup:SetParent(SkillCappedTutorial)
                popup:SetFrameLevel(9999)
            end

            if not popup.hooked then
                popup:HookScript("OnHide", function()
                    popup:SetParent(UIParent)
                end)
                popup.hooked = true
            end
        end
    end
end

function SC:WeakAuraCheckboxEnabled(contentType)
    local checkboxTable = (contentType == "PvP" and pvpCheckboxes) or (contentType == "PvE" and pveCheckboxes)
    local weakAurasCheckbox = checkboxTable and checkboxTable["WeakAuras"..contentType]

    if weakAurasCheckbox and weakAurasCheckbox:GetChecked() then
        return true
    else
        return false
    end
end

function SC:EditModeCheckboxEnabled(contentType)
    local checkboxTable = (contentType == "PvP" and pvpCheckboxes) or (contentType == "PvE" and pveCheckboxes)
    local editModeCheckbox = checkboxTable and checkboxTable["EditMode"..contentType]

    if editModeCheckbox and editModeCheckbox:GetChecked() then
        return true
    else
        return false
    end
end

function SC:CDMCheckboxEnabled(contentType)
    local checkboxTable = (contentType == "PvP" and pvpCheckboxes) or (contentType == "PvE" and pveCheckboxes)
    local cdmCheckbox = checkboxTable and checkboxTable["CooldownManager"..contentType]

    if cdmCheckbox and cdmCheckbox:GetChecked() then
        return true
    else
        return false
    end
end

function SC:ShowCurrentStep(step)
    -- Hide all possible step frames
    SkillCappedTutorial.stepOne:Hide()
    SkillCappedTutorial.generalStep:Hide()
    --SkillCappedTutorial.pveStep:Hide() -- PvE disabled
    SkillCappedTutorial.pvpStep:Hide()
    SkillCappedTutorial.installBtn:Hide()
    if SkillCappedTutorial.installStep then
        SkillCappedTutorial.installStep:Hide()
    end

    SkillCappedTutorial.addonProfiles:SetText("")

    if step == 0 then
        SkillCappedTutorial.BackButton:Hide()
        SkillCappedTutorial.NextButton:Hide()
        return
    end

    -- Show the frame corresponding to the current step
    if step == 1 then
        SkillCappedTutorial.progressBar:SetParent(SkillCappedTutorial.stepOne)
        SkillCappedTutorial.stepOne:Show()
        SkillCappedTutorial.addonProfiles:SetText("")
        SkillCappedTutorial.BackButton:Disable()

    elseif step == 2 then
        SkillCappedTutorial.progressBar:SetParent(SkillCappedTutorial.generalStep)
        SC:CreateInstallStep("LookAndFeel", SkillCappedTutorial.generalStep)
    elseif step == 3 then
        -- PvE disabled: Step 3 is now always the final PvP step
        --if SkillCappedTutorial.mainContent == "PvP" then
            SkillCappedTutorial.progressBar:SetParent(SkillCappedTutorial.pvpStep)
            SC:CreateInstallStep("PvP", SkillCappedTutorial.pvpStep)
        -- PvE disabled
        --elseif SkillCappedTutorial.mainContent == "PvE" then
        --    SkillCappedTutorial.progressBar:SetParent(SkillCappedTutorial.pveStep)
        --    SC:CreateInstallStep("PvE", SkillCappedTutorial.pveStep)
        --end
        -- PvE disabled: Always show install button on step 3 since it's the final step
        SkillCappedTutorial.installBtn:Show()
    elseif step == 4 then
        if SkillCappedTutorial.secondaryContent == "PvP" then
            SkillCappedTutorial.progressBar:SetParent(SkillCappedTutorial.pvpStep)
            SC:CreateInstallStep("PvP", SkillCappedTutorial.pvpStep)
            SkillCappedTutorial.installBtn:Show()
        -- PvE disabled
        --elseif SkillCappedTutorial.secondaryContent == "PvE" then
        --    SkillCappedTutorial.progressBar:SetParent(SkillCappedTutorial.pveStep)
        --    SC:CreateInstallStep("PvE", SkillCappedTutorial.pveStep)
        --    SkillCappedTutorial.installBtn:Show()
        elseif step == 6 then
            -- finish
            SC:CreatePreInstallStep("LookAndFeel", SkillCappedTutorial.installStep)
        end
    end

    -- Adjust button visibility based on step
    SkillCappedTutorial.BackButton:SetShown(step >= 1)
    SkillCappedTutorial.BackButton:SetEnabled(step > 1)
    -- PvE disabled: Next button should not show on step 3 (final step) or beyond
    SkillCappedTutorial.NextButton:SetShown(not SkillCappedTutorial.installBtn:IsShown() and step < 3)
end

local function CheckForChanges(checkboxGroup, reloadBtn, mainBtn, showMainBtn, installer)
    local changedAndNeedsReload = false
    if checkboxGroup then
        for addonName, cb in pairs(checkboxGroup) do
            if SC:DoesAddonExist(addonName) then
                -- Check if the checkbox state has changed from the initial state
                if cb:GetChecked() ~= cb.initialState then
                    if not cb.initialState and not SC:IsAddonLoaded(SC:GetRealAddonName(addonName)) then
                        local realAddonName = SC:GetRealAddonName(addonName)
                        local _, reason = C_AddOns.IsAddOnLoadable(realAddonName)
                        local skip = reason == "INCOMPATIBLE"
                        if not SkillCappedDB.WeakAura then
                            if SC.scAddons[realAddonName] then
                                skip = true
                            end
                        end
                        if not skip then
                            if not SC.addonsNeedingReload then
                                SC.addonsNeedingReload = {}
                            end
                            -- Add the addon only if it doesn't already exist in the table
                            if not SC.addonsNeedingReload[realAddonName] then
                                if realAddonName == "DejaCharacterStats" then
                                    SC.addonsNeedingReload["BetterCharacterPanel"] = true
                                    SC.addonsNeedingReload["TrueStatValues"] = true
                                end
                                SC.addonsNeedingReload[realAddonName] = true
                            end
                            changedAndNeedsReload = true
                        end
                    end
                end
            end
        end
    end

    if SkillCappedTutorial then
        SC:ShowCurrentStep(SkillCappedTutorial.step)
    end

    local function SetButtonColorAndDesaturation(buttonPart, desaturate, r, g, b)
        buttonPart:SetDesaturated(desaturate)
        buttonPart:SetVertexColor(r, g, b)
    end

    local function RecolorReloadBtn(btn, reloadNeeded)
        local r, g, b = 1, 1, 1
        if reloadNeeded then
            r, g, b = 0.9, 1, 0
        end

        SetButtonColorAndDesaturation(btn.Right, reloadNeeded, r, g, b)
        SetButtonColorAndDesaturation(btn.Left, reloadNeeded, r, g, b)
        SetButtonColorAndDesaturation(btn.Middle, reloadNeeded, r, g, b)
    end

    if changedAndNeedsReload then
        if installer then
            if SkillCappedTutorial.step == SkillCappedTutorial.maxStep then
                mainBtn:Hide()
                reloadBtn:Show()
                RecolorReloadBtn(reloadBtn, true)
            else
                reloadBtn:Hide()
                RecolorReloadBtn(reloadBtn, false)
            end
        else
            if SkillCappedTutorial then
                SkillCappedTutorial.NextButton:Hide()
                --SkillCappedTutorial.BackButton:Hide()
            end
            reloadBtn:Show()
            mainBtn:Hide()
        end
    else
        reloadBtn:Hide()
        RecolorReloadBtn(reloadBtn, false)
        if showMainBtn then
            mainBtn:Show()
        end
    end
end

local function addonIs(baseName, addonName)
    return addonName == baseName or addonName == baseName .. "PvP" or addonName == baseName .. "PvE"
end

local function addonIsNot(baseName, addonName)
    return not addonIs(baseName, addonName)
end

local defaultTooltipSettings = {
    parent = GameTooltip:GetParent(),
    strata = GameTooltip:GetFrameStrata(),
    level = GameTooltip:GetFrameLevel()
}

local function AddTooltip2(parent, title, mainText, anchor, extraParent, toggle)
    parent:HookScript("OnEnter", function(self)
        GameTooltip:SetParent(extraParent or parent)
        GameTooltip:SetOwner(self, anchor or "ANCHOR_RIGHT")
        GameTooltip:ClearLines()

        -- Add the primary tooltip text
        GameTooltip:AddLine(title)
        GameTooltip:AddLine(mainText, 1, 1, 1, true)  -- Wrap text

        -- Check for toggle and add additional lines if needed
        if toggle then
            local mainContentIconAtlas = SkillCappedDB.mainContent == "PvP" and "countdown-swords:16:16" or "Dungeon:22:22"
            local secondaryContentIconAtlas = SkillCappedDB.secondaryContent == "PvE" and "Dungeon:22:22" or "countdown-swords:16:16"
            local mainContentText = SkillCappedDB.mainContent or "none"
            local otherUI = SkillCappedDB.secondaryContent or "PvE"

            GameTooltip:AddDoubleLine(
                "Swap to "..otherUI.." UI|A:" .. secondaryContentIconAtlas .. "|a",
                "Active: " .. mainContentText .. " |A:" .. mainContentIconAtlas .. "|a",
                1, 0.82, 0, 0.2, 1, 0.6
            )
            --GameTooltip:AddLine("Click to swap to " .. otherUI .. " UI.")
        end

        -- Set strata and level, then show the tooltip
        GameTooltip:SetFrameStrata("TOOLTIP")
        GameTooltip:SetFrameLevel(3800)
        GameTooltip:Show()
    end)

    parent:HookScript("OnLeave", function()
        GameTooltip:Hide()
        GameTooltip:SetParent(defaultTooltipSettings.parent)
        GameTooltip:SetFrameStrata(defaultTooltipSettings.strata)
        GameTooltip:SetFrameLevel(defaultTooltipSettings.level)
    end)
end

local function RefreshTooltip(parent, title, mainText, anchor, extraParent)
    GameTooltip:SetParent(extraParent or parent)
    GameTooltip:SetOwner(parent, anchor or "ANCHOR_RIGHT")
    GameTooltip:ClearLines()
    GameTooltip:AddLine(title)
    GameTooltip:AddLine(mainText, 1, 1, 1, true)  -- Wrap text
    GameTooltip:Show()
end

StaticPopupDialogs["SC_RELOAD_REQUIRED"] = {
    text = SC.Logo.."\n\nThis action requires a reload. Reload now?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["SC_BNET_UNAVAILABLE"] = {
    text = SC.Logo.."\n\nBattle.net unreachable.\nCan't import profile strings.\n\nPlease try again later.\n ",
    button1 = "OK",
    OnAccept = function()
        --
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["SC_NEW_UPDATE"] = {
    text = SC.Logo .. "\n\nThe Skill Capped addon has been updated for season 3 of The War Within.\n\nGet your code from the Skill Capped website to Import Profiles again.\n\nLeft click the new minimap icon or run the setup from the /sc menu to install updated profiles.\n",
    button1 = "OK",
    OnAccept = function()
        --
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}



StaticPopupDialogs["SC_WEAKAURAS_MISSING"] = {
    text = SC.Logo.."\n\nWeakAuras was not found.\nWe could not install the Skill-Capped WeakAuras.\n\nPlease check your addon settings and try instaling again.\n ",
    button1 = "OK",
    OnAccept = function()
        --
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["SC_NOT_SELECTED"] = {
    text = SC.Logo.."\n\nYou haven't selected any presets.\n ",
    button1 = "OK",
    OnAccept = function()
        --
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["SC_FORCE_RELOAD"] = {
    text = SC.Logo.."\n\nDue to large changes in the WeakAuras,\nthis patch requires a reload.\n ",
    button1 = "Reload UI Now",
    OnAccept = function()
        SkillCappedDB.waReloadForced = true
        SC:LoadAddonSet(SkillCappedDB.mainContent)
    end,
    timeout = 0,
    whileDead = true,
}

StaticPopupDialogs["SC_WA_RELOAD_REQUIRED"] = {
    text = SC.Logo.."\n\nSome of the WeakAuras updated require a reload.\n ",
    button1 = "Reload UI Now",
    OnAccept = function()
        SkillCappedDB.waReloadForced = true
        SC:LoadAddonSet(SkillCappedDB.mainContent)
    end,
    timeout = 0,
    whileDead = true,
}

StaticPopupDialogs["SC_WEAKAURA_UPDATE"] = {
    text = SC.Logo.."\n\nSome of our WeakAuras have updates!\n\nWould you like to import them?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        SC:CreateWeakAuraUpdateWindow()
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
        self.checkbox:SetChecked(SkillCappedDB.dontShowWeakAuraUpdateMessage or false)
        self.checkbox:SetScript("OnClick", function(checkbox)
            SkillCappedDB.dontShowWeakAuraUpdateMessage = checkbox:GetChecked() or nil
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

StaticPopupDialogs["SC_WEAKAURA_UPDATE_RELOAD"] = {
    text = SC.Logo.."\n\nSome of our WeakAuras have updates!\n\nSome of them require a reload,\nwould you like to reload now?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        SC:DeleteWeakAuraAndChildren("TWW Dungeons (https://wago.io/twwdungeons)")
        SC:DeleteWeakAuraAndChildren("Undermine (https://wago.io/twwraid2)")
        SC:DeleteWeakAuraAndChildren("Causese Anchors (don't rename)")
        SkillCappedDB.twwS3WAUpdate = true
        SkillCappedDB.needPveWAUpdate = nil
        ReloadUI()
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
        self.checkbox:SetChecked(SkillCappedDB.dontShowWeakAuraUpdateMessage or false)
        self.checkbox:SetScript("OnClick", function(checkbox)
            SkillCappedDB.dontShowWeakAuraUpdateMessage = checkbox:GetChecked() or nil
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

StaticPopupDialogs["SC_TALENTS_UPDATE"] = {
    text = SC.Logo.."\n\nSome of our Talent Profiles have updates!\n\nWould you like to import them?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        UpdateTalentLoadoutEx()
        SC:UpdateTalentsVersionNumber()
        if not SkillCappedDB.waReloadForced then
            SkillCappedDB.waReloadForced = true
            SC:LoadAddonSet(SkillCappedDB.mainContent)
        else
            ReloadUI()
        end
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
        self.checkbox:SetChecked(SkillCappedDB.dontShowTalentUpdateMessage or false)
        self.checkbox:SetScript("OnClick", function(checkbox)
            SkillCappedDB.dontShowTalentUpdateMessage = checkbox:GetChecked() or nil
        end)
        self.checkbox:SetPoint("LEFT", self.ButtonContainer.Button2, "RIGHT", -2, -0.3)
        self.checkbox:Show()
    end,
    OnHide = function(self)
        if self.checkbox then
            self.checkbox:Hide()
        end
        if not SkillCappedDB.waReloadForced then
            StaticPopup_Show("SC_FORCE_RELOAD")
        elseif SC.WeakAuraReloadRequired then
            StaticPopup_Show("SC_WA_RELOAD_REQUIRED")
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["SC_BACKUP_WARNING"] = {
    text = coloredAddonName.."\n\nAre you absolutely sure you're ready\nto restore backups?\nYour old backups will be lost.\n\nRestore backups & reload now?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        if InCombatLockdown() then
            SC:Print("Leave combat to continue installation. Make sure you are out of combat while installing.")
            return
        end
        SC.setupActive = false
        SC:RestoreAllSettings()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

local function ExitSetup()
    SC:HideTutorialShowUI()
    SkillCappedDB.reOpenToAddonConfig = nil
    SC.setupActive = false
    SkillCappedTutorial.step = 1
    SC:UpdateMaxStep()
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    SkillCappedDB.characters[playerNameAndRealm] = SkillCappedDB.mainContent or "PvP"
    PlaySound(1115)
    if SkillCappedDB.newFonts then
        SC:SetFonts()
    else
        SC:RestoreFonts()
    end
    if not UnitAffectingCombat("player") and not InCombatLockdown() then
        SetUIVisibility(true)
    end
    if SC.SkillCappedBlizzard then
        --InterfaceOptionsFrame_OpenToCategory(SC.SkillCappedBlizzard)
        Settings.OpenToCategory(SC.category:GetID())
    end
    if SkillCappedTutorial.reloadReqBtn then
        SkillCappedTutorial.reloadReqBtn:Hide()
    end
    SkillCappedTutorial.LookAndFeelInitCheckboxStates = {}
end

StaticPopupDialogs["SC_EXIT_WARNING"] = {
    text = SC.Logo.."\n\nAre you sure you want to exit the setup process?\n\nThis is NOT recommended but you can still go through the setup from the addon settings.",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        ExitSetup()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

local function LookAndFeelCbChange()
    if not SkillCappedTutorial then return end
    if not SkillCappedTutorial.LookAndFeelInitCheckboxStates then return end
    for addonName, cb in pairs(lookAndFeelCheckboxes) do
        if cb:GetChecked() ~= SkillCappedTutorial.LookAndFeelInitCheckboxStates[addonName] then
            return true -- A state has changed
        end
    end
    return false -- All states are the same
end

StaticPopupDialogs["SC_EXIT_WARNING_LF"] = {
    text = SC.Logo.."\n\nYou have unsaved changes in the Look & Feel section.\n\nDo you want to save these and Reload UI?",
    button1 = "Yes",
    button2 = "No, exit.",
    OnAccept = function()
        for addonName, cb in pairs(checkboxes) do
            if not cb.LookAndFeel then
                cb:SetChecked(false)
            end
        end
        SC:GoInstall()
    end,
    OnCancel = function()
        ExitSetup()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["SC_WARN_ADDON"] = {
    text = SC.Logo.."\n\nYou seem to have some addons\ndisabled or missing.\nIf you continue without enabling\nthem their settings will not be imported.\n\nAre you sure you want to continue?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function(self)
        if SC:WeakAuraCheckboxEnabled("PvE") then
            local noPvEWeakauraSelected = true
            for _, cb in pairs(waCheckboxes) do
                if cb:GetChecked() then
                    noPvEWeakauraSelected = false
                    break
                end
            end
            if noPvEWeakauraSelected then
                StaticPopup_Show("SC_WARN_WEAKAURA")
                SetUpPopupProperties()
            else
                SC:GoInstall()
            end
        else
            SC:GoInstall()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["SC_WARN_WEAKAURA"] = {
    text = SC.Logo.."\n\nYou have not selected any class specific PvE Weakauras.\nIf you continue without enabling\nthem their settings will not be imported.\n\nAre you sure you want to continue?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function(self)
        SC:GoInstall()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

local customDescriptions = {
    ["HealthBarColor"] = "Colors the health bar of player, target, and focus frames by class.",
    ["BattleGroundEnemiesFixed"] = "Show a row of enemy healthbars during battlegrounds for good awareness.",
    --["Combined Bags"] = "Consolidates all bags into one mega-bag.",
    ["Dark Mode"] = "Enables FrameColor for a dark mode theme to all of WoW.",
    ["FrameColor"] = "Enables FrameColor for a dark mode theme to all of WoW.",
    ["DejaCharacterStats"] = "Enables three addons to vastly improve the Character Panel. (BetterCharacterPanel, DejaCharacterStats & TrueStatValues)",
    ["Details"] = "Advanced combat analysis and damage meter addon for tracking and comparing player performance in all types of content.",
    ["Class Icon Portraits"] = "Enable class icon portraits instead of character portraits.",
    ["Fade Menu & Bags"] = "Fade the Micro Menu & Bags Bar out of vision and show it on mouseover.",
    ["Hide PvE WA's in PvP"] = "Hide PvE class WeakAuras in PvP.",
    ["Hide PvP WA's in PvE"] = "Hide PvP (Class Buffs & Buffs & Debuffs) WeakAuras in PvE.",
    ["Hide Class Power (PvE)"] = "Hide the class resource/power underneath PlayerFrame.\nIdeal in combination with PvE Class WeakAuras.\n\nThis will only be active in the PvE UI Mode.",
    ["Fade Status/XP Bar"] = "Fade out the Status/XP Bars. It is located at the top of your screen and still shows on mouseover.",
    ["Hide Error Frame"] = "Hide the spam messages in the ErrorFrame. The red text at the top of your screen saying Out of Range, Low Mana etc.",
    ["Hide Hit Indicator"] = "Hide the health gain/loss numbers shown on the Player portrait icon.",
    ["New Fonts"] = "Enables a new font for all the text in the game.",
    ["BetterBags"] = "Better and more organized bags.",
    ["Player Elite Frame"] = "Enables a dragon texture around your PlayerFrame.\n|cff32f795Right-click to swap between the 4 different textures available.|r",
    ["Queue Pop Notification"] = "Enables a \"ping\" sound on PvP/PvE Queue pops that wont get muted if you mute game sounds (Audio Enabled is still required).",
    ["Smart Tab Targeting"] = "Automatically swaps your keybind for \"Target Nearest Enemy\" and \"Target Nearest Enemy Player\" in PvP.",
    ["Cell"] = "Cell is a raid frame addon inspired by popular addons like CompactRaid, Grid2, Aptechka, and VuhDo. It features a user-friendly interface designed to enhance the user experience.",
    ["MouseoverActionSettings"] = "Hide unnecessary UI frames for a cleaner look, with options to show them on mouseover. Choose from two presets to keep your action bars hidden.\n\nThis addon will only be active in PvE.",
    ["TalentLoadoutsEx"] = "Easily save and manage unlimited talent combinations, including PvP talents. Create groups, export/import multiple setups.\n\nThe SkillCapped profile is regularly updated to include the best builds for every content type for every class and spec."
    --["Resize Talents & Spellbook"] = "Reduce the size of the Talents & Spellbook a little bit."
}

local waDescriptions = {
    ["Consumables"] = "Show consumables",
    ["Raid"] = "Undermine Raid",
    ["Dungeons"] = "TWW Dungeons",
    ["AW_BattleRes"] = "AW BattleRes",
    ["M_Plus_Keys"] = "Mythic+ !keys The War Within",
    ["Racials_And_Trinkets"] = "Show Racials & Trinkets above PlayerFrame",
    ["M_Plus_Timer"] = "M+ Timer",
    ["M_Plus_Automark"] = "Automarking WA for M+",
    ["Externals_On_You"] = "Show important external CDs on you",
    ["Tank_Frontals"] = "Tank Frontals TWW",
    ["PvP_Queue"] = "Show PvP Queue timer",
    ["SkillCapped_BuffsAndDebuffs"] = "Show important Buffs & Debuffs",
    ["SkillCapped_ClassBuffs"] = "Show important rotational class buffs",
    ["Enemy_Battleground_CDs"] = "Show when Enemy pops CDs in Battlegrounds",
    ["Gladius_DoT_Tracker"] = "Show Arena DoTs on Gladius to keep track of dot uptime.",
    ["SkillCapped_MissingBuffs"] = "Show Missing Buffs reminder icons",
    ["Healer_CC"] = "Show an icon when your Healer is in CC",
    ["Drink"] = "Show when Enemy Healer is drinking in Arena",
    ["SkillCapped_EnemyCDs"] = "Show when Enemy pops CDs in Arena",
}

local function getAddonDescription(addonName)
    if customDescriptions[addonName] then
        return customDescriptions[addonName]
    end
    return C_AddOns.GetAddOnMetadata(addonName, "Notes") or "No description available."
end

local function CheckForMissingLookAndFeelAddon(cb, ...)
    local missingAddons = {}
    local disabledAddons = {}

    -- Check each provided addon
    for i = 1, select("#", ...) do
        local addonName = select(i, ...)
        if not C_AddOns.DoesAddOnExist(addonName) then
            table.insert(missingAddons, "|cFFFF0000" .. addonName .. "|r") -- Red for missing addon
        elseif not C_AddOns.IsAddOnLoaded(addonName) then
            table.insert(disabledAddons, "|cFFFF9900" .. addonName .. "|r") -- Orange for unloaded addon
        end
    end

    -- Generate the text for missing and disabled addons
    local missingText = ""
    if #missingAddons > 0 then
        missingText = "\n\n|cFFFF0000Missing addons:|r\n" .. table.concat(missingAddons, "\n")
    end
    if #disabledAddons > 0 then
        missingText = missingText .. "\n\n|cFFFF9900Disabled addons:|r\n" .. table.concat(disabledAddons, "\n")
    end

    -- Set cb.missingLookAndFeelAddon to a color table
    if #missingAddons > 0 then
        cb.missingLookAndFeelAddon = {1, 0, 0} -- Red color
    elseif #disabledAddons > 0 then
        --cb.missingLookAndFeelAddon = {1, 0.6, 0} -- Orange color
    else
        cb.missingLookAndFeelAddon = nil -- No issues
    end

    return missingText
end

local function MakeFrameMoveable(frame)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
end

function SC:ExitTutorial()
    SC:HideTutorialShowUI()
    SC.setupActive = false
    if SC.SkillCappedBlizzard then
        Settings.OpenToCategory(SC.category:GetID())
    end
    if WeakAurasOptions then
        WeakAurasOptions:SetParent(UIParent)
    end
end

-- local function AddFadeInEffect(frame, duration)
--     if not frame.fadeInScaleGroup then
--         -- Create an Animation Group for the frame
--         frame.fadeInScaleGroup = frame:CreateAnimationGroup()

--         -- Create a Fade In Animation
--         local fadeIn = frame.fadeInScaleGroup:CreateAnimation("Alpha")
--         fadeIn:SetFromAlpha(0)
--         fadeIn:SetToAlpha(1)
--         fadeIn:SetDuration(duration or 1)
--         fadeIn:SetSmoothing("IN")

--         -- Create a Scale Animation
--         local scale = frame.fadeInScaleGroup:CreateAnimation("Scale")
--         scale:SetScale(1 / 0.98, 1 / 0.98)
--         scale:SetDuration(duration or 1)
--         scale:SetSmoothing("IN")

--         frame.ShowWithFadeAndScale = function(self)
--             self:SetScale(0.85)
--             self:Show()
--             self.fadeInScaleGroup:Play()
--         end

--         frame:HookScript("OnShow", function()
--             frame.fadeInScaleGroup:Stop()
--             frame.fadeInScaleGroup:Play()
--         end)
--     end
-- end

local function CreateHeader(title, parent, smaller)
    local frame = CreateFrame("Frame", nil, parent)
    local text = frame:CreateFontString()
    text:SetFont(scFont, 12, "THINOUTLINE")
    text:SetText(title)
    text:SetTextColor(1, 0.819607, 0)
    text:SetPoint("CENTER", frame, "CENTER")
    local textWidth = text:GetWidth()+60

    local lineWidth = (parent:GetWidth()/2) - (textWidth/2)
    if smaller then
        lineWidth = lineWidth - smaller
    end
    local lineLeft = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    lineLeft:SetAtlas("_GarrMission_TopBorder")
    lineLeft:SetDesaturated(true)
    lineLeft:SetSize(lineWidth, 5)
    lineLeft:SetPoint("RIGHT", text, "LEFT", -10, 0)

    local lineRight = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    lineRight:SetAtlas("_GarrMission_TopBorder")
    lineRight:SetDesaturated(true)
    lineRight:SetSize(lineWidth, 5)
    lineRight:SetPoint("LEFT", text, "RIGHT", 10, 0)

    frame:SetSize(textWidth+(lineWidth*2)-30, text:GetHeight())

    return frame
end

local function makeBox(frame, varName, buttonText, point, offsetX, offsetY, tooltipTitle, tooltipText, func)
    local cb = CreateFrame("CheckButton", varName .. "CheckButton", frame, "InterfaceOptionsCheckButtonTemplate")
    cb:SetPoint("TOPLEFT", point, "BOTTOMLEFT", offsetX, offsetY)
    cb:SetSize(25, 25)

    cb:SetNormalTexture("common-button-square-gray-up")
    cb:SetHighlightTexture("common-button-square-gray-up")
    cb:SetPushedTexture("common-button-square-gray-up")
    cb:SetDisabledTexture("common-button-square-gray-up")

    local checkTexture = cb:CreateTexture(nil, "OVERLAY")
    checkTexture:SetAtlas("common-icon-checkmark-yellow")
    checkTexture:SetPoint("CENTER", cb, "CENTER", 0, 0)
    checkTexture:SetSize(17, 17)
    cb:SetCheckedTexture(checkTexture)

    cb:HookScript("OnClick", function(self)
        SkillCappedDB[varName] = self:GetChecked()
        if func then func() end
    end)
    cb.Text:ClearAllPoints()
    cb.Text:SetPoint("LEFT", cb, "RIGHT", 0, 0)
    cb.Text:SetText(buttonText)
    cb.Text:SetFont(scFont, 11)
    cb.Text:SetTextColor(1,1,1)
    cb:SetChecked(SkillCappedDB[varName])
    if SkillCappedDB[varName] == "1" then
        cb:SetChecked(true)
    elseif SkillCappedDB[varName] == "0" then
        cb:SetChecked(false)
    end
    AddTooltip2(cb, tooltipTitle, tooltipText)
    return cb
end

-- Create a helper function to handle the scaling animation
-- local function ScaleFrame(frame, scale, time)
--     local startX, startY = frame:GetScale(), frame:GetScale()
--     local endX, endY = scale, scale
--     local duration = 0

--     frame:SetScript("OnUpdate", function(self, elapsed)
--         duration = duration + elapsed
--         if duration < time then
--             -- Calculate the interpolation
--             local delta = duration / time
--             local interpX = startX + (endX - startX) * delta
--             local interpY = startY + (endY - startY) * delta
--             self:SetScale(interpX, interpY)
--         else
--             -- Set the final scale and remove the script
--             self:SetScale(endX, endY)
--             self:SetScript("OnUpdate", nil)
--         end
--     end)
-- end

local function FadeFrameAlpha(frame, startAlpha, endAlpha, duration)
    if not frame:IsShown() then return end
    UIFrameFade(frame, {
        mode = "IN",
        timeToFade = duration,
        startAlpha = startAlpha,
        endAlpha = endAlpha,
    })
end

local function fadeOutFrame(frame, duration)
    UIFrameFadeOut(frame, duration, 1, 0)
    C_Timer.After(duration, function()
        frame:Hide()
        frame:SetAlpha(1)
    end)
end

local function ColorCheckboxTextAfterState(cb)
    if cb.soon then
        cb.Text:SetTextColor(1, 0.55, 0)
        return
    end
    if cb.hasUpdate then
        if not cb.pveWA then
            cb.Text:SetTextColor(0, 1, 0)
        end
        return
    end
    if not cb.Init then
        -- If the checkbox is enabled
        if cb:GetChecked() then
            if cb.notFound then
                cb.Text:SetTextColor(1, 0, 0, 1) -- red if not found
            --elseif cb.notLoaded then
                --cb.Text:SetTextColor(1, 0.6, 0, 1) -- Orange if not loaded
            else
                cb.Text:SetTextColor(0, 1, 0)  -- Green if loaded
            end
        else
            -- If the checkbox is disabled
            if cb.notFound then
                cb.Text:SetTextColor(1, 0, 0, 1) -- Red if disabled
            --elseif cb.notLoaded then
                --cb.Text:SetTextColor(1, 0.6, 0, 1) -- Orange if not loaded
            elseif cb.installed then
                cb.Text:SetTextColor(0.482, 0.643, 0.988) -- Blue if installed
            else
                cb.Text:SetTextColor(0.6, 0.6, 0.6) -- Gray if deselected
            end
        end
        cb.Init = true
    else
        -- If the checkbox is enabled
        if cb:GetChecked() then
            if cb.notFound then
                cb.Text:SetTextColor(1, 0, 0, 1) -- red if not found
            --elseif cb.notLoaded then
                --cb.Text:SetTextColor(0, 1, 0)  -- Green if loaded
            else
                cb.Text:SetTextColor(0, 1, 0)  -- Green if loaded
            end
        else
            if cb.forceOrange then
                cb.Text:SetTextColor(1, 0.6, 0, 1) -- Orange if not loaded
            -- If the checkbox is disabled
            elseif cb.notFound then
                cb.Text:SetTextColor(1, 0, 0, 1) -- Red if disabled
            --elseif cb.notLoaded then
                --cb.Text:SetTextColor(1, 0.6, 0, 1) -- Orange if not loaded
            elseif cb.installed then
                cb.Text:SetTextColor(0.482, 0.643, 0.988) -- Blue if installed
            else
                cb.Text:SetTextColor(0.6, 0.6, 0.6) -- Gray if deselected
            end
        end
    end
    if cb.LookAndFeel then
        if cb:GetChecked() then
            if cb.missingLookAndFeelAddon then
                -- local r, g, b = unpack(cb.missingLookAndFeelAddon)
                -- cb.Text:SetTextColor(r, g, b)
                -- cb.Check:SetDesaturated(true)
                -- cb.Check:SetVertexColor(r, g, b)
                -- cb.changedCheck = true
                cb.Text:SetTextColor(1, 0.819607, 0.3)
            else
                --cb.Text:SetTextColor(1, 0.819607, 0.3)
                cb.Text:SetTextColor(1, 0.819607, 0.3)
                if cb.changedCheck then
                    cb.changedCheck = nil
                    cb.Check:SetDesaturated(false)
                    cb.Check:SetVertexColor(1,1,1)
                end
            end
        else
            cb.Text:SetTextColor(0.6, 0.6, 0.6)
        end
    end

    if cb.uninstall then
        cb.Text:SetTextColor(1, 0.4, 0.7)
    end
end

local function CheckboxHasUpdate(cb)
    if cb.hasUpdate then return end
    local hasUpdate = cb:CreateTexture(nil, "OVERLAY")
    hasUpdate:SetSize(32,24)
    hasUpdate:SetPoint("LEFT", cb.text, "RIGHT", -5, 0)
    hasUpdate:SetAtlas("CharacterCreate-NewLabel")
    hasUpdate:SetDesaturated(true)
    hasUpdate:SetVertexColor(0.118, 1, 0.071, 1)
    cb.hasUpdate = hasUpdate
    if SkillCappedDB.firstLaunchAfterUpdate then
        cb:SetChecked(true)
        ColorCheckboxTextAfterState(cb)
        if cb.addonName == "ArcUI" then
            if checkboxes["CooldownManagerPvP"] then
                checkboxes["CooldownManagerPvP"]:SetChecked(true)
                ColorCheckboxTextAfterState(checkboxes["CooldownManagerPvP"])
            end
        end
    end
    AddTooltip2(hasUpdate, "New update available!", "This profile has updates.\n\nReinstalling it will mean the loss of any of your changes to the profile.", "ANCHOR_RIGHT", cb:GetParent())
end

local function CheckboxWillGetUpdated(cb, addonName)
    if SC:GetRealAddonName(addonName) == "ArcUI" then
        cb:SetChecked(false)
        cb:Disable()
        ColorCheckboxTextAfterState(cb)
        if cb.soon then return end
        cb:Disable()
        local overlay = CreateFrame("Frame", nil, cb:GetParent())
        overlay:SetFrameLevel(cb:GetFrameLevel() + 1)
        overlay:SetFrameStrata("HIGH")
        overlay:SetSize(cb:GetWidth()+cb.Text:GetWidth(), cb:GetHeight())
        overlay:SetPoint("TOPLEFT", cb, "TOPLEFT")
        overlay:SetScript("OnMouseDown", function()
            PlaySound(847)
        end)
        overlay:EnableMouse(true)
        AddTooltip2(overlay, "New profile soon!", nil, "ANCHOR_TOP", cb:GetParent())
        cb.overlay = overlay
        local soon = cb:CreateTexture(nil, "OVERLAY")
        soon:SetSize(18,18)
        soon:SetPoint("LEFT", cb.text, "RIGHT", -2, 0)
        soon:SetAtlas("worldquest-icon-clock")
        --soon:SetDesaturated(true)
        --soon:SetVertexColor(0.118, 1, 0.071, 1)
        cb.soon = soon
        AddTooltip2(soon, "New profile soon!", nil, "ANCHOR_TOP", cb:GetParent())
        AddTooltip2(cb, "New profile soon!", nil, "ANCHOR_TOP", cb:GetParent())
        AddTooltip2(cb.Text, "New profile soon!", nil, "ANCHOR_TOP", cb:GetParent())
        ColorCheckboxTextAfterState(cb)
    end
end

local function CheckIfProfileHasUpdates(addonName, cb, markPveWeakauras)
    if cb.hasUpdate then return end
    if not SkillCappedDB.completedSetup then return end
    if cb.notFound then return end

    if not newUpdates[addonName] then return end
    local dbName = SC.addonDatabaseMap[addonName]
    local addonIsBackedUp = dbName and SkillCappedBackupDB[dbName]
    if not addonIsBackedUp then return end
    local installedVersion = SkillCappedDB["profileUpdates"][addonName] or 0
    local latestVersion = newUpdates[addonName]
    if installedVersion >= latestVersion then return end
    CheckboxHasUpdate(cb)
end

local function CreateCheckbox(addonName, parent, x, y)
    local cb = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    cb:SetPoint("TOPLEFT", x, y)
    cb:SetSize(19, 19)

    cb:SetNormalTexture("common-button-square-gray-up")
    cb:SetHighlightTexture("common-button-square-gray-up")
    cb:SetPushedTexture("common-button-square-gray-up")
    cb:SetDisabledTexture("common-button-square-gray-up")

    local checkTexture = cb:CreateTexture(nil, "OVERLAY")
    checkTexture:SetAtlas("common-icon-checkmark")
    checkTexture:SetPoint("CENTER", cb, "CENTER", 0, 0)
    checkTexture:SetSize(17, 17)
    cb:SetCheckedTexture(checkTexture)
    cb.Check = checkTexture

    cb.Text:SetPoint("LEFT", cb, "RIGHT", 0, 0)
    cb:HookScript("OnClick", function(self)
        cb.Check:SetAtlas("common-icon-checkmark")
        ColorCheckboxTextAfterState(self)
    end)

    return cb
end

local function CreateLinkPopup(parent, link, title)
    if not parent.linkPopup then
        local frame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        frame:SetSize(315, 100)
        frame:SetPoint("CENTER")
        frame:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true,
            tileSize = 26,
            edgeSize = 26,
            insets = { left = 8, right = 8, top = 8, bottom = 8 }
        })
        frame:SetBackdropColor(0, 0, 0, 0.9)
        frame:Hide()
        frame:SetFrameStrata("FULLSCREEN_DIALOG")

        -- Title
        local titleText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        titleText:SetPoint("TOP", frame, "TOP", 0, -10)
        titleText:SetFont(scFont, 20)
        titleText:SetTextColor(1, 1, 1)

        -- Link EditBox
        local linkBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
        linkBox:SetSize(270, 30)
        linkBox:SetPoint("CENTER", frame, "CENTER", 0, 0)
        linkBox:SetAutoFocus(false)
        linkBox:SetFontObject("ChatFontNormal")
        linkBox:SetCursorPosition(0)
        linkBox:ClearFocus()
        linkBox:SetScript("OnEscapePressed", function(self)
            self:ClearFocus()
        end)
        linkBox:SetScript("OnKeyDown", function(self, key)
            if IsControlKeyDown() and key == "C" then
                self:HighlightText()
                -- Show "Copied!" feedback
                C_Timer.After(0.1, function()
                    local copiedText = frame.copiedText
                    if not copiedText then
                        copiedText = frame:CreateFontString(nil, "ARTWORK")
                        copiedText:SetFont(scFont, 13)
                        copiedText:SetText("Copied!|A:common-icon-checkmark:16:16|a")
                        copiedText:SetTextColor(0, 1, 0)
                        copiedText:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
                        frame.copiedText = copiedText
                    end
                    copiedText:Show()
                    C_Timer.After(0.5, function()
                        fadeOutFrame(copiedText, 1)
                    end)
                end)
            end
        end)
        linkBox:SetScript("OnMouseUp", function(self) self:HighlightText() end)
        AddTooltip2(linkBox, "Ctrl + C to copy link", nil, "ANCHOR_CURSOR")

        -- Close Button
        local closeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        closeButton:SetSize(80, 20)
        closeButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
        closeButton:SetText("Close")
        closeButton:SetScript("OnClick", function()
            frame:Hide()
        end)

        -- Store elements for reuse
        frame.titleText = titleText
        frame.linkBox = linkBox
        parent.linkPopup = frame
    end

    -- Update the popup with the new link and title
    parent.linkPopup.titleText:SetText(title.." ")
    parent.linkPopup.linkBox:SetText(link)
    parent.linkPopup.linkBox:HighlightText()
    parent.linkPopup:Show()
end

local function MakeBanner(parent, gParent, lenght)
    local addonConfigBanner = CreateFrame("Frame", nil, gParent)
    addonConfigBanner:SetSize(parent:GetWidth(), 105)
    addonConfigBanner:SetPoint("TOP", parent, "TOP")

    local extra = lenght or 0
    local separatorLine = parent:CreateTexture(nil, "OVERLAY")
    separatorLine:SetAtlas("AftLevelup-GlowLine")
    separatorLine:SetPoint("CENTER", addonConfigBanner, "BOTTOM")
    separatorLine:SetSize(parent:GetWidth()+40+extra, 10)
    separatorLine:SetDesaturated(true)
    separatorLine:SetVertexColor(0.482, 0.643, 0.988)


    local SkillCappedLogo = parent:CreateTexture(nil, "OVERLAY")
    SkillCappedLogo:SetTexture("Interface\\AddOns\\SkillCapped\\media\\SkillCappedLogo")
    SkillCappedLogo:SetPoint("RIGHT", addonConfigBanner, "RIGHT", -17, 0)
    SkillCappedLogo:SetSize(105,105)

    local hiddenExitButton = CreateFrame("Frame", nil, parent)
    hiddenExitButton:SetAllPoints(SkillCappedLogo)
    hiddenExitButton:SetScript("OnMouseDown", function()
        if IsControlKeyDown() and IsAltKeyDown() then
            SC:ExitTutorial()
        end
    end)

    local title2 = parent:CreateFontString(nil, "OVERLAY", "Game48FontShadow")
    title2:SetText(coloredAddonName)
    title2:SetJustifyH("CENTER")
    title2:SetPoint("LEFT", addonConfigBanner, "LEFT", 20, 15)
    title2:SetFont(scFont, 40, "THINOUTLINE")

    local description2 = parent:CreateFontString(nil, "ARTWORK")
    description2:SetPoint("TOP", title2, "BOTTOM", 0, 0)
    description2:SetFont(scFont, 12)
    description2:SetText("Famously effective guides")

    -- Buttons for Discord and YouTube
    local joinDiscordBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    joinDiscordBtn:SetText("Join Discord")
    joinDiscordBtn:SetWidth(92)
    joinDiscordBtn:SetHeight(21)
    joinDiscordBtn:SetPoint("TOP", description2, "BOTTOM", 48, -5)
    joinDiscordBtn:SetScale(0.90)
    joinDiscordBtn.Text:SetFont(scFont, 11)

    joinDiscordBtn:HookScript("OnClick", function()
        CreateLinkPopup(parent, "discord.gg/scwow", "|TInterface/AddOns/SkillCapped/media/icon.blp:14:14:0:0|t Join Discord")
    end)

    local youtubeGuideBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    youtubeGuideBtn:SetText("YouTube Guide")
    youtubeGuideBtn:SetWidth(92)
    youtubeGuideBtn:SetHeight(21)
    youtubeGuideBtn:SetPoint("RIGHT", joinDiscordBtn, "LEFT", -5, 0)
    youtubeGuideBtn:SetScale(0.9)
    youtubeGuideBtn.Text:SetFont(scFont, 11)

    youtubeGuideBtn:HookScript("OnClick", function()
        CreateLinkPopup(parent, "https://youtu.be/JVhP2XOHo2A", "|TInterface/AddOns/SkillCapped/media/icon.blp:14:14:0:0|t YouTube Guide")
    end)

    local versionText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    versionText:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -3, -2)
    versionText:SetFont(scFont, 7)
    versionText:SetText(C_AddOns.GetAddOnMetadata("SkillCapped", "Version"))
    versionText:SetTextColor(1, 1, 1, 0.25)

    local function ResizeBannerComponents()
        addonConfigBanner:SetSize(parent:GetWidth(), 105)
        separatorLine:SetSize(parent:GetWidth() + 40 + extra, 10)
    end

    parent:HookScript("OnSizeChanged", ResizeBannerComponents)

    return addonConfigBanner
end

-- Function to create dropdown buttons and setup callback on selection
local function CreateLabeledDropdown(parentFrame, labelText, options, onSelect)
    -- Create a container frame for the dropdown and label
    local container = CreateFrame("Frame", nil, parentFrame)
    container:SetSize(150, 50) -- Default size, can be adjusted

    -- Create the dropdown within the container
    local dropdown = CreateFrame("DropdownButton", nil, container, "WowStyle1DropdownTemplate")
    dropdown:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT", 0, 0) -- Assume position relative to the container
    dropdown:SetWidth(150)

    -- Create the label above the dropdown inside the container
    local label = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("BOTTOM", dropdown, "TOP", 0, 2) -- Position label above the dropdown
    label:SetFont(scFont, 17)
    label:SetText(labelText)
    if labelText == "Secondary Content" then
        label:SetTextColor(0.7, 0.7, 0.7)
    else
        label:SetTextColor(0.482, 0.643, 0.988)
    end

    -- Set default text for dropdown
    dropdown:SetDefaultText("Select option")

    -- Store the available options in the dropdown for later use
    dropdown.options = options
    dropdown.selected = nil

    -- Filter options only during the initial setup
    local initialOptions = {}
    local mainContent = SkillCappedDB.mainContent
    for _, option in ipairs(options) do
        if option ~= mainContent then
            table.insert(initialOptions, option)
        end
    end

    -- Function to update the dropdown options dynamically
    function dropdown:UpdateOptions(newOptions)
        -- Setup the dropdown menu options
        self:SetupMenu(function(owner, rootDescription)
            for _, option in ipairs(newOptions) do
                local displayText = option
                rootDescription:CreateButton(displayText, function()
                    -- Store the selected option in the dropdown and update the default text
                    owner.selected = displayText
                    owner:SetDefaultText(displayText)
                    onSelect(option)
                end)
            end
        end)
    end

    -- Setup the initial options
    dropdown:UpdateOptions(initialOptions)

    return container, dropdown -- Return the container frame and dropdown
end

local function CreateDropdown(parentFrame, width, options, onSelect, defaultOption)
    -- Create a container frame for the dropdown and label
    local container = CreateFrame("Frame", nil, parentFrame)
    container:SetSize(width or 150, 50) -- Default size, can be adjusted

    -- Create the dropdown within the container
    local dropdown = CreateFrame("DropdownButton", nil, container, "WowStyle1DropdownTemplate")
    dropdown:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT", 0, 0) -- Assume position relative to the container
    dropdown:SetWidth(width or 150)

    -- Set default text for dropdown
    dropdown:SetDefaultText(defaultOption)

    -- Store the available options in the dropdown for later use
    dropdown.options = options
    dropdown.selected = nil

    -- Function to update the dropdown options dynamically
    function dropdown:UpdateOptions(newOptions)
        -- Setup the dropdown menu options
        self:SetupMenu(function(owner, rootDescription)
            for _, option in ipairs(newOptions) do
                local displayText = option
                rootDescription:CreateButton(displayText, function()
                    -- Store the selected option in the dropdown and update the default text
                    owner.selected = displayText
                    owner:SetDefaultText(displayText)
                    onSelect(option)
                end)
            end
        end)
    end

    -- Setup the initial options
    dropdown:UpdateOptions(options)

    return container, dropdown -- Return the container frame and dropdown
end


local function UpdateNextButtonState(nextBtn)
    if SkillCappedTutorial.mainContent and SkillCappedTutorial.secondaryContent then
        nextBtn:Enable()
        nextBtn.nextBtnOverlay:Hide()
    else
        nextBtn:Disable()
        nextBtn.nextBtnOverlay:Show()
    end
end

--##########################################################

-- Create a frame for the addon's interface options
SkillCappedTutorial = nil
function SC:MakeGUI(showUI)
    if not showUI then
        SC:HideUIShowTutorial()
    else
        if SettingsPanel then
            SettingsPanel:Hide()
        end
    end

    if SkillCappedTutorial then
        SkillCappedTutorial.hiddenUI = not showUI
        SC:ReadyInstallationFrame()
        if SkillCappedTutorial.requiredReload then
            SC:PrepRequiredReloadState()
            return
        end
        if SC.AltActive then
            SC:UndoAltReloadPage()
        end
        --SC:ShowHideSCCheckboxes() -- replace with show step one
        return
    end

    SC.setupActive = true
    SkillCappedTutorial = CreateFrame("Frame", "SkillCappedTutorial")
    SkillCappedTutorial:ClearAllPoints()
    SkillCappedTutorial:SetPoint("TOP", UIParent, "TOP", 0, yOffset)
    SkillCappedTutorial:SetFrameStrata("HIGH")
    SkillCappedTutorial:SetSize(600,480)
    SkillCappedTutorial:Show()
    SkillCappedTutorial:SetScale(0.9)
    SkillCappedTutorial:RegisterEvent("PLAYER_REGEN_DISABLED")
    SkillCappedTutorial:RegisterEvent("PLAYER_REGEN_ENABLED")
    -- PvE disabled: Set defaults to PvP main and PvE secondary for fresh installs
    SkillCappedTutorial.mainContent = SkillCappedDB.mainContent or "PvP"
    SkillCappedTutorial.secondaryContent = SkillCappedDB.secondaryContent or "PvE"

    SkillCappedTutorial.hiddenUI = not showUI

    SkillCappedTutorial:SetScript("OnEvent", function(self, event)
        if SC.setupActive then
            if event == "PLAYER_REGEN_DISABLED" then
                SC:HideTutorialShowUI()
            elseif event == "PLAYER_REGEN_ENABLED" then
                SC:HideUIShowTutorial()
            end
        end
    end)

    SkillCappedTutorial:HookScript("OnShow", function()
        SC.setupActive = true
        for addonName, cb in pairs(checkboxes) do
            local addonDBName = SC.addonDatabaseMap[addonName]
            if SkillCappedDB.completedSetup then
                if SkillCappedBackupDB[addonDBName] and not cb.LookAndFeel then
                    cb:SetChecked(false)
                elseif addonIsNot("WeakAuras", addonName) then
                    if cb.notLoaded then
                        cb:SetChecked(false)
                    else
                        --cb:SetChecked(true)
                    end
                end
            else
                if SkillCappedBackupDB[addonDBName] then
                    cb:SetChecked(false)
                elseif addonIsNot("WeakAuras", addonName) then
                    if cb.notLoaded then
                        cb:SetChecked(false)
                    else
                        cb:SetChecked(true)
                    end
                end
            end

            ColorCheckboxTextAfterState(cb)
            if cb.hasUpdate and SkillCappedDB.firstLaunchAfterUpdate then
                cb:SetChecked(true)
            end
        end
        if not SkillCappedDB.completedSetup then
            SC:SetFonts()
        end
        --SC:RestoreCheckboxStates()
    end)

    SkillCappedTutorial:HookScript("OnHide", function()
        if not SkillCappedDB.completedSetup then
            SC:RestoreFonts()
        end
    end)
    if not SkillCappedDB.completedSetup then
        SC:SetFonts()
    end

    local installSelectFrame = CreateFrame("Frame", nil, SkillCappedTutorial, "BackdropTemplate")
    installSelectFrame:SetPoint("BOTTOM", SkillCappedTutorial, "BOTTOM")
    installSelectFrame:SetSize(360,420)
    installSelectFrame:Hide()
    -- Use a more modern border and background with softer edges
    installSelectFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", -- Subtle dark background
        edgeFile = "Interface\\Buttons\\WHITE8x8", -- Soft border
        tile = true,
        tileSize = 32,
        edgeSize = 1, -- Thinner edge for a cleaner look
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    installSelectFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.85) -- Darker, semi-transparent background
    installSelectFrame:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8) -- Light border
    SkillCappedTutorial.installSelectFrame = installSelectFrame

    local addonConfigBanner = MakeBanner(installSelectFrame, SkillCappedTutorial)
    SkillCappedTutorial.Header = addonConfigBanner

    local exitButton = CreateFrame("Button", nil, SkillCappedTutorial, "UIPanelButtonTemplate")
    exitButton:SetText("Exit")
    exitButton:SetWidth(80)
    AddTooltip2(exitButton, "Exit the Skill-Capped setup.", "You can re-open it later from settings.", "ANCHOR_TOP")
    exitButton:SetPoint("BOTTOM", installSelectFrame, "BOTTOM", 0, -30)
    exitButton.Text:SetFont(scFont, 12)
    SkillCappedTutorial.exitButton = exitButton

    local addonProfiles = installSelectFrame:CreateFontString(nil, "ARTWORK")
    addonProfiles:SetFont(scFont, 24)
    addonProfiles:SetPoint("TOP", addonConfigBanner, "BOTTOM", 9, -9)
    SkillCappedTutorial.addonProfiles = addonProfiles

    -- local backupNotif = installSelectFrame:CreateFontString(nil, "ARTWORK", "SystemFont_Tiny")
    -- backupNotif:SetPoint("BOTTOM", installSelectFrame, "BOTTOM", 0, 10)
    -- backupNotif:Hide()
    -- if not SkillCappedDB.completedSetup then
    --     backupNotif:SetText("All your addons will be be backed up. You can restore them later.")
    --     backupNotif:Show()
    --     backupNotif:SetTextColor(0.6,0.6,0.6)
    -- end

    local reloadReadyText = installSelectFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    reloadReadyText:Hide()
    SkillCappedTutorial.reloadReadyText = reloadReadyText

    -- local addonConfigText = installSelectFrame:CreateFontString(nil, "OVERLAY", "Game20Font")
    -- addonConfigText:SetText("")
    -- addonConfigText:SetPoint("TOP", installSelectFrame, "TOP", 0, -32)
    -- addonConfigText:SetFont(scFont, 26, "THICKOUTLINE")

    local reloadReqBtn = CreateFrame("Button", nil, installSelectFrame, "UIPanelButtonTemplate")
    reloadReqBtn:SetText("Reload")
    --reloadReqBtn:SetWidth(95)
    --reloadReqBtn:SetHeight(30)
    --reloadReqBtn.Text:SetScale(1.3)
    reloadReqBtn:SetWidth(55)
    reloadReqBtn:SetHeight(26.1)
    reloadReqBtn.Text:SetFont(scFont, 12)
    SkillCappedTutorial.reloadReqBtn = reloadReqBtn

    reloadReqBtn:Hide()
    reloadReqBtn:HookScript("OnClick", function()
        SkillCappedDB.reOpenToAddonConfig = true
        SkillCappedDB.reOpenToStep = SkillCappedTutorial.step
        SkillCappedDB.mainContent = SkillCappedTutorial.mainContent
        SkillCappedDB.characters[SC:GetPlayerNameAndRealm()] = SkillCappedDB.mainContent
        SkillCappedDB.secondaryContent = SkillCappedTutorial.secondaryContent
        SkillCappedDB.reloadCheckboxStates = SkillCappedDB.reloadCheckboxStates or {}
        SkillCappedDB.fadeBarsDropdownSelection = SkillCappedTutorial.mouseoverActionSettingsOption
        for addonName, cb in pairs(checkboxes) do
            local isChecked = cb:GetChecked()
            SkillCappedDB.reloadCheckboxStates[addonName] = isChecked
        end
        -- for weakauraClass, cb in pairs (waCheckboxes) do
        --     local isChecked = cb:GetChecked()
        --     SkillCappedDB.reloadCheckboxStates[weakauraClass] = isChecked
        -- end
        if SC.addonsNeedingReload then
            for addonName in pairs(SC.addonsNeedingReload) do
                C_AddOns.EnableAddOn(addonName)
            end
        end
        ReloadUI()
    end)
    --reloadReqBtn:SetPoint("CENTER", installSelectFrame, "BOTTOMRIGHT", -80, 40)
    reloadReqBtn:SetPoint("CENTER", installSelectFrame, "BOTTOMRIGHT", -55, 30)

    AddTooltip2(reloadReqBtn, "Reload UI", "An AddOn has been toggled and needs to be loaded in.\nClick to reload the UI. Your choices so far will be preselected after reload.", "ANCHOR_TOP")

    local installBtn = CreateFrame("Button", nil, installSelectFrame, "UIPanelButtonTemplate")
    installBtn:SetText("Install")
    installBtn:SetWidth(55)
    installBtn:SetHeight(26.1)
    installBtn:SetPoint("CENTER", installSelectFrame, "BOTTOMRIGHT", -55, 30)
    installBtn.Text:SetFont(scFont, 12)

    local installGlowCenter = installSelectFrame:CreateTexture(nil, "ARTWORK")
    installGlowCenter:SetAtlas("UI-Frame-Bar-GlowCenter")
    installGlowCenter:SetPoint("CENTER", installBtn, "CENTER", 0, -1)
    installGlowCenter:SetSize(20,35)
    installGlowCenter:SetAlpha(0)

    local installGlowLeft = installSelectFrame:CreateTexture(nil, "ARTWORK")
    installGlowLeft:SetAtlas("UI-Frame-Bar-GlowLeft")
    installGlowLeft:SetPoint("RIGHT", installGlowCenter, "LEFT")
    installGlowLeft:SetSize(20,35)
    installGlowLeft:SetAlpha(0)

    local installGlowRight = installSelectFrame:CreateTexture(nil, "ARTWORK")
    installGlowRight:SetAtlas("UI-Frame-Bar-GlowRight")
    installGlowRight:SetPoint("LEFT", installGlowCenter, "RIGHT")
    installGlowRight:SetSize(20,35)
    installGlowRight:SetAlpha(0)

    installBtn:HookScript("OnEnter", function()
        FadeFrameAlpha(installGlowCenter, 0, 1, 0.5)
        FadeFrameAlpha(installGlowLeft, 0, 1, 0.5)
        FadeFrameAlpha(installGlowRight, 0, 1, 0.5)
    end)

    installBtn:HookScript("OnLeave", function()
        FadeFrameAlpha(installGlowCenter, 1, 0, 0.3)
        FadeFrameAlpha(installGlowLeft, 1, 0, 0.3)
        FadeFrameAlpha(installGlowRight, 1, 0, 0.3)
    end)

    --installBtn.Text:SetScale(1.1)
    SkillCappedTutorial.installBtn = installBtn




    local finishInstallReloadBtn = CreateFrame("Button", nil, installSelectFrame, "UIPanelButtonTemplate")
    finishInstallReloadBtn:SetPoint("RIGHT", installSelectFrame, "RIGHT", -70, -17)
    finishInstallReloadBtn:SetText("Reload UI")
    finishInstallReloadBtn:SetWidth(70)
    finishInstallReloadBtn:SetScale(1.5)
    finishInstallReloadBtn.Text:SetFont(scFont, 12)
    finishInstallReloadBtn:HookScript("OnClick", function()
        if InCombatLockdown() then
            SC:Print("Leave combat to continue installation. Make sure you are out of combat while installing.")
            return
        end
        SC:FinishInstall()
    end)
    finishInstallReloadBtn:Hide()

    installBtn:Hide()





    -- Next button handler
    local function OnNextButtonClick()
        SkillCappedTutorial.step = SkillCappedTutorial.step + 1
        SC:ShowCurrentStep(SkillCappedTutorial.step)
        SC:UpdateStepBar()
        CheckForChanges(checkboxes, SkillCappedTutorial.reloadReqBtn, SkillCappedTutorial.installBtn, nil, true)
        if SkillCappedTutorial["PvEIgnoreWindow"] then
            SkillCappedTutorial["PvEIgnoreWindow"]:Hide()
        end
        if SkillCappedTutorial["PvPIgnoreWindow"] then
            SkillCappedTutorial["PvPIgnoreWindow"]:Hide()
        end
    end

    -- Back button handler
    local function OnBackButtonClick()
        SkillCappedTutorial.step = SkillCappedTutorial.step - 1
        SC:ShowCurrentStep(SkillCappedTutorial.step)
        SC:UpdateStepBar()
        CheckForChanges(checkboxes, SkillCappedTutorial.reloadReqBtn, SkillCappedTutorial.installBtn, nil, true)
        if SkillCappedTutorial["PvEIgnoreWindow"] then
            SkillCappedTutorial["PvEIgnoreWindow"]:Hide()
        end
        if SkillCappedTutorial["PvPIgnoreWindow"] then
            SkillCappedTutorial["PvPIgnoreWindow"]:Hide()
        end
    end




    -- #####################################
    -- Step One
    -- #####################################
    -- #####################################
    -- Step One
    -- #####################################
    local stepOne = CreateFrame("Frame", nil, SkillCappedTutorial)
    stepOne:SetAllPoints(installSelectFrame)
    SkillCappedTutorial.stepOne = stepOne
    SkillCappedTutorial.step = SkillCappedDB.reOpenToStep or 1

    local nextBtn = CreateFrame("Button", nil, installSelectFrame, "UIPanelButtonTemplate")
    nextBtn:SetText("Next")
    nextBtn:SetWidth(55)
    nextBtn:SetHeight(26.1)
    nextBtn:SetPoint("CENTER", installSelectFrame, "BOTTOMRIGHT", -55, 30)
    nextBtn.Text:SetFont(scFont, 12)
    --nextBtn.Text:SetScale(1.1)

    local backBtn = CreateFrame("Button", nil, installSelectFrame, "UIPanelButtonTemplate")
    backBtn:SetText("Back")
    backBtn:SetWidth(55)
    backBtn:SetHeight(26.1)
    backBtn:SetPoint("CENTER", installSelectFrame, "BOTTOMLEFT", 55, 30)
    backBtn.Text:SetFont(scFont, 12)
    --backBtn.Text:SetScale(1.1)
    --backBtn:Hide()

    nextBtn:HookScript("OnClick", OnNextButtonClick)
    backBtn:HookScript("OnClick", OnBackButtonClick)
    SkillCappedTutorial.NextButton = nextBtn
    SkillCappedTutorial.BackButton = backBtn

    -- Create an overlay frame to capture mouse events and show a tooltip when the button is disabled
    nextBtn.nextBtnOverlay = CreateFrame("Frame", nil, nextBtn)
    nextBtn.nextBtnOverlay:SetAllPoints(nextBtn)
    nextBtn.nextBtnOverlay:EnableMouse(true)
    nextBtn.nextBtnOverlay:Hide()
    AddTooltip2(nextBtn.nextBtnOverlay, "Select both options to continue", nil, "ANCHOR_CURSOR")

    UpdateNextButtonState(nextBtn)

    SkillCappedTutorial.maxStep = 3

    -- Create the actual status bar
    local stepStatusBar = CreateFrame("StatusBar", nil, stepOne, "BackdropTemplate")
    Mixin(stepStatusBar, SmoothStatusBarMixin)
    SkillCappedTutorial.progressBar = stepStatusBar

    stepStatusBar:SetSize(180, 20)
    stepStatusBar:SetPoint("BOTTOM", installSelectFrame, "BOTTOM", 0, 19.5)
    --stepStatusBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    --stepStatusBar:SetStatusBarTexture("Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill")
    stepStatusBar:SetStatusBarTexture("Interface\\AddOns\\SkillCapped\\media\\smooth.tga")
    stepStatusBar:GetStatusBarTexture():SetHorizTile(false)
    stepStatusBar:SetMinMaxSmoothedValue(0, SkillCappedTutorial.maxStep)
    stepStatusBar:SetSmoothedValue(SkillCappedTutorial.step or 1)
    stepStatusBar:SetStatusBarColor(0.482, 0.643, 0.988)
    stepStatusBar:SetValue(1)

    -- Create the border frame around the status bar
    local border = CreateFrame("Frame", nil, stepStatusBar, "BackdropTemplate")
    border:SetPoint("TOPLEFT", stepStatusBar, "TOPLEFT", -3, 3)
    border:SetPoint("BOTTOMRIGHT", stepStatusBar, "BOTTOMRIGHT", 3, -3)
    border:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 13,  -- Border thickness
    })
    border:SetBackdropColor(0, 0, 0, 0)
    border:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
    border:SetFrameLevel(stepStatusBar:GetFrameLevel() + 10)


    -- Add a text label to display "1/X" format
    local stepText = stepStatusBar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    stepText:SetPoint("CENTER", stepStatusBar, "CENTER", 0, 0)
    stepText:SetText((SkillCappedTutorial.step or 1) .. "/" .. SkillCappedTutorial.maxStep)

    -- Function to update the step smoothly
    function SC:UpdateStepBar()
        -- Smoothly update the status bar max value and current value
        stepStatusBar:SetMinMaxSmoothedValue(0, SkillCappedTutorial.maxStep)
        stepStatusBar:SetSmoothedValue(SkillCappedTutorial.step or 1)
        -- Update the text to reflect the current step and max step
        stepText:SetText((SkillCappedTutorial.step or 1) .. "/" .. SkillCappedTutorial.maxStep)
    end

    -- Function to dynamically update max step and ensure smooth animation
    function SC:UpdateMaxStep()
        -- PvE disabled: maxStep is 4 if secondary is PvP, otherwise 3
        SkillCappedTutorial.maxStep = 3
        -- Original with PvE: or (SkillCappedTutorial.secondaryContent == "PvE" and 4)
        SC:UpdateStepBar()  -- Update the bar and text with the new max step smoothly
    end

    -- Options for Main and Secondary content dropdowns
    local mainContentOptions = {"PvP", "PvE"}
    local secondaryContentOptions = {"PvP", "PvE"}

    -- Create the Secondary Content dropdown
    local secondaryContentDropdown, secondaryContentDropdownObj = CreateLabeledDropdown(
        stepOne,
        "Secondary Content",
        secondaryContentOptions,
        function(selection)
            SkillCappedTutorial.secondaryContent = selection
            UpdateNextButtonState(nextBtn)
            SC:UpdateMaxStep()
            SC:ToggleSwapButton()
            SC:UpdateDropdownOptions()
        end
    )
    secondaryContentDropdown:SetScale(0.9)
    secondaryContentDropdownObj:Disable()
    secondaryContentDropdownObj:EnableMouse(false)

    --
    local midnightPveInfo = stepOne:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    midnightPveInfo:SetPoint("TOP", secondaryContentDropdown, "BOTTOM", 31, -5)
    midnightPveInfo:SetFont(scFont, 11)
    midnightPveInfo:SetTextColor(1, 1, 1, 1)
    midnightPveInfo:SetWidth(150)
    midnightPveInfo:SetText("PvE discontinued.\nMouseover for info.")
    midnightPveInfo:SetJustifyH("LEFT")

    local midnightPvEInfoIcon = stepOne:CreateTexture(nil, "OVERLAY")
    midnightPvEInfoIcon:SetTexture("Interface\\AddOns\\SkillCapped\\media\\icon.blp")
    midnightPvEInfoIcon:SetSize(19,19)
    midnightPvEInfoIcon:SetPoint("TOPRIGHT", midnightPveInfo, "TOPLEFT", -2, -2)

    local midnightInfoFrame = CreateFrame("Frame", nil, stepOne)
    midnightInfoFrame:SetPoint("TOPLEFT", secondaryContentDropdown, "TOPLEFT", 0, 0)
    midnightInfoFrame:SetPoint("BOTTOMRIGHT", midnightPveInfo, "BOTTOMRIGHT", 0, 0)

    AddTooltip2(midnightInfoFrame, "Skill Capped PvE UI Discontinued", "The Skill Capped UI no longer comes with a preset PvE UI.\n\nYou can still swap to a secondary UI and use the Skill-Capped addon to toggle between the two UI’s just as before.\n\nRight-click the minimap icon after installing to load an unconfigured UI and from there you can enable the addons you want in your PvE UI.", "ANCHOR_CURSOR")


    -- Create the Main Content dropdown
    local mainContentDropdown, mainContentDropdownObj = CreateLabeledDropdown(
        stepOne,
        "Main Content",
        mainContentOptions,
        function(selection)
            SkillCappedTutorial.mainContent = selection
            UpdateNextButtonState(nextBtn)
            SC:UpdateMaxStep()
            SC:UpdateDropdownOptions()
        end
    )
    mainContentDropdown:SetScale(0.9)
    mainContentDropdownObj:Disable()
    mainContentDropdownObj:EnableMouse(false)
    local isFirstInitialization = true
    function SC:UpdateDropdownOptions()
        -- On first initialization, use SkillCappedDB; on subsequent updates, use SkillCappedTutorial
        local mainContent = "PvP"--isFirstInitialization and (SkillCappedDB.mainContent or "Select Option") or (SkillCappedTutorial.mainContent or "Select Option")
        local secondaryContent = "PvE"--isFirstInitialization and (SkillCappedDB.secondaryContent or "Select Option") or (SkillCappedTutorial.secondaryContent or "Select Option")

        -- Filter main dropdown options based on secondary content selection
        local filteredMainOptions = {"PvP"}--, "PvE"}
        for i = #filteredMainOptions, 1, -1 do
            if filteredMainOptions[i] == mainContent then
                table.remove(filteredMainOptions, i)
            end
        end

        -- Filter secondary options by removing the selected `mainContent`
        local filteredSecondaryOptions = {"PvP", "PvE"}
        for i = #filteredSecondaryOptions, 1, -1 do
            if filteredSecondaryOptions[i] == mainContent or filteredSecondaryOptions[i] == secondaryContent then
                table.remove(filteredSecondaryOptions, i)
            end
        end

        -- Update dropdowns with the filtered options
        mainContentDropdownObj:UpdateOptions(filteredMainOptions)
        mainContentDropdownObj:SetDefaultText(mainContent)
        secondaryContentDropdownObj:UpdateOptions(filteredSecondaryOptions)
        secondaryContentDropdownObj:SetDefaultText(secondaryContent)

        if secondaryContent ~= "Select Option" and mainContent == secondaryContent then
            local opposite = (mainContent == "PvP") and "PvE" or "PvP"
            secondaryContent = opposite
            SkillCappedTutorial.secondaryContent = opposite
            secondaryContentDropdownObj:SetDefaultText(opposite)

            -- Force the dropdown to refresh display
            secondaryContentDropdownObj:Hide()  -- Hide momentarily
            secondaryContentDropdownObj:Show()  -- Show again to refresh
        end

        SC:UpdateMaxStep()

        -- Set the flag to false after the initial setup
        isFirstInitialization = false
    end

    -- Initialize the dropdowns with the current SkillCappedDB values or defaults
    SC:UpdateDropdownOptions()

    UpdateNextButtonState(nextBtn)
    --SC:UpdateMaxStep()

    -- Title text
    local titleText = stepOne:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -13)
    titleText:SetText("Welcome to the Skill-Capped UI!")
    titleText:SetFont(scFont, 20)
    titleText:SetTextColor(0.482, 0.643, 0.988)

    -- Additional information text
    local infoText = stepOne:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    infoText:SetPoint("TOP", titleText, "BOTTOM", 0, -14)
    infoText:SetWidth(stepOne:GetWidth() - 95)
    local extraText = not SkillCappedDB.completedSetup and "\n\nYour addon profiles will be backed up and can be restored later." or ""
    infoText:SetText("Select the content you plan on playing."..extraText.."\n\nAfter installing, use the addon panel or the minimap icon to swap UI mode.\n\nType /sc to run this installer again or access other options.")
    infoText:SetFont(scFont, 11)
    infoText:SetTextColor(1, 1, 1, 1)

    if not SkillCappedDB.completedSetup then
        installSelectFrame:SetHeight(440)
    end

    -- Positioning the dropdowns relative to each other
    mainContentDropdown:SetPoint("TOP", infoText, "BOTTOM", -95, -20)
    secondaryContentDropdown:SetPoint("TOP", infoText, "BOTTOM", 95, -20)

    --if not SkillCappedDB.WeakAura then
        local editBox = CreateFrame("EditBox", nil, stepOne, "InputBoxTemplate")
        editBox:SetSize(85, 20)
        editBox:SetAutoFocus(false)
        editBox:Hide()

        AddTooltip2(editBox, "Enter import string", nil, "ANCHOR_TOP")

        editBox:HookScript("OnTextChanged", function()
            if SC:ChangeWeakAura(editBox:GetText()) then
                if InCombatLockdown() then
                    SC:Print("Leave combat to continue installation. Make sure you are out of combat while installing.")
                    return
                end
                -- Set the text to indicate import success
                editBox:SetJustifyH("CENTER")
                editBox:SetText("Imported!|A:common-icon-checkmark:16:16|a")

                editBox:EnableKeyboard(false)
                editBox:EnableMouse(false)
                editBox:ClearFocus()

                PlaySound(1115)
            end
        end)

        local importBtn = CreateFrame("Button", nil, stepOne, "UIPanelButtonTemplate")
        importBtn:SetText("Import")
        importBtn:SetWidth(55)
        importBtn:SetHeight(26.1)
        importBtn:SetPoint("CENTER", installSelectFrame, "BOTTOM", 0, 60)
        importBtn.Text:SetFont(scFont, 12)
        importBtn:SetScript("OnClick", function()
            -- Hide the button and show the edit box
            importBtn:Hide()
            editBox:Show()
            editBox:SetFocus()
            -- Set up a timer to hide the edit box and show the button after 15 seconds
            C_Timer.After(15, function()
                if editBox:GetText() ~= "Imported!|A:common-icon-checkmark:16:16|a" then
                    editBox:Hide()
                    importBtn:Show()
                    editBox:ClearFocus()
                end
            end)
        end)
        editBox:SetPoint("CENTER", importBtn, "CENTER", 2, 0)

        if SkillCappedDB.WeakAura then
            editBox:SetJustifyH("CENTER")
            editBox:SetText("Imported!|A:common-icon-checkmark:16:16|a")
            importBtn:Hide()
            editBox:Show()
            editBox:EnableKeyboard(false)
            editBox:EnableMouse(false)
            editBox:ClearFocus()
        end
    --end

    local generalStep = CreateFrame("Frame", nil, SkillCappedTutorial)
    generalStep:SetAllPoints(installSelectFrame)
    SkillCappedTutorial.generalStep = generalStep

    exitButton:SetScript("OnClick", function()
        if LookAndFeelCbChange() and SkillCappedDB.completedSetup then
            StaticPopup_Show("SC_EXIT_WARNING_LF")
            SetUpPopupProperties()
        elseif not SkillCappedDB.completedSetup then
            StaticPopup_Show("SC_EXIT_WARNING")
            SetUpPopupProperties()
        else
            ExitSetup()
        end
    end)

    -- #####################################
    -- Step 2
    -- #####################################

    -- PvE disabled - keep frame creation commented out for easy re-enabling
    --local pveStep = CreateFrame("Frame", nil, SkillCappedTutorial)
    --pveStep:SetAllPoints(installSelectFrame)
    --pveStep:Hide()
    --pveStep:HookScript("OnShow", function()
    --    SC:ShowHideSCCheckboxes("pve")
    --end)
    --SkillCappedTutorial.pveStep = pveStep
    
    -- Create a dummy frame to prevent nil reference errors
    SkillCappedTutorial.pveStep = CreateFrame("Frame", nil, SkillCappedTutorial)
    SkillCappedTutorial.pveStep:Hide()

    local pvpStep = CreateFrame("Frame", nil, SkillCappedTutorial)
    pvpStep:SetAllPoints(installSelectFrame)
    pvpStep:Hide()
    pvpStep:HookScript("OnShow", function()
        SC:ShowHideSCCheckboxes("pvp")
    end)
    SkillCappedTutorial.pvpStep = pvpStep

    function SC:ShowHideSCCheckboxes(contentType)
        for addonName, cb in pairs(scCheckboxes) do
            --if SC:GetSkillCappedAddonList(contentType)[addonName] then
                if SkillCappedDB.WeakAura then
                    cb:Show()
                else
                    cb:Hide()
                end
            --end
        end
    end

    function SC:CreateInstallStep(contentType, parentFrame)
        if not SkillCappedTutorial.installStepCreated then
            SkillCappedTutorial.installStepCreated = {}
        end
        local titleText = contentType == "PvP" and "PvP Profiles" or contentType == "PvE" and "PvE Profiles" or contentType == "LookAndFeel" and "Look & Feel" or ""
        if SkillCappedTutorial.installStepCreated[contentType] then
            parentFrame:Show()
            addonProfiles:SetText(titleText)
            return
        end
        local yOffset = contentType == "LookAndFeel" and -98 or -96
        local yOffset2 = -53
        local xOffset = contentType == "LookAndFeel" and 40 or 40
        local spacing = 17

        local contentTypeSettings = {
            ["PvP"] = { atlas = "countdown-swords", size = {28, 28}, offset = {-2, 1} },
            ["PvE"] = { atlas = "Dungeon", size = {36, 36}, offset = {0, 1} },
            ["LookAndFeel"] = { atlas = "glues-characterSelect-icon-notify-inProgress-hover", size = {39, 39}, offset = {2, -2} },
        }
        local settings = contentTypeSettings[contentType] or { atlas = "DefaultAtlasName", size = {16, 16}, offset = {-2, 0} }
        local contentIcon = parentFrame:CreateTexture(nil, "OVERLAY")
        contentIcon:SetSize(unpack(settings.size))
        contentIcon:SetAtlas(settings.atlas)
        contentIcon:SetPoint("RIGHT", addonProfiles, "LEFT", unpack(settings.offset))

        addonProfiles:SetText(titleText)

        -- local contentTypeSettings = {
        --     ["PvP"] = { atlas = "weeklyrewards-background-pvp", size = {20, 20}, offset = {-2, 0} },
        --     ["PvE"] = { atlas = "weeklyrewards-background-mythic", size = {349, 132}, offset = {-2, 0} },
        --     ["LookAndFeel"] = { atlas = "mountequipment-background", size = {18, 18}, offset = {-3, 0} },
        -- }
        -- local settings = contentTypeSettings[contentType] or { atlas = "DefaultAtlasName", size = {16, 16}, offset = {-2, 0} }
        -- local contentIcon = parentFrame:CreateTexture(nil, "BORDER")
        -- --contentIcon:SetSize(unpack(settings.size))
        -- contentIcon:SetAtlas(settings.atlas)
        -- contentIcon:SetPoint("TOPLEFT", addonConfigBanner, "TOPLEFT", 1, -1)
        -- contentIcon:SetPoint("BOTTOMRIGHT", addonConfigBanner, "BOTTOMRIGHT", -1, 0)
        -- contentIcon:SetTexCoord(1,0,0,1)
        -- contentIcon:SetAlpha(0.9)
        -- contentIcon:SetDrawLayer("BORDER", -1)

        local checkboxTables = {
            ["PvP"] = pvpCheckboxes,
            ["PvE"] = pveCheckboxes,
            ["LookAndFeel"] = lookAndFeelCheckboxes,
        }

        local contentCheckboxes = checkboxTables[contentType]
        local addonList = (contentType == "PvP" and "pvpAddonList") or (contentType == "PvE" and "pveAddonList") or "lookAndFeelAddonList"
        local scAddonList = (contentType == "PvP" and "pvpSkillCappedAddonList") or (contentType == "PvE" and "pveSkillCappedAddonList")

        local yOffsetPush = -17
        for _, addonName in ipairs(SC:GetAddonList(addonList)) do
            local formattedAddonName = addonName:gsub("_", " ")
            local cb = CreateCheckbox(addonName, parentFrame, 250, yOffset)
            yOffsetPush = yOffsetPush + spacing
            if addonName == "Fade Status/XP Bar" then
                xOffset = xOffset + 175
                yOffset = yOffset + yOffsetPush
            end
            if addonName == "Smart Tab Targeting" then
                yOffset = yOffset - 63
                xOffset = xOffset - 175
            end
            cb:SetPoint("TOPLEFT", addonConfigBanner, "BOTTOMLEFT", xOffset, yOffset)
            yOffset = yOffset - spacing
            cb.Text:SetText(formattedAddonName)
            cb[contentType.."Addon"] = true
            if SC.sharedAddons[addonName] then
                checkboxes[addonName..contentType] = cb
                contentCheckboxes[addonName..contentType] = cb
            else
                checkboxes[addonName] = cb
                contentCheckboxes[addonName] = cb
            end
        end

        for _, addonName in ipairs(SC:GetAddonList(scAddonList)) do
            local formattedAddonName = addonName:gsub("_", " ")
            local cb = CreateCheckbox(addonName, parentFrame, 250, yOffset)
            cb:SetPoint("TOPLEFT", addonConfigBanner, "BOTTOMRIGHT", -130, yOffset2)
            yOffset2 = yOffset2 - spacing
            cb.Text:SetText(formattedAddonName)
            cb[contentType.."Addon"] = true
            if SC.sharedAddons[addonName] or addonName == "CooldownManager" then
                checkboxes[addonName..contentType] = cb
                contentCheckboxes[addonName..contentType] = cb
                scCheckboxes[addonName..contentType] = cb
                cb.addonName = addonName..contentType
            else
                checkboxes[addonName] = cb
                contentCheckboxes[addonName] = cb
                scCheckboxes[addonName] = cb
            end
        end

        if contentType == "LookAndFeel" then
            parentFrame:HookScript("OnShow", function(self)
                if self.showing then return end
                self.showing = true
                if SkillCappedDB.reloadCheckboxStates then
                    return
                end
                local addonNameMapping = {
                    ["BetterBags"] = "BetterBags",
                    ["Dark Mode"] = "FrameColor",
                    ["Class Colored Healthbars"] = "HealthBarColor",
                    ["Improved Character Panel"] = "DejaCharacterStats",
                }
                local addonSettingMapping = {
                    ["Class Icon Portraits"] = "ReplaceMyPlayerPortrait",
                    --["Combined Bags"] = "combinedBags",
                    ["Fade Menu & Bags"] = "fadeMicroMenu",
                    ["Fade Status/XP Bar"] = "fadeStatusBar",
                    ["Hide Error Frame"] = "hideErrorFrame",
                    ["Hide Hit Indicator"] = "hideHitIndicator",
                    ["New Fonts"] = "newFonts",
                    ["Player Elite Frame"] = "playerElite",
                    ["Queue Pop Notification"] = "queuePopNotification",
                    ["Smart Tab Targeting"] = "smartTabTargeting",
                    --["Resize Talents & Spellbook"] = "reducedTalentFrameSize",
                }
                SkillCappedTutorial.LookAndFeelInitCheckboxStates = {}
                for addonName, cb in pairs(contentCheckboxes) do
                    if cb.installed then
                        cb:SetChecked(true)
                    end
                    local mappedName = addonNameMapping[addonName]
                    if mappedName then
                        if not SC:IsAddonLoaded(mappedName) then
                            if SkillCappedDB.characters[SC:GetPlayerNameAndRealm()] then
                                if mappedName == "DejaCharacterStats" then
                                    local loaded, allMissing = SC:IsAddonLoaded(mappedName)
                                    if allMissing then
                                        cb:SetChecked(false)
                                    end
                                else
                                    -- if mappedName == "MouseoverActionSettings" and SkillCappedDB.mainContent == "PvP" then
                                    --     --
                                    -- else
                                        cb:SetChecked(false)
                                    --end
                                end
                            end
                        end
                    end
                    local settingKey = addonSettingMapping[addonName]
                    if SkillCappedDB.completedSetup and settingKey and not SkillCappedDB[settingKey] then
                        cb:SetChecked(false)
                    end
                    ColorCheckboxTextAfterState(cb)
                    SkillCappedTutorial.LookAndFeelInitCheckboxStates[addonName] = cb:GetChecked()
                end
                for addonName, cb in pairs(checkboxes) do
                    local mappedName = addonNameMapping[addonName]
                    if mappedName then
                        if not SC:IsAddonLoaded(mappedName) then
                            if SkillCappedDB.characters[SC:GetPlayerNameAndRealm()] then
                                if mappedName == "DejaCharacterStats" then
                                    local loaded, allMissing = SC:IsAddonLoaded(mappedName)
                                    if allMissing then
                                        cb:SetChecked(false)
                                    end
                                else
                                    -- if mappedName == "MouseoverActionSettings" and SkillCappedDB.mainContent == "PvP" then
                                    --     --
                                    -- else
                                        cb:SetChecked(false)
                                    --end
                                end
                            end
                        end
                    end
                    local settingKey = addonSettingMapping[addonName]
                    if SkillCappedDB.completedSetup and settingKey and not SkillCappedDB[settingKey] then
                        cb:SetChecked(false)
                    end
                    ColorCheckboxTextAfterState(cb)
                end
            end)

            SkillCappedTutorial:HookScript("OnHide", function()
                parentFrame.showing = nil
            end)

            local infoText = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            infoText:SetPoint("TOP", addonProfiles, "BOTTOM", -9, -5)
            infoText:SetWidth(parentFrame:GetWidth() - 40)
            infoText:SetText("Choose which features you want on or off.")
            infoText:SetFont(scFont, 11)
            infoText:SetTextColor(1, 1, 1, 1)

            local infoText2 = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            infoText2:SetPoint("TOP", infoText, "BOTTOM", 0, -3)
            infoText2:SetWidth(parentFrame:GetWidth() - 40)
            infoText2:SetText("You can return to this menu after installation using /sc")
            infoText2:SetFont(scFont, 11)
            infoText2:SetTextColor(1, 1, 1, 1)

            local infoText = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            infoText:SetPoint("BOTTOMLEFT", contentCheckboxes["New Fonts"], "TOPLEFT", 5, 8)
            infoText:SetText("Appearance")
            infoText:SetFont(scFont, 15)
            infoText:SetTextColor(1, 1, 1, 1)
            contentCheckboxes["New Fonts"].Text:SetText("New Font")

            local separatorLine = parentFrame:CreateTexture(nil, "OVERLAY")
            separatorLine:SetAtlas("AftLevelup-GlowLine")
            separatorLine:SetPoint("TOP", infoText, "BOTTOM", 0, 1)
            separatorLine:SetSize(135, 10)
            separatorLine:SetDesaturated(true)
            separatorLine:SetVertexColor(0.482, 0.643, 0.988)

            local infoText = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            infoText:SetPoint("BOTTOMLEFT", contentCheckboxes["Fade Status/XP Bar"], "TOPLEFT", 12, 8)
            infoText:SetText("Hide Frames")
            infoText:SetFont(scFont, 15)
            infoText:SetTextColor(1, 1, 1, 1)

            local separatorLine = parentFrame:CreateTexture(nil, "OVERLAY")
            separatorLine:SetAtlas("AftLevelup-GlowLine")
            separatorLine:SetPoint("TOP", infoText, "BOTTOM", -1, 1)
            separatorLine:SetSize(135, 10)
            separatorLine:SetDesaturated(true)
            separatorLine:SetVertexColor(0.482, 0.643, 0.988)

            local infoText = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            infoText:SetPoint("BOTTOMLEFT", contentCheckboxes["Smart Tab Targeting"], "TOPLEFT", 5, 8)
            infoText:SetText("Misc")
            infoText:SetFont(scFont, 15)
            infoText:SetTextColor(1, 1, 1, 1)

            local separatorLine = parentFrame:CreateTexture(nil, "OVERLAY")
            separatorLine:SetAtlas("AftLevelup-GlowLine")
            separatorLine:SetPoint("TOP", infoText, "BOTTOM", 27, 1)
            separatorLine:SetSize(135, 10)
            separatorLine:SetDesaturated(true)
            separatorLine:SetVertexColor(0.482, 0.643, 0.988)
        else
            local infoText = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            infoText:SetPoint("TOP", addonProfiles, "BOTTOM", -9, -5)
            infoText:SetWidth(parentFrame:GetWidth() - 40)
            infoText:SetText("Choose the Skill Capped profiles you want to install.")
            infoText:SetFont(scFont, 11)
            infoText:SetTextColor(1, 1, 1, 1)
        end


        if contentType ~= "LookAndFeel" and contentType ~= "PvE" then
            local cvarCb = CreateCheckbox("CVars", parentFrame, 250, -2)
            cvarCb:SetPoint("TOPLEFT", addonConfigBanner, "BOTTOMLEFT", 40, -53)
            cvarCb.Text:SetText("CVars")
            contentCheckboxes["CVars"..contentType] = cvarCb
            cvarCb.addonName = "CVars"..contentType
            checkboxes["CVars"..contentType] = cvarCb
            --checkboxes["CVars"] = cvarCb

            local editModeCb = CreateCheckbox("EditMode", parentFrame, 250, -2)
            editModeCb:SetPoint("TOPLEFT", addonConfigBanner, "BOTTOMLEFT", 40, -70)
            editModeCb.Text:SetText("Edit Mode & UI Scale")
            contentCheckboxes["EditMode"..contentType] = editModeCb
            editModeCb.addonName = "EditMode"..contentType
            checkboxes["EditMode"..contentType] = editModeCb
            --checkboxes["EditMode"] = editModeCb
        end

        local addonSettingMapping = {
            ["Class Icon Portraits"] = "ReplaceMyPlayerPortrait",
            --["Combined Bags"] = "combinedBags",
            ["Fade Menu & Bags"] = "fadeMicroMenu",
            ["Hide PvE WA's in PvP"] = "hidePvEWeakAurasInPvP",
            ["Hide PvP WA's in PvE"] = "hidePvPWeakAurasInPvE",
            ["Hide Class Power (PvE)"] = "hidePlayerPower",
            ["Fade Status/XP Bar"] = "fadeStatusBar",
            ["Hide Error Frame"] = "hideErrorFrame",
            ["Hide Hit Indicator"] = "hideHitIndicator",
            ["New Fonts"] = "newFonts",
            ["Player Elite Frame"] = "playerElite",
            ["Queue Pop Notification"] = "queuePopNotification",
            ["Smart Tab Targeting"] = "smartTabTargeting",
            --["Resize Talents & Spellbook"] = "reducedTalentFrameSize",
        }

        for addonName, cb in pairs(contentCheckboxes) do
            cb.initialState = cb:GetChecked()
            cb.addonName = addonName
            local tooltipText = getAddonDescription(SC:GetRealAddonName(addonName))
            local addonDBName = SC.addonDatabaseMap[addonName]

            if contentType == "LookAndFeel" then
                addonName = SC:GetRealAddonName(addonName)
                cb.addonName = SC:GetRealAddonName(addonName)
                tooltipText = getAddonDescription(SC:GetRealAddonName(SC:GetRealAddonName(addonName)))
                addonDBName = SC.addonDatabaseMap[SC:GetRealAddonName(addonName)]
                cb.LookAndFeel = true
            end

            local settingKey = addonSettingMapping[addonName]
            if settingKey and SkillCappedDB[settingKey] then
                cb.installed = true
            end

            if addonName == "Player Elite Frame" then
                local function ombScript(cb)
                    cb:HookScript("OnMouseDown", function(self, button)
                        if button == "RightButton" then
                            -- Update the playerEliteMode and apply the changes
                            SkillCappedDB["playerEliteMode"] = SkillCappedDB["playerEliteMode"] % 4 + 1
                            local originalPlayerEliteState = SkillCappedDB.playerElite
                            if not originalPlayerEliteState then
                                SkillCappedDB.playerElite = true
                            end
                            SC:PlayerElite(SkillCappedDB["playerEliteMode"])

                            -- Store the original parent if not already done
                            if not cb.pfParent then
                                cb.pfParent = PlayerFrame:GetParent()
                            end
                            if not cb.originalPoint then
                                -- Save the original position
                                local point, relativeTo, relativePoint, xOfs, yOfs = PlayerFrame:GetPoint()
                                cb.originalPoint = { point, relativeTo, relativePoint, xOfs, yOfs }
                            end

                            -- Update the parent to the tutorial temporarily
                            PlayerFrame:SetParent(SkillCappedTutorial)
                            PlayerFrame:ClearAllPoints()
                            PlayerFrame:SetPoint("RIGHT", installSelectFrame, "LEFT", 5, -80)

                            -- Cancel the previous timer if it exists
                            if cb.pendingTimer then
                                cb.pendingTimer:Cancel()
                            end

                            -- Start a new timer
                            cb.pendingTimer = C_Timer.NewTimer(3, function()
                                -- Only set the parent back after the timer completes
                                PlayerFrame:SetParent(cb.pfParent)
                                -- Restore the original position
                                PlayerFrame:ClearAllPoints()
                                PlayerFrame:SetPoint(unpack(cb.originalPoint))
                                SkillCappedDB.playerElite = originalPlayerEliteState
                                cb.pendingTimer = nil -- Clear the timer reference
                            end)
                        end
                    end)
                end
                ombScript(cb)
                ombScript(cb.Text)
            end

            local function ombScript(cb)
                cb:HookScript("OnMouseDown", function(self, button)
                    if button == "RightButton" and IsControlKeyDown() then
                        if not cb.uninstallMark then
                            local uninstallMark = cb:CreateTexture(nil, "OVERLAY")
                            uninstallMark:SetAtlas("common-icon-redx")
                            uninstallMark:SetPoint("CENTER", cb, "CENTER", 0, 0)
                            uninstallMark:SetSize(13, 13)
                            cb.uninstallMark = uninstallMark
                        end
                        if not cb.uninstall then
                            cb.uninstall = true
                            cb.uninstallMark:Show()
                            cb:SetChecked(false)
                        else
                            cb.uninstall = nil
                            cb.uninstallMark:Hide()
                        end
                        ColorCheckboxTextAfterState(cb)
                    end
                end)
            end
            ombScript(cb)
            ombScript(cb.Text)

            cb:HookScript("OnClick", function()
                if cb.uninstall then
                    cb:SetChecked(false)
                end
            end)

            if SkillCappedBackupDB[addonDBName] then
                if addonIsNot("WeakAuras", addonName) and contentType ~= "LookAndFeel" then
                    local hasBkup = cb:CreateTexture(nil, "OVERLAY")
                    hasBkup:SetSize(15, 15)
                    hasBkup:SetPoint("RIGHT", cb, "LEFT", 2, 0)
                    hasBkup:SetAtlas("Repair")
                    local backupDate = SkillCappedBackupDB.addonBackupTimes and SkillCappedBackupDB.addonBackupTimes[addonName] or "Date not available"
                    local isOrAre = addonIs("CVars", addonName) and "are" or "is"
                    local headerText = string.format("%s %s backed up.", addonName, isOrAre)
                    local tooltipText = ""
                    if addonIs("EditMode") then
                        tooltipText = string.format("Backup made: %s\n\nYou will not lose this backup if\nyou re-run the installation.\nOnly restoring a previous backup will wipe backups and create new ones during a new installation.", backupDate)
                    else
                        tooltipText = string.format("Backup made: %s\n\nYou will not lose this backup if\nyou re-run the installation.\nOnly restoring a previous backup will wipe backups and create new ones during a new installation.", backupDate)
                    end
                    AddTooltip2(hasBkup, headerText, tooltipText, "ANCHOR_LEFT", parentFrame)

                    cb.hasBkup = hasBkup
                end
                if contentType == "LookAndFeel" then
                    local addonNameMapping = {
                        ["FrameColor"] = "Dark Mode",
                        ["HealthBarColor"] = "Class Colored Healthbars",
                        ["DejaCharacterStats"] = "Improved Character Panel",
                        ["BetterBags"] = "BetterBags",
                    }
                    local mappedName = addonNameMapping[addonName]
                    if SkillCappedDB.enabledAddons[addonName] or SkillCappedDB.enabledAddons[mappedName] then
                        cb.installed = true
                    end
                else
                    cb.installed = true
                end
            end

            --CheckboxWillGetUpdated(cb, addonName)

            -- Not loaded addons
            if not SC:IsAddonLoaded(addonName) and addonIsNot("MouseoverActionSettings", addonName) and addonIsNot("FrameColor", addonName) and addonIsNot("DejaCharacterStats", addonName) and addonIsNot("BetterBags", addonName) then
                cb.notLoaded = true
                if contentType ~= "LookAndFeel" then
                    cb:SetChecked(false)
                end

                CheckIfProfileHasUpdates(addonName, cb)
                local updateNote = cb.hasUpdate and "\n\n|cff32f795Profile has update available! Enable if you want to update this profile. Doing this will reset any changes you have made to this profile since the last install.|r" or ""

                AddTooltip2(cb, "Addon not enabled.", "Please check the box to enable the addon in order to install preset."..updateNote, "ANCHOR_LEFT", parentFrame)
                AddTooltip2(cb.Text, "Addon not enabled.", "Please check the box to enable the addon in order to install preset."..updateNote, "ANCHOR_LEFT", parentFrame)

                -- If they dont exist make them red and disable them
                if not SC:DoesAddonExist(addonName) then
                    cb:Disable()
                    local overlay = CreateFrame("Frame", nil, parentFrame)
                    overlay:SetFrameLevel(cb:GetFrameLevel() + 1)
                    overlay:SetFrameStrata("HIGH")
                    overlay:SetSize(cb:GetWidth()+cb.Text:GetWidth(), cb:GetHeight())
                    overlay:SetPoint("TOPLEFT", cb, "TOPLEFT")
                    overlay:SetScript("OnMouseDown", function()
                        PlaySound(847)
                    end)
                    overlay:EnableMouse(true)
                    AddTooltip2(overlay, "Addon not found.", "Please check your addon folder\nor download it from CurseForge.\n\nRight-click install button to reload to check again.", "ANCHOR_LEFT", parentFrame)
                    cb.overlay = overlay
                    cb.notFound = true
                else
                    if SkillCappedDB.newPvEUpdate then
                        cb:SetChecked(true)
                    end
                    if cb.hasUpdate and SkillCappedDB.firstLaunchAfterUpdate then
                        cb:SetChecked(true)
                    end
                end
            else
                -- loaded addons
                CheckIfProfileHasUpdates(addonName, cb)
                local updateNote = cb.hasUpdate and "\n\n|cff32f795Profile has update available! Enable if you want to update this profile. Doing this will reset any changes you have made to this profile since the last install.|r" or ""
                local installedNote = (cb.LookAndFeel and cb.installed) and "\n\nSetting/Addon enabled. Unselect and install to turn off." or (cb.hasUpdate and updateNote) or cb.installed and "\n\n|cff7ba4fcProfile already installed. Enable if you want to re-import this profile. Doing this will reset any changes you have made to this profile since the last install.|r" or ""
                local dbName = SC.addonDatabaseMap[addonName]
                local addonIsBackedUp = dbName and SkillCappedBackupDB[dbName]

                -- Uncheck if the addon is backed up or if the setting is enabled in SkillCappedDB
                if addonIsBackedUp or (settingKey and SkillCappedDB[settingKey]) then
                    if contentType ~= "LookAndFeel" then
                        cb:SetChecked(false)
                    else
                        if addonIsBackedUp then
                            if addonName == "FrameColor" then
                                addonName = "Dark Mode"
                            end
                            if addonName == "HealthBarColor" then
                                addonName = "Class Colored Healthbars"
                            end
                            if addonName == "DejaCharacterStats" then
                                addonName = "Improved Character Panel"
                            end
                            if SkillCappedDB.enabledAddons[addonName] then
                                cb:SetChecked(true)
                            end
                        else
                            cb:SetChecked(true)
                        end
                    end
                else
                    if not SkillCappedDB.completedSetup then
                        if addonName == "Queue Pop Notification" then
                            cb:SetChecked(false)
                        else
                            cb:SetChecked(true)
                        end
                    elseif addonIsNot("WeakAuras", addonName) then
                        if contentType ~= "LookAndFeel" then
                            if SkillCappedDB.newPvEUpdate then
                                cb:SetChecked(true)
                            else
                                cb:SetChecked(false)
                            end
                        end
                    else
                        if SkillCappedDB.newPvEUpdate then
                            cb:SetChecked(true)
                        end
                    end
                end
                if not SkillCappedDB.completedSetup then
                    if not cb.notFound then
                        if addonName == "Queue Pop Notification" then
                            cb:SetChecked(false)
                        else
                            cb:SetChecked(true)
                        end
                    end
                end
                if cb.hasUpdate and SkillCappedDB.firstLaunchAfterUpdate then
                    cb:SetChecked(true)
                end

                if addonIs("CVars", addonName) then
                    AddTooltip2(cb, "CVars", "SkillCapped customized CVars."..installedNote, "ANCHOR_LEFT", parentFrame)
                    AddTooltip2(cb.Text, "CVars", "SkillCapped customized CVars."..installedNote, "ANCHOR_LEFT", parentFrame)
                elseif addonIs("EditMode", addonName) then
                    AddTooltip2(cb, "Edit Mode", "SkillCapped customized edit mode profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                    AddTooltip2(cb.Text, "Edit Mode", "SkillCapped customized edit mode profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                elseif addonIs("CooldownManager", addonName) then
                    AddTooltip2(cb, "Cooldown Manager", "SkillCapped customized Cooldown Manager profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                    AddTooltip2(cb.Text, "Cooldown Manager", "SkillCapped customized Cooldown Manager profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                elseif addonIs("Dark Mode", addonName) then
                    local missingText = CheckForMissingLookAndFeelAddon(cb, "FrameColor")
                    AddTooltip2(cb, "Dark Mode", "Enables FrameColor for a dark mode theme to all of WoW."..installedNote..missingText, "ANCHOR_LEFT", parentFrame)
                    AddTooltip2(cb.Text, "Dark Mode", "Enables FrameColor for a dark mode theme to all of WoW."..installedNote..missingText, "ANCHOR_LEFT", parentFrame)
                -- elseif addonIs("WeakAuras", addonName) then
                --     local weakauraNote = cb.hasUpdate and "\n\n|cff32f795Our WeakAuras have updates available! Enable if you want to update them. Doing this will reset any changes you have made to them.|r" or cb.installed and "|cff7ba4fc\n\nWeakAuras have already been imported.\nEnable to re-import the SkillCapped preset WeakAuras.\nAll your other WeakAuras will not be affected.|r" or "|cff7ba4fc\n\nEnable to import the SkillCapped preset WeakAuras.\nAll your other WeakAuras will not be affected.|r"
                --     AddTooltip2(cb, "WeakAuras", tooltipText.."\n\n|cff32f795Right-click to ignore specific weakauras|r"..weakauraNote, "ANCHOR_LEFT", parentFrame)
                --     AddTooltip2(cb.Text, "WeakAuras", tooltipText.."\n\n|cff32f795Right-click to ignore specific weakauras|r"..weakauraNote, "ANCHOR_LEFT", parentFrame)
                elseif addonName == "Improved Character Panel" then
                    local missingText = CheckForMissingLookAndFeelAddon(cb, "BetterCharacterPanel", "DejaCharacterStats", "TrueStatValues")
                    AddTooltip2(cb, "Improved Character Panel", "Enables three addons to vastly improve the Character Panel. (BetterCharacterPanel, DejaCharacterStats & TrueStatValues)"..installedNote..missingText, "ANCHOR_LEFT", parentFrame)
                    AddTooltip2(cb.Text, "Improved Character Panel", "Enables three addons to vastly improve the Character Panel. (BetterCharacterPanel, DejaCharacterStats & TrueStatValues)"..installedNote..missingText, "ANCHOR_LEFT", parentFrame)
                elseif addonName == "BetterBags" then
                    local missingText = CheckForMissingLookAndFeelAddon(cb, "BetterBags")
                    --local description = customDescriptions["BetterBags"]
                    AddTooltip2(cb, "BetterBags", tooltipText..installedNote..missingText, "ANCHOR_LEFT", parentFrame)
                    AddTooltip2(cb.Text, "BetterBags", tooltipText..installedNote..missingText, "ANCHOR_LEFT", parentFrame)
                elseif addonName == "Class Colored Healthbars" then
                    local missingText = CheckForMissingLookAndFeelAddon(cb, "HealthBarColor")
                    local description = customDescriptions["HealthBarColor"]
                    AddTooltip2(cb, "Class Colored Healthbars", description..installedNote..missingText, "ANCHOR_LEFT", parentFrame)
                    AddTooltip2(cb.Text, "Class Colored Healthbars", description..installedNote..missingText, "ANCHOR_LEFT", parentFrame)
                else
                    AddTooltip2(cb, SC:GetRealAddonName(addonName), tooltipText..installedNote, "ANCHOR_LEFT", parentFrame)
                    AddTooltip2(cb.Text, SC:GetRealAddonName(addonName), tooltipText..installedNote, "ANCHOR_LEFT", parentFrame)
                end
            end

            ColorCheckboxTextAfterState(cb)

            if addonName == "ArcUI" then
                hooksecurefunc(cb, "SetChecked", function(self)
                    local checked = self:GetChecked()
                    if checked then
                        if contentCheckboxes["CooldownManager"..contentType] and not contentCheckboxes["CooldownManager"..contentType]:GetChecked() then
                            contentCheckboxes["CooldownManager"..contentType]:SetChecked(true)
                            ColorCheckboxTextAfterState(contentCheckboxes["CooldownManager"..contentType])
                        end
                    end
                end)
            end

            cb:HookScript("OnClick", function(self)
                local addonName = self.addonName
                local currentState = self:GetChecked()

                -- Auto-check CooldownManager when ArcUI is checked
                if currentState and addonName == "ArcUI" then
                    local cooldownManagerKey = "CooldownManager"..contentType
                    if contentCheckboxes[cooldownManagerKey] and not contentCheckboxes[cooldownManagerKey]:GetChecked() then
                        contentCheckboxes[cooldownManagerKey]:SetChecked(true)
                        ColorCheckboxTextAfterState(contentCheckboxes[cooldownManagerKey])
                    end
                end

                -- Auto-uncheck ArcUI when CooldownManager is unchecked (ArcUI requires CooldownManager)
                if not currentState and addonName == "CooldownManager"..contentType then
                    if contentCheckboxes["ArcUI"] and contentCheckboxes["ArcUI"]:GetChecked() then
                        contentCheckboxes["ArcUI"]:SetChecked(false)
                        ColorCheckboxTextAfterState(contentCheckboxes["ArcUI"])
                    end
                end

                CheckForChanges(checkboxes, SkillCappedTutorial.reloadReqBtn, SkillCappedTutorial.installBtn, nil, true)
                if SC:DoesAddonExist(addonName) then
                    if currentState then
                        -- if contentType ~= "LookAndFeel" then
                        --     C_AddOns.EnableAddOn(addonName)
                        -- end
                        -- if addonName == "WeakAuras" then
                        --     -- if SkillCappedTutorial.step == 3 or (SkillCappedTutorial.step == 2 and SkillCappedTutorial.mainContent == "PvE" and SkillCappedTutorial.secondaryContent == "None") then
                        --     --     SkillCappedTutorial.installBtn:Hide()
                        --     -- end
                        --     C_AddOns.EnableAddOn("WeakAurasArchive")
                        --     C_AddOns.EnableAddOn("WeakAurasCompanion")
                        --     C_AddOns.EnableAddOn("WeakAurasModelPaths")
                        --     C_AddOns.EnableAddOn("WeakAurasOptions")
                        --     C_AddOns.EnableAddOn("WeakAurasTemplates")
                        -- end
                        -- if addonName == "ImprovedCharacterPanel" then
                        --     C_AddOns.EnableAddOn("BetterCharacterPanel")
                        --     C_AddOns.EnableAddOn("DejaCharacterStats")
                        --     C_AddOns.EnableAddOn("TrueStatValues")
                        -- end
                        local updateNote = cb.hasUpdate and "\n\n|cff32f795Profile has update available! Enable if you want to update this profile. Doing this will reset any changes you have made to this profile since the last install.|r" or ""
                        local installedNote = (cb.LookAndFeel and cb.installed) and "\n\nSetting/Addon enabled. Unselect and install to turn off." or (cb.hasUpdate and updateNote) or cb.installed and "\n\n|cff7ba4fcProfile already installed. Enable if you want to re-import this profile. Doing this will reset any changes you have made to this profile since the last install.|r" or ""
                        if addonIs("CVars", addonName) then
                            AddTooltip2(cb, "CVars", "SkillCapped customized CVars."..installedNote, "ANCHOR_LEFT", parentFrame)
                            AddTooltip2(cb.Text, "CVars", "SkillCapped customized CVars."..installedNote, "ANCHOR_LEFT", parentFrame)
                            RefreshTooltip(cb, "CVars", "SkillCapped customized CVars."..installedNote, "ANCHOR_LEFT", parentFrame)
                        elseif addonIs("EditMode", addonName) then
                            AddTooltip2(cb, "Edit Mode", "SkillCapped customized edit mode profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                            AddTooltip2(cb.Text, "Edit Mode", "SkillCapped customized edit mode profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                            RefreshTooltip(cb, "Edit Mode", "SkillCapped customized edit mode profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                        elseif addonIs("CooldownManager", addonName) then
                            AddTooltip2(cb, "Cooldown Manager", "SkillCapped customized Cooldown Manager profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                            AddTooltip2(cb.Text, "Cooldown Manager", "SkillCapped customized Cooldown Manager profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                            RefreshTooltip(cb, "Cooldown Manager", "SkillCapped customized Cooldown Manager profile."..installedNote, "ANCHOR_LEFT", parentFrame)
                        elseif addonName =="FrameColor" then
                            AddTooltip2(cb, "Dark Mode", "Enables FrameColor for a dark mode theme to all of WoW."..installedNote, "ANCHOR_LEFT", parentFrame)
                            AddTooltip2(cb.Text, "Dark Mode", "Enables FrameColor for a dark mode theme to all of WoW."..installedNote, "ANCHOR_LEFT", parentFrame)
                            RefreshTooltip(cb, "Dark Mode", "Enables FrameColor for a dark mode theme to all of WoW."..installedNote, "ANCHOR_LEFT", parentFrame)
                        -- elseif addonIs("WeakAuras", addonName) then
                        --     local weakauraNote = cb.hasUpdate and "\n\n|cff32f795Our WeakAuras have updates available! Enable if you want to update them. Doing this will reset any changes you have made to them.|r" or cb.installed and "|cff7ba4fc\n\nWeakAuras have already been imported.\nEnable to re-import the SkillCapped preset WeakAuras.\nAll your other WeakAuras will not be affected.|r" or "|cff7ba4fc\n\nEnable to import the SkillCapped preset WeakAuras.\nAll your other WeakAuras will not be affected.|r"
                        --     AddTooltip2(cb, addonName, tooltipText.."\n\n|cff32f795Right-click to ignore specific weakauras|r"..weakauraNote, "ANCHOR_LEFT", parentFrame)
                        --     AddTooltip2(cb.Text, addonName, tooltipText.."\n\n|cff32f795Right-click to ignore specific weakauras|r"..weakauraNote, "ANCHOR_LEFT", parentFrame)
                        --     RefreshTooltip(cb, addonName, tooltipText.."\n\n|cff32f795Right-click to ignore specific weakauras|r"..weakauraNote, "ANCHOR_LEFT", parentFrame)
                        else
                            AddTooltip2(cb, SC:GetRealAddonName(addonName), tooltipText..installedNote, "ANCHOR_LEFT", parentFrame)
                            AddTooltip2(cb.Text, SC:GetRealAddonName(addonName), tooltipText..installedNote, "ANCHOR_LEFT", parentFrame)
                            RefreshTooltip(cb, SC:GetRealAddonName(addonName), tooltipText..installedNote, "ANCHOR_LEFT", parentFrame)
                        end
                    else
                        if cb.notLoaded then
                            AddTooltip2(cb, "Addon not enabled.", "Please check the box to enable the addon in order to install preset.", "ANCHOR_LEFT", parentFrame)
                            AddTooltip2(cb.Text, "Addon not enabled.", "Please check the box to enable the addon in order to install preset.", "ANCHOR_LEFT", parentFrame)
                            RefreshTooltip(cb, "Addon not enabled.", "Please check the box to enable the addon in order to install preset.", "ANCHOR_LEFT", parentFrame)
                        end
                    end
                end
            end)
        end

        local missingAddonDetected
        for _, addonName in ipairs(SC:GetAddonList(addonList)) do
            if not SC:IsAddonLoaded(SC:GetRealAddonName(addonName)) then
                missingAddonDetected = true
                break
            end
        end
        if SkillCappedDB.WeakAura then
            for _, addonName in ipairs(SC:GetAddonList(scAddonList)) do
                if not SC:IsAddonLoaded(SC:GetRealAddonName(addonName)) then
                    missingAddonDetected = true
                    break
                end
            end
        end

        -- Addon not loaded or missing
        if missingAddonDetected and not SkillCappedDB.completedSetup then
            AddTooltip2(installBtn, "Missing Addon       ", "One or more addons are disabled/missing.\n\nYou will need to either enable or download these addons to install profiles for them.\n\nAfter enabling/installing missing addons, right-click the install button to reload your UI.", "ANCHOR_TOP", parentFrame)
            if not installBtn.reloadHook then
                installBtn:HookScript("OnMouseDown", function(self, button)
                    if button == "RightButton" then
                        SkillCappedDB.reOpenToAddonConfig = true
                        ReloadUI()
                    end
                end)
                installBtn.reloadHook = true
            end
        end

        local separatorLine = parentFrame:CreateTexture(nil, "OVERLAY")
        separatorLine:SetAtlas("AftLevelup-GlowLine")
        separatorLine:SetPoint("TOPLEFT", checkboxes["EditMode"..contentType], "BOTTOMLEFT", -5, 1)
        separatorLine:SetSize(135, 10)
        separatorLine:SetDesaturated(true)
        separatorLine:SetVertexColor(0.482, 0.643, 0.988)

        -- for addonName, cb in pairs(checkboxes) do
        --     CheckboxWillGetUpdated(cb, addonName)
        -- end

        parentFrame:Show()
        SkillCappedTutorial.installStepCreated[contentType] = true
    end

    -- #####################################
    -- Step 3
    -- #####################################

    local installStep = CreateFrame("Frame", nil, SkillCappedTutorial)
    installStep:SetAllPoints(installSelectFrame)
    installStep:Hide()
    SkillCappedTutorial.installStep = installStep


    function SC:CreatePreInstallStep(stepType, parentFrame)
        if SkillCappedTutorial.installStepCreated[stepType] then
            parentFrame:Show()
            return
        end
        parentFrame:Show()
        SkillCappedTutorial.installStepCreated[stepType] = true
    end

    function SC:AltReloadPage()
        SC.AltActive = true
        addonProfiles:Hide()
        SC:ShowCurrentStep(0)
        installSelectFrame:Show()
        reloadReqBtn:Hide()

        local extraTxt = ""
        local buttonTxt = "Reload UI"
        local windowHeight = 280
        local two
        -- if SkillCappedDB.secondaryContent ~= "None" then
        --     extraTxt = "\n\nThis is a 2 step process."
        --     buttonTxt = "Continue"
        --     windowHeight = 330
        --     two = true
        -- end
        installSelectFrame:SetSize(400,windowHeight)

        if not SkillCappedTutorial.altReloadMsg then
            local altReload = CreateFrame("Frame", nil, installSelectFrame)
            altReload:SetAllPoints(installSelectFrame)

            local titleText = altReload:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            titleText:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -10)
            titleText:SetText("|cff7ba4fcNew character detected!|r")
            titleText:SetFont(scFont, 22)

            local infoText = altReload:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            infoText:SetPoint("TOP", titleText, "BOTTOM", 0, -10)
            infoText:SetWidth(altReload:GetWidth() - 110)
            infoText:SetText("Please click '"..buttonTxt.."' to enable the Skill Capped UI on this character."..extraTxt.."\n\nThis is only required when logging onto a character for the first time.")
            infoText:SetFont(scFont, 11)
            infoText:SetTextColor(1, 1, 1, 1)

            SkillCappedTutorial.altReload = altReload
            SkillCappedTutorial.altReloadMsg = infoText
        end
        SkillCappedTutorial.altReload:Show()


        -- if SkillCappedDB.secondaryContent ~= "None" then
        --     if not installSelectFrame.altReloadStatusBar then
        --         local progressBar = CreateFrame("StatusBar", nil, SkillCappedTutorial.installSelectFrame, "BackdropTemplate")
        --         Mixin(progressBar, SmoothStatusBarMixin)

        --         progressBar:SetSize(160, 22)
        --         progressBar:SetPoint("TOP", SkillCappedTutorial.altReloadMsg, "BOTTOM", 0, -20)
        --         progressBar:SetStatusBarTexture("Interface\\AddOns\\SkillCapped\\media\\smooth.tga")

        --         progressBar:SetStatusBarColor(0.482, 0.643, 0.988)
        --         progressBar:SetMinMaxSmoothedValue(0, 2)
        --         progressBar:SetSmoothedValue(1)

        --         local border = CreateFrame("Frame", nil, progressBar, "BackdropTemplate")
        --         border:SetPoint("TOPLEFT", progressBar, "TOPLEFT", -3, 3)
        --         border:SetPoint("BOTTOMRIGHT", progressBar, "BOTTOMRIGHT", 3, -3)
        --         border:SetBackdrop({
        --             bgFile = "Interface\\Buttons\\WHITE8x8",
        --             edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        --             edgeSize = 13,
        --         })
        --         border:SetBackdropColor(0, 0, 0, 0)
        --         border:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
        --         border:SetFrameLevel(progressBar:GetFrameLevel() + 10)

        --         local progressText = progressBar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        --         progressText:SetPoint("CENTER", progressBar, "CENTER", 0, 0)
        --         progressText:SetText("1/2")
        --         installSelectFrame.altReloadStatusBar = progressBar
        --     end
        -- end

        finishInstallReloadBtn:ClearAllPoints()
        finishInstallReloadBtn:SetPoint("TOP", installSelectFrame.altReloadStatusBar or SkillCappedTutorial.altReloadMsg, "BOTTOM", 0, two and -9 or -13)
        finishInstallReloadBtn:Show()
        finishInstallReloadBtn.Text:SetText(buttonTxt)

        exitButton:SetAlpha(0)
        C_Timer.After(40, function()
            FadeFrameAlpha(exitButton, 0, 1, 3)
        end)

        installBtn:Hide()
        for _, cb in pairs(checkboxes) do
            cb:EnableMouse(false)
            cb:Hide()
            if cb.overlay then
                cb.overlay:Hide()
            end
        end
    end

    function SC:AltSecondReloadPage()
        SC.AltSecondReloadActive = true
        addonProfiles:Hide()
        SC:ShowCurrentStep(0)
        installSelectFrame:Show()
        reloadReqBtn:Hide()

        if not SkillCappedTutorial.altReloadMsg then
            local altReload = CreateFrame("Frame", nil, installSelectFrame)
            altReload:SetAllPoints(installSelectFrame)

            -- Title text
            local titleText = altReload:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            titleText:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -10)
            titleText:SetText("|cff7ba4fcAlmost there!|r")
            titleText:SetFont(scFont, 22)

            local infoText = altReload:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            infoText:SetPoint("TOP", titleText, "BOTTOM", 0, -10)
            infoText:SetWidth(altReload:GetWidth() - 110)
            infoText:SetText("Please click 'Finish' to complete the Skill-Capped UI setup on this character.\n\nThis is only required when logging onto a character for the first time.")
            infoText:SetFont(scFont, 11)
            infoText:SetTextColor(1, 1, 1, 1)

            SkillCappedTutorial.altReload = altReload
            SkillCappedTutorial.altReloadMsg = infoText
        end
        SkillCappedTutorial.altReload:Show()

        if not installSelectFrame.altReloadStatusBar then
            local progressBar = CreateFrame("StatusBar", nil, SkillCappedTutorial.installSelectFrame, "BackdropTemplate")
            Mixin(progressBar, SmoothStatusBarMixin)

            progressBar:SetSize(160, 22)
            progressBar:SetPoint("TOP", SkillCappedTutorial.altReloadMsg, "BOTTOM", 0, -20)
            progressBar:SetStatusBarTexture("Interface\\AddOns\\SkillCapped\\media\\smooth.tga")

            progressBar:SetStatusBarColor(0.482, 0.643, 0.988)
            progressBar:SetMinMaxSmoothedValue(0, 2)
            progressBar:SetSmoothedValue(2)

            local border = CreateFrame("Frame", nil, progressBar, "BackdropTemplate")
            border:SetPoint("TOPLEFT", progressBar, "TOPLEFT", -3, 3)
            border:SetPoint("BOTTOMRIGHT", progressBar, "BOTTOMRIGHT", 3, -3)
            border:SetBackdrop({
                bgFile = "Interface\\Buttons\\WHITE8x8",
                edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                edgeSize = 13,
            })
            border:SetBackdropColor(0, 0, 0, 0)
            border:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
            border:SetFrameLevel(progressBar:GetFrameLevel() + 10)

            local progressText = progressBar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            progressText:SetPoint("CENTER", progressBar, "CENTER", 0, 0)
            progressText:SetText("2/2")
            installSelectFrame.altReloadStatusBar = progressBar
        end

        finishInstallReloadBtn:ClearAllPoints()
        finishInstallReloadBtn:SetPoint("TOP", installSelectFrame.altReloadStatusBar, "BOTTOM", 0, -8)
        finishInstallReloadBtn:Show()
        finishInstallReloadBtn.Text:SetText("Finish!")

        exitButton:SetAlpha(0)
        C_Timer.After(40, function()
            FadeFrameAlpha(exitButton, 0, 1, 3)
        end)

        installBtn:Hide()
        installSelectFrame:SetSize(400,305)
        for _, cb in pairs(checkboxes) do
            cb:EnableMouse(false)
            cb:Hide()
            if cb.overlay then
                cb.overlay:Hide()
            end
        end
    end

    function SC:UndoAltReloadPage()
        installSelectFrame:SetSize(360,400)
        addonProfiles:Show()
        installSelectFrame:Show()
        finishInstallReloadBtn:ClearAllPoints()
        finishInstallReloadBtn:SetPoint("RIGHT", installSelectFrame, "RIGHT", -70, -17)
        finishInstallReloadBtn:Hide()
        installBtn:Show()

        for _, cb in pairs(checkboxes) do
            cb:EnableMouse(true)
            cb:Show()
            if cb.overlay then
                cb.overlay:Show()
            end
        end
    end

    function SC:ReadyInstallationFrame()
        SkillCappedTutorial:Show()
        installSelectFrame:Show()
        SkillCappedTutorial.step = SkillCappedDB.reOpenToStep or 1
        SC:ShowCurrentStep(SkillCappedTutorial.step)
        for _, checkbox in pairs(checkboxes) do
            checkbox:EnableMouse(true)
        end
        FadeFrameAlpha(installSelectFrame, 0, 1, 0.2)
    end

    SC:ReadyInstallationFrame()

    if not SkillCappedDB.completedSetup and not SkillCappedDB.backupRestored and not SkillCappedDB.forcedReloadComplete then
        local needsReload = SC:ToggleAddons()
        if needsReload then

            function SC:PrepRequiredReloadState()
                installBtn:Hide()
                addonProfiles:Hide()
                SkillCappedTutorial.stepOne:Hide()
                if not SkillCappedTutorial.welcomeMsg then
                    -- Title text
                    local titleText = installSelectFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                    titleText:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -13)
                    titleText:SetText("|cff7ba4fcWelcome to the Skill-Capped UI!|r")
                    titleText:SetFont(scFont, 20)

                    local infoText = installSelectFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                    infoText:SetPoint("TOP", titleText, "BOTTOM", 0, -14)
                    infoText:SetWidth(installSelectFrame:GetWidth() - 120)
                    infoText:SetText("To ensure a smooth installation, we'll need to prepare your addon list.\n\nPlease click 'Continue' to reload your UI and load in the necessary addons for setup.")
                    infoText:SetFont(scFont, 11)
                    infoText:SetTextColor(1, 1, 1, 1)

                    exitButton:HookScript("OnClick", function()
                        SkillCappedDB.forcedReloadComplete = false
                        SC:RestoreAddonStates()
                        if not SkillCappedDB.completedSetup then
                            SkillCappedDB.initialAddonStates = {}
                        end
                    end)

                    SkillCappedTutorial.welcomeMsg = infoText
                end

                installSelectFrame:SetSize(360,270)
                SC:ShowCurrentStep(0)
                SkillCappedTutorial:ClearAllPoints()
                SkillCappedTutorial:SetPoint("TOP", UIParent, "TOP", 0, yOffset+50)

                reloadReqBtn:ClearAllPoints()
                reloadReqBtn:SetPoint("TOP", SkillCappedTutorial.welcomeMsg, "BOTTOM", 0, -15)
                reloadReqBtn:Show()
                reloadReqBtn:SetWidth(75)
                reloadReqBtn:SetHeight(24)
                reloadReqBtn:SetText("Continue")
                reloadReqBtn:SetScript("OnEnter", nil)
                reloadReqBtn:SetScript("OnClick", function()
                    SkillCappedDB.reOpenToAddonConfig = true
                    SC:ApplyAddonChanges()
                    ReloadUI()
                end)

                exitButton:SetAlpha(0)
                C_Timer.After(50, function()
                    FadeFrameAlpha(exitButton, 0, 1, 3)
                end)

                SkillCappedTutorial.requiredReload = true
            end

            SC:PrepRequiredReloadState()
        end
    end

    function SC:LoadingFrame()
        for _, cb in pairs(checkboxes) do
            cb:EnableMouse(false)
            cb:Hide()
            if cb.overlay then
                cb.overlay:Hide()
            end
        end
        --separatorLine:Hide()
        exitButton:Hide()
        addonProfiles:Hide()
        reloadReqBtn:Hide()
        installBtn:Hide()
        reloadReadyText:ClearAllPoints()
        reloadReadyText:SetPoint("BOTTOM", installSelectFrame, "BOTTOM", 0, 110)
        reloadReadyText:Show()
        reloadReadyText:SetFont(scFont, 45, "THICKOUTLINE")
        reloadReadyText:SetText("Installing")

        if not SkillCappedTutorial.hiddenUI then
            SC:HideUIShowTutorial()
        end

        installSelectFrame:SetSize(360,330)
        SkillCappedTutorial:ClearAllPoints()
        SkillCappedTutorial:SetPoint("TOP", UIParent, "TOP", 0, yOffset+35)

    end

    function SC:RepositionWeakAuras()
        if not WeakAurasOptions then return end
        --WeakAurasOptions:SetSize(570,400)
        --installSelectFrame:SetSize(360,345)
        --WeakAurasOptions:ClearAllPoints()
        --WeakAurasOptions:SetPoint("BOTTOMRIGHT", installSelectFrame, "BOTTOMRIGHT", 0, 0)
    end

    function SC:ChangeLoadingText()
        local dotCount = 0
        local maxDots = 4
        local elapsedTime = 0

        if not self.reloadReadyDots then
            self.reloadReadyDots = installSelectFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
            self.reloadReadyDots:SetFont(scFont, 45, "THICKOUTLINE")
            self.reloadReadyDots:SetPoint("BOTTOMLEFT", reloadReadyText, "BOTTOMRIGHT", -3, 0)
        end

        if not self.loadingTextFrame then
            self.loadingTextFrame = CreateFrame("Frame")
        end

        -- OnUpdate script to cycle dots from 0 to 3
        self.loadingTextFrame:SetScript("OnUpdate", function(_, delta)
            elapsedTime = elapsedTime + delta
            if elapsedTime >= 0.6 then  -- Update every 0.5 seconds
                dotCount = (dotCount + 1) % maxDots  -- Cycle through 0, 1, 2, 3
                self.reloadReadyDots:SetText(string.rep(".", dotCount))  -- Update dots display
                elapsedTime = 0
            end
        end)

        -- Positioning of WeakAuras, if needed
        if SkillCappedTutorial then
            SC:RepositionWeakAuras()
        else
            SC:CenterWeakAuras()
        end
    end


    function SC:PrepReloadFrame()
        SC:HideFakeUI()
        --separatorLine:Hide()

        if self.reloadReadyDots then
            self.reloadReadyDots:SetText("")
            self.loadingTextFrame:SetScript("OnUpdate", nil)
        end
        installSelectFrame:SetSize(360,260)
        SkillCappedTutorial.weakAuraProgressBar:Hide()

        -- Additional information text
        local infoText = installSelectFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        infoText:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -20)
        infoText:SetWidth(installSelectFrame:GetWidth())
        infoText:SetText("Your new UI is ready!")
        infoText:SetFont(scFont, 26)
        infoText:SetTextColor(1, 1, 1, 1)

        local infoText2 = installSelectFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        infoText2:SetPoint("TOP", infoText, "BOTTOM", 0, -12)
        infoText2:SetWidth(installSelectFrame:GetWidth() - 120)
        infoText2:SetText("Please click 'Finish!' to complete the installation.")
        infoText2:SetFont(scFont, 13)
        infoText2:SetTextColor(1, 1, 1, 1)

        finishInstallReloadBtn:ClearAllPoints()
        finishInstallReloadBtn:SetPoint("TOP", infoText2, "BOTTOM", 0, -15)
        finishInstallReloadBtn:Show()
        finishInstallReloadBtn:SetScale(1.1)
        finishInstallReloadBtn.Text:SetText("Finish!")

        SkillCappedTutorial.waLoadingText:Hide()

        SkillCappedTutorial:ClearAllPoints()
        SkillCappedTutorial:SetPoint("TOP", UIParent, "TOP", 0, yOffset+50)

        reloadReadyText:SetText("")
        installBtn:Hide()
        for _, cb in pairs(checkboxes) do
            cb:EnableMouse(false)
            cb:Hide()
            if cb.overlay then
                cb.overlay:Hide()
            end
        end
    end

    function SC:GoInstall()
        local db = SkillCappedDB
        SC:ShowFakeUI()

        -- PvE disabled: ensure all PvE checkboxes are unchecked
        for addonName, cb in pairs(pveCheckboxes) do
            cb:SetChecked(false)
        end

        if SkillCappedTutorial["PvEIgnoreWindow"] then
            SkillCappedTutorial["PvEIgnoreWindow"]:Hide()
        end
        if SkillCappedTutorial["PvPIgnoreWindow"] then
            SkillCappedTutorial["PvPIgnoreWindow"]:Hide()
        end

        for addonName, cb in pairs(checkboxes) do
            if cb:IsEnabled() and cb:IsShown() and cb:GetChecked() then
                db.enabledAddons[addonName] = true
                db["profileUpdates"][addonName] = newUpdates[addonName]
                SC:EnsureAddonInSet(addonName)
                if addonName == "ArcUI" then
                    SC.ArcUIEnabled = true
                end
            else
                if addonIsNot("EditMode", addonName) and addonIsNot("CooldownManager", addonName) then
                    if not cb.missingLFAddon then
                        db.enabledAddons[addonName] = nil
                    end
                end
            end
            if cb.uninstall then
                db.enabledAddons[addonName] = nil
                -- if addonName == "WeakAurasPvE" then
                --     db.pveWeakauras = nil
                --     SkillCappedBackupDB["WeakAurasPvE"] = nil
                -- end
                -- if addonName == "WeakAurasPvP" then
                --     db.pvpWeakauras = nil
                --     SkillCappedBackupDB["WeakAurasPvP"] = nil
                -- end

                local dbName = SC.addonDatabaseMap[addonName]
                local dbName2 = SC.addonDatabaseMap[SC:GetRealAddonName(addonName)]
                if dbName then
                    SkillCappedBackupDB[dbName] = nil
                    if SkillCappedBackupDB.addonBackupTimes then
                        SkillCappedBackupDB.addonBackupTimes[dbName] = nil
                        SkillCappedBackupDB.addonBackupTimes[addonName] = nil
                        SkillCappedBackupDB.addonBackupTimes[SC:GetRealAddonName(addonName)] = nil
                    end
                end
                if dbName2 then
                    SkillCappedBackupDB[dbName2] = nil
                    if SkillCappedBackupDB.addonBackupTimes then
                        SkillCappedBackupDB.addonBackupTimes[dbName2] = nil
                        SkillCappedBackupDB.addonBackupTimes[addonName] = nil
                        SkillCappedBackupDB.addonBackupTimes[SC:GetRealAddonName(addonName)] = nil
                    end
                end
            end
        end

        db.dontShowWeakAuraUpdateMessage = nil
        db.dontShowTalentUpdateMessage = nil
        db.firstLaunchAfterUpdate = nil

        SkillCappedDB.mainContent = SkillCappedTutorial.mainContent
        SkillCappedDB.characters[SC:GetPlayerNameAndRealm()] = SkillCappedDB.mainContent
        SkillCappedDB.secondaryContent = SkillCappedTutorial.secondaryContent

        -- Check the state of the EditMode checkboxes and nil the respective sets
        if checkboxes["EditModePvP"] and checkboxes["EditModePvP"]:GetChecked() then
            SkillCappedDB.cvarSets["SkillCapped PvP"] = nil
            SkillCappedDB.editmodeSets["SkillCapped PvP"] = nil
        end
        -- PvE disabled
        --if checkboxes["EditModePvE"] and checkboxes["EditModePvE"]:GetChecked() then
        --    SkillCappedDB.cvarSets["SkillCapped PvE"] = nil
        --    SkillCappedDB.editmodeSets["SkillCapped PvE"] = nil
        --end

        -- Reset CDM processed flag so ForceImport can run again
        SC.processedCooldownManager = nil

        if TalentTreeTweaksDB and TalentTreeTweaksDB["moduleDb"] then
            TalentTreeTweaksDB["moduleDb"]["ScaleTalentFrame"] = {
                ["scale"] = 0.9,
            }
        end

        if VWQL then
            VWQL["DisableLFG"] = true
        end

        SC:InstallSelectedAddonPresets()

        SC:ShowCurrentStep(0)
        SkillCappedTutorial.NextButton:Hide()
        SkillCappedTutorial.BackButton:Hide()

        local lookAndFeelSettingsMap = {
            ["Class Icon Portraits"] = function(isEnabled) SkillCappedDB.ReplaceMyPlayerPortrait = isEnabled and "1" or nil end,
            --["Combined Bags"] = function(isEnabled) SkillCappedDB.combinedBags = isEnabled and "1" or nil end,
            ["Fade Menu & Bags"] = function(isEnabled) SkillCappedDB.fadeMicroMenu = isEnabled and true or nil end,
            -- ["Hide PvE WA's in PvP"] = function(isEnabled) SkillCappedDB.hidePvEWeakAurasInPvP = isEnabled and true or false end,
            -- ["Hide PvP WA's in PvE"] = function(isEnabled) SkillCappedDB.hidePvPWeakAurasInPvE = isEnabled and true or false end,
            -- ["Hide Class Power (PvE)"] = function(isEnabled) SkillCappedDB.hidePlayerPower = isEnabled and true or nil end,
            ["Fade Status/XP Bar"] = function(isEnabled) SkillCappedDB.fadeStatusBar = isEnabled and true or nil end,
            ["Hide Error Frame"] = function(isEnabled) SkillCappedDB.hideErrorFrame = isEnabled and true or nil end,
            ["Hide Hit Indicator"] = function(isEnabled) SkillCappedDB.hideHitIndicator = isEnabled and true or nil end,
            ["New Fonts"] = function(isEnabled) SkillCappedDB.newFonts = isEnabled and true or nil end,
            ["Player Elite Frame"] = function(isEnabled) SkillCappedDB.playerElite = isEnabled and true or nil end,
            ["Queue Pop Notification"] = function(isEnabled) SkillCappedDB.queuePopNotification = isEnabled and true or nil end,
            ["Smart Tab Targeting"] = function(isEnabled) SkillCappedDB.smartTabTargeting = isEnabled and true or nil end,
            --["Resize Talents & Spellbook"] = function(isEnabled) SkillCappedDB.reducedTalentFrameSize = isEnabled and true or nil end,
        }

        for addonName, cb in pairs(lookAndFeelCheckboxes) do
            local isEnabled = cb:GetChecked()
            local updateFunc = lookAndFeelSettingsMap[addonName]
            if updateFunc then
                updateFunc(isEnabled)
            end
        end

        -- if SC:UpdateWeakAurasIfChecked() then
        --     if SC:IsAddonLoaded("WeakAuras") then
        --         if not SC:IsAddonLoaded("WeakAurasOptions") then
        --             C_AddOns.EnableAddOn("WeakAurasOptions")
        --             C_AddOns.LoadAddOn("WeakAurasOptions")
        --         end
        --         if SC:IsAddonLoaded("WeakAurasOptions") then
        --             -- SkillCappedWeakAurasDB = {}
        --             -- Track PvP Weakauras
        --             if SC:WeakAuraCheckboxEnabled("PvP") then
        --                 SkillCappedDB.pvpWeakauras = true
        --             end

        --             -- Track PvE Weakauras for selected classes
        --             if SC:WeakAuraCheckboxEnabled("PvE") then
        --                 SC:EnsureAddonInSet("CauseseDB")
        --                 if not SkillCappedDB.pveWeakauras then
        --                     SkillCappedDB.pveWeakauras = {}
        --                 end
        --                 -- Track the selected classes for PvE
        --                 for _, className in ipairs(SkillCappedTutorial.weakauraClasses) do
        --                     SkillCappedDB.pveWeakauras[className] = true
        --                     SkillCappedDB["profileUpdates"][className] = newUpdates[className]
        --                 end
        --             end
        --             if SkillCappedTutorial.ignoredWeakAuras then
        --                 SkillCappedDB.ignoredWeakAuras = {}
        --                 for waName, _ in pairs(SkillCappedTutorial.ignoredWeakAuras) do
        --                     SkillCappedDB.ignoredWeakAuras[waName] = true
        --                 end
        --             end
        --             SC:LoadingFrame()
        --             SC:CheckAndUpdateWeakAuras(true)
        --         else
        --             C_AddOns.EnableAddOn("WeakAuras")
        --             C_AddOns.EnableAddOn("WeakAurasOptions")
        --             SkillCappedDB.WeakAurasNotFound = true

        --             SC:LoadAddonSet(SkillCappedDB.mainContent)
        --         end
        --     else
        --         C_AddOns.EnableAddOn("WeakAuras")
        --         C_AddOns.EnableAddOn("WeakAurasOptions")
        --         SkillCappedDB.WeakAurasNotFound = true
        --         SC:LoadAddonSet(SkillCappedDB.mainContent)
        --         --ReloadUI()
        --     end
        -- else
            SC:FinishInstall()
        --end
    end

    function SC:FinishInstall()
        SC:ShowFakeUI()
        --SC.setupActive = false
        SkillCappedDB.backupRestored = nil
        local playerNameAndRealm = SC:GetPlayerNameAndRealm()
        SkillCappedDB.characters[playerNameAndRealm] = SkillCappedDB.mainContent or "PvP"
        SkillCappedDB.completedSetup = true
        SkillCappedDB.newPvEUpdate = nil
        SkillCappedDB.midnightInitialized = true
        SkillCappedDB.newAddOns1 = true -- avoid re-adding new addons for new users

        -- Temporarily make sure ArcUI is disabled when user installs
        -- because many users enable it unintentionally and get confused.
        -- Remove when ArcUI profile is finished.
        if not SkillCappedDB.WeakAura then
            SC:RemoveAddonFromSet("ArcUI", "SkillCapped PvP")
            C_AddOns.DisableAddOn("ArcUI")
        end
        SC:EnsureAddonInSet("SkillCapped")

        if SC.AltActive then
            --SC:UpdateEnabledAddons()
            -- if SkillCappedDB.secondaryContent ~= "None" then
            --     SkillCappedDB.altCharSecondReload = true
            --     SkillCappedDB.reOpenToAddonConfig = true
            --     SC:LoadAddonSet("All")
            -- else
                SC:UpdateEnabledAddons()
                SC:LoadAddonSet(SkillCappedDB.mainContent)
            --end
        elseif SC.AltSecondReloadActive then
            SC:UpdateEnabledAddons()
            SkillCappedDB.altCharSecondReload = nil
            SkillCappedDB.reOpenToAddonConfig = nil
            SC:LoadAddonSet(SkillCappedDB.mainContent)
        else
            SC:LoadAddonSet(SkillCappedDB.mainContent)
        end
    end

    installBtn:SetScript("OnClick", function()
        PlaySound(1115)
        if InCombatLockdown() then
            SC:Print("Leave combat to continue installation. Make sure you are out of combat while installing.")
            return
        end

        installBtn:SetScript("OnEnter", nil)
        installBtn:SetScript("OnLeave", nil)
        installGlowCenter:Hide()
        installGlowLeft:Hide()
        installGlowRight:Hide()

        local missingAddonDetected
        local mainContentType = SkillCappedTutorial.mainContent
        local secondaryContentType = SkillCappedTutorial.secondaryContent

        -- Function to check addons for a given content type
        local function CheckAddonsForContentType(contentType)
            local addonList = "pvpAddonList"--contentType == "PvP" and "pvpAddonList" or "pveAddonList"
            local scAddonList = "pvpSkillCappedAddonList"--contentType == "PvP" and "pvpSkillCappedAddonList" or "pveSkillCappedAddonList"

            -- Check if any required addons are missing for the given content type
            for _, addonName in ipairs(SC:GetAddonList(addonList)) do
                if not SC:IsAddonLoaded(addonName) then
                    missingAddonDetected = true
                    break
                end
            end

            -- Check for additional Skill-Capped PvP or PvE-specific addons
            if SkillCappedDB.WeakAura then
                for _, addonName in ipairs(SC:GetAddonList(scAddonList)) do
                    if not SC:IsAddonLoaded(addonName) then
                        if addonName ~= "ArcUI" or (addonName == "ArcUI" and not SkillCappedDB.WeakAura) then
                            missingAddonDetected = true
                        end
                        break
                    end
                end
            end
        end

        -- Check mainContentType addons
        CheckAddonsForContentType(mainContentType)
        -- Check secondaryContentType addons if it's not "None"
        -- if secondaryContentType ~= "None" then
        --     CheckAddonsForContentType(secondaryContentType)
        -- end
        SkillCappedDB.reOpenToAddonConfig = nil

        -- Addon not loaded or missing
        if missingAddonDetected and not SkillCappedDB.completedSetup then
            local anyChecked = false
            for addonName, cb in pairs(checkboxes) do
                if SkillCappedDB.WeakAura then
                    if cb:GetChecked() then
                        anyChecked = true
                        break
                    end
                else
                    if addonName ~= "ArcUI" then
                        if cb:GetChecked() then
                            anyChecked = true
                            break
                        end
                    end
                end
            end

            --if anyChecked then
                StaticPopup_Show("SC_WARN_ADDON")
                SetUpPopupProperties()
            -- else
            --     StaticPopup_Show("SC_NOT_SELECTED")
            --     SetUpPopupProperties()
            -- end
        else
            local anyChecked = false
            for addonName, cb in pairs(checkboxes) do
                if SkillCappedDB.WeakAura then
                    if cb:GetChecked() then
                        anyChecked = true
                        break
                    end
                else
                    if addonName ~= "ArcUI" then
                        if cb:GetChecked() then
                            anyChecked = true
                            break
                        end
                    end
                end
            end

            --if anyChecked then
                -- if SC:WeakAuraCheckboxEnabled("PvE") then
                --     local noPvEWeakauraSelected = true
                --     for _, cb in pairs(waCheckboxes) do
                --         if cb:GetChecked() then
                --             noPvEWeakauraSelected = false
                --             break
                --         end
                --     end
                --     if noPvEWeakauraSelected then
                --         StaticPopup_Show("SC_WARN_WEAKAURA")
                --         SetUpPopupProperties()
                --     else
                --         SC:GoInstall()
                --     end
                -- else
                    SC:GoInstall()
                --end
            -- else
            --     StaticPopup_Show("SC_NOT_SELECTED")
            --     SetUpPopupProperties()
            -- end
        end

        if GameTooltip:IsShown() then
            GameTooltip:Hide()
        end
    end)


    SC:RestoreCheckboxStates()

    if not SkillCappedDB.completedSetup and not SkillCappedDB.backupRestored then
        exitButton:SetAlpha(0)
        C_Timer.After(25, function()
            FadeFrameAlpha(exitButton, 0, 1, 3)
        end)
    end
end


local SkillCappedBlizzard
function SC:CreateBlizzGUI()
    if SkillCappedBlizzard then
        --open to etc
        return
    end

    SkillCappedBlizzard = CreateFrame("Frame")
    SkillCappedBlizzard.name = coloredAddonName

    local frame = CreateFrame("Frame", nil, SkillCappedBlizzard)
    frame:SetPoint("CENTER", SkillCappedBlizzard, "CENTER", -6, 3)
    frame:SetSize(685, 611)

    local addonConfigBanner = MakeBanner(frame, SkillCappedBlizzard, 30)

    local frameBg = frame:CreateTexture(nil, "BACKGROUND")
    frameBg:SetColorTexture(0, 0, 0, 0.6)
    frameBg:SetAllPoints(frame)

    local profilesHeader = CreateHeader("Profiles", frame, 10)
    profilesHeader:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -10)

    local profileDesc = frame:CreateFontString(nil, "OVERLAY")
    profileDesc:SetFont(scFont, 11)
    profileDesc:SetText("Set all selected addon profiles to the Skill-Capped one. You will not lose your settings.")
    profileDesc:SetPoint("TOPLEFT", profilesHeader, "BOTTOMLEFT", 5, -6)

    local updateAltProfileBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    updateAltProfileBtn:SetText("Set Profiles")
    updateAltProfileBtn:SetWidth(125)
    updateAltProfileBtn:SetPoint("TOPLEFT", profileDesc, "BOTTOMLEFT", 0, -5)
    updateAltProfileBtn:SetScript("OnClick", function()
        if SkillCappedDB.completedSetup then
            SC:UpdateEnabledAddons()
            SC:LoadAddonSet(SkillCappedDB.mainContent)
            --PlaySound(1115)
            --ReloadUI()
        else
            SC:Print("You have no presets installed. Please use the setup button to install presets.")
        end
    end)
    updateAltProfileBtn:SetScale(0.95)
    updateAltProfileBtn.Text:SetFont(scFont, 12)
    AddTooltip2(updateAltProfileBtn, "Set Profiles", "This will set the active profiles of all currently installed addon presets to the Skill-Capped one.\n\nClick this if a profile did not get set correctly or you want all profiles back to Skill-Capped. (Reloads UI)\n(It only sets the profile, settings are safe!).", nil, frame)

    local hotswapHeader = CreateHeader("UI Mode", frame, 10)
    hotswapHeader:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -100)

    local hotswapDesc = frame:CreateFontString(nil, "OVERLAY")
    hotswapDesc:SetFont(scFont, 11)
    hotswapDesc:SetText("Toggle between PvE and PvP UI.")
    hotswapDesc:SetPoint("TOPLEFT", hotswapHeader, "BOTTOMLEFT", 5, -6)
    local mainUI = SkillCappedDB.mainContent or "PvP"
    local otherUI = SkillCappedDB.secondaryContent or ((mainUI == "PvP") and "PvE" or "PvP")
    local buttonText = "Swap to "..otherUI.." UI"
    --if otherUI == "None" then
    --    buttonText = "No Secondary UI"
    --end
    local swapUIBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    swapUIBtn:SetText(buttonText)
    swapUIBtn:SetWidth(125)
    swapUIBtn:SetPoint("TOPLEFT", hotswapDesc, "BOTTOMLEFT", 0, -5)
    swapUIBtn:SetScript("OnClick", function()
        SC:SwapContentMode()
    end)
    swapUIBtn:SetScale(0.95)
    swapUIBtn.Text:SetFont(scFont, 12)
    AddTooltip2(swapUIBtn, "", "", nil, frame, true)
    --if otherUI == "None" or SkillCappedDB.secondaryContent == nil then
    --    swapUIBtn:Disable()
    --    C_Timer.After(1, function()
    --        swapUIBtn:Disable()
    --    end)
    --    local buttonOverlay = CreateFrame("Frame", nil, frame)
    --    buttonOverlay:SetAllPoints(swapUIBtn)
    --    buttonOverlay:SetFrameStrata("HIGH")
    --    AddTooltip2(buttonOverlay, "No Secondary UI", "Install the PvE UI to be able to toggle between the two UI modes.")
    --end

    -- local addonListHeader = CreateHeader("AddOn Lists", frame, 10)
    -- addonListHeader:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -190)

    -- local addonListDesc = frame:CreateFontString(nil, "OVERLAY")
    -- addonListDesc:SetFont(scFont, 11)
    -- addonListDesc:SetText("Changes which addons load in PvP and PvE mode. This does not effect profiles.")
    -- addonListDesc:SetPoint("TOPLEFT", addonListHeader, "BOTTOMLEFT", 5, -6)

    local mainContentIconAtlas = SkillCappedDB.mainContent == "PvP" and "|A:countdown-swords:16:16|a" or "|A:Dungeon:22:22|a"
    StaticPopupDialogs["SC_SAVE_ADDONLIST"] = {
        text = SC.Logo.."\n\nThis will save your current addon list\nto the "..mainUI.." UI"..mainContentIconAtlas.."\n\nAll currently enabled addons will load when swapping to the "..mainUI.." UI"..mainContentIconAtlas.."\n\nAre you sure you want to continue?",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            SC:SaveEnabledAddonsSet(mainUI)
            SC:Print("Your current enabled addons have been saved to the "..SkillCappedDB.mainContent.." preset!")
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }
    -- local saveCurrentAddonList = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    -- saveCurrentAddonList:SetText("Save AddOns")
    -- saveCurrentAddonList:SetWidth(125)
    -- saveCurrentAddonList:SetPoint("TOPLEFT", addonListDesc, "BOTTOMLEFT", 0, -5)
    -- saveCurrentAddonList:SetScript("OnClick", function()
    --     StaticPopup_Show("SC_SAVE_ADDONLIST")
    -- end)
    -- saveCurrentAddonList:SetScale(0.95)
    -- saveCurrentAddonList.Text:SetFont(scFont, 12)
    -- AddTooltip2(saveCurrentAddonList, "Save Enabled Addon List to "..mainUI.." UI "..mainContentIconAtlas, "You can use this button to change the addons that are loaded in the UI you currently have active ("..mainUI..").\n\nSimply enable/disable the addons you want to load in the active UI and then click this button.", nil, frame)


    StaticPopupDialogs["SC_DEFAULT_ADDONLIST"] = {
        text = SC.Logo.."\n\nThis will restore the default "..mainUI..mainContentIconAtlas.."addon list preset that comes with the SkillCapped addon.\n\nAre you sure you want to continue?",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            SC:RestoreDefaultAddonSet(mainUI)
            ReloadUI()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }
    -- local restoreDefaultAddonList = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    -- restoreDefaultAddonList:SetText("Default AddOns")
    -- restoreDefaultAddonList:SetWidth(125)
    -- restoreDefaultAddonList:SetPoint("TOPLEFT", saveCurrentAddonList, "BOTTOMLEFT", 0, -5)
    -- restoreDefaultAddonList:SetScript("OnClick", function()
    --     StaticPopup_Show("SC_DEFAULT_ADDONLIST")
    -- end)
    -- restoreDefaultAddonList:SetScale(0.95)
    -- restoreDefaultAddonList.Text:SetFont(scFont, 12)
    -- AddTooltip2(restoreDefaultAddonList, "Restore Default Addon List for "..mainUI.." UI "..mainContentIconAtlas, "Click this button to restore the active UI addon list back to the way it was when you first installed.", nil, frame)

    local mainContentIconDetails = {
        ["PvP"] = { atlas = "countdown-swords", size = {22, 22}, offset = {2, 1} },
        ["PvE"] = { atlas = "Dungeon", size = {35, 35}, offset = {0, 1} },
    }
    local mainContent = SkillCappedDB.mainContent or "PvP"
    local iconDetails = mainContentIconDetails[mainContent]

    local firstText = AddonList:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    firstText:SetPoint("TOPLEFT", AddonList, "BOTTOMLEFT", 12, -8)
    firstText:SetText("|TInterface/AddOns/SkillCapped/media/icon64.tga:12:12:0:0|t" .. coloredAddonName .. " " .. mainContent)
    firstText:SetFont(scFont, 18)

    local contentIcon = AddonList:CreateTexture(nil, "OVERLAY")
    contentIcon:SetSize(unpack(iconDetails.size))
    contentIcon:SetAtlas(iconDetails.atlas)
    contentIcon:SetPoint("LEFT", firstText, "RIGHT", unpack(iconDetails.offset))

    local btnWidth = 100
    -- local addonListSaveUI = CreateFrame("Frame", nil, AddonList)
    -- addonListSaveUI:SetPoint("CENTER", AddonList.OkayButton, "CENTER", 0, 0)
    -- addonListSaveUI:SetSize(AddonList.OkayButton:GetWidth(), AddonList.OkayButton:GetHeight())
    -- addonListSaveUI:SetFrameStrata("FULLSCREEN_DIALOG")
    -- addonListSaveUI:SetScript("OnMouseUp", function()
    --     StaticPopup_Show("SC_SAVE_ADDONLIST")
    -- end)

    AddonList.OkayButton:HookScript("OnMouseDown", function()
        for _, r in pairs({AddonList.OkayButton:GetRegions()}) do
            if r:GetObjectType() == "FontString" then
                local text = r:GetText()
                if text == "Save & Reload" then --or text == OKAY 
                    SC:SaveEnabledAddonsSet(mainUI)
                end
            end
        end
    end)

    local addonListSwapUI = CreateFrame("Button", nil, AddonList, "UIPanelButtonTemplate")
    addonListSwapUI:SetText(buttonText)
    addonListSwapUI:SetWidth(btnWidth)
    addonListSwapUI:SetPoint("TOPRIGHT", AddonList, "BOTTOMRIGHT", -5, -5)
    addonListSwapUI:SetScript("OnClick", function()
        SC:SwapContentMode()
    end)
    AddTooltip2(addonListSwapUI, "", "", nil, AddonList, true)

    local addonListDefaultUI = CreateFrame("Button", nil, AddonList, "UIPanelButtonTemplate")
    addonListDefaultUI:SetText("Default "..mainUI.." Set")
    addonListDefaultUI:SetWidth(btnWidth)
    addonListDefaultUI:SetPoint("RIGHT", addonListSwapUI, "LEFT", 0, 0)
    addonListDefaultUI:SetScript("OnClick", function()
        StaticPopup_Show("SC_DEFAULT_ADDONLIST")
    end)
    AddTooltip2(addonListDefaultUI, "Restore Default Addon List for "..mainUI.." UI "..mainContentIconAtlas, "Click this button to restore the "..mainUI.." addon list back to the way it was when you first installed.", nil, AddonList)

    function SC:ToggleSwapButton()
        --if SkillCappedDB.secondaryContent == "None" then
        --    addonListSwapUI:Disable()
        --    swapUIBtn:Disable()
        --else
            addonListSwapUI:Enable()
            swapUIBtn:Enable()
        --end
    end
    SC:ToggleSwapButton()

    local backgroundAddonList = CreateFrame("Frame", nil, AddonList, "DefaultPanelTemplate")
    backgroundAddonList:SetSize(AddonList:GetWidth(), AddonList:GetHeight())
    backgroundAddonList:SetPoint("TOPLEFT", AddonList, "BOTTOMLEFT", 0.5, 140)
    backgroundAddonList:SetPoint("BOTTOMRIGHT", AddonList, "BOTTOMRIGHT", -1, -38)
    backgroundAddonList:EnableMouse(true)
    backgroundAddonList:SetFrameStrata("HIGH")
    backgroundAddonList:SetFrameLevel(AddonList:GetFrameLevel()-1)
    backgroundAddonList.NineSlice.TopEdge:Hide()
    backgroundAddonList.NineSlice.TopLeftCorner:Hide()
    backgroundAddonList.NineSlice.TopRightCorner:Hide()

    -- Function to copy properties from one texture to another
    local function CopyTextureProperties(source, target)
       if source and target then
          if source.GetVertexColor and target.SetVertexColor then
             local r, g, b, a = source:GetVertexColor()
             target:SetVertexColor(r, g, b, a)
          end
          if source.IsDesaturated and target.SetDesaturated then
             target:SetDesaturated(source:IsDesaturated())
          end
       end
    end

    local newBg = backgroundAddonList:CreateTexture(nil, "BACKGROUND")
    newBg:SetTexture(374154)
    newBg:SetPoint("TOPLEFT", backgroundAddonList, "TOPLEFT", 6, 0)
    newBg:SetPoint("BOTTOMRIGHT", backgroundAddonList, "BOTTOMRIGHT", -2, 3)
    newBg:SetTexCoord(0,1,0,1)
    backgroundAddonList.Bg:Hide()

    -- Apply SetVertexColor and SetDesaturated for AddonList.Bg
    if AddonList.Inset.Bg and backgroundAddonList.Bg then
       CopyTextureProperties(AddonList.Inset.Bg, backgroundAddonList.Bg)
    end

    -- Apply SetVertexColor and SetDesaturated for each region in AddonList.NineSlice
    if AddonList.NineSlice and backgroundAddonList.NineSlice then
       for i = 1, AddonList.NineSlice:GetNumRegions() do
          local sourceRegion = select(i, AddonList.NineSlice:GetRegions())
          local targetRegion = select(i, backgroundAddonList.NineSlice:GetRegions())
          if sourceRegion and targetRegion and sourceRegion:IsObjectType("Texture") then
             CopyTextureProperties(sourceRegion, targetRegion)
          end
       end
    end

    local extrasHeader = CreateHeader("Extras", frame, 10)
    extrasHeader:SetPoint("TOP", frame, "BOTTOM", 0, 145)

    -- local playerElite = makeBox(frame, "playerElite", "Player Elite Frame", extrasHeader, 65, -10, "Player Elite Frame", "Show elite dragon around PlayerFrame.\n|cff32f795Right-click to swap between the 4 different textures available.|r", function()SC:PlayerElite(SkillCappedDB["playerEliteMode"])end)
    -- playerElite:HookScript("OnMouseDown", function(self, button)
    --     if button == "RightButton" then
    --         SkillCappedDB["playerEliteMode"] = SkillCappedDB["playerEliteMode"] % 4 + 1
    --         SC:PlayerElite(SkillCappedDB["playerEliteMode"])
    --     end
    -- end)

    -- local newFonts = makeBox(frame, "newFonts", "New Fonts", playerElite, 0, -10, "New Fonts", "Enable new fonts for the entire game.")--, function()StaticPopup_Show("SC_RELOAD_REQUIRED")end)
    -- newFonts:HookScript("OnClick", function(self)
    --     if self:GetChecked() then
    --         SC:SetFonts()
    --     else
    --         SC:RestoreFonts()
    --     end
    -- end)

    -- local combinedBags = makeBox(frame, "combinedBags", "Combined Bags", newFonts, 0, -10, "Combined Bags", "Combine all bags into one mega-bag.")--, function()StaticPopup_Show("SC_RELOAD_REQUIRED")end)
    -- combinedBags:HookScript("OnClick", function(self)
    --     if self:GetChecked() then
    --         SC:RunAfterCombat(function()
    --             C_CVar.SetCVar("combinedBags", "1")
    --         end, "Setting will change after combat.")
    --     else
    --         SC:RunAfterCombat(function()
    --             C_CVar.SetCVar("combinedBags", "0")
    --         end, "Setting will change after combat.")
    --     end
    -- end)

    -- local hideErrorFrame = makeBox(frame, "hideErrorFrame", "Hide Error Frame", extrasHeader, 257, -10, "Hide Error Frame", "Hide the error frame displaying messages such as \"NOT ENOUGH MANA\".", function()StaticPopup_Show("SC_RELOAD_REQUIRED")end)
    -- local hideHitIndicator = makeBox(frame, "hideHitIndicator", "Hide Hit Indicator", hideErrorFrame, 0, -10, "Hide Hit Indicator", "Hide damage numbers on player and pet frame.", function()StaticPopup_Show("SC_RELOAD_REQUIRED")end)

    -- local fadeStatusBar = makeBox(frame, "fadeStatusBar", "Fade Status/XP Bar", extrasHeader, 450, -10, "Fade Status/XP Bar", "Fade out the Status/XP Bar.\nMouseover to show.", function()StaticPopup_Show("SC_RELOAD_REQUIRED")end)
    -- local queuePopNotification = makeBox(frame, "queuePopNotification", "Queue Pop Notification", fadeStatusBar, 0, -10, "Queue Pop Notification", "Play an alarm sound on PvP queue pops.\nUses the Master audio channel, will play even if game is muted with the default mute keybind.", function()StaticPopup_Show("SC_RELOAD_REQUIRED")end)

    -- local ReplaceMyPlayerPortrait = makeBox(frame, "ReplaceMyPlayerPortrait", "Class Icon Portraits", queuePopNotification, 0, -10, "Class Icon Portraits", "Change unit frame portraits to class icons.")--, function()StaticPopup_Show("SC_RELOAD_REQUIRED")end)
    -- ReplaceMyPlayerPortrait:HookScript("OnClick", function(self)
    --     if self:GetChecked() then
    --         SC:RunAfterCombat(function()
    --             C_CVar.SetCVar("ReplaceMyPlayerPortrait", "1")
    --             C_CVar.SetCVar("ReplaceOtherPlayerPortraits", "1")
    --         end, "Setting will change after combat.")
    --     else
    --         SC:RunAfterCombat(function()
    --             C_CVar.SetCVar("ReplaceMyPlayerPortrait", "0")
    --             C_CVar.SetCVar("ReplaceOtherPlayerPortraits", "0")
    --         end, "Setting will change after combat.")
    --     end
    -- end)

    local minimapIconHide = makeBox(frame, "minimapIconHide", "Hide Minimap Icon", extrasHeader, 3, -2, "Hide Minimap Icon", "Hides the SkillCapped Minimap Icon.")
    minimapIconHide:HookScript("OnClick", function(self)
        local LDBIcon = LibStub("LibDBIcon-1.0")
        SkillCappedDB.minimapIconHide = self:GetChecked() or nil  -- Set to true if checked, nil otherwise
        LDBIcon[SkillCappedDB.minimapIconHide and "Hide" or "Show"](LDBIcon, "SkillCapped")
    end)


    local updateSQW = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    local updatedCheck = frame:CreateTexture(nil, "OVERLAY")
    updatedCheck:SetSize(18,18)
    updatedCheck:SetPoint("LEFT", updateSQW, "RIGHT", 4, 0)
    updatedCheck:SetAtlas("common-icon-checkmark")
    updatedCheck:Hide()
    local window = GetCVar("SpellQueueWindow")
    updateSQW:SetText("Update SQW: " .. window)
    updateSQW:SetWidth(125)
    local updateDelay
    updateSQW:SetScript("OnClick", function()
        if not updateDelay then
            SC:MeasureLatencyAndAdjustSpellQueue()
            updateDelay = true
            C_Timer.After(30, function()
                updateDelay = false
            end)
        end
        local newWindow = GetCVar("SpellQueueWindow")
        updateSQW:SetText("Update SQW: " .. newWindow)
        C_Timer.After(0.01, function()
            updatedCheck:Show()
            updatedCheck:SetAlpha(1)
            C_Timer.After(0.5, function()
                fadeOutFrame(updatedCheck, 1)
            end)
        end)
    end)
    updateSQW.Text:SetFont(scFont, 12)
    AddTooltip2(updateSQW, "Update Spell Queue Window", "Automatically update the spell queue window to your optimal value.\nCan only be updated every 30sec.", nil, frame)
    updateSQW:SetScale(0.95)
    updateSQW:SetPoint("TOPLEFT", extrasHeader, "BOTTOMLEFT", 5, -35)


    -- local waToggles = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    -- waToggles:SetText("WeakAura Load States")
    -- waToggles:SetWidth(150)
    -- waToggles:SetScript("OnClick", function()
    --     SC:OpenWeakAuraTogglesGUI()
    -- end)
    -- waToggles.Text:SetFont(scFont, 12)
    -- waToggles:SetScale(0.95)
    -- waToggles:SetPoint("TOP", extrasHeader, "BOTTOM", 0, -20)
    -- AddTooltip2(waToggles, "WeakAura Load States", "Input the names of your own WeakAuras that you would like to load in PvP or PvE UI Mode only.", nil, frame)



    local backupsHeader = CreateHeader("Setup & Backup", frame, 10)
    backupsHeader:SetPoint("TOP", frame, "BOTTOM", 0, 70)

    local profileDesc = frame:CreateFontString(nil, "OVERLAY")
    profileDesc:SetFont(scFont, 11)
    profileDesc:SetJustifyH("LEFT")
    profileDesc:SetText("Run the installation process again.")
    profileDesc:SetPoint("TOPLEFT", backupsHeader, "BOTTOMLEFT", 5, -6)

    local openTutorialBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    openTutorialBtn:SetText("Setup")
    openTutorialBtn:SetWidth(125)
    openTutorialBtn:SetPoint("TOPLEFT", profileDesc, "BOTTOMLEFT", 0, -5)
    openTutorialBtn:SetScript("OnClick", function()
        if InCombatLockdown() then
            SC:Print("Leave combat to continue installation. Make sure you are out of combat while installing.")
            return
        end
        SC.setupActive = true
        SC:MakeGUI(true)
        PlaySound(1115)
    end)
    openTutorialBtn:SetScale(0.95)
    openTutorialBtn.Text:SetFont(scFont, 12)
    AddTooltip2(openTutorialBtn, "Setup", "Go through the installation again. Only selected presets will be installed. Installing a new preset overwrites current setup but does not overwrite current backups. ", nil, frame)

    local profileDesc = frame:CreateFontString(nil, "OVERLAY")
    profileDesc:SetFont(scFont, 11)
    profileDesc:SetText("Restore backups of old addon configurations")
    profileDesc:SetPoint("TOPRIGHT", backupsHeader, "BOTTOMRIGHT", -5, -6)

    local restoreBackupsBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    restoreBackupsBtn:SetText("Restore Backups")
    restoreBackupsBtn:SetWidth(125)
    restoreBackupsBtn:SetPoint("TOPLEFT", profileDesc, "BOTTOMLEFT", 0, -5)
    restoreBackupsBtn:HookScript("OnClick", function()
        if InCombatLockdown() then
            SC:Print("Leave combat to continue installation. Make sure you are out of combat while installing.")
            return
        end
        if SkillCappedDB.completedSetup then
            SC:BackupWarningGUI()
        else
            SC:Print("No backup has been made yet.")
        end
    end)
    restoreBackupsBtn:SetScale(0.95)
    restoreBackupsBtn.Text:SetFont(scFont, 12)
    AddTooltip2(restoreBackupsBtn, "Restore Backups", "Restores all profiles that were backed up by the Skill-Capped addon.\n|cff32f795Make sure all of those addons are enabled or the disabled ones wont get their backup restored.|r", nil, frame)

    local verNumber = frame:CreateFontString(nil, "OVERLAY")
    verNumber:SetFont(scFont, 12)
    verNumber:SetText(C_AddOns.GetAddOnMetadata("SkillCapped", "Version"))
    verNumber:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 2)
    verNumber:SetTextColor(0.15,0.15,0.15,0.9)

    SC.category = Settings.RegisterCanvasLayoutCategory(SkillCappedBlizzard, SkillCappedBlizzard.name, SkillCappedBlizzard.name)
    Settings.RegisterAddOnCategory(SC.category)
    --InterfaceOptions_AddCategory(SkillCappedBlizzard)
    SLASH_SKILLCAPPED1 = "/sc"
    SLASH_SKILLCAPPED2 = "/skillcapped"
    SlashCmdList["SKILLCAPPED"] = function(msg)
        msg = msg:lower():trim()
        if msg == "ver" or msg == "version" then
            local currentAddonVersion = C_AddOns.GetAddOnMetadata(AddonName, "Version")
            SC:Print("UI Version: " .. currentAddonVersion)
        elseif msg == "pvp" then
            if SkillCappedDB.mainContent == "PvP" or SkillCappedDB.secondaryContent == "PvP" then
                SC:LoadAddonSet("PvP")
            end
        elseif msg == "pve" then
            if SkillCappedDB.mainContent == "PvE" or SkillCappedDB.secondaryContent == "PvE" then
                SC:LoadAddonSet("PvE")
            end
        elseif msg == "swap" then
            SC:SwapContentMode()
        elseif msg == "bar fix" then
            if InCombatLockdown() then
                SC:Print("Leave combat before you run this command.")
                return
            end
            if SC:HasOneFreeEditModeSlot() then
                local contentType = SkillCappedDB.mainContent
                SC:ForceImportEditModeToSkillCapped(contentType, nil, contentType)
                ReloadUI()
            else
                SC:Print("You need one free edit mode profile slot. Please delete one profile to make space.")
            end
        elseif msg == "fix" then
            if InCombatLockdown() then
                SC:Print("Leave combat before you run this command.")
                return
            end
            if SkillCappedDB.completedSetup then
                SC.fixCDM = true
                SC:EnsureAddonInSet("SkillCapped")
                SC:UpdateEnabledAddons()
                SC:LoadAddonSet(SkillCappedDB.mainContent)
            else
                SC:Print("You have no presets installed. Please use the setup button to install presets.")
            end
        elseif msg == "bigfix" then
            if InCombatLockdown() then
                SC:Print("Leave combat before you run this command.")
                return
            end
            if SkillCappedDB.completedSetup then
                SC:RestoreDefaultAddonSet("PvE")
                SC:RestoreDefaultAddonSet("PvP")
                SC:UpdateEnabledAddons()
                SC:LoadAddonSet(SkillCappedDB.mainContent)
            else
                SC:Print("You have no presets installed. Please use the setup button to install presets.")
            end
        elseif msg == "list" then
            if InCombatLockdown() then
                SC:Print("Leave combat before you run this command.")
                return
            end
            if SkillCappedDB.completedSetup then
                SC:RestoreDefaultAddonSet("PvE")
                SC:RestoreDefaultAddonSet("PvP")
                SC:UpdateEnabledAddons()
                SC:LoadAddonSet(SkillCappedDB.mainContent)
            else
                SC:Print("You have no presets installed. Please use the setup button to install presets.")
            end
        elseif msg == "setup" then
            if InCombatLockdown() then
                SC:Print("Leave combat to enter Setup. Make sure you are out of combat while installing.")
                return
            end
            SC.setupActive = true
            SC:MakeGUI(true)
        elseif msg == "uiscale" then
            SkillCappedDB.dontWarnUIScale = true
        -- elseif msg == "wa" then
        --     SC:OpenWeakAuraTogglesGUI()
        else
            Settings.OpenToCategory(SC.category:GetID())
        end
    end
    SC.SkillCappedBlizzard = SkillCappedBlizzard
end

SkillCappedBackupWarning = nil
function SC:BackupWarningGUI()
    if not SkillCappedDB.checkAddonsForBackup then
        Settings.OpenToCategory(SC.category:GetID())
    end
    if SkillCappedBackupWarning then
        SettingsPanel:Hide()
        SkillCappedBackupWarning:Show()
        return
    end
    SettingsPanel:Hide()
    local SkillCappedBackupWarning = CreateFrame("Frame", "SkillCappedBackupWarning", UIParent, "BackdropTemplate")
    SkillCappedBackupWarning:SetPoint("CENTER", UIParent, "CENTER", 0, 60)
    SkillCappedBackupWarning:SetSize(370,300)
    --SkillCappedBackupWarning:Hide()
    SkillCappedBackupWarning:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = true,
        tileSize = 32,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    SkillCappedBackupWarning:SetBackdropColor(0.05, 0.05, 0.05, 0.85)
    SkillCappedBackupWarning:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
    SkillCappedBackupWarning:SetFrameStrata("DIALOG")

    MakeFrameMoveable(SkillCappedBackupWarning)

    local addonConfigBanner = MakeBanner(SkillCappedBackupWarning, UIParent)

    local warningBkupText = SkillCappedBackupWarning:CreateFontString(nil, "ARTWORK", "Game15Font")
    warningBkupText:SetFont(scFont, 22)
    warningBkupText:SetText("WARNING")
    warningBkupText:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -10)

    local warningBkupDescription = SkillCappedBackupWarning:CreateFontString(nil, "ARTWORK", "Game15Font")
    warningBkupDescription:SetFont(scFont, 12)
    warningBkupDescription:SetText("The following addons have a backup but are not enabled.\nIf you restore backups now it will |cffff0000NOT|r restore the settings for these addons and the backup will be |cffff0000LOST|r.\nPlease enable them to make sure no data is lost.")
    warningBkupDescription:SetPoint("TOP", addonConfigBanner, "BOTTOM", 0, -35)
    warningBkupDescription:SetWidth(SkillCappedBackupWarning:GetWidth()-110)

    local restoreBtn = CreateFrame("Button", nil, SkillCappedBackupWarning, "UIPanelButtonTemplate")
    restoreBtn:SetText("Restore Backups")
    restoreBtn:SetWidth(115)
    restoreBtn:SetHeight(25)
    restoreBtn.Text:SetFont(scFont, 12)
    restoreBtn:SetPoint("BOTTOM", SkillCappedBackupWarning, "BOTTOM", 0, 25)
    restoreBtn:HookScript("OnClick", function()
        if InCombatLockdown() then
            SC:Print("Leave combat to continue installation. Make sure you are out of combat while installing.")
            return
        end
        StaticPopup_Show("SC_BACKUP_WARNING")
        SetUpPopupProperties(true)
    end)
    restoreBtn:SetScale(1.05)

    local reloadBtn = CreateFrame("Button", nil, SkillCappedBackupWarning, "UIPanelButtonTemplate")
    reloadBtn:SetText("Reload UI")
    reloadBtn:SetWidth(100)
    reloadBtn:SetHeight(25)
    reloadBtn.Text:SetFont(scFont, 12)
    reloadBtn:SetPoint("BOTTOM", SkillCappedBackupWarning, "BOTTOM", 0, 25)
    AddTooltip2(reloadBtn, "Reload UI", "Addon(s) have been enabled.\nReload UI to load them in and safely restore the backups.", "ANCHOR_TOP", UIParent)
    reloadBtn:HookScript("OnClick", function()
        SkillCappedDB.checkAddonsForBackup = true
        ReloadUI()
    end)
    reloadBtn:Hide()
    reloadBtn:SetScale(1.05)

    local exitButton = CreateFrame("Button", nil, SkillCappedBackupWarning, "UIPanelButtonTemplate")
    exitButton:SetText("Exit")
    exitButton:SetWidth(60)
    exitButton.Text:SetFont(scFont, 12)
    exitButton:SetPoint("TOP", SkillCappedBackupWarning, "BOTTOM", 0, -5)
    exitButton:SetScript("OnClick", function()
        SkillCappedBackupWarning:Hide()
        --InterfaceOptionsFrame_OpenToCategory(SkillCappedBlizzard)
        Settings.OpenToCategory(SC.category:GetID())
    end)
    exitButton:SetScale(0.95)

    local unloadedBackupAddonCheckboxes = {}
    local yOffset = -5
    local spacing = 18
    local height = 0
    local addonMissing = false
    for _, addonName in ipairs(SC:GetAddonList("allAddons")) do
        local addonDBName = SC.addonDatabaseMap[addonName]
        if not SkillCappedBackupDB then
            return
        end
        if SkillCappedBackupDB[addonDBName] then
            if not SC:IsAddonLoaded(addonName) then
                addonMissing = true
                local formattedAddonName = addonName:gsub("_", " ")
                local cb = CreateCheckbox(addonName, SkillCappedBackupWarning, 250, yOffset)
                cb:SetPoint("TOPLEFT", warningBkupDescription, "BOTTOM", -62, yOffset)
                cb:SetSize(22,22)
                cb.forceOrange = true
                height = height + (cb:GetHeight()-5)
                cb.Text:SetFont(scFont, 11)
                yOffset = yOffset - spacing
                cb.Text:SetText(formattedAddonName)
                cb:SetChecked(false)
                cb.Text:SetTextColor(1, 0.6, 0, 1)
                cb:SetAlpha(1)
                AddTooltip2(cb, "|cffff9900Addon not enabled|r", "If you don't enable this addon your settings for it will NOT be restored and you will LOSE your backup.\n\n|cff32f795Click to enable addon.|r", "ANCHOR_LEFT", SkillCappedBackupWarning)
                AddTooltip2(cb.Text, "|cffff9900Addon not enabled|r", "If you don't enable this addon your settings for it will NOT be restored and you will LOSE your backup.\n\n|cff32f795Click to enable addon.|r", "ANCHOR_LEFT", SkillCappedBackupWarning)
                if not SC:DoesAddonExist(addonName) then
                    cb:Disable()  -- Disable if not existing
                    local overlay = CreateFrame("Frame", nil, SkillCappedBackupWarning)
                    overlay:SetFrameLevel(cb:GetFrameLevel() + 1)
                    overlay:SetFrameStrata("DIALOG")
                    overlay:SetSize(cb:GetWidth()+cb.Text:GetWidth(), cb:GetHeight())
                    overlay:SetPoint("TOPLEFT", cb, "TOPLEFT")
                    overlay:EnableMouse(true)
                    AddTooltip2(overlay, "|cffff0000Addon not found|r","Check your addon folder or download it from CurseForge.\n\nIf you don't enable this addon your backup for it will NOT be restored and you will LOSE your settings.", "ANCHOR_LEFT", SkillCappedBackupWarning)
                    cb.Text:SetTextColor(1, 0, 0, 1)
                    cb.overlay = overlay
                    cb.notFound = true
                end
                unloadedBackupAddonCheckboxes[addonName] = cb
            end
        end
    end

    if not addonMissing then
        warningBkupDescription:SetWidth(SkillCappedBackupWarning:GetWidth()-120)
        warningBkupText:SetText("Careful!")
        warningBkupDescription:SetText("Your current settings for Skill-Capped preset addons will be lost and the backups will be deleted once restored.\n\nYou will create new backups on a new installation.\n\nAre you sure?")
    end

    for addonName, cb in pairs(unloadedBackupAddonCheckboxes) do
        cb.initialState = cb:GetChecked()
        cb.addonName = addonName
        cb:HookScript("OnClick", function(self)
            local addonName = self.addonName
            local currentState = self:GetChecked()
            CheckForChanges(unloadedBackupAddonCheckboxes, reloadBtn, restoreBtn, true)
            if SC:DoesAddonExist(addonName) then
                if currentState then
                    C_AddOns.EnableAddOn(addonName)
                    local colorAddonName = "|cff00FF00"..addonName
                    local tooltipText = "Addon enabled. Click the Reload UI button to load addons."
                    AddTooltip2(cb, colorAddonName, tooltipText, "ANCHOR_LEFT", SkillCappedBackupWarning)
                    AddTooltip2(cb.Text, colorAddonName, tooltipText, "ANCHOR_LEFT", SkillCappedBackupWarning)
                    RefreshTooltip(cb, colorAddonName, tooltipText, "ANCHOR_LEFT", SkillCappedBackupWarning)
                else
                    AddTooltip2(cb, "|cffff9900Addon not enabled|r", "If you don't enable this addon your settings for it will NOT be restored and you will LOSE your backup.\n\n|cff32f795Click to enable addon.|r", "ANCHOR_LEFT", SkillCappedBackupWarning)
                    AddTooltip2(cb.Text, "|cffff9900Addon not enabled|r", "If you don't enable this addon your settings for it will NOT be restored and you will LOSE your backup.\n\n|cff32f795Click to enable addon.|r", "ANCHOR_LEFT", SkillCappedBackupWarning)
                    RefreshTooltip(cb, "|cffff9900Addon not enabled|r", "If you don't enable this addon your settings for it will NOT be restored and you will LOSE your backup.\n\n|cff32f795Click to enable addon.|r", "ANCHOR_LEFT", SkillCappedBackupWarning)
                end
            end
        end)
    end
    SkillCappedBackupWarning:SetHeight(300+height)
end

function SC:ImportGUI()
    local SkillCappedImport = CreateFrame("Frame")
    SkillCappedImport.name = "Import"
    SkillCappedImport.parent = SkillCappedBlizzard.name
    --SkillCappedBlizzard:SetSize(100,300)

    local frame = CreateFrame("Frame", nil, SkillCappedImport)
    frame:SetPoint("CENTER", SkillCappedImport, "CENTER", -6, 3)
    frame:SetSize(685, 611)
    --InterfaceOptions_AddCategory(SkillCappedImport)
    local importSubCategory = Settings.RegisterCanvasLayoutSubcategory(SC.category, SkillCappedImport, SkillCappedImport.name, SkillCappedImport.name)
    SC.category.Import = SkillCappedImport.name

    local frameBg = frame:CreateTexture(nil, "BACKGROUND")
    frameBg:SetColorTexture(0, 0, 0, 0.6)
    frameBg:SetAllPoints(frame)

    local importBanner = MakeBanner(frame, SkillCappedImport, 30)

    local importHeader = CreateHeader("Import Profiles", frame, 10)
    importHeader:SetPoint("TOP", importBanner, "BOTTOM", 0, -10)
    local headerWidth = importHeader:GetWidth()

    local importDesc = frame:CreateFontString(nil, "OVERLAY")
    importDesc:SetFont(scFont, 11)
    importDesc:SetJustifyH("LEFT")
    importDesc:SetText("Paste encoded strings")
    importDesc:SetPoint("TOPLEFT", importHeader, "BOTTOMLEFT", 5, -6)

    local editBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    editBox:SetSize(headerWidth-20, 20)
    editBox:SetPoint("TOPLEFT", importHeader, "BOTTOMLEFT", 10, -27)
    editBox:SetAutoFocus(false)

    AddTooltip2(editBox, "Enter import string", nil, "ANCHOR_TOP")

    editBox:HookScript("OnTextChanged", function()
        if SC:ChangeWeakAura(editBox:GetText()) then
            if InCombatLockdown() then
                SC:Print("Leave combat to continue installation. Make sure you are out of combat while installing.")
                return
            end
            editBox:SetText("")
            SC.setupActive = true
            SC:MakeGUI(true)
            PlaySound(1115)
        end
    end)


    local importBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    importBtn:SetText("Import")
    importBtn:SetWidth(85)
    importBtn:SetHeight(21)
    importBtn:SetPoint("TOPLEFT", editBox, "BOTTOMLEFT", -5, -5)
    importBtn:SetScale(1)
    importBtn.Text:SetFont(scFont, 12)
    importBtn:HookScript("OnClick", function()
        if SC:ChangeWeakAura(editBox:GetText()) then
            -- open instlal config here
            if InCombatLockdown() then
                SC:Print("Leave combat to continue installation. Make sure you are out of combat while installing.")
                return
            end
            editBox:SetText("")
            SC.setupActive = true
            SC:MakeGUI(true)
        else
            SC:Print("Invalid import string.")
        end
    end)

    local verNumber = frame:CreateFontString(nil, "OVERLAY")
    verNumber:SetFont(scFont, 12)
    verNumber:SetText(C_AddOns.GetAddOnMetadata("SkillCapped", "Version"))
    verNumber:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 2)
    verNumber:SetTextColor(0.15,0.15,0.15,0.9)
end

-- function SC:CenterWeakAuras()
--     if not WeakAurasOptions then return end
--     WeakAurasOptions:SetSize(840,500)
--     WeakAurasOptions:ClearAllPoints()
--     WeakAurasOptions:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
-- end

function SC:GetAddonCheckboxes()
    return checkboxes
end

-- function SC:GetWACheckboxes()
--     return waCheckboxes
-- end

function SC:RestoreCheckboxStates()
    -- Check if the stored states exist before attempting to restore
    if SkillCappedDB.reloadCheckboxStates then
        SC:CreateInstallStep("LookAndFeel", SkillCappedTutorial.generalStep)
        SC:CreateInstallStep("PvP", SkillCappedTutorial.pvpStep)
        -- PvE disabled
        --SC:CreateInstallStep("PvE", SkillCappedTutorial.pveStep)

        for addonName, cb in pairs(checkboxes) do
            -- Only restore state for checkboxes that exist and were stored
            if cb and SkillCappedDB.reloadCheckboxStates[addonName] ~= nil then
                cb:SetChecked(SkillCappedDB.reloadCheckboxStates[addonName])
                ColorCheckboxTextAfterState(cb)
            end
        end

        for weakauraClass, cb in pairs (waCheckboxes) do
            if cb then
                if checkboxes["WeakAurasPvE"]:GetChecked() then
                    cb:SetAlpha(1)
                    cb:Enable()
                end
            end
            if cb and SkillCappedDB.reloadCheckboxStates[weakauraClass] ~= nil then
                cb:SetChecked(SkillCappedDB.reloadCheckboxStates[weakauraClass])
            end
        end

        -- Clear the stored states after restoring
        SkillCappedDB.reloadCheckboxStates = nil
    end
end



-- function SC:AllBackedUpAddonsAreOn()
--     for _, addonName in ipairs(SC:GetAddonList("pvpAddonList")) do
--         local addonDBName = SC.addonDatabaseMap[addonName]
--         if SkillCappedBackupDB[addonDBName] and not SC:IsAddonLoaded(addonName) then
--             return false
--         end
--     end
--     return true
-- end

function SC:CreateAddonSetNotification()
    -- Create the frame to contain the icon and text
    local statusFrame = CreateFrame("Frame", nil, UIParent)
    statusFrame:SetSize(300, 50)  -- Adjust the size as needed
    statusFrame:SetPoint("CENTER", UIParent, "CENTER", -17, 240)
    statusFrame:SetAlpha(0)

    -- Determine icon details based on SkillCappedDB.mainContent
    local mainContentIconDetails = {
        ["PvP"] = { atlas = "countdown-swords", size = {28, 28}, offset = {2, 1} },
        ["PvE"] = { atlas = "Dungeon", size = {45, 45}, offset = {0, 1} },
    }
    local mainContent = SkillCappedDB.mainContent or "PvP"  -- Default to "PvP" if not set
    local iconDetails = mainContentIconDetails[mainContent]

    -- Add the first text: scIcon, coloredAddonName, and mainContent
    local firstText = statusFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    firstText:SetPoint("LEFT", statusFrame, "LEFT", 0, 0)
    firstText:SetText("|TInterface/AddOns/SkillCapped/media/icon64.tga:16:16:0:0|t" .. coloredAddonName .. " " .. mainContent)
    firstText:SetFont(scFont, 23)

    -- Add the content icon next to the first text
    local contentIcon = statusFrame:CreateTexture(nil, "OVERLAY")
    contentIcon:SetSize(unpack(iconDetails.size))
    contentIcon:SetAtlas(iconDetails.atlas)
    contentIcon:SetPoint("LEFT", firstText, "RIGHT", unpack(iconDetails.offset))

    -- Add the second text: "Set Enabled"
    local secondText = statusFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local xOffset = mainContent == "PvP" and 4 or -1
    secondText:SetPoint("LEFT", contentIcon, "RIGHT", xOffset, 0)
    secondText:SetText("Enabled")
    secondText:SetFont(scFont, 23)

    FadeFrameAlpha(statusFrame, 0, 1, 0.5)
    C_Timer.After(3.5, function()
        FadeFrameAlpha(statusFrame, 1, 0, 1)
        C_Timer.After(1.1, function()
            statusFrame:Hide()
            statusFrame = nil
        end)
    end)
end

-- function SC:CreateWeakAuraUpdateWindow()
--     if not SC.WeakAurasWithUpdates then return end
--     local waNames = SC:GetWeakAuraNames("All")
--     if not SkillCappedDB.ignoredWeakAuras then
--         SkillCappedDB.ignoredWeakAuras = {}
--     end

--     local updateList, ignoredList = {}, {}
--     SC.ignoredWeakAuras = {}

--     for weakauraKey in pairs(SC.WeakAurasWithUpdates) do
--         local ignored = SkillCappedDB.ignoredWeakAuras[weakauraKey]
--         if ignored then
--             table.insert(ignoredList, weakauraKey)
--             SC.ignoredWeakAuras[weakauraKey] = true
--         else
--             table.insert(updateList, weakauraKey)
--             SC.ignoredWeakAuras[weakauraKey] = false
--         end
--     end

--     table.sort(updateList, function(a, b) return waNames[a]:lower() < waNames[b]:lower() end)
--     table.sort(ignoredList, function(a, b) return waNames[a]:lower() < waNames[b]:lower() end)

--     local function CreateCheckboxList(parent, anchor, list, yOffset, label, colorDisabled)
--         if #list == 0 then return yOffset end

--         local header = parent:CreateFontString(nil, "OVERLAY", colorDisabled and "GameFontDisableSmall" or "GameFontHighlight")
--         header:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 10, yOffset)
--         header:SetText(label)

--         yOffset = yOffset - 20

--         local halfSize = math.ceil(#list / 2)
--         local columnXOffsets = {10, 210}

--         for i, waKey in ipairs(list) do
--             local col = (i > halfSize) and 2 or 1
--             local row = (col == 1) and i or (i - halfSize)
--             local posX, posY = columnXOffsets[col], yOffset - ((row - 1) * 18) + 6

--             local cb = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
--             cb:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", posX, posY)
--             cb.Text:SetText(waNames[waKey])
--             cb:SetChecked(not colorDisabled)
--             cb:SetSize(22, 22)

--             if not cb.uninstallMark then
--                 local uninstallMark = cb:CreateTexture(nil, "OVERLAY")
--                 uninstallMark:SetAtlas("common-icon-redx")
--                 uninstallMark:SetPoint("CENTER", cb, 0, 0)
--                 uninstallMark:SetSize(13, 13)
--                 cb.uninstallMark = uninstallMark
--             end
--             cb.uninstallMark:SetShown(colorDisabled)
--             if colorDisabled then
--                 cb.Text:SetTextColor(0.5, 0.5, 0.5, 1)
--             else
--                 cb.Text:SetTextColor(1,0.82,0,1)
--             end

--             cb:SetScript("OnClick", function(self)
--                 local newIgnoredState = not self:GetChecked()
--                 SC.ignoredWeakAuras[waKey] = newIgnoredState

--                 if newIgnoredState then
--                     cb.Text:SetTextColor(0.5, 0.5, 0.5, 1)
--                 else
--                     cb.Text:SetTextColor(1, 0.82, 0, 1)
--                 end
--                 cb.uninstallMark:SetShown(newIgnoredState)
--             end)

--             cb:HookScript("OnMouseDown", function(self, button)
--                 if button == "RightButton" then self:Click() end
--             end)
--             cb.Text:HookScript("OnMouseDown", function(self, button)
--                 if button == "RightButton" then self:Click() end
--             end)
--         end

--         return yOffset - (math.min(#list, halfSize) * 18) - 10
--     end

--     local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
--     frame:SetBackdrop({
--         bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
--         edgeFile = "Interface\\Buttons\\WHITE8x8",
--         tile = true, tileSize = 32, edgeSize = 1,
--         insets = { left = 1, right = 1, top = 1, bottom = 1 },
--     })
--     frame:SetBackdropColor(0.05, 0.05, 0.05, 0.85)
--     frame:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
--     frame:SetPoint("TOP", UIParent, "TOP", 0, screenHeight * -0.16)
--     frame:Show()

--     local addonConfigBanner = MakeBanner(frame, UIParent)

--     local yOffset = -10
--     yOffset = CreateCheckboxList(frame, addonConfigBanner, updateList, yOffset, "WeakAura Updates Available:", false)
--     yOffset = CreateCheckboxList(frame, addonConfigBanner, ignoredList, yOffset, "Currently Ignored:", true)

--     local updateWaBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
--     updateWaBtn:SetText("Update")
--     updateWaBtn:SetWidth(85)
--     updateWaBtn:SetHeight(21)
--     updateWaBtn:SetPoint("BOTTOM", frame, "BOTTOM", 0, 6)
--     updateWaBtn:SetScale(1.2)
--     updateWaBtn:HookScript("OnClick", function()
--         SkillCappedDB.ignoredWeakAuras = SkillCappedDB.ignoredWeakAuras or {}
--         for waKey, ignored in pairs(SC.ignoredWeakAuras) do
--             SkillCappedDB.ignoredWeakAuras[waKey] = ignored and true or nil
--         end
--         SC:RunAfterCombat(function()
--             SC.updateInstalled = true
--             SC:CheckAndUpdateWeakAuras()
--             SC:UpdateAllWeakAuraVersionNumbers()
--             frame:Hide()
--         end)
--     end)

--     frame:SetSize(420, math.abs(yOffset) + 145)
--     frame:Show()
-- end


-- function SC:RemoveIgnoreNameRealmFlag(name)
--     if not WeakAurasSaved or not name then return end

--     local aura = WeakAurasSaved["displays"] and WeakAurasSaved["displays"][name]
--     if not aura or not aura["load"] then return end

--     aura["load"]["use_ignoreNameRealm"] = false
--     aura["load"]["ignoreNameRealm"] = ""

--     -- Unset for any child WeakAuras
--     for childName, childAura in pairs(WeakAurasSaved["displays"]) do
--         if childAura["parent"] == name and childAura["load"] then
--             childAura["load"]["use_ignoreNameRealm"] = false
--             childAura["load"]["ignoreNameRealm"] = ""
--         end
--     end
-- end

-- local function UpdateCustomWeakAuraLoadTogglesOnLogout()
--     if SC.UpdateCustomWeakAuraToggles then return end
--     local f = CreateFrame("Frame")
--     f:RegisterEvent("PLAYER_LOGOUT")
--     f:SetScript("OnEvent", function()
--         SC:UpdateCustomWeakAuraLoadStatus(SkillCappedDB.mainContent)
--     end)
--     SC.UpdateCustomWeakAuraToggles = f
-- end

-- function SC:OpenWeakAuraTogglesGUI()
--     if not SkillCappedDB.weakauraToggles then
--         SkillCappedDB.weakauraToggles = {}
--     end

--     if SC.waToggleFrame and SC.waToggleFrame:IsShown() then
--         SC.waToggleFrame:Hide()
--         return
--     end

--     local frame = CreateFrame("Frame", "SC_WeakAuraTogglesFrame", UIParent, "DefaultPanelTemplate")
--     frame:SetSize(420, 460)
--     frame:SetPoint("CENTER")
--     frame:SetMovable(true)
--     frame:EnableMouse(true)
--     frame:RegisterForDrag("LeftButton")
--     frame:SetScript("OnDragStart", frame.StartMoving)
--     frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
--     frame:SetTitle(scIcon..coloredAddonName.." WeakAura PvE/PvP Toggles")
--     frame:SetFrameStrata("HIGH")

--     local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
--     closeBtn:SetPoint("TOPRIGHT", 0, -1)
--     closeBtn:SetScript("OnClick", function()
--         frame:Hide()
--     end)

--     frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
--     frame.title:SetPoint("TOPLEFT", 16, -40)
--     frame.title:SetText("Input WeakAura name and select\nwhich UI Mode (PvP/PvE) it should load in.")
--     frame.title:SetJustifyH("LEFT")

--     SC.waToggleFrame = frame

--     local input = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
--     input:SetSize(210, 21)
--     input:SetPoint("TOPLEFT", 18, -70)
--     input:SetAutoFocus(false)
--     input:SetScript("OnEscapePressed", input.ClearFocus)
--     AddTooltip2(input, "WeakAura Name", "Enter the WeakAuras name.\nNeeds to be an identical match.")

--     local typeContainer, dropdown
--     typeContainer, dropdown = CreateDropdown(frame, 100, {"PvE", "PvP"}, function(selected)
--         dropdown.selected = selected
--         UpdateCustomWeakAuraLoadTogglesOnLogout()
--     end, "PvE")
--     local typeDropdown = dropdown

--     typeContainer:SetPoint("LEFT", input, "RIGHT", 10, 12)
--     typeContainer:SetScale(0.8)
--     AddTooltip2(typeContainer, "Select which type of content the WeakAura should load in.")

--     local addBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
--     addBtn:SetSize(60, 22)
--     addBtn:SetPoint("LEFT", typeContainer, "RIGHT", 10, -10)
--     addBtn:SetText("Add")
--     AddTooltip2(addBtn, "Add WeakAura name to list")

--     local reloadUI = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
--     reloadUI:SetSize(120, 22)
--     reloadUI:SetPoint("BOTTOM", frame, "BOTTOM", 0, 8)
--     reloadUI:SetText("Reload UI")
--     reloadUI:SetScale(1)
--     AddTooltip2(reloadUI, "Reload UI", "Reload UI for changes to take effect.", "ANCHOR_TOP")
--     reloadUI:HookScript("OnClick", ReloadUI)

--     local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
--     scrollFrame:SetPoint("TOPLEFT", 16, -110)
--     scrollFrame:SetPoint("BOTTOMRIGHT", -32, 35)

--     local listBackdrop = CreateFrame("Frame", nil, frame, "BackdropTemplate")
--     listBackdrop:SetPoint("TOPLEFT", scrollFrame, -2, 2)
--     listBackdrop:SetPoint("BOTTOMRIGHT", scrollFrame, 2, -2)
--     listBackdrop:SetBackdrop({
--         bgFile = "Interface\\Buttons\\WHITE8x8",
--         edgeFile = "Interface\\Buttons\\WHITE8x8",
--         edgeSize = 1,
--     })
--     listBackdrop:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
--     listBackdrop:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)
--     listBackdrop:SetFrameLevel(frame:GetFrameLevel() + 1)
--     listBackdrop:SetScale(1.01)
--     listBackdrop:SetClipsChildren(true)

--     local content = CreateFrame("Frame", nil, scrollFrame)
--     content:SetSize(370, 1)
--     scrollFrame:SetScrollChild(content)
--     frame.content = content

--     local function RefreshList()
--         for _, child in ipairs({content:GetChildren()}) do
--             child:Hide()
--         end

--         local sortedList = {}
--         for waName, toggleType in pairs(SkillCappedDB.weakauraToggles) do
--             table.insert(sortedList, {name = waName, type = toggleType})
--         end
--         table.sort(sortedList, function(a, b)
--             return a.name:lower() < b.name:lower()
--         end)

--         for i, data in ipairs(sortedList) do
--             local waName = data.name
--             local auraExists = WeakAurasSaved and WeakAurasSaved.displays and WeakAurasSaved.displays[waName]
--             local toggleType = data.type
--             local row = content["row"..i] or CreateFrame("Frame", nil, content)
--             content["row"..i] = row
--             row.waName = waName

--             row:SetSize(375, 26)
--             row:SetPoint("TOPLEFT", 0, -((i - 1) * 28))

--             -- Background
--             if not row.bg then
--                 row.bg = row:CreateTexture(nil, "BACKGROUND")
--                 row.bg:SetAllPoints()
--             end
--             if i % 2 == 0 then
--                 row.bg:SetColorTexture(0.18, 0.18, 0.18, 0.4)
--             else
--                 row.bg:SetColorTexture(0.25, 0.25, 0.25, 0.4)
--             end

--             -- Name Text
--             if not row.nameText then
--                 row.nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
--                 row.nameText:SetPoint("LEFT", 5, 0)
--             end
--             row.nameText:SetText(waName)

--             -- Delete Button
--             if not row.deleteBtn then
--                 row.deleteBtn = CreateFrame("Button", nil, row, "UIPanelCloseButton")
--                 row.deleteBtn:SetSize(21, 21)
--                 row.deleteBtn:SetPoint("RIGHT", -5, 0)
--                 AddTooltip2(row.deleteBtn, "Delete WeakAura from this list.")
--             end
--             row.deleteBtn:SetScript("OnClick", function()
--                 SC:RemoveIgnoreNameRealmFlag(row.waName)
--                 SkillCappedDB.weakauraToggles[row.waName] = nil
--                 RefreshList()
--                 UpdateCustomWeakAuraLoadTogglesOnLogout()
--             end)

--             -- Dropdown
--             if not row.dropdownContainer then
--                 row.dropdownContainer, row.dropdown = CreateDropdown(row, 100, {"PvE", "PvP"}, function(selected)
--                     SkillCappedDB.weakauraToggles[row.waName] = selected
--                     UpdateCustomWeakAuraLoadTogglesOnLogout()
--                 end, toggleType)
--                 row.dropdownContainer:SetPoint("RIGHT", row.deleteBtn, "LEFT", -5, 13)
--                 row.dropdownContainer:SetScale(0.8)
--             end

--             row.dropdown:UpdateOptions({"PvE", "PvP"})
--             row.dropdown:SetDefaultText(SkillCappedDB.weakauraToggles[row.waName] or "PvE")

--             -- Warning Icon if WA not found
--             if not row.warnTexture then
--                 row.warnTexture = row:CreateTexture(nil, "OVERLAY")
--                 row.warnTexture:SetSize(18, 18)
--                 row.warnTexture:SetPoint("RIGHT", row.dropdownContainer, "LEFT", -5, -11)
--                 row.warnTexture:SetAtlas("Professions_Icon_Warning")
--                 row.warnTexture:Hide()

--                 row.warnTexture.tooltipTitle = "WeakAura not found"
--                 row.warnTexture.tooltipText = "The name doesn't match any existing WeakAura.\nAre you sure you've typed it exactly the same?"

--                 row.warnTexture:SetScript("OnEnter", function(self)
--                     GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
--                     GameTooltip:AddLine(self.tooltipTitle, 1, 0.2, 0.2)
--                     GameTooltip:AddLine(self.tooltipText, 1, 1, 1, true)
--                     GameTooltip:Show()
--                 end)
--                 row.warnTexture:SetScript("OnLeave", GameTooltip_Hide)
--             end
--             row.warnTexture:SetShown(not auraExists)

--             row:Show()
--         end

--         content:SetHeight(#sortedList * 28)
--     end

--     local function AddEntry()
--         local waName = strtrim(input:GetText() or "")
--         local selected = typeDropdown.selected or "PvE"
--         if waName ~= "" then
--             SkillCappedDB.weakauraToggles[waName] = selected
--             input:SetText("")
--             RefreshList()
--             UpdateCustomWeakAuraLoadTogglesOnLogout()
--         end
--     end

--     addBtn:SetScript("OnClick", AddEntry)
--     input:SetScript("OnEnterPressed", AddEntry)

--     RefreshList()
-- end

hooksecurefunc("AddonList_Update", function()
    if not AddonList.OkayButton.scTooltip then
        AddTooltip2(AddonList.OkayButton, SC.Logo, "Save currently selected addons to your current UI Mode and Reload UI.")
        hooksecurefunc(AddonList.OkayButton, "SetText", function(self, text)
            if text ~= "Save & Reload" then
                self:SetText("Save & Reload")
            end
        end)
        AddonList.OkayButton.scTooltip = true
    end
    AddonList.OkayButton:SetWidth(120)
    AddonList.OkayButton:SetText("Save & Reload")
    AddonList.shouldReload = true
end)