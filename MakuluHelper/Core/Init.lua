--[[
    Makulu Helper - Core Initialization
    Version: 1.0.0
]]

-- Create addon namespace
MakuluHelper = {}
MakuluHelper.Version = "1.0.0"
MakuluHelper.Name = "Makulu Helper"

-- Addon state
MakuluHelper.Loaded = false
MakuluHelper.Initialized = false

-- Database reference (will be set on ADDON_LOADED)
MakuluHelper.DB = nil

-- Default settings
MakuluHelper.Defaults = {
    ui = {
        scale = 1.0,
        locked = false,
        position = {
            point = "CENTER",
            x = 0,
            y = 0
        }
    },
    features = {
        errorDetection = true,
        autoShowHelp = true,
        verboseMode = false
    },
    display = {
        showSpellIcons = true,
        showExamples = true,
        maxResults = 10
    }
}

-- Color codes for chat output
MakuluHelper.Colors = {
    PRIMARY = "|cFFA330C9",    -- Purple
    SUCCESS = "|cFF00FF00",    -- Green
    ERROR = "|cFFFF0000",      -- Red
    WARNING = "|cFFFFA500",    -- Orange
    INFO = "|cFF00BFFF",       -- Light Blue
    RESET = "|r"
}

-- Print helper function
function MakuluHelper:Print(message, color)
    local prefix = self.Colors.PRIMARY .. "[Makulu Helper]" .. self.Colors.RESET
    local coloredMessage = (color or "") .. message .. self.Colors.RESET
    print(prefix .. " " .. coloredMessage)
end

-- Debug print (only if verbose mode enabled)
function MakuluHelper:Debug(message)
    if self.DB and self.DB.features.verboseMode then
        self:Print("[DEBUG] " .. message, self.Colors.INFO)
    end
end

-- Error print
function MakuluHelper:Error(message)
    self:Print(message, self.Colors.ERROR)
end

-- Success print
function MakuluHelper:Success(message)
    self:Print(message, self.Colors.SUCCESS)
end

-- Warning print
function MakuluHelper:Warning(message)
    self:Print(message, self.Colors.WARNING)
end

-- Initialize database with defaults
function MakuluHelper:InitializeDatabase()
    if not MakuluHelperDB then
        MakuluHelperDB = {}
    end
    
    -- Deep copy defaults if not set
    for category, settings in pairs(self.Defaults) do
        if not MakuluHelperDB[category] then
            MakuluHelperDB[category] = {}
            for key, value in pairs(settings) do
                if type(value) == "table" then
                    MakuluHelperDB[category][key] = {}
                    for k, v in pairs(value) do
                        MakuluHelperDB[category][key][k] = v
                    end
                else
                    MakuluHelperDB[category][key] = value
                end
            end
        end
    end
    
    self.DB = MakuluHelperDB
    self:Debug("Database initialized")
end

-- Check if Makulu Framework is loaded
function MakuluHelper:IsMakuluFrameworkLoaded()
    return MakuluFramework ~= nil
end

-- Get addon info
function MakuluHelper:GetInfo()
    return string.format("%s v%s", self.Name, self.Version)
end

-- Event frame
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "MakuluHelper" then
            MakuluHelper:InitializeDatabase()
            MakuluHelper.Loaded = true
            MakuluHelper:Debug("Addon loaded")
        end
    elseif event == "PLAYER_LOGIN" then
        if MakuluHelper.Loaded then
            MakuluHelper.Initialized = true
            MakuluHelper:Print("Loaded successfully! Type " .. 
                MakuluHelper.Colors.INFO .. "/makulu help" .. 
                MakuluHelper.Colors.RESET .. " for commands.")
            
            -- Check if Makulu Framework is loaded
            if MakuluHelper:IsMakuluFrameworkLoaded() then
                MakuluHelper:Success("Makulu Framework detected!")
            else
                MakuluHelper:Warning("Makulu Framework not detected. Some features may be limited.")
            end
        end
    end
end)

-- Export event frame for other modules
MakuluHelper.EventFrame = eventFrame

