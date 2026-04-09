local AddonName, SkillCapped = ...
local SC = SkillCapped

local layoutName = "SkillCapped"
local layoutImportString = "1 39 0 0 0 0 0 UIParent 572.3 -915.0 -1 ##$$%/&('%)$+$,$ 0 1 1 7 7 UIParent 0.0 45.0 -1 ##$$%/&('%(#,$ 0 2 1 7 7 UIParent 0.0 45.0 -1 ##$$%/&('%(#,$ 0 3 1 5 5 UIParent -5.0 -77.0 -1 #$$$%/&('%(#,$ 0 4 1 5 5 UIParent -5.0 -77.0 -1 #$$$%/&('%(#,$ 0 5 1 1 4 UIParent 0.0 0.0 -1 ##$$%/&('%(#,# 0 6 1 1 4 UIParent 0.0 -50.0 -1 ##$$%/&('%(#,# 0 7 1 1 4 UIParent 0.0 -100.0 -1 ##$$%/&('%(#,# 0 10 1 7 7 UIParent 0.0 45.0 -1 ##$$&('% 0 11 1 7 7 UIParent 0.0 45.0 -1 ##$$&('%,# 0 12 1 7 7 UIParent 0.0 45.0 -1 ##$$&('% 1 -1 1 4 4 UIParent 0.0 0.0 -1 ##$#%# 2 -1 1 2 2 UIParent 0.0 0.0 -1 ##$#%( 3 0 0 0 0 UIParent 207.2 -66.7 -1 $#3# 3 1 0 0 0 UIParent 395.4 -67.8 -1 %#3# 3 2 0 0 0 UIParent 395.2 -287.2 -1 %#&$3# 3 3 0 0 0 UIParent 272.1 -312.3 -1 '$(#)#-k.G/#1$3# 3 4 0 0 0 UIParent 0.0 -312.6 -1 ,$-/.)/#0#1#2( 3 5 1 5 5 UIParent 0.0 0.0 -1 &#*$3# 3 6 1 5 5 UIParent 0.0 0.0 -1 -#.#/#4& 3 7 1 4 4 UIParent 0.0 0.0 -1 3# 4 -1 1 7 7 UIParent 0.0 45.0 -1 # 5 -1 1 7 7 UIParent 0.0 45.0 -1 # 6 0 1 2 2 UIParent -255.0 -10.0 -1 ##$#%#&.(()( 6 1 1 2 2 UIParent -270.0 -155.0 -1 ##$#%#'+(()( 7 -1 1 7 7 UIParent 0.0 45.0 -1 # 8 -1 0 0 0 UIParent 32.0 -699.8 -1 #%$^%$&7 9 -1 1 7 7 UIParent 0.0 45.0 -1 # 10 -1 1 0 0 UIParent 16.0 -116.0 -1 # 11 -1 1 8 8 UIParent -9.0 85.0 -1 # 12 -1 1 2 2 UIParent -110.0 -275.0 -1 #K$# 13 -1 1 8 8 MicroButtonAndBagsBar 0.0 0.0 -1 ##$#%)&- 14 -1 1 2 2 MicroButtonAndBagsBar 0.0 10.0 -1 ##$#%( 15 0 0 1 1 UIParent 0.0 -2.0 -1 # 15 1 0 1 1 UIParent 0.0 -2.0 -1 # 16 -1 1 5 5 UIParent 0.0 0.0 -1 #( 17 -1 1 1 1 UIParent 0.0 -100.0 -1 ## 18 -1 1 5 5 UIParent 0.0 0.0 -1 #- 19 -1 1 7 7 UIParent 0.0 0.0 -1 ##"
local coloredAddonName = "|cFFFFFFFFSkill|r|cff7ba4fcCapped|r"

StaticPopupDialogs["SC_EDITMODE_FULL"] = {
    text = coloredAddonName.."\n\nRaid Profile layouts are full.\nWe could not install the Skill-Capped layouts.\n\nPlease make room for two layouts and try again.\n(Options->Interface->Raid Frames->Raid Profile)\n\nYou can use the \"Set Profiles\" button in settings to try again after.\n ",
    button1 = "OK",
    OnAccept = function()
        --
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["SC_EDITMODE_FULL_HAS_PROFILE"] = {
    text = coloredAddonName.."\n\nYou already have the\nSkill-Capped raid profile layout.\n\nIf you want the updated version then please delete the old one to make room and click\n\"Set Profiles\" in the Skill-Capped settings.\n ",
    button1 = "OK",
    OnAccept = function()
        --
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["SC_EDITMODE_ONLY_ONE_FREE_SLOT"] = {
    text = coloredAddonName.."\n\nThere was only room for one of\nthe two Skill-Capped raid profile layouts.\nThe profile for 10 man+ raids was not imported.\n\nIf you want both then make sure you\nhave two free slots and then click\n\"Set Profiles\"\nin the Skill-Capped settings.\n ",
    button1 = "OK",
    OnAccept = function()
        --
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

local function SetUIFrameLocations()
    if not SkillCappedBackupDB.Frames then
        SkillCappedBackupDB.Frames = {}
        local backup = SkillCappedBackupDB.Frames
        -- Backup frame positions
        local point, _, relativePoint, xOfs, yOfs

        -- PlayerFrame
        point, _, relativePoint, xOfs, yOfs = PlayerFrame:GetPoint()
        backup.PlayerFrame = {point, "UIParent", relativePoint, xOfs, yOfs}

        -- TargetFrame
        point, _, relativePoint, xOfs, yOfs = TargetFrame:GetPoint()
        backup.TargetFrame = {point, "UIParent", relativePoint, xOfs, yOfs}

        -- FocusFrame
        point, _, relativePoint, xOfs, yOfs = FocusFrame:GetPoint()
        backup.FocusFrame = {point, "UIParent", relativePoint, xOfs, yOfs}
    end
    if not SkillCappedBackupDB.addonBackupTimes["EditMode"] then
        SkillCappedBackupDB["EditMode"] = "SkillCapped PvP"
        SkillCappedBackupDB.addonBackupTimes["EditModePvP"] = SC:GetDateAndTime()
    end
    if not SkillCappedBackupDB["EditModePvP"] then
        SkillCappedBackupDB["EditModePvP"] = true
    end
    PlayerFrame:ClearAllPoints();
    PlayerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 187, -80);
    PlayerFrame:SetUserPlaced(true);
    PlayerFrame:SetClampedToScreen(true);
    PlayerFrame_SetLocked(true);

    TargetFrame:ClearAllPoints();
    TargetFrame:SetPoint("TOP", UIParent, "TOP", -325, -80);
    TargetFrame:SetUserPlaced(true);
    TargetFrame:SetClampedToScreen(true);
    TargetFrame_SetLocked(true);

    FocusFrame:ClearAllPoints();
    FocusFrame:SetPoint("CENTER", UIParent, "CENTER", -325, 123);
    FocusFrame:SetUserPlaced(true);
    FocusFrame:SetClampedToScreen(true);
    FocusFrameMixin:SetLock(true);
end

local function RestoreFramePositions()
    if SkillCappedBackupDB and SkillCappedBackupDB.Frames then
        local backup = SkillCappedBackupDB.Frames

        -- Restore PlayerFrame position
        if backup.PlayerFrame then
            PlayerFrame:ClearAllPoints()
            PlayerFrame:SetPoint(unpack(backup.PlayerFrame))
        end

        -- Restore TargetFrame position
        if backup.TargetFrame then
            TargetFrame:ClearAllPoints()
            TargetFrame:SetPoint(unpack(backup.TargetFrame))
        end

        -- Restore FocusFrame position
        if backup.FocusFrame then
            FocusFrame:ClearAllPoints()
            FocusFrame:SetPoint(unpack(backup.FocusFrame))
        end
    end
end

local function RestoreOtherEditModeSettings()
    -- Restore action bar toggles
    if SkillCappedBackupDB.actionBarToggles then
        local toggles = SkillCappedBackupDB.actionBarToggles
        SetActionBarToggles(toggles[1], toggles[2], toggles[3], toggles[4])
        -- Apply the changes immediately
        -- UIParent_ManageFramePositions()
    end

    -- Restore chat settings
    if SkillCappedBackupDB.chatPosition then
        local chatPoint, chatX, chatY = unpack(SkillCappedBackupDB.chatPosition)
        if chatPoint and chatX and chatY then
            SetChatWindowSavedPosition(1, chatPoint, chatX, chatY)
        end
    end
    if SkillCappedBackupDB.chatSize then
        local chatSizeX, chatSizeY = unpack(SkillCappedBackupDB.chatSize)
        if chatSizeX and chatSizeY then
            SetChatWindowSavedDimensions(1, chatSizeX, chatSizeY)
        end
    end
end

local function CheckProfileSlots()
    local savedProfiles = 0

    -- Count the number of saved profiles
    for i = 1, GetNumRaidProfiles() do
        savedProfiles = savedProfiles + 1
    end

    -- Determine if profiles are full (5 profiles) and if there are two or more free slots (3 or fewer saved profiles)
    local noFreeProfileSlots = savedProfiles == 5
    local twoFreeProfileSlots = savedProfiles <= 3

    -- Return the two status values
    return noFreeProfileSlots, twoFreeProfileSlots
end

local function SetChatWindowSettings()
    SetChatWindowSavedDimensions(1, 296, 120)
    SetChatWindowSavedPosition(1, "BOTTOMLEFT", 0.020509999245405, 0.16807200014591)
end

local function DeleteExistingSkillCappedProfiles()
    if RaidProfileExists("SkillCapped") then
        DeleteRaidProfile("SkillCapped")
    end
    if RaidProfileExists("SkillCappedRaid") then
        DeleteRaidProfile("SkillCappedRaid")
    end
end

local function CreateSkillCappedPartyProfile()
    CreateNewRaidProfile("SkillCapped")
    CompactUnitFrameProfiles_ActivateRaidProfile("SkillCapped")
    local profile = GetActiveRaidProfile()
    SetRaidProfileOption(profile, "frameWidth", 144)
    SetRaidProfileOption(profile, "frameHeight", 72)
    SetRaidProfileOption(profile, "displayPowerBar", true)
    SetRaidProfileOption(profile, "useClassColors", true)
    SetRaidProfileOption(profile, "displayPets", true)
    SetRaidProfileOption(profile, "displayBorder", false)
    SetRaidProfileOption(profile, "sortBy", "group")

    SetRaidProfileOption(profile, "autoActivatePvP", true)
    SetRaidProfileOption(profile, "autoActivatePvE", true)
    local autoActivateOn = {2, 3, 5}
    for _, groupSize in ipairs(autoActivateOn) do
        SetRaidProfileOption(profile, "autoActivate"..groupSize.."Players", true)
    end

    CompactUnitFrameProfiles_ApplyCurrentSettings()


    --SetRaidProfileSavedPosition(profile, false, "TOP", 320, "BOTTOM", 0, "LEFT", 268)
    SetRaidProfileSavedPosition("SkillCapped", false, "TOP", 320, "BOTTOM", 110, "LEFT", 268)
    CompactRaidFrameManager_ResizeFrame_LoadPosition(CompactRaidFrameManager)

    CompactRaidFrameManagerDisplayFrameLockedModeToggle:SetText(UNLOCK)
    CompactRaidFrameManagerDisplayFrameLockedModeToggle.lockMode = false
    CompactRaidFrameManager_UpdateContainerLockVisibility(CompactRaidFrameManager)
    CompactRaidFrameContainer_UpdateDisplayedUnits(CompactRaidFrameContainer)
    CompactRaidFrameContainer_TryUpdate(CompactRaidFrameContainer)
    RaidOptionsFrame_UpdatePartyFrames()
    CompactRaidFrameManager_UpdateShown(CompactRaidFrameManager)
end

local function CreateSkillCappedRaidProfile()
    CreateNewRaidProfile("SkillCappedRaid")
    CompactUnitFrameProfiles_ActivateRaidProfile("SkillCappedRaid")
    local profile = GetActiveRaidProfile()
    SetRaidProfileOption(profile, "frameWidth", 82)
    SetRaidProfileOption(profile, "frameHeight", 38)
    SetRaidProfileOption(profile, "displayPowerBar", true)
    SetRaidProfileOption(profile, "useClassColors", true)
    SetRaidProfileOption(profile, "displayPets", false)
    SetRaidProfileOption(profile, "displayBorder", false)
    SetRaidProfileOption(profile, "sortBy", "group")
    SetRaidProfileOption(profile, "keepGroupsTogether", true)

    SetRaidProfileOption(profile, "autoActivatePvP", true)
    SetRaidProfileOption(profile, "autoActivatePvE", true)
    local autoActivateOn = {10, 15, 20, 40}
    for _, groupSize in ipairs(autoActivateOn) do
        SetRaidProfileOption(profile, "autoActivate"..groupSize.."Players", true)
    end

    CompactUnitFrameProfiles_ApplyCurrentSettings()


    --SetRaidProfileSavedPosition(profile, false, "TOP", 320, "BOTTOM", 0, "LEFT", 0)
    SetRaidProfileSavedPosition(profile, false, "TOP", 194, "BOTTOM", 270, "ATTACHED", 0)
    CompactRaidFrameManager_ResizeFrame_LoadPosition(CompactRaidFrameManager)

    CompactRaidFrameManagerDisplayFrameLockedModeToggle:SetText(UNLOCK)
    CompactRaidFrameManagerDisplayFrameLockedModeToggle.lockMode = false
    CompactRaidFrameManager_UpdateContainerLockVisibility(CompactRaidFrameManager)
    CompactRaidFrameContainer_UpdateDisplayedUnits(CompactRaidFrameContainer)
    CompactRaidFrameContainer_TryUpdate(CompactRaidFrameContainer)
    RaidOptionsFrame_UpdatePartyFrames()
    CompactRaidFrameManager_UpdateShown(CompactRaidFrameManager)
end

local function CreateSkillCappedGroupProfile(groupSize)
    if groupSize == "party" then
        CreateSkillCappedPartyProfile()
    elseif groupSize == "raid" then
        CreateSkillCappedRaidProfile()
    end
    SetActionBarToggles(true, true, true, true)
end

function SC:ForceImportEditModeToSkillCapped()
    if not SkillCappedBackupDB.EditMode then
        -- Backup active profile name
        SkillCappedBackupDB.EditMode = GetActiveRaidProfile()

        -- Backup action bar toggles
        local bar2, bar3, bar4, bar5 = GetActionBarToggles()
        SkillCappedBackupDB.actionBarToggles = {bar2, bar3, bar4, bar5}

        -- Backup Chat settings
        local chatPoint, chatX, chatY = GetChatWindowSavedPosition(1)
        SkillCappedBackupDB.chatPosition = {chatPoint, chatX, chatY}
        local chatSizeX, chatSizeY = GetChatWindowSavedDimensions(1)
        SkillCappedBackupDB.chatSize = {chatSizeX, chatSizeY}

        SkillCappedBackupDB.addonBackupTimes["EditMode"] = SC:GetDateAndTime()
    end
    SetUIFrameLocations()
    SC:ApplyCVarPreset("uiScaleCVars")

    --Adjust chat window
    SetChatWindowSettings()

    -- Delete old profiles and check for space
    DeleteExistingSkillCappedProfiles()
    local noFreeProfileSlots, twoFreeProfileSlots = CheckProfileSlots()

    if noFreeProfileSlots then
        SkillCappedDB.editModeIsFull = true
    else
        if twoFreeProfileSlots then
            CreateSkillCappedGroupProfile("raid")
            CreateSkillCappedGroupProfile("party")
        else
            CreateSkillCappedGroupProfile("party")
            SkillCappedDB.editModeOnlyOneFreeSlot = true
        end
    end
end

-- Function to set the active edit mode layout by name
function SC:SetActiveEditModeLayout(layoutName)
    SetActiveRaidProfile(layoutName)
end

function SC:GetActiveEditModeLayout()
    return GetActiveRaidProfile()
end

function SC:SetEditModeToSkillCappedOrAddIfMissing()
    SC:ApplyCVarPreset("uiScaleCVars")
    SetUIFrameLocations()
    SetChatWindowSettings()

    -- Check if profile exists and set it or create it
    if RaidProfileExists("SkillCapped") and RaidProfileExists("SkillCappedRaid") then
        SetActiveRaidProfile("SkillCapped")
    else
        local noFreeProfileSlots, twoFreeProfileSlots = CheckProfileSlots()

        if noFreeProfileSlots then
            SkillCappedDB.editModeIsFull = true
        else
            if twoFreeProfileSlots then
                CreateSkillCappedGroupProfile("raid")
                CreateSkillCappedGroupProfile("party")
            else
                CreateSkillCappedGroupProfile("party")
                SkillCappedDB.editModeOnlyOneFreeSlot = true
            end
        end
    end
end

function SC:SetEditModeProfileToBackup()
    if not SkillCappedBackupDB.addonBackupTimes["EditMode"] then return end
    SC:RestoreCVars("uiScaleCVars")
    RestoreOtherEditModeSettings()
    RestoreFramePositions()

    if RaidProfileExists(SkillCappedBackupDB.EditMode) then
        SetActiveRaidProfile(SkillCappedBackupDB.EditMode)
        if SkillCappedBackupDB.EditMode ~= "SkillCapped" and SkillCappedBackupDB.EditMode ~= "SkillCappedRaid" then
            DeleteExistingSkillCappedProfiles()
            CompactUnitFrameProfiles_ApplyCurrentSettings()
        end
    else
        local noFreeProfileSlots, twoFreeProfileSlots = CheckProfileSlots()

        if not noFreeProfileSlots then
            CreateNewRaidProfile("Primary")
            SetActiveRaidProfile("Primary")
        else
            for i = 1, GetNumRaidProfiles() do
                local name = GetRaidProfileName(i)
                if name ~= "SkillCapped" and name ~= "SkillCappedRaid" then
                    SetActiveRaidProfile(name)
                    CompactUnitFrameProfiles_ApplyCurrentSettings()
                end
            end
        end
        DeleteExistingSkillCappedProfiles()
        --CompactUnitFrameProfiles_ResetToDefaults()
    end
end

function SC:SetRaidProfile(profile)
    local activeProfile = GetActiveRaidProfile()
    if activeProfile == profile then
        return
    end

    if not RaidProfileExists(profile) then
        return
    end

    if CompactUnitFrameProfiles_ActivateRaidProfile then
        CompactUnitFrameProfiles_ActivateRaidProfile(profile)
    end
end

function SC:IsInLargeGroup()
    return GetNumGroupMembers() > 4
end