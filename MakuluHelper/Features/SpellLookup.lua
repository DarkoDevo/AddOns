--[[
    Makulu Helper - Spell Lookup Feature
]]

MakuluHelper.SpellLookup = {}

-- Display spell information in chat
function MakuluHelper.SpellLookup:DisplaySpell(spell)
    if not spell then
        return
    end

    -- Get spell link from game (safe call for different WoW versions)
    local spellLink = spell.name
    if C_Spell and C_Spell.GetSpellLink then
        spellLink = C_Spell.GetSpellLink(spell.id) or spell.name
    elseif GetSpellLink then
        spellLink = GetSpellLink(spell.id) or spell.name
    end
    
    -- Header
    MakuluHelper:Print(string.format("Spell Information: %s", spellLink))
    print(" ")
    
    -- Basic info
    print(string.format("  %sID:%s %d", 
        MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, spell.id))
    
    if spell.class then
        local classColor = MakuluHelper.Utils:GetClassColor(spell.class)
        print(string.format("  %sClass:%s %s%s%s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET,
            classColor, spell.class, MakuluHelper.Colors.RESET))
    end
    
    if spell.spec then
        print(string.format("  %sSpec:%s %s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, spell.spec))
    end
    
    print(" ")
    
    -- Description
    if spell.description then
        print(string.format("  %s", spell.description))
        print(" ")
    end
    
    -- Cast info
    if spell.castTime then
        print(string.format("  %sCast Time:%s %s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, spell.castTime))
    end
    
    if spell.cooldown and spell.cooldown > 0 then
        local cdText = MakuluHelper.Utils:FormatTime(spell.cooldown)
        print(string.format("  %sCooldown:%s %s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, cdText))
    end
    
    if spell.range and spell.range > 0 then
        print(string.format("  %sRange:%s %d yards", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, spell.range))
    end
    
    if spell.cost then
        print(string.format("  %sCost:%s %s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, spell.cost))
    end
    
    if spell.school then
        print(string.format("  %sSchool:%s %s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, spell.school))
    end
    
    print(" ")

    -- Check if player knows the spell (safe call)
    local knowsSpell = false
    if IsSpellKnown then
        knowsSpell = IsSpellKnown(spell.id)
    end
    if not knowsSpell and IsPlayerSpell then
        knowsSpell = IsPlayerSpell(spell.id)
    end

    if knowsSpell then
        MakuluHelper:Success("You know this spell!")
    else
        MakuluHelper:Warning("You don't know this spell")
    end
    
    -- Wowhead link
    print(string.format("  %sWowhead:%s https://www.wowhead.com/spell=%d", 
        MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, spell.id))
end

-- Display spell tooltip (for UI)
function MakuluHelper.SpellLookup:CreateSpellTooltip(parent, spell)
    if not spell then
        return
    end

    -- Don't create tooltips in combat to avoid taint
    if InCombatLockdown and InCombatLockdown() then
        return
    end

    local tooltip = CreateFrame("GameTooltip", "MakuluHelperSpellTooltip", parent, "GameTooltipTemplate")
    tooltip:SetOwner(parent, "ANCHOR_CURSOR")

    -- Set spell (safe call)
    if tooltip.SetSpellByID then
        tooltip:SetSpellByID(spell.id)
    end

    -- Add custom info
    tooltip:AddLine(" ")
    tooltip:AddLine("Makulu Helper Info:", 0.64, 0.21, 0.93)

    if spell.class then
        tooltip:AddDoubleLine("Class:", spell.class, 1, 1, 1, 0.64, 0.21, 0.93)
    end

    if spell.spec then
        tooltip:AddDoubleLine("Spec:", spell.spec, 1, 1, 1, 0.64, 0.21, 0.93)
    end

    tooltip:AddLine(" ")
    tooltip:AddLine("Type /makulu spell " .. spell.id .. " for more info", 0.5, 0.5, 0.5)

    tooltip:Show()

    return tooltip
end

-- Search spells and display results
function MakuluHelper.SpellLookup:SearchAndDisplay(query, maxResults)
    maxResults = maxResults or 10
    
    local results = MakuluHelper.Database:SearchSpells(query, maxResults)
    
    if #results == 0 then
        MakuluHelper:Error(string.format("No spells found matching: %s", query))
        return
    end
    
    if #results == 1 then
        -- Single result, display full info
        self:DisplaySpell(results[1])
    else
        -- Multiple results, show list
        MakuluHelper:Print(string.format("Found %d spell(s):", #results))
        for i, spell in ipairs(results) do
            -- Get spell link (safe call)
            local link = spell.name
            if C_Spell and C_Spell.GetSpellLink then
                link = C_Spell.GetSpellLink(spell.id) or spell.name
            elseif GetSpellLink then
                link = GetSpellLink(spell.id) or spell.name
            end

            local classColor = spell.class and MakuluHelper.Utils:GetClassColor(spell.class) or ""
            local classText = spell.class and string.format(" [%s%s%s]",
                classColor, spell.class, MakuluHelper.Colors.RESET) or ""

            print(string.format("  %d. %s%s (%s%d%s)",
                i, link, classText,
                MakuluHelper.Colors.INFO, spell.id, MakuluHelper.Colors.RESET))
        end
        print(" ")
        print(string.format("  Use %s/makulu spell <id>%s to see details", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET))
    end
end

-- Get spell usage example
function MakuluHelper.SpellLookup:GetSpellExample(spell)
    if not spell then
        return nil
    end
    
    local example = string.format([[
-- Define spell
local %s = Spell:new(%d)

-- Check if ready and cast
if %s:IsReady() and player:CanCast(%s) then
    return %s:Cast()
end
]], 
        spell.name:gsub("[^%w]", ""),  -- Remove special chars for variable name
        spell.id,
        spell.name:gsub("[^%w]", ""),
        spell.name:gsub("[^%w]", ""),
        spell.name:gsub("[^%w]", "")
    )
    
    return example
end

