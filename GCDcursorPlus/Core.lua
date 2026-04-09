local addonName = "GCDCursorPlus"
local addon = {}
_G[addonName] = addon

addon.version = "1.0.5"
addon.variables = {}

-- DO NOT initialize GCDCursorPlusDB here! WoW loads SavedVariables AFTER this file loads.
-- If we create the table here, WoW won't load the saved data from disk.
-- Instead, we initialize it in the ADDON_LOADED event handler.
addon.db = nil  -- Will be set in InitDB() during ADDON_LOADED

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

-- Hotpath locals & constants
local GetCursorPosition = GetCursorPosition
local IsMouseButtonDown = IsMouseButtonDown
local UIParent = UIParent
local UnitAffectingCombat = UnitAffectingCombat
local UnitClass = UnitClass
local GetClassColor = GetClassColor
local GetTime = GetTime
local GetSpellCooldownInfo = (C_Spell and C_Spell.GetSpellCooldown) or GetSpellCooldown
local RING_FRAME_NAME = addonName .. "_MouseRingFrame"
local GCD_RING_FRAME_NAME = addonName .. "_GCDRingFrame"
local TEX_MOUSE = "Interface\\AddOns\\" .. addonName .. "\\Media\\Mouse.tga"
local TEX_DOT = "Interface\\AddOns\\" .. addonName .. "\\Media\\Dot.tga"
local TEX_TRAIL = "Interface\\AddOns\\" .. addonName .. "\\Media\\MouseTrail.tga"
local GCD_SPELL_ID = 61304

-- Trail configuration
local MaxActuationPoint = 1
local MaxActuationPointSq = MaxActuationPoint * MaxActuationPoint
local duration = 0.3
local Density = 0.02
local ElementCap = 28
local PastCursorX, PastCursorY, PresentCursorX, PresentCursorY = nil, nil, nil, nil

-- Trail presets (density levels)
local trailPresets = {
	[1] = { -- LOW
		MaxActuationPoint = 1.0,
		duration = 0.4,
		Density = 0.025,
		ElementCap = 20,
	},
	[2] = { -- MEDIUM
		MaxActuationPoint = 0.7,
		duration = 0.5,
		Density = 0.02,
		ElementCap = 40,
	},
	[3] = { -- HIGH (Sweet Spot)
		MaxActuationPoint = 0.5,
		duration = 0.7,
		Density = 0.012,
		ElementCap = 80,
	},
	[4] = { -- ULTRA
		MaxActuationPoint = 0.3,
		duration = 0.7,
		Density = 0.007,
		ElementCap = 120,
	},
	[5] = { -- ULTRA HIGH
		MaxActuationPoint = 0.2,
		duration = 0.8,
		Density = 0.005,
		ElementCap = 150,
	},
}

-- State variables
local trailPool = {}
local activeCount = 0
local playerClass = UnitClass and select(2, UnitClass("player")) or nil
local classR, classG, classB
if playerClass and GetClassColor then
	classR, classG, classB = GetClassColor(playerClass)
end
local currentPreset = nil
local lastTrailWanted = false
local lastRingCombat = nil
local ringStyleDirty = true

-- GCD tracking variables
local gcdActive = false
local gcdStart = 0
local gcdDuration = 0
local gcdRate = 1

-- Database initialization
local function InitDB()
	-- Initialize saved variables (like DandersFrames does)
	if not GCDCursorPlusDB then
		GCDCursorPlusDB = {}
	end

	-- Point addon.db to the global SavedVariables table
	addon.db = GCDCursorPlusDB

	local defaults = {
		-- Mouse Ring
		mouseRingEnabled = false,
		mouseRingSize = 70,
		mouseRingColor = { r = 1, g = 1, b = 1, a = 0.6 },
		mouseRingUseClassColor = false,
		mouseRingCombatOnly = false,
		mouseRingHideDot = false,
		mouseRingOnlyOnRightClick = false,

		-- Combat Override
		mouseRingCombatOverride = false,
		mouseRingCombatOverrideSize = 70,
		mouseRingCombatOverrideColor = { r = 1, g = 0.2, b = 0.2, a = 1 },

		-- Combat Overlay
		mouseRingCombatOverlay = false,
		mouseRingCombatOverlaySize = 90,
		mouseRingCombatOverlayColor = { r = 1, g = 0.2, b = 0.2, a = 0.6 },

		-- GCD Ring
		mouseRingGCDEnabled = false,
		mouseRingGCDSize = 90,
		mouseRingGCDColor = { r = 0.2, g = 1, b = 0.2, a = 0.6 },
		mouseRingGCDUseClassColor = false,
		mouseRingGCDInverted = false,
		mouseRingGCDRadial = false,
		mouseRingGCDFixedPosition = false,
		mouseRingGCDFixedX = 0,
		mouseRingGCDFixedY = 0,
		mouseRingGCDFixedSize = 90,

		-- Mouse Trail
		mouseTrailEnabled = false,
		mouseTrailColor = { r = 1, g = 1, b = 1, a = 0.6 },
		mouseTrailUseClassColor = false,
		mouseTrailCombatOnly = false,
		mouseTrailDensity = 1,
	}

	-- Apply defaults for any missing values
	for key, value in pairs(defaults) do
		if addon.db[key] == nil then
			addon.db[key] = value
		elseif type(value) == "table" and type(addon.db[key]) ~= "table" then
			-- Stored value exists but is not a table (e.g. a color was corrupted to nil or a scalar)
			addon.db[key] = value
		end
	end
end

-- Helper function to get color
local function getRingColor()
	local db = addon.db
	if not db then return 0.4, 0.8, 1, 0.6 end  -- Default blue
	local c = db["mouseRingColor"]
	local alpha = (type(c) == "table" and c.a) or 0.6
	if db["mouseRingUseClassColor"] and classR then
		return classR, classG, classB, alpha
	end
	if type(c) ~= "table" then return 1, 1, 1, 0.6 end
	return c.r or 1, c.g or 1, c.b or 1, c.a or 0.6
end

local function getGCDRingColor()
	local db = addon.db
	if not db then return 1, 1, 1, 0.8 end  -- Default white
	local c = db["mouseRingGCDColor"]
	local alpha = (type(c) == "table" and c.a) or 0.6
	if db["mouseRingGCDUseClassColor"] and classR then
		return classR, classG, classB, alpha
	end
	if type(c) ~= "table" then return 0.2, 1, 0.2, 0.6 end
	return c.r or 0.2, c.g or 1, c.b or 0.2, c.a or 0.6
end

local function getTrailColor()
	local db = addon.db
	if not db then return 0.4, 0.8, 1, 0.6 end  -- Default blue
	local c = db["mouseTrailColor"]
	local alpha = (type(c) == "table" and c.a) or 0.6
	if db["mouseTrailUseClassColor"] and classR then
		return classR, classG, classB, alpha
	end
	if type(c) ~= "table" then return 1, 1, 1, 0.6 end
	return c.r or 1, c.g or 1, c.b or 1, c.a or 0.6
end

local function getCombatOverrideColor()
	local c = addon.db["mouseRingCombatOverrideColor"]
	if c then return c.r, c.g, c.b, c.a or 1 end
	return 1, 0.2, 0.2, 1
end

local function getCombatOverlayColor()
	local c = addon.db["mouseRingCombatOverlayColor"]
	if c then return c.r, c.g, c.b, c.a or 1 end
	return 1, 0.2, 0.2, 0.6
end

-- Apply trail density preset
local function applyPreset(presetName)
	local preset = trailPresets[presetName]
	if not preset then return end
	MaxActuationPoint = preset.MaxActuationPoint
	MaxActuationPointSq = MaxActuationPoint * MaxActuationPoint
	duration = preset.duration
	Density = preset.Density
	ElementCap = preset.ElementCap
	currentPreset = presetName
end

-- Check if ring should be shown
local function isRingWanted(db, inCombat, rightClickActive)
	if not db or not db["mouseRingEnabled"] then return false end
	if db["mouseRingCombatOnly"] and not inCombat then return false end
	if db["mouseRingOnlyOnRightClick"] and not rightClickActive then return false end
	return true
end

-- Ensure ring texture exists
local function ensureRing(frame)
	local ring = frame.ring
	if ring then return ring end
	ring = frame:CreateTexture(nil, "BACKGROUND")
	ring:SetTexture(TEX_MOUSE)
	ring:SetBlendMode("ADD")
	ring:SetPoint("CENTER", frame, "CENTER", 0, 0)
	ring:SetDrawLayer("BACKGROUND", -1)
	frame.ring = ring
	return ring
end

-- Ensure center dot exists
local function ensureDot(frame)
	local dot = frame.dot
	if dot then return dot end
	dot = frame:CreateTexture(nil, "BACKGROUND")
	dot:SetTexture(TEX_DOT)
	dot:SetSize(10, 10)
	dot:SetPoint("CENTER", frame, "CENTER", 0, 0)
	frame.dot = dot
	return dot
end

-- Ensure combat overlay exists
local function ensureCombatOverlay(frame)
	local overlay = frame.combatOverlay
	if overlay then return overlay end
	overlay = frame:CreateTexture(nil, "BACKGROUND")
	overlay:SetTexture(TEX_MOUSE)
	overlay:SetBlendMode("ADD")
	overlay:SetPoint("CENTER", frame, "CENTER", 0, 0)
	overlay:SetDrawLayer("BACKGROUND", 0)
	frame.combatOverlay = overlay
	return overlay
end

-- Ensure GCD ring texture exists
local function ensureGCDRing(frame)
	local gcdRing = frame.gcdRing
	if gcdRing then return gcdRing end
	gcdRing = frame:CreateTexture(nil, "BACKGROUND")
	gcdRing:SetTexture(TEX_MOUSE)
	gcdRing:SetBlendMode("ADD")
	gcdRing:SetPoint("CENTER", frame, "CENTER", 0, 0)
	gcdRing:SetDrawLayer("BACKGROUND", -2)
	frame.gcdRing = gcdRing
	return gcdRing
end

-- Ensure GCD radial ring (Cooldown frame for pie chart effect)
local function ensureGCDRadialRing(frame)
	local radialRing = frame.gcdRadialRing
	if radialRing then return radialRing end

	-- Create a Cooldown frame for pie chart effect
	radialRing = CreateFrame("Cooldown", nil, frame)
	radialRing:SetPoint("CENTER", frame, "CENTER", 0, 0)
	radialRing:SetFrameLevel(frame:GetFrameLevel() + 2)
	radialRing:SetSwipeTexture(TEX_MOUSE)
	radialRing:SetHideCountdownNumbers(true)
	radialRing:SetDrawEdge(false)
	radialRing:SetDrawSwipe(true)

	-- Set rotation to start at 12 o'clock (top)
	radialRing:SetRotation(0)

	frame.gcdRadialRing = radialRing
	return radialRing
end

-- Update GCD cooldown info
local function updateGCD()
	local start, duration, enabled, modRate
	local info, info2, info3, info4 = GetSpellCooldownInfo(GCD_SPELL_ID)
	if type(info) == "table" then
		start = info.startTime
		duration = info.duration
		enabled = info.isEnabled
		modRate = info.modRate
	else
		start = info
		duration = info2
		enabled = info3
		modRate = info4
	end

	if not enabled or enabled == 0 then
		gcdActive = false
		return
	end

	if not start or start == 0 or not duration or duration == 0 then
		gcdActive = false
		return
	end

	gcdActive = true
	gcdStart = start
	gcdDuration = duration
	gcdRate = modRate or 1
end

-- Update GCD ring display
local function updateGCDRing(ringFrame)
	local db = addon.db
	if not db then return end  -- Don't run until database is initialized
	if not db["mouseRingGCDEnabled"] then
		if ringFrame.gcdRing then
			ringFrame.gcdRing:Hide()
		end
		if ringFrame.gcdRadialRing then
			ringFrame.gcdRadialRing:Hide()
		end
		return
	end

	if not gcdActive then
		if ringFrame.gcdRing then
			ringFrame.gcdRing:Hide()
		end
		if ringFrame.gcdRadialRing then
			ringFrame.gcdRadialRing:Hide()
		end
		return
	end

	local now = GetTime()
	local elapsed = (now - gcdStart) * gcdRate

	if elapsed >= gcdDuration then
		gcdActive = false
		if ringFrame.gcdRing then
			ringFrame.gcdRing:Hide()
		end
		if ringFrame.gcdRadialRing then
			ringFrame.gcdRadialRing:Hide()
		end
		return
	end

	local progress = elapsed / gcdDuration
	if progress < 0 then progress = 0 end
	if progress > 1 then progress = 1 end

	-- Check if radial mode is enabled
	if db["mouseRingGCDRadial"] then
		-- Hide scaling ring, show radial ring
		if ringFrame.gcdRing then
			ringFrame.gcdRing:Hide()
		end

		local radialRing = ensureGCDRadialRing(ringFrame)
		local gcdSize = db["mouseRingGCDFixedPosition"] and (db["mouseRingGCDFixedSize"] or 90) or (db["mouseRingGCDSize"] or 90)
		local gr, gg, gb, ga = getGCDRingColor()

		-- Set size
		radialRing:SetSize(gcdSize, gcdSize)

		-- Set swipe color
		radialRing:SetSwipeColor(gr, gg, gb, ga or 0.8)

		-- Set reverse based on inverted option
		local shouldReverse = db["mouseRingGCDInverted"] or false
		radialRing:SetReverse(shouldReverse)

		-- Start the cooldown animation (pie chart sweep)
		radialRing:SetCooldown(gcdStart, gcdDuration)
		radialRing:Show()
	else
		-- Hide radial ring, show scaling ring
		if ringFrame.gcdRadialRing then
			ringFrame.gcdRadialRing:Hide()
		end

		local gcdRing = ensureGCDRing(ringFrame)
		local gcdSize = db["mouseRingGCDFixedPosition"] and (db["mouseRingGCDFixedSize"] or 90) or (db["mouseRingGCDSize"] or db["mouseRingSize"] or 90)

		-- Scale the GCD ring based on progress
		local currentSize
		if db["mouseRingGCDInverted"] then
			-- Inverted: grow from inside out (0 to full size)
			currentSize = gcdSize * progress
		else
			-- Normal: shrink from outside in (full size to 0)
			currentSize = gcdSize * (1 - progress)
		end
		if currentSize < 1 then currentSize = 1 end

		gcdRing:SetSize(currentSize, currentSize)
		local gr, gg, gb, ga = getGCDRingColor()
		gcdRing:SetVertexColor(gr, gg, gb, ga)
		gcdRing:Show()
	end
end

-- Update main ring display
local function updateRing(ringFrame)
	local db = addon.db
	if not db then return end  -- Don't run until database is initialized
	local combatActive = UnitAffectingCombat("player")
	local rightClickActive = db["mouseRingOnlyOnRightClick"] and IsMouseButtonDown("RightButton")

	-- Check if ring should be shown
	if not isRingWanted(db, combatActive, rightClickActive) then
		if ringFrame.ring then
			ringFrame.ring:Hide()
		end
		if ringFrame.combatOverlay then
			ringFrame.combatOverlay:Hide()
		end
		if ringFrame.dot then
			ringFrame.dot:Hide()
		end
		return
	end

	-- Update main ring
	local ring = ensureRing(ringFrame)
	local size = db["mouseRingSize"] or 70
	local r, g, b, a = getRingColor()

	-- Apply combat override if active
	if combatActive and db["mouseRingCombatOverride"] then
		size = db["mouseRingCombatOverrideSize"] or size
		r, g, b, a = getCombatOverrideColor()
	end

	ring:SetSize(size, size)
	ring:SetVertexColor(r, g, b, a)
	ring:Show()

	-- Update combat overlay
	if combatActive and db["mouseRingCombatOverlay"] then
		local overlay = ensureCombatOverlay(ringFrame)
		local overlaySize = db["mouseRingCombatOverlaySize"] or size
		local or_r, or_g, or_b, or_a = getCombatOverlayColor()
		overlay:SetSize(overlaySize, overlaySize)
		overlay:SetVertexColor(or_r, or_g, or_b, or_a)
		overlay:Show()
	else
		if ringFrame.combatOverlay then
			ringFrame.combatOverlay:Hide()
		end
	end

	-- Update center dot
	if db["mouseRingHideDot"] then
		if ringFrame.dot then
			ringFrame.dot:Hide()
		end
	else
		local dot = ensureDot(ringFrame)
		dot:Show()
	end
end

-- Trail pool management
local function getTrailElement()
	for i = 1, #trailPool do
		local elem = trailPool[i]
		if not elem.active then
			elem.active = true
			activeCount = activeCount + 1
			return elem
		end
	end

	if #trailPool >= ElementCap then
		return nil
	end

	local elem = UIParent:CreateTexture(nil, "BACKGROUND")
	elem:SetTexture(TEX_TRAIL)
	elem:SetBlendMode("ADD")
	elem:SetSize(32, 32)
	elem.active = true
	elem.birth = 0
	trailPool[#trailPool + 1] = elem
	activeCount = activeCount + 1
	return elem
end

local function releaseTrailElement(elem)
	if elem.active then
		elem.active = false
		elem:Hide()
		activeCount = activeCount - 1
	end
end

-- Update trail elements
local function updateTrail(delta)
	local db = addon.db
	if not db then return end  -- Don't run until database is initialized
	if not db["mouseTrailEnabled"] then
		for i = 1, #trailPool do
			releaseTrailElement(trailPool[i])
		end
		return
	end

	-- Check combat only setting
	if db["mouseTrailCombatOnly"] and not UnitAffectingCombat("player") then
		for i = 1, #trailPool do
			releaseTrailElement(trailPool[i])
		end
		return
	end

	local now = GetTime()
	local r, g, b, a = getTrailColor()

	-- Update existing trail elements
	for i = 1, #trailPool do
		local elem = trailPool[i]
		if elem.active then
			local age = now - elem.birth
			if age >= duration then
				releaseTrailElement(elem)
			else
				local progress = age / duration
				local alpha = (1 - progress) * a
				elem:SetVertexColor(r, g, b, alpha)
			end
		end
	end

	-- Spawn new trail elements
	local scale = UIParent:GetEffectiveScale()
	local x, y = GetCursorPosition()
	x = x / scale
	y = y / scale

	PresentCursorX, PresentCursorY = x, y

	if PastCursorX and PastCursorY then
		local dx = x - PastCursorX
		local dy = y - PastCursorY
		local distSq = dx * dx + dy * dy

		if distSq >= MaxActuationPointSq then
			local elem = getTrailElement()
			if elem then
				elem:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)
				elem:SetVertexColor(r, g, b, a)
				elem.birth = now
				elem:Show()
			end
		end
	end

	PastCursorX, PastCursorY = PresentCursorX, PresentCursorY
end

-- Main update function
local function onUpdate(self, delta)
	local db = addon.db

	-- Don't run until database is initialized (happens during ADDON_LOADED)
	if not db then
		return
	end

	-- Apply trail density preset if changed
	local trailWanted = db["mouseTrailEnabled"]
	if trailWanted and currentPreset ~= db["mouseTrailDensity"] then
		applyPreset(db["mouseTrailDensity"])
	end

	-- Update GCD tracking
	updateGCD()

	-- Get scale + cursor position (used by both frames)
	local scale = UIParent:GetEffectiveScale()
	local x, y = GetCursorPosition()
	local cursorX, cursorY = x / scale, y / scale

	-- Get or create cursor ring frame (always follows cursor)
	local ringFrame = _G[RING_FRAME_NAME]
	if not ringFrame then
		ringFrame = CreateFrame("Frame", RING_FRAME_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
		ringFrame:SetSize(120, 120)
		ringFrame:SetFrameStrata("TOOLTIP")
		ringFrame:SetFrameLevel(100)
	end
	ringFrame:ClearAllPoints()
	ringFrame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cursorX, cursorY)

	-- Get or create GCD ring frame (fixed or cursor-following)
	local gcdRingFrame = _G[GCD_RING_FRAME_NAME]
	if not gcdRingFrame then
		gcdRingFrame = CreateFrame("Frame", GCD_RING_FRAME_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
		gcdRingFrame:SetSize(120, 120)
		gcdRingFrame:SetFrameStrata("TOOLTIP")
		gcdRingFrame:SetFrameLevel(100)
	end
	if db["mouseRingGCDFixedPosition"] then
		gcdRingFrame:ClearAllPoints()
		gcdRingFrame:SetPoint("CENTER", UIParent, "CENTER", db["mouseRingGCDFixedX"] or 0, db["mouseRingGCDFixedY"] or 0)
	else
		gcdRingFrame:ClearAllPoints()
		gcdRingFrame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cursorX, cursorY)
	end

	-- Update ring and GCD ring
	updateRing(ringFrame)
	updateGCDRing(gcdRingFrame)

	-- Update trail
	updateTrail(delta)
end

-- Event frame for updates
local updateFrame = CreateFrame("Frame")
updateFrame:SetScript("OnUpdate", onUpdate)

-- Event handlers
local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")

eventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		local loadedAddon = ...
		-- Match case-insensitively since folder name might not match exactly
		if loadedAddon and (loadedAddon == addonName or loadedAddon:lower() == addonName:lower()) then
			InitDB()
		end
	elseif event == "PLAYER_LOGIN" then
		-- Refresh class colors
		playerClass = UnitClass and select(2, UnitClass("player")) or nil
		if playerClass and GetClassColor then
			classR, classG, classB = GetClassColor(playerClass)
		end
		-- Apply initial trail density preset
		if addon.db and addon.db["mouseTrailDensity"] then
			applyPreset(addon.db["mouseTrailDensity"])
		end
	elseif event == "SPELL_UPDATE_COOLDOWN" then
		updateGCD()
	end
end)

-- Slash command
SLASH_GCDCURSORPLUS1 = "/gcdcp"
SlashCmdList["GCDCURSORPLUS"] = function(msg)
	if Settings and Settings.OpenToCategory and addon.settingsCategory then
		Settings.OpenToCategory(addon.settingsCategory:GetID())
	elseif SettingsPanel then
		SettingsPanel:Open()
	else
		print("|cff00ff98GCD Cursor Plus|r: Settings panel not available. Use /reload to fix.")
	end
end

-- Refresh function for settings
function addon.RefreshAll()
	ringStyleDirty = true
end

print("|cff00ff98GCD Cursor Plus|r v" .. addon.version .. " loaded. Type |cffffffff/gcdcp|r to open settings.")

