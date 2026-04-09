--[[
    Makulu Helper - Main Entry Point
    Version: 1.0.0
    
    Quick reference and learning tool for Makulu Framework
]]

-- Wait for addon to be fully loaded
local function OnAddonLoaded()
    -- Initialize database
    MakuluHelper.Database:Initialize()
    
    -- Initialize UI
    MakuluHelper.UI:Initialize()
    
    -- Show welcome message
    if MakuluHelper.DB.features.autoShowHelp then
        C_Timer.After(2, function()
            MakuluHelper:Print("Type " .. MakuluHelper.Colors.INFO .. "/makulu help" .. 
                MakuluHelper.Colors.RESET .. " to get started!")
        end)
    end
end

-- Register initialization
MakuluHelper.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
MakuluHelper.EventFrame:HookScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        OnAddonLoaded()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end
end)

-- Export global functions for easy access
_G.MakuluHelper = MakuluHelper

