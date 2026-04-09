local AddonName, SkillCapped = ...
local SC = SkillCapped

local layoutImportStringPvP = "2 50 0 0 0 0 0 UIParent 572.3 -914.0 -1 ##$$%/&('%)$+$,$ 0 1 1 7 7 UIParent 0.0 45.0 -1 ##$$%/&('%(#,$ 0 2 1 7 7 UIParent 0.0 45.0 -1 ##$$%/&('%(#,$ 0 3 1 5 5 UIParent -5.0 -77.0 -1 #$$$%/&('%(#,$ 0 4 1 5 5 UIParent -5.0 -77.0 -1 #$$$%/&('%(#,$ 0 5 0 8 6 MainActionBar -4.0 0.0 -1 ##$&%/&('%(#,# 0 6 0 6 8 MainActionBar 4.0 0.0 -1 ##$&%/&('%(#,# 0 7 0 0 0 UIParent -0.0 -0.0 -1 #$$$%/&('%(#,# 0 10 1 7 7 UIParent 0.0 45.0 -1 ##$$&('% 0 11 1 7 7 UIParent 0.0 45.0 -1 ##$$&('%,# 0 12 1 7 7 UIParent 0.0 45.0 -1 ##$$&('% 1 -1 1 4 4 UIParent 0.0 0.0 -1 ##$#%# 2 -1 1 2 2 UIParent 0.0 0.0 -1 ##$#%( 3 0 0 0 0 UIParent 207.2 -66.7 -1 $#3# 3 1 0 0 0 UIParent 395.4 -67.8 -1 %#3# 3 2 0 0 0 UIParent 395.2 -287.2 -1 %#&$3# 3 3 0 0 0 UIParent 272.1 -312.3 -1 '$(#)#-k.G/#1$3#5#627-7$ 3 4 0 0 0 UIParent 0.0 -312.2 -1 ,%-/.)/#0#1#2(5#6(7-7$ 3 5 1 5 5 UIParent 0.0 0.0 -1 &$*$3# 3 6 1 5 5 UIParent 0.0 0.0 -1 -#.#/#4&5#6(7-7$ 3 7 1 4 4 UIParent 0.0 0.0 -1 3# 4 -1 1 7 7 UIParent 0.0 45.0 -1 # 5 -1 1 7 7 UIParent 0.0 45.0 -1 # 6 0 1 2 2 UIParent -255.0 -10.0 -1 ##$#%#&.(()( 6 1 1 2 2 UIParent -270.0 -155.0 -1 ##$#%#'+(()(-$ 6 2 0 0 0 UIParent 483.2 -457.5 -1 ##$#%#&.(()(+#,-,$ 7 -1 1 7 7 UIParent 0.0 45.0 -1 # 8 -1 0 0 0 UIParent 32.0 -679.9 -1 #%$^%$&7 9 -1 1 7 7 UIParent 0.0 45.0 -1 # 10 -1 1 0 0 UIParent 16.0 -116.0 -1 # 11 -1 1 8 8 UIParent -9.0 85.0 -1 # 12 -1 1 2 2 UIParent -110.0 -275.0 -1 #K$#%# 13 -1 1 8 8 MicroButtonAndBagsBar 0.0 0.0 -1 ##$#%)&- 14 -1 1 2 2 MicroButtonAndBagsBar 0.0 10.0 -1 ##$#%( 15 0 0 1 1 UIParent 0.0 -2.0 -1 # 15 1 0 1 1 UIParent 0.0 -2.0 -1 # 16 -1 1 5 5 UIParent 0.0 0.0 -1 #( 17 -1 1 1 1 UIParent 0.0 -100.0 -1 ## 18 -1 1 5 5 UIParent 0.0 0.0 -1 #- 19 -1 1 7 7 UIParent 0.0 0.0 -1 ## 20 0 0 4 4 UIParent 0.0 100.0 -1 ##$/%$&('%(-($)%+$,$-$ 20 1 0 4 4 UIParent 0.0 0.0 -1 ##$*%$&('%(-($)%+$,$-$ 20 2 0 4 4 UIParent 100.0 0.0 -1 #$$$%$&''((-($)#+$,$-$ 20 3 1 7 7 UIParent 420.0 430.0 -1 #$$$%#&('((-($)%*#+$,$-$.-.$ 21 -1 0 0 0 UIParent 776.3 -545.9 -1 #$$# 22 0 0 0 0 UIParent 1059.9 -192.6 -1 #$$$%#&('&(#)U*$+$,$-$.#/U0# 22 1 1 1 1 UIParent 0.0 -40.0 -1 &('&)U*#+$ 22 2 1 1 1 UIParent 0.0 -90.0 -1 &('&)U*#+$ 22 3 1 1 1 UIParent 0.0 -130.0 -1 &('&)U*#+$ 23 -1 1 0 0 UIParent 0.0 0.0 -1 ##$#%$&-&$'7(%)U+$,$-$.(/U"
local layoutImportStringPvPArcUI = "2 50 0 0 0 0 0 UIParent 572.3 -914.0 -1 ##$$%/&('%)$+$,$ 0 1 1 7 7 UIParent 0.0 45.0 -1 ##$$%/&('%(#,$ 0 2 1 7 7 UIParent 0.0 45.0 -1 ##$$%/&('%(#,$ 0 3 1 5 5 UIParent -5.0 -77.0 -1 #$$$%/&('%(#,$ 0 4 1 5 5 UIParent -5.0 -77.0 -1 #$$$%/&('%(#,$ 0 5 0 8 6 MainActionBar -4.0 0.0 -1 ##$&%/&('%(#,# 0 6 0 6 8 MainActionBar 4.0 0.0 -1 ##$&%/&('%(#,# 0 7 0 0 0 UIParent -0.0 -0.0 -1 #$$$%/&('%(#,# 0 10 1 7 7 UIParent 0.0 45.0 -1 ##$$&('% 0 11 1 7 7 UIParent 0.0 45.0 -1 ##$$&('%,# 0 12 1 7 7 UIParent 0.0 45.0 -1 ##$$&('% 1 -1 1 4 4 UIParent 0.0 0.0 -1 ##$#%# 2 -1 1 2 2 UIParent 0.0 0.0 -1 ##$#%( 3 0 0 0 0 UIParent 207.2 -66.7 -1 $#3# 3 1 0 0 0 UIParent 395.4 -67.8 -1 %#3# 3 2 0 0 0 UIParent 395.2 -287.2 -1 %#&$3# 3 3 0 0 0 UIParent 272.1 -312.3 -1 '$(#)#-k.G/#1$3#5#627-7$ 3 4 0 0 0 UIParent 0.0 -312.2 -1 ,%-/.)/#0#1#2(5#6(7-7$ 3 5 1 5 5 UIParent 0.0 0.0 -1 &$*$3# 3 6 1 5 5 UIParent 0.0 0.0 -1 -#.#/#4&5#6(7-7$ 3 7 1 4 4 UIParent 0.0 0.0 -1 3# 4 -1 1 7 7 UIParent 0.0 45.0 -1 # 5 -1 1 7 7 UIParent 0.0 45.0 -1 # 6 0 1 2 2 UIParent -255.0 -10.0 -1 ##$#%#&.(()( 6 1 1 2 2 UIParent -270.0 -155.0 -1 ##$#%#'+(()(-$ 6 2 0 0 0 UIParent 483.2 -457.5 -1 ##$#%#&.(()(+#,-,$ 7 -1 1 7 7 UIParent 0.0 45.0 -1 # 8 -1 0 0 0 UIParent 32.0 -679.9 -1 #%$^%$&7 9 -1 1 7 7 UIParent 0.0 45.0 -1 # 10 -1 1 0 0 UIParent 16.0 -116.0 -1 # 11 -1 1 8 8 UIParent -9.0 85.0 -1 # 12 -1 1 2 2 UIParent -110.0 -275.0 -1 #K$#%# 13 -1 1 8 8 MicroButtonAndBagsBar 0.0 0.0 -1 ##$#%)&- 14 -1 1 2 2 MicroButtonAndBagsBar 0.0 10.0 -1 ##$#%( 15 0 0 1 1 UIParent 0.0 -2.0 -1 # 15 1 0 1 1 UIParent 0.0 -2.0 -1 # 16 -1 1 5 5 UIParent 0.0 0.0 -1 #( 17 -1 1 1 1 UIParent 0.0 -100.0 -1 ## 18 -1 1 5 5 UIParent 0.0 0.0 -1 #- 19 -1 1 7 7 UIParent 0.0 0.0 -1 ## 20 0 0 4 4 UIParent 0.0 100.4 -1 ##$/%$&('%(-($)#+$,$-$ 20 1 0 4 4 UIParent 0.0 -0.0 -1 ##$*%$&('%(-($)#+$,$-$ 20 2 0 4 4 UIParent 0.0 200.0 -1 #$$$%$&''((-($)#+#,$-$ 20 3 1 7 7 UIParent 420.0 430.0 -1 #$$$%#&('((-($)%*#+$,$-$.-.$ 21 -1 0 0 0 UIParent 776.3 -545.9 -1 #$$# 22 0 0 0 0 UIParent 1059.9 -192.6 -1 #$$$%#&('&(#)U*$+$,$-$.#/U0# 22 1 1 1 1 UIParent 0.0 -40.0 -1 &('&)U*#+$ 22 2 1 1 1 UIParent 0.0 -90.0 -1 &('&)U*#+$ 22 3 1 1 1 UIParent 0.0 -130.0 -1 &('&)U*#+$ 23 -1 1 0 0 UIParent 0.0 0.0 -1 ##$#%$&-&$'7(%)U+$,$-$.(/U"
local layoutImportStringPvE = layoutImportStringPvP
local tbc_layoutImportStringPvP = "2 28 0 0 0 7 7 UIParent 20.0 2.0 -1 ##$$%/&('))$+#,$ 0 1 0 8 2 MainActionBar 0.0 4.0 -1 ##$$%/&(')(#,$ 0 2 0 6 0 MultiBarBottomLeft 0.0 4.0 -1 ##$$%/&(')(#,$ 0 3 1 5 5 UIParent -2.0 -35.0 -1 #$$$%/&(')(#,$ 0 4 1 5 5 UIParent -2.0 -35.0 -1 #$$$%/&(')(#,$ 0 5 1 1 4 UIParent 0.0 0.0 -1 ##$$%/&(')(#,# 0 6 1 1 4 UIParent 0.0 -50.0 -1 ##$$%/&(')(#,# 0 7 1 1 4 UIParent 0.0 -100.0 -1 ##$$%/&(')(#,# 0 10 0 6 0 MultiBarBottomRight 0.0 4.0 -1 ##$$&('* 0 11 1 6 7 UIParent -441.0 50.0 -1 ##$$&('+,# 0 12 0 6 0 StanceBar 0.0 4.0 -1 ##$$&('* 1 -1 0 0 0 UIParent 749.3 -736.0 -1 ##$# 2 -1 1 2 2 UIParent 0.0 0.0 -1 ##$#%( 3 0 0 0 0 UIParent 209.1 -82.7 -1 3# 3 1 0 0 0 UIParent 398.6 -82.7 -1 %#3# 3 2 0 0 0 UIParent 397.3 -303.0 -1 %#&#3# 3 3 0 0 0 UIParent 273.3 -313.0 -1 '$(#)#-k.G/#1$3# 3 4 0 0 0 UIParent -0.0 -424.2 -1 ,$-#.#/#0#1#2( 3 7 1 4 4 UIParent 0.0 0.0 -1 3# 6 0 1 2 2 UIParent -187.0 -13.0 -1 ##$#%#&.(()( 6 1 1 2 2 UIParent -202.0 -152.0 -1 ##$#%#'+(*)( 8 -1 0 0 0 UIParent 32.0 -682.2 -1 #%$k%$&6 9 -1 0 0 0 UIParent 624.3 -738.0 -1 # 13 -1 0 7 7 UIParent 766.9 2.0 -1 ##$#%% 14 -1 0 8 2 MicroMenuContainer 0.4 3.6 -1 ##$#%$&( 15 0 0 0 0 UIParent 341.3 1.0 -1 # 15 1 0 0 0 UIParent 341.3 1.0 -1 # 16 -1 1 5 5 UIParent 0.0 0.0 -1 #("

function SC:GetEditModeLayoutString(contentType, role)
    if contentType == "PvP" then
        if SC.isTBC then
            return tbc_layoutImportStringPvP, "SkillCapped"
        elseif SC.ArcUIEnabled then
            return layoutImportStringPvPArcUI, "SkillCapped"
        else
            return layoutImportStringPvP, "SkillCapped"
        end
    elseif contentType == "PvE" then
        if role == "Healer" then
            return layoutImportStringPvE, "SkillCapped PvE"
        elseif role == "DPS/Tank" then
            return layoutImportStringPvE, "SkillCapped PvE"
        else
            return layoutImportStringPvE, "SkillCapped PvE"
        end
    end
end

StaticPopupDialogs["SC_EDITMODE_FULL"] = {
    text = SC.Logo.."  \n\n|A:Ping_Marker_Icon_Warning:22:22|aEdit Mode layouts are full|A:Ping_Marker_Icon_Warning:22:22|a\nWe could not install the Skill-Capped layout(s).\n\nPlease make room for the Edit Mode profiles.\nYou can enter Edit Mode by right-clicking your PlayerFrame.\nPvP and PvE Profile requires 1 slot each.\nIf you are installing both you will need 2 free slots.\n\nYou can use the \"Set Profiles\" button in /sc settings to try again once you have made room.\n",
    button1 = "OK",
    OnAccept = function()
        --
    end,
    timeout = 0,
    whileDead = true,
    OnShow = function(self)
        self.ButtonContainer.Button1:Disable()
        local function UpdateButtonText(remainingTime)
            if remainingTime > 1 then
                self.ButtonContainer.Button1:SetText("Reading time left: "..remainingTime - 1 .. "")
                C_Timer.After(1, function() UpdateButtonText(remainingTime - 1) end)
            else
                self.ButtonContainer.Button1:SetText("OK")
                self.ButtonContainer.Button1:Enable()
            end
        end
        UpdateButtonText(8)
    end,
}

StaticPopupDialogs["SC_EDITMODE_FULL_HAS_PROFILE"] = {
    text = SC.Logo.."\n\nYou already have the Skill-Capped\nEdit Mode layout for: %s\n\nIf you want to make sure you have the\nmost up-to-date version(s) then:\n\n1) Open Edit Mode and delete the old one(s).\n2) Click \"Set Profiles\" in the Skill-Capped settings.\n",
    button1 = "OK",
    OnAccept = function()
    end,
    timeout = 0,
    whileDead = true,
    OnShow = function(self)
        self.ButtonContainer.Button1:Disable()
        local function UpdateButtonText(remainingTime)
            if remainingTime > 1 then
                self.ButtonContainer.Button1:SetText(remainingTime - 1 .. "...")
                C_Timer.After(1, function() UpdateButtonText(remainingTime - 1) end)
            else
                self.ButtonContainer.Button1:SetText("OK")
                self.ButtonContainer.Button1:Enable()
            end
        end
        UpdateButtonText(8)
    end,
}

local deleteQueue = {}
local cvarsApplied
local editModeShenanigans

local function EditModeShenanigans()
    if editModeShenanigans then return end
    editModeShenanigans = true
    SC:ShowFakeUI()
    SetUIVisibility(true) -- Make sure UI is visible before opening Edit Mode otherwise it causes lua errors.
    if EditModeManagerFrame and EditModeManagerFrame.AccountSettings then
        ShowUIPanel(EditModeManagerFrame)
    end
    if EditModeManagerFrame and EditModeManagerFrame.AccountSettings then
        HideUIPanel(EditModeManagerFrame)
    end
end

function SC:HasOneFreeEditModeSlot()
    local layouts = C_EditMode.GetLayouts()  -- Retrieve all current layouts
    local totalSlots = 5  -- Maximum number of Edit Mode slots
    local usedSlots = #layouts.layouts  -- Count of currently used slots

    return (totalSlots - usedSlots) >= 1  -- Returns true if there is at least 1 free slot
end

function SC:ForceImportEditModeToSkillCapped(contentType, role, force)
    local activeLayoutName = SC:GetActiveEditModeLayout()
    if not SkillCappedBackupDB.addonBackupTimes["EditMode"] then
        SkillCappedBackupDB["EditMode"] = activeLayoutName
        SkillCappedBackupDB.addonBackupTimes["EditMode"] = SC:GetDateAndTime()
    end
    if not SkillCappedBackupDB["EditMode" .. contentType] then
        SkillCappedBackupDB["EditMode" .. contentType] = true
    end
    -- Track execution state to avoid duplicate runs
    if self.processedEditMode then
        return -- Exit early if already processed
    end

    -- Check if both checkboxes are enabled
    local pvpEnabled = SC:EditModeCheckboxEnabled("PvP")
    local pveEnabled = SC:EditModeCheckboxEnabled("PvE")


    EditModeShenanigans()
    if not cvarsApplied then
        local cvarsToApply = SkillCappedDB.mainContent == "PvP" and "uiScaleCVars" or "uiScaleCVarsPvE"
        if not SkillCappedDB.nameplateShowSelfSkip then
            C_CVar.SetCVar("nameplateShowSelf", "1")
        end
        SC:ApplyCVarPreset(cvarsToApply)
        cvarsApplied = true
    end

    -- Get existing layouts and prepare variables for tracking duplicates
    local layouts = C_EditMode.GetLayouts()
    local latestIndices = {}  -- Store the latest index for each unique name
    deleteQueue = {}  -- Clear deleteQueue for fresh tracking

    -- Function to import a layout
    local function ImportLayout(layoutImportString, layoutName)
        local layoutInfo = C_EditMode.ConvertStringToLayoutInfo(layoutImportString)
        local layoutType = EditModeImportLayoutDialog.CharacterSpecificLayoutCheckButton:IsControlChecked() and Enum.EditModeLayoutType.Character or Enum.EditModeLayoutType.Account
        EditModeManagerFrame:ImportLayout(layoutInfo, layoutType, layoutName)
    end

    local pvpLayoutExists
    local pveLayoutExists
    for i, layoutInfo in ipairs(layouts.layouts) do
        if layoutInfo.layoutName == "SkillCapped" then
            pvpLayoutExists = true
        end
        if layoutInfo.layoutName == "SkillCapped PvE" then
            pveLayoutExists = true
        end
    end
    -- Calculate required free slots
    local requiredSlots = 0
    if pvpEnabled or pveEnabled then
        requiredSlots = 1
    end
    if pveEnabled and pvpEnabled then
        requiredSlots = 2
    end

    -- Handle slot availability
    local availableSlots = 5 - #layouts.layouts

    -- Not enough slots
    if requiredSlots > availableSlots then
        if (pvpEnabled and pvpLayoutExists) and (pveEnabled and pveLayoutExists) then
            SkillCappedDB.editModeFullButHasProfile = "PvE & PvP"
        elseif pvpEnabled and pvpLayoutExists then
            SkillCappedDB.editModeFullButHasProfile = "PvP"
        elseif pveEnabled and pveLayoutExists then
            SkillCappedDB.editModeFullButHasProfile = "PvE"
        else
            SkillCappedDB.editModeIsFull = true
        end
        return
    end

    -- Handle PvP layout
    if pvpEnabled or force == "PvP" then
        local layoutImportString, layoutName = SC:GetEditModeLayoutString("PvP")
        ImportLayout(layoutImportString, layoutName)
    end

    -- Handle PvE layout
    if pveEnabled or force == "PvE" then
        local layoutImportString, layoutName
        if SC:IsHealerSpec() then
            layoutImportString, layoutName = SC:GetEditModeLayoutString("PvE", "Healer")
        else
            layoutImportString, layoutName = SC:GetEditModeLayoutString("PvE", "DPS/Tank")
        end
        ImportLayout(layoutImportString, layoutName)
    end

    -- Re-fetch layouts and flag duplicates
    layouts = C_EditMode.GetLayouts()  -- Refresh after import
    for i, layoutInfo in ipairs(layouts.layouts) do
        local layoutName = layoutInfo.layoutName
        --print("Found Layout: " .. layoutName)
        if not latestIndices[layoutName] then
            -- Store the first occurrence (adjust index for EditModeManagerFrame)
            latestIndices[layoutName] = i + 2
        else
            -- Add the first occurrence to deleteQueue (adjust for offset)
            table.insert(deleteQueue, latestIndices[layoutName])
            --print("Marked old layout '" .. layoutName .. "' for deletion at index: " .. latestIndices[layoutName])
            -- Update to keep the second occurrence
            latestIndices[layoutName] = i + 2
        end
    end
    -- -- Set active layout based on main content and role
    -- if SkillCappedDB.mainContent == "PvP" then
    --     local layoutImportString, layoutName = SC:GetEditModeLayoutString("PvP")
    --     SC:SetActiveEditModeLayout(layoutName)
    -- elseif SkillCappedDB.mainContent == "PvE" then
    --     local roleToUse = SC:IsHealerSpec() and "Healer" or "DPS/Tank"
    --     local layoutImportString, layoutName = SC:GetEditModeLayoutString("PvE", roleToUse)
    --     SC:SetActiveEditModeLayout(layoutName)
    -- end

    -- Handle deletion logic
    for i = #deleteQueue, 1, -1 do
        local deleteIndex = deleteQueue[i]
        if layouts.layouts[deleteIndex - 2] then  -- Ensure it's still valid
            --print("Deleting layout at index: " .. deleteIndex)
            EditModeManagerFrame:DeleteLayout(deleteIndex)
        end
    end
    deleteQueue = {}  -- Clear queue after deletion

    if SkillCappedDB.mainContent == "PvP" then
        local layoutImportString, layoutName = SC:GetEditModeLayoutString("PvP")
        SC:SetActiveEditModeLayout(layoutName)
    elseif SkillCappedDB.mainContent == "PvE" then
        local roleToUse = SC:IsHealerSpec() and "Healer" or "DPS/Tank"
        local layoutImportString, layoutName = SC:GetEditModeLayoutString("PvE", roleToUse)
        SC:SetActiveEditModeLayout(layoutName)
    end

    -- Mark as processed to avoid reprocessing
    self.processedEditMode = true
end


-- Function to set the active edit mode layout by name
function SC:SetActiveEditModeLayout(layoutName)
    local layouts = C_EditMode.GetLayouts()
    for i, layoutInfo in ipairs(layouts.layouts) do
        if layoutInfo.layoutName == layoutName then
            local layoutIndex = i + 2 -- Add 2 to adjust for Blizzard's default layouts
            C_EditMode.SetActiveLayout(layoutIndex)
            break
        end
    end
    SC.detailsReload = nil
    if SC.detailsReloadPvE then
        SC:UpdateDetailsProfile()
    end
    if SC.detailsReloadPvP then
        SC:UpdateDetailsProfile()
    end
    SC.detailsReload = true
end

function SC:GetActiveEditModeLayout()
    local activeLayout = EditModeManagerFrame:GetActiveLayoutInfo()
    if activeLayout then
        local activeLayoutName = activeLayout.layoutName
        return activeLayoutName
    end
end

function SC:SetEditModeToSkillCappedOrAddIfMissing(contentType, role)
    SC.detailsReload = nil
    if SC.detailsReloadPvE then
        SC:UpdateDetailsProfile()
    end
    if not cvarsApplied then
        local cvarsToApply = SkillCappedDB.mainContent == "PvP" and "uiScaleCVars" or "uiScaleCVarsPvE"
        SC:ApplyCVarPreset(cvarsToApply)
        cvarsApplied = true
    end

    if SC.detailsReloadPvP then
        SC:UpdateDetailsProfile()
    end
    SC.detailsReload = true

    -- if self.processedEditMode then
    --     return -- Exit early if already processed
    -- end

    EditModeShenanigans()

    local layoutImportString, layoutName = SC:GetEditModeLayoutString(contentType, role)
    local layouts = C_EditMode.GetLayouts()
    local layoutExists = false

    -- Check if the layout already exists and get its index
    for i, layoutInfo in ipairs(layouts.layouts) do
        if layoutInfo.layoutName == layoutName then
            layoutExists = true
            break
        end
    end

    if SkillCappedDB.mainContent == nil then
        SkillCappedDB.mainContent = "PvP"
        SkillCappedDB.characters[SC:GetPlayerNameAndRealm()] = SkillCappedDB.mainContent
        SkillCappedDB.secondaryContent = "PvE"
    end

    -- If layout exists, set it as active and apply settings
    if layoutExists then
        if (SkillCappedDB.mainContent == "PvP" and layoutName == "SkillCapped") or
           (SkillCappedDB.mainContent == "PvE" and layoutName == "SkillCapped PvE") then
            SC:SetActiveEditModeLayout(layoutName)
        end
    else
        -- Check if layout limit is reached (5 layouts max)
        if #layouts.layouts == 5 then
            SkillCappedDB.editModeIsFull = true
            return
        end

        -- Import new layout if it doesn't exist
        local layoutInfo = C_EditMode.ConvertStringToLayoutInfo(layoutImportString)
        local layoutType = EditModeImportLayoutDialog.CharacterSpecificLayoutCheckButton:IsControlChecked() and Enum.EditModeLayoutType.Character or Enum.EditModeLayoutType.Account
        EditModeManagerFrame:ImportLayout(layoutInfo, layoutType, layoutName)

        -- Set the newly imported layout as active
        local activeName = SkillCappedDB.mainContent == "PvE" and "SkillCapped PvE" or "SkillCapped"
        SC:SetActiveEditModeLayout(activeName)
    end

    -- Mark as processed to avoid reprocessing
    --self.processedEditMode = true
end



function SC:SetEditModeProfileToBackup()
    EditModeShenanigans()

    local layouts = C_EditMode.GetLayouts()
    local targetLayoutName = SkillCappedBackupDB["EditMode"]
    local layoutIndex = nil
    local deleteQueue = {}

    if targetLayoutName == "Modern" then
        layoutIndex = 1  -- Index for Modern
    elseif targetLayoutName == "Classic" then
        layoutIndex = 2  -- Index for Classic
    end

    -- Search for custom layouts including SkillCapped PvP, PvE Heal, and PvE DPS/Tank
    for i, layoutInfo in ipairs(layouts.layouts) do
        local adjustedIndex = i + 2  -- Adjust for indexing due to Blizzard defaults

        if layoutInfo.layoutName == targetLayoutName then
            layoutIndex = adjustedIndex
        end
        if layoutInfo.layoutName == "SkillCapped" then
            table.insert(deleteQueue, adjustedIndex)
        end
        if layoutInfo.layoutName == "SkillCapped PvE" then
            table.insert(deleteQueue, adjustedIndex)
        end
        -- if layoutInfo.layoutName == "SkillCapped PvE Heal" then
        --     table.insert(deleteQueue, adjustedIndex)
        -- end
        -- if layoutInfo.layoutName == "SkillCapped PvE DPS/Tank" then
        --     table.insert(deleteQueue, adjustedIndex)
        -- end
    end

    -- Sort the delete queue in reverse order to prevent indexing issues
    table.sort(deleteQueue, function(a, b) return a > b end)

    -- Delete SkillCapped layouts starting from the highest index
    for _, index in ipairs(deleteQueue) do
        EditModeManagerFrame:DeleteLayout(index)
    end

    -- If a valid layout index is found, set it as active
    if layoutIndex then
        C_EditMode.SetActiveLayout(layoutIndex)
    end

    if SkillCappedBackupDB["EditMode"] then
        SC:SetActiveEditModeLayout(SkillCappedBackupDB["EditMode"])
    end

    -- Restore CVars after applying backup
    SC:RestoreCVars("uiScaleCVars")
end