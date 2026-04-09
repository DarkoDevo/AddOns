--[[
    Makulu Helper - Utility Functions
]]

MakuluHelper.Utils = {}

-- String utilities
function MakuluHelper.Utils:Trim(str)
    return str:match("^%s*(.-)%s*$")
end

function MakuluHelper.Utils:Split(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    for match in str:gmatch(pattern) do
        table.insert(result, match)
    end
    return result
end

function MakuluHelper.Utils:StartsWith(str, prefix)
    return str:sub(1, #prefix) == prefix
end

function MakuluHelper.Utils:EndsWith(str, suffix)
    return str:sub(-#suffix) == suffix
end

function MakuluHelper.Utils:Contains(str, substring)
    return str:find(substring, 1, true) ~= nil
end

-- Normalize string for fuzzy matching (same as VSCode extension)
function MakuluHelper.Utils:NormalizeString(str)
    return str:lower():gsub("[^a-z0-9]", "")
end

-- Fuzzy match two strings
function MakuluHelper.Utils:FuzzyMatch(str1, str2)
    local normalized1 = self:NormalizeString(str1)
    local normalized2 = self:NormalizeString(str2)
    return normalized1 == normalized2 or 
           normalized1:find(normalized2, 1, true) ~= nil or
           normalized2:find(normalized1, 1, true) ~= nil
end

-- Table utilities
function MakuluHelper.Utils:TableSize(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

function MakuluHelper.Utils:TableContains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

function MakuluHelper.Utils:TableCopy(tbl)
    local copy = {}
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            copy[k] = self:TableCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

-- Format utilities
function MakuluHelper.Utils:FormatNumber(num)
    if num >= 1000000 then
        return string.format("%.1fM", num / 1000000)
    elseif num >= 1000 then
        return string.format("%.1fK", num / 1000)
    else
        return tostring(num)
    end
end

function MakuluHelper.Utils:FormatTime(seconds)
    if seconds >= 60 then
        local minutes = math.floor(seconds / 60)
        local secs = seconds % 60
        return string.format("%dm %ds", minutes, secs)
    else
        return string.format("%ds", seconds)
    end
end

-- Color utilities
function MakuluHelper.Utils:ColorText(text, color)
    return color .. text .. MakuluHelper.Colors.RESET
end

function MakuluHelper.Utils:GetClassColor(class)
    local colors = {
        WARRIOR = "|cFFC79C6E",
        PALADIN = "|cFFF58CBA",
        HUNTER = "|cFFABD473",
        ROGUE = "|cFFFFF569",
        PRIEST = "|cFFFFFFFF",
        DEATHKNIGHT = "|cFFC41F3B",
        SHAMAN = "|cFF0070DE",
        MAGE = "|cFF40C7EB",
        WARLOCK = "|cFF8787ED",
        MONK = "|cFF00FF96",
        DRUID = "|cFFFF7D0A",
        DEMONHUNTER = "|cFFA330C9",
        EVOKER = "|cFF33937F"
    }
    return colors[class] or "|cFFFFFFFF"
end

-- Spell utilities (safe wrappers for WoW API)
function MakuluHelper.Utils:GetSpellInfo(spellID)
    -- Modern WoW uses C_Spell namespace
    if C_Spell and C_Spell.GetSpellInfo then
        local info = C_Spell.GetSpellInfo(spellID)
        if info then
            return info.name, info.iconID
        end
    elseif GetSpellInfo then
        local name, _, icon = GetSpellInfo(spellID)
        return name, icon
    end
    return nil, nil
end

function MakuluHelper.Utils:GetSpellLink(spellID)
    -- Modern WoW uses C_Spell namespace
    if C_Spell and C_Spell.GetSpellLink then
        return C_Spell.GetSpellLink(spellID)
    elseif GetSpellLink then
        return GetSpellLink(spellID)
    end
    return nil
end

function MakuluHelper.Utils:IsSpellKnown(spellID)
    local known = false
    if IsSpellKnown then
        known = IsSpellKnown(spellID)
    end
    if not known and IsPlayerSpell then
        known = IsPlayerSpell(spellID)
    end
    return known
end

-- UI utilities
function MakuluHelper.Utils:CreateTexture(parent, texture, width, height)
    local tex = parent:CreateTexture(nil, "ARTWORK")
    tex:SetTexture(texture)
    tex:SetSize(width, height)
    return tex
end

function MakuluHelper.Utils:CreateFontString(parent, text, font, size)
    local fs = parent:CreateFontString(nil, "OVERLAY")
    fs:SetFont(font or "Fonts\\FRIZQT__.TTF", size or 12)
    fs:SetText(text)
    return fs
end

-- Validation utilities
function MakuluHelper.Utils:IsValidSpellID(id)
    return type(id) == "number" and id > 0 and GetSpellInfo(id) ~= nil
end

function MakuluHelper.Utils:IsValidNumber(str)
    return tonumber(str) ~= nil
end

-- Search utilities
function MakuluHelper.Utils:SearchTable(tbl, query, fields)
    local results = {}
    local normalizedQuery = self:NormalizeString(query)
    
    for _, item in ipairs(tbl) do
        for _, field in ipairs(fields) do
            if item[field] then
                local normalizedField = self:NormalizeString(tostring(item[field]))
                if normalizedField:find(normalizedQuery, 1, true) then
                    table.insert(results, item)
                    break
                end
            end
        end
    end
    
    return results
end

