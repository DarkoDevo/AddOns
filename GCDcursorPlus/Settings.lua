local addonName = "GCDCursorPlus"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local SettingsLib = LibStub("LibGCDCPSettingsMode-1.0")

-- CRITICAL: Prevent this file from running multiple times
if addon.settingsFileLoaded then
	return
end
addon.settingsFileLoaded = true

-- Create settings on PLAYER_LOGIN (only once)
local function InitializeSettings()
	-- CRITICAL: Check if already initialized - prevent ALL duplicate UI creation
	if addon.settingsCategory then
		return
	end

	-- CRITICAL: Ensure database exists before creating settings
	if not _G.GCDCursorPlusDB or type(_G.GCDCursorPlusDB) ~= "table" then
		print("|cff00ff98GCD Cursor Plus|r: |cffff0000ERROR:|r Database not initialized! Cannot create settings.")
		return
	end

	-- Create settings category
	local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)
	Settings.RegisterAddOnCategory(category)
	addon.settingsCategory = category

	-- Cache for registered settings to prevent duplicates
	local registeredSettings = {}

	-- Helper function to create checkbox
	local function CreateCheckbox(variable, name, tooltip, parent)
		-- Check if setting already registered
		if not registeredSettings[variable] then
			-- Get current value from database
			local currentValue = _G.GCDCursorPlusDB[variable]
			if currentValue == nil then
				currentValue = false
			end

			-- Must use _G to get the actual global table, not addon.db reference
			registeredSettings[variable] = Settings.RegisterAddOnSetting(category, variable, variable, _G.GCDCursorPlusDB, Settings.VarType.Boolean, name, currentValue)

			-- Add callback to persist changes
			registeredSettings[variable]:SetValueChangedCallback(function(setting, value)
				-- The Settings API should auto-save to the table, but let's be explicit
				_G.GCDCursorPlusDB[variable] = value
				addon.RefreshAll()
			end)
		end
		local setting = registeredSettings[variable]
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
		if parent then
			initializer:SetParentInitializer(parent)
		end
		-- NOTE: Settings.CreateCheckbox already adds the initializer to the category
		-- layout:AddInitializer(initializer)
		return setting, initializer
	end

	-- Helper function to create slider
	local function CreateSlider(variable, name, tooltip, minValue, maxValue, step, parent)
		-- Check if setting already registered
		if not registeredSettings[variable] then
			local defaultVal = _G.GCDCursorPlusDB[variable]
			if defaultVal == nil then defaultVal = minValue end
			-- Must use _G to get the actual global table, not addon.db reference
			registeredSettings[variable] = Settings.RegisterAddOnSetting(category, variable, variable, _G.GCDCursorPlusDB, Settings.VarType.Number, name, defaultVal)
			-- Add callback to persist changes
			registeredSettings[variable]:SetValueChangedCallback(function(setting, value)
				_G.GCDCursorPlusDB[variable] = value
				addon.db[variable] = value
				addon.RefreshAll()
			end)
		end
		local setting = registeredSettings[variable]
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value)
			return string.format("%.0f", value)
		end)
		local initializer = Settings.CreateSlider(category, setting, options, tooltip)
		if parent then
			initializer:SetParentInitializer(parent)
		end
		-- NOTE: Settings.CreateSlider already adds the initializer to the category
		-- layout:AddInitializer(initializer)
		return setting, initializer
	end

	-- Helper function to create color picker with swatch (using LibGCDCP)
	local function CreateColorPicker(variable, name, tooltip, parent)
		local initializer = SettingsLib:CreateColorOverrides(category, {
			key = variable,
			headerText = name,
			entries = { { key = variable, label = name, tooltip = tooltip } },
			getColor = function(key)
				local c = _G.GCDCursorPlusDB[variable]
				if c then
					return c.r or 1, c.g or 1, c.b or 1, c.a or 1
				end
				return 1, 1, 1, 1
			end,
			setColor = function(key, r, g, b, a)
				_G.GCDCursorPlusDB[variable] = { r = r, g = g, b = b, a = a }
				addon.db[variable] = { r = r, g = g, b = b, a = a }
				addon.RefreshAll()
			end,
			getDefaultColor = function()
				return 1, 1, 1, 1
			end,
			parent = parent,
			hasOpacity = true,
		})

		-- NOTE: SettingsLib:CreateColorOverrides already registers the initializer
		-- layout:AddInitializer(initializer)
		return initializer
	end

	-- Helper function to create dropdown
	local function CreateDropdown(variable, name, tooltip, options, parent)
		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			for key, label in pairs(options) do
				container:Add(key, label)
			end
			return container:GetData()
		end

		-- Check if setting already registered
		if not registeredSettings[variable] then
			-- Must use _G to get the actual global table, not addon.db reference
			registeredSettings[variable] = Settings.RegisterAddOnSetting(category, variable, variable, _G.GCDCursorPlusDB, Settings.VarType.Number, name, 1)
			-- Add callback to persist changes
			registeredSettings[variable]:SetValueChangedCallback(function(setting, value)
				_G.GCDCursorPlusDB[variable] = value
				addon.db[variable] = value
				addon.RefreshAll()
			end)
		end
		local setting = registeredSettings[variable]
		local initializer = Settings.CreateDropdown(category, setting, GetOptions, tooltip)
		if parent then
			initializer:SetParentInitializer(parent)
		end
		-- NOTE: Settings.CreateDropdown already adds the initializer to the category
		-- layout:AddInitializer(initializer)
		return setting, initializer
	end

	-- Title
	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["GCD Cursor Plus Settings"]))

	-- Mouse Ring Section
	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["Mouse Ring"]))

	local ringSetting, ringEnabled = CreateCheckbox("mouseRingEnabled", L["Enable Mouse Ring"], L["Show a ring around your mouse cursor"])
	CreateSlider("mouseRingSize", L["Ring Size"], L["Size of the mouse ring"], 20, 240, 5, ringEnabled)
	CreateCheckbox("mouseRingUseClassColor", L["Use Class Color"], L["Use your class color for the ring"], ringEnabled)
	CreateColorPicker("mouseRingColor", L["Ring Color"], L["Custom color for the ring"], ringEnabled)
	CreateCheckbox("mouseRingCombatOnly", L["Combat Only"], L["Only show ring in combat"], ringEnabled)
	CreateCheckbox("mouseRingHideDot", L["Hide Center Dot"], L["Hide the center dot in the ring"], ringEnabled)
	CreateCheckbox("mouseRingOnlyOnRightClick", L["Show Only on Right Click"], L["Only show ring when right mouse button is held"], ringEnabled)

	-- Combat Override (nested under Mouse Ring)
	local combatOverrideSetting, combatOverrideEnabled = CreateCheckbox("mouseRingCombatOverride", L["Combat Override"], L["Override ring size and color in combat"], ringEnabled)
	CreateSlider("mouseRingCombatOverrideSize", L["Combat Ring Size"], L["Size of the ring when in combat"], 20, 200, 5, combatOverrideEnabled)
	CreateColorPicker("mouseRingCombatOverrideColor", L["Combat Ring Color"], L["Color of the ring when in combat"], combatOverrideEnabled)

	-- Combat Overlay (nested under Mouse Ring)
	local combatOverlaySetting, combatOverlayEnabled = CreateCheckbox("mouseRingCombatOverlay", L["Combat Overlay"], L["Show an additional ring overlay in combat"], ringEnabled)
	CreateSlider("mouseRingCombatOverlaySize", L["Combat Overlay Size"], L["Size of the combat overlay ring"], 20, 240, 5, combatOverlayEnabled)
	CreateColorPicker("mouseRingCombatOverlayColor", L["Combat Overlay Color"], L["Color of the combat overlay ring"], combatOverlayEnabled)

	-- GCD Ring Section
	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["GCD Ring"]))

	local gcdSetting, gcdEnabled = CreateCheckbox("mouseRingGCDEnabled", L["Enable GCD Ring"], L["Show a ring that tracks your Global Cooldown"])
	CreateSlider("mouseRingGCDSize", L["GCD Ring Size"], L["Size of the GCD ring"], 20, 240, 5, gcdEnabled)
	CreateCheckbox("mouseRingGCDUseClassColor", L["Use Class Color for GCD"], L["Use your class color for the GCD ring"], gcdEnabled)
	CreateColorPicker("mouseRingGCDColor", L["GCD Ring Color"], L["Custom color for the GCD ring"], gcdEnabled)
	CreateCheckbox("mouseRingGCDInverted", L["Inverted GCD Ring"], L["Fill instead of drain"], gcdEnabled)
	CreateCheckbox("mouseRingGCDRadial", L["Radial GCD Ring"], L["Pie chart style animation"], gcdEnabled)

	-- Fixed Position (nested under GCD Ring)
	local gcdFixedPosSetting, gcdFixedPosEnabled = CreateCheckbox("mouseRingGCDFixedPosition", L["Fixed Position"], L["Anchor the GCD ring to a fixed screen position instead of following the cursor"], gcdEnabled)
	CreateSlider("mouseRingGCDFixedSize", L["Fixed Position Size"], L["Size of the GCD ring when in fixed position mode"], 20, 240, 5, gcdFixedPosEnabled)
	CreateSlider("mouseRingGCDFixedX", L["Fixed Position X"], L["Horizontal offset from screen center (negative = left, positive = right)"], -500, 500, 5, gcdFixedPosEnabled)
	CreateSlider("mouseRingGCDFixedY", L["Fixed Position Y"], L["Vertical offset from screen center (negative = down, positive = up)"], -400, 400, 5, gcdFixedPosEnabled)

	-- Mouse Trail Section
	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["Mouse Trail"]))

	local trailSetting, trailEnabled = CreateCheckbox("mouseTrailEnabled", L["Enable Mouse Trail"], L["Show a trail behind your mouse cursor"])
	CreateCheckbox("mouseTrailUseClassColor", L["Use Class Color for Trail"], L["Use your class color for the trail"], trailEnabled)
	CreateColorPicker("mouseTrailColor", L["Trail Color"], L["Custom color for the trail"], trailEnabled)
	CreateCheckbox("mouseTrailCombatOnly", L["Trail Combat Only"], L["Only show trail in combat"], trailEnabled)

	-- Trail Density Dropdown
	local densityOptions = {
		[1] = VIDEO_OPTIONS_LOW,
		[2] = VIDEO_OPTIONS_MEDIUM,
		[3] = VIDEO_OPTIONS_HIGH,
		[4] = VIDEO_OPTIONS_ULTRA,
		[5] = VIDEO_OPTIONS_ULTRA_HIGH,
	}
	CreateDropdown("mouseTrailDensity", L["Trail Density"], L["Adjust the density of the mouse trail"], densityOptions, trailEnabled)
end

-- Wait for PLAYER_LOGIN to initialize settings (only create frame once)
if not addon.settingsEventFrame then
	addon.settingsEventFrame = CreateFrame("Frame")
	addon.settingsEventFrame:RegisterEvent("PLAYER_LOGIN")
	addon.settingsEventFrame:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_LOGIN" then
			InitializeSettings()
			self:UnregisterAllEvents()
			self:SetScript("OnEvent", nil)
		end
	end)
end

