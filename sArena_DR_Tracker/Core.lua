-- sArena DR Tracker Core
local AceDB = LibStub("AceDB-3.0")

function DRTrackerMixin:OnLoad()
	-- Only register PLAYER_LOGIN initially to avoid ADDON_ACTION_FORBIDDEN
	-- Other events will be registered after login
	self:RegisterEvent("PLAYER_LOGIN")
end

function DRTrackerMixin:RegisterAllEvents()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ARENA_OPPONENT_UPDATE")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function DRTrackerMixin:OnEvent(event, ...)
	if event == "PLAYER_LOGIN" then
		self:Initialize()
		-- Register other events after initialization
		self:RegisterAllEvents()
	elseif event == "PLAYER_ENTERING_WORLD" then
		local isInitialLogin, isReloadingUi = ...
		if isInitialLogin or isReloadingUi then
			self:UpdateAllFramePositions()
		end
	elseif event == "ARENA_OPPONENT_UPDATE" then
		local unitToken, updateReason = ...
		if updateReason == "seen" then
			self:OnArenaOpponentSeen(unitToken)
		elseif updateReason == "destroyed" then
			self:OnArenaOpponentDestroyed(unitToken)
		elseif updateReason == "cleared" then
			self:OnArenaMatchEnd()
		end
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		self:OnCombatLogEvent()
	end
end

function DRTrackerMixin:Initialize()
	-- Initialize database
	self.db = AceDB:New("sArenaDRTrackerDB", self.defaultSettings, true)

	-- Update DR time setting
	self:UpdateDRTimeSetting()

	-- Create arena frames in Lua
	for i = 1, self.maxArenaOpponents do
		local unit = "arena" .. i
		local frameName = "DRTrackerArena" .. i

		-- Create the arena frame WITHOUT parenting to UIParent to avoid taint
		-- We'll parent it after creation
		local frame = CreateFrame("Frame", frameName, nil, "DRTrackerArenaFrameTemplate")
		frame:SetParent(UIParent)
		frame:SetID(i)

		-- Apply mixin
		for k, v in pairs(DRTrackerFrameMixin) do
			frame[k] = v
		end

		-- Set up the frame
		frame.unit = unit
		frame.parent = self
		frame.Label:SetText(tostring(i))

		-- Position the frame
		local settings = self.db.profile.frames["arena" .. i]
		local parentX, parentY = UIParent:GetCenter()
		frame:SetPoint("CENTER", UIParent, "CENTER", settings.posX, settings.posY)
		frame:SetScale(settings.scale or 1.0)

		-- Create DR frames
		frame:CreateDRFrames()

		-- Show frame initially so it can be positioned
		frame:Show()

		-- Store reference
		self["arena" .. i] = frame
	end

	self:Print("Loaded! Type /drtracker show to position frames, or /drtracker for help.")
end

function DRTrackerMixin:OnArenaOpponentSeen(unitToken)
	local id = tonumber(unitToken:match("arena(%d)"))
	if not id then return end
	
	local frame = self["arena" .. id]
	if frame then
		frame:Show()
		frame:UpdateDRPositions()
	end
end

function DRTrackerMixin:OnArenaOpponentDestroyed(unitToken)
	local id = tonumber(unitToken:match("arena(%d)"))
	if not id then return end
	
	local frame = self["arena" .. id]
	if frame then
		frame:ResetDR()
		frame:Hide()
	end
end

function DRTrackerMixin:OnArenaMatchEnd()
	for i = 1, self.maxArenaOpponents do
		local frame = self["arena" .. i]
		if frame then
			frame:ResetDR()
			frame:Hide()
		end
	end
end

function DRTrackerMixin:OnCombatLogEvent()
	local timestamp, combatEvent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
		destGUID, destName, destFlags, destRaidFlags, spellID = CombatLogGetCurrentEventInfo()
	
	-- Only track arena opponents
	if not destGUID or not destGUID:match("Player") then return end
	
	-- Check if it's a DR-relevant event
	if combatEvent == "SPELL_AURA_APPLIED" or 
	   combatEvent == "SPELL_AURA_REFRESH" or
	   combatEvent == "SPELL_AURA_REMOVED" or
	   combatEvent == "SPELL_AURA_BROKEN" then
		
		-- Find which arena frame this belongs to
		for i = 1, self.maxArenaOpponents do
			local unit = "arena" .. i
			if UnitGUID(unit) == destGUID then
				local frame = self["arena" .. i]
				if frame then
					frame:FindDR(combatEvent, spellID)
				end
				break
			end
		end
	end
end

function DRTrackerFrameMixin:CreateDRFrames()
	local id = self:GetID()
	for _, category in ipairs(DRTrackerMixin.drCategories) do
		local name = "DRTrackerFrame" .. id .. category
		local drFrame = CreateFrame("Frame", name, self, "DRTrackerDRFrameTemplate")
		drFrame:SetSize(self.parent.db.profile.dr.size, self.parent.db.profile.dr.size)
		self[category] = drFrame
	end
end

function DRTrackerMixin:UpdateAllFramePositions()
	for i = 1, self.maxArenaOpponents do
		local frame = self["arena" .. i]
		if frame then
			local settings = self.db.profile.frames["arena" .. i]
			frame:ClearAllPoints()
			frame:SetPoint("CENTER", UIParent, "CENTER", settings.posX, settings.posY)
			frame:SetScale(settings.scale or 1.0)
			frame:UpdateDRPositions()
		end
	end
end

function DRTrackerMixin:SaveFramePosition(frameID)
	local frame = self[frameID]
	if not frame then return end

	local x, y = frame:GetCenter()
	local parentX, parentY = UIParent:GetCenter()

	x = x - parentX
	y = y - parentY

	self.db.profile.frames[frameID].posX = x
	self.db.profile.frames[frameID].posY = y
end

-- Slash command handler
SLASH_DRTRACKER1 = "/drtracker"
SLASH_DRTRACKER2 = "/drt"
SlashCmdList["DRTRACKER"] = function(msg)
	local addon = DRTracker
	if not addon then
		print("|cFFFF8000sArena DR Tracker:|r Addon not loaded yet!")
		return
	end

	msg = msg:lower():trim()

	local maxOpponents = addon.maxArenaOpponents or 3

	if msg == "reset" then
		if addon.db then
			addon.db:ResetProfile()
			addon:UpdateAllFramePositions()
			addon:Print("Settings reset to default!")
		else
			addon:Print("Database not initialized yet!")
		end
	elseif msg == "show" then
		-- Show all frames for positioning
		for i = 1, maxOpponents do
			local frame = addon["arena" .. i]
			if frame then
				frame:Show()
			end
		end
		addon:Print("Showing all frames. Alt+Drag to move them.")
	elseif msg == "hide" then
		for i = 1, maxOpponents do
			local frame = addon["arena" .. i]
			if frame then
				frame:Hide()
			end
		end
		addon:Print("Frames hidden.")
	else
		addon:Print("Commands:")
		addon:Print("/drtracker show - Show all frames for positioning")
		addon:Print("/drtracker hide - Hide all frames")
		addon:Print("/drtracker reset - Reset all settings")
	end
end

-- Create the main addon frame in Lua to avoid ADDON_ACTION_FORBIDDEN errors
-- This must be done after all methods are defined
-- IMPORTANT: Create without a name to avoid being treated as a secure frame
local DRTracker = CreateFrame("Frame")

for k, v in pairs(DRTrackerMixin) do
	DRTracker[k] = v
end

-- Make it globally accessible
_G.DRTracker = DRTracker

-- Set up event handling
DRTracker:SetScript("OnEvent", function(self, event, ...)
	self:OnEvent(event, ...)
end)

-- Call OnLoad to register events
DRTracker:OnLoad()

