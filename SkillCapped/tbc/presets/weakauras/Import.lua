local AddonName, SkillCapped = ...
local SC = SkillCapped
local updatedWeakAuras = {}
SkillCappedWeakAurasDB = SkillCappedWeakAurasDB or {}
SkillCappedInstalledWeakAurasDB = SkillCappedInstalledWeakAurasDB or {}

local waNames = {
    ["Arena_Frame_DoT_Tracker"] = "Skill Capped TBC Anniversary Arena DoTs",
    --["PersonalResourceDisplayClassic"] = "Skill Capped PersonalResourceMoP",
    ["BBP_NameplateResourceTBC"] = "BBP-NameplateResourceTBC",
    ["SkillCapped_ClassBuffs"] = "Skill Capped TBC Anniversary Class Buffs WeakAura Pack",
    ["SkillCapped_BuffsAndDebuffs"] = "Skill Capped TBC Anniversary Defensive Buffs & Debuffs WeakAura Pack",
    ["SkillCapped_EnemyCDs"] = "Skill Capped TBC Anniversary Enemy CDs WeakAura Pack",
    ["SkillCapped_MissingBuffs"] = "Skill Capped TBC Anniversary Missing Buffs WeakAura Pack",
    ["SkillCapped_CC"] = "Skill Capped TBC Anniversary CC WeakAura Pack",
    ["Drink"] = "Drink TBC Anniversary",
    ["PartyAutoMarker"] = "[Arena] Ultimate Party Automarker",
}

local waNamesPvE = {
}

local waNamesPvP = {
    ["SkillCapped_BuffsAndDebuffs"] = SC.scIcon.."Buffs & Debuffs WeakAura Pack",
    ["SkillCapped_ClassBuffs"] = SC.scIcon.."Class Buffs WeakAura Pack",
    ["Gladdy_DoT_Tracker"] = SC.scIcon.."Arena DoTs",
    ["SkillCapped_MissingBuffs"] = SC.scIcon.."Missing Buffs WeakAura Pack",
    ["Drink"] = "Drink TBC Anniversary",
    ["SkillCapped_EnemyCDs"] = SC.scIcon.."Enemy CDs WeakAura Pack",
    --["PersonalResourceDisplayClassic"] = SC.scIcon.."PersonalResourceMoP",
    ["BBP_NameplateResourceTBC"] = "BBP NameplateResourceTBC",
    ["SkillCapped_CC"] = SC.scIcon.."CC WeakAura Pack",
    ["PartyAutoMarker"] = "[Arena] Ultimate Party Automarker",
}

local waUpdateCheck = {
    ["SkillCapped_BuffsAndDebuffs"] = SC.scIcon.."Buffs & Debuffs WeakAura Pack",
    ["SkillCapped_ClassBuffs"] = SC.scIcon.."Class Buffs WeakAura Pack",
    ["SkillCapped_MissingBuffs"] = SC.scIcon.."Missing Buffs WeakAura Pack",
    ["SkillCapped_EnemyCDs"] = SC.scIcon.."Enemy CDs WeakAura Pack",
    ["Drink"] = "Drink TBC Anniversary",
    --["PersonalResourceDisplayClassic"] = SC.scIcon.."PersonalResourceMoP",
    ["BBP_NameplateResourceTBC"] = "BBP NameplateResourceTBC",
    ["SkillCapped_CC"] = SC.scIcon.."CC WeakAura Pack",
    ["PartyAutoMarker"] = "[Arena] Ultimate Party Automarker",
}

local reloadRequiredWeakAuras = {

}

function SC:GetWeakAuraNames(contentType)
    if contentType == "PvE" then
        return waNamesPvE
    elseif contentType == "PvP" then
        return waNamesPvP
    elseif contentType == "All" then
        return waUpdateCheck
    end
end

local waLoadStates = {
    ["Brace For Impact (Optional)"] = true,
    ["Fatebound Coin (Optional - Heads - Assassination)"] = true,
    ["Dark Evangelism (Optional)"] = true,
    ["Demonic Calling (Optional)"] = true,
    ["Secret Infusion (Optional)"] = true,
    ["Flurry Charge (Optional - Windwalker)"] = true,
    ["Magma Chamber (Optional)"] = true,
    ["Parting Skies (Optional)"] = true,
    ["Mana Bar (Optional Fire & Frost) - LWA - Mage"] = true,
    ["Fire Mastery"] = true,
    ["Clear the Witnesses (Optional - Subtlety)"] = true,
    ["Charred Passions (Optional)"] = true,
    ["Solar Grace (Optional - Holy)"] = true,
    ["Icicle 1"] = true,
    ["Empyrean Power (Optional)"] = true,
    ["Fatebound Coin (Optional - Tails - Assassination)"] = true,
    ["Engulf 2"] = true,
    ["Molten Weapon (Optional)"] = true,
    ["Enlightened (Optional)"] = true,
    ["Bullseye (Optional)"] = true,
    ["Elemental Blast (Optional - Elemental)"] = true,
    ["Balanced Stratagem (Optional - Brewmaster)"] = true,
    ["Essence Burst (Optional - Devastation)"] = true,
    ["Alacrity (Optional - Subtlety)"] = true,
    ["Into the Fray (Optional)"] = true,
    ["Serrated Glaive (Optional)"] = true,
    ["Fury of Xuen (Optional)"] = true,
    ["Tip of the Spear (Optional)"] = true,
    ["Flawless Form (Optional - Outlaw)"] = true,
    ["Healing Elixir (Optional - Mistweaver)"] = true,
    ["Finality: Rupture (Optional)"] = true,
    ["Flashpoint (Optional)"] = true,
    ["Infernal Strike 2"] = true,
    ["Sanctify (Optional)"] = true,
    ["Roll 1"] = true,
    ["Ancient Teachings Bar - LWA - Monk"] = true,
    ["Icy Edge (Optional)"] = true,
    ["Infernal Strike 1"] = true,
    ["Power Swell (Optional)"] = true,
    ["Mind Devourer"] = true,
    ["Strength of the Black Ox (Optional - Windwalker)"] = true,
    ["Pyrotechnics (Optional)"] = true,
    ["Icicle 3"] = true,
    ["Acclamation (Optional)"] = true,
    ["Deeper Daggers (Optional)"] = true,
    ["A Feast of Souls (Optional - Frost)"] = true,
    ["Exhilarating Burst (Optional)"] = true,
    ["Hailstorm (Optional)"] = true,
    ["Health Bar (Optional) - LWA - Paladin"] = true,
    ["Tempest (Enhancement - Optional)"] = true,
    ["Ancient Teachings (Optional)"] = true,
    ["Morning Star (Optional - Holy)"] = true,
    ["Ravage (Optional - Feral)"] = true,
    ["Dark Harvest (Optional)"] = true,
    ["In the Rhythm (Optional)"] = true,
    ["Overflowing Power (Optional)"] = true,
    ["Awakening (Optional)"] = true,
    ["Chain Reaction (Optional)"] = true,
    ["Undeath (Optional - Unholy)"] = true,
    ["Martial Prowess (Optional)"] = true,
    ["Slaughtering Strikes (Optional)"] = true,
    ["Essence Burst (Optional - Preservation)"] = true,
    ["Frenzy (Optional)"] = true,
    ["Impetus (Optional)"] = true,
    ["Rune Mastery (Optional - Unholy)"] = true,
    ["Vengeful Retreat Bar (Optional) - LWA - Demon Hunter"] = true,
    ["Empyrean Legacy (Optional - Retribution)"] = true,
    ["Arcane Shot"] = true,
    ["Firestarter (Optional)"] = true,
    ["Health Bar (Optional) - LWA - Death Knight"] = true,
    ["Flurry 2"] = true,
    ["Flight of the Red Crane (Optional)"] = true,
    ["Momentum Shift (Optional)"] = true,
    ["Wildfire Bomb - Dynamic (Optional)"] = true,
    ["Battering Ram (Optional)"] = true,
    ["Mend Pet (Optional)"] = true,
    ["Health Bar (Optional) - LWA - Demon Hunter"] = true,
    ["Hit Scheme (Optional)"] = true,
    ["Incite Terror (Optional)"] = true,
    ["Show of Force (Optional)"] = true,
    ["In For The Kill (Optional)"] = true,
    ["Balance of All Things (Optional)"] = true,
    ["Fatebound Coin (Optional - Heads - Outlaw)"] = true,
    ["Whirlwind (Optional)"] = true,
    ["Radiant Glory (Optional)"] = true,
    ["Health Bar (Optional) - LWA - Warrior"] = true,
    ["Wicked Maw (Optional)"] = true,
    ["Winter's Chill (Optional)"] = true,
    ["Immolation Aura Bar (Optional) - LWA - Demon Hunter"] = true,
    ["Health Bar (Optional) - LWA - Mage"] = true,
    ["Fel Sunder (Optional)"] = true,
    ["Perforated Veins (Optional)"] = true,
    ["Take 'em by Surprise (Optional)"] = true,
    ["Roll 3"] = true,
    ["Power Overwhelming (Optional)"] = true,
    ["Twist of Fate (Optional - Holy)"] = true,
    ["Health Bar (Optional) - LWA - Evoker"] = true,
    ["Apex Predator's Craving (Optional)"] = true,
    ["Incanter's Flow (Optional)"] = true,
    ["Reverse Entropy (Optional)"] = true,
    ["Solar Grace (Optional - Retribution)"] = true,
    ["Roll 2"] = true,
    ["Conflagration of Chaos - Conflagrate"] = true,
    ["Tactical Retreat (Optional)"] = true,
    ["Frost Mastery"] = true,
    ["Slice and Dice (Optional - Outlaw)"] = true,
    ["Engulf 1"] = true,
    ["Mana Bar (Optional - Off-Spec) - LWA - Shaman"] = true,
    ["Health Bar - LWA - Shaman"] = true,
    ["Wildfire Bomb 1"] = true,
    ["Healing Rain Bar (Optional) - LWA - Shaman"] = true,
    ["Icicle 5"] = true,
    ["Lifecycles (Optional)"] = true,
    ["Judge, Jury and Executioner (Optional)"] = true,
    ["Crackling Surge (Optional)"] = true,
    ["Splintered Elements (Optional)"] = true,
    ["Martial Mixture (Optional)"] = true,
    ["Power of the Maelstrom (Optional)"] = true,
    ["Mana Bar (Optional - Devastation & Augmentation) - LWA - Evoker"] = true,
    ["Tempest (Elemental - Optional)"] = true,
    ["Storm Frenzy (Optional)"] = true,
    ["Finality: Eviscerate (Optional)"] = true,
    ["Lifebind"] = true,
    ["Master Assassin (Optional)"] = true,
    ["Lingering Shadow (Optional)"] = true,
    ["Serrated Bone Spike (Optional)"] = true,
    ["Conflagration of Chaos - Shadowburn"] = true,
    ["Silent Storm (Optional)"] = true,
    ["Icicle 2"] = true,
    ["Health Bar (Optional) - LWA - Warlock"] = true,
    ["Charged Blast (Optional)"] = true,
    ["Twist of Fate (Optional - Discipline)"] = true,
    ["Slice and Dice (Optional - Subtlety)"] = true,
    ["Inquisitor's Ire (Optional)"] = true,
    ["Health Bar (Optional) - LWA - Rogue"] = true,
    ["Blade Flurry Bar (Optional)- LWA - Rogue"] = true,
    ["Cull the Herd (Optional)"] = true,
    ["Momentum Bar (Optional) - LWA - Demon Hunter"] = true,
    ["Alacrity (Optional - Outlaw)"] = true,
    ["Ordered Elements (Optional)"] = true,
    ["Doomblade (Optional)"] = true,
    ["Consecration Bar (Optional) - LWA - Paladin"] = true,
    ["Clarity! (Optional - S2 - 2-Pieces)"] = true,
    ["Internal Bleeding (Optional)"] = true,
    ["Bulwark of Order (Optional)"] = true,
    ["Find Weakness (Optional - Subtlety)"] = true,
    ["Sanctification (Optional - Protection)"] = true,
    ["Arcane Barrage (Optional)"] = true,
    ["Envenom (Optional)"] = true,
    ["Flawless Form (Optional - Subtlety)"] = true,
    ["Flurry 1"] = true,
    ["Fatebound Coin (Optional - Tails - Outlaw)"] = true,
    ["Redoubt (Optional)"] = true,
    ["Power of the Silver Hand (Optional)"] = true,
    ["Finality: Black Powder (Optional)"] = true,
    ["Inner Light (Optional)"] = true,
    ["Strength in Adversity (Optional)"] = true,
    ["Wildfire Bomb 2"] = true,
    ["Rune of Razor Ice (Optional)"] = true,
    ["Slice and Dice (Optional - Assassination)"] = true,
    ["Master of Shadows (Optional)"] = true,
    ["Vicious Cycle (Optional)"] = true,
    ["Harsh Discipline (Optional)"] = true,
    ["Weal and Woe (Optional)"] = true,
    ["Divine Image (Optional)"] = true,
    ["Rend (Optional - Protection)"] = true,
    ["Idol of Yogg-Saron (Optional)"] = true,
    ["Rune Mastery (Optional - Frost)"] = true,
    ["Morning Star (Optional - Retribution)"] = true,
    ["Shadow Covenant (Optional)"] = true,
    ["Rush of Vitality (Optional)"] = true,
    ["Twist of Fate (Optional - Shadow)"] = true,
    ["Soar (Optional)"] = true,
    ["Health Bar (Optional) - LWA - Priest"] = true,
    ["Mana Bar (Optional - Shadow) - LWA - Priest"] = true,
    ["The Rotten (Optional)"] = true,
    ["Echoing Void"] = true,
    ["A Feast of Souls (Optional - Unholy)"] = true,
    ["Hit Combo (Optional)"] = true,
    ["Razor Fragments (Optional)"] = true,
    ["Soul Fragments (Optional - Vengeance)"] = true,
    ["Alacrity (Optional - Assassination)"] = true,
    ["Sanctification (Optional - Retribution)"] = true,
    ["Undeath (Optional - Frost)"] = true,
    ["Ancient Flame (Optional - Devastation)"] = true,
    ["Death Rot (Optional)"] = true,
    ["Health Bar - LWA - Druid"] = true,
    ["Icicle 4"] = true,
    ["Rune of Fallen Crusader (Optional)"] = true,
    ["Empath (Optional)"] = true,
    ["Vampiric Strike (Optional - Unholy)"] = true,
    ["Umbral Embrace (Optional)"] = true,
    ["Ignite (Optional)"] = true,
    ["Burning Wound (Optional)"] = true,
    ["Flurry Charge (Optional - Brewmaster)"] = true,
    ["Thill of the Hunt (Optional)"] = true,
    ["Ignore Pain Bar (Value - Optional) - LWA - Warrior"] = true,
    ["Blessing of Dusk"] = true,
    ["Flame Accelerant (Optional)"] = true,
    ["Blessing of Dawn"] = true,
    ["Serpent Sting (Optional - Survival)"] = true,
    ["Lifecycles Vivify (Optional)"] = true,
    ["Health Bar (Optional) - LWA - Monk"] = true,
    ["Mana Bar (Optional - Protection & Retribution) - LWA - Paladin"] = true,
    ["Relentless Inquisitor (Optional - Protection)"] = true,
    ["Mana Bar (Optional - Off-Spec) - LWA - Druid"] = true,
    ["Controlled Destruction (Optional)"] = true,
    ["Health Bar (Optional) - LWA - Hunter"] = true,
    ["Initiative (Optional)"] = true,
    ["Thunderfist (Optional)"] = true,
    ["Jade Ignition (Optional)"] = true,
    ["Blessed Assurance (Optional)"] = true,
    ["Blade Ward (Optional - Havoc)"] = true,
    ["Numbing Blast (Optional)"] = true,
    ["Bloodseeker (Optional)"] = true,
    ["Thrash Debuff (Optional - Guardian)"] = true,
    ["Fire Breath (Optional)"] = true,
    ["Bulwark of Righteous Fury (Optional)"] = true,
    ["Vampiric Strike (Optional - Blood)"] = true,
    ["Furious Gaze (Optional)"] = true,
}

function SC:SetWeakAuraLoadNeverState(name, state)
    if not WeakAurasSaved then return end
    local aura = WeakAurasSaved["displays"][name]
    if not aura or not aura["load"] then return end

    if state then
        aura["load"]["use_never"] = true
    else
        -- Keep the disabled weakauras disabled
        if waLoadStates[name] then
            aura["load"]["use_never"] = true
        else
            aura["load"]["use_never"] = false
        end
    end

    -- Recursively check for children and apply the same state
    for childName, childAura in pairs(WeakAurasSaved["displays"]) do
        if childAura["parent"] == name then
            SC:SetWeakAuraLoadNeverState(childName, state)
        end
    end
end

function SC:TogglePvEWeakAuras(contentType)
    -- List of all class names (must match the Luxthos WeakAura names exactly)
    local classNames = {
        "Death Knight", "Demon Hunter", "Druid", "Evoker",
        "Hunter", "Mage", "Monk", "Paladin", "Priest",
        "Rogue", "Shaman", "Warlock", "Warrior"
    }
    local waNames = {
        "Externals on you",
        "Luxthos - Consumables",
        "Luxthos - Racials & Trinkets",
        "CauseseDB AddOn Check",
    }
    local pvpWaNames = {
        "Skill Capped Buffs & Debuffs WeakAura Pack",
        "Skill Capped Class Buffs WeakAura Pack",
    }

    -- Disable when swapping into PvP mode
    if SkillCappedDB.hidePvEWeakAurasInPvP and contentType == "PvP" then
        -- Disable all Luxthos WeakAuras for each class
        for _, className in ipairs(classNames) do
            SC:SetWeakAuraLoadNeverState("Luxthos - " .. className, true)
        end
        for _, waName in ipairs(waNames) do
            SC:SetWeakAuraLoadNeverState(waName, true)
        end
    else
        -- Enable all Luxthos WeakAuras for each class
        for _, className in ipairs(classNames) do
            SC:SetWeakAuraLoadNeverState("Luxthos - " .. className, false)
        end
        for _, waName in ipairs(waNames) do
            SC:SetWeakAuraLoadNeverState(waName, false)
        end
    end

    if SkillCappedDB.hidePvPWeakAurasInPvE and contentType == "PvE" then
        for _, pvpWaName in ipairs(pvpWaNames) do
            SC:SetWeakAuraLoadNeverState(pvpWaName, true)
        end
    else
        for _, pvpWaName in ipairs(pvpWaNames) do
            SC:SetWeakAuraLoadNeverState(pvpWaName, false)
        end
    end
end

function SC:FixWeakAuraNeverState()
    -- if SkillCappedDB.fixedWeakAuraNeverState then return end
    -- local classNames = {
    --     "Death Knight", "Demon Hunter", "Druid", "Evoker",
    --     "Hunter", "Mage", "Monk", "Paladin", "Priest",
    --     "Rogue", "Shaman", "Warlock", "Warrior"
    -- }
    -- local waNames = {
    --     "Externals on you",
    --     "Luxthos - Consumables",
    --     "Luxthos - Racials & Trinkets",
    --     "CauseseDB AddOn Check",
    -- }
    -- local pvpWaNames = {
    --     "Skill Capped Buffs & Debuffs WeakAura Pack",
    --     "Skill Capped Class Buffs WeakAura Pack",
    -- }
    -- for _, className in ipairs(classNames) do
    --     SC:SetWeakAuraLoadNeverState("Luxthos - " .. className, false)
    -- end
    -- for _, waName in ipairs(waNames) do
    --     SC:SetWeakAuraLoadNeverState(waName, false)
    -- end
    -- for _, pvpWaName in ipairs(pvpWaNames) do
    --     SC:SetWeakAuraLoadNeverState(pvpWaName, false)
    -- end
    -- SkillCappedDB.fixedWeakAuraNeverState = true
end

local function SetWeakAuraIgnoreNameRealm(name, ignoreNameRealmString, state)
    if not WeakAurasSaved then return end
    local aura = WeakAurasSaved["displays"][name]
    if not aura or not aura["load"] then return end

    -- Apply ignore settings
    aura["load"]["use_ignoreNameRealm"] = state
    aura["load"]["ignoreNameRealm"] = ignoreNameRealmString

    -- Recursively check for children and apply the same settings
    for childName, childAura in pairs(WeakAurasSaved["displays"]) do
        if childAura["parent"] == name then
            SetWeakAuraIgnoreNameRealm(childName, ignoreNameRealmString, state)
        end
    end
end

function SC:UpdateWeakAurasIgnoreNameRealm(contentType)
    if not WeakAurasSaved then return end

    local pvpCharacters, pveCharacters = {}, {}

    -- Loop through SkillCappedDB characters and format names
    for fullName, mode in pairs(SkillCappedDB["characters"]) do
        local formattedName = fullName:gsub(" %- ", "-") -- Remove spaces between name and realm
        if mode == "PvP" then
            table.insert(pvpCharacters, formattedName)
        elseif mode == "PvE" then
            table.insert(pveCharacters, formattedName)
        end
    end

    -- Convert to comma-separated strings (only when needed)
    local pvpCharString = table.concat(pvpCharacters, ", ")
    local pveCharString = table.concat(pveCharacters, ", ")
    local pvpCharactersStringUnload = SkillCappedDB.hidePvEWeakAurasInPvP and pvpCharString or ""
    local pveCharactersStringUnload = SkillCappedDB.hidePvPWeakAurasInPvE and pveCharString or ""

    -- List of WeakAuras to apply changes to
    local classNames = {
        "Death Knight", "Demon Hunter", "Druid", "Evoker",
        "Hunter", "Mage", "Monk", "Paladin", "Priest",
        "Rogue", "Shaman", "Warlock", "Warrior"
    }
    local waNames = {
        "Externals on you",
        "Luxthos - Consumables",
        "Luxthos - Racials & Trinkets",
        "CauseseDB AddOn Check",
    }
    local pvpWaNames = {
        "Skill Capped Buffs & Debuffs WeakAura Pack",
        "Skill Capped Class Buffs WeakAura Pack",
    }

    -- Apply PvE WeakAura Ignore Settings
    local pveState = SkillCappedDB.hidePvEWeakAurasInPvP or false
    for _, className in ipairs(classNames) do
        SetWeakAuraIgnoreNameRealm("Luxthos - " .. className, pvpCharactersStringUnload, pveState)
    end
    for _, waName in ipairs(waNames) do
        SetWeakAuraIgnoreNameRealm(waName, pvpCharactersStringUnload, pveState)
    end

    -- Apply PvP WeakAura Ignore Settings
    local pvpState = SkillCappedDB.hidePvPWeakAurasInPvE or false
    for _, waName in ipairs(pvpWaNames) do
        SetWeakAuraIgnoreNameRealm(waName, pveCharactersStringUnload, pvpState)
    end

    -- Handle custom toggles (e.g. SkillCappedDB.customWAToggles["Some WA"] = "PvE" or "PvP")
    if SkillCappedDB.weakauraToggles then
        local ignoreString = (contentType == "PvE") and pveCharString or pvpCharString
        local enableInThisContent = (contentType == "PvE") and "PvE" or "PvP"

        for waName, toggleType in pairs(SkillCappedDB.weakauraToggles) do
            local shouldEnable = (toggleType == enableInThisContent)
            SetWeakAuraIgnoreNameRealm(waName, ignoreString, not shouldEnable)
        end
    end
end

function SC:UpdateCustomWeakAuraLoadStatus(contentType)
    local pvpCharacters, pveCharacters = {}, {}

    -- Loop through SkillCappedDB characters and format names
    for fullName, mode in pairs(SkillCappedDB["characters"]) do
        local formattedName = fullName:gsub(" %- ", "-") -- Remove spaces between name and realm
        if mode == "PvP" then
            table.insert(pvpCharacters, formattedName)
        elseif mode == "PvE" then
            table.insert(pveCharacters, formattedName)
        end
    end

    local pvpCharString = table.concat(pvpCharacters, ", ")
    local pveCharString = table.concat(pveCharacters, ", ")

    if SkillCappedDB.weakauraToggles then
        local ignoreString = (contentType == "PvE") and pveCharString or pvpCharString
        local enableInThisContent = (contentType == "PvE") and "PvE" or "PvP"

        for waName, toggleType in pairs(SkillCappedDB.weakauraToggles) do
            local shouldEnable = (toggleType == enableInThisContent)
            SetWeakAuraIgnoreNameRealm(waName, ignoreString, not shouldEnable)
        end
    end
end

function SC:NewWeakAuraUpdates()
    local weakauras = SC:GetPresetWeakAuras()
    local updatesAvailable = false
    SC.WeakAurasWithUpdates = {}

    -- Check for PvP WeakAuras updates if PvP is selected
    if SkillCappedDB.pvpWeakauras then
        for weakaura, importString in pairs(weakauras["PvP"]) do
            if (SkillCappedWeakAurasDB[weakaura] and SkillCappedWeakAurasDB[weakaura] ~= importString) then
                -- check if wa is still installed
                local weakauraName = waNames[weakaura]
                if WeakAurasSaved and WeakAurasSaved["displays"] and WeakAurasSaved["displays"][weakauraName] then
                    if not (SkillCappedDB.ignoredWeakAuras and SkillCappedDB.ignoredWeakAuras[weakaura]) then
                        updatesAvailable = true
                    end
                    SC.WeakAurasWithUpdates[weakaura] = true
                else
                    SkillCappedWeakAurasDB[weakaura] = nil
                end
            end
        end
    end

    -- Check for PvE WeakAuras updates (including "Dungeons & Raids" and class-specific ones) if PvE is selected
    if SkillCappedDB.pveWeakauras then
        for categoryName, categoryWeakAuras in pairs(weakauras["PvE"]) do
            if SkillCappedDB.pveWeakauras[categoryName] and type(categoryWeakAuras) == "table" then
                for weakaura, importString in pairs(categoryWeakAuras) do
                    if (SkillCappedWeakAurasDB[weakaura] and SkillCappedWeakAurasDB[weakaura] ~= importString) then
                        -- check if wa is still installed
                        local weakauraName = waNames[weakaura]
                        if WeakAurasSaved and WeakAurasSaved["displays"] and WeakAurasSaved["displays"][weakauraName] then
                            if not (SkillCappedDB.ignoredWeakAuras and SkillCappedDB.ignoredWeakAuras[weakaura]) then
                                updatesAvailable = true
                            end
                            SC.WeakAurasWithUpdates[weakaura] = true
                        else
                            SkillCappedWeakAurasDB[weakaura] = nil
                        end
                    end
                end
            end
        end
    end

    if updatesAvailable then return true end

    return false
end

function SC:CheckAndPromptMissingClassWeakAuras()
    -- Ensure PvE WeakAuras are enabled and relevant classes are selected
    local playerClass = UnitClassBase("player") -- Uppercase class name
    local playerClassX = playerClass:lower():gsub("^%l", string.upper) -- Capitalized first letter

    if not SkillCappedDB.pveWeakauras or SkillCappedDB.pveWeakauras[playerClass] then
        return  -- PvE WeakAuras not selected or already installed for this class
    end

    -- Check if the WeakAura for this class is missing
    local weakauras = SC:GetPresetWeakAuras()
    local classWeakAuras = weakauras["PvE"] and weakauras["PvE"][playerClass]

    if classWeakAuras and not SkillCappedWeakAurasDB[playerClassX] then
        -- Prompt the player to import the WeakAuras
        StaticPopupDialogs["SC_MISSING_CLASS_WA"] = {
            text = SC.Logo.."\n\nYou have not installed the class specific PvE WeakAuras for your class.\n\nWould you like to install it now?",
            button1 = "Yes",
            button2 = "No",
            OnAccept = function()
                -- Queue the WeakAuras for import
                SC.updateInstalled = true

                SkillCappedDB.pveWeakauras[playerClass] = true
                local totalCount = 0
                for weakaura, importString in pairs(classWeakAuras) do
                    totalCount = totalCount + 1
                    SC:QueueWeakAuraImport(importString)
                    SkillCappedWeakAurasDB[weakaura] = importString
                end
                --SC:CreateWeakAuraUpdateBar(totalCount)
                --SC:IncrementWeakAuraUpdateProgress()
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
                self.checkbox:SetChecked(SkillCappedDB.dontShowWeakAuraClassUpdateMessage or false)
                self.checkbox:SetScript("OnClick", function(checkbox)
                    SkillCappedDB.dontShowWeakAuraClassUpdateMessage = checkbox:GetChecked() or nil
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
        StaticPopup_Show("SC_MISSING_CLASS_WA")
    end
end

function SC:InitializeOrUpdateWeakAuras(forceInstall)
    local weakauras = SC:GetPresetWeakAuras()
    local newWeakAuras

    -- Check for PvP WeakAuras updates if PvP is selected
    if SkillCappedDB.pvpWeakauras then
        local shouldCheckPvP = false

        if SC.setupActive then
            -- During installation, only process PvP WeakAuras if the PvP WeakAuras checkbox is checked
            shouldCheckPvP = SC:WeakAuraCheckboxEnabled("PvP")
        else
            -- Outside of installation, process PvP WeakAuras if SkillCappedDB.pvpWeakauras is true
            shouldCheckPvP = SkillCappedDB.pvpWeakauras
        end

        if shouldCheckPvP then
            for weakaura, importString in pairs(weakauras["PvP"]) do
                -- Only add WeakAuras that are new or updated
                if forceInstall or (SkillCappedWeakAurasDB[weakaura] and SkillCappedWeakAurasDB[weakaura] ~= importString) then
                    if (SkillCappedTutorial and SkillCappedTutorial.ignoredWeakAuras and SkillCappedTutorial.ignoredWeakAuras[weakaura]) or (SkillCappedDB.ignoredWeakAuras and SkillCappedDB.ignoredWeakAuras[weakaura]) then
                        -- Skip this WeakAura since it's ignored
                    else
                        if reloadRequiredWeakAuras[weakaura] then
                            SC.WeakAuraReloadRequired = true
                        end
                        updatedWeakAuras[weakaura] = importString
                        newWeakAuras = true
                    end
                end
            end
        end
    end

    -- Check for PvE WeakAuras updates, including "Dungeons & Raids" and class-specific WeakAuras
    if SkillCappedDB.pveWeakauras then
        -- Retrieve the table of WeakAura checkboxes to validate selected classes during installation
        local waCheckboxes = SC:GetWACheckboxes()

        for categoryName, categoryWeakAuras in pairs(weakauras["PvE"]) do
            local shouldCheckCategory = false

            if SC.setupActive then
                -- During installation, ensure that only selected classes/Dungeons & Raids are processed
                local classCheckbox = waCheckboxes[categoryName]
                shouldCheckCategory = classCheckbox and classCheckbox:GetChecked()
            else
                -- Outside of installation, use existing SkillCappedDB entries for pveWeakauras
                shouldCheckCategory = SkillCappedDB.pveWeakauras[categoryName] and type(categoryWeakAuras) == "table"
            end

            if shouldCheckCategory then
                for weakaura, importString in pairs(categoryWeakAuras) do
                    -- Only add WeakAuras that are new or updated
                    if forceInstall or (SkillCappedWeakAurasDB[weakaura] and SkillCappedWeakAurasDB[weakaura] ~= importString) then
                        if (SkillCappedTutorial and SkillCappedTutorial.ignoredWeakAuras and SkillCappedTutorial.ignoredWeakAuras[weakaura]) or (SkillCappedDB.ignoredWeakAuras and SkillCappedDB.ignoredWeakAuras[weakaura]) then
                            -- Skip this WeakAura since it's ignored
                        else
                            if reloadRequiredWeakAuras[weakaura] then
                                SC.WeakAuraReloadRequired = true
                            end
                            updatedWeakAuras[weakaura] = importString
                            newWeakAuras = true
                        end
                    end
                end
            end
        end
    end

    -- Notify if there are new or updated WeakAuras
    if newWeakAuras then
        SC:Print("Importing new/updated WeakAuras.")
    end
end


local translations = {
    ["enUS"] = { ["Import"] = "Import",              ["Update"] = "Update",            ["Copy"] = "Import as Copy",          ["Update Auras"] = "Update Auras",            ["Close"] = "Close",   ["Size & Position"] = "Size & Position" },
    ["deDE"] = { ["Import"] = "Importieren",         ["Update"] = "Aktualisieren",     ["Copy"] = "Als Kopie importieren",   ["Update Auras"] = "Update Auras",            ["Close"] = "Schließen",   ["Size & Position"] = "Größe & Position"  },
    ["esES"] = { ["Import"] = "Importar",            ["Update"] = "Actualizar",        ["Copy"] = "Importar como copia",     ["Update Auras"] = "Actualizar auras",        ["Close"] = "Cerrar",   ["Size & Position"] = "Tamaño y posición"  },
    ["esMX"] = { ["Import"] = "Importar",            ["Update"] = "Actualizar",        ["Copy"] = "Importar como copia",     ["Update Auras"] = "Actualizar auras",        ["Close"] = "Cerrar",   ["Size & Position"] = "Tamaño y posición"  },
    ["frFR"] = { ["Import"] = "Importer",            ["Update"] = "Mettre à jour",     ["Copy"] = "Importer comme copie",    ["Update Auras"] = "Mettre à jour les auras", ["Close"] = "Fermer",   ["Size & Position"] = "Taille & Position"  },
    ["itIT"] = { ["Import"] = "Importa",             ["Update"] = "Aggiorna",          ["Copy"] = "Importa come copia",      ["Update Auras"] = "Update Auras",            ["Close"] = "Chiudi",   ["Size & Position"] = "Size & Position"  },
    ["koKR"] = { ["Import"] = "가져오기",             ["Update"] = "업데이트",           ["Copy"] = "사본으로 가져오기",        ["Update Auras"] = "위크오라 업데이트",         ["Close"] = "닫기",   ["Size & Position"] = "크기 & 위치"  },
    ["ptBR"] = { ["Import"] = "Importar",            ["Update"] = "Atualizar",         ["Copy"] = "Importar como cópia",     ["Update Auras"] = "Atualizar Auras",          ["Close"] = "Fechar",   ["Size & Position"] = "Size & Position"  },
    ["ruRU"] = { ["Import"] = "Импорт",              ["Update"] = "Обновить",          ["Copy"] = "Копировать",              ["Update Auras"] = "Обновить индикации",       ["Close"] = "Закрыть",   ["Size & Position"] = "Размер и расположение"  },
    ["zhCN"] = { ["Import"] = "导入",                 ["Update"] = "更新",              ["Copy"] = "以副本导入",               ["Update Auras"] = "更新光环",                  ["Close"] = "关闭",   ["Size & Position"] = "尺寸和位置"  },
    ["zhTW"] = { ["Import"] = "匯入",                 ["Update"] = "更新",              ["Copy"] = "匯入為副本",               ["Update Auras"] = "更新提醒效果",              ["Close"] = "關閉",   ["Size & Position"] = "大小 & 位置"  },
}

local importQueue = {}
local isImporting = false
local isRetrying = false

local function simulateButtonClick(button)
    if not button then
        return
    end

    -- Trigger OnMouseDown script if it exists
    if button:GetScript("OnMouseDown") then
        button:GetScript("OnMouseDown")(button)
    end

    -- Trigger OnMouseUp script if it exists
    if button:GetScript("OnMouseUp") then
        button:GetScript("OnMouseUp")(button)
    end
end

local function findButtonByLabel(frame, labelKey, deepSearch)
    local locale = GetLocale()
    local localeTranslations = translations[locale] or translations["enUS"]
    local labelText = localeTranslations[labelKey]
    local englishLabelText = translations["enUS"][labelKey]

    local children = {frame:GetChildren()}
    for _, child in ipairs(children) do
        if child:IsObjectType("Button") and child.GetText then
            local buttonText = child:GetText()
            if (buttonText == labelText or buttonText == englishLabelText) and child:IsVisible() and child:IsEnabled() then
                return child
            end
        elseif deepSearch and child:IsObjectType("Frame") then
            local found = findButtonByLabel(child, labelKey, deepSearch)
            if found then
                return found
            end
        end
    end
end

local function findAndClickDeepButton(frame, labelKey)
    local children = {frame:GetChildren()}
    local locale = GetLocale()
    local localeTranslations = translations[locale] or translations["enUS"]
    local labelText = localeTranslations[labelKey]

    for _, child in ipairs(children) do
        if child:IsObjectType("Button") or child:IsObjectType("Frame") then
            -- Check for FontStrings within Button or Frame elements
            local innerFontStrings = {child:GetRegions()}
            for _, region in ipairs(innerFontStrings) do
                if region:IsObjectType("FontString") then
                    local innerText = region:GetText()
                    if innerText == labelText and child:IsVisible() and child:IsEnabled() then
                        -- If it's a button, simulate the click and return
                        if child:IsObjectType("Button") then
                            simulateButtonClick(child)
                            return true
                        end
                    end
                end
            end

            -- Recursively check within child frames and buttons
            if findAndClickDeepButton(child, labelKey) then
                return true
            end
        end
    end
    return false
end


local attemptCount = 0
local maxAttempts = 10
local function autoClickWeakAuraImportButton()
    if isRetrying then return end
    isRetrying = true

    local weakauraOptions = WeakAurasOptions
    if weakauraOptions then
        WeakAurasOptions:Show()
        -- Attempt to click the "Import" button first
        local importButton = findButtonByLabel(weakauraOptions, "Import", true)
        if importButton then
            isRetrying = false
            importButton:Click()
            C_Timer.After(1, function()
                if not isImporting then
                    SC:StartWeakAuraImport()
                end
            end)
            return
        end

        -- Attempt to click "Update Auras" button if available
        if findAndClickDeepButton(weakauraOptions, "Update Auras") then
            C_Timer.After(0.3, function()
                findAndClickDeepButton(weakauraOptions, "Size & Position")
            end)
            C_Timer.After(0.5, function()
                -- Look for the new "Import" button that appears after clicking "Update Auras"
                local newUpdateButton = findButtonByLabel(weakauraOptions, "Update", true)
                if newUpdateButton then
                    isRetrying = false
                    newUpdateButton:Click()
                    C_Timer.After(1, function()
                        if not isImporting then
                            SC:StartWeakAuraImport()
                        end
                    end)
                else
                    isRetrying = false
                    autoClickWeakAuraImportButton()
                end
            end)
            return
        end

        -- Fallback to "Close" button if no other buttons were found
        local closeButton = findButtonByLabel(weakauraOptions, "Close", true)
        if closeButton then
            isRetrying = false
            closeButton:Click()
            return
        end

        -- Retry if no button was clicked
        C_Timer.After(0.5, function()
            isRetrying = false
            autoClickWeakAuraImportButton()
        end)
    else
        attemptCount = attemptCount + 1
        if attemptCount < maxAttempts then
            C_Timer.After(0.5, function()
                isRetrying = false
                autoClickWeakAuraImportButton()
            end)
        elseif attemptCount == maxAttempts then
            attemptCount = 0
        end
    end
end

-- Callback function for import completion
local function importCallback(result)
    -- if result then
    --     print("Import success")
    -- else
    --     print("Import failed")
    -- end
    table.remove(importQueue, 1)
    isImporting = false
    SC:IncrementWeakAuraProgress()
    -- if SC.weakAuraUpdateBar then
    --     SC:IncrementWeakAuraUpdateProgress()
    -- end
    SC:StartWeakAuraImport()
end

local function PrepAndImportWeakAura()
    isImporting = true
    local importData = importQueue[1]
    --print("Starting import for data:")
    WeakAuras.Import(importData, nil, importCallback)
    if not SC.updateInstalled then
        if not SC.transparentFrame then
            SC.transparentFrame = CreateFrame("Frame")
            SC.transparentFrame:SetAlpha(0)
            SC.transparentFrame:EnableMouse(false)
        end
        WeakAurasOptions:SetParent(SC.transparentFrame)
    end
    -- if WeakAurasFrame then
    --     WeakAurasFrame:SetParent(SC.transparentFrame)
    -- end
    if SkillCappedTutorial then
        SC:RepositionWeakAuras()
    else
        SC:CenterWeakAuras()
        --WeakAurasOptions:ClearAllPoints()
        --WeakAurasOptions:SetPoint("TOP", UIParent, "BOTTOM", 0, -50)
    end
    WeakAurasOptions:Show()
    WeakAurasOptions:SetFrameStrata("DIALOG")
    if SkillCappedTutorial then
        SC:ChangeLoadingText()
    end
    C_Timer.After(0.5, autoClickWeakAuraImportButton)  -- Wait half a second before attempting to click the import button
end

function SC:StartWeakAuraImport()
    if not SC.updateInstalled then
        SC:HideFakeUI()
    end
    if not isImporting and #importQueue > 0 then
        SC:RunAfterCombat(function()
            PrepAndImportWeakAura()
        end)
    elseif #importQueue == 0 then
        -- All imports processed.
        if not SC.updateInstalled then
            if WeakAurasOptions then WeakAurasOptions:Hide() end
            --if WeakAurasOptions then WeakAurasOptions:SetParent(SC.hiddenFrame) end
        end
        if WeakAurasOptions then WeakAurasOptions:Hide() end

        -- WeakAurasOptions:SetParent(UIParent)
        -- if WeakAurasFrame then
        --     WeakAurasFrame:SetParent(UIParent)
        -- end

        -- if SC.weakAuraUpdateFrame then
        --     SC.weakAuraUpdateFrame:Hide()
        --     SC:CenterWeakAuras()
        --     SC:HideTutorialShowUI()
        -- end

        if SC.setupActive then
            SC:IncrementWeakAuraProgress()
            SC:PrepReloadFrame()
        elseif SC.newTalentsAndWeakAurasAvailable and not SkillCappedDB.dontShowTalentUpdateMessage then
            StaticPopup_Show("SC_TALENTS_UPDATE")
        elseif not SkillCappedDB.waReloadForced then
            StaticPopup_Show("SC_FORCE_RELOAD")
        elseif SC.WeakAuraReloadRequired then
            StaticPopup_Show("SC_WA_RELOAD_REQUIRED")
        end
        if SC.updateInstalled and WeakAurasOptions then WeakAurasOptions:SetParent(UIParent) end
        SC.updateInstalled = nil
    end
end

function SC:QueueWeakAuraImport(importString)
    table.insert(importQueue, importString)  -- Add new import data to the queue
    --print("Queueing data for import...")
    if not isImporting then
        SC:StartWeakAuraImport()
        SC:IncrementWeakAuraProgress()
    end
end

-- function SC:ImportSingleWeakAura(weakauraName)
--     WeakAuras.Import(weakauras[weakauraName])
-- end

function SC:ImportAllWeakAuras(weakauras, update)
    local totalCount = 0
    for weakaura, importString in pairs(weakauras) do
        self:QueueWeakAuraImport(importString)
        SkillCappedWeakAurasDB[weakaura] = importString
        totalCount = totalCount + 1
    end

    if SkillCappedTutorial then
        SC:InitializeWeakAuraProgressBar(totalCount)
        SkillCappedTutorial.exitButton:Hide()
        SkillCappedTutorial.currentWeakAuras = 0
    end

    -- if update then
    --     SC:CreateWeakAuraUpdateBar(totalCount)
    --     SC:IncrementWeakAuraUpdateProgress()
    -- end

    if not isImporting then
        self:StartWeakAuraImport()
    end
end

function SC:CheckAndUpdateWeakAuras(forceInstall)
    SC:InitializeOrUpdateWeakAuras(forceInstall)
    SC:ImportAllWeakAuras(updatedWeakAuras, true)
end

function SC:UpdateWeakAurasIfChecked()
    local checkboxes = SC:GetAddonCheckboxes()
    local pveWeakAuraCheckbox = checkboxes["WeakAurasPvE"]
    local pvpWeakAuraCheckbox = checkboxes["WeakAurasPvP"]
    if (pveWeakAuraCheckbox and pveWeakAuraCheckbox:GetChecked()) or (pvpWeakAuraCheckbox and pvpWeakAuraCheckbox:GetChecked()) then
        return true
    end
    return false
end

function SC:InitializeWeakAuraProgressBar(totalCount)
    local infoText = SkillCappedTutorial.installSelectFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    infoText:SetPoint("TOP", SkillCappedTutorial.Header, "BOTTOM", 0, -18)
    infoText:SetWidth(SkillCappedTutorial.installSelectFrame:GetWidth())
    infoText:SetText("Please wait while we install your profiles.\n\nThe installation time will vary depending on\nhow many WeakAuras you have selected.")
    infoText:SetFont("Interface/AddOns/SkillCapped/media/fonts/Prototype.ttf", 11)
    infoText:SetTextColor(1, 1, 1, 1)
    SkillCappedTutorial.waLoadingText = infoText

    if not SkillCappedTutorial.weakAuraProgressBar then
        local progressBar = CreateFrame("StatusBar", nil, SkillCappedTutorial.installSelectFrame, "BackdropTemplate")
        Mixin(progressBar, SmoothStatusBarMixin)

        progressBar:SetSize(190, 35)
        progressBar:SetPoint("TOP", SkillCappedTutorial.reloadReadyText, "BOTTOM", 2, -5)
        progressBar:SetStatusBarTexture("Interface\\AddOns\\SkillCapped\\media\\smooth.tga")

        progressBar:SetStatusBarColor(0.482, 0.643, 0.988)
        progressBar:SetMinMaxSmoothedValue(0, totalCount)
        progressBar:SetSmoothedValue(0)

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
        progressText:SetText("0%")

        SkillCappedTutorial.weakAuraProgressBar = progressBar
        SkillCappedTutorial.weakAuraProgressText = progressText
        SkillCappedTutorial.totalWeakAuras = totalCount
    end

    SkillCappedTutorial.reloadReadyText:ClearAllPoints()
    SkillCappedTutorial.reloadReadyText:SetPoint("TOP", infoText, "BOTTOM", -2, -26)
    SkillCappedTutorial.reloadReadyText:SetFont("Interface/AddOns/SkillCapped/media/fonts/Prototype.ttf", 45, "THICKOUTLINE")
    SkillCappedTutorial.reloadReadyText:SetText("Installing")

end

function SC:IncrementWeakAuraProgress()
    if not SkillCappedTutorial then return end
    if SkillCappedTutorial.weakAuraProgressBar then
        SkillCappedTutorial.currentWeakAuras = math.min(SkillCappedTutorial.currentWeakAuras + 1, SkillCappedTutorial.totalWeakAuras)
        local currentCount = SkillCappedTutorial.currentWeakAuras
        local totalCount = SkillCappedTutorial.totalWeakAuras
        SkillCappedTutorial.weakAuraProgressBar:SetSmoothedValue(currentCount)
        local percentage = math.ceil((currentCount / totalCount) * 100)
        percentage = math.min(percentage, 100)
        SkillCappedTutorial.weakAuraProgressText:SetText(percentage .. "%")
    end
end




function SC:CreateWeakAuraUpdateBar(totalCount)
    -- Create parent frame to hold everything
    local updateFrame = CreateFrame("Frame", nil, nil, "BackdropTemplate")
    updateFrame:SetSize(210, 50) -- Enough room for status bar + text
    updateFrame:SetPoint("TOP", UIParent, "TOP", 0, -150) -- Slightly down from the top
    updateFrame:SetScale(1.1)
    SC:HideUIShowTutorial()

    -- Text above the status bar
    local updateText = updateFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    updateText:SetPoint("TOP", updateFrame, "TOP", 0, -5)
    updateText:SetText("Updating WeakAuras...")
    updateText:SetFont("Interface/AddOns/SkillCapped/media/fonts/Prototype.ttf", 14)
    updateText:SetTextColor(1, 1, 1, 1)

    -- Status bar
    local progressBar = CreateFrame("StatusBar", nil, updateFrame, "BackdropTemplate")
    Mixin(progressBar, SmoothStatusBarMixin)

    progressBar:SetSize(190, 20) -- Smaller height: 15
    progressBar:SetPoint("TOP", updateText, "BOTTOM", 0, -10)
    progressBar:SetStatusBarTexture("Interface\\AddOns\\SkillCapped\\media\\smooth.tga")
    progressBar:SetStatusBarColor(0.482, 0.643, 0.988)

    progressBar:SetMinMaxSmoothedValue(0, totalCount)
    progressBar:SetSmoothedValue(0)

    local bg = progressBar:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0, 0, 0, 0.6)

    -- Border around the status bar
    local border = CreateFrame("Frame", nil, progressBar, "BackdropTemplate")
    border:SetPoint("TOPLEFT", progressBar, "TOPLEFT", -3, 3)
    border:SetPoint("BOTTOMRIGHT", progressBar, "BOTTOMRIGHT", 3, -3)
    border:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })
    border:SetBackdropColor(0, 0, 0, 0)
    border:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
    border:SetFrameLevel(progressBar:GetFrameLevel() + 10)

    -- Progress text inside the bar
    local progressText = progressBar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    progressText:SetPoint("CENTER", progressBar, "CENTER", 0, 0)
    progressText:SetText("0%")

    -- Save references for future updates
    SC.weakAuraUpdateFrame = updateFrame
    SC.weakAuraUpdateBar = progressBar
    SC.weakAuraUpdateText = progressText
    SC.totalWeakAuras = totalCount

    if not SC.transparentFrame then
        SC.transparentFrame = CreateFrame("Frame")
        SC.transparentFrame:SetAlpha(0)
        SC.transparentFrame:EnableMouse(false)
    end
    WeakAurasOptions:SetParent(SC.transparentFrame)
end


function SC:IncrementWeakAuraUpdateProgress()
    if not SC.weakAuraUpdateBar then return end -- Ensure the new progress bar exists

    -- Track current progress, initialize if nil
    SC.currentWeakAuras = (SC.currentWeakAuras or 0) + 1
    SC.currentWeakAuras = math.min(SC.currentWeakAuras, SC.totalWeakAuras)

    -- Update the progress bar
    local currentCount = SC.currentWeakAuras
    local totalCount = SC.totalWeakAuras
    SC.weakAuraUpdateBar:SetSmoothedValue(currentCount)

    -- Calculate percentage and update text
    local percentage = math.ceil((currentCount / totalCount) * 100)
    percentage = math.min(percentage, 100)
    SC.weakAuraUpdateText:SetText(percentage .. "%")
end