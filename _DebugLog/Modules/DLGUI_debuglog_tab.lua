------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLGUI_debuglog_tab.lua - Create New Log Tabs / Show Log Tabs
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals TEMPDLAPI debugstack SEARCH C_AddOns

local addonName, addon = ...
local GUI = addon:GetModule("GUI")
local AceGUI = LibStub("AceGUI-3.0")
local TextDump = LibStub("LibTextDump-1.0", true)
local private = {}
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Settings

private.dataWidget           = addonName .. "DLData" -- enhanced AceGUIContainer-ScrollFrame.lua
private.minCol               = 6                     -- minimum place holder columns

GUI.debugLog_defaultTextSize = 11                    -- table font size
GUI.debugLog_maxExport       = 1000                  -- export only the last maxExport lines
GUI.debugLog_showTitle       = true

GUI.debugLog_colCtrl  = GUI.debugLog_colCtrl or {}
GUI.debugLog_fmt = GUI.debugLog_fmt or {}
GUI.debugLog_lastSortTitle = GUI.debugLog_lastSortTitle or {}

if addonName == "__DebugLogTemp" then
	private.dataWidget       = addonName .. "DLDataTemp"
end

local GGetAddOnMetadata = GetAddOnMetadata
local function GetAddOnMetadata(...)
	if C_AddOns and C_AddOns.GetAddOnMetadata then
		local status, res = pcall(C_AddOns.GetAddOnMetadata, ...)
		if status then
			return res
		end
	else
		local status, res = pcall(GGetAddOnMetadata, ...)
		if status then
			return res
		end
	end
end

------------------------------------------------------------------------------
-- DLAPI Functions

-- setting alternative InlineGroup and Content widgets
function GUI.DebugLog_SetWidgets(widgets)
	private.DebugPrintf("DebugLog_SetWidgets(%s)", widgets)
	if widgets then
		if widgets.data then
			private.dataWidget = widgets.data
		end
	end
end

-- is a format registered?
function GUI.DebugLog_IsFormatRegistered(hdl)
	private.DebugPrintf("DebugLog_IsFormatRegistered(%s)", tostring(hdl))
	if not hdl or type(hdl) ~= "string" or not GUI.debugLog_fmt[hdl] then
		return false
	else
		if type(hdl) == "string" and GUI.debugLog_fmt[hdl] then
			private.DebugPrintf("  = true")
			return GUI.debugLog_fmt[hdl]
		else
			return false
		end
	end
end

-- register a debug log format
function GUI.DebugLog_RegisterFormat(hdl, def)
	if not hdl or type(hdl) ~= "string" or not def then
		private.DebugPrintf("ERR~DebugLog_RegisterFormat(%s, %s): no format or definition!", tostring(hdl), tostring(def))
		return
	end

	if def.colNames then
		private.DebugPrintf("DebugLog_RegisterFormat(%s, %s)", tostring(hdl), tostring(def))

		GUI.debugLog_fmt[hdl] = GUI.debugLog_fmt[hdl] or {}
		GUI.debugLog_fmt[hdl].colNames = def.colNames
		GUI.debugLog_fmt[hdl].colWidth = def.colWidth
		GUI.debugLog_fmt[hdl].colFlex = def.colFlex
		GUI.debugLog_fmt[hdl].statusText = def.statusText

		GUI.debugLog_fmt[hdl].GetSTData = def.GetSTData
	else
		private.DebugPrintf("ERR~DebugLog_RegisterFormat(%s, %s): no %s.colNames defined!", tostring(hdl), tostring(def), tostring(def))
	end
end

-- return colCtrl for a tab "a"
function GUI.DebugLog_GetColCtrl(a)
	if a and type(a) == "string" and GUI.debugLog_colCtrl[a] then
		return GUI.debugLog_colCtrl[a]
	end
end

-- return format for tab "a"
function GUI.DebugLog_GetFormat(a)
	if a and type(a) == "string" and GUI.debugLog_colCtrl[a] then
		return GUI.debugLog_colCtrl[a].fmt
	end
end

-- set tab "a" to format "hdl"
function GUI.DebugLog_SetFormat(a, hdl)
	-- check if tab already exists
	if GUI.debugLog_colCtrl[a] then
		private.DebugPrintf("ERR~DebugLog_SetFormat(): tab '%s' already exists (format is '%s')",
			tostring(a), tostring(GUI.debugLog_colCtrl[a].fmt))
		return
	end
	if hdl and type(hdl) == "string" and GUI.debugLog_fmt[hdl] then
		GUI.debugLog_colCtrl[a] = GUI.debugLog_colCtrl[a] or {}
		GUI.debugLog_colCtrl[a].fmt = hdl
		private.DebugPrintf("OK~DebugLog_SetFormat(): tab '%s' set to format '%s'",
			tostring(a), tostring(GUI.debugLog_colCtrl[a].fmt))
	end
end

-- write an entry to a debug log, create a new log tab if not already present
function GUI.DebugLog(a, ...)
	if a and type(a) == "string" then

		-- create log if not present
		addon.debuglog = addon.debuglog or {}
		if not addon.debuglog[a] then
			addon.debuglog[a] = {}
			if addonName == "_DebugLog" then
				tinsert(addon.debuglog[a], { t = time(), m = "WARN~Log for '" .. a .. "' created" })
				if addonName ~= a then
					GUI.DebugLog(addonName, "WARN~Tab '" .. a .. "' created")
				end
				addon:Printf("Log for '" .. a .. "' created")
			end
		end

		private.rec = private.rec or {}
		-- check for loop
		if not private.rec[a] then
			private.rec[a] = true
			-- create tab if not present
			if addon.GUI and not addon.GUI.guiTabs.select[a] then
				addon.GUI.DebugLog_CreateTab(a)
				tinsert(addon.debuglog[a], { t = time(),
					m = format("WARN~Format for log '%s' is '%s'", tostring(a), tostring(GUI.debugLog_colCtrl[a].fmt)) })
			end
			private.rec[a] = nil
		end

		local status, res = pcall(format, ...)
		if status then
			if res then
				tinsert(addon.debuglog[a], { t = time(), m = res })
			end
		else
			if addon.DebugLog then
				addon:DebugLog(format("ERR~Wrong Syntax for DebugLog() in %s: %s", private.Caller(), tostring(res)))
			end
		end
	else
		if addon.DebugLog then
			addon:DebugLog(format("ERR~Wrong Syntax for DebugLog() in %s", private.Caller()))
		end
	end
end

-- returns formatted time
function GUI.DebugLog_TimeToString(tme, withYear)
	local t = tme
	if type(t) == "string" then
		if tonumber(t) then
			t = tonumber(t)
		else
			return "???"
		end
	end

	local res
	local timeFormat = "%m-%d %H:%M:%S"
	if addon.db and addon.db.global and addon.db.global.timeFormat then
		timeFormat = addon.db.global.timeFormat
	end

	if not withYear then
		if timeFormat == "%d.%m.%Y %H:%M:%S" then
			timeFormat = "%d.%m. %H:%M:%S"
		elseif timeFormat == "%m/%d/%Y %H:%M:%S" then
			timeFormat = "%m/%d %H:%M:%S"
		elseif timeFormat == "%Y-%m-%d %H:%M:%S" then
			timeFormat = "%m-%d %H:%M:%S"
		end
	end

	if timeFormat == "ago" then
		local lTime = time() - t
		if (lTime == 0) then
			res = "now"
		else
			res = format("%s ago", SecondsToTime(lTime) or "?")
		end
	elseif timeFormat then
		res = date(timeFormat, t)
	else
		res = tostring(t)
	end
	return res
end

------------------------------------------------------------------------------
-- Create/Show Tab

-- compute scroll table column widhts
function private.computeWidth(container, text, width, flex)
	private.DebugPrintf("computeWidth(%s, %s, %s, %s)", tostring(container), tostring(text), tostring(width), tostring(flex))
	if not flex then
		return text, width
	end

	local align = {}
	for i, _ in ipairs(flex) do
		if width[i] < 0 then
			align[i] = -1
			width[i] = abs(width[i])
		else
			align[i] = 1
		end
	end

	local colDebug = false

	local w = 0
	if colDebug then
		for i, _ in ipairs(flex) do
			w = w + width[i]
			private.DebugPrintf("original width[%s] = %s, sum=%s", tostring(i), tostring(width[i]), tostring(w))
		end
	end

	-- flexibled view
	w = 0
	if container.parent and container.parent.status and container.parent.status.width and container.parent.status.width > 900 then
		for i, _ in ipairs(flex) do
			width[i] = width[i] + (width[i] / 2.2) - (width[i] / 2.2) * (container.parent.status.width / 1400)
			if colDebug then
				w = w + width[i]
				private.DebugPrintf("flexibled width[%s] = %s, sum=%s", tostring(i), tostring(width[i]), tostring(w))
			end
		end
	end

	-- find sum of all flex cols and remove unwanted cols
	local flexVal = 0
	w = 0
	for i, _ in ipairs(flex) do
		w = w + width[i]
		if flex[i] == "" then
			width[i] = 0.001
		elseif flex[i] == "flex" or flex[i] == "drop" then
			flexVal = flexVal + width[i]
		end
	end
	if colDebug then
		private.DebugPrintf("is 1=%s ?, flexVal=%s", tostring(w), tostring(flexVal))
	end

	for i, _ in ipairs(flex) do
		if flex[i] and (flex[i] == "max" or flex[i] == "search") then
			width[i] = 1 - flexVal
			if colDebug then
				private.DebugPrintf("max is col %s = %s", tostring(i), tostring(width[i]))
			end
		end
	end

	if colDebug then
		w = 0
		for i, _ in ipairs(flex) do
			w = w + width[i]
			private.DebugPrintf("after width[%s] = %s, sum=%s", tostring(i), tostring(width[i]), tostring(w))
		end
		if width[1] ~= nil and w > 1 then
			private.DebugPrintf("width[1] reduced minus %s", tostring(w - 1))
			width[1] = width[1] - (w - 1)
			if width[1] < 0 then
				width[1] = 0
			end
			w = 0
			for i, _ in ipairs(flex) do
				w = w + width[i]
				private.DebugPrintf("final width[%s] = %s, sum=%s", tostring(i), tostring(width[i]), tostring(w))
			end
		end
	end

	for i, _ in ipairs(flex) do
		width[i] = width[i] * align[i]
	end

	return text, width
end

-- delete a log
function GUI.DebugLog_Reset(a)
	if not a then
		return
	end

	addon.debuglog = addon.debuglog or {}
	if addon.debuglog[a] then
		wipe(addon.debuglog[a])
		addon.debuglog[a] = nil
	end

	addon.debuglogLines = addon.debuglogLines or {}
	addon.debuglogLines[a] = nil
end

-- create a new log tab by creating functions to run on select
function GUI.DebugLog_CreateTab(a, fmt, fu, additionalUICB)
	if not a then
		return
	end

	-- if the format is not already set by GUI.DebugLog_SetFormat() use format "default"
	GUI.debugLog_colCtrl[a] = GUI.debugLog_colCtrl[a] or {}
	GUI.debugLog_colCtrl[a].fmt = GUI.debugLog_colCtrl[a].fmt or fmt or "default"
	private.DebugPrintf("WARN~DebugLog_CreateTab(%s, %s, %s)", tostring(a), tostring(fmt), tostring(fu))

	GUI.guiTabs.texts[a] = {title=a, desc=a}
	GUI.guiTabs.order[#GUI.guiTabs.order + 1] = a

	GUI.guiTabs.select[a] = function(container, group)
		private.DebugPrintf("OK~guiTabs.select(%s, %s)", tostring(container), tostring(group))

		-- Scrolling Data Table
		local stData

		-- Column Definition
		if type(GUI.debugLog_colCtrl[a].fmt) == "string" and GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt] then
			-- default log column definition
			GUI.debugLog_colCtrl[a].colNames = private.tcopy(GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].colNames)
			GUI.debugLog_colCtrl[a].colWidth = private.tcopy(GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].colWidth)
			GUI.debugLog_colCtrl[a].colFlex = private.tcopy(GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].colFlex)
			GUI.debugLog_colCtrl[a].statusText = private.tcopy(GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].statusText)
			GUI.debugLog_colCtrl[a].colFilter = GUI.debugLog_colCtrl[a].colFilter or {}

			stData, GUI.debugLog_colCtrl[a].colFlex = GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].GetSTData(a, GUI.debugLog_colCtrl[a].colFlex)
		else
			local desc = AceGUI:Create("Label")
			desc:SetText(format("Debug Log Format '%s' is undefined!", tostring(GUI.debugLog_colCtrl[a].fmt)))
			desc:SetRelativeWidth(1)
			container:AddChild(desc)
			return container
		end

		-- Column Titles and Status Text
		local titles = {}
		local status = {}
		GUI.debugLog_colCtrl[a].colNames, GUI.debugLog_colCtrl[a].colWidth = private.computeWidth(container,
			GUI.debugLog_colCtrl[a].colNames,
			GUI.debugLog_colCtrl[a].colWidth,
			GUI.debugLog_colCtrl[a].colFlex)

		if GUI.debugLog_colCtrl[a].colFlex then
			for i, _ in ipairs(GUI.debugLog_colCtrl[a].colFlex) do
				local name = GUI.debugLog_colCtrl[a].colNames[i]
				local noSort = false
				if (strmatch(name, "^(~)")) then
					name = name:gsub("^~", "")
					noSort = true
				end
				tinsert(titles, {text = name, noSort = noSort, relWidth = GUI.debugLog_colCtrl[a].colWidth[i]})
				tinsert(status, GUI.debugLog_colCtrl[a].statusText[i])
			end
		end
		container.titleStatusText = status

		-- eventually insert line with filter for dropdown and search box
		-- add for every GUI.debugLog_colCtrl[a].colFlex[i] == "drop" one drop down filter
		-- add for every GUI.debugLog_colCtrl[a].colFlex[i] == "search" one search box, but only if there
		--   is already one drop down filter
		local numControl
		local numDropDown = 0
		local numSearchBox = 0
		local numSearchReset = 1
		for _, v in ipairs(GUI.debugLog_colCtrl[a].colFlex) do
			if v == "drop" then
				numDropDown = numDropDown + 1
			elseif v == "search" then
				numSearchBox = numSearchBox + 1
			end
		end
		numControl = numDropDown + numSearchBox

		-- test for LibTextDump
		local numExport = 0
		if TextDump then
			numExport = 1
		end

		-- Filter Bar
		local grp
		if numDropDown > 0 or addon.db.global.showExport then
			if GUI.debugLog_defaultSimpleGroupContainer then
				grp = AceGUI:Create("SimpleGroup")
			else
				grp = AceGUI:Create("InlineGroup")
			end
			grp:SetLayout("Flow")
			grp:SetFullWidth(true)
			grp.content:SetPoint("TOPLEFT", 5, -5)
			grp.content:SetPoint("BOTTOMRIGHT", -5, 5)

			if grp.SetTitle then
				local NAME = GetAddOnMetadata(a, "Title") or a
				local VERSION = GetAddOnMetadata(a, "Version") and ("v" .. GetAddOnMetadata(a, "Version")) or ""
				local NOTES = GetAddOnMetadata(a, "Notes") and ("- " .. GetAddOnMetadata(a, "Notes")) or ""
				grp:SetTitle(NAME .. " " .. VERSION .. " " .. NOTES)
			end

			if numControl > 0 then
				private.DebugPrintf("guiTabs.select()  Create filter bar with %s drop down and %s search box", tostring(numDropDown), tostring(numSearchBox))

				-- use not less space than for minCol cols
				local numCol = numDropDown + numSearchBox * 3 + numSearchReset + numExport
				if numCol < private.minCol then
					numCol = private.minCol
				end

				-- create drop down controls
				for i, v in ipairs(GUI.debugLog_colCtrl[a].colFlex) do
					if v == "drop" then
						GUI.debugLog_colCtrl[a].colDrop = GUI.debugLog_colCtrl[a].colDrop or {}
						GUI.debugLog_colCtrl[a].colDrop[i] = {}

						-- provide drop down lists from actual data
						for _, en in ipairs(stData) do
							if en and en.data and en.data[i] and en.data[i][1] then
								local w = en.data[i][1]
								if w ~= "" and not GUI.debugLog_colCtrl[a].colDrop[i][w] then
									GUI.debugLog_colCtrl[a].colDrop[i][w] = w
								end
							end
						end

						-- create label and drop down control
						local desc = AceGUI:Create("Label")
						if desc.SetText then
							desc:SetText(GUI.debugLog_colCtrl[a].colNames[i] and GUI.debugLog_colCtrl[a].colNames[i] .. ": " or "???")
							desc:SetJustifyH("RIGHT")
						end
						desc:SetRelativeWidth(1 / numCol / 4 * 1.5)
						grp:AddChild(desc)

						local drop = AceGUI:Create("Dropdown")
						drop:SetCallback("OnEnter", function() GUI:SetStatusLine(status) end)
						drop:SetCallback("OnLeave", function() GUI:SetStatusLine("") end)
						drop:SetRelativeWidth(1 / numCol / 4 * 3)
						drop:SetList(GUI.debugLog_colCtrl[a].colDrop[i])

						if GUI.debugLog_colCtrl[a].colFilter[i] and type(GUI.debugLog_colCtrl[a].colFilter[i]) == "string" then
							private.DebugPrintf("8~ drop %s: set key=%s from filter", tostring(i), tostring(GUI.debugLog_colCtrl[a].colFilter[i]))
							drop:SetValue(GUI.debugLog_colCtrl[a].colFilter[i])
						end

						drop:SetCallback("OnValueChanged",
							function(_, _, key)
								if key and key ~= "" and key ~= 1 then
									GUI.debugLog_colCtrl[a].colFilter[i] = key
								else
									GUI.debugLog_colCtrl[a].colFilter[i] = nil
								end
								if type(GUI.debugLog_colCtrl[a].fmt) == "string" and GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt] then
									local stFilteredData
										stFilteredData, GUI.debugLog_colCtrl[a].colFlex = GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].GetSTData(a,
											GUI.debugLog_colCtrl[a].colFlex,
											GUI.debugLog_colCtrl[a].colFilter)
									GUI.debugLog_colCtrl[a].w:SetContent(stFilteredData)
								end
							end
						)
						grp:AddChild(drop)
					end
				end

				-- create place holder
				local numPH = numCol
				while numPH > (numDropDown + numSearchBox * 3 + numSearchReset + numExport) do
						local desc = AceGUI:Create("Label")
						-- desc:SetText(format("PH %s", tostring(numPH)))
						desc:SetRelativeWidth(1 / numCol)
						grp:AddChild(desc)
						numPH = numPH - 1
				end

				-- create label and search box
				for i, v in ipairs(GUI.debugLog_colCtrl[a].colFlex) do
					if v == "search" then
						-- insert search box
						local desc = AceGUI:Create("Label")
						if desc.SetText then
							-- desc:SetText(GUI.debugLog_colCtrl[a].colNames[i] and GUI.debugLog_colCtrl[a].colNames[i] .. ": " or "???")
							desc:SetText(SEARCH .. ":")
							desc:SetJustifyH("RIGHT")
						end
						desc:SetRelativeWidth((1 / numCol / 5) * 2)
						grp:AddChild(desc)

						local search = AceGUI:Create("EditBox")
						search:SetRelativeWidth(((1 / numCol / 5 * 4)) * 2 - 0.001)
						if GUI.debugLog_colCtrl[a].colFilter[i] and type(GUI.debugLog_colCtrl[a].colFilter[i]) == "string" then
							private.DebugPrintf("8~ search %s: set text=%s from filter", tostring(i), tostring(GUI.debugLog_colCtrl[a].colFilter[i]))
							search:SetText(GUI.debugLog_colCtrl[a].colFilter[i])
						end
						search:SetCallback("OnTextChanged",
								function(f, _, value)
									value = value:trim()
									if value == "" then
										GUI.debugLog_colCtrl[a].colFilter[i] = nil
									else
										GUI.debugLog_colCtrl[a].colFilter[i] = value
										f:DisableButton(false)
									end
									if type(GUI.debugLog_colCtrl[a].fmt) == "string" and GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt] then
										local stFilteredData
										stFilteredData, GUI.debugLog_colCtrl[a].colFlex = GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].GetSTData(a,
											GUI.debugLog_colCtrl[a].colFlex,
											GUI.debugLog_colCtrl[a].colFilter)
										GUI.debugLog_colCtrl[a].w:SetContent(stFilteredData)
									end
								end
							)
						grp:AddChild(search)
					end
				end

				-- create reset button
				local btnReset = AceGUI:Create("Button")
				btnReset:SetText("RESET")
				btnReset:SetRelativeWidth(1 / numCol / 2)
				btnReset:SetCallback("OnEnter", function() GUI:SetStatusLine("Reset search filter") end)
				btnReset:SetCallback("OnLeave", function() GUI:SetStatusLine("") end)
				btnReset:SetCallback("OnClick", function()
					wipe(GUI.debugLog_colCtrl[a].colFilter)
					container:Reload()
					end)
				grp:AddChild(btnReset)

				if numExport > 0 then
					-- create export button
					local btnExport1 = AceGUI:Create("Button")
					btnExport1:SetText("CSV")
					btnExport1:SetRelativeWidth(1 / numCol / 2)
					btnExport1:SetCallback("OnEnter", function() GUI:SetStatusLine("Export current log (CSV, last " .. GUI.debugLog_maxExport .. " lines)") end)
					btnExport1:SetCallback("OnLeave", function() GUI:SetStatusLine("") end)
					btnExport1:SetCallback("OnClick", function() GUI.DebugLog_ExportLog(a, "csv") end)
					grp:AddChild(btnExport1)
					-- create export button
					local btnExport2 = AceGUI:Create("Button")
					btnExport2:SetText("HTML")
					btnExport2:SetRelativeWidth(1 / numCol / 2)
					btnExport2:SetCallback("OnEnter", function() GUI:SetStatusLine("Export current log (HTML, last " .. GUI.debugLog_maxExport .. " lines)") end)
					btnExport2:SetCallback("OnLeave", function() GUI:SetStatusLine("") end)
					btnExport2:SetCallback("OnClick", function() GUI.DebugLog_ExportLog(a, "html") end)
					grp:AddChild(btnExport2)
					-- create export button
					local btnExport3 = AceGUI:Create("Button")
					btnExport3:SetText("MD")
					btnExport3:SetRelativeWidth(1 / numCol / 2)
					btnExport3:SetCallback("OnEnter", function() GUI:SetStatusLine("Export current log (MD, last " .. GUI.debugLog_maxExport .. " lines)") end)
					btnExport3:SetCallback("OnLeave", function() GUI:SetStatusLine("") end)
					btnExport3:SetCallback("OnClick", function() GUI.DebugLog_ExportLog(a, "md") end)
					grp:AddChild(btnExport3)
				end
			end
			container:AddChild(grp)
		end

		-- addon additional UI elements
		if additionalUICB then
			additionalUICB(a, container)
		end

		-- Event Handlers
		GUI.debugLog_OnEnter = GUI.debugLog_OnEnter or {}
		GUI.debugLog_OnLeave = GUI.debugLog_OnLeave or {}
		GUI.debugLog_OnClick = GUI.debugLog_OnClick or {}
		local eventHandlers = {
			OnEnter = function(btn, data)
				if btn.btnCnt then
					GUI:SetStatusLine(GUI.container.titleStatusText[btn.btnCnt])
				end
				if btn.btnCol then
					if not data then return end
					if GUI.debugLog_OnEnter[GUI.debugLog_colCtrl[a].fmt] then
						GUI.debugLog_OnEnter[GUI.debugLog_colCtrl[a].fmt](btn, data)
					end
				end
			end,
			OnLeave = function(btn, data)
				if btn.btnCnt then
					GUI:SetStatusLine()
				end
				if btn.btnCol then
					if not data then return end
					if GUI.debugLog_OnLeave[GUI.debugLog_colCtrl[a].fmt] then
						GUI.debugLog_OnLeave[GUI.debugLog_colCtrl[a].fmt](btn, data)
					end
				end
			end,
			OnClick = function(btn, data, button)
				if not data then return end
				if GUI.debugLog_OnClick[GUI.debugLog_colCtrl[a].fmt] then
					GUI.debugLog_OnClick[GUI.debugLog_colCtrl[a].fmt](btn, data, button)
				end
			end,
		}

		-- Create the Data Widget
		local grp2
		local showTitle = GUI.debugLog_showTitle
		if numDropDown > 0 or addon.db.global.showExport or additionalUICB or not showTitle then
			grp2 = AceGUI:Create("SimpleGroup")
			grp2.content:SetPoint("TOPLEFT", 1, -3)
			grp2.content:SetPoint("BOTTOMRIGHT", -1, 3)
		else
			if GUI.debugLog_defaultSimpleGroupContainer then
				grp2 = AceGUI:Create("SimpleGroup")
			else
				grp2 = AceGUI:Create("InlineGroup")
			end
			if grp2.SetTitle and not GUI.debugLog_defaultNoContainerTitle then
				local NAME = GetAddOnMetadata(a, "Title") or a
				local VERSION = GetAddOnMetadata(a, "Version") and ("v" .. GetAddOnMetadata(a, "Version")) or ""
				local NOTES = GetAddOnMetadata(a, "Notes") and ("- " .. GetAddOnMetadata(a, "Notes")) or ""
				grp2:SetTitle(NAME .. " " .. VERSION .. " " .. NOTES)
			end
		end
		grp2:SetLayout("Fill")
		grp2:SetFullWidth(true)
		grp2:SetFullHeight(true)

		local textSize = GUI.debugLog_defaultTextSize or 11
		if addon.db and addon.db.global and addon.db.global.textSize and tonumber(addon.db.global.textSize) then
			textSize = tonumber(addon.db.global.textSize)
		end

		GUI.debugLog_colCtrl[a].w = AceGUI:Create(private.dataWidget)
		GUI.debugLog_colCtrl[a].w:DoRedraw(false)
		GUI.debugLog_colCtrl[a].w:SetEventHandlers(eventHandlers)
		GUI.debugLog_colCtrl[a].w:SetTitles(titles)
		GUI.debugLog_colCtrl[a].w:SetTextSize(textSize)
		GUI.debugLog_colCtrl[a].w:SetSortTitle(GUI.debugLog_lastSortTitle[a] or GUI.debugLog_defaultSortTitle or 1)
		GUI.debugLog_colCtrl[a].w:SetSumLine(GUI.debugLog_defaultHasSumLine or false)

		grp2:AddChild(GUI.debugLog_colCtrl[a].w)

		container:AddChild(grp2)

		local wantsFilter = false
		for i, _ in ipairs(GUI.debugLog_colCtrl[a].colFlex) do
			if GUI.debugLog_colCtrl[a].colFilter[i] then
				wantsFilter = true
			end
		end

		if wantsFilter then
			local stFilteredData
			stFilteredData, GUI.debugLog_colCtrl[a].colFlex = GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].GetSTData(a,
				GUI.debugLog_colCtrl[a].colFlex,
				GUI.debugLog_colCtrl[a].colFilter)
			GUI.debugLog_colCtrl[a].w:SetContent(stFilteredData)
		else
			GUI.debugLog_colCtrl[a].w:SetContent(stData)
		end

		GUI.debugLog_colCtrl[a].w:DoRedraw(true)

		if fu and fu[a] and fu[a].select then
			fu[a].select()
		end

		return container
	end

	------------------------------------------------------------------------------
	-- Timers

	GUI.guiTabs.timer[a] = function()
		-- private.DebugPrintf("guiTabs.timer[%s]", tostring(a))
		addon.debuglog = addon.debuglog or {}
		if not addon.debuglog[a] then
			return
		end

		local doUpdate = false

		addon.debuglogLines = addon.debuglogLines or {}
		addon.debuglogLines[a] = addon.debuglogLines[a] or 0
		if addon.debuglogLines[a] < #addon.debuglog[a] then
			private.DebugPrintf("guiTabs.timer(%s): num of lines has changed from %s to %s", a, addon.debuglogLines[a], #addon.debuglog[a])
			doUpdate = true
		end
		addon.debuglogLines[a] = #addon.debuglog[a]
		if doUpdate then
			GUI.DebugLog_UpdateData(a, true)
		end
	end

	-- trigger full reload of tabgroup
	private.doReload = true
end

-- update the table data of a log tab
private.inUpdate = false
function GUI.DebugLog_UpdateData(a, updated)
	-- GUI:DebugPrintf("UpdateTabData(%s, %s) doReload=%s inUpdate=%s", a, tostring(updated), tostring(private.doReload), tostring(private.inUpdate))

	private.DebugPrintf("UpdateTabData(%s, %s) doReload=%s inUpdate=%s", a, tostring(updated), tostring(private.doReload), tostring(private.inUpdate))
	if private.inUpdate then
		private.DebugPrintf("WARN~  inUpdate!")
		return
	end
	private.inUpdate = true
	if GUI.display and GUI.view == a then
		if updated and GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt] then
			private.DebugPrintf("  calling SetContent()/GetSTData() for %s", tostring(a))
			local stFilteredData
			stFilteredData, GUI.debugLog_colCtrl[a].colFlex = GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].GetSTData(a,
					GUI.debugLog_colCtrl[a].colFlex,
					GUI.debugLog_colCtrl[a].colFilter)
			GUI.debugLog_colCtrl[a].w:SetContent(stFilteredData or {})
			-- do no Reload()s for now
			-- GUI.container:Reload()
		end
	end
	if GUI.display and private.doReload then
		-- load full tabgroup to show new tab
		private.DebugPrintf("  doReload was set, so calling GUI:Load() to show new tabs")
		private.doReload = false
		GUI:Load()
	end
	private.inUpdate = false
end

------------------------------------------------------------------------------
-- Helper Functions

-- export log to html
function GUI.DebugLog_ExportLog(a, mode)
	private.DebugPrintf("ExportLog(%s, %s)", tostring(a), tostring(mode))
	local stFilteredData, _ = GUI.debugLog_fmt[GUI.debugLog_colCtrl[a].fmt].GetSTData(a,
		GUI.debugLog_colCtrl[a].colFlex,
		GUI.debugLog_colCtrl[a].colFilter)

	if mode == "csv" then
		local f = LibStub("LibTextDump-1.0"):New(("%s (%s, last %s lines)"):format(addonName, mode, GUI.debugLog_maxExport), 1024, 500)

		local firstLine = ""
		for _, v in ipairs(GUI.debugLog_colCtrl[a].colNames) do
			firstLine = firstLine .. (v or "") .. ";"
		end
		f:AddLine(firstLine)

		local from = #stFilteredData - GUI.debugLog_maxExport
		for i, en in ipairs(stFilteredData) do
			if i > from then
				local line = ""
				for j, _ in ipairs(GUI.debugLog_colCtrl[a].colNames) do
					local m = en.data[j][1] or ""
					line = line .. m .. ";"
				end
				if line and line ~= "" then
					f:AddLine(line)
				end
			end
		end
		f:Display()
	end

	if mode == "html" then
		local f = LibStub("LibTextDump-1.0"):New(("%s (%s, last %s lines)"):format(addonName, mode, GUI.debugLog_maxExport), 1024, 500)

		f:AddLine("<!DOCTYPE html><head><meta charset=\"UTF-8\"></head><body><style type=\"text/css\">" .. private.ExportCSS() .. "</style>")
		f:AddLine("<table class=\"dltable\">")

		local firstLine = "<tr>"
		for _, v in ipairs(GUI.debugLog_colCtrl[a].colNames) do
			firstLine = firstLine .. "<th class=\"dlth\">" .. (v or "") .. "</th>"
		end
		firstLine = firstLine .. "</tr>"
		f:AddLine(firstLine)

		local from = #stFilteredData - GUI.debugLog_maxExport
		for i, en in ipairs(stFilteredData) do
			if i > from then
				local line
				if (i % 2) == 0 then
					line = "<tr class=\"dle\">"
				else
					line = "<tr class=\"dlo\">"
				end

				for j, _ in ipairs(GUI.debugLog_colCtrl[a].colNames) do
					local m = en.data[j][1] or ""
					line = line .. "<td class=\"dlv\">" .. m .. "</td>"
				end
				line = line .. "</tr>"
				if line and line ~= "" then
					f:AddLine(line)
				end
			end
		end
		f:AddLine("</table></html")
		f:Display()
	end

	if mode == "md" then
		local f = LibStub("LibTextDump-1.0"):New(("%s (%s, last %s lines)"):format(addonName, mode, GUI.debugLog_maxExport), 1024, 500)

		local firstLine = ""
		local secondLine = ""
		for _, v in ipairs(GUI.debugLog_colCtrl[a].colNames) do
			firstLine = firstLine .. "| " .. (v or "")
			secondLine = secondLine .. "| --- "
		end
		firstLine = firstLine .. " |"
		secondLine = secondLine .. " |"
		f:AddLine(firstLine)
		f:AddLine(secondLine)

		local from = #stFilteredData - GUI.debugLog_maxExport
		for i, en in ipairs(stFilteredData) do
			if i > from then
				local line = ""
				for j, _ in ipairs(GUI.debugLog_colCtrl[a].colNames) do
					local m = en.data[j][1] or ""
					line = line .. "| " .. m
				end
				line = line .. " |"
				if line and line ~= "" then
					f:AddLine(line)
				end
			end
		end
		f:Display()
	end
end

function private.ExportCSS()

return [[
.dltable {
  width: 100%;
  font-size: 10pt;
  font-family: Arial, Verdana, Sans-serif;
  border-color: #2B477F;
  border-style: solid;
  border-width: 1px 1px 1px 1px;
  border-spacing: 1px;
  border-collapse: collapse;
}

.dlth {
  background: #99CCFF;
  text-align: left;
  font-weight: bold;
}

.dltable td, th {
  padding: 0px;
  padding-left: 3px;
  padding-right: 3px;
  border-color:  rgb(87, 108, 155);
  border-width: 1px 1px 1px 1px;
  border-style: solid;
}

.dlo {
  background: #E0E0E0;
  border-color:  rgb(87, 108, 155);
  border-width: 1px 1px 1px 1px;
  border-style: solid;
}

.dle {
  background: #F0F0F0;
  border-color:  rgb(87, 108, 155);
  border-width: 1px 1px 1px 1px;
  border-style: solid;
}

.right {
  text-align: right;
}

]]
end

function private.DebugPrintf(...)
	if TEMPDLAPI and TEMPDLAPI.DebugLog and addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			TEMPDLAPI.DebugLog(addonName, "GUI~" .. res)
		end
	end
end

function private.Caller(a)
	local r = a or 4
	local s = strmatch(debugstack(r,1,0), '^(.*): in') or ""
	s = s:gsub("^.string..", " ")
	s = s:gsub('"]', "")
	return s
end

function private.tcopy(t)
	local r = {}
	for u, v in pairs(t) do
		r[u] = v
	end
	return r
end

-- EOF

