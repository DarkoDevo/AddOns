--[[
    Makulu Helper - Main UI Frame
    Draggable window with tabs for different features
]]

MakuluHelper.UI = {}

local UI = MakuluHelper.UI

-- Create main frame
function UI:CreateMainFrame()
    if self.MainFrame then
        return self.MainFrame
    end
    
    -- Create frame
    local frame = CreateFrame("Frame", "MakuluHelperMainFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(600, 400)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetFrameStrata("DIALOG")
    frame:Hide()
    
    -- Title
    frame.title = frame:CreateFontString(nil, "OVERLAY")
    frame.title:SetFontObject("GameFontHighlight")
    frame.title:SetPoint("LEFT", frame.TitleBg, "LEFT", 5, 0)
    frame.title:SetText("Makulu Helper v" .. MakuluHelper.Version)
    
    -- Close button (already created by template)
    frame.CloseButton:SetScript("OnClick", function()
        frame:Hide()
    end)
    
    -- Tab buttons
    local tabs = {
        {name = "Spells", onClick = function() UI:ShowTab("spells") end},
        {name = "API", onClick = function() UI:ShowTab("api") end},
        {name = "Examples", onClick = function() UI:ShowTab("examples") end},
        {name = "Settings", onClick = function() UI:ShowTab("settings") end}
    }
    
    frame.tabs = {}
    for i, tab in ipairs(tabs) do
        local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        button:SetSize(100, 25)
        button:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", (i-1) * 105, 0)
        button:SetText(tab.name)
        button:SetScript("OnClick", tab.onClick)
        frame.tabs[i] = button
    end
    
    -- Content area
    frame.content = CreateFrame("Frame", nil, frame)
    frame.content:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -30)
    frame.content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
    
    self.MainFrame = frame
    return frame
end

-- Show/hide main frame
function UI:Toggle()
    if not self.MainFrame then
        self:CreateMainFrame()
    end
    
    if self.MainFrame:IsShown() then
        self.MainFrame:Hide()
    else
        self.MainFrame:Show()
    end
end

-- Show specific tab
function UI:ShowTab(tabName)
    if not self.MainFrame then
        self:CreateMainFrame()
    end
    
    -- Clear content
    for _, child in ipairs({self.MainFrame.content:GetChildren()}) do
        child:Hide()
    end
    
    -- Show tab content
    if tabName == "spells" then
        self:ShowSpellTab()
    elseif tabName == "api" then
        self:ShowAPITab()
    elseif tabName == "examples" then
        self:ShowExamplesTab()
    elseif tabName == "settings" then
        self:ShowSettingsTab()
    end
end

-- Spell tab (placeholder)
function UI:ShowSpellTab()
    local content = self.MainFrame.content
    
    local text = content:CreateFontString(nil, "OVERLAY")
    text:SetFontObject("GameFontNormal")
    text:SetPoint("TOP", content, "TOP", 0, -20)
    text:SetText("Spell Database Browser")
    
    local info = content:CreateFontString(nil, "OVERLAY")
    info:SetFontObject("GameFontNormal")
    info:SetPoint("TOP", text, "BOTTOM", 0, -20)
    info:SetText("Use /makulu spell <id|name> to look up spells")
end

-- API tab (placeholder)
function UI:ShowAPITab()
    local content = self.MainFrame.content
    
    local text = content:CreateFontString(nil, "OVERLAY")
    text:SetFontObject("GameFontNormal")
    text:SetPoint("TOP", content, "TOP", 0, -20)
    text:SetText("API Reference Browser")
    
    local info = content:CreateFontString(nil, "OVERLAY")
    info:SetFontObject("GameFontNormal")
    info:SetPoint("TOP", text, "BOTTOM", 0, -20)
    info:SetText("Use /makulu api <method> to search methods")
end

-- Examples tab (placeholder)
function UI:ShowExamplesTab()
    local content = self.MainFrame.content
    
    local text = content:CreateFontString(nil, "OVERLAY")
    text:SetFontObject("GameFontNormal")
    text:SetPoint("TOP", content, "TOP", 0, -20)
    text:SetText("Example Rotations")
    
    local info = content:CreateFontString(nil, "OVERLAY")
    info:SetFontObject("GameFontNormal")
    info:SetPoint("TOP", text, "BOTTOM", 0, -20)
    info:SetText("Coming soon!")
end

-- Settings tab (placeholder)
function UI:ShowSettingsTab()
    local content = self.MainFrame.content
    
    local text = content:CreateFontString(nil, "OVERLAY")
    text:SetFontObject("GameFontNormal")
    text:SetPoint("TOP", content, "TOP", 0, -20)
    text:SetText("Settings")
    
    -- Add some basic settings
    local y = -60
    
    -- Error detection toggle
    local errorDetection = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    errorDetection:SetPoint("TOPLEFT", content, "TOPLEFT", 20, y)
    errorDetection.text:SetText("Enable Error Detection")
    errorDetection:SetChecked(MakuluHelper.DB.features.errorDetection)
    errorDetection:SetScript("OnClick", function(self)
        MakuluHelper.ErrorDetection:SetEnabled(self:GetChecked())
    end)
    
    y = y - 30
    
    -- Verbose mode toggle
    local verboseMode = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    verboseMode:SetPoint("TOPLEFT", content, "TOPLEFT", 20, y)
    verboseMode.text:SetText("Verbose Mode (Debug)")
    verboseMode:SetChecked(MakuluHelper.DB.features.verboseMode)
    verboseMode:SetScript("OnClick", function(self)
        MakuluHelper.DB.features.verboseMode = self:GetChecked()
        if self:GetChecked() then
            MakuluHelper:Success("Verbose mode enabled")
        else
            MakuluHelper:Print("Verbose mode disabled")
        end
    end)
end

-- Initialize UI
function UI:Initialize()
    self:CreateMainFrame()
    MakuluHelper:Debug("UI initialized")
end

