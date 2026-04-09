--[[
    Makulu Helper - Error Detection System
    Detects common rotation errors and provides suggestions
]]

MakuluHelper.ErrorDetection = {
    Enabled = true,
    Errors = {}
}

-- Common error patterns
local errorPatterns = {
    {
        pattern = "attempt to call method '(%w+)' %(a nil value%)",
        handler = function(methodName)
            return string.format(
                "Method '%s' doesn't exist. Did you mean one of these?\n" ..
                "  • Check spelling: /makulu api %s\n" ..
                "  • View all methods: /makulu class Unit",
                methodName, methodName
            )
        end
    },
    {
        pattern = "attempt to index field '(%w+)' %(a nil value%)",
        handler = function(fieldName)
            return string.format(
                "Field '%s' is nil. Common causes:\n" ..
                "  • Target doesn't exist: Check target:Exists()\n" ..
                "  • Spell not defined: local %s = Spell:new(spellID)\n" ..
                "  • Unit not initialized: Check MakuluFramework.%s",
                fieldName, fieldName, fieldName
            )
        end
    },
    {
        pattern = "Spell:new%((%d+)%)",
        handler = function(spellID)
            local spell = MakuluHelper.Database:GetSpellByID(tonumber(spellID))
            if spell then
                return string.format(
                    "Spell ID %d is '%s'\n" ..
                    "  • Use: /makulu spell %d for details\n" ..
                    "  • Check if you know it: IsSpellKnown(%d)",
                    spellID, spell.name, spellID, spellID
                )
            else
                return string.format(
                    "Spell ID %d not found in database\n" ..
                    "  • Verify spell ID on Wowhead\n" ..
                    "  • Check if spell exists: GetSpellInfo(%d)",
                    spellID, spellID
                )
            end
        end
    }
}

-- Enable/disable error detection
function MakuluHelper.ErrorDetection:SetEnabled(enabled)
    self.Enabled = enabled
    MakuluHelper.DB.features.errorDetection = enabled
    
    if enabled then
        MakuluHelper:Success("Error detection enabled")
    else
        MakuluHelper:Warning("Error detection disabled")
    end
end

-- Check if error detection is enabled
function MakuluHelper.ErrorDetection:IsEnabled()
    return self.Enabled and MakuluHelper.DB.features.errorDetection
end

-- Analyze error message
function MakuluHelper.ErrorDetection:AnalyzeError(errorMsg)
    if not self:IsEnabled() then
        return nil
    end
    
    for _, pattern in ipairs(errorPatterns) do
        local match = errorMsg:match(pattern.pattern)
        if match then
            return pattern.handler(match)
        end
    end
    
    return nil
end

-- Hook into Lua error handler
local function ErrorHandler(errorMsg)
    -- Store original error
    table.insert(MakuluHelper.ErrorDetection.Errors, {
        message = errorMsg,
        time = time()
    })
    
    -- Analyze error
    local suggestion = MakuluHelper.ErrorDetection:AnalyzeError(errorMsg)
    
    if suggestion then
        MakuluHelper:Print("Error detected in rotation:")
        MakuluHelper:Error(errorMsg)
        print(" ")
        MakuluHelper:Print("Suggestion:")
        print(suggestion)
    end
end

-- Register error handler
if MakuluHelper.DB and MakuluHelper.DB.features.errorDetection then
    -- Hook into error system (careful not to break other addons)
    -- This is a simplified version - production would need more robust hooking
end

-- Get recent errors
function MakuluHelper.ErrorDetection:GetRecentErrors(count)
    count = count or 5
    local recent = {}
    
    for i = #self.Errors, math.max(1, #self.Errors - count + 1), -1 do
        table.insert(recent, self.Errors[i])
    end
    
    return recent
end

-- Clear error history
function MakuluHelper.ErrorDetection:ClearErrors()
    self.Errors = {}
    MakuluHelper:Success("Error history cleared")
end

-- Common mistake detection
function MakuluHelper.ErrorDetection:CheckCommonMistakes(code)
    local mistakes = {}
    
    -- Check for missing target existence check
    if code:find("target:") and not code:find("target:Exists%(%)") then
        table.insert(mistakes, {
            type = "warning",
            message = "Missing target existence check",
            suggestion = "Add: if not target:Exists() then return end"
        })
    end
    
    -- Check for missing spell ready check
    if code:find(":Cast%(%)") and not code:find(":IsReady%(%)") then
        table.insert(mistakes, {
            type = "warning",
            message = "Missing spell ready check",
            suggestion = "Add: if spell:IsReady() then ... end"
        })
    end
    
    -- Check for resource checks
    if code:find("ChaosStrike") and not code:find("Power%(") then
        table.insert(mistakes, {
            type = "info",
            message = "Consider checking Fury before casting Chaos Strike",
            suggestion = "Add: if player:Power('fury') >= 40 then ... end"
        })
    end
    
    return mistakes
end

-- Display mistake report
function MakuluHelper.ErrorDetection:DisplayMistakes(mistakes)
    if #mistakes == 0 then
        MakuluHelper:Success("No common mistakes detected!")
        return
    end
    
    MakuluHelper:Warning(string.format("Found %d potential issue(s):", #mistakes))
    print(" ")
    
    for i, mistake in ipairs(mistakes) do
        local color = mistake.type == "error" and MakuluHelper.Colors.ERROR or
                     mistake.type == "warning" and MakuluHelper.Colors.WARNING or
                     MakuluHelper.Colors.INFO
        
        print(string.format("  %d. %s%s%s", i, color, mistake.message, MakuluHelper.Colors.RESET))
        print(string.format("     💡 %s", mistake.suggestion))
        print(" ")
    end
end

