------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLGUI_debuglog_fmt_tables.lua - Debug Log Format for Tables
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals TEMPDLAPI

local _, addon = ...
local GUI = addon:GetModule("GUI")
-- local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local private = {}
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Settings

-- tables Debug Log Format
private.tables = {}
private.tables.colNames = { "ID",   "Type",  "Variable", "Address", "Object", "Name", "Value" }
private.temp = 1            -0.05   -0.08   -0.2        -0.15      -0.1      -0.2
private.tables.colWidth = {  0.05,   0.08,   0.2,        0.15,      0.1,      0.2,   private.temp,}
private.tables.colFlex  = { "flex", "drop", "flex",      "flex",    "drop",   "flex", "search", }
private.tables.statusText = {
			"Sort by ID",
			"Sort by Type",
			"Sort by Variable",
			"Sort by Address",
			"Sort by Object",
			"Sort by Name",
			"Sort by Value",
		}
private.tables.GetSTData = function(...) return private.GetSTData_tables(...) end

------------------------------------------------------------------------------
-- Scrolling Table Data

-- Return Scrolling Table Data
function private.GetSTData_tables(a, flex, filter)
	GUI:DebugPrintf("GetSTData_tables(%s, %s, %s) private.temp=%s", tostring(a), tostring(flex), tostring(filter), tostring(private.temp))

	-- generate content only if visible
	if not GUI.display or GUI.view ~= a then
		GUI:DebugPrintf("... nothing done.")
		return
	end

	local content = {}

	-- generate content only if log data present
	addon.debuglog = addon.debuglog or {}
	if not addon.debuglog[a] then
		return content, flex
	end

	-- generate content
	local colHasContent = {}
	local k = 1
	for _, data in pairs(addon.debuglog[a]) do
		local filterMatch = nil  -- = nil -> no filter input = true -> filtered

		-- check dropdown
		for j, col in ipairs(flex) do
			colHasContent[j] = colHasContent[j] or data[j]
			if col == "drop" then
				if filter and filter[j] and filter[j] ~= "" then
					if (filterMatch == nil or filterMatch) then
						if data[j] and filter[j] == data[j] then
							filterMatch = true
						else
							filterMatch = false
						end
					end
				end
			end
		end

		-- check search
		for j, col in ipairs(flex) do
			if col == "search" then
				if filter and filter[j] and filter[j] ~= "" then
					if (filterMatch == nil or filterMatch) then
						-- search in all column data
						local found = false
						for m, _ in pairs(data) do
							if data[m] and type(data[m]) == "string" and strfind(strlower(data[m]), strlower(filter[j])) then
								filterMatch = true
								found = true
							end
						 end
						if not found then
							filterMatch = false
						end
					end
				end
			end
		end

		if filterMatch or filterMatch == nil then
			local en = {}

			if data[20] and type(data[20]) == "table" then
				en.en = data
			else
				if data[20] and type(data[20]) == "userdata" then
					en.en = data
				end
			end

			en.data = {}
			en.data[1] = {k, k}
			for w, _ in ipairs(flex) do
				en.data[w + 1] = {data[w + 1], data[w + 1] or ""}
			end
			tinsert(content, en)
			k = k + 1
		end
	end

	-- disable dropdown if not present
	for j, col in ipairs(flex) do
		if col == "drop" and not colHasContent[j] then
			flex[j] = ""
		end
	end

	return content, flex
end

-- Provide left + right click on table frame
GUI.debugLog_OnClick = GUI.debugLog_OnClick or {}
function GUI.debugLog_OnClick.tables(btn, data, button)
	GUI:DebugPrintf("OnClick: %s %s %s ", tostring(btn), tostring(data), tostring(button))

	if not data then return end
	if data.data[2][2] == "table" then
		if data.en and data.en[20] then
			if button == "LeftButton" then
				-- peruse in new table tab
				addon.Tables:Load(tostring(GUI.view) .. " | " .. data.en[3], data.en[20])
			else
				if data.en[20].GetParent then
					if data.en[20]:GetParent() then
						local name = data.en[3]
						if data.en[20].GetName then
							name = data.en[20]:GetName()
						end
						addon.Tables:Load(name or data.en[3], data.en[20]:GetParent())
					end
				end
			end
		end
	end
end

-- Provide tooltip on content button
GUI.debugLog_OnEnter = GUI.debugLog_OnEnter or {}
function GUI.debugLog_OnEnter.tables(btn, data)
	GUI:DebugPrintf("OnEnter: %s %s %s ", tostring(btn), tostring(data))

	if btn.btnCnt then
		GUI:SetStatusLine(GUI.container.titleStatusText[btn.btnCnt])
	else
		if type(data) == "table" and data.en then
			GUI:SetStatusLine("Click to show table in new tab.")
		end

		GameTooltip:SetOwner(btn, "ANCHOR_TOPLEFT")
		GameTooltip:ClearLines()
		for i, n in ipairs(data.data) do
			if i > 1 then
				if n[2] and n[2] ~= "" then
					GameTooltip:AddDoubleLine(private.tables.colNames[i], "|cffffffff" .. tostring(n[1]) .. "|r")
				end
			end
		end
		GameTooltip:Show()
	end
end

-- Hide Tooltip
GUI.debugLog_OnLeave = GUI.debugLog_OnLeave or {}
function GUI.debugLog_OnLeave.tables(btn, data)
	GUI:DebugPrintf("OnLeave: %s %s %s ", tostring(btn), tostring(data))

	if type(data) == "table" then
		GameTooltip:Hide()
		if BattlePetTooltip and BattlePetTooltip.Hide then
			BattlePetTooltip:Hide()
		end
	end

	GUI:SetStatusLine()
end

------------------------------------------------------------------------------
-- Create Tab

-- function GUI.CreateTablesTab(tab, vtab)
function GUI.CreateTablesTab(a, additionalUICB, forced)
	GUI:DebugPrintf("CreateTablesTab(%s)", tostring(a))

	if not a or type(a) ~= "string" then
		-- should not never happen!
		GUI:DebugPrintf("ERR~  missing tab name!")
		return
	end

	if GUI.guiTabs.select[a] and not forced then
		GUI:DebugPrintf("Tab %s exists.", tostring(a))
		return
	end

	-- create a new log format
	if not GUI.DebugLog_IsFormatRegistered("tables") or forced then
		GUI.DebugLog_RegisterFormat("tables", private.tables)
	end

	-- adjust default data widget parameters
	addon.db.global.showExport = true
	GUI.debugLog_defaultNoSelfTab = false
	GUI.debugLog_defaultTextSize = tonumber(addon.db.global.textSize) or 12
	GUI.debugLog_defaultHeight = 500
	GUI.debugLog_defaultWidth = 800
	GUI.debugLog_defaultSortTitle = 1

	-- create tab as custom debug log
	GUI.DebugLog_CreateTab(a, "tables", nil, additionalUICB)

	-- no need to have a timer
	GUI.guiTabs.timer[a] = nil

	GUI:DebugPrintf("WARN~Log for '" .. a .. "' created")
	-- no implicit Load()
	-- GUI:Load(a)

	GUI:DebugPrintf("  <<CreateTablesTab(%s)", tostring(a))
end

-- EOF
