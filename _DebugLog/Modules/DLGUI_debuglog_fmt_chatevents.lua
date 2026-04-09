------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLGUI_debuglog_fmt_chatevents.lua - CHAT_MSG Debug Log Format
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals TEMPDLAPI ChatFrame_OnEvent

local addonName, addon = ...
local GUI = addon:GetModule("GUI")
local private = {}
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Settings

-- CHAT_MSG Debug Log Format
private.chatevents = {}
private.chatevents.colNames = { "ID", "Time", "Event", "Message", }
private.chatevents.colWidth = { 0.05, 0.12, 0.2, 1 - 0.05 - 0.12 - 0.2, }
private.chatevents.colFlex = { "flex", "flex", "drop", "search", }
private.chatevents.statusText = {
			"Sort by ID",
			"Sort by Time",
			"Sort by Event",
			"Sort by Message",
		}
private.chatevents.GetSTData = function(...) return private.GetSTData_chatevents(...) end

------------------------------------------------------------------------------
-- Get Scrolling Table Data

function private.GetSTData_chatevents(a, flex, filter)
	private.DebugPrintf("GetSTData_chatevents(%s, %s, %s)", tostring(a), tostring(flex), tostring(filter))

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
		data[4] = rdata.m or ""
		local q = "ffffff"
		local flag = strmatch(data[4], "^([^~]+)~")
		while flag do
			data[4] = strmatch(data[4], "^[^~]+~(.*)$")

			if strmatch(flag, "^(ERR)") then
				q = "ff8888"
			elseif strmatch(flag, "^(OK)") then
				q = "88ff88"
			elseif strmatch(flag, "^(WARN)") then
				q = "8888ff"
			elseif strmatch(flag, "^(WARN)") then
				q = "8888ff"
			elseif strmatch(flag, "^(.+)") then
				data[3] = flag
			end
			flag = strmatch(data[4], "^([^~]+)~")
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

		if filterMatch or filterMatch == nil then
			data[4] = data[4] .. "\n"
			data[4]:gsub("([^\n]*)\n",
				function(j)
					local en = {}
					en.data = {}

					en.data[1] = {k, k}
					en.data[2] = {GUI.DebugLog_TimeToString(data[2]), data[2]}
					en.data[3] = {data[3], data[3] or ""}
					en.data[4] = {"|cff" .. q .. j .. "|r", j}
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
-- CHAT_MSG
function GUI.DebugLog_EnableChatEvents(tab)
	if not GUI.DebugLog_IsFormatRegistered("chatevents") then
		GUI.DebugLog_RegisterFormat("chatevents", private.chatevents)
	end

	-- finding tab name
	local a = "Chat Events"
	if tab and type(tab) == "string" then
		a = tab
	end

	if GUI.guiTabs.timer[a] then
		GUI:Load(a)
		return
	end

	-- find free tab name
	while GUI.guiTabs.timer[a] do
		a = a .. "*"
	end

	GUI.DebugLog_CreateTab(a, "chatevents")

	if addon.DebugLog then
		addon:DebugLog("WARN~Log for '" .. a .. "' created")
	end

	private.antiLoop = private.antiLoop or {}
	private.lastMessage = private.lastMessage or {}

	if ChatFrame_OnEvent then
		-- < 12.x
		hooksecurefunc("ChatFrame_OnEvent", function(self, event, ...)
			if private.antiLoop[a] then
				return
			end
			private.antiLoop[a] = true

			local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...;

			local message = format("%s~1=%s 2=%s 3=%s 4=%s 5=%s 6=%s 7=%s 8=%s 9=%s", tostring(event),
				tostring(arg1), tostring(arg2), tostring(arg3), tostring(arg4), tostring(arg5), tostring(arg6), tostring(arg7), tostring(arg8), tostring(arg9))

			if private.lastMessage[a] == nil or message ~= private.lastMessage[a] then
				GUI.DebugLog(a, message or "")
				private.lastMessage[a] = message
			end
			private.antiLoop[a] = false
		end)
	end

	GUI:Load(a)
end

-- EOF
