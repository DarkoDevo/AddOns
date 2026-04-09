------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLGUI_debuglog_fmt_addons.lua - Debug Log Format for AddOns
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals TEMPDLAPI

local addonName, addon = ...
local GUI = addon:GetModule("GUI")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local private = {}
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Settings

-- addons Debug Log Format
private.addons = {}
private.addons.colNames = { "ID",   "Name",  "Title", "Version", "Enabled", "Loadable",  "Reason",  "Secure", }
private.temp = 1            -0.05   -0.2    -0.3      -0.15      -0.05       -0.05       -0.10
private.addons.colWidth = {  0.05,   0.2,    0.3,      0.15,      0.05,      0.05,       0.10,      private.temp, }
private.addons.colFlex  = { "flex", "flex", "flex",   "flex",    "flex",    "flex",     "flex",     "search", }
private.addons.statusText = {
			"Sort by ID",
			"Sort by Name",
			"Sort by Title",
			"Sort by Version",
			"Sort by Enabled",
			"Sort by Loadable",
			"Sort by Reason",
			"Sort by Security",
		}
private.addons.GetSTData = function(...) return private.GetSTData_addons(...) end

------------------------------------------------------------------------------
-- Scrolling Table Data

-- Return Scrolling Table Data
function private.GetSTData_addons(a, flex, filter)
	GUI:DebugPrintf("GetSTData_addons(%s, %s, %s) private.temp=%s", tostring(a), tostring(flex), tostring(filter), tostring(private.temp))

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

			en.data = {}
--			en[1] = j
			en.data[1] = {tostring(data[1]), tonumber(data[1]) or 0}

--			en[2] = tostring(v.Name)
			en.data[2] = {tostring(data[2]), data[2] or ""}
			if (C_AddOns and C_AddOns.IsAddOnLoaded) then
				if C_AddOns.IsAddOnLoaded(tostring(data[2])) then
					en.data[2][1] = ITEM_QUALITY_COLORS[2].hex .. en.data[2][1] .. FONT_COLOR_CODE_CLOSE
				else
					en.data[2][1] = ITEM_QUALITY_COLORS[1].hex .. en.data[2][1] .. FONT_COLOR_CODE_CLOSE
				end
			end
			if _G[tostring(data[2])] and _G[tostring(data[2]) .. "DB"] then
				en.data[2][1] = en.data[2][1] .. " (DB/*)"
			elseif _G[tostring(data[2])] then
				en.data[2][1] = en.data[2][1] .. " (*)"
			elseif _G[tostring(data[2]) .. "DB"] then
				en.data[2][1] = en.data[2][1] .. " (DB)"
			end

--			en[3] = tostring(v.Title)
--			en[4] = tostring(v.TitleText)
			en.data[3] = {tostring(data[4]), data[3] or ""}
--			en[5] = tostring(v.Version)
			en.data[4] = {tostring(data[5]), data[5] or ""}
--			en[6] = tostring(v.Enabled)
			en.data[5] = {tostring(data[6]), data[6] or ""}
			if C_AddOns and C_AddOns.DoesAddOnHaveLoadError then
				if C_AddOns.DoesAddOnHaveLoadError(en.data[2][2]) then
					en.data[5][1] = en.data[5][1] .. "/" .. L["we"]
				end
			end

--			en[7] = tostring(v.Loadable)
			en.data[6] = {tostring(data[7]), data[7] or ""}
--			en[8] = tostring(v.Reason)
			en.data[7] = {tostring(data[8]), data[8] or ""}
--			en[9] = tostring(v.Security)
			en.data[8] = {tostring(data[9]), data[9] or ""}

--			en[20] = v
			if data[20] and type(data[20]) == "table" then
				en.en = data
			end

			tinsert(content, en)
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
function GUI.debugLog_OnClick.addons(btn, data, button)
	GUI:DebugPrintf("OnClick: %s %s %s ", tostring(btn), tostring(data), tostring(button))

	if not data then return end
	local name = tostring(data.data[2][2])
	if name and name ~= "" then
		local tab = {}
		if button == "LeftButton" then
			if _G[name .. "DB"] then
				tab[name .. "DB"] = _G[name .. "DB"]
				addon.Tables:Load(tostring(GUI.view) .. " | " .. name .. "DB", tab)
			else
				addon:Printf(L["AddOn does not expose a "] .. name .. "DB.")
			end
		elseif button == "RightButton" then
			if _G[name] then
				tab[name] = _G[name]
				addon.Tables:Load(tostring(GUI.view) .. " | " .. name, tab)
			else
				addon:Printf(L["AddOn does not expose his namespace."])
			end
		end
	end
end

-- Provide tooltip on content button
GUI.debugLog_OnEnter = GUI.debugLog_OnEnter or {}
function GUI.debugLog_OnEnter.addons(btn, data)
	GUI:DebugPrintf("OnEnter: %s %s %s ", tostring(btn), tostring(data))

	if btn.btnCnt then
		GUI:SetStatusLine(GUI.container.titleStatusText[btn.btnCnt])
	else
		if type(data) == "table" and data.en then
			GUI:SetStatusLine("Click left to show addon variable in new tab, right to show addon name global table.")
		end

		GameTooltip:SetOwner(btn, "ANCHOR_TOPLEFT")
		GameTooltip:ClearLines()
		for i, n in ipairs(data.data) do
			if i > 1 then
				if n[2] and n[2] ~= "" then
					GameTooltip:AddDoubleLine(private.addons.colNames[i], "|cffffffff" .. tostring(n[1]) .. "|r")
				end
			end
		end
		GameTooltip:Show()
	end
end

-- Hide Tooltip
GUI.debugLog_OnLeave = GUI.debugLog_OnLeave or {}
function GUI.debugLog_OnLeave.addons(btn, data)
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

-- function GUI.CreateAddOnsTab(tab, vtab)
function GUI.CreateAddOnsTab(a, additionalUICB, forced)
	GUI:DebugPrintf("CreateAddOnsTab(%s)", tostring(a))

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
	if not GUI.DebugLog_IsFormatRegistered("addons") or forced then
		GUI.DebugLog_RegisterFormat("addons", private.addons)
	end

	-- adjust default data widget parameters
	addon.db.global.showExport = true
	GUI.debugLog_defaultNoSelfTab = false
	GUI.debugLog_defaultTextSize = tonumber(addon.db.global.textSize) or 12
	GUI.debugLog_defaultHeight = 500
	GUI.debugLog_defaultWidth = 800
	GUI.debugLog_defaultSortTitle = 1

	-- create tab as custom debug log
	GUI.DebugLog_CreateTab(a, "addons", nil, additionalUICB)

	-- no need to have a timer
	GUI.guiTabs.timer[a] = nil

	-- GUI:Printf("WARN~Log for '" .. a .. "' created")
	-- no implicit Load()
	-- GUI:Load(a)

	GUI:DebugPrintf("  <<CreateAddOnsTab(%s)", tostring(a))
end

-- EOF
