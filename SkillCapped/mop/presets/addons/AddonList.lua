local AddonName, SkillCapped = ...
local SC = SkillCapped

-- All "allowed" addons on first install
local enabledAddons = {

    -- General
    ["AdvancedInterfaceOptions"] = true,
    ["BetterCharacterPanel"] = true,
    ["BugSack"] = true,
    ["!BugGrabber"] = true,
    ["BagBrother"] = true,
    ["Bagnon"] = true,
    ["Bagnon_Bank"] = true,
    ["Bagnon_Config"] = true,
    ["Bagnon_GuildBank"] = true,
    ["Bagnon_VoidStorage"] = true,
    ["Capping"] = true,
    ["Capping_Options"] = true,
    ["SimpleItemLevel"] = true,
    --["TrueStatValues"] = true,
    --["TalentLoadoutsEx"] = true,
    --["TalentTreeTweaks"] = true,
    --["TeleportMenu"] = true,
    ["Auctionator"] = true,
    ["BigDebuffs"] = true,
    ["BuffOverlay"] = true,
    ["idTip"] = true,
    ["LiteButtonAuras"] = true,
    ["oGlowClassic"] = true,
    ["Postal"] = true,
    ["Prat-3.0"] = true,
    ["Questie"] = true,
    --["SpellActivationOverlay"] = true,
    ["PixelPerfectAlign"] = true,

    -- PvP
    ["Bartender4"] = true,
    ["BattlegroundTargets"] = true,
    ["BetterBlizzFrames"] = true,
    ["BetterBlizzPlates"] = true,
    ["BetterBlizzQueue"] = true,
    ["Details"] = true,
    ["Diminish"] = true,
    ["Diminish_Options"] = true,
    ["FrameColor"] = true,
    ["FrameSort"] = true,
    ["ReforgeLite"] = true,
    ["sArena_MoP"] = true,
    --["HealthBarColor"] = true,
    --["OmniAuras"] = true,
    ["OmniBar"] = true,
    ["OmniCC"] = true,
    ["OmniCC_Config"] = true,
    ["OmniCD"] = true,
    ["SkillCapped"] = true,
    ["WeakAuras"] = true,
    ["WeakAurasArchive"] = true,
    ["WeakAurasCompanion"] = true,
    ["WeakAurasModelPaths"] = true,
    ["WeakAurasOptions"] = true,
    ["WeakAurasTemplates"] = true,
}

local pvpAddonList = {
    --["Bartender4"] = true,
    ["BigDebuffs"] = true,
    ["BuffOverlay"] = true,
    ["BattlegroundTargets"] = true,
    ["BetterBlizzFrames"] = true,
    ["Capping"] = true,
    ["Details"] = true,
    ["Diminish"] = true,
    --["SimpleItemLevel"] = true,
    --["FrameColor"] = true,--done outside as "Dark Mode"
    ["FrameSort"] = true,
    ["sArena_MoP"] = true,
    --["HealthBarColor"] = true,
    --["OmniAuras"] = true,
    ["WeakAuras"] = true,
}

local pveAddonList = {
}

local pvpSkillCappedAddonList = {
    ["BetterBlizzPlates"] = true,
    ["ReforgeLite"] = true,
    ["OmniBar"] = true,
    ["OmniCD"] = true,
    --["TalentLoadoutsEx"] = true,
}
SC.scAddons = pvpSkillCappedAddonList

local pveSkillCappedAddonList = {
}

local sharedAddons = {
    ["WeakAuras"] = true,
    ["OmniCD"] = true,
    ["Details"] = true,
    --["TalentLoadoutsEx"] = true,
    --["HealthBarColor"] = true,
    --["SimpleItemLevel"] = true,
    --["FrameColor"] = true,--done outside as "Dark Mode",
}
SC.sharedAddons = sharedAddons

local lookAndFeelAddonList = {
    ["Bagnon"] = true,
    ["Class Colored Healthbars"] = true,
    ["Class Icon Portraits"] = true,
    ["Dark Mode"] = true,
    ["Fade Menu & Bags"] = true,
    ["Combo Points on Nameplate"] = true,
    ["Personal Resource Display"] = true,
    ["Fade Status/XP Bar"] = true,
    ["Hide Error Frame"] = true,
    ["Hide Hit Indicator"] = true,
    ["Improved Character Panel"] = true,
    ["New Fonts"] = true,
    ["Player Elite Frame"] = true,
    ["Queue Pop Notification"] = true,
    ["Smart Tab Targeting"] = true,
}

local nonAddons = {
    ["Class Icon Portraits"] = true,
    ["Fade Menu & Bags"] = true,
    ["Combo Points on Nameplate"] = true,
    ["Personal Resource Display"] = true,
    ["Fade Status/XP Bar"] = true,
    ["Hide Error Frame"] = true,
    ["Hide Hit Indicator"] = true,
    ["New Fonts"] = true,
    ["Player Elite Frame"] = true,
    ["Queue Pop Notification"] = true,
    ["Smart Tab Targeting"] = true,
    ["CVars"] = true,
    ["CVarsPvP"] = true,
    ["CVarsPvE"] = true,
    ["EditMode"] = true,
    ["EditModePvE"] = true,
    ["EditModePvP"] = true,
}


local addonUpdateFunctions = {
    -- General
    Capping = function() return SC:UpdateCappingProfile() end,
    FrameColor = function() return SC:UpdateFrameColorProfile() end,
    HealthBarColor = function() return SC:UpdateHealthBarColorProfile() end,

    -- PvP
    CVarsPvP = function() return SC:ApplyCharacterCVarPreset("PvP") end,
    DetailsPvP = function() return SC:UpdateDetailsProfile("PvP") end,
    EditModePvP = function() return SC:SetEditModeToSkillCappedOrAddIfMissing("PvP") end,
    Bartender4 = function() return SC:UpdateBartender4Profile() end,
    BigDebuffs = function() return SC:UpdateBigDebuffsProfile() end,
    BuffOverlay = function() return SC:UpdateBuffOverlayProfile() end,
    Diminish = function() return SC:UpdateDiminishProfile() end,
    ReforgeLite = function() return SC:UpdateReforgeLiteProfile() end,
    sArena_MoP = function() return SC:UpdatesArena_MoPProfile() end,
    --OmniAuras = function() return SC:UpdateOmniAurasProfile() end,
    OmniBar = function() return SC:UpdateOmniBarProfile() end,
    OmniCDPvP = function() return SC:UpdateOmniCDProfile("PvP") end,

    --PVE
}

local addonSwapUpdateFunctions = {
    DetailsPvP = function() return SC:UpdateDetailsProfile("PvP") end,
    OmniCDPvP = function() return SC:UpdateOmniCDProfile("PvP") end,
    -- DetailsPvE = function() return SC:UpdateDetailsProfile("PvE") end,
    -- OmniCDPvE = function() return SC:UpdateOmniCDProfile("PvE") end,
}

local addonDatabaseMap = {
    -- Look and Feel
    Bagnon = "BrotherBags",
    SimpleItemLevel = "SimpleItemLevelDB",
    FrameColor = "FrameColorDB",
    HealthBarColor = "HealthBarColorDB",

    -- Shared
    Capping = "CappingSettings", --Only shows on PvP
    EditMode = "EditMode",
    OmniCD = "OmniCDDB",

    -- PvP
    CVarsPvP = "CVars",
    DetailsPvP = "DetailsDBPvP",
    EditModePvP = "EditModePvP",
    Bartender4 = "Bartender4DB",
    BigDebuffs = "BigDebuffsDB",
    BuffOverlay = "BuffOverlayDB",
    BattlegroundTargets = "BattlegroundTargets_Options",
    BetterBlizzFrames = "BetterBlizzFramesDB",
    BetterBlizzPlates = "BetterBlizzPlatesDB",
    Diminish = "DiminishDB",
    FrameSort = "FrameSortDB",
    ReforgeLite = "ReforgeLiteDB",
    sArena_MoP = "sArena_MoPDB",
    --OmniAuras = "OmniAurasDB",
    OmniBar = "OmniBarDB",
    --TalentLoadoutsExPvP = "TalentLoadoutsExPvP",
    OmniCDPvP = "OmniCDDBPvP",
    WeakAurasPvP = "WeakAurasPvP",

    --PVE
}

SC.addonDatabaseMap = addonDatabaseMap

function SC:UpdateEnabledAddons()
    for addonName, updateFunc in pairs(addonUpdateFunctions) do
        local dbName = SC.addonDatabaseMap[addonName]
        if dbName and SkillCappedBackupDB[dbName] then  -- check if addon is backed up
            if addonName == "OmniBar" or SC:GetRealAddonName(addonName) == "OmniCD" or addonName == "ReforgeLite" then --only update addons with profile system that needs updating
                if SkillCappedDB.WeakAura then
                    updateFunc()
                end
            else
                updateFunc()
            end
        end
    end
end

function SC:UpdateAddonProfilesForUIModeSwap()
    for addonName, updateFunc in pairs(addonSwapUpdateFunctions) do
        local dbName = SC.addonDatabaseMap[addonName]
        if dbName and SkillCappedBackupDB[dbName] then  -- check if addon is backed up
            if addonName == "OmniBar" or SC:GetRealAddonName(addonName) == "OmniCD" or addonName == "ReforgeLite" then --only update addons with profile system that needs updating
                if SkillCappedDB.WeakAura then
                    updateFunc()
                end
            else
                updateFunc()
            end
        end
    end
end

local addonSettings = {
    -- Look and Feel
    ["Bagnon"] = function() return SC:BrotherBags() end,
    ["Class Colored Healthbars"] = function() return SC:HealthBarColorDB() end,
    ["Dark Mode"] = function() return SC:FrameColorDB() end,
    ["Improved Character Panel"] = function() return SC:SimpleItemLevelDB() end,
    --Settings from Look and Feel
    ["Class Icon Portraits"] = function() SkillCappedDB.ReplaceMyPlayerPortrait = "1" end,
    ["Fade Menu & Bags"] = function() SkillCappedDB.fadeMicroMenu = true end,
    ["Combo Points on Nameplate"] = function() SkillCappedDB.comboPointsOnNameplate = true; SC:ToggleComboPointsOnNameplate(true) end,
    ["Personal Resource Display"] = function() SkillCappedDB.personalResourceDisplay = true; SC:TogglePersonalResourceDisplay() end,
    ["Fade Status/XP Bar"] = function() SkillCappedDB.fadeStatusBar = true end,
    ["Hide Error Frame"] = function() SkillCappedDB.hideErrorFrame = true end,
    ["Hide Hit Indicator"] = function() SkillCappedDB.hideHitIndicator = true end,
    ["New Fonts"] = function() SkillCappedDB.newFonts = true end,
    ["Player Elite Frame"] = function() SkillCappedDB.playerElite = true end,
    ["Queue Pop Notification"] = function() SkillCappedDB.queuePopNotification = true end,
    ["Smart Tab Targeting"] = function() SkillCappedDB.smartTabTargeting = true end,

    -- Shared
    Capping = function() return SC:CappingDB() end, -- Only shows on PvP

    -- PvP
    Bartender4 = function() return SC:Bartender4DB() end,
    BattlegroundTargets = function() return SC:BattlegroundTargets() end,
    BigDebuffs = function() return SC:BigDebuffsDB() end,
    BuffOverlay = function() return SC:BuffOverlayDB() end,
    DetailsPvP = function() return SC:DetailsDB("PvP") end,
    EditModePvP = function() return SC:ForceImportEditModeToSkillCapped("PvP") end,
    CVarsPvP = function() return SC:ApplyCVarPreset("CVars") end,
    BetterBlizzFrames = function() return SC:BetterBlizzFramesDB() end,
    BetterBlizzPlates = function() return SC:BetterBlizzPlatesDB() end,
    Diminish = function() return SC:DiminishDB() end,
    FrameSort = function() return SC:FrameSortDB() end,
    ReforgeLite = function() return SC:ReforgeLiteDB() end,
    sArena_MoP = function() return SC:sArena_MoPDB() end,
    OmniBar = function() return SC:OmniBarDB() end,
    OmniCDPvP = function() return SC:OmniCDDB("PvP") end,
    WeakAurasPvP = function() return SC:WeakAurasDB("PvP") end,

    --PVE
}

-- function SC:CheckAddonsLoaded()
--     local addonsStatus = {}
--     for _, addonName in ipairs(defaultAddonList) do
--         addonsStatus[addonName] = self:IsAddonLoaded(addonName)
--     end
--     for _, addonName in ipairs(skillcappedAddonList) do
--         addonsStatus[addonName] = self:IsAddonLoaded(addonName)
--     end
--     return addonsStatus
-- end

local addonNameMapping = {
    ["Bagnon"] = "Bagnon",
    ["Dark Mode"] = "FrameColor",
    ["FrameColor"] = "FrameColor",
    ["Class Colored Healthbars"] = "BetterBlizzFrames",
    ["Improved Character Panel"] = "SimpleItemLevel",
    ["HealthBarColor"] = "HealthBarColor",
}

function SC:GetRealAddonName(fakeName)
    if not fakeName then return end
    local realName = fakeName:gsub("(%S)PvP$", "%1"):gsub("(%S)PvE$", "%1")
    return addonNameMapping[fakeName] or realName
end

function SC:IsAddonLoaded(addonName)
    if not addonName then return end

    -- If the addon is in nonAddons, return true immediately
    if nonAddons[addonName] then
        return true
    end

    addonName = addonName:gsub("PvP$", ""):gsub("PvE$", "")

    -- Special case for ImprovedCharacterPanel
    if addonName == "Bagnon" then
        local requiredAddons = {"Bagnon", "BagBrother"}
        local oneMissing = false
        local allMissing = true

        for _, reqAddon in ipairs(requiredAddons) do
            if not C_AddOns.IsAddOnLoaded(reqAddon) then
                oneMissing = true
            else
                allMissing = false -- At least one addon is loaded
            end
        end

        if allMissing then
            return false, true -- All required addons are missing
        elseif oneMissing then
            return false -- At least one addon is missing
        end

        return true -- All required addons are loaded
    end

    -- Default behavior for single addons
    return C_AddOns.IsAddOnLoaded(addonName)
end

function SC:DoesAddonExist(addonName)
    if not addonName then return end

    -- If the addon is in nonAddons, return true immediately
    if nonAddons[addonName] then
        return true
    end

    addonName = SC:GetRealAddonName(addonName)
    addonName = addonName:gsub("PvP$", ""):gsub("PvE$", "")

    -- Special case for Bagnon
    if addonName == "Bagnon" then
        local requiredAddons = {"Bagnon", "BagBrother"}
        for _, reqAddon in ipairs(requiredAddons) do
            if not C_AddOns.DoesAddOnExist(reqAddon) then
                return false
            end
        end
        return true
    end

    -- Default behavior for single addons
    return C_AddOns.DoesAddOnExist(addonName)
end

function SC:AddonNoSubfix(addonName)
    addonName = addonName:gsub("PvP$", ""):gsub("PvE$", "")
    return addonName
end

-- Function to retrieve LookAndFeel addons directly, already in order
function SC:SortLookAndFeelAddons()
    local lookAndFeelAddonList = {
        "New Fonts",
        "Dark Mode",
        "Player Elite Frame",
        "Class Colored Healthbars",
        "Improved Character Panel",
        "Bagnon",
        "Combo Points on Nameplate",
        "Personal Resource Display",
        "Fade Status/XP Bar",
        "Hide Hit Indicator",
        "Hide Error Frame",
        "Fade Menu & Bags",
        "Smart Tab Targeting",
        "Queue Pop Notification",
    }
    return lookAndFeelAddonList  -- No further sorting is needed if already ordered
end

function SC:GetAddonList(addonList)
    local sortedAddons = {}

    if addonList == "pvpAddonList" then
        for addonName in pairs(pvpAddonList) do
            table.insert(sortedAddons, addonName)
        end
    elseif addonList == "pvpSkillCappedAddonList" then
        for addonName in pairs(pvpSkillCappedAddonList) do
            table.insert(sortedAddons, addonName)
        end
    elseif addonList == "pveAddonList" then
        for addonName in pairs(pveAddonList) do
            table.insert(sortedAddons, addonName)
        end
    elseif addonList == "pveSkillCappedAddonList" then
        for addonName in pairs(pveSkillCappedAddonList) do
            table.insert(sortedAddons, addonName)
        end
    elseif addonList == "lookAndFeelAddonList" then
        return SC:SortLookAndFeelAddons()
        -- for addonName in pairs(lookAndFeelAddonList) do
        --     table.insert(sortedAddons, addonName)
        -- end
    elseif addonList == "allAddons" then
        local combinedAddons = {}
        for addonName in pairs(pvpAddonList) do
            combinedAddons[addonName] = true
        end
        for addonName in pairs(pvpSkillCappedAddonList) do
            combinedAddons[addonName] = true
        end
        for addonName in pairs(pveAddonList) do
            combinedAddons[addonName] = true
        end
        for addonName in pairs(pveSkillCappedAddonList) do
            combinedAddons[addonName] = true
        end
        for addonName in pairs(lookAndFeelAddonList) do
            combinedAddons[addonName] = true
        end
        for addonName in pairs(combinedAddons) do
            table.insert(sortedAddons, addonName)
        end
    end

    table.sort(sortedAddons, function(a, b)
        return a:lower() < b:lower()
    end)
    return sortedAddons
end

function SC:GetSkillCappedAddonList(type)
    if type == "pvp" then
        return pvpSkillCappedAddonList
    elseif type == "pve" then
        return pveSkillCappedAddonList
    end
end

function SC:InstallSelectedAddonPresets()
    if SC:IsAddonLoaded("BugSack") then
        if not SkillCappedBackupDB.BugSackDB then
            if BugSackDB then
                SkillCappedBackupDB.BugSackDB = SC:DeepCopy(BugSackDB)
                BugSackDB["mute"] = true
                BugSackDB["auto"] = false
            end
        end
    end

    for addonName, isEnabled in pairs(SkillCappedDB.enabledAddons) do
        if isEnabled then
            local checkboxes = SC:GetAddonCheckboxes()
            local updateFunc = addonSettings[addonName]
            if updateFunc and checkboxes[addonName] and checkboxes[addonName]:GetChecked() then
                if addonName == "BetterBlizzPlates" or addonName == "OmniBar" or SC:GetRealAddonName(addonName) == "OmniCD" or addonName == "ReforgeLite" then
                    if SkillCappedDB.WeakAura then
                        updateFunc()
                    end
                else
                    updateFunc()
                    if BetterBlizzPlatesDB then
                        BetterBlizzPlatesDB.scTotem = BetterBlizzPlatesDB.totemIndicator
                        BetterBlizzPlatesDB.totemIndicator = true
                    end
                end
            end
        end
    end

    if SC:IsAddonLoaded("BetterBlizzPlates") and not SkillCappedDB.WeakAura then
        BetterBlizzPlatesDB.skipCVarsPlater = true
        if BetterBlizzPlatesDB.nameplateEnemyWidth == 110 and BetterBlizzPlatesDB.NamePlateVerticalScale == 2.7 then
            BetterBlizzPlatesDB.nameplateEnemyWidth = 154
            BetterBlizzPlatesDB.nameplateFriendlyWidth = 154
        end
    end

    if BetterBlizzQueueDB then
        BetterBlizzQueueDB = {
            ["hideOtherTimers"] = true,
            ["queueTimerWarning"] = false,
            ["queueTimerAudio"] = false,
        }
    end

    -- Add capping settings
    if SkillCappedDB.mainContent == "PvE" and SkillCappedDB.secondaryContent == "None" then
        SC:AddCappingProfile()
    end

    -- Remove/add add-ons from both "SkillCapped PvP" and "SkillCapped PvE" if depending on user selection
    SC:ToggleAddonsBasedOnEnabled("SkillCapped PvP")
    --SC:ToggleAddonsBasedOnEnabled("SkillCapped PvE")
end

function SC:GetAddonSettings(addonName)
    return addonSettings[addonName] or nil
end

-- function SC:UpdateAltSettings()
--     SC:UpdateDetailsProfile()
--     SC:ForceImportEditModeToSkillCapped()
--     SC:UpdateTrufiGCDProfile()--changing db withour reload, will it work hmm
--     SC:ApplyCVarPreset("CVars")
-- end

function SC:UpdateAllAddonProfileKeysToSkillCapped()
    -- Iterate through each backup addon configuration in SkillCappedBackupDB
    for addonName, addonBackup in pairs(SkillCappedBackupDB) do
        -- Ensure the corresponding live addon data exists and has profileKeys
        local addonDB = _G[addonName]
        if addonDB and addonDB.profileKeys then
            -- Update all profile keys to "SkillCapped"
            for playerNameAndRealm in pairs(addonDB.profileKeys) do
                addonDB.profileKeys[playerNameAndRealm] = "SkillCapped"
            end
        end
    end
end

function SC:UpdateCurrentPlayerProfileKeysToSkillCapped()
    -- Get the current player's name and realm string
    local currentPlayer = SC:GetPlayerNameAndRealm()
    -- Iterate through each backup addon configuration in SkillCappedBackupDB
    for addonName, addonBackup in pairs(SkillCappedBackupDB) do
        -- Ensure the corresponding live addon data exists and has profileKeys
        local addonDB = _G[addonName]
        if addonDB and addonDB.profileKeys then
            -- Check if the current player has a profile key in this addon
            if addonDB.profileKeys[currentPlayer] then
                if addonDB.profileKeys[currentPlayer] ~= "SkillCapped" then
                    addonDB.profileKeys[currentPlayer] = "SkillCapped"
                end
            else
                addonDB.profileKeys[currentPlayer] = "SkillCapped"
            end
        end
    end
end



function SC:UpdateAddonProfileKeysToSkillCapped(addonName)
    local addonDB = _G[addonName]
    local addonBackup = SkillCappedBackupDB[addonName]

    -- Check if the necessary data is available
    if not addonDB or not addonDB.profileKeys then
        return
    end
    if not addonBackup or not addonBackup.profileKeys then
        return
    end

    -- -- Update all profile keys to "SkillCapped"
    -- for playerNameAndRealm, _ in pairs(addonBackup.profileKeys) do
    --     addonDB.profileKeys[playerNameAndRealm] = "SkillCapped"
    -- end
end


function SC:RestoreAddonBackups()
    for addonName, dbName in pairs(addonDatabaseMap) do
        if SkillCappedBackupDB[dbName] and SC:IsAddonLoaded(addonName) and type(SkillCappedBackupDB[dbName]) ~= "boolean" then
            if addonName == "Details" then
                Details:ApplyProfile(SkillCappedBackupDB[dbName])
                if _detalhes_global and _detalhes_global.always_use_profile and SkillCappedBackupDB.DetailsDBAlwaysUseProfile then
                    _detalhes_global.always_use_profile = SkillCappedBackupDB.DetailsDBAlwaysUseProfile
                end
                Details:EraseProfile("SkillCapped")
            elseif addonName == "BigWigs" then
                if SkillCappedBackupDB.BigWigs3DB then
                    BigWigs3DB = SC:DeepCopy(SkillCappedBackupDB.BigWigs3DB)
                end
                if SkillCappedBackupDB.BigWigsIconDB then
                    BigWigsIconDB = SC:DeepCopy(SkillCappedBackupDB.BigWigsIconDB)
                end
                if SkillCappedBackupDB.BigWigsStatsDB then
                    BigWigsStatsDB = SC:DeepCopy(SkillCappedBackupDB.BigWigsStatsDB)
                end
                if SkillCappedBackupDB.BigWigsTempNameplates then
                    BigWigsTempNameplates = SC:DeepCopy(SkillCappedBackupDB.BigWigsTempNameplates)
                end
            else
                if addonName ~= "WeakAuras" then
                    _G[dbName] = SC:DeepCopy(SkillCappedBackupDB[dbName])
                end
            end
        end
    end

    SC:RestoreProfilesFromBackup()

    if SC:IsAddonLoaded("BugSack") then
        if BugSackDB and SkillCappedBackupDB.BugSackDB then
            BugSackDB = SC:DeepCopy(SkillCappedBackupDB.BugSackDB)
        end
    end
end

function SC:RestoreProfilesFromBackup()
    -- Iterate through each backup addon configuration in SkillCappedBackupDB
    for addonName, addonBackup in pairs(SkillCappedBackupDB) do
        if addonName ~= "WeakAuras" then
            -- Check if the corresponding live addon data exists and has profileKeys
            local addonDB = _G[addonName]
            if addonDB and type(addonDB) == "table" and addonDB.profileKeys and addonBackup.profileKeys then
                -- Restore profile keys from the backup
                for playerNameAndRealm, backupProfile in pairs(addonBackup.profileKeys) do
                    -- Apply the backup profile name to the live addon configuration
                    if addonDB.profileKeys[playerNameAndRealm] then
                        addonDB.profileKeys[playerNameAndRealm] = backupProfile
                    end
                end
            end
        end
    end
end

function SC:ToggleAddons()
    local numAddons = C_AddOns.GetNumAddOns()
    SkillCappedDB.numAddons = numAddons
    SC.needsReload = false

    -- Table for tracking addon changes
    SkillCappedDB.initialAddonStates = SkillCappedDB.initialAddonStates or {}
    SC.addonsNeedingReload = {}

    -- List of addons that should not trigger a reload
    local noReloadList = {
        ["AdvancedInterfaceOptions"] = true,
        ["BugSack"] = true,
        ["!BugGrabber"] = true,
        --
        ["Capping_Options"] = true,
        ["Details_Compare2"] = true,
        ["Details_EncounterDetails"] = true,
        ["Details_RaidCheck"] = true,
        ["Details_Streamer"] = true,
        ["Details_TinyThreat"] = true,
        ["Details_Vanguard"] = true,
        ["Diminish_Options"] = true,
        ["OmniCC_Config"] = true,
        ["WeakAurasArchive"] = true,
        ["WeakAurasCompanion"] = true,
        ["WeakAurasModelPaths"] = true,
        ["WeakAurasOptions"] = true,
        ["WeakAurasTemplates"] = true,
    }

    --  Enable and disable addons
    for i = 1, numAddons do
        local name, title, notes, loadable, reason, security, newVersion, isLoD = C_AddOns.GetAddOnInfo(i)
        local isEnabled = C_AddOns.IsAddOnLoaded(i)

        if C_AddOns.GetAddOnEnableState(i) == 2 then
            isEnabled = true
        end

        -- Record initial state if it's not recorded yet
        if SkillCappedDB.initialAddonStates[name] == nil then
            SkillCappedDB.initialAddonStates[name] = isEnabled
        end

        -- Determine action needed and track if reload is necessary
        if enabledAddons[name] and not isEnabled then
            SC.addonsNeedingReload[name] = true  -- true means enable
            if not noReloadList[name] then
                SC.needsReload = true
            end
        elseif not enabledAddons[name] and isEnabled then
            -- If the addon is enabled but not in the list, it should be disabled
            SC.addonsNeedingReload[name] = false  -- false means disable
            if not noReloadList[name] then
                SC.needsReload = true
            end
        end
    end

    -- if SC.needsReload then
    --     SkillCappedDB.forcedReloadComplete = true
    -- end

    return SC.needsReload
end

function SC:ApplyAddonChanges()
    if not SC.addonsNeedingReload then return end
    for addonName, enable in pairs(SC.addonsNeedingReload) do
        if enable then
            C_AddOns.EnableAddOn(addonName)
        else
            C_AddOns.DisableAddOn(addonName)
        end
    end
    SkillCappedDB.forcedReloadComplete = true
end

function SC:RestoreAddonStates()
    if SkillCappedDB.initialAddonStates then
        C_AddOns.DisableAllAddOns()
        for addonName, wasEnabled in pairs(SkillCappedDB.initialAddonStates) do
            if wasEnabled then
                C_AddOns.EnableAddOn(addonName)
            end
        end
    end
    SkillCappedDB.forcedReloadComplete = false
end