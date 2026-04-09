--[[
    Makulu Helper - Slash Commands
    /makulu command system
]]

MakuluHelper.Commands = {}

-- Command handlers
local handlers = {}

-- Register a command handler
function MakuluHelper.Commands:RegisterHandler(command, handler, description)
    handlers[command:lower()] = {
        handler = handler,
        description = description
    }
end

-- Get all registered commands
function MakuluHelper.Commands:GetCommands()
    return handlers
end

-- Help command
handlers["help"] = {
    handler = function()
        MakuluHelper:Print("Available commands:")
        print(" ")
        
        local commands = {
            {"/makulu help", "Show this help message"},
            {"/makulu spell <id|name>", "Look up spell information"},
            {"/makulu api <method>", "Search API methods"},
            {"/makulu class <name>", "Show class methods"},
            {"/makulu show", "Show/hide the main UI"},
            {"/makulu stats", "Show database statistics"},
            {"/makulu version", "Show addon version"},
        }
        
        for _, cmd in ipairs(commands) do
            local command = MakuluHelper.Colors.INFO .. cmd[1] .. MakuluHelper.Colors.RESET
            local desc = cmd[2]
            print(string.format("  %s - %s", command, desc))
        end
    end,
    description = "Show help message"
}

-- Version command
handlers["version"] = {
    handler = function()
        MakuluHelper:Print(string.format("Version %s", MakuluHelper.Version))
        
        if MakuluHelper:IsMakuluFrameworkLoaded() then
            MakuluHelper:Success("Makulu Framework is loaded")
        else
            MakuluHelper:Warning("Makulu Framework is not loaded")
        end
    end,
    description = "Show addon version"
}

-- Stats command
handlers["stats"] = {
    handler = function()
        local stats = MakuluHelper.Database:GetStatistics()
        
        MakuluHelper:Print("Database Statistics:")
        print(string.format("  Spells: %s%d%s", 
            MakuluHelper.Colors.INFO, stats.spells, MakuluHelper.Colors.RESET))
        print(string.format("  API Classes: %s%d%s", 
            MakuluHelper.Colors.INFO, stats.classes, MakuluHelper.Colors.RESET))
        print(string.format("  API Methods: %s%d%s", 
            MakuluHelper.Colors.INFO, stats.methods, MakuluHelper.Colors.RESET))
    end,
    description = "Show database statistics"
}

-- Spell lookup command
handlers["spell"] = {
    handler = function(args)
        if not args or args == "" then
            MakuluHelper:Error("Usage: /makulu spell <id|name>")
            return
        end
        
        -- Try to parse as spell ID
        local spellID = tonumber(args)
        local spell
        
        if spellID then
            spell = MakuluHelper.Database:GetSpellByID(spellID)
        else
            -- Search by name
            spell = MakuluHelper.Database:GetSpellByName(args)
            
            -- If not found, try fuzzy search
            if not spell then
                local results = MakuluHelper.Database:SearchSpells(args, 5)
                if #results > 0 then
                    MakuluHelper:Print(string.format("Found %d spell(s):", #results))
                    for i, s in ipairs(results) do
                        local link = GetSpellLink(s.id) or s.name
                        print(string.format("  %d. %s (%s%d%s)", 
                            i, link, 
                            MakuluHelper.Colors.INFO, s.id, MakuluHelper.Colors.RESET))
                    end
                    return
                end
            end
        end
        
        if spell then
            MakuluHelper.SpellLookup:DisplaySpell(spell)
        else
            MakuluHelper:Error(string.format("Spell not found: %s", args))
        end
    end,
    description = "Look up spell information"
}

-- API search command
handlers["api"] = {
    handler = function(args)
        if not args or args == "" then
            MakuluHelper:Error("Usage: /makulu api <method>")
            return
        end
        
        local results = MakuluHelper.Database:SearchAPI(args, 10)
        
        if #results > 0 then
            MakuluHelper:Print(string.format("Found %d method(s):", #results))
            for i, result in ipairs(results) do
                local classColor = MakuluHelper.Utils:GetClassColor("DEMONHUNTER")
                print(string.format("  %d. %s%s%s:%s%s%s", 
                    i,
                    classColor, result.class, MakuluHelper.Colors.RESET,
                    MakuluHelper.Colors.INFO, result.method.name, MakuluHelper.Colors.RESET))
                print(string.format("     %s", result.method.signature))
            end
        else
            MakuluHelper:Error(string.format("No methods found matching: %s", args))
        end
    end,
    description = "Search API methods"
}

-- Class command
handlers["class"] = {
    handler = function(args)
        if not args or args == "" then
            local classes = MakuluHelper.Database:GetAllClasses()
            MakuluHelper:Print("Available classes:")
            for _, className in ipairs(classes) do
                local count = MakuluHelper.Database:GetClassMethodCount(className)
                print(string.format("  %s%s%s (%d methods)", 
                    MakuluHelper.Colors.INFO, className, MakuluHelper.Colors.RESET, count))
            end
            return
        end
        
        local class = MakuluHelper.Database:GetAPIClass(args)
        if class then
            MakuluHelper:Print(string.format("Class: %s%s%s", 
                MakuluHelper.Colors.INFO, args, MakuluHelper.Colors.RESET))
            print(string.format("  %s", class.description))
            print(string.format("  Methods: %d", #class.methods))
            print(" ")
            print("  Use " .. MakuluHelper.Colors.INFO .. "/makulu api <method>" .. 
                MakuluHelper.Colors.RESET .. " to search methods")
        else
            MakuluHelper:Error(string.format("Class not found: %s", args))
        end
    end,
    description = "Show class information"
}

-- Show/hide UI command
handlers["show"] = {
    handler = function()
        if MakuluHelper.UI and MakuluHelper.UI.MainFrame then
            MakuluHelper.UI:Toggle()
        else
            MakuluHelper:Error("UI not initialized yet")
        end
    end,
    description = "Show/hide the main UI"
}

-- Main slash command handler
local function SlashCommandHandler(msg)
    -- Initialize database if not done
    if not MakuluHelper.Database.Initialized then
        MakuluHelper.Database:Initialize()
    end
    
    -- Parse command and arguments
    local command, args = msg:match("^(%S*)%s*(.-)$")
    command = command:lower()
    
    -- Default to help if no command
    if command == "" then
        command = "help"
    end
    
    -- Find and execute handler
    local handler = handlers[command]
    if handler then
        handler.handler(args)
    else
        MakuluHelper:Error(string.format("Unknown command: %s", command))
        MakuluHelper:Print("Type " .. MakuluHelper.Colors.INFO .. "/makulu help" .. 
            MakuluHelper.Colors.RESET .. " for available commands")
    end
end

-- Register slash commands
SLASH_MAKULU1 = "/makulu"
SLASH_MAKULU2 = "/mh"
SlashCmdList["MAKULU"] = SlashCommandHandler

