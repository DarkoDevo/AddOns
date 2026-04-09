-- UltimateUI.lua

local addonName, addonTable = ...
local UltimateUI = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0", "AceHook-3.0")

-- Initialize the addon
function UltimateUI:OnInitialize()
    self:RegisterEvent("PLAYER_LOGIN")
    self:SetupStatusBox()
    self:SetupCustomDrawer()
end

-- Create the status box
function UltimateUI:SetupStatusBox()
    local statusBox = CreateFrame("Frame", "UltimateUIStatusBox", UIParent)
    statusBox:SetSize(200, 100)
    statusBox:SetPoint("TOPRIGHT", -20, -20)
    statusBox:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    
    local statusText = statusBox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statusText:SetPoint("CENTER")
    statusText:SetText("Status: Ready")
    self.statusText = statusText
end

-- Create a custom drawer
function UltimateUI:SetupCustomDrawer()
    local drawer = CreateFrame("Frame", "UltimateUIDrawer", UIParent)
    drawer:SetSize(150, 400)
    drawer:SetPoint("RIGHT", 0, 0)
    drawer:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    
    -- Add some sample content to the drawer
    local title = drawer:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -10)
    title:SetText("Custom Drawer")
    
    local button = CreateFrame("Button", nil, drawer, "UIPanelButtonTemplate")
    button:SetSize(100, 30)
    button:SetPoint("TOP", title, "BOTTOM", 0, -10)
    button:SetText("Click Me!")
    button:SetScript("OnClick", function()
        print("UltimateUI: Button clicked!")
    end)
    
    self.drawer = drawer
end

-- Event handler for PLAYER_LOGIN
function UltimateUI:PLAYER_LOGIN()
    print("UltimateUI loaded successfully!")
end

-- Register the addon with Ace3
UltimateUI:Register()

-- SLASH_HELLO1 = "/helloworld"

-- local function HelloWorldHandler(name)
--     if (string.len(name) > 0) then
--         message("Hello, " .. name .. "!")
--     else
--         local playerName = UnitName("player")
--         message("Hello, " .. playerName .. "!")
--     end
-- end

-- SlashCmdList["HELLO"] = HelloWorldHandler;
