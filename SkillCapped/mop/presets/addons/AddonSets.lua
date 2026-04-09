local AddonName, SkillCapped = ...
local SC = SkillCapped

local skillCappedPvP = {
    "AdvancedInterfaceOptions",
    "Bartender4",
    "BattlegroundTargets",
    "BagBrother",
    "Bagnon",
    "Bagnon_Bank",
    "Bagnon_Config",
    "Bagnon_GuildBank",
    "Bagnon_VoidStorage",
    "BetterBlizzFrames",
    "BetterBlizzPlates",
    "!BugGrabber",
    "BugSack",
    "Capping",
    "Capping_Options",
    "SimpleItemLevel",
    "Details",
    "Diminish",
    "Diminish_Options",
    "FrameColor",
    "FrameColorOptions",
    "FrameSort",
    "ReforgeLite",
    "sArena_MoP",
    "OmniBar",
    "OmniCC",
    "OmniCC_Config",
    "OmniCD",
    "PixelPerfectAlign",
    "SkillCapped",
    "WeakAuras",
    "WeakAurasArchive",
    "WeakAurasCompanion",
    "WeakAurasModelPaths",
    "WeakAurasOptions",
    "WeakAurasTemplates",
    "Auctionator",
    "BigDebuffs",
    "BuffOverlay",
    "idTip",
    "LiteButtonAuras",
    "oGlowClassic",
    "Postal",
    "Prat-3.0",
    "Questie",
    --"SpellActivationOverlay",
}

local skillCappedPvE = {
    "AdvancedInterfaceOptions",
    -- "Bagnon",
    -- "BetterBlizzQueue",
    -- "BetterCharacterPanel",
    -- "BigWigs",
    -- "BigWigs_Core",
    -- "BigWigs_KhazAlgar",
    -- "BigWigs_NerubarPalace",
    -- "BigWigs_Options",
    -- "BigWigs_Plugins",
    -- "!BugGrabber",
    -- "BugSack",
    -- "Capping",
    -- "Capping_Options",
    -- "CauseseDB",
    -- "SimpleItemLevel",
    -- "Details",
    -- "FrameColor",
    -- "FrameColorOptions",
    -- "HandyNotes",
    -- "HandyNotes_TheWarWithin",
    -- "HandyNotes_WarWithin",
    -- "HealthBarColor",
    -- "LittleWigs",
    -- "LittleWigs_BattleForAzeroth",
    -- "LittleWigs_BurningCrusade",
    -- "LittleWigs_Cataclysm",
    -- "LittleWigs_Classic",
    -- "LittleWigs_Dragonflight",
    -- "LittleWigs_Legion",
    -- "LittleWigs_MistsOfPandaria",
    -- "LittleWigs_Shadowlands",
    -- "LittleWigs_WarlordsOfDraenor",
    -- "LittleWigs_WrathOfTheLichKing",
    -- "MouseoverActionSettings",
    -- "MRT",
    -- "MythicDungeonTools",
    -- "OmniCC",
    -- "OmniCC_Config",
    -- "OmniCD",
    -- "Pawn",
    -- "PremadeGroupsFilter",
    -- "SharedMedia_Causese",
    -- "SkillCapped",
    -- "TalentLoadoutsEx",
    -- "TalentTreeTweaks",
    -- "TeleportMenu",
    -- "TrueStatValues",
    -- "WeakAuras",
    -- "WeakAurasArchive",
    -- "WeakAurasCompanion",
    -- "WeakAurasModelPaths",
    -- "WeakAurasOptions",
    -- "WeakAurasTemplates",
    -- "WorldQuestTracker",
    -- "WorldQuestsList",
}

local weakAurasAddons = {
    "WeakAuras",
    "WeakAurasArchive",
    "WeakAurasCompanion",
    "WeakAurasModelPaths",
    "WeakAurasOptions",
    "WeakAurasTemplates",
}

local bagAddons = {
    "BagBrother",
    "Bagnon",
    "Bagnon_Bank",
    "Bagnon_Config",
    "Bagnon_GuildBank",
    "Bagnon_VoidStorage",
}

function SC:EnsureAddonInSet(addonName)
    -- Ensure SkillCappedDB.addonSets exists
    SkillCappedDB.addonSets = SkillCappedDB.addonSets or {}
    SkillCappedDB.addonSets["SkillCapped PvP"] = SkillCappedDB.addonSets["SkillCapped PvP"] or {}
    SkillCappedDB.addonSets["SkillCapped PvE"] = SkillCappedDB.addonSets["SkillCapped PvE"] or {}

    local addonName = SC:GetRealAddonName(addonName)

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
        if addonName == "WeakAuras" then
            ensureAddonSet("SkillCapped PvP", weakAurasAddons)
        elseif addonName == "Bagnon" then
            ensureAddonSet("SkillCapped PvP", bagAddons)
        elseif not tContains(SkillCappedDB.addonSets["SkillCapped PvP"], addonName) then
            table.insert(SkillCappedDB.addonSets["SkillCapped PvP"], addonName)
        end
    end
    if isPvEAddon then
        if addonName == "WeakAuras" then
            ensureAddonSet("SkillCapped PvE", weakAurasAddons)
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

    -- if not SkillCappedDB.completedSetup and not SkillCappedDB.WeakAura then
    --     SC:RemoveAddonFromSet("ReforgeLite", "SkillCapped PvP")
    -- end
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

    -- if not SkillCapped.WeakAura then
    --     SC:RemoveAddonFromSet("ReforgeLite", "SkillCapped PvP")
    -- end

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

    -- Update SkillCappedDB settings for content type
    if contentType ~= "All" then
        SkillCappedDB.mainContent = contentType
        SkillCappedDB.characters[SC:GetPlayerNameAndRealm()] = contentType
    end
    if contentType ~= "All" and SkillCappedDB.secondaryContent ~= "None" then
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

    if C_CVar.GetCVarBool("nameplateResourceOnTarget") == true then
        local bbpVal = BetterBlizzPlatesDB and BetterBlizzPlatesDB.nameplateResourceOnTarget
        C_CVar.SetCVar("nameplateResourceOnTarget", "0")
        if bbpVal then
            BetterBlizzPlatesDB.nameplateResourceOnTarget = bbpVal
        end
    end

    --SC:TogglePvEWeakAuras(contentType)
    SC:FixWeakAuraNeverState()
    SkillCappedDB.waReloadForced = true
    SC:UpdateWeakAurasIgnoreNameRealm(contentType)

    ReloadUI()
end


function SC:SwapContentMode()
    if SkillCappedDB.secondaryContent == "None" then
        SC:Print("You do not have a second UI installed. Please install by clicking 'Setup' in /sc")
        return
    end
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
        ["Bagnon"] = "Bagnon",
        ["Dark Mode"] = "FrameColor",
        ["Class Colored Healthbars"] = "HealthBarColor",
        ["Improved Character Panel"] = "SimpleItemLevel",
        -- ["Fade Action Bars (PvE)"] = "MouseoverActionSettings",
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