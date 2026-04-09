------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLAddOns.lua - AddOns Data
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: ignore 212 globals TEMPDLAPI

local _, addon = ...
local AddOns = addon:NewModule("AddOns", "AceEvent-3.0", "AceConsole-3.0")
local private = {}
-------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Debug Stuff

function AddOns:DebugPrintf(...)
	if addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			addon:DebugLog("Tbl~" .. res)
		end
	end
end

------------------------------------------------------------------------------
-- Enable AddOns

function AddOns:Login()
	AddOns:DebugPrintf("Login()")

	-- we are using the debugLog environment
	addon.debuglog = addon.debuglog or {}

	AddOns:DebugPrintf("  <<Login()")
end

function AddOns:Logout()
end

function AddOns:SetRebuildUI()
	private.rebuildUI = true
end

-- Create Tab, Fill Data, Show UI
function AddOns:Load(tab)
	AddOns:DebugPrintf("Load(%s)", tostring(tab))

	local theTab = tab or "AddOns"

	-- create Log/Tab if not present
	if not addon.debuglog[theTab] or private.rebuildUI then
		AddOns:DebugPrintf("  no log %s", tostring(theTab))

		-- flag tab for reload
		if private.rebuildUI then
			AddOns:DebugPrintf("  rebuildUI for %s: #addon.GUI.guiTabs.order = %s", tostring(theTab), tostring(#addon.GUI.guiTabs.order))
			local thisName
			for i, name in ipairs(addon.GUI.guiTabs.order) do
				AddOns:DebugPrintf("  rebuildUI for %s: i=%s, name=%s", tostring(theTab), tostring(i), tostring(name))
				if name and name == theTab then
					thisName = i
				end
			end
			if thisName then
				AddOns:DebugPrintf("  rebuildUI for %s: tab num %s", tostring(theTab), tostring(thisName))
				table.remove(addon.GUI.guiTabs.order, thisName)
			else
				AddOns:DebugPrintf("ERR~  rebuildUI for %s: no tab num found!", tostring(theTab))
			end
		end

		addon.GUI.CreateAddOnsTab(theTab, nil, private.rebuildUI)
	else
		-- to show this tab in GUI:Load()
		addon.GUI.guiTabs.lastSelected = theTab
		AddOns:DebugPrintf("  log %s", tostring(theTab))
	end

	private.rebuildUI = false

	-- put data into the log
	AddOns:FillLogFromAddOnCache(theTab)

	-- show the GUI
	AddOns:DebugPrintf("  -> GUI:Load(%s)", tostring(theTab))
	addon.GUI:Load(theTab)

	if addon.GUI.debugLog_colCtrl[theTab] and addon.GUI.debugLog_colCtrl[theTab].w then
		addon.GUI.debugLog_lastSortTitle[theTab] = addon.GUI.debugLog_colCtrl[theTab].w:GetSortTitle()
		-- addon:Printf("set GUI.debugLog_lastSortTitle[%s] = %s", tostring(theTab), tostring(addon.GUI.debugLog_lastSortTitle[theTab]))
	end
	AddOns:DebugPrintf("  <<Load(%s)", tostring(theTab))
end

------------------------------------------------------------------------------
-- Fill Log from Table

function AddOns:FillLogFromAddOnCache(tab)
	AddOns:DebugPrintf("FillLogFromAddOnCache(%s)", tostring(tab))
	if not tab then
		AddOns:DebugPrintf("ERR~  tab is nil")
		return
	end

	addon.GUI.DebugLog_Reset(tab)

	addon.debuglog[tab] = {}

	local vtab = {}
	local vtabKey

	if addon.CacheAddOns then
		vtab = addon.CacheAddOns:GetCache()
		vtabKey = addon.CacheAddOns:GetKey()
		vtab = vtab[vtabKey].data.tab1
	end

	if vtab then
		for j, v in pairs(vtab) do
			local en = {}
			en[1] = j
			en[2] = tostring(v.Name)
			en[3] = tostring(v.Title)
			en[4] = tostring(v.TitleText)
			en[5] = tostring(v.Version)
			en[6] = tostring(v.Enabled)
			en[7] = tostring(v.Loadable)
			en[8] = tostring(v.Reason)
			en[9] = tostring(v.Security)
			en[20] = v
			tinsert(addon.debuglog[tab], en)
		end
	end

	AddOns:DebugPrintf("  <<FillLogFromAddOnCache(%s)", tostring(tab))
end

-- EOF
