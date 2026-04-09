local AddonName, SkillCapped = ...
local SC = SkillCapped
local coloredAddonName = "|cFFFFFFFFSkill|r|cff7ba4fcCapped|r"
local scIcon = "|TInterface/AddOns/SkillCapped/media/icon.blp:16:16:0:0|t"
SC.scIcon = scIcon
SC.Logo = scIcon..coloredAddonName.."  "

function SC:Print(msg)
    print(scIcon..coloredAddonName..": "..msg)
end

local LSM = LibStub("LibSharedMedia-3.0")
LSM:Register("font", "Prototype", [[Interface\Addons\SkillCapped\media\fonts\Prototype.ttf]])
LSM:Register("statusbar", "Blizzard DF", [[Interface\TargetingFrame\UI-TargetingFrame-BarFill]])

function SC:DefaultSettings()
    if SC:IsRetail() then
        return {
            playerEliteMode = 1,
            minimapIconPos = {["minimapPos"] = 198.6906032777571},
            bisListShown = true,
            -- hidePvEWeakAurasInPvP = true,
            -- hidePvPWeakAurasInPvE = true,
        }
    else
        return {
            playerElite = true,
            playerEliteMode = 1,
            hideErrorFrame = true,
            hideHitIndicator = true,
            newFonts = true,
            queuePopNotification = false,
            fadeStatusBar = true,
            combinedBags = "1",
            ReplaceMyPlayerPortrait = "1",
            --nameplateShowSelf = "0",
            --nameplateResourceOnTarget  = "1",
            skipAltReload = false,
            hideActionBarArt = true, -- cata only
            fadeMirrorImageNameplates = true, --cata only
            toggleFriendlyNameplates = true, -- cata only
        }
    end
end

local events = {}
local eventFrame = CreateFrame("Frame")
eventFrame:SetScript("OnEvent", function(frame, event, ...)
    if events[event] then
        for _, handler in ipairs(events[event]) do
            handler(...)
        end
    end
end)

function SC:RegisterEvent(event, func)
    if not events[event] then
        events[event] = {}
        eventFrame:RegisterEvent(event)
    end
    table.insert(events[event], func)
    return func  -- Return the function reference
end

function SC:UnregisterEvent(event, func)
    if not events[event] then
        return  -- No event registered, nothing to do
    end

    -- Remove the specific function from the list
    for i, handler in ipairs(events[event]) do
        if handler == func then
            table.remove(events[event], i)
            break
        end
    end

    -- If no more handlers are left for this event, unregister it completely
    if #events[event] == 0 then
        eventFrame:UnregisterEvent(event)
        events[event] = nil
    end
end

local hiddenFrame = CreateFrame("Frame")
hiddenFrame:Hide()
hiddenFrame:SetAlpha(0)
hiddenFrame:SetFrameStrata("BACKGROUND")
hiddenFrame:SetFrameLevel(0)
SC.hiddenFrame = hiddenFrame
local uiParent

function SC:HideTutorialShowUI()
    SC:ShowUI()
    hiddenFrame:Show()
    hiddenFrame:SetAlpha(1)

    if SkillCappedTutorial then
        SkillCappedTutorial:Hide()
    end
    if SettingsPanel then
        SettingsPanel:SetParent(UIParent)
    end
end

function SC:HideUIShowTutorial()
    if SettingsPanel then
        SettingsPanel:SetParent(hiddenFrame)
    end
    hiddenFrame:Hide()
    hiddenFrame:SetAlpha(0)
    SC:HideUI()

    if SkillCappedTutorial then
        SkillCappedTutorial:Show()
        --SC:TutorialStart()
        --SC:ReadyInstallationFrame()
    end
end

function SC:HideUI()
    if not uiParent then
        uiParent = UIParent:GetParent()
    end
    UIParent:SetParent(hiddenFrame)
    Minimap:Hide()
end

function SC:ShowUI()
    UIParent:SetParent(uiParent)
    Minimap:Show()
end

function SC:ShowFakeUI()
    SC.hiddenFrame:Show()
end

function SC:HideFakeUI()
    SC.hiddenFrame:Hide()
end

function SC:RunAfterCombat(func, msg)
    if UnitAffectingCombat("player") or InCombatLockdown() then
        local handlerTest
        handlerTest = SC:RegisterEvent("PLAYER_REGEN_ENABLED", function()
            func()  -- Execute the function after combat
            SC:UnregisterEvent("PLAYER_REGEN_ENABLED", handlerTest)
        end)
        if msg then
            SC:Print(msg)
        end
    else
        func()
    end
end

function SC:FadeOutFrame(frame, duration)
    UIFrameFadeOut(frame, duration, 1, 0)
end

function SC:FadeInFrame(frame, duration)
    UIFrameFadeIn(frame, duration, 0, 1)
end

local character = UnitGUID("player")
local loaded
loaded = SC:RegisterEvent("ADDON_LOADED", function()
    --- From BlizzBugsSuck:
	-- Fix glitchy-ness of EnableAddOn/DisableAddOn API, which affects the stability of the default
	-- UI's addon management list (both in-game and glue), as well as any addon-management addons.
	-- The problem is caused by broken defaulting logic used to merge AddOns.txt settings across
	-- characters to those missing a setting in AddOns.txt, whereby toggling an addon for a single character
	-- sometimes results in also toggling it for a different character on that realm for no obvious reason.
	-- The code below ensures each character gets an independent enable setting for each installed
	-- addon in its AddOns.txt file, thereby avoiding the broken defaulting logic.
	-- Note the fix applies to each character the first time it loads there, and a given character
	-- is not protected from the faulty logic on addon X until after the fix has run with addon X
	-- installed (regardless of enable setting) and the character has logged out normally.
	for i = 1, C_AddOns.GetNumAddOns() do
		local enabled = C_AddOns.GetAddOnEnableState(i, character) > 0
		AddonList.startStatus[i] = enabled
		if enabled then
			C_AddOns.EnableAddOn(i, character)
		else
			C_AddOns.DisableAddOn(i, character)
		end
	end

    SC:UnregisterEvent("ADDON_LOADED", loaded)
end)

local function HasAnyChanged()
    local checkIfOutOfDate = false
    if AddonList.outOfDate and not C_AddOns.IsAddonVersionCheckEnabled() then
        return true
    elseif not AddonList.outOfDate and C_AddOns.IsAddonVersionCheckEnabled() then
        checkIfOutOfDate = true
    end

    for i = 1, C_AddOns.GetNumAddOns() do
        local enabled = C_AddOns.GetAddOnEnableState(i, character) > 0
        local _, _, _, loadable, reason = C_AddOns.GetAddOnInfo(i)
        if checkIfOutOfDate and enabled and not loadable and reason == "INTERFACE_VERSION" then
            return true
        end
        if enabled ~= AddonList.startStatus[i] and reason ~= "DEP_DISABLED" then
            return true
        end
    end
    return false
end

local function CheckAddonDependencies(...)
	for i = 1, select("#", ...) do
		local dep = select(i, ...)
		if C_AddOns.GetAddOnEnableState(dep, character) == 0 then
			return false
		end
	end
	return true
end

local function InitAddonFix(entry, treeNode)
    local addonIndex = treeNode:GetData().addonIndex
    local checkbox = entry.Enabled
    local status = entry.Status

    local enabled = C_AddOns.GetAddOnEnableState(addonIndex, character) > 0
    if enabled then
        local depsEnabled = CheckAddonDependencies(C_AddOns.GetAddOnDependencies(addonIndex))
        if not depsEnabled then
            --title:SetTextColor(1.0, 0.1, 0.1)
            status:SetText(_G.ADDON_DISABLED)
            checkbox:SetChecked(false)
        end
    end
end

if AddonList_InitAddon then
    hooksecurefunc("AddonList_InitAddon", InitAddonFix)
end

-- function SC:GetAspectRatio()
--     -- Get the current screen resolution
--     local screenWidth, screenHeight = GetPhysicalScreenSize()

--     -- Calculate the aspect ratio
--     local aspectRatio = screenWidth / screenHeight

--     local commonRatios = {
--         {ratio = 4/3,   name = "4:3"},    -- Standard
--         {ratio = 16/9,  name = "16:9"},   -- Widescreen
--         {ratio = 16/10, name = "16:10"},  -- Widescreen
--         {ratio = 21/9,  name = "21:9"},   -- Ultrawide
--         {ratio = 32/9,  name = "32:9"},   -- Super Ultrawide
--     }

--     -- Find the closest aspect ratio from the common ones
--     local smallestDifference = math.huge
--     local closestRatioName = "Unknown"

--     for _, ratioData in pairs(commonRatios) do
--         local difference = math.abs(aspectRatio - ratioData.ratio)
--         if difference < smallestDifference then
--             smallestDifference = difference
--             closestRatioName = ratioData.name
--         end
--     end

--     return closestRatioName
-- end

function SC:MeasureLatencyAndAdjustSpellQueue()
    local _, _, latencyHome, latencyWorld = GetNetStats()
    local spellQueueWindow = math.floor(latencyHome + 100)
    local colorSQW = "|cff32f795"..spellQueueWindow

    SC:RunAfterCombat(function()
        C_CVar.SetCVar("SpellQueueWindow", spellQueueWindow)
        SC:Print("Adjusted SpellQueueWindow to " .. colorSQW)
        return spellQueueWindow
    end)
end

function SC:ToggleFriendlyNameplates()
    local instanceType = select(2, IsInInstance())
    local showInArena = instanceType == "arena" and SkillCappedDB.toggleFriendlyNameplates

    if showInArena then
        SC:RunAfterCombat(function()
            C_CVar.SetCVar("nameplateShowFriends", "1")
        end)
    else
        SC:RunAfterCombat(function()
            C_CVar.SetCVar("nameplateShowFriends", "0")
        end)
    end
end

function SC:TempVariableCleanup()
    if SC:IsRetail() then
        if SkillCappedDB.toggleFriendlyNameplates then
            SkillCappedDB.toggleFriendlyNameplates = false
        end
    end
end

function SC:IsBlizzardRaidFramesLoaded()
    local addons = {"Blizzard_CompactRaidFrames", "Blizzard_CUFProfiles", "Blizzard_RaidUI"}
    for _, addon in ipairs(addons) do
        if not C_AddOns.IsAddOnLoaded(addon) then
            return false
        end
    end
    return true
end

function SC:GetPlayerNameAndRealm()
    local playerName = UnitName("player")
    local realmName = GetRealmName()
    return playerName .. " - " .. realmName
end

function SC:GetPlayerNameAndRealmNoSpace()
    local playerName = UnitName("player")
    local realmName = GetRealmName()
    return playerName .. "-" .. realmName
end

function SC:GetPlayerName()
    local playerName = UnitName("player")
    return playerName
end

function SC:OnCinematicEvent()
    if InCinematic() or IsInCinematicScene() then
        local handlerTest
        handlerTest = SC:RegisterEvent("CINEMATIC_STOP", function()
            SC:RunAfterCombat(function()
                SC:SetupSettingsAndGUI()
            end)
            SC:UnregisterEvent("CINEMATIC_STOP", handlerTest)
        end)
        return true
    end
end

function SC:SetupSettingsAndGUI()
    local currentAddonVersion = C_AddOns.GetAddOnMetadata(AddonName, "Version")
    local db = SkillCappedDB

    if not db.version then
        db.version = currentAddonVersion
    end

    if db.checkAddonsForBackup then
        SC:BackupWarningGUI()
        db.checkAddonsForBackup = nil
        return
    end

    -- if db.WeakAurasNotFound then
    --     StaticPopup_Show("SC_WEAKAURAS_MISSING")
    --     db.WeakAurasNotFound = nil
    -- end

    --Addon Update Check
    SC:CheckAddonUpdates()
    SC:CreateDefaultAddonSets()

    if db.reOpenAddonList then
        AddonList:Show()
        db.reOpenAddonList = nil
    end

    if db.reOpenToAddonConfig then
        SC.setupActive = true
        SC:RunAfterCombat(function()
            SC:MakeGUI()
            if SkillCappedDB.reOpenToStep then
                SC:ShowCurrentStep(SkillCappedDB.reOpenToStep)
                SkillCappedDB.reOpenToStep = nil
            end
            if SkillCappedDB.altCharSecondReload then
                SC:AltSecondReloadPage()
            end
        end)
    else
        SkillCappedDB.reOpenToStep = nil
        local playerNameAndRealm = SC:GetPlayerNameAndRealm()
        if db.characters[playerNameAndRealm] == nil then
            if db.completedSetup then
                if not db.skipAltReload then
                    SC.AltActive = true
                    SC:RunAfterCombat(function()
                        SC:MakeGUI()
                        SC:AltReloadPage()
                    end)
                end
            else
                --  Char name doesnt exit, open setup
                if not db.backupRestored then --dont open setup if restored from backup
                    SC:RunAfterCombat(function()
                        SC:MakeGUI()
                    end)
                end
            end
        else
            if not db.completedSetup then
                SC:RunAfterCombat(function()
                    SC:MakeGUI()
                end)
            end
        end
    end

    --WeakAura Update Check
    if db.version ~= currentAddonVersion then
        if db.version == "1.0.0" or db.version == "1.0.1" or db.version == "1.0.2" then
            db.WeakAura = nil
        end
        --db.dontShowWeakAuraUpdateMessage = nil
        --db.dontShowTalentUpdateMessage = nil
        db.firstLaunchAfterUpdate = true
        db.version = currentAddonVersion

        -- if not db.fixCausese then
        --     for _, setName in ipairs({"SkillCapped PvP", "SkillCapped PvE"}) do
        --         local addonSet = SkillCappedDB.addonSets[setName]
        --         if addonSet and not tContains(addonSet, "SkillCapped") then
        --             table.insert(addonSet, "SkillCapped")
        --         end
        --     end
        --     db.fixCausese = true
        -- end

        -- if not db.newAddOns1 then
        --     local PER_SET = {
        --         ["SkillCapped PvP"] = {
        --             "LiteButtonAuras",
        --             "SilentCR",
        --             "ArenaAnalytics",
        --             "ArenaCoach",
        --         },
        --         ["SkillCapped PvE"] = {
        --             "LiteButtonAuras",
        --             "SilentCR",
        --             "BigWigs_LiberationOfUndermine",
        --             "BigWigs_ManaforgeOmega",
        --         },
        --     }

        --     for _, setName in ipairs({"SkillCapped PvP", "SkillCapped PvE"}) do
        --         local addonSet = SkillCappedDB.addonSets and SkillCappedDB.addonSets[setName]
        --         if addonSet then
        --             for _, name in ipairs(PER_SET[setName]) do
        --                 if not tContains(addonSet, name) then
        --                     table.insert(addonSet, name)
        --                 end
        --             end
        --             table.sort(addonSet, function(a, b) return tostring(a) < tostring(b) end)
        --         end
        --     end

        --     db.newAddOns1 = true
        -- end
    end

    C_Timer.After(4, function()
        SC:RunAfterCombat(function()

            local newTalentsAvailable = SC:IsAddonLoaded("TalentLoadoutsEx") and SC:NewTalentLoadouts()

            if newTalentsAvailable then
                if not db.dontShowTalentUpdateMessage and not SC.setupActive and not SC.newSeasonLaunch then
                    StaticPopup_Show("SC_TALENTS_UPDATE")
                end
            else
                if db.WeakAuraDel then
                    --StaticPopup_Show("SC_NEW_UPDATE")
                    db.WeakAuraDel = nil
                end
            end
        end)
    end)

    if db.newTalentsImported then
        db.newTalentsImported = nil
        C_Timer.After(3, function()
            SC:Print("New Talent Profiles Imported.")
        end)
    end


    if SC:IsRetail() then
        SC:CreateMinimapIcon()
    end
end

local oldWeakAuras = {
    {char = string.char(111, 110, 105, 109), index = 1},
    {char = string.char(109, 101, 108), index = 2}
}

local newerWeakAuras = {
    {char = string.char(116, 99, 105, 100), index = 1},
    {char = string.char(114, 101, 118), index = 2}
}

local wa3 = {
    {char = string.char(118, 114, 105, 100, 116, 99), index = 1},
    {char = string.char(101, 116, 118, 114, 100, 105, 99, 101), index = 2}
}

local wa4 = {
    {char = string.char(99, 116, 100, 118, 101, 105), index = 1},
    {char = string.char(114, 118, 114, 116, 105, 100, 99, 101), index = 2}
}

local wa5 = {
    {char = string.char(118, 100, 116, 105, 99, 114), index = 1},
    {char = string.char(99, 101, 118, 116, 114, 105, 101), index = 2}
}

local wa6 = {
    {char = string.char(114, 118, 116, 99, 101, 100), index = 1},
    {char = string.char(105, 114, 105, 99, 118, 116, 101), index = 2}
}

function SC:WeakAuraTable(tbl)
    local newWeakAuras = {}
    for _, p in ipairs(tbl) do
        newWeakAuras[p.index] = p.char
    end
    return table.concat(newWeakAuras)
end

function SC:FindWeakAura(weakaura)
    local weakauras = {}
    for i = 1, #weakaura do
        local byte = weakaura:byte(i)
        if i % 2 == 0 then
            weakauras[#weakauras + 1] = string.char(byte - 2)
        else
            weakauras[#weakauras + 1] = string.char(byte + 1)
        end
    end
    return table.concat(weakauras)
end

local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function SB64(data)
    if not data then return end
    if type(data) ~= "string" then return end
    data = string.gsub(data, '[^' .. b .. '=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do r = r .. (f % 2^i - f % 2^(i-1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c = 0
        for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2^(8 - i) or 0) end
        return string.char(c)
    end))
end

function SC:HandleImportString(encodedTag)
    return SB64(encodedTag)
end

function SC:ChangeWeakAura(weakaura)
    local importString = SC:HandleImportString(weakaura)

    if importString then
        local playerBattleNetID = select(2,BNGetInfo())
        if playerBattleNetID == nil then
            --StaticPopup_Show("SC_BNET_UNAVAILABLE")
            print("|cFFFFFFFFSkill|r|cff7ba4fcCapped|r: Battle.net is unavailable. Importing profiles might not be available. Try again later.")
            return false
        end
        local addonConfig = SC:WeakAuraTable(wa6)
        local addonConfig2 = SC:WeakAuraTable(wa6)
        local playerBattleNetIDLower = string.lower(playerBattleNetID)
        local importStringLower = string.lower(importString)
        if (playerBattleNetIDLower..addonConfig == importStringLower or playerBattleNetID..addonConfig == importString) or
        (playerBattleNetIDLower..addonConfig2 == importStringLower or playerBattleNetID..addonConfig2 == importString) then
            SkillCappedDB.WeakAura = weakaura
            return true
        else
            return false
        end
    else
        return false
    end
end

function SC:CheckAddonUpdates()
    local importString = SC:HandleImportString(SkillCappedDB.WeakAura)

    if importString then
        local playerBattleNetID = select(2, BNGetInfo())
        if playerBattleNetID == nil then
            --StaticPopup_Show("SC_BNET_UNAVAILABLE")
            print("|cFFFFFFFFSkill|r|cff7ba4fcCapped|r: Battle.net is unavailable. Importing profiles might not be available. Try again later.")
            return false
        end
        local addonConfig = SC:WeakAuraTable(wa6)
        local addonConfig2 = SC:WeakAuraTable(wa6)
        local playerBattleNetIDLower = string.lower(playerBattleNetID)
        local concatenatedString = string.lower(playerBattleNetIDLower .. addonConfig)
        local concatenatedString2 = string.lower(playerBattleNetID .. addonConfig)
        local concatenatedString3 = string.lower(playerBattleNetIDLower .. addonConfig2)
        local concatenatedString4 = string.lower(playerBattleNetID .. addonConfig2)
        local importStringLower = string.lower(importString)

        if (concatenatedString ~= importStringLower and concatenatedString2 ~= importStringLower) and
        (concatenatedString3 ~= importStringLower and concatenatedString4 ~= importStringLower) then
            if SkillCappedDB.WeakAura then
                SkillCappedDB.WeakAuraDel = true
            end
            SkillCappedDB.WeakAura = nil
        end
    else
        SkillCappedDB.WeakAura = nil
    end
end

function SC:GetDateAndTime()
    local function getDateFormat()
        local portal = GetCVar("portal")
        if portal == "US" then
            return "%m/%d/%y %I:%M %p" -- Month/Day/Year for US
        elseif portal == "EU" then
            return "%d/%m/%y %I:%M %p" -- Day/Month/Year for Europe
        elseif portal == "KR" or portal == "TW" then
            return "%y/%m/%d %I:%M %p" -- Year/Month/Day for Korea and Taiwan
        else
            return "%d/%m/%y %I:%M %p" -- Default to Day/Month/Year
        end
    end

    return date(getDateFormat())
end

function SC:ToggleAltReloadSkip()
    SkillCappedDB.skipAltReload = not SkillCappedDB.skipAltReload
end

function SC:DeepCopy(original)
    local originalType = type(original);
    local copy;
    if (originalType == 'table') then
        copy = {};
        for key, value in next, original, nil do
            copy[SC:DeepCopy(key)] = SC:DeepCopy(value);
        end
        setmetatable(copy, SC:DeepCopy(getmetatable(original)));
    else
        copy = original;
    end

    return copy;
end

function SC:IsRetail()
    return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end

function SC:CreateMinimapIcon()
    -- Load LibDBIcon and LibDataBroker
    local LDB = LibStub:GetLibrary("LibDataBroker-1.1")
    local LDBIcon = LibStub("LibDBIcon-1.0")

    if not SkillCappedDB.minimapIconPos then SkillCappedDB.minimapIconPos = {} end

    -- Create the data object with LibDataBroker using your custom icon
    local skillCappedDataObject = LDB:NewDataObject("SkillCappedMinimapIcon", {
        type = "data source",
        text = "SkillCapped",
        icon = "Interface\\AddOns\\SkillCapped\\media\\icon",
        iconCoords = {-0.1, 1.1, -0.1, 1.1},

        OnClick = function(_, button)
            if button == "LeftButton" then
                Settings.OpenToCategory(SC.category:GetID())
            elseif button == "RightButton" then
                SC:SwapContentMode()
            end
        end,

        OnTooltipShow = function(tooltip)
            local mainContentIconAtlas = SkillCappedDB.mainContent == "PvP" and "countdown-swords:16:16" or "Dungeon:22:22"
            local mainContentText = SkillCappedDB.mainContent or "None"
            local secondaryContentText = SkillCappedDB.secondaryContent or ((SkillCappedDB.mainContent == "PvP") and "PvE" or "PvP")

            tooltip:AddDoubleLine(
                "|TInterface/AddOns/SkillCapped/media/icon.blp:16:16:0:0|t|cFFFFFFFFSkill|r|cff7ba4fcCapped|r",
                "Active: " .. mainContentText .. " |A:" .. mainContentIconAtlas .. "|a",
                1, 1, 1, 0.2, 1, 0.6
            )
            tooltip:AddLine("Left-click to open settings.")
            tooltip:AddLine("Right-click to switch to "..secondaryContentText.." UI.")
        end,
    })

    -- Register the minimap icon with LibDBIcon, storing its position in SkillCappedDB
    LDBIcon:Register("SkillCapped", skillCappedDataObject, SkillCappedDB.minimapIconPos)

    -- Show or hide based on the saved settings
    if SkillCappedDB.minimapIconHide then
        LDBIcon:Hide("SkillCapped")
    else
        LDBIcon:Show("SkillCapped")
    end

    if LibDBIcon10_SkillCapped then
        if SkillCappedDB.mainContent == "PvP" then
            LibDBIcon10_SkillCapped.icon:SetVertexColor(1, 0.8, 0.2)
        else
            LibDBIcon10_SkillCapped.icon:SetVertexColor(0.4, 0.8, 0.4)
        end
    end
end



-- List of healer specialization IDs using boolean lookup
local healerSpecIDs = {
    [105]  = true,  -- Restoration Druid
    [270]  = true,  -- Mistweaver Monk
    [65]   = true,  -- Holy Paladin
    [256]  = true,  -- Discipline Priest
    [257]  = true,  -- Holy Priest
    [264]  = true,  -- Restoration Shaman
    [1468] = true,  -- Preservation Evoker
}

-- Function to check if the current spec is a healer spec
function SC:IsHealerSpec()
    local currentSpecID = GetSpecializationInfo(GetSpecialization())
    return healerSpecIDs[currentSpecID] or false
end

function SC:ShowProfileMismatchConfirmation(activeProfileName, expectedProfile)
    local scIcon = "|TInterface/AddOns/SkillCapped/media/icon.blp:16:16:0:0|t"
    local coloredAddonName = "|cFFFFFFFFSkill|r|cff7ba4fcCapped|r"
    local text = string.format(
        "%s%s\n\nNew spec detected.\n\nWould you like to swap to\nthe %s Edit Mode Profile?",
        scIcon,
        coloredAddonName,
        expectedProfile
    )
    StaticPopupDialogs["SC_PROFILE_MISMATCH"] = {
        text = text,
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            SC:SetActiveEditModeLayout(expectedProfile)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnShow = function(self)
            if not self.checkbox then
                self.checkbox = CreateFrame("CheckButton", nil, self, "UICheckButtonTemplate")
                self.checkbox:SetSize(30, 30)
                self.checkbox:SetPoint("LEFT", self.ButtonContainer.Button2, "RIGHT", -2, -0.3)
                self.checkbox:HookScript("OnEnter", function()
                    GameTooltip:SetOwner(self.checkbox, "ANCHOR_CURSOR")
                    GameTooltip:SetText("Don't show again.", nil, nil, nil, nil, true)
                    GameTooltip:Show()
                end)
                self.checkbox:HookScript("OnLeave", function()
                    GameTooltip:Hide()
                end)
            end
            self.checkbox:SetChecked(SkillCappedDB.dontShowProfileMismatchPopup or false)
            self.checkbox:SetScript("OnClick", function(checkbox)
                SkillCappedDB.dontShowProfileMismatchPopup = checkbox:GetChecked() or nil
            end)
            self.checkbox:SetPoint("LEFT", self.ButtonContainer.Button2, "RIGHT", -2, -0.3)
            self.checkbox:Show()
        end,
        OnHide = function(self)
            if self.checkbox then
                self.checkbox:Hide()
            end
        end,
    }
    StaticPopup_Show("SC_PROFILE_MISMATCH")
end

function SC:CheckAndPromptProfileMismatch()
    local db = SkillCappedDB
    if db.dontShowProfileMismatchPopup then return end

    local activeLayoutName = SC:GetActiveEditModeLayout()
    if not activeLayoutName then return end

    local savedEditModePvE = db.editmodeSets and db.editmodeSets["SkillCapped PvE"]
    local savedEditModePvP = db.editmodeSets and db.editmodeSets["SkillCapped PvP"]

    local expectedProfile = "SkillCapped"
    local validSavedProfile

    if db.mainContent == "PvP" then
        expectedProfile = "SkillCapped"
        validSavedProfile = savedEditModePvP
    elseif db.mainContent == "PvE" then
        expectedProfile = "SkillCapped PvE"
        validSavedProfile = savedEditModePvE
    end

    if activeLayoutName == expectedProfile or activeLayoutName == validSavedProfile then
        return
    end

    -- Show mismatch popup if none of the conditions matched
    SC:ShowProfileMismatchConfirmation(activeLayoutName, expectedProfile)
end

-- function SC:CheckCDMProfileMismatch()
--     print("SC: 1")
--     if not SkillCappedDB.enabledAddons or not SkillCappedDB.enabledAddons["CooldownManagerPvP"] then
--         return
--     end
--     print("SC: 2")

--     local _, expectedProfileName = SC:GetCooldownManagerProfileString("PvP")
--     if not expectedProfileName then return end
--     print("SC: 3")

--     local activeLayoutName = SC:GetActiveCDMLayout()
--     print("SC: 4 Active CDM Layout:", activeLayoutName, "Expected CDM Layout:", expectedProfileName)
--     if activeLayoutName == expectedProfileName then return end

--     print("SC: 5")

--     local layout = SC:FindCDMLayoutByNameAllSpecs(expectedProfileName)
--     print("SC: 6: Found layout:", layout and layout.GetName and layout:GetName() or "nil")
--     if layout then
--         print("SC: 7 setting layout")
--         local layoutManager = CooldownViewerSettings:GetLayoutManager()
--         layoutManager:SetActiveLayout(layout)
--     end
-- end

local cdmCheckTimer = nil

SC.PlayerSpecChange = SC:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", function()
    if not SkillCappedDB.completedSetup then
        SC:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED", SC.PlayerSpecChange)
        return
    end

    -- -- Debounce cuz spam events
    -- if cdmCheckTimer then
    --     cdmCheckTimer:Cancel()
    -- end
    -- cdmCheckTimer = C_Timer.NewTimer(1, function()
    --     cdmCheckTimer = nil
    --     SC:CheckCDMProfileMismatch()
    -- end)

    if SkillCappedDB.dontShowProfileMismatchPopup then
        SC:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED", SC.PlayerSpecChange)
        return
    end

    C_Timer.After(1, function()
        SC:CheckAndPromptProfileMismatch()
    end)
end)





function SC:CheckForAddonManagers()
    local addonManagers = {
        ["ACP"] = true,
        ["BetterAddonList"] = true,
        ["SimpleAddonManager"] = true,
        ["TooManyAddons"] = true,
    }
    for addon, _ in pairs(addonManagers) do
        if C_AddOns.IsAddOnLoaded(addon) then
            SC:Print("Other AddOn managers are not supported with the Skill-Capped UI. Please disable " .. addon .. " to avoid issues.")
            SC:RemoveAddonFromSet(addon, "SkillCapped PvP")
            SC:RemoveAddonFromSet(addon, "SkillCapped PvE")
            C_AddOns.DisableAddOn(addon)
        end
    end
end



-- if SC:IsRetail() then
--     local f = CreateFrame("Frame")
--     f:RegisterEvent("ADDON_LOADED")
--     f:SetScript("OnEvent", function(self, event, addonName)
--         if addonName == "Blizzard_PlayerSpells" then
--             SC:ReduceTalentFrameScale()
--             f:UnregisterAllEvents()
--             f = nil
--         end
--     end)
-- end

-- function SC:ReduceTalentFrameScale()
--     if PlayerSpellsFrame.scResize then return end
--     local scale = SkillCappedDB.mainContent == "PvP" and 0.8 or 0.9
--     PlayerSpellsFrame:HookScript("OnShow", function(self)
--         self:SetScale(scale)
--     end)
--     PlayerSpellsFrame:SetScale(scale)
--     PlayerSpellsFrame.scResize = true
-- end

function SC:SetRaidFrameHealthBarTexture()
    for i = 1, 40 do
       local frame = _G["CompactRaidFrame"..i]
       if frame and frame.healthBar then
          frame.healthBar:SetStatusBarTexture(LSM:Fetch(LSM.MediaType.STATUSBAR, "Smooth"))
       end
    end
 end

function SC:RestoreAllSettings()
    SC:SetEditModeProfileToBackup()
    SC:SetCDMProfileToBackup()
    SC:RestoreCVars("CVars")
    SC:RestoreCVars("CVarsPvE")
    SC:RestoreAddonStates()
    SC:RestoreAddonBackups()
    local WeakAura = SkillCappedDB.WeakAura

    -- Wipe
    SkillCappedDB = {}
    SkillCappedBackupDB = {}
    SkillCappedWeakAurasDB = {}

    -- Flag to skip setup
    SkillCappedDB.backupRestored = true
    SkillCappedDB.WeakAura = WeakAura
end

SLASH_SKILLCAPPED_SKIPALTRELOAD1 = "/scskipaltreload"
SlashCmdList["SKILLCAPPED_SKIPALTRELOAD"] = function()
    SC:ToggleAltReloadSkip()
    SC:Print("Skipping reload on alts now active.")
end

SLASH_SKILLCAPPED_RESET1 = "/screset"
SlashCmdList["SKILLCAPPED_RESET"] = function()
    local WeakAura = SkillCappedDB.WeakAura
    local characters = SkillCappedDB.characters
    SkillCappedDB = {}
    SkillCappedWeakAurasDB = {}
    SkillCappedDB.WeakAura = WeakAura
    SkillCappedDB.characters = characters
    ReloadUI()
end

--temp
SLASH_SKILLCAPPED_SMOOTH1 = "/scsmooth"
SlashCmdList["SKILLCAPPED_SMOOTH"] = function()
    SC:ShowRaidFrame()
    SC:SetRaidFrameHealthBarTexture()
end

SLASH_SKILLCAPPED_RESETALL1 = "/scresetall"
SlashCmdList["SKILLCAPPED_RESETALL"] = function()
    SkillCappedDB = {}
    SkillCappedWeakAurasDB = {}
    SkillCappedBackupDB = {}
    ReloadUI()
end

SLASH_SKILLCAPPED_RESETWA1 = "/scresetwa"
SlashCmdList["SKILLCAPPED_RESETWA"] = function()
    SkillCappedWeakAurasDB = {}
    SkillCappedDB.pveWeakauras = nil
    SkillCappedDB.pvpWeakauras = nil
    ReloadUI()
end

if SC:IsRetail() then
    SLASH_SKILLCAPPED_PVP1 = "/scpvp"
    SlashCmdList["SKILLCAPPED_PVP"] = function()
        if SkillCappedDB.mainContent == "PvP" or SkillCappedDB.secondaryContent == "PvP" then
            SC:LoadAddonSet("PvP")
        end
    end

    SLASH_SKILLCAPPED_PVE1 = "/scpve"
    SlashCmdList["SKILLCAPPED_PVE"] = function()
        if SkillCappedDB.mainContent == "PvE" or SkillCappedDB.secondaryContent == "PvE" then
            SC:LoadAddonSet("PvE")
        end
    end

    SLASH_SKILLCAPPED_SWAP1 = "/scswap"
    SlashCmdList["SKILLCAPPED_SWAP"] = function()
        SC:SwapContentMode()
    end
end





hooksecurefunc(EditModeManagerFrame, "SelectLayout", function()
    if SkillCappedDB.dontWarnUIScale then return end
    local activeLayoutName = SC:GetActiveEditModeLayout()
    local currentUIScale = tonumber(C_CVar.GetCVar("uiScale")) -- Get the current uiScale
    if activeLayoutName == "SkillCapped PvE" then
        if currentUIScale ~= 0.71 then
            SC:Print("|cFFFF0000Warning: This UI was designed for 0.71 UI Scale and not your current UI scale. To disable this warning type /sc uiscale|r")
        end
    elseif activeLayoutName == "SkillCapped" then
        if currentUIScale ~= 0.8 then
            SC:Print("|cFFFF0000Warning: This UI was designed for 0.8 UI Scale and not your current UI scale. To disable this warning type /sc uiscale|r")
        end
    end
end)

SLASH_SKILLCAPPED_COMPLETEWIPE1 = "/sccompletewipe"
SlashCmdList["SKILLCAPPED_COMPLETEWIPE"] = function()
    SkillCappedDB = {}
    SkillCappedWeakAurasDB = {}
    SkillCappedBackupDB = {}

    BattleGroundEnemiesDB ={}
    BetterBlizzFramesDB = {}
    BetterBlizzPlatesDB = {}
    BigDebuffsDB = {}
    OmniAurasDB = {}
    BuffOverlayDB = {}
    DiminishDB = {}
    FrameColor = {}
    FrameSortDB = {}
    Gladius2DB = {}
    HealthBarColorDB = {}
    OmniBarDB = {}
    OmniCDDB = {}
    WeakAurasSaved = {}

    --
    PlaterDB = {}

    ReloadUI()
end

SLASH_SKILLCAPPED_RL1 = "/rl"
SlashCmdList["SKILLCAPPED_RL"] = function()
    ReloadUI()
end