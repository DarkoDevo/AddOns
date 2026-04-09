------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLGUI_debuglog_fmt.lua - Default Debuglog Format
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals TEMPDLAPI issecretvalue

local addonName, addon = ...
local GUI = addon:GetModule("GUI")
local private = {}
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Settings

-- Default DebugLog Format
private = private or {}
private.default = {}
private.default.colNames = { "ID", "Time", "Cat", "Vrb", "Message", }
private.default.colWidth = { 0.05, 0.12, 0.05, 0.03, 1 - 0.05 - 0.12 - 0.05 - 0.03, }
private.default.colFlex = { "flex", "flex", "drop", "drop", "search", }
private.default.statusText = {
			"Sort by ID",
			"Sort by Time",
			"Sort by Category",
			"Sort by Verbosity",
			"Sort by Message",
		}
private.default.GetSTData = function(...) return private.GetSTData_default(...) end

-- Short DebugLog Format
private.short = {}
private.short.colNames = { "ID", "Time", "Cat", "Vrb", "Messag", }
private.short.colWidth = { 0.05, 0.12, 0.05, 0.03, 1 - 0.05 - 0.12 - 0.05 - 0.03, }
private.short.colFlex = { "flex", "flex", "", "", "search", }
private.short.statusText = {
			"Sort by ID",
			"Sort by Time",
			"Sort by Category",
			"Sort by Verbosity",
			"Sort by Message",
		}
private.short.GetSTData = function(...) return private.GetSTData_default(...) end

local issecretvalue = issecretvalue or function(_) return false end

------------------------------------------------------------------------------
-- Get Scrolling Table Data

function private.GetSTData_default(a, flex, filter)
	private.DebugPrintf("GetSTData_default(%s, %s, %s)", tostring(a), tostring(flex), tostring(filter))

	-- generate content only if visible
	if not GUI.display or GUI.view ~= a then
		private.DebugPrintf("... nothing done.")
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
	for _, rdata in pairs(addon.debuglog[a]) do
		local filterMatch = nil  -- = nil -> no filter input = true -> filtered

		local data = {}
		data[2] = rdata.t
		data[3] = nil
		data[4] = nil
		data[5] = rdata.m or ""

		local q = "ffffff"

		-- 12.x: check for secret strings and print them in the chat
		if issecretvalue(data[5]) then
			DEFAULT_CHAT_FRAME:AddMessage("ID " .. tostring(k) .. " (secret) " .. data[5]);
			data[5] = "ERR~<SECRET STRING> (see chat!)"
		end

		local flag = strmatch(data[5], "^([^~]+)~")
		while flag do
			data[5] = strmatch(data[5], "^[^~]+~(.*)$")

			if strmatch(flag, "^(ERR)") then
				q = "ff8888"
			elseif strmatch(flag, "^(OK)") then
				q = "88ff88"
			elseif strmatch(flag, "^(WARN)") then
				q = "8888ff"
			elseif strmatch(flag, "^([0-9]+)") then
				data[4] = flag
			elseif strmatch(flag, "^(.+)") then
				data[3] = flag
			end
			flag = strmatch(data[5], "^([^~]+)~")
		end

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

		if addon.db and addon.db.global and addon.db.global.maxVerbosity and data[4] then
			if tonumber(data[4]) and tonumber(addon.db.global.maxVerbosity) and
				tonumber(data[4]) > tonumber(addon.db.global.maxVerbosity) then
					filterMatch = false
			end
		end

		if filterMatch or filterMatch == nil then
			data[5] = data[5] .. "\n"
			data[5]:gsub("([^\n]*)\n",
				function(j)
					local en = {}
					en.data = {}

					en.data[1] = {k, k}
					en.data[2] = {GUI.DebugLog_TimeToString(data[2]), data[2]}
					en.data[3] = {data[3], data[3] or ""}
					en.data[4] = {data[4], data[4] or ""}
					en.data[5] = {"|cff" .. q .. j .. "|r", j}
					tinsert(content, en)
					k = k + 1
				end
			)
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

function private.DebugPrintf(...)
	if TEMPDLAPI and TEMPDLAPI.DebugLog and addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			TEMPDLAPI.DebugLog(addonName, "GUI~" .. res)
		end
	end
end

------------------------------------------------------------------------------
-- Register the formats defined in this file

GUI.DebugLog_RegisterFormat("default", private.default)
GUI.DebugLog_RegisterFormat("short", private.short)

-- EOF
