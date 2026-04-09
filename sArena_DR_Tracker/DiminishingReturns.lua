-- Diminishing Returns Tracking Module
local drCategories = DRTrackerMixin.drCategories
local isRetail = DRTrackerMixin.isRetail
local drTime = (isRetail and 18.5) or 20
local drList = DRTrackerMixin.drList

local severityColor = {
	[1] = { 0, 1, 0, 1 },  -- Green (50% reduction)
	[2] = { 1, 1, 0, 1 },  -- Yellow (25% reduction)
	[3] = { 1, 0, 0, 1 }   -- Red (immune)
}

local GetTime = GetTime
local GetSpellTexture = GetSpellTexture or C_Spell.GetSpellTexture

function DRTrackerMixin:UpdateDRTimeSetting()
	if not self.db.profile.drResetTimeFix then
		self.db.profile.drResetTime = (isRetail and 18.5 or 20)
		self.db.profile.drResetTimeFix = true
	end
	drTime = self.db.profile.drResetTime or (isRetail and 18.5 or 20)
end

function DRTrackerFrameMixin:FindDR(combatEvent, spellID)
	local category = drList[spellID]
	if not category then return end

	-- Check if this DR category is enabled
	local categoryEnabled = self.parent.db.profile.drCategories[category]
	if not categoryEnabled then return end

	local frame = self[category]
	if not frame then return end
	
	local currTime = GetTime()

	if (combatEvent == "SPELL_AURA_REMOVED" or combatEvent == "SPELL_AURA_BROKEN") then
		local startTime, startDuration = frame.Cooldown:GetCooldownTimes()
		startTime, startDuration = startTime/1000, startDuration/1000

		-- Guard against division by zero
		if startDuration == 0 or (1 - ((currTime - startTime) / startDuration)) == 0 then
			DRTrackerMixin:Print("|cFFFF0000BUG: DR failed:|r " .. spellID .. ", " .. combatEvent)
			return
		end

		local newDuration = drTime / (1 - ((currTime - startTime) / startDuration))
		local newStartTime = drTime + currTime - newDuration

		frame:Show()
		frame.Cooldown:SetCooldown(newStartTime, newDuration)
		return
		
	elseif (combatEvent == "SPELL_AURA_APPLIED" or combatEvent == "SPELL_AURA_REFRESH") then
		local unit = self.unit

		for i = 1, 30 do
			local auraData = C_UnitAuras.GetAuraDataByIndex(unit, i, "HARMFUL")

			if auraData then
				if not auraData.spellId then break end

				if (auraData.duration and spellID == auraData.spellId) then
					frame:Show()
					frame.Cooldown:SetCooldown(currTime, auraData.duration + drTime)
					break
				end
			end
		end
	end
	
	-- Set icon texture
	local textureID = self.parent.db.profile.drIcons[category]
	if not textureID then
		textureID = GetSpellTexture(spellID)
	end
	frame.Icon:SetTexture(textureID)

	-- Set border colors based on severity
	local borderColor = severityColor[frame.severity]
	frame.Border:SetVertexColor(unpack(borderColor))

	-- Update DR text (½, ¼, %)
	local drText = frame.DRTextFrame.DRText
	if drText then
		if frame.severity == 1 then
			drText:SetText("½")
		elseif frame.severity == 2 then
			drText:SetText("¼")
		else
			drText:SetText("%")
		end
		drText:SetTextColor(unpack(severityColor[frame.severity]))
	end

	-- Color cooldown text if enabled
	if self.parent.db.profile.colorDRCooldownText and frame.Cooldown.sArenaText then
		frame.Cooldown.sArenaText:SetTextColor(unpack(severityColor[frame.severity]))
	end

	-- Increment severity
	frame.severity = frame.severity + 1
	if frame.severity > 3 then
		frame.severity = 3
	end
end

function DRTrackerFrameMixin:UpdateDRPositions()
	local db = self.parent.db.profile.dr
	local numActive = 0
	local frame, prevFrame
	local spacing = db.spacing
	local growthDirection = db.growthDirection

	for i = 1, #drCategories do
		frame = self[drCategories[i]]

		if (frame and frame:IsShown()) then
			frame:ClearAllPoints()
			if (numActive == 0) then
				-- First frame
				local offset = (db.size or 28) / 2
				if (growthDirection == 4) then
					frame:SetPoint("RIGHT", self, "LEFT", -offset, 0)
				elseif (growthDirection == 3) then
					frame:SetPoint("LEFT", self, "RIGHT", offset, 0)
				elseif (growthDirection == 1) then
					frame:SetPoint("TOP", self, "BOTTOM", 0, -offset)
				elseif (growthDirection == 2) then
					frame:SetPoint("BOTTOM", self, "TOP", 0, offset)
				end
			else
				if (growthDirection == 4) then
					frame:SetPoint("RIGHT", prevFrame, "LEFT", -spacing, 0)
				elseif (growthDirection == 3) then
					frame:SetPoint("LEFT", prevFrame, "RIGHT", spacing, 0)
				elseif (growthDirection == 1) then
					frame:SetPoint("TOP", prevFrame, "BOTTOM", 0, -spacing)
				elseif (growthDirection == 2) then
					frame:SetPoint("BOTTOM", prevFrame, "TOP", 0, spacing)
				end
			end
			numActive = numActive + 1
			prevFrame = frame
		end
	end
end

function DRTrackerFrameMixin:ResetDR()
	for i = 1, #drCategories do
		if self[drCategories[i]] then
			self[drCategories[i]].Cooldown:Clear()
		end
	end
end

