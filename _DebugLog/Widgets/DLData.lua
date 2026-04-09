------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Widgets/DLData - an Ace3 Data Widget
--
-- Author: Expelliarm5s / February 2026
-- based von AceGUI-3.0/AceGUIContainer-ScrollFrame.lua
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: globals LibStub CreateFrame UIParent wipe abs sort tinsert
-- luacheck: globals FauxScrollFrame_Update FauxScrollFrame_GetOffset FauxScrollFrame_OnVerticalScroll GameFontNormal
-- luacheck: globals debugWidgets DLAPI

local addonName = ...
local Type, Version = addonName .. "DLData", 7
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
------------------------------------------------------------------------------

-- Lua APIs
local floor = math.floor

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

--[[-----------------------------------------------------------------------------
Debug Stuff
-------------------------------------------------------------------------------]]

local debugAPI
local debugTag
local debugLvl = 0

local debugLog = function(f, ...)
	if debugTag and debugAPI then debugAPI.DebugLog(debugTag, "WDT~" .. f, ...) end
end

local debugStart = function(f, ...)
	if debugTag and debugAPI then debugAPI.DebugLog(debugTag, "WDT B~%s: " .. f, debugLvl, ...) end
	debugLvl = debugLvl + 1
end

local debugStop = function(f, ...)
	debugLvl = debugLvl - 1
	if debugTag and debugAPI then debugAPI.DebugLog(debugTag, "WDT E~%s: " .. f, debugLvl, ...) end
end

--[[-----------------------------------------------------------------------------
Support functions
-------------------------------------------------------------------------------]]

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		if debugWidgets and debugWidgets[Type] ~= nil then
			debugAPI = debugWidgets[Type].DLAPI
			debugTag = debugWidgets[Type].tag or "DebugWidgets"
			debugLog("OK~*** Debug log for widget %s enabled. ***", tostring(Type))
		end

		debugLog("OnAcquire", tostring(self))
		self.content = nil
		self.titles = nil
		self.doRedraw = true
		self.lastDataLines = 0
		self.lastWidth = 0
		self.hasSumLine = false
	end,

	["OnRelease"] = function(self)
		debugLog("OnRelease(%s)", tostring(self))
		wipe(self.titles)
		wipe(self.content)
		wipe(self.eventHandlers)
		self.doRedraw = false
	end,

	["WipeContent"] = function(self)
		debugLog("WipeContent(%s)", tostring(self))
		if self.content then
			wipe(self.content)
		end
		self.content = nil
		self.doRedraw = false
	end,

	["OnWidthSet"] = function(self, _)
		debugStart("OnWidthSet(%s)", tostring(self))
		if self.doRedraw then
			self.doRedraw = false
			self:Redraw()
			self.doRedraw = true
		end
		debugStop("OnWidthSet(%s)", tostring(self))
	end,

	["OnHeightSet"] = function(self, _)
		debugStart("OnHeightSet(%s)", tostring(self))
		if self.doRedraw then
			self.doRedraw = false
			self:Redraw()
			self.doRedraw = true
		end
		debugStop("OnHeightSet(%s)", tostring(self))
	end,

	["DoRedraw"] = function(self, flag)
		debugStart("DoRedraw(%s, %s)", tostring(self), tostring(flag))
		self.doRedraw = flag or false
		if flag then
			self:Redraw()
		end
		debugStop("DoRedraw(%s, %s)", tostring(self), tostring(flag))
	end,

	["SetTitles"] = function(self, titles)
		debugStart("SetTitles(%s, %s)", tostring(self), tostring(titles))
		self.titles = titles or {}
		if self.doRedraw then
			self:Redraw()
		end
		debugStop("SetTitles(%s, %s)", tostring(self), tostring(titles))
	end,

	["SetContent"] = function(self, content, stick)
		debugStart("SetContent(%s, %s, %s)", tostring(self), tostring(content), tostring(stick))
		self.content = content or {}
		self.sortIt = true
		if self.doRedraw then
			self:RefreshContent(stick)
		end
		debugStop("SetContent(%s, %s, %s)", tostring(self), tostring(content), tostring(stick))
	end,

	["SetTextSize"] = function(self, size)
		debugStart("SetTextSize(%s, %s)", tostring(self), tostring(size))
		self.textSize = size
		self.frameHeight = self.textSize + 1
		if self.doRedraw then
			self:Redraw()
		end
		debugStop("SetTextSize(%s, %s)", tostring(self), tostring(size))
	end,

	["SetSortTitle"] = function(self, title)
		debugLog("SetSortTitle(%s, %s)", tostring(self), tostring(title))
		self.sortTitle = abs(title or 1)
		self.sortDir = not title or title > 0
		self.sortIt = true
	end,

	["SetSumLine"] = function(self, hasLine)
		debugLog("SetSumLine(%s, %s)", tostring(self), tostring(hasLine))
		self.hasSumLine = hasLine
		if not hasLine then
			self.sumLine:Hide()
		end
	end,

	["GetSortTitle"] = function(self)
		debugLog("GetSortTitle(%s)", tostring(self))
		local title = tonumber(self.sortTitle) or 1
		if not self.sortDir then
			title = -1 * title
		end
		return title
	end,

	["RefreshContent"] = function(self, stick)
		if not self.content or not self.dataLines or not self.dataFrames then return end

		debugStart("RefreshContent(%s, %s)", tostring(self), tostring(stick))
		debugLog("WARN~Full RefreshContent()")

		FauxScrollFrame_Update(self.scrollFrame, #self.content, self.dataLines, self.textSize + 2)
		local offset = FauxScrollFrame_GetOffset(self.scrollFrame)
		-- debugLog("  was #content=" .. tostring(#self.content) .. " dataLines=" .. tostring(self.dataLines) .. " offset=" .. tostring(offset))

		if stick then
			offset = #self.content - self.dataLines
			-- debugLog("  now #content=" .. tostring(#self.content) .. " dataLines=" .. tostring(self.dataLines) .. " offset=" .. tostring(offset))
			if offset < 0 then
				offset = 0
			end
		end

		if self.sortIt and self.content and self.sortTitle then
			sort(self.content,
				function (a, b)
					if self.sortDir then
						return a.data[self.sortTitle][2] < b.data[self.sortTitle][2]
					else
						return a.data[self.sortTitle][2] > b.data[self.sortTitle][2]
					end
				end)
			self.sortIt = nil
		end

		for i=1, self.dataLines do
			self.dataFrames[i].data = nil
			if i > #self.content then
				self.dataFrames[i]:Hide()
			else
				self.dataFrames[i]:Show()
				local data = self.content[i+offset]
				if not data then break end
				self.dataFrames[i].data = data

				for j, dataButton in ipairs(self.dataFrames[i].dataButtons) do
					if self.titles[j] then
						if data.data[j] then
							dataButton:SetText(data.data[j][1])
						else
							dataButton:SetText("")
						end
					end
				end

				if self.hasSumLine then
					if self.dataLines >= 1 and (i+offset) == (#self.content - 1) then
						self.sumLine:Show()
						self.sumLine:ClearAllPoints()
						self.sumLine:SetPoint("TOPLEFT", self.dataFrames[i], "TOPLEFT", 2, - (self.textSize))
						self.sumLine:SetPoint("TOPRIGHT", self.dataFrames[i], "TOPRIGHT", -2, - (self.textSize))
					end
					if (i+offset) < (#self.content - 1) then
						self.sumLine:Hide()
					end
				end
			end
		end
		debugStop("RefreshContent(%s, %s)", tostring(self), tostring(stick))
	end,

	["Redraw"] = function(self)
		if not self.titles then return end

		debugStart("Redraw(%s, %s)", tostring(self), tostring(self.doRedraw))

		self.redrawCnt = (self.redrawCnt + 1) or 1

		local width = self.frame:GetWidth() - 14
		-- local height = self.frame:GetHeight()
		self.dataLines = floor((self.frame:GetHeight() - (self.textSize + 3))/ self.frameHeight) or 0

		if self.dataLines == self.lastDataLines then
			if (self.lastWidth > (width - 20)) and (self.lastWidth < (width + 20)) then
				if self.doRedraw then
					self:RefreshContent()
				end
				debugStop("Redraw(%s, %s) no change", tostring(self), tostring(self.doRedraw))
				return
			end
		end
		self.lastDataLines = self.dataLines
		self.lastWidth = width

		debugLog("WARN~Full Redraw()")

		self.titleButtons = self.titleButtons or {}
		while #self.titleButtons < #self.titles do
			self:NewTitleButton()
		end
		for i, titleButton in ipairs(self.titleButtons) do
			if self.titles[i] then
				titleButton:Show()
				titleButton:SetHeight(self.frameHeight)
				titleButton:SetWidth(abs(self.titles[i].relWidth) * width)
				titleButton:SetText(self.titles[i].text or "")
				if self.titles[i].relWidth < 0 then
					titleButton.text:SetJustifyH("RIGHT")
				else
					titleButton.text:SetJustifyH("LEFT")
				end
			else
				titleButton:Hide()
			end
		end

		self.dataFrames = self.dataFrames or {}
		while #self.dataFrames < self.dataLines do
			self:NewDataFrame()
		end

		for i, dataFrame in ipairs(self.dataFrames) do
			if i > self.dataLines then
				dataFrame.data = nil
				dataFrame:Hide()
			else
				dataFrame:Show()

				dataFrame.dataButtons = dataFrame.dataButtons or {}
				while #dataFrame.dataButtons < #self.titles do
					self:NewDataButton(i)
				end
				for j, dataButton in ipairs(dataFrame.dataButtons) do
					if self.titleButtons[j] and self.titles[j] then
						dataButton:Show()
						dataButton:SetWidth(abs(self.titles[j].relWidth) * width)
						if self.titles[j].relWidth < 0 then
							dataButton.text:SetJustifyH("RIGHT")
						else
							dataButton.text:SetJustifyH("LEFT")
						end
					else
						dataButton:Hide()
					end
				end
			end
		end

		self:RefreshContent()

		debugStop("Redraw(%s, %s) changed", tostring(self), tostring(self.doRedraw))
	end,

	["NewDataButton"] = function(self, i)
		debugLog("NewDataButton(%s, %s)", tostring(self), tostring(i))

		local dataFrame = self.dataFrames[i]
		local btnCnt = #dataFrame.dataButtons + 1
		local button = CreateFrame("Button", nil, dataFrame)

		if btnCnt == 1 then
			button:SetPoint("TOPLEFT")
		else
			button:SetPoint("TOPLEFT", dataFrame.dataButtons[btnCnt-1], "TOPRIGHT")
		end

		button.text = button:CreateFontString()
		button.text:SetFont(GameFontNormal:GetFont(), self.textSize)
		button.text:SetJustifyV("MIDDLE")
		button.text:SetJustifyH("LEFT")
		button.text:SetPoint("TOPLEFT", 1, -1)
		button.text:SetPoint("BOTTOMRIGHT", -1, 1)
		button:SetFontString(button.text)
		button:SetHeight(self.frameHeight)

		button:SetScript("OnEnter",
			function(btn, ...)
				if not dataFrame.data then return end
				dataFrame.glow:Show()
				if self.eventHandlers.OnEnter then
					self.eventHandlers.OnEnter(btn, dataFrame.data, ...)
				end
			end)
		button:SetScript("OnLeave" ,
			function(btn, ...)
				if not dataFrame.data then return end
				dataFrame.glow:Hide()
				if self.eventHandlers.OnLeave then
					self.eventHandlers.OnLeave(btn, dataFrame.data, ...)
				end
			end)
		button:RegisterForClicks("AnyUp")
		button:SetScript("OnClick",
			function(btn, ...)
				if not dataFrame.data then return end
				dataFrame.glow:Show()
				if self.eventHandlers.OnClick then
					self.eventHandlers.OnClick(btn, dataFrame.data, ...)
				end
			end)

		button.btnCol = btnCnt
		tinsert(dataFrame.dataButtons, button)
	end,

	["NewTitleButton"] = function(self)
		debugLog("NewTitleButton(%s)", tostring(self))

		local btnCnt = #self.titleButtons + 1
		local button = CreateFrame("Button", nil, self.contentFrame)

		if btnCnt == 1 then
			button:SetPoint("TOPLEFT")
		else
			button:SetPoint("TOPLEFT", self.titleButtons[btnCnt-1], "TOPRIGHT")
		end

		button.text = button:CreateFontString()
		button.text:SetFont(GameFontNormal:GetFont(), self.textSize)
		button.text:SetJustifyV("MIDDLE")
		button.text:SetJustifyH("LEFT")
		button.text:SetAllPoints()
		button:SetFontString(button.text)

		local glow = button:CreateTexture()
		glow:SetAllPoints()
		glow:SetColorTexture(1, 0.3, 0.3, 0.5)
		button:SetHighlightTexture(glow);

		button:RegisterForClicks("AnyUp")
		button:SetScript("OnClick",
			function (btnself, btn, ...)
				if btn == "LeftButton" then
					if not self.titles[btnself.btnCnt].noSort then
						if self.sortTitle == btnself.btnCnt then
							self.sortDir = not self.sortDir
						else
							self.sortTitle = btnself.btnCnt
							self.sortDir = true
						end
						self.sortIt = true
						self:RefreshContent()
					end
				else
					if self.eventHandlers.OnClick then
						self.eventHandlers.OnClick(btnself, btnCnt, btn, ...)
					end
				end
			end)
		button:SetScript("OnEnter",
			function(btn, ...)
				if self.eventHandlers.OnEnter then
					self.eventHandlers.OnEnter(btn, ...)
				end
			end)
		button:SetScript("OnLeave" ,
			function(btn, ...)
				if self.eventHandlers.OnLeave then
					self.eventHandlers.OnLeave(btn, ...)
				end
			end)

		button.btnCnt = btnCnt
		tinsert(self.titleButtons, button)
	end,

	["NewDataFrame"] = function(self)
		debugLog("NewDataFrame(%s)", tostring(self))

		local frmCnt = #self.dataFrames + 1
		local dataFrame = CreateFrame("Frame", nil, self.contentFrame)

		dataFrame:SetHeight(self.frameHeight)
		if frmCnt == 1 then
			dataFrame:SetPoint("TOPLEFT", 0, - (self.textSize + 4))
			dataFrame:SetPoint("TOPRIGHT", 0, - (self.textSize + 4))
		else
			dataFrame:SetPoint("TOPLEFT", self.dataFrames[frmCnt-1], "BOTTOMLEFT")
			dataFrame:SetPoint("TOPRIGHT", self.dataFrames[frmCnt-1], "BOTTOMRIGHT")
		end

		local glow = dataFrame:CreateTexture()
		glow:SetAllPoints()
		glow:SetColorTexture(1, 0, 0.1, 0.1)
		glow:Hide()
		dataFrame.glow = glow

		if (frmCnt % 2) == 1 then
			local ntex = dataFrame:CreateTexture()
			ntex:SetAllPoints()
			ntex:SetColorTexture(0, 0, 0, 0.3)
		else
			local ntex = dataFrame:CreateTexture()
			ntex:SetAllPoints()
			ntex:SetColorTexture(0, 0, 0, 0.1)
		end

		tinsert(self.dataFrames, dataFrame)
	end,

	["SetEventHandlers"] = function(self, ...)
		local eventHandlers = ...
		debugLog("SetEventHandlers(%s, %s)", tostring(self), tostring(eventHandlers))

		self.eventHandlers = self.eventHandlers or {}
		for event, handler in pairs(eventHandlers) do
			self.eventHandlers[event] = handler
		end
	end,

}
--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]

local function Constructor()
	local num = AceGUI:GetNextWidgetNum(Type)
	local frame = CreateFrame("Frame", Type .. num, UIParent)
	frame:SetAllPoints()

	debugLog("Constructor(): frame=%s name=%s", tostring(frame), tostring(Type .. num))

	local widget = {
		frame = frame,
		type = Type,

		textSize = 11,
		frameHeight = 11 + 1,
		titles = nil,
		content = nil,
		eventHandlers = nil,
		titleButtons = nil,
		dataFrames = nil,
		dataLines = nil,
		contentFrame = nil,
		scrollFrame = nil,
		sortTitle = nil,
		sortDir = nil,
		sortIt = nil,
		redrawCnt = 0,
	}

	for method, func in pairs(methods) do
		widget[method] = func
	end

	local contentFrame = CreateFrame("Frame", Type .. num .. "Content", frame)
	contentFrame:SetPoint("TOPLEFT", 0, -1)
	contentFrame:SetPoint("BOTTOMRIGHT", 0, 0)
	widget.contentFrame = contentFrame

	local scrollFrame = CreateFrame("ScrollFrame", Type .. num .. "ScrollFrame", frame, "FauxScrollFrameTemplate")
	scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
		FauxScrollFrame_OnVerticalScroll(self, offset, widget.textSize + 2, function() widget.RefreshContent(widget) end)
	end)
	scrollFrame:SetAllPoints(contentFrame)
	widget.scrollFrame = scrollFrame

	local scrollBar = _G[scrollFrame:GetName().."ScrollBar"]
	scrollBar:ClearAllPoints()
	scrollBar:SetPoint("TOPRIGHT", frame, -2, - _G[scrollBar:GetName().."ScrollUpButton"]:GetHeight()
		- (widget.textSize + 6))
	scrollBar:SetPoint("BOTTOMRIGHT", frame, -2, _G[scrollBar:GetName().."ScrollDownButton"]:GetHeight())

	local line = frame:CreateTexture()
	line:ClearAllPoints()
	line:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, - (widget.textSize + 3))
	line:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, - (widget.textSize + 3))
	line:SetHeight(1)
	line:SetColorTexture(1, 0.5, 0.5, 0.4)

	local sumLine = frame:CreateTexture()
	sumLine:ClearAllPoints()
	sumLine:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, - (widget.textSize + 3))
	sumLine:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, - (widget.textSize + 3))
	sumLine:SetHeight(1)
	sumLine:SetColorTexture(1, 0.8, 0.3, 0.4)
	widget.sumLine = sumLine

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)

-- EOF
