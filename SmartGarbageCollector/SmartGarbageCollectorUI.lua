-- =============================================================================
-- Smart Garbage Collector UI
-- Do not remove important & explanatory comments
-- =============================================================================

local SmartGarbageCollectorUI = {}

-- =============================================================================
-- LOCAL VARIABLES
-- =============================================================================

local mainFrame = nil

-- =============================================================================
-- RELOAD CONFIRMATION DIALOG
-- =============================================================================

local function ShowReloadDialog(title, message, onConfirm)
	-- Create backdrop frame
	local backdrop = CreateFrame("Frame", nil, UIParent)
	backdrop:SetFrameStrata("FULLSCREEN_DIALOG")
	backdrop:SetAllPoints()
	backdrop:EnableMouse(true)

	-- Semi-transparent black background
	backdrop.bg = backdrop:CreateTexture(nil, "BACKGROUND")
	backdrop.bg:SetAllPoints()
	backdrop.bg:SetColorTexture(0, 0, 0, 0.7)

	-- Create dialog frame
	local dialog = CreateFrame("Frame", nil, backdrop)
	dialog:SetSize(400, 150)
	dialog:SetPoint("CENTER")
	dialog:SetFrameStrata("FULLSCREEN_DIALOG")

	-- Dialog background
	dialog.bg = dialog:CreateTexture(nil, "BACKGROUND")
	dialog.bg:SetAllPoints()
	dialog.bg:SetColorTexture(0.153, 0.188, 0.247)

	-- Dialog border
	dialog.border = CreateFrame("Frame", nil, dialog)
	dialog.border:SetAllPoints()

	-- Border textures
	dialog.border.top = dialog.border:CreateTexture(nil, "OVERLAY")
	dialog.border.top:SetHeight(2)
	dialog.border.top:SetPoint("TOPLEFT")
	dialog.border.top:SetPoint("TOPRIGHT")
	dialog.border.top:SetColorTexture(0.35, 0.57, 0.75, 1.0)

	dialog.border.bottom = dialog.border:CreateTexture(nil, "OVERLAY")
	dialog.border.bottom:SetHeight(2)
	dialog.border.bottom:SetPoint("BOTTOMLEFT")
	dialog.border.bottom:SetPoint("BOTTOMRIGHT")
	dialog.border.bottom:SetColorTexture(0.35, 0.57, 0.75, 1.0)

	dialog.border.left = dialog.border:CreateTexture(nil, "OVERLAY")
	dialog.border.left:SetWidth(2)
	dialog.border.left:SetPoint("TOPLEFT")
	dialog.border.left:SetPoint("BOTTOMLEFT")
	dialog.border.left:SetColorTexture(0.35, 0.57, 0.75, 1.0)

	dialog.border.right = dialog.border:CreateTexture(nil, "OVERLAY")
	dialog.border.right:SetWidth(2)
	dialog.border.right:SetPoint("TOPRIGHT")
	dialog.border.right:SetPoint("BOTTOMRIGHT")
	dialog.border.right:SetColorTexture(0.35, 0.57, 0.75, 1.0)

	-- Title text
	dialog.title = dialog:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
	dialog.title:SetPoint("TOP", 0, -15)
	dialog.title:SetText(title)
	dialog.title:SetTextColor(0.638, 0.825, 0.957)

	-- Message text
	dialog.message = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	dialog.message:SetPoint("TOP", dialog.title, "BOTTOM", 0, -15)
	dialog.message:SetWidth(360)
	dialog.message:SetText(message)
	dialog.message:SetJustifyH("CENTER")
	dialog.message:SetTextColor(1, 1, 1)

	-- Confirm button
	local confirmButton = CreateFrame("Button", nil, dialog)
	confirmButton:SetSize(120, 30)
	confirmButton:SetPoint("BOTTOM", dialog, "BOTTOM", -65, 15)

	confirmButton.bg = confirmButton:CreateTexture(nil, "BACKGROUND")
	confirmButton.bg:SetAllPoints()
	confirmButton.bg:SetColorTexture(0.153, 0.187, 0.247)

	confirmButton.border = CreateFrame("Frame", nil, confirmButton)
	confirmButton.border:SetAllPoints()
	confirmButton.border.top = confirmButton.border:CreateTexture(nil, "OVERLAY")
	confirmButton.border.top:SetHeight(1)
	confirmButton.border.top:SetPoint("TOPLEFT")
	confirmButton.border.top:SetPoint("TOPRIGHT")
	confirmButton.border.top:SetColorTexture(0.35, 0.57, 0.75, 1.0)
	confirmButton.border.bottom = confirmButton.border:CreateTexture(nil, "OVERLAY")
	confirmButton.border.bottom:SetHeight(1)
	confirmButton.border.bottom:SetPoint("BOTTOMLEFT")
	confirmButton.border.bottom:SetPoint("BOTTOMRIGHT")
	confirmButton.border.bottom:SetColorTexture(0.35, 0.57, 0.75, 1.0)
	confirmButton.border.left = confirmButton.border:CreateTexture(nil, "OVERLAY")
	confirmButton.border.left:SetWidth(1)
	confirmButton.border.left:SetPoint("TOPLEFT")
	confirmButton.border.left:SetPoint("BOTTOMLEFT")
	confirmButton.border.left:SetColorTexture(0.35, 0.57, 0.75, 1.0)
	confirmButton.border.right = confirmButton.border:CreateTexture(nil, "OVERLAY")
	confirmButton.border.right:SetWidth(1)
	confirmButton.border.right:SetPoint("TOPRIGHT")
	confirmButton.border.right:SetPoint("BOTTOMRIGHT")
	confirmButton.border.right:SetColorTexture(0.35, 0.57, 0.75, 1.0)

	confirmButton.text = confirmButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	confirmButton.text:SetPoint("CENTER")
	confirmButton.text:SetText("Reload Now")
	confirmButton.text:SetTextColor(1, 1, 1)

	confirmButton:SetScript("OnEnter", function(self)
		self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
	end)

	confirmButton:SetScript("OnLeave", function(self)
		self.bg:SetColorTexture(0.153, 0.187, 0.247)
	end)

	confirmButton:SetScript("OnClick", function()
		backdrop:Hide()
		if onConfirm then
			onConfirm()
		end
		ReloadUI()
	end)

	-- Cancel button
	local cancelButton = CreateFrame("Button", nil, dialog)
	cancelButton:SetSize(120, 30)
	cancelButton:SetPoint("BOTTOM", dialog, "BOTTOM", 65, 15)

	cancelButton.bg = cancelButton:CreateTexture(nil, "BACKGROUND")
	cancelButton.bg:SetAllPoints()
	cancelButton.bg:SetColorTexture(0.153, 0.187, 0.247)

	cancelButton.border = CreateFrame("Frame", nil, cancelButton)
	cancelButton.border:SetAllPoints()
	cancelButton.border.top = cancelButton.border:CreateTexture(nil, "OVERLAY")
	cancelButton.border.top:SetHeight(1)
	cancelButton.border.top:SetPoint("TOPLEFT")
	cancelButton.border.top:SetPoint("TOPRIGHT")
	cancelButton.border.top:SetColorTexture(0.35, 0.57, 0.75, 1.0)
	cancelButton.border.bottom = cancelButton.border:CreateTexture(nil, "OVERLAY")
	cancelButton.border.bottom:SetHeight(1)
	cancelButton.border.bottom:SetPoint("BOTTOMLEFT")
	cancelButton.border.bottom:SetPoint("BOTTOMRIGHT")
	cancelButton.border.bottom:SetColorTexture(0.35, 0.57, 0.75, 1.0)
	cancelButton.border.left = cancelButton.border:CreateTexture(nil, "OVERLAY")
	cancelButton.border.left:SetWidth(1)
	cancelButton.border.left:SetPoint("TOPLEFT")
	cancelButton.border.left:SetPoint("BOTTOMLEFT")
	cancelButton.border.left:SetColorTexture(0.35, 0.57, 0.75, 1.0)
	cancelButton.border.right = cancelButton.border:CreateTexture(nil, "OVERLAY")
	cancelButton.border.right:SetWidth(1)
	cancelButton.border.right:SetPoint("TOPRIGHT")
	cancelButton.border.right:SetPoint("BOTTOMRIGHT")
	cancelButton.border.right:SetColorTexture(0.35, 0.57, 0.75, 1.0)

	cancelButton.text = cancelButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	cancelButton.text:SetPoint("CENTER")
	cancelButton.text:SetText("Later")
	cancelButton.text:SetTextColor(1, 1, 1)

	cancelButton:SetScript("OnEnter", function(self)
		self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
	end)

	cancelButton:SetScript("OnLeave", function(self)
		self.bg:SetColorTexture(0.153, 0.187, 0.247)
	end)

	cancelButton:SetScript("OnClick", function()
		backdrop:Hide()
	end)

	-- Show the dialog
	backdrop:Show()
end

-- =============================================================================
-- MODERN UI HELPER FUNCTIONS
-- =============================================================================

local function CreateUIElementBorders(frame, borderFrame)
	-- -------------------------------------------------------------------------
	-- Top border
	-- -------------------------------------------------------------------------
	borderFrame.top = borderFrame:CreateTexture(nil, "OVERLAY")
	borderFrame.top:SetHeight(1)
	borderFrame.top:SetPoint("TOPLEFT", frame, "TOPLEFT")
	borderFrame.top:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
	borderFrame.top:SetColorTexture(0.35, 0.57, 0.75, 1.0)

	-- -------------------------------------------------------------------------
	-- Bottom border
	-- -------------------------------------------------------------------------
	borderFrame.bottom = borderFrame:CreateTexture(nil, "OVERLAY")
	borderFrame.bottom:SetHeight(1)
	borderFrame.bottom:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
	borderFrame.bottom:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
	borderFrame.bottom:SetColorTexture(0.35, 0.57, 0.75, 1.0)

	-- -------------------------------------------------------------------------
	-- Left border
	-- -------------------------------------------------------------------------
	borderFrame.left = borderFrame:CreateTexture(nil, "OVERLAY")
	borderFrame.left:SetWidth(1)
	borderFrame.left:SetPoint("TOPLEFT", frame, "TOPLEFT")
	borderFrame.left:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
	borderFrame.left:SetColorTexture(0.35, 0.57, 0.75, 1.0)

	-- -------------------------------------------------------------------------
	-- Right border
	-- -------------------------------------------------------------------------
	borderFrame.right = borderFrame:CreateTexture(nil, "OVERLAY")
	borderFrame.right:SetWidth(1)
	borderFrame.right:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
	borderFrame.right:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
	borderFrame.right:SetColorTexture(0.35, 0.57, 0.75, 1.0)
end

local function CreateModernButton(parent, width, height, text, tooltipText)
	local button = CreateFrame("Button", nil, parent)
	button:SetSize(width, height)

	-- -------------------------------------------------------------------------
	-- Button background and border
	-- -------------------------------------------------------------------------
	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetAllPoints()
	button.bg:SetColorTexture(0.153, 0.187, 0.247)

	button.border = CreateFrame("Frame", nil, button)
	button.border:SetAllPoints()
	CreateUIElementBorders(button, button.border)

	-- -------------------------------------------------------------------------
	-- Button text
	-- -------------------------------------------------------------------------
	button.text = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	button.text:SetPoint("CENTER")
	button.text:SetText(text or "")
	button.text:SetTextColor(1, 1, 1)

	-- -------------------------------------------------------------------------
	-- Hover effects and tooltip
	-- -------------------------------------------------------------------------
	button:SetScript("OnEnter", function(self)
		self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)

		if tooltipText then
			GameTooltip:SetOwner(self, "ANCHOR_TOP")
			GameTooltip:SetText(text, 1, 1, 1, true)
			GameTooltip:AddLine(tooltipText, 1, 1, 1, true)
			GameTooltip:Show()
		end
	end)

	button:SetScript("OnLeave", function(self)
		self.bg:SetColorTexture(0.153, 0.187, 0.247)
		if tooltipText then
			GameTooltip:Hide()
		end
	end)

	return button
end

local function CreateModernInputBox(parent, width, height, labelText, defaultValue, minVal, maxVal)
	local container = CreateFrame("Frame", nil, parent)
	container:SetSize(width, height + 20)

	-- -------------------------------------------------------------------------
	-- Label above input
	-- -------------------------------------------------------------------------
	local label = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("TOP", container, "TOP", 0, 0)
	label:SetText(labelText)
	label:SetTextColor(1, 1, 1)

	-- -------------------------------------------------------------------------
	-- Input box setup
	-- -------------------------------------------------------------------------
	local input = CreateFrame("EditBox", nil, container)
	input:SetSize(width, height)
	input:SetPoint("TOP", label, "BOTTOM", 0, -5)
	input:SetAutoFocus(false)
	input:SetMaxLetters(4)
	input:SetNumeric(true)

	input.bg = input:CreateTexture(nil, "BACKGROUND")
	input.bg:SetAllPoints()
	input.bg:SetColorTexture(0.153, 0.187, 0.247)

	input.border = CreateFrame("Frame", nil, input)
	input.border:SetAllPoints()
	CreateUIElementBorders(input, input.border)

	input:SetFont("Fonts\\FRIZQT__.TTF", 12, "")
	input:SetTextInsets(5, 0, 0, 0)
	input:SetTextColor(1, 1, 1)
	input:SetText(tostring(defaultValue))

	-- -------------------------------------------------------------------------
	-- Input box event handlers
	-- -------------------------------------------------------------------------
	input:SetScript("OnEnterPressed", function(self)
		local value = tonumber(self:GetText()) or defaultValue
		if value < minVal then
			value = minVal
			print("|cFFFF0000SmartGarbageCollector:|r Minimum delay is " .. minVal .. " seconds")
		end
		if value > maxVal then value = maxVal end
		self:SetText(tostring(value))
		self:ClearFocus()
		if self.OnValueChanged then
			self:OnValueChanged(value)
		end
	end)

	input:SetScript("OnEscapePressed", function(self)
		self:ClearFocus()
	end)

	input:SetScript("OnEnter", function(self)
		if self.tooltipText then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

			-- Use the stored color if available, otherwise default to white
			if self.tooltipTitleColor then
				GameTooltip:SetText(self.tooltipTitle or "",
					self.tooltipTitleColor[1],
					self.tooltipTitleColor[2],
					self.tooltipTitleColor[3],
					self.tooltipTitleColor[4],
					true)
			else
				GameTooltip:SetText(self.tooltipTitle or "", 1, 1, 1, 1, true)
			end

			GameTooltip:AddLine(self.tooltipText, 1, 1, 1, 1, true)
			GameTooltip:Show()
		end
	end)

	input:SetScript("OnLeave", function(self)
		if self.tooltipText then
			GameTooltip:Hide()
		end
	end)

	return container, input
end

local function CreateModernCheckbox(parent, width, height, labelText)
	local container = CreateFrame("Frame", nil, parent)
	container:SetSize(width, height)

	-- -------------------------------------------------------------------------
	-- Checkbox button setup
	-- -------------------------------------------------------------------------
	local checkbox = CreateFrame("CheckButton", nil, container)
	checkbox:SetSize(20, 20)
	checkbox:SetPoint("LEFT", container, "LEFT", 0, 0)

	-- Checkbox background
	checkbox.bg = checkbox:CreateTexture(nil, "BACKGROUND")
	checkbox.bg:SetAllPoints()
	checkbox.bg:SetColorTexture(0.153, 0.187, 0.247)

	-- Checkbox border
	checkbox.border = CreateFrame("Frame", nil, checkbox)
	checkbox.border:SetAllPoints()
	CreateUIElementBorders(checkbox, checkbox.border)

	-- Check mark texture
	checkbox.check = checkbox:CreateTexture(nil, "OVERLAY")
	checkbox.check:SetSize(14, 14)
	checkbox.check:SetPoint("CENTER")
	checkbox.check:SetColorTexture(0.35, 0.57, 0.75, 1)
	checkbox.check:Hide()

	-- -------------------------------------------------------------------------
	-- Label text
	-- -------------------------------------------------------------------------
	checkbox.label = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	checkbox.label:SetPoint("LEFT", checkbox, "RIGHT", 8, 0)
	checkbox.label:SetText(labelText)
	checkbox.label:SetTextColor(1, 1, 1)

	-- -------------------------------------------------------------------------
	-- Hover effects and click handler
	-- -------------------------------------------------------------------------
	checkbox:SetScript("OnEnter", function(self)
		self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
	end)

	checkbox:SetScript("OnLeave", function(self)
		self.bg:SetColorTexture(0.153, 0.187, 0.247)
	end)

	-- Click handler
	checkbox:SetScript("OnClick", function(self)
		if self:GetChecked() then
			self.check:Show()
		else
			self.check:Hide()
		end
		if self.OnValueChanged then
			self:OnValueChanged(self:GetChecked())
		end
	end)

	container.checkbox = checkbox
	return container
end

-- =============================================================================
-- UI CREATION
-- =============================================================================

local function CreateUI()
	if mainFrame then return end

	-- -------------------------------------------------------------------------
	-- Create main frame
	-- -------------------------------------------------------------------------
	mainFrame = CreateFrame("Frame", "SmartGarbageCollectorFrame", UIParent)
	mainFrame:SetSize(300, 580)
	mainFrame:SetPoint("CENTER")
	mainFrame:SetFrameStrata("DIALOG")
	mainFrame:SetFrameLevel(10)
	mainFrame:SetMovable(true)
	mainFrame:EnableMouse(true)
	mainFrame:RegisterForDrag("LeftButton")
	mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
	mainFrame:SetScript("OnDragStop", mainFrame.StopMovingOrSizing)
	mainFrame:Hide()

	-- Modern dark background
	mainFrame.bg = mainFrame:CreateTexture(nil, "BACKGROUND")
	mainFrame.bg:SetAllPoints()
	mainFrame.bg:SetColorTexture(0.153, 0.188, 0.247)

	-- Modern border
	mainFrame.border = CreateFrame("Frame", nil, mainFrame)
	mainFrame.border:SetAllPoints()
	CreateUIElementBorders(mainFrame, mainFrame.border)

	-- -------------------------------------------------------------------------
	-- Close button (X)
	-- -------------------------------------------------------------------------
	mainFrame.closeButton = CreateFrame("Button", nil, mainFrame)
	mainFrame.closeButton:SetSize(24, 24)
	mainFrame.closeButton:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -5, -5)

	-- Add background and border to close button
	mainFrame.closeButton.bg = mainFrame.closeButton:CreateTexture(nil, "BACKGROUND")
	mainFrame.closeButton.bg:SetAllPoints()
	mainFrame.closeButton.bg:SetColorTexture(0.153, 0.188, 0.247)

	mainFrame.closeButton.border = CreateFrame("Frame", nil, mainFrame.closeButton)
	mainFrame.closeButton.border:SetAllPoints()
	CreateUIElementBorders(mainFrame.closeButton, mainFrame.closeButton.border)

	mainFrame.closeButton:SetText("X")
	mainFrame.closeButton:SetNormalFontObject("GameFontNormal")
	mainFrame.closeButton:GetFontString():SetTextColor(1, 1, 1)

	mainFrame.closeButton:SetScript("OnClick", function() mainFrame:Hide() end)
	mainFrame.closeButton:SetScript("OnEnter", function(self)
		self:GetFontString():SetTextColor(1, 1, 1)
		self.bg:SetColorTexture(0.20, 0.39, 0.55, 1.0)
	end)
	mainFrame.closeButton:SetScript("OnLeave", function(self)
		self:GetFontString():SetTextColor(1, 1, 1)
		self.bg:SetColorTexture(0.153, 0.188, 0.247)
	end)

	-- -------------------------------------------------------------------------
	-- Title
	-- -------------------------------------------------------------------------
	mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
	mainFrame.title:SetPoint("TOP", mainFrame, "TOP", 0, -10)
	mainFrame.title:SetText("Smart Garbage Collector")
	mainFrame.title:SetTextColor(0.638, 0.825, 0.957)

	-- -------------------------------------------------------------------------
	-- Manual run button
	-- -------------------------------------------------------------------------
	mainFrame.runButton = CreateModernButton(mainFrame, 104, 25, "Run Now")
	mainFrame.runButton:SetPoint("TOP", mainFrame, "TOP", 0, -50)
	mainFrame.runButton:SetScript("OnClick", function()
		DoGarbageCollection("manual")
	end)

	-- -------------------------------------------------------------------------
	-- Auto Clean Enable/Disable button
	-- -------------------------------------------------------------------------
	mainFrame.enableButton = CreateModernButton(mainFrame, 104, 25, "Auto Clean")
	mainFrame.enableButton:SetPoint("TOP", mainFrame.runButton, "BOTTOM", 0, -8)
	mainFrame.enableButton.isToggle = true
	mainFrame.enableButton.isEnabled = false

	local function UpdateEnableButtonVisual()
		if mainFrame.enableButton.isEnabled then
			mainFrame.enableButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.enableButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.enableButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end

		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText("Auto Clean", 0.275, 0.51, 0.706, 1, false)
		GameTooltip:AddLine("When enabled, SGC automatically runs garbage collection at the specified frequency set below.", 1, 1, 1, 1, true)
		GameTooltip:Show()
	end)

	mainFrame.enableButton:SetScript("OnLeave", function(self)
		UpdateEnableButtonVisual()
		GameTooltip:Hide()
	end)

	mainFrame.enableButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.enabled = not SmartGarbageCollectorDB.enabled
		self.isEnabled = SmartGarbageCollectorDB.enabled
		UpdateEnableButtonVisual()
		if SmartGarbageCollectorDB.enabled then
			SmartGarbageCollector.StartAutoTimer()
			print(string.format("|cFFAAD2FFSGC:|r Auto clean will run every %d seconds", SmartGarbageCollectorDB.autoDelay))
		else
			SmartGarbageCollector.StopAutoTimer()
			print("|cFFAAD2FFSGC:|r Auto collection disabled")
		end
	end)

	UpdateEnableButtonVisual()

	-- -------------------------------------------------------------------------
	-- Auto Clean Frequency section
	-- -------------------------------------------------------------------------
	mainFrame.delayLabel = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	mainFrame.delayLabel:SetPoint("TOP", mainFrame.enableButton, "BOTTOM", 0, -10)
	mainFrame.delayLabel:SetText("Auto Clean Frequency")
	mainFrame.delayLabel:SetTextColor(0.638, 0.825, 0.957)

	-- Minimum delay subtext
	mainFrame.delaySubtext = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	mainFrame.delaySubtext:SetPoint("TOP", mainFrame.delayLabel, "BOTTOM", 0, -3)
	mainFrame.delaySubtext:SetText("Default 40s")
	mainFrame.delaySubtext:SetTextColor(0.638, 0.825, 0.957)

	-- Auto delay input box
	local delayContainer, delayInput = CreateModernInputBox(mainFrame, 70, 25, "", SmartGarbageCollectorDB.autoDelay, 30, 180)
	delayContainer:SetPoint("TOP", mainFrame.delaySubtext, "BOTTOM", 0, -0)
	mainFrame.delayInput = delayInput
	delayInput.OnValueChanged = function(self, value)
		SmartGarbageCollectorDB.autoDelay = value
		SmartGarbageCollector.StartAutoTimer()
		print("|cFFAAD2FFSGC:|r Auto delay set to " .. value .. " seconds")
	end

	-- Auto delay input box tooltip
	delayInput.tooltipTitle = "Auto Clean Frequency"
	delayInput.tooltipTitleColor = {0.275, 0.51, 0.706, 1.0}
	delayInput.tooltipText = "How often automatic clean-ups run\n\nRange (30-180 seconds)\n\nRecommended values 40-60 seconds"

	-- -------------------------------------------------------------------------
	-- Auto Step Size button
	-- -------------------------------------------------------------------------
	mainFrame.autoAdjustButton = CreateModernButton(mainFrame, 104, 25, "Auto Step Size", "Automatically increase step size when inefficient clean-ups are detected")
	mainFrame.autoAdjustButton:SetPoint("TOP", delayContainer, "BOTTOM", 0, 5)
	mainFrame.autoAdjustButton.isToggle = true
	mainFrame.autoAdjustButton.isEnabled = true

	local function UpdateAutoAdjustButtonVisual()
		if mainFrame.autoAdjustButton.isEnabled then
			mainFrame.autoAdjustButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.autoAdjustButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.autoAdjustButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end

		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText("Auto Step Size", 0.275, 0.51, 0.706, 1, false)
		GameTooltip:AddLine("When enabled, automatically increases step size by 32 after 2 consecutive inefficient clean-ups.\n\n", 1, 1, 1, 1, true)
		GameTooltip:AddLine("Auto Step Size is recommended over Manual Step Size", 0.275, 0.51, 0.706, true)
		GameTooltip:Show()
	end)

	mainFrame.autoAdjustButton:SetScript("OnLeave", function(self)
		UpdateAutoAdjustButtonVisual()
		GameTooltip:Hide()
	end)

	mainFrame.autoAdjustButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.autoAdjustStepSize = not SmartGarbageCollectorDB.autoAdjustStepSize
		self.isEnabled = SmartGarbageCollectorDB.autoAdjustStepSize
		UpdateAutoAdjustButtonVisual()

		if SmartGarbageCollectorDB.autoAdjustStepSize then
			-- Reset to 64 when enabling auto-adjust mid-session
			SmartGarbageCollectorDB.stepSize = 64
			if mainFrame.stepSizeInput then
				mainFrame.stepSizeInput:SetText("64")
			end
			print("|cFFAAD2FFSGC:|r Auto step size enabled - reset to 64")
		else
			-- Restore manual preference when disabling auto-adjust
			SmartGarbageCollectorDB.stepSize = SmartGarbageCollectorDB.manualStepSize
			if mainFrame.stepSizeInput then
				mainFrame.stepSizeInput:SetText(tostring(SmartGarbageCollectorDB.manualStepSize))
			end
			print("|cFFAAD2FFSGC:|r Auto step size disabled")
		end
	end)

	UpdateAutoAdjustButtonVisual()

	-- -------------------------------------------------------------------------
	-- Manual Step Size section
	-- -------------------------------------------------------------------------
	mainFrame.stepSizeLabel = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	mainFrame.stepSizeLabel:SetPoint("TOP", mainFrame.autoAdjustButton, "BOTTOM", 0, -8)
	mainFrame.stepSizeLabel:SetText("Manual Step Size")
	mainFrame.stepSizeLabel:SetTextColor(0.638, 0.825, 0.957, 1.0)

	-- Manual Step Size subtext
	mainFrame.stepSizeSubtext = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	mainFrame.stepSizeSubtext:SetPoint("TOP", mainFrame.stepSizeLabel, "BOTTOM", 0, -2)
	mainFrame.stepSizeSubtext:SetText("Range: 64 - 512")
	mainFrame.stepSizeSubtext:SetTextColor(0.638, 0.825, 0.957, 1.0)

	-- Manual Step Size input box
	local stepSizeContainer, stepSizeInput = CreateModernInputBox(mainFrame, 70, 25, "", SmartGarbageCollectorDB.stepSize, 64, 512)
	stepSizeContainer:SetPoint("TOP", mainFrame.stepSizeSubtext, "BOTTOM", 0, -2)
	mainFrame.stepSizeInput = stepSizeInput
	stepSizeInput.OnValueChanged = function(self, value)
		SmartGarbageCollectorDB.stepSize = value
		SmartGarbageCollectorDB.manualStepSize = value	-- Save as manual preference
		print("|cFFAAD2FFSGC:|r Step size set to " .. value)
	end

	-- Manual Step Size input box tooltip
	stepSizeInput.tooltipTitle = "Manual Step Size"
	stepSizeInput.tooltipTitleColor = {0.275, 0.51, 0.706, 1.0}
	stepSizeInput.tooltipText = "Increase by increments of 32-64 if you see repeated inefficient clean-up warnings in chat\n\n|cFF4682B4You don't need to change this value if Auto Step Size is enabled!|r"

	-- -------------------------------------------------------------------------
	-- Instance Disable Section
	-- -------------------------------------------------------------------------
	mainFrame.instanceHeader = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	mainFrame.instanceHeader:SetPoint("TOP", stepSizeContainer, "BOTTOM", 0, 2)
	mainFrame.instanceHeader:SetText("Enable Auto Clean For")
	mainFrame.instanceHeader:SetTextColor(0.638, 0.825, 0.957)

	-- Dungeon button
	mainFrame.dungeonButton = CreateModernButton(mainFrame, 104, 25, "Dungeons")
	mainFrame.dungeonButton:SetPoint("TOP", mainFrame.instanceHeader, "BOTTOM", -54, -8)
	mainFrame.dungeonButton.isEnabled = not SmartGarbageCollectorDB.disableInDungeon

	local function UpdateDungeonButtonVisual()
		if mainFrame.dungeonButton.isEnabled then
			mainFrame.dungeonButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.dungeonButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.dungeonButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end
	end)

	mainFrame.dungeonButton:SetScript("OnLeave", function(self)
		UpdateDungeonButtonVisual()
	end)

	mainFrame.dungeonButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.disableInDungeon = not SmartGarbageCollectorDB.disableInDungeon
		self.isEnabled = not SmartGarbageCollectorDB.disableInDungeon
		UpdateDungeonButtonVisual()
		print("|cFFAAD2FFSGC:|r Auto clean in dungeons: " .. (SmartGarbageCollectorDB.disableInDungeon and "Disabled" or "Enabled"))
	end)

	UpdateDungeonButtonVisual()

	-- Raid button
	mainFrame.raidButton = CreateModernButton(mainFrame, 104, 25, "Raids")
	mainFrame.raidButton:SetPoint("TOP", mainFrame.instanceHeader, "BOTTOM", 54, -8)
	mainFrame.raidButton.isEnabled = not SmartGarbageCollectorDB.disableInRaid

	local function UpdateRaidButtonVisual()
		if mainFrame.raidButton.isEnabled then
			mainFrame.raidButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.raidButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.raidButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end
	end)

	mainFrame.raidButton:SetScript("OnLeave", function(self)
		UpdateRaidButtonVisual()
	end)

	mainFrame.raidButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.disableInRaid = not SmartGarbageCollectorDB.disableInRaid
		self.isEnabled = not SmartGarbageCollectorDB.disableInRaid
		UpdateRaidButtonVisual()
		print("|cFFAAD2FFSGC:|r Auto clean in raids: " .. (SmartGarbageCollectorDB.disableInRaid and "Disabled" or "Enabled"))
	end)

	UpdateRaidButtonVisual()

	-- PVP button
	mainFrame.pvpButton = CreateModernButton(mainFrame, 104, 25, "PVP Instances")
	mainFrame.pvpButton:SetPoint("TOP", mainFrame.dungeonButton, "BOTTOM", 0, -8)
	mainFrame.pvpButton.isEnabled = not SmartGarbageCollectorDB.disableInPVP

	local function UpdatePVPButtonVisual()
		if mainFrame.pvpButton.isEnabled then
			mainFrame.pvpButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.pvpButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.pvpButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end
	end)

	mainFrame.pvpButton:SetScript("OnLeave", function(self)
		UpdatePVPButtonVisual()
	end)

	mainFrame.pvpButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.disableInPVP = not SmartGarbageCollectorDB.disableInPVP
		self.isEnabled = not SmartGarbageCollectorDB.disableInPVP
		UpdatePVPButtonVisual()
		print("|cFFAAD2FFSGC:|r Auto clean in PVP: " .. (SmartGarbageCollectorDB.disableInPVP and "Disabled" or "Enabled"))
	end)

	UpdatePVPButtonVisual()

	-- Scenario button
	mainFrame.scenarioButton = CreateModernButton(mainFrame, 104, 25, "Scenarios")
	mainFrame.scenarioButton:SetPoint("TOP", mainFrame.raidButton, "BOTTOM", 0, -8)
	mainFrame.scenarioButton.isEnabled = not SmartGarbageCollectorDB.disableInScenario

	local function UpdateScenarioButtonVisual()
		if mainFrame.scenarioButton.isEnabled then
			mainFrame.scenarioButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.scenarioButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.scenarioButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end
	end)

	mainFrame.scenarioButton:SetScript("OnLeave", function(self)
		UpdateScenarioButtonVisual()
	end)

	mainFrame.scenarioButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.disableInScenario = not SmartGarbageCollectorDB.disableInScenario
		self.isEnabled = not SmartGarbageCollectorDB.disableInScenario
		UpdateScenarioButtonVisual()
		print("|cFFAAD2FFSGC:|r Auto clean in scenarios: " .. (SmartGarbageCollectorDB.disableInScenario and "Disabled" or "Enabled"))
	end)

	UpdateScenarioButtonVisual()

	-- -------------------------------------------------------------------------
	-- GC Protection Section
	-- -------------------------------------------------------------------------
	mainFrame.protectionHeader = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	mainFrame.protectionHeader:SetPoint("TOP", mainFrame.instanceHeader, "BOTTOM", 0, -80)
	mainFrame.protectionHeader:SetText("Garbage Protector")
	mainFrame.protectionHeader:SetTextColor(0.638, 0.825, 0.957)

	-- Block External GC toggle button
	mainFrame.blockGCButton = CreateModernButton(mainFrame, 104, 25, "Block Add-ons", "Block other add-ons from calling garbage collection")
	mainFrame.blockGCButton:SetPoint("TOP", mainFrame.pvpButton, "BOTTOM", 0, -35)
	mainFrame.blockGCButton.isToggle = true
	mainFrame.blockGCButton.isEnabled = false

	local function UpdateBlockGCButtonVisual()
		if mainFrame.blockGCButton.isEnabled then
			mainFrame.blockGCButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.blockGCButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.blockGCButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end

		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText("Block Add-ons", 0.275, 0.51, 0.706, 1, false)
		GameTooltip:AddLine("Prevents other add-ons from calling garbage collection.\n\nSmartGarbageCollector will still be allowed to perform its controlled GC.\n\nThis blocks badly-behaved add-ons that cause frame drops.", 1, 1, 1, 1, true)
		GameTooltip:Show()
	end)

	mainFrame.blockGCButton:SetScript("OnLeave", function(self)
		UpdateBlockGCButtonVisual()
		GameTooltip:Hide()
	end)

	mainFrame.blockGCButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.blockExternalGC = not SmartGarbageCollectorDB.blockExternalGC
		self.isEnabled = SmartGarbageCollectorDB.blockExternalGC
		UpdateBlockGCButtonVisual()
		if SmartGarbageCollectorDB.blockExternalGC then
			print("|cFFAAD2FFSGC:|r Add-on GC blocking enabled - add-ons blocked")
		else
			print("|cFFAAD2FFSGC:|r Add-on GC blocking disabled - add-ons allowed")
		end
	end)

	UpdateBlockGCButtonVisual()

	-- Block Memory Updates toggle button
	mainFrame.blockMemoryButton = CreateModernButton(mainFrame, 104, 25, "Block Memory", "Block UpdateAddOnMemoryUsage calls")
	mainFrame.blockMemoryButton:SetPoint("TOP", mainFrame.scenarioButton, "BOTTOM", 0, -35)
	mainFrame.blockMemoryButton.isToggle = true
	mainFrame.blockMemoryButton.isEnabled = false

	local function UpdateBlockMemoryButtonVisual()
		if mainFrame.blockMemoryButton.isEnabled then
			mainFrame.blockMemoryButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.blockMemoryButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.blockMemoryButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end

		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText("Block Memory", 0.275, 0.51, 0.706, 1, false)
		GameTooltip:AddLine("Blocks UpdateAddOnMemoryUsage calls from other add-ons.\n\nThis saves CPU cycles as memory updates are expensive.\n\nWarning: Add-on memory usage will show as 0 in the add-on list when enabled.\n\n", 1, 1, 1, 1, true)
		GameTooltip:AddLine("This option requires a /reload to take effect!", 0.275, 0.51, 0.706, true)
		GameTooltip:Show()
	end)

	mainFrame.blockMemoryButton:SetScript("OnLeave", function(self)
		UpdateBlockMemoryButtonVisual()
		GameTooltip:Hide()
	end)

	mainFrame.blockMemoryButton:SetScript("OnClick", function(self)
		-- Toggle the setting
		local newValue = not SmartGarbageCollectorDB.blockMemoryUpdates
		SmartGarbageCollectorDB.blockMemoryUpdates = newValue

		-- Update visual immediately for feedback
		self.isEnabled = newValue
		UpdateBlockMemoryButtonVisual()

		local statusMsg = newValue and
			"Memory blocking enabled - reloading UI..." or
			"Memory blocking disabled - reloading UI..."
		print("|cFFAAD2FFSGC:|r " .. statusMsg)

		-- Show reload dialog with clear messaging
		ShowReloadDialog(
			"Reload Required",
			"Memory blocking changes require a UI reload\nto take effect properly.\n\nReloading now...",
			nil
		)
	end)

	UpdateBlockMemoryButtonVisual()

	-- -------------------------------------------------------------------------
	-- Chat Options Section
	-- -------------------------------------------------------------------------
	mainFrame.chatHeader = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	mainFrame.chatHeader:SetPoint("TOP", mainFrame.protectionHeader, "BOTTOM", 0, -50)
	mainFrame.chatHeader:SetText("Chat Options")
	mainFrame.chatHeader:SetTextColor(0.638, 0.825, 0.957)

	-- Chat Print toggle button
	mainFrame.hideChatButton = CreateModernButton(mainFrame, 104, 25, "Amount Cleaned", "|cFFAAD2FFDisable chat print for Auto Clean|r")
	mainFrame.hideChatButton:SetPoint("TOP", mainFrame.blockGCButton, "BOTTOM", 0, -35)
	mainFrame.hideChatButton.isToggle = true
	mainFrame.hideChatButton.isEnabled = true

	local function UpdateChatButtonVisual()
		if mainFrame.hideChatButton.isEnabled then
			mainFrame.hideChatButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.hideChatButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.hideChatButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end

		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText("Amount Cleaned", 0.275, 0.51, 0.706, 1, false)
		GameTooltip:AddLine("Disable this if you don't want to see how much garbage has been cleaned-up in chat", 1, 1, 1, 1, true)
		GameTooltip:Show()
	end)

	mainFrame.hideChatButton:SetScript("OnLeave", function(self)
		UpdateChatButtonVisual()
		GameTooltip:Hide()
	end)

	mainFrame.hideChatButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.hideAutoChatPrint = not SmartGarbageCollectorDB.hideAutoChatPrint
		self.isEnabled = not SmartGarbageCollectorDB.hideAutoChatPrint
		UpdateChatButtonVisual()
		if SmartGarbageCollectorDB.hideAutoChatPrint then
			print("|cFFAAD2FFSGC:|r Auto clean-up chat messages hidden")
		else
			print("|cFFAAD2FFSGC:|r Auto clean-up chat messages enabled")
		end
	end)

	UpdateChatButtonVisual()

	-- Critical Warnings toggle button
	mainFrame.criticalWarningsButton = CreateModernButton(mainFrame, 104, 25, "Critical Warnings", "Only disable if getting repeated warnings despite step size set to 512")
	mainFrame.criticalWarningsButton:SetPoint("TOP", mainFrame.blockMemoryButton, "BOTTOM", 0, -35)
	mainFrame.criticalWarningsButton.isToggle = true
	mainFrame.criticalWarningsButton.isEnabled = true

	local function UpdateCriticalWarningsButtonVisual()
		if mainFrame.criticalWarningsButton.isEnabled then
			mainFrame.criticalWarningsButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.criticalWarningsButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.criticalWarningsButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end

		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText("Critical Warnings", 0.275, 0.51, 0.706, 1, false)
		GameTooltip:AddLine("Disabling this is NOT recommended.\n\nOnly disable if you are getting repeated inefficient clean-up warnings in chat, even after changing the step size to the maximum of 512", 1, 1, 1, 1, true)
		GameTooltip:Show()
	end)

	mainFrame.criticalWarningsButton:SetScript("OnLeave", function(self)
		UpdateCriticalWarningsButtonVisual()
		GameTooltip:Hide()
	end)

	mainFrame.criticalWarningsButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.showCriticalWarnings = not SmartGarbageCollectorDB.showCriticalWarnings
		self.isEnabled = SmartGarbageCollectorDB.showCriticalWarnings
		UpdateCriticalWarningsButtonVisual()
		if SmartGarbageCollectorDB.showCriticalWarnings then
			print("|cFFAAD2FFSGC:|r Critical warnings enabled")
		else
			print("|cFFFF0000SmartGarbageCollector:|r Critical warnings disabled - not recommended!")
		end
	end)

	UpdateCriticalWarningsButtonVisual()

	-- Show Blocked Add-ons Button (GC blocks)
	mainFrame.showBlockedGCButton = CreateModernButton(mainFrame, 214, 25, "Show Blocked Add-ons", "Display when add-ons are blocked from GC")
	mainFrame.showBlockedGCButton:SetPoint("TOP", mainFrame.criticalWarningsButton, "BOTTOM", -54, -10)
	mainFrame.showBlockedGCButton.isToggle = true
	mainFrame.showBlockedGCButton.isEnabled = true

	local function UpdateShowBlockedGCButtonVisual()
		if mainFrame.showBlockedGCButton.isEnabled then
			mainFrame.showBlockedGCButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.showBlockedGCButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.showBlockedGCButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end

		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText("Show Blocked Add-ons", 0.275, 0.51, 0.706, 1, false)
		GameTooltip:AddLine("Display chat messages when other add-ons try to call garbage collection.\n\nShows which add-ons are being blocked from running GC.\n\nBlocked attempts are aggregated over 2 seconds to avoid spam.", 1, 1, 1, 1, true)
		GameTooltip:Show()
	end)

	mainFrame.showBlockedGCButton:SetScript("OnLeave", function(self)
		UpdateShowBlockedGCButtonVisual()
		GameTooltip:Hide()
	end)

	mainFrame.showBlockedGCButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.showBlockedGC = not SmartGarbageCollectorDB.showBlockedGC
		self.isEnabled = SmartGarbageCollectorDB.showBlockedGC
		UpdateShowBlockedGCButtonVisual()
		if SmartGarbageCollectorDB.showBlockedGC then
			print("|cFFAAD2FFSGC:|r Showing Add-on blocked GC attempts")
		else
			print("|cFFAAD2FFSGC:|r Hiding Add-on blocked GC attempts")
		end
	end)

	UpdateShowBlockedGCButtonVisual()

	-- Show Blocked Memory Button
	mainFrame.showBlockedMemoryButton = CreateModernButton(mainFrame, 214, 25, "Show Blocked Memory", "Display when memory updates are blocked")
	mainFrame.showBlockedMemoryButton:SetPoint("TOP", mainFrame.showBlockedGCButton, "BOTTOM", 0, -5)
	mainFrame.showBlockedMemoryButton.isToggle = true
	mainFrame.showBlockedMemoryButton.isEnabled = true

	local function UpdateShowBlockedMemoryButtonVisual()
		if mainFrame.showBlockedMemoryButton.isEnabled then
			mainFrame.showBlockedMemoryButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
		else
			mainFrame.showBlockedMemoryButton.bg:SetColorTexture(0.153, 0.187, 0.247)
		end
	end

	mainFrame.showBlockedMemoryButton:SetScript("OnEnter", function(self)
		if self.isEnabled then
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		else
			self.bg:SetColorTexture(0.20, 0.39, 0.55, 0.9)
		end

		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText("Show Blocked Memory", 0.275, 0.51, 0.706, 1, false)
		GameTooltip:AddLine("Display chat messages when other add-ons try to update memory usage.\n\nShows which add-ons are being blocked from calling UpdateAddOnMemoryUsage.\n\nBlocked attempts are aggregated over 2 seconds to avoid spam.", 1, 1, 1, 1, true)
		GameTooltip:Show()
	end)

	mainFrame.showBlockedMemoryButton:SetScript("OnLeave", function(self)
		UpdateShowBlockedMemoryButtonVisual()
		GameTooltip:Hide()
	end)

	mainFrame.showBlockedMemoryButton:SetScript("OnClick", function(self)
		SmartGarbageCollectorDB.showBlockedMemory = not SmartGarbageCollectorDB.showBlockedMemory
		self.isEnabled = SmartGarbageCollectorDB.showBlockedMemory
		UpdateShowBlockedMemoryButtonVisual()
		if SmartGarbageCollectorDB.showBlockedMemory then
			print("|cFFAAD2FFSGC:|r Showing blocked memory update attempts")
		else
			print("|cFFAAD2FFSGC:|r Hiding blocked memory update attempts")
		end
	end)

	UpdateShowBlockedMemoryButtonVisual()
end

-- =============================================================================
-- UI UPDATE FUNCTION
-- =============================================================================

local function UpdateUI()
	if not mainFrame then return end

	-- Update UI state
	mainFrame.enableButton.isEnabled = SmartGarbageCollectorDB.enabled
	if SmartGarbageCollectorDB.enabled then
		mainFrame.enableButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.enableButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	-- Update button visuals
	if mainFrame.enableButton.isEnabled then
		mainFrame.enableButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.enableButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	if mainFrame.hideChatButton.isEnabled then
		mainFrame.hideChatButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.hideChatButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	mainFrame.dungeonButton.isEnabled = not SmartGarbageCollectorDB.disableInDungeon
	if mainFrame.dungeonButton.isEnabled then
		mainFrame.dungeonButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.dungeonButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	mainFrame.raidButton.isEnabled = not SmartGarbageCollectorDB.disableInRaid
	if mainFrame.raidButton.isEnabled then
		mainFrame.raidButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.raidButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	mainFrame.pvpButton.isEnabled = not SmartGarbageCollectorDB.disableInPVP
	if mainFrame.pvpButton.isEnabled then
		mainFrame.pvpButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.pvpButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	mainFrame.scenarioButton.isEnabled = not SmartGarbageCollectorDB.disableInScenario
	if mainFrame.scenarioButton.isEnabled then
		mainFrame.scenarioButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.scenarioButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	-- Update Hide Chat button state
	mainFrame.hideChatButton.isEnabled = not SmartGarbageCollectorDB.hideAutoChatPrint
	if SmartGarbageCollectorDB.hideAutoChatPrint then
		mainFrame.hideChatButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	else
		mainFrame.hideChatButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	end

	-- Update Critical Warnings button state
	mainFrame.criticalWarningsButton.isEnabled = SmartGarbageCollectorDB.showCriticalWarnings
	if SmartGarbageCollectorDB.showCriticalWarnings then
		mainFrame.criticalWarningsButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.criticalWarningsButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	-- Update Auto-Adjust button state
	mainFrame.autoAdjustButton.isEnabled = SmartGarbageCollectorDB.autoAdjustStepSize
	if SmartGarbageCollectorDB.autoAdjustStepSize then
		mainFrame.autoAdjustButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.autoAdjustButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	-- Update Block External GC button state
	mainFrame.blockGCButton.isEnabled = SmartGarbageCollectorDB.blockExternalGC
	if SmartGarbageCollectorDB.blockExternalGC then
		mainFrame.blockGCButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.blockGCButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	-- Update Block Memory Updates button state
	mainFrame.blockMemoryButton.isEnabled = SmartGarbageCollectorDB.blockMemoryUpdates
	if SmartGarbageCollectorDB.blockMemoryUpdates then
		mainFrame.blockMemoryButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.blockMemoryButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	-- Update Show Blocked GC button state
	if SmartGarbageCollectorDB.showBlockedGC == nil then
		SmartGarbageCollectorDB.showBlockedGC = true
	end
	mainFrame.showBlockedGCButton.isEnabled = SmartGarbageCollectorDB.showBlockedGC
	if SmartGarbageCollectorDB.showBlockedGC then
		mainFrame.showBlockedGCButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.showBlockedGCButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	-- Update Show Blocked Memory button state
	if SmartGarbageCollectorDB.showBlockedMemory == nil then
		SmartGarbageCollectorDB.showBlockedMemory = true
	end
	mainFrame.showBlockedMemoryButton.isEnabled = SmartGarbageCollectorDB.showBlockedMemory
	if SmartGarbageCollectorDB.showBlockedMemory then
		mainFrame.showBlockedMemoryButton.bg:SetColorTexture(0.15, 0.29, 0.41, 0.9)
	else
		mainFrame.showBlockedMemoryButton.bg:SetColorTexture(0.153, 0.187, 0.247)
	end

	mainFrame.delayInput:SetText(tostring(SmartGarbageCollectorDB.autoDelay))
	mainFrame.stepSizeInput:SetText(tostring(SmartGarbageCollectorDB.stepSize))
end

-- =============================================================================
-- TOGGLE UI FUNCTION
-- =============================================================================

function SmartGarbageCollectorUI.ToggleUI()
	CreateUI()
	if mainFrame:IsShown() then
		mainFrame:Hide()
	else
		UpdateUI()
		mainFrame:Show()
	end
end

-- =============================================================================
-- EXPOSE PUBLIC API
-- =============================================================================

_G.SmartGarbageCollectorUI = SmartGarbageCollectorUI
