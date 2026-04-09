------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLTables.lua - Tables Data
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals TEMPDLAPI issecretvalue

local _, addon = ...
local Tables = addon:NewModule("Tables", "AceEvent-3.0", "AceConsole-3.0")
local private = {}
-------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Debug Stuff

function Tables:DebugPrintf(...)
	if addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			addon:DebugLog("Tbl~" .. res)
		end
	end
end

local issecretvalue = issecretvalue or function(_) return false end

------------------------------------------------------------------------------
-- Enable Tables

function Tables:Login()
	Tables:DebugPrintf("Login()")

	-- we are using the debugLog environment
	addon.debuglog = addon.debuglog or {}

	Tables:DebugPrintf("  <<Login()")
end

function Tables:Logout()
end

function Tables:SetRebuildUI()
	private.rebuildUI = true
end

-- Create Tab, Fill Data, Show UI
function Tables:Load(tab, aTable)
	Tables:DebugPrintf("Load(%s, %s)", tostring(tab), tostring(aTable))

	local list = tab
	if not tab then
		if not list then
			Tables:DebugPrintf("ERR~  tab is nil")
			return
		else
			Tables:DebugPrintf("  use list %s", tostring(list))
		end
	end

	local theTab = tab or list

	-- create Log/Tab if not present
	if not addon.debuglog[theTab] or private.rebuildUI then
		Tables:DebugPrintf("  no log %s", tostring(theTab))

		-- flag tab for reload
		if private.rebuildUI then
			Tables:DebugPrintf("  rebuildUI for %s: #addon.GUI.guiTabs.order = %s", tostring(theTab), tostring(#addon.GUI.guiTabs.order))
			local thisName
			for i, name in ipairs(addon.GUI.guiTabs.order) do
				Tables:DebugPrintf("  rebuildUI for %s: i=%s, name=%s", tostring(theTab), tostring(i), tostring(name))
				if name and name == theTab then
					thisName = i
				end
			end
			if thisName then
				Tables:DebugPrintf("  rebuildUI for %s: tab num %s", tostring(theTab), tostring(thisName))
				table.remove(addon.GUI.guiTabs.order, thisName)
			else
				Tables:DebugPrintf("ERR~  rebuildUI for %s: no tab num found!", tostring(theTab))
			end
		end

		addon.GUI.CreateTablesTab(theTab, nil, private.rebuildUI)
	else
		-- to show this tab in GUI:Load()
		addon.GUI.guiTabs.lastSelected = theTab
		Tables:DebugPrintf("  log %s", tostring(theTab))
	end

	private.rebuildUI = false

	-- put data into the log
	Tables:FillLogFromTable(theTab, aTable)

	-- show the GUI
	Tables:DebugPrintf("  -> GUI:Load(%s)", tostring(theTab))
	addon.GUI:Load(theTab)

	if addon.GUI.debugLog_colCtrl[theTab] and addon.GUI.debugLog_colCtrl[theTab].w then
		addon.GUI.debugLog_lastSortTitle[theTab] = addon.GUI.debugLog_colCtrl[theTab].w:GetSortTitle()
		-- addon:Printf("set GUI.debugLog_lastSortTitle[%s] = %s", tostring(theTab), tostring(addon.GUI.debugLog_lastSortTitle[theTab]))
	end
	Tables:DebugPrintf("  <<Load(%s)", tostring(theTab))
end

------------------------------------------------------------------------------
-- Fill Log from Table

function Tables:FillLogFromTable(tab, aTable)
	Tables:DebugPrintf("FillLogFromTable(%s)", tostring(tab))
	if not tab then
		Tables:DebugPrintf("ERR~  tab is nil")
		return
	end

	addon.GUI.DebugLog_Reset(tab)

	addon.debuglog[tab] = {}
	local vtab = aTable
		if vtab then
		for n, v in pairs(vtab) do
			if strmatch(n, "^Store") or strmatch(n, "^WowToken") or strmatch(n, "^SecureTransfer")
				or strmatch(n, "^ServicesLogout") or strmatch(n, "^AuthChallenge")
				or strmatch(n, "^SimpleCheck") or strmatch(n, "^_DevLoc") or strmatch(n, "^TradePlayer")
				or strmatch(n, "^CommunitiesCreate") or strmatch(n, "^CommunitiesAdd")
				or strmatch(n, "^PingFrame") or strmatch(n, "^PingListenerFrame") or strmatch(n, "^ClassTrialSecure") then
				local en = {}
				en[3] = tostring(n)
				tinsert(addon.debuglog[tab], en)
			else
				local en = {}
				en[2] = type(v)
				en[3] = tostring(n)
				if v and en[2] == "table" then
					en[20] = v -- saved for OnClick handler
					en[4] = strmatch(tostring(v), "table: ([0-9A-Z]+)") or ""
					en[5] = private.tryCall("GetObjectType", v) or ""
					en[6] = private.tryCall("GetName", v) or ""
				elseif v and en[2] == "function" then
					en[4] = strmatch(tostring(v), "function: ([0-9A-Z]+)") or ""
				elseif v and en[2] == "userdata" then
					en[4] = strmatch(tostring(v), "userdata: ([0-9A-Z]+)") or ""
				else
					en[7] = tostring(v)
				end
				tinsert(addon.debuglog[tab], en)
			end
		end
		local meta = getmetatable(vtab)
		if meta and meta.__index then
			meta = meta.__index
			local en = {}
			en[2] = type(meta)
			en[3] = "metatable.__index"
			if meta and en[2] == "table" then
				en[20] = meta -- safed for OnClock handler
				en[4] = strmatch(tostring(meta), "table: ([0-9A-Z]+)") or ""
				en[5] = private.tryCall("GetObjectType", meta) or ""
				en[6] = private.tryCall("GetName", meta) or ""
				tinsert(addon.debuglog[tab], en )
			end
		end
	end

	Tables:DebugPrintf("  <<FillLogFromTable(%s)", tostring(tab))
end

function private.tryCall(func, v)
	if not func or type(v) ~= "table" then
		return ""
	end

	-- 12.x: check for secrets
	if issecretvalue(v) or issecrettable(v) then
		return "?! <SECRET>"
	end

	-- not safe to index it
	local mt = getmetatable(v)
	if mt and type(mt) == "table" and type(mt.__index) == "function" then
		return "?! metatable"
	end

	-- dont't call from insecure
	if v.IsForbidden then
		local status, res = pcall(v.IsForbidden, v)
		if status then
			if res then
				return "?! IsForbidden!"
			end
		else
			return "?! Error calling IsForbidden"
		end
	end

	local f = func
	if (type(f) ~= "table") then
		f = v[f]
	end

	-- has function
	if not f or type(f) ~= "function" then
		return ""
	end

	local status, res = pcall(f, v)
	if status then
		return res
	else
		return "?! " .. tostring(res)
	end
end

-- EOF
