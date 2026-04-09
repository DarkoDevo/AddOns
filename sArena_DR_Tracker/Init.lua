-- sArena DR Tracker - Standalone Diminishing Returns Tracker
-- Extracted from sArena Reloaded

DRTrackerMixin = {}
DRTrackerFrameMixin = {}

-- Set up version detection first
local gameVersion = select(1, GetBuildInfo())
DRTrackerMixin.isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
DRTrackerMixin.isMidnight = gameVersion:match("^12")
DRTrackerMixin.isMoP = gameVersion:match("^5%.")
DRTrackerMixin.isWrath = gameVersion:match("^3%.")
DRTrackerMixin.isTBC = gameVersion:match("^2%.")

DRTrackerMixin.maxArenaOpponents = (DRTrackerMixin.isRetail and 3) or 5

-- Default settings
DRTrackerMixin.defaultSettings = {
    profile = {
        drResetTime = (DRTrackerMixin.isRetail and 18.5) or 20,
        drResetTimeFix = true,
        colorDRCooldownText = false,
        invertDRCooldown = true,
        disableDRSwipe = false,
        disableSwipeEdge = false,
        showDecimalsDR = true,
        decimalThreshold = 6,
        drStaticIcons = true,
        drStaticIconsPerSpec = false,
        drStaticIconsPerClass = false,
        drCategoriesPerSpec = false,
        drCategoriesPerClass = false,
        -- Frame positioning per arena opponent
        frames = {
            arena1 = { posX = 0, posY = 100, scale = 1.0 },
            arena2 = { posX = 0, posY = 50, scale = 1.0 },
            arena3 = { posX = 0, posY = 0, scale = 1.0 },
            arena4 = { posX = 0, posY = -50, scale = 1.0 },
            arena5 = { posX = 0, posY = -100, scale = 1.0 },
        },
        -- DR display settings
        dr = {
            size = 28,
            spacing = 3,
            growthDirection = 3, -- 1=Down, 2=Up, 3=Right, 4=Left
            blackDRBorder = false,
            disableDRBorder = false,
        },
    }
}

-- Helper function for printing messages
function DRTrackerMixin:Print(msg)
    print("|cFFFF8000sArena DR Tracker:|r " .. tostring(msg))
end

-- Frame Mixin Methods
function DRTrackerFrameMixin:CreateDRFrames()
	local id = self:GetID()
	for _, category in ipairs(self.parent.drCategories) do
		local name = "DRTrackerDR" .. id .. category
		local drFrame = CreateFrame("Frame", name, self, "DRTrackerDRFrameTemplate")
		self[category] = drFrame
	end
end

function DRTrackerFrameMixin:UpdateDRPositions()
	if not self.parent or not self.parent.db then return end

	local layoutdb = self.parent.db.profile
	local numActive = 0
	local frame, prevFrame
	local spacing = layoutdb.dr.spacing
	local growthDirection = layoutdb.dr.growthDirection

	for i = 1, #self.parent.drCategories do
		frame = self[self.parent.drCategories[i]]

		if frame and frame:IsShown() then
			frame:ClearAllPoints()
			if numActive == 0 then
				-- First frame, offset due to unique DR sizes
				local offset = (layoutdb.dr.size or 28) / 2
				if growthDirection == 4 then
					frame:SetPoint("RIGHT", self, "CENTER", offset, 0)
				elseif growthDirection == 3 then
					frame:SetPoint("LEFT", self, "CENTER", -offset, 0)
				elseif growthDirection == 1 then
					frame:SetPoint("TOP", self, "CENTER", 0, offset)
				elseif growthDirection == 2 then
					frame:SetPoint("BOTTOM", self, "CENTER", 0, -offset)
				end
			else
				if growthDirection == 4 then
					frame:SetPoint("RIGHT", prevFrame, "LEFT", -spacing, 0)
				elseif growthDirection == 3 then
					frame:SetPoint("LEFT", prevFrame, "RIGHT", spacing, 0)
				elseif growthDirection == 1 then
					frame:SetPoint("TOP", prevFrame, "BOTTOM", 0, -spacing)
				elseif growthDirection == 2 then
					frame:SetPoint("BOTTOM", prevFrame, "TOP", 0, spacing)
				end
			end
			numActive = numActive + 1
			prevFrame = frame
		end
	end
end

