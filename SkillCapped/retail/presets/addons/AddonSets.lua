local AddonName, SkillCapped = ...
local SC = SkillCapped

local skillCappedPvP = {
    --"AdvancedInterfaceOptions",
    --"ArcUI", -- only enabled if user installs it
    "ArenaAnalytics",
    "ArenaCoach",
    "BattleGroundEnemiesFixed",
    "BattlegroundWinConditions",
    "BetterBags",
    "BetterBlizzFrames",
    "BetterBlizzPlates",
    "BetterCharacterPanel",
    "!BugGrabber",
    "BugSack",
    "Capping",
    "Capping_Options",
    "DejaCharacterStats",
    "Details",
    "FrameColor",
    "FrameColorOptions",
    "FrameSort",
    "HandyNotes",
    "HandyNotes_Midnight",
    "HandyNotes_MidnightTreasures",
    "HealthBarColor",
    "idTip",
    "MiniCC",
    "MiniOvershields",
    "PremadeGroupsFilter",
    "sArena_Reloaded",
    "SkillCapped",
    "TalentLoadoutsEx",
    "TalentTreeTweaks",
    "TeleportMenu",
    "TrueStatValues",
    "WorldQuestTracker",
    "WorldQuestsList",
}

local skillCappedPvE = {
    --"AdvancedInterfaceOptions",
    "BetterBags",
    "BetterBlizzQueue",
    "BetterCharacterPanel",
    "!BugGrabber",
    "BugSack",
    "Capping",
    "Capping_Options",
    "DejaCharacterStats",
    "Details",
    "FrameColor",
    "FrameColorOptions",
    "HealthBarColor",
    "SkillCapped",
    "TalentLoadoutsEx",
    "TalentTreeTweaks",
}

local improvedCharPanelAddons = {
    "DejaCharacterStats",
    "BetterCharacterPanel",
    "TrueStatValues"
}

function SC:EnsureAddonInSet(addonName)
    -- Ensure SkillCappedDB.addonSets exists
    SkillCappedDB.addonSets = SkillCappedDB.addonSets or {}
    SkillCappedDB.addonSets["SkillCapped PvP"] = SkillCappedDB.addonSets["SkillCapped PvP"] or {}
    SkillCappedDB.addonSets["SkillCapped PvE"] = SkillCappedDB.addonSets["SkillCapped PvE"] or {}

    local addonName = SC:GetRealAddonName(addonName)

    -- ArcUI is intentionally excluded from the default addon sets but should
    -- be added to the PvP set when explicitly enabled by the user during install
    if addonName == "ArcUI" then
        if not tContains(SkillCappedDB.addonSets["SkillCapped PvP"], "ArcUI") then
            table.insert(SkillCappedDB.addonSets["SkillCapped PvP"], "ArcUI")
        end
        return
    end

    -- Create lookup tables once for fast checking
    if not self.defaultPvPLookup then
        self.defaultPvPLookup = {}
        for _, addon in ipairs(skillCappedPvP) do
            self.defaultPvPLookup[addon] = true
        end
    end

    if not self.defaultPvELookup then
        self.defaultPvELookup = {}
        for _, addon in ipairs(skillCappedPvE) do
            self.defaultPvELookup[addon] = true
        end
    end

    -- Function to ensure all grouped addons are added
    local function ensureAddonSet(setName, addonList)
        for _, addon in ipairs(addonList) do
            if not tContains(SkillCappedDB.addonSets[setName], addon) then
                table.insert(SkillCappedDB.addonSets[setName], addon)
            end
        end
    end

    -- Check if addon belongs to PvP or PvE
    local isPvPAddon = self.defaultPvPLookup[addonName]
    local isPvEAddon = self.defaultPvELookup[addonName]

    -- Ensure it exists in the corresponding SkillCappedDB.addonSets list
    if isPvPAddon then
        if addonName == "DejaCharacterStats" then
            ensureAddonSet("SkillCapped PvP", improvedCharPanelAddons)
        elseif not tContains(SkillCappedDB.addonSets["SkillCapped PvP"], addonName) then
            table.insert(SkillCappedDB.addonSets["SkillCapped PvP"], addonName)
        end
    end
    if isPvEAddon then
        if addonName == "DejaCharacterStats" then
            ensureAddonSet("SkillCapped PvE", improvedCharPanelAddons)
        elseif not tContains(SkillCappedDB.addonSets["SkillCapped PvE"], addonName) then
            table.insert(SkillCappedDB.addonSets["SkillCapped PvE"], addonName)
        end
    end
end

function SC:RemoveAddonFromSet(addonName, setName)
    -- Ensure the addonSets table exists
    if not SkillCappedDB.addonSets or not SkillCappedDB.addonSets[setName] then
        return
    end

    -- Find and remove the addon from the specified set
    local addonSet = SkillCappedDB.addonSets[setName]
    for i = #addonSet, 1, -1 do
        if addonSet[i] == addonName then
            table.remove(addonSet, i)
            break
        end
    end
end

function SC:CreateDefaultAddonSets()
    SkillCappedDB.addonSets = SkillCappedDB.addonSets or {}
    SkillCappedDB.cvarSets = SkillCappedDB.cvarSets or {}
    SkillCappedDB.editmodeSets = SkillCappedDB.editmodeSets or {}

    local defaults = {
        ["SkillCapped PvP"] = skillCappedPvP,
        ["SkillCapped PvE"] = skillCappedPvE,
    }

    for setName, addonSet in pairs(defaults) do
        local contentType = setName:match("SkillCapped (%w+)")
        SkillCappedDB.addonSets[setName] = SkillCappedDB.addonSets[setName] or addonSet
        SkillCappedDB.cvarSets[setName] = SkillCappedDB.cvarSets[setName] or SC:GetUIScaleCVars(contentType)
        SkillCappedDB.editmodeSets[setName] = SkillCappedDB.editmodeSets[setName] or SC:GetActiveEditModeLayout()
    end
end

function SC:RestoreDefaultAddonSet(contentType)
    if not SkillCappedDB.addonSets then return end

    -- Reset addon sets
    local setName = "SkillCapped " .. contentType
    if contentType == "PvP" then
        SkillCappedDB.addonSets[setName] = skillCappedPvP
        SkillCappedDB.cvarSets[setName] = nil
        SkillCappedDB.editmodeSets[setName] = nil
    elseif contentType == "PvE" then
        SkillCappedDB.addonSets[setName] = skillCappedPvE
        SkillCappedDB.cvarSets[setName] = nil
        SkillCappedDB.editmodeSets[setName] = nil
    end

    -- Clear current cvarSets and apply the correct preset
    local cvarSet = (contentType == "PvP") and "uiScaleCVars" or "uiScaleCVarsPvE"
    SC:ApplyCVarPreset(cvarSet)

    -- Recreate default addon sets and cvar sets
    SC:CreateDefaultAddonSets()

    -- Apply the addon set to characters
    SC:ApplySetToCharacters(contentType)
end

function SC:GetSetName()
    if SkillCappedDB.mainContent == "PvP" then
        return "SkillCapped PvP"
    elseif SkillCappedDB.mainContent == "PvE" then
        return "SkillCapped PvE"
    end
end

function SC:SaveEnabledAddonsSet(contentType)
    local setName = SC:GetSetName()
    -- -- Initialize the addon sets table if not present
    -- SkillCappedDB.addonSets = SkillCappedDB.addonSets or {}
    -- SkillCappedDB.addonSets[setName] = SkillCappedDB.addonSets[setName] or {}

    -- -- Initialize the CVAR sets table if not present
    -- SkillCappedDB.cvarSets = SkillCappedDB.cvarSets or {}
    -- SkillCappedDB.cvarSets[setName] = SkillCappedDB.cvarSets[setName] or {}

    -- -- Save CVars
    -- SkillCappedDB.cvarSets[setName].uiScale = C_CVar.GetCVar("uiScale")
    -- SkillCappedDB.cvarSets[setName].useUiScale = C_CVar.GetCVar("useUiScale")

    -- Save EditMode
    -- SkillCappedDB.editmodeSets[setName] = SC:GetActiveEditModeLayout()

    -- Get the current player's name (optional)
    local playerName = UnitGUID("player")

    -- Temporary table to track currently enabled addons
    local enabledAddons = {}

    -- Iterate over all addons and check if they are enabled for the current character
    for i = 1, C_AddOns.GetNumAddOns() do
        local addonName = C_AddOns.GetAddOnInfo(i)
        local enabledState = C_AddOns.GetAddOnEnableState(addonName, playerName)

        -- Save the addon if it is enabled for the current character
        if enabledState > 0 then
            enabledAddons[addonName] = true -- Mark as enabled
            if not tContains(SkillCappedDB.addonSets[setName], addonName) then
                table.insert(SkillCappedDB.addonSets[setName], addonName)
            end
        end
    end

    -- Remove any addons from the set that are not currently enabled
    for i = #SkillCappedDB.addonSets[setName], 1, -1 do
        local savedAddonName = SkillCappedDB.addonSets[setName][i]
        if not enabledAddons[savedAddonName] then
            table.remove(SkillCappedDB.addonSets[setName], i)
        end
    end

    -- -- Ensure SkillCapped is always included
    -- if SkillCappedDB.addonSets[setName] then
    --     if not tContains(SkillCappedDB.addonSets[setName], "SkillCapped") then
    --         table.insert(SkillCappedDB.addonSets[setName], "SkillCapped")
    --     end
    -- end

    AddonList:Hide() -- Hide AddonList so it doesn't override logic on reload
    SC:ApplySetToCharacters(contentType)
    --SkillCappedDB.reOpenAddonList = true
    ReloadUI()
end

function SC:ApplySetToCharacters(contentType)
    if not SkillCappedDB.addonSets or not SkillCappedDB.characters then return end

    local setName = "SkillCapped "..contentType

    local targetSet = SkillCappedDB.addonSets[setName]
    if not targetSet then
        return
    end

    -- -- Ensure SkillCapped is always included
    -- if SkillCappedDB.addonSets[setName] then
    --     if not tContains(SkillCappedDB.addonSets[setName], "SkillCapped") then
    --         table.insert(SkillCappedDB.addonSets[setName], "SkillCapped")
    --     end
    -- end

    -- Enable/Disable AddOns for all saved characters
    for fullName, charContentType in pairs(SkillCappedDB.characters) do
        if charContentType == contentType then
            local characterName = string.match(fullName, "^(.-) %-") or fullName
            -- Enable only the addons in the target set
            C_AddOns.DisableAllAddOns(characterName)
            for _, addonName in ipairs(targetSet) do
                C_AddOns.EnableAddOn(addonName, characterName)
            end
        end
    end
    for savedGUID, charContentType in pairs(SkillCappedDB.characterGUIDs) do
        if charContentType == contentType then
            C_AddOns.DisableAllAddOns(savedGUID)
            for _, addonName in ipairs(targetSet) do
                C_AddOns.EnableAddOn(addonName, savedGUID)
            end
        end
    end

    -- Final for current character only.
    -- For whatever reason wont work properly without this causes issues with same name diff server
    C_AddOns.DisableAllAddOns(UnitGUID("player"))
    for _, addonName in ipairs(targetSet) do
        C_AddOns.EnableAddOn(addonName, UnitGUID("player"))
    end
end


function SC:LoadAddonSet(contentType)
    if InCombatLockdown() then
        SC:Print("Leave combat to change PvP/PvE mode.")
        return
    end

    if (SC:GetCurrentInstanceType() == "PvP" and IsFalling()) then
        SC:Print("Cannot be falling while changing PvP/PvE mode.")
        return
    end

    local playerName = UnitGUID("player")
    local targetAddons = {}
    local setName = "SkillCapped " .. contentType

    -- Details need cvars to change in a specific order to not have window moved (PvE needs CVars first and PvP needs CVars last)
    -- Add these flags so the UIScale switcher knows
    local detailsPvPEnabled = SkillCappedBackupDB and SkillCappedBackupDB["DetailsDBPvP"]
    local detailsPvEEnabled = SkillCappedBackupDB and SkillCappedBackupDB["DetailsDBPvE"]
    SC.detailsReload = true
    if contentType == "PvP" and detailsPvPEnabled then
        SC.detailsReloadPvP = true
    elseif contentType == "PvE" and detailsPvEEnabled then
        SC.detailsReloadPvE = true
    end

    -- -- Ensure SkillCapped is always included
    -- if SkillCappedDB.addonSets[setName] then
    --     if not tContains(SkillCappedDB.addonSets[setName], "SkillCapped") then
    --         table.insert(SkillCappedDB.addonSets[setName], "SkillCapped")
    --     end
    -- end

    if contentType == "PvP" or contentType == "PvE" then
        targetAddons = SkillCappedDB.addonSets[setName] or {}
    elseif contentType == "All" then
        local addonSetLookup = {}
        for _, addonName in ipairs(SkillCappedDB.addonSets["SkillCapped PvP"] or {}) do
            addonSetLookup[addonName] = true
        end
        for _, addonName in ipairs(SkillCappedDB.addonSets["SkillCapped PvE"] or {}) do
            addonSetLookup[addonName] = true
        end
        for addonName in pairs(addonSetLookup) do
            table.insert(targetAddons, addonName)
        end
    end

    AddonList:Hide() -- Hide AddonList so it doesn't override logic on reload

    -- Disable all addons first
    C_AddOns.DisableAllAddOns(playerName)

    -- Enable only the target set
    for _, addonName in ipairs(targetAddons) do
        C_AddOns.EnableAddOn(addonName, playerName)
    end

    -- Remember Personal Resource Display setting
    if SkillCappedDB.mainContent == "PvP" then
        local prdEnabled = C_CVar.GetCVarBool("nameplateShowSelf")
        if prdEnabled then
            SkillCappedDB.prdPvP = true
        end
    end


    -- Update SkillCappedDB settings for content type
    if contentType ~= "All" then
        SkillCappedDB.mainContent = contentType
        SkillCappedDB.characters[SC:GetPlayerNameAndRealm()] = contentType
    end
    if contentType ~= "All" then --and SkillCappedDB.secondaryContent ~= "None" then
        SkillCappedDB.secondaryContent = (contentType == "PvP") and "PvE" or "PvP"
    end

    SC:UpdateAddonProfilesForUIModeSwap()

    SkillCappedDB.swappedAddonSet = true

    -- Set the appropriate edit mode for the content type
    if contentType ~= "All" and SkillCappedDB.enabledAddons["EditMode" .. contentType] then
        SC:SetEditModeToSkillCappedOrAddIfMissing(contentType, SC:IsHealerSpec() and "Healer" or "DPS/Tank")
    elseif contentType ~= "All" then
        -- local cvars = SkillCappedDB.cvarSets[setName]
        -- if cvars then
        --     for cvar, value in pairs(cvars) do
        --         C_CVar.SetCVar(cvar, value)
        --     end
        -- end
        SC:SetActiveEditModeLayout(SkillCappedDB.editmodeSets[setName])
    end

    -- Set the appropriate CDM profile for the content type
    if (SkillCappedDB.enabledAddons["CooldownManager"] or SkillCappedDB.enabledAddons["CooldownManagerPvP"] or SkillCappedDB.enabledAddons["CooldownManagerPvE"]) and SkillCappedDB.WeakAura then
        SC:SetCDMToSkillCappedOrAddIfMissing(contentType)
    end

    if C_CVar.GetCVarBool("nameplateResourceOnTarget") == true then
        local bbpVal = BetterBlizzPlatesDB and BetterBlizzPlatesDB.nameplateResourceOnTarget
        C_CVar.SetCVar("nameplateResourceOnTarget", "0")
        if bbpVal then
            BetterBlizzPlatesDB.nameplateResourceOnTarget = bbpVal
        end
    end

    --SC:TogglePvEWeakAuras(contentType)
    SkillCappedDB.waReloadForced = true

    if SkillCappedDB.enabledAddons["MiniCC"] then
        C_CVar.SetCVar("raidFramesCenterBigDefensive", "0")
    end

    ReloadUI()
end


function SC:SwapContentMode()
    --if SkillCappedDB.secondaryContent == "None" then
    --    SC:Print("You do not have a second UI installed. Please install by clicking 'Setup' in /sc")
    --    return
    --end
    if SkillCappedDB.mainContent == "PvP" then
        SC:LoadAddonSet("PvE")
    elseif SkillCappedDB.mainContent == "PvE" then
        SC:LoadAddonSet("PvP")
    end
end

function SC:ToggleAddonsBasedOnEnabled(setName)
    local set = SkillCappedDB["addonSets"][setName]
    if not set then return end

    -- Get the original addon list for validation
    local originalList = (setName == "SkillCapped PvP") and skillCappedPvP or skillCappedPvE
    local originalSetLookup = {}
    for _, addonName in ipairs(originalList) do
        originalSetLookup[addonName] = true
    end

    local addonsToToggle = {
        ["BetterBags"] = "BetterBags",
        ["Dark Mode"] = "FrameColor",
        ["Improved Character Panel"] = {"DejaCharacterStats", "TrueStatValues", "BetterCharacterPanel"},
    }

    for friendlyName, addonNames in pairs(addonsToToggle) do
        local shouldBeEnabled = SkillCappedDB.enabledAddons[friendlyName]

        if type(addonNames) == "table" then
            -- Handle multiple addons for this friendly name
            for _, addonName in ipairs(addonNames) do
                local isInSet = false
                for _, name in ipairs(set) do
                    if name == addonName then
                        isInSet = true
                        break
                    end
                end

                if shouldBeEnabled and not isInSet and originalSetLookup[addonName] then
                    -- Add addon to set if it should be enabled, is not in the set, and is part of the original list
                    table.insert(set, addonName)
                    C_AddOns.EnableAddOn(addonName)
                elseif not shouldBeEnabled and isInSet then
                    -- Remove addon from set if it should be disabled and is in the set
                    for i = #set, 1, -1 do
                        if set[i] == addonName then
                            table.remove(set, i)
                            C_AddOns.DisableAddOn(addonName)
                        end
                    end
                end
            end
        else
            -- Handle a single addon for this friendly name
            local addonName = addonNames
            local isInSet = false
            for _, name in ipairs(set) do
                if name == addonName then
                    isInSet = true
                    break
                end
            end

            if shouldBeEnabled and not isInSet and originalSetLookup[addonName] then
                -- Add addon to set if it should be enabled, is not in the set, and is part of the original list
                table.insert(set, addonName)
                C_AddOns.EnableAddOn(addonName)
            elseif not shouldBeEnabled and isInSet then
                -- Remove addon from set if it should be disabled and is in the set
                for i = #set, 1, -1 do
                    if set[i] == addonName then
                        table.remove(set, i)
                        C_AddOns.DisableAddOn(addonName)
                    end
                end
            end
        end
    end
end