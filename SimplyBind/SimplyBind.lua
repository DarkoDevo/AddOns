SimplyBind = {
    UI = {},
    macros = {},
    CATEGORIES = {
        COMBAT = true,
        UTILITY = true,
        SOCIAL = true
    },
    Keybinding = {
        autoBindConfig = {
            enabled = true,
            enabledRanges = {},
            conflictResolution = "PROMPT",
            perCharacter = false,
            backupBindings = true,
            smartModifiers = true
        },
        bindingTemplates = {
            COMBAT = {
                priority = 1,
                preferredModifiers = { "ALT" },
                preferredKeys = { "1", "2", "3", "4", "5", "Q", "E", "R", "F", "Z", "X", "C", "V" },
                avoidModifiers = { "CTRL" }
            },
            UTILITY = {
                priority = 2,
                preferredModifiers = { "SHIFT" },
                preferredKeys = { "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8" }
            },
            SOCIAL = {
                priority = 3,
                preferredModifiers = { "CTRL" },
                preferredKeys = { "F9", "F10", "F11", "F12" }
            }
        }
    }
}

local addonName = "SimplyBind"

-- Initialize saved variables
function SimplyBind:Initialize()
    SimplyBindDB = SimplyBindDB or {
        macros = {},
        settings = {},
        bindingBackups = {}
    }
    
    self.macros = SimplyBindDB.macros
    self:LoadSettings()
    
    -- Print welcome message
    self:Print("Loaded! Type /sb help for commands")
end

-- Create main frame and register events
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        SimplyBind:Initialize()
    elseif event == "PLAYER_LOGIN" then
        SimplyBind:CreateUI()
    end
end)

-- Slash command registration
SLASH_SIMPLYBIND1 = "/simplybind"
SLASH_SIMPLYBIND2 = "/sb"

function SlashCmdList.SIMPLYBIND(msg, editbox)
    SimplyBind:HandleSlashCommand(msg)
end

function SimplyBind:Print(msg)
    print("|cff33ff99SimplyBind|r: " .. msg)
end

function SimplyBind:CreateUI()
    -- Main frame
    local f = CreateFrame("Frame", "SimplyBindFrame", UIParent, "BackdropTemplate")
    f:SetSize(800, 600)
    f:SetPoint("CENTER")
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    f:Hide()
    
    -- Make it movable
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    
    -- Title
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 20, -20)
    title:SetText("SimplyBind")
    
    -- Close button
    local closeButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -5, -5)
    
    self.UI.mainFrame = f
    
    -- Create interfaces
    self:CreateMacroInterface()           -- Add this line
    self:CreateKeybindingInterface()
    self:CreateAdvancedAutoBindingInterface()
end

function SimplyBind:CreateMacroInterface()
    local f = CreateFrame("Frame", "SimplyBindMacroFrame", self.UI.mainFrame)
    f:SetSize(350, 250)
    f:SetPoint("TOPLEFT", 15, -50)

    -- Macro Creation Header
    local header = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    header:SetPoint("TOPLEFT", 0, 0)
    header:SetText("Create Macro")

    -- Macro Name
    local nameLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameLabel:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -15)
    nameLabel:SetText("Name:")

    local nameEdit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    nameEdit:SetSize(200, 20)
    nameEdit:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 5, -5)
    nameEdit:SetAutoFocus(false)

    -- Category Dropdown
    local categoryLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    categoryLabel:SetPoint("TOPLEFT", nameEdit, "BOTTOMLEFT", -5, -10)
    categoryLabel:SetText("Category:")

    local categoryDropdown = CreateFrame("Frame", "SimplyBindCategoryDropdown", f, "UIDropDownMenuTemplate")
    categoryDropdown:SetPoint("TOPLEFT", categoryLabel, "BOTTOMLEFT", -15, -5)

    local function CategoryDropdown_Initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        for category in pairs(SimplyBind.CATEGORIES) do
            info.text = category
            info.value = category
            info.func = function(self)
                UIDropDownMenu_SetSelectedValue(categoryDropdown, self.value)
            end
            UIDropDownMenu_AddButton(info)
        end
    end

    UIDropDownMenu_Initialize(categoryDropdown, CategoryDropdown_Initialize)
    UIDropDownMenu_SetWidth(categoryDropdown, 150)
    UIDropDownMenu_JustifyText(categoryDropdown, "LEFT")

    -- Macro Body
    local bodyLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bodyLabel:SetPoint("TOPLEFT", categoryDropdown, "BOTTOMLEFT", 15, -10)
    bodyLabel:SetText("Macro:")

    -- Modify the bodyEdit creation to include BackdropTemplate
    local bodyEdit = CreateFrame("EditBox", nil, f, "BackdropTemplate")
    bodyEdit:SetMultiLine(true)
    bodyEdit:SetSize(300, 60)
    bodyEdit:SetPoint("TOPLEFT", bodyLabel, "BOTTOMLEFT", 5, -5)
    bodyEdit:SetFontObject(ChatFontNormal)
    bodyEdit:SetAutoFocus(false)
    bodyEdit:SetMaxLetters(255)

    -- Add a background and border to the macro edit box
    local backdrop = {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 16,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    }
    bodyEdit:SetBackdrop(backdrop)

    -- Create Macro Button
    local createButton = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    createButton:SetSize(100, 22)
    createButton:SetPoint("TOPLEFT", bodyEdit, "BOTTOMLEFT", 0, -10)
    createButton:SetText("Create Macro")
    createButton:SetScript("OnClick", function()
        local name = nameEdit:GetText()
        local category = UIDropDownMenu_GetSelectedValue(categoryDropdown)
        local body = bodyEdit:GetText()
        
        if name and category and body then
            SimplyBind:CreateMacro(name, nil, body, category)
            -- Clear the fields
            nameEdit:SetText("")
            bodyEdit:SetText("")
            UIDropDownMenu_SetSelectedValue(categoryDropdown, nil)
        else
            SimplyBind:Print("Please fill in all fields")
        end
    end)

    self.UI.macroFrame = f
end


-- Keybinding Interface
function SimplyBind:CreateKeybindingInterface()
    local f = CreateFrame("Frame", "SimplyBindKeybindFrame", self.UI.mainFrame)
    f:SetSize(350, 150)
    f:SetPoint("BOTTOMLEFT", 15, 15)
    
    -- Keybind Header
    local header = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    header:SetPoint("TOPLEFT", 0, 0)
    header:SetText("Keybinding")

    -- Keybind Button
    local button = CreateFrame("Button", "SimplyBindKeyBindButton", f, "UIPanelButtonTemplate")
    button:SetSize(150, 30)
    button:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -10)
    button:SetText("Click to Bind")
    button:SetScript("OnClick", function()
        self:StartBinding()
    end)

    -- Current Bind Text
    local bindText = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bindText:SetPoint("LEFT", button, "RIGHT", 10, 0)
    bindText:SetText("No binding set")
    
    self.UI.bindButton = button
    self.UI.bindText = bindText
end

-- Auto-binding Interface
function SimplyBind:CreateAdvancedAutoBindingInterface()
    local f = self.UI.autoBindFrame or CreateFrame("Frame", "SimplyBindAutoBindFrame", self.UI.mainFrame)
    f:SetSize(600, 400)
    f:SetPoint("CENTER")
    f:Hide()

    -- Add tab system
    local tabs = {
        { text = "General", frame = "generalConfig" },
        { text = "Templates", frame = "templateConfig" },
        { text = "Categories", frame = "categoryConfig" },
        { text = "Advanced", frame = "advancedConfig" }
    }

    -- Create tab frames
    for _, tab in ipairs(tabs) do
        local frame = CreateFrame("Frame", nil, f)
        frame:SetSize(580, 350)
        frame:SetPoint("TOPLEFT", 10, -50)
        frame:Hide()
        self.UI[tab.frame] = frame
    end

    -- Create tab buttons
    local function ShowTab(index)
        for i, tabInfo in ipairs(tabs) do
            self.UI[tabInfo.frame]:Hide()
        end
        self.UI[tabs[index].frame]:Show()
    end

local previousTab
for i, tab in ipairs(tabs) do
    local tabButton = CreateFrame("Button", nil, f)
    tabButton:SetSize(115, 24)
    
    -- Create background texture
    local bg = tabButton:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.1, 0.1, 0.1, 0.8)
    
    -- Create text
    local text = tabButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    text:SetPoint("CENTER")
    text:SetText(tab.text)
    
    -- Position
    if not previousTab then
        tabButton:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 5, 25)
    else
        tabButton:SetPoint("LEFT", previousTab, "RIGHT", 2, 0)
    end
    
    -- Click handler
    tabButton:SetScript("OnClick", function()
        ShowTab(i)
        -- Update tab appearances
        for j, otherTab in ipairs(tabs) do
            local otherButton = f["tab" .. j]
            if i == j then
                otherButton.bg:SetColorTexture(0.2, 0.2, 0.2, 0.9)
                otherButton.text:SetTextColor(1, 1, 1)
            else
                otherButton.bg:SetColorTexture(0.1, 0.1, 0.1, 0.8)
                otherButton.text:SetTextColor(0.8, 0.8, 0.8)
            end
        end
    end)
    
    tabButton.bg = bg
    tabButton.text = text
    f["tab" .. i] = tabButton
    previousTab = tabButton
end

-- Initialize first tab as selected
f.tab1.bg:SetColorTexture(0.2, 0.2, 0.2, 0.9)
f.tab1.text:SetTextColor(1, 1, 1)


end

-- General Config Tab
function SimplyBind:CreateGeneralConfigTab(frame)
    -- Enable/Disable Auto-binding
    local enableCheck = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    enableCheck:SetPoint("TOPLEFT", 15, -15)
    enableCheck.text = enableCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    enableCheck.text:SetPoint("LEFT", enableCheck, "RIGHT", 5, 0)
    enableCheck.text:SetText("Enable Auto-Binding")
    enableCheck:SetChecked(self.Keybinding.autoBindConfig.enabled)
    
    -- Auto-bind on Creation
    local bindOnCreateCheck = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    bindOnCreateCheck:SetPoint("TOPLEFT", enableCheck, "BOTTOMLEFT", 0, -10)
    bindOnCreateCheck.text = bindOnCreateCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bindOnCreateCheck.text:SetPoint("LEFT", bindOnCreateCheck, "RIGHT", 5, 0)
    bindOnCreateCheck.text:SetText("Auto-bind on Macro Creation")

    -- Create Key Range Selector
    function SimplyBind:CreateKeyRangeSelector(frame, parentElement)
    local container = CreateFrame("Frame", nil, frame)
    container:SetSize(200, 100)
    container:SetPoint("TOPLEFT", parentElement, "BOTTOMLEFT", 0, -20)
    
    local header = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header:SetPoint("TOPLEFT")
    header:SetText("Key Range Selection")
    
    -- Add implementation for key range selection UI elements
    -- This is a placeholder for the actual implementation
    end

    self:CreateKeyRangeSelector(frame, enableCheck)
end

-- Template Config Tab
function SimplyBind:CreateTemplateConfigTab(frame)
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetSize(560, 320)
    scrollFrame:SetPoint("TOPLEFT", 5, -5)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(560, 500)
    scrollFrame:SetScrollChild(content)

    local previousTemplate
    for category, template in pairs(self.Keybinding.bindingTemplates) do
        local templateFrame = CreateFrame("Frame", nil, content)
        templateFrame:SetSize(540, 100)
        if not previousTemplate then
            templateFrame:SetPoint("TOPLEFT", 5, -5)
        else
            templateFrame:SetPoint("TOPLEFT", previousTemplate, "BOTTOMLEFT", 0, -10)
        end

        -- Template Header
        local header = templateFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        header:SetPoint("TOPLEFT")
        header:SetText(category)

        -- Priority Slider
        local priority = CreateFrame("Slider", nil, templateFrame, "OptionsSliderTemplate")
        priority:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 5, -15)
        priority:SetMinMaxValues(1, 10)
        priority:SetValue(template.priority)
        priority:SetWidth(200)
        priority.Text:SetText("Priority")
        priority.Low:SetText("1")
        priority.High:SetText("10")

        -- Create modifier and key selectors
        function SimplyBind:CreateModifierSelector(frame, template, anchorElement)
            local container = CreateFrame("Frame", nil, frame)
            container:SetSize(200, 30)
            container:SetPoint("TOPLEFT", anchorElement, "BOTTOMLEFT", 0, -10)
            
        -- Add modifier selection implementation
    end

    function SimplyBind:CreateKeySelector(frame, template, anchorElement)
        local container = CreateFrame("Frame", nil, frame)
        container:SetSize(200, 30)
        container:SetPoint("TOPLEFT", anchorElement, "BOTTOMLEFT", 0, -10)
        
        -- Add key selection implementation
    end

        self:CreateModifierSelector(templateFrame, template, priority)
        self:CreateKeySelector(templateFrame, template, priority)

        previousTemplate = templateFrame
    end
end
-- Category Config Tab
function SimplyBind:CreateCategoryConfigTab(frame)
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetSize(560, 320)
    scrollFrame:SetPoint("TOPLEFT", 5, -5)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(560, 500)
    scrollFrame:SetScrollChild(content)

    -- Category Management
    local categoryHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    categoryHeader:SetPoint("TOPLEFT", 5, -5)
    categoryHeader:SetText("Category Management")

    local yOffset = -35
    for category in pairs(self.CATEGORIES) do
        -- Category Frame
        local catFrame = CreateFrame("Frame", nil, content)
        catFrame:SetSize(540, 30)
        catFrame:SetPoint("TOPLEFT", 5, yOffset)

        -- Category Name
        local name = catFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        name:SetPoint("LEFT")
        name:SetText(category)

        -- Delete Button
        local deleteBtn = CreateFrame("Button", nil, catFrame, "UIPanelButtonTemplate")
        deleteBtn:SetSize(70, 22)
        deleteBtn:SetPoint("RIGHT")
        deleteBtn:SetText("Delete")
        deleteBtn:SetScript("OnClick", function()
            self:DeleteCategory(category)
        end)

        yOffset = yOffset - 35
    end

    -- Add New Category
    function SimplyBind:AddCategory(categoryName)
    if not categoryName or categoryName == "" then
        self:Print("Category name is required")
        return
    end
    
    categoryName = categoryName:upper()
    if self.CATEGORIES[categoryName] then
        self:Print("Category already exists")
        return
    end
    
    self.CATEGORIES[categoryName] = true
    self:Print(string.format("Added category '%s'", categoryName))
    -- Refresh UI if needed
    end

    local addFrame = CreateFrame("Frame", nil, content)
    addFrame:SetSize(540, 30)
    addFrame:SetPoint("TOPLEFT", 5, yOffset)

    local newCatEdit = CreateFrame("EditBox", nil, addFrame, "InputBoxTemplate")
    newCatEdit:SetSize(200, 20)
    newCatEdit:SetPoint("LEFT")
    newCatEdit:SetAutoFocus(false)

    local addBtn = CreateFrame("Button", nil, addFrame, "UIPanelButtonTemplate")
    addBtn:SetSize(70, 22)
    addBtn:SetPoint("LEFT", newCatEdit, "RIGHT", 5, 0)
    addBtn:SetText("Add")
    addBtn:SetScript("OnClick", function()
        self:AddCategory(newCatEdit:GetText())
        newCatEdit:SetText("")
    end)
end

-- Advanced Config Tab
function SimplyBind:CreateAdvancedConfigTab(frame)
    -- Add safety check
    if not self.Keybinding or not self.Keybinding.autoBindConfig then
        self:LoadSettings()
    end
    -- Conflict Resolution
    local conflictHeader = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    conflictHeader:SetPoint("TOPLEFT", 15, -15)
    conflictHeader:SetText("Conflict Resolution")

    local conflictDropdown = CreateFrame("Frame", "SimplyBindConflictDropdown", frame, "UIDropDownMenuTemplate")
    conflictDropdown:SetPoint("TOPLEFT", conflictHeader, "BOTTOMLEFT", -15, -10)

    local function OnClick(self)
        UIDropDownMenu_SetSelectedID(conflictDropdown, self:GetID())
        SimplyBind.Keybinding.autoBindConfig.conflictResolution = self.value
    end

    local function Initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        info.func = OnClick

        info.text, info.value = "Prompt", "PROMPT"
        info.checked = SimplyBind.Keybinding.autoBindConfig.conflictResolution == "PROMPT"
        UIDropDownMenu_AddButton(info)

        info.text, info.value = "Skip", "SKIP"
        info.checked = SimplyBind.Keybinding.autoBindConfig.conflictResolution == "SKIP"
        UIDropDownMenu_AddButton(info)

        info.text, info.value = "Override", "OVERRIDE"
        info.checked = SimplyBind.Keybinding.autoBindConfig.conflictResolution == "OVERRIDE"
        UIDropDownMenu_AddButton(info)
    end

    UIDropDownMenu_Initialize(conflictDropdown, Initialize)
    UIDropDownMenu_SetWidth(conflictDropdown, 150)
    UIDropDownMenu_SetButtonWidth(conflictDropdown, 174)
    UIDropDownMenu_JustifyText(conflictDropdown, "LEFT")
    UIDropDownMenu_SetSelectedValue(conflictDropdown, self.Keybinding.autoBindConfig.conflictResolution)

    -- Backup Settings
    local backupCheck = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    backupCheck:SetPoint("TOPLEFT", conflictDropdown, "BOTTOMLEFT", 15, -20)
    backupCheck.text = backupCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    backupCheck.text:SetPoint("LEFT", backupCheck, "RIGHT", 5, 0)
    backupCheck.text:SetText("Create Backup Before Binding")
    backupCheck:SetChecked(self.Keybinding.autoBindConfig.backupBindings)
    backupCheck:SetScript("OnClick", function(self)
        SimplyBind.Keybinding.autoBindConfig.backupBindings = self:GetChecked()
    end)

    -- Smart Modifier System
    local smartCheck = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    smartCheck:SetPoint("TOPLEFT", backupCheck, "BOTTOMLEFT", 0, -10)
    smartCheck.text = smartCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    smartCheck.text:SetPoint("LEFT", smartCheck, "RIGHT", 5, 0)
    smartCheck.text:SetText("Use Smart Modifier System")
    smartCheck:SetChecked(self.Keybinding.autoBindConfig.smartModifiers)
    smartCheck:SetScript("OnClick", function(self)
        SimplyBind.Keybinding.autoBindConfig.smartModifiers = self:GetChecked()
    end)
end

-- Binding System Implementation
function SimplyBind:StartBinding()
    if self.bindingInProgress then return end
    
    self.bindingInProgress = true
    self.UI.bindButton:SetText("Press a key...")
    self.UI.bindText:SetText("Waiting for input...")

    local bindFrame = CreateFrame("Frame", nil, UIParent)
    bindFrame:SetScript("OnKeyDown", function(self, key)
        self:SetPropagateKeyboardInput(false)
        SimplyBind:HandleBinding(key)
    end)
    bindFrame:SetScript("OnMouseDown", function(self, button)
        SimplyBind:HandleBinding(button)
    end)
    bindFrame:EnableKeyboard(true)
    bindFrame:EnableMouse(true)
    
    self.bindFrame = bindFrame
end

function SimplyBind:HandleBinding(key)
    if not self.bindingInProgress then return end
    
    local binding = key
    if IsShiftKeyDown() then binding = "SHIFT-" .. binding end
    if IsControlKeyDown() then binding = "CTRL-" .. binding end
    if IsAltKeyDown() then binding = "ALT-" .. binding end

    self:StopBinding()
    self:SetBinding(binding)
end

function SimplyBind:StopBinding()
    if not self.bindingInProgress then return end
    
    self.bindingInProgress = false
    if self.bindFrame then
        self.bindFrame:EnableKeyboard(false)
        self.bindFrame:EnableMouse(false)
        self.bindFrame:SetScript("OnKeyDown", nil)
        self.bindFrame:SetScript("OnMouseDown", nil)
        self.bindFrame:Hide()
        self.bindFrame = nil  -- Allow frame to be garbage collected
    end
    
    self.UI.bindButton:SetText("Click to Bind")
end

-- Macro Management System
function SimplyBind:CreateMacro(name, icon, body, category)
    if not name or name == "" then
        self:Print("Macro name is required")
        return
    end

    if not category or not self.CATEGORIES[category] then
        self:Print("Invalid category")
        return
    end

    local macro = {
        name = name,
        icon = icon or "INV_Misc_QuestionMark",
        body = body or "",
        category = category,
        binding = nil
    }

    self.macros[name] = macro
    SimplyBindDB.macros[name] = macro

    if self.Keybinding.autoBindConfig.enabled then
        self:AutoBindMacro(macro)
    end

    self:Print(string.format("Created macro '%s' in category '%s'", name, category))
    return macro
end

function SimplyBind:DeleteMacro(name)
    if not self.macros[name] then
        self:Print("Macro not found")
        return
    end

    local binding = self.macros[name].binding
    if binding then
        self:ClearBinding(binding)
    end

    self.macros[name] = nil
    SimplyBindDB.macros[name] = nil
    self:Print(string.format("Deleted macro '%s'", name))
end

-- Auto-binding Implementation
function SimplyBind:AutoBindMacro(macro)
    if not self.Keybinding.autoBindConfig.enabled then return end

    local template = self.Keybinding.bindingTemplates[macro.category]
    if not template then return end

    -- Create backup if enabled
    if self.Keybinding.autoBindConfig.backupBindings then
        self:CreateBindingBackup()
    end

    local binding = self:FindAvailableBinding(template)
    if binding then
        self:SetBinding(binding, macro)
    end
end

function SimplyBind:FindAvailableBinding(template)
    local modifiers = template.preferredModifiers
    local keys = template.preferredKeys

    for _, modifier in ipairs(modifiers) do
        for _, key in ipairs(keys) do
            local binding = modifier .. "-" .. key
            if not self:IsBindingTaken(binding) then
                return binding
            end
        end
    end

    return nil
end

-- Settings and Backup System
function SimplyBind:LoadSettings()
    -- Initialize default settings if they don't exist
    if not SimplyBindDB.settings then
        SimplyBindDB.settings = {
            autoBindConfig = {
                enabled = true,
                enabledRanges = {},
                conflictResolution = "PROMPT",
                perCharacter = false,
                backupBindings = true,
                smartModifiers = true
            },
            bindingTemplates = self.Keybinding.bindingTemplates
        }
    end

    -- Ensure all autoBindConfig fields exist
    SimplyBindDB.settings.autoBindConfig = SimplyBindDB.settings.autoBindConfig or {}
    for key, value in pairs(self.Keybinding.autoBindConfig) do
        if SimplyBindDB.settings.autoBindConfig[key] == nil then
            SimplyBindDB.settings.autoBindConfig[key] = value
        end
    end

    -- Update the addon's settings with saved values
    self.Keybinding.autoBindConfig = SimplyBindDB.settings.autoBindConfig
    self.Keybinding.bindingTemplates = SimplyBindDB.settings.bindingTemplates
end


function SimplyBind:SaveSettings()
    SimplyBindDB.settings = {
        autoBindConfig = self.Keybinding.autoBindConfig,
        bindingTemplates = self.Keybinding.bindingTemplates
    }
end

function SimplyBind:CreateBindingBackup()
    local backup = {
        timestamp = time(),
        bindings = {}
    }

    for name, macro in pairs(self.macros) do
        if macro.binding then
            backup.bindings[name] = macro.binding
        end
    end

    table.insert(SimplyBindDB.bindingBackups, backup)
    
    -- Keep only last 10 backups
    while #SimplyBindDB.bindingBackups > 10 do
        table.remove(SimplyBindDB.bindingBackups, 1)
    end
end

function SimplyBind:RestoreBindings(backupIndex)
    local backup = SimplyBindDB.bindingBackups[backupIndex]
    if not backup then return end

    -- Clear current bindings
    for name, macro in pairs(self.macros) do
        if macro.binding then
            self:ClearBinding(macro.binding)
        end
    end

    -- Restore backed up bindings
    for name, binding in pairs(backup.bindings) do
        if self.macros[name] then
            self:SetBinding(binding, self.macros[name])
        end
    end

    self:Print("Restored bindings from backup")
end

-- Utility Functions
function SimplyBind:IsBindingTaken(binding)
    for _, macro in pairs(self.macros) do
        if macro.binding == binding then
            return true
        end
    end
    return false
end

function SimplyBind:SetBinding(binding, macro)
    if not binding or not macro then
        self:Print("Invalid binding or macro")
        return false
    end
    if self:IsBindingTaken(binding) then
        local resolution = self.Keybinding.autoBindConfig.conflictResolution
        if resolution == "SKIP" then
            return false
        elseif resolution == "PROMPT" then
            -- Show confirmation dialog
            StaticPopupDialogs["SIMPLYBIND_CONFIRM_OVERRIDE"] = {
                text = string.format("Binding %s is already in use. Override?", binding),
                button1 = "Yes",
                button2 = "No",
                OnAccept = function()
                    self:ClearBinding(binding)
                    self:ApplyBinding(binding, macro)
                end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
            }
            StaticPopup_Show("SIMPLYBIND_CONFIRM_OVERRIDE")
            return
        end
    end

    self:ApplyBinding(binding, macro)
    return true
end

function SimplyBind:ApplyBinding(binding, macro)
    if macro.binding then
        self:ClearBinding(macro.binding)
    end
    
    macro.binding = binding
    SetBinding(binding, "MACRO " .. macro.name)
    SaveBindings(GetCurrentBindingSet())
    
    self:Print(string.format("Bound '%s' to %s", macro.name, binding))
end

function SimplyBind:ListMacros()
    if next(self.macros) == nil then
        self:Print("No macros found")
        return
    end
    
    self:Print("Current macros:")
    for name, macro in pairs(self.macros) do
        local binding = macro.binding or "unbound"
        self:Print(string.format("%s (%s): %s", name, macro.category, binding))
    end
end


function SimplyBind:ClearBinding(binding)
    SetBinding(binding, nil)
    SaveBindings(GetCurrentBindingSet())
end

function SimplyBind:DeleteCategory(category)
    if not self.CATEGORIES[category] then
        self:Print("Category not found")
        return
    end
    
    -- Check if category is in use
    for _, macro in pairs(self.macros) do
        if macro.category == category then
            self:Print("Cannot delete category in use")
            return
        end
    end
    
    self.CATEGORIES[category] = nil
    self:Print(string.format("Deleted category '%s'", category))
    -- Refresh UI if needed
end

-- Handle slash commands
function SimplyBind:HandleSlashCommand(msg)
    local command, rest = msg:match("^(%S*)%s*(.-)$")
    
    if command == "" or command == "help" then
        self:Print("Commands:")
        self:Print("/sb show - Show main interface")
        self:Print("/sb bind <macro> <key> - Bind a key to a macro")
        self:Print("/sb create <name> <category> <body> - Create a new macro")
        self:Print("/sb delete <name> - Delete a macro")
        self:Print("/sb list - List all macros")
        self:Print("/sb backup - Create binding backup")
        self:Print("/sb restore <index> - Restore binding backup")
    elseif command == "show" then
        self.UI.mainFrame:Show()
    elseif command == "bind" then
        local macro, key = rest:match("^(%S+)%s+(.+)$")
        if macro and key and self.macros[macro] then
            self:SetBinding(key, self.macros[macro])
        end
    elseif command == "create" then
        local name, category, body = rest:match("^(%S+)%s+(%S+)%s+(.+)$")
        if name and category and body then
            self:CreateMacro(name, nil, body, category)
        end
    elseif command == "delete" then
        self:DeleteMacro(rest)
    elseif command == "list" then
        self:ListMacros()
    elseif command == "backup" then
        self:CreateBindingBackup()
        self:Print("Created binding backup")
    elseif command == "restore" then
        local index = tonumber(rest) or #SimplyBindDB.bindingBackups
        self:RestoreBindings(index)
    end
end
