------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLGUI_debuglog_api.lua - DebugLog Formats API
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
--
------------------------------------------------------------------------------
-- Notice @me when using this debug log in my other addons:
--
-- a) put GUI_debuglog_tab.lua and ..._fmt.lua in .toc file
-- b) use equivalent GUI environment
-- d) set proper widgets with GUI.DebugLog_SetWidgets()
-- d) provide global options addon.db.global.timeFormat/maxVerbosity/showExport
-- e) define / register log formats with GUI.DebugLog_RegisterFormat()
------------------------------------------------------------------------------
-- luacheck: ignore 212, globals DLAPI TEMPDLAPI

local addonName, addon = ...
local GUI = addon:GetModule("GUI")

------------------------------------------------------------------------------
-- DebugLog / DLAPI

-- called by _DebugLog/DebugLog.lua in :OnInitialize()
function GUI.DebugLog_RegisterAPI()
	-- check if this is the real _DebugLog addon
	if not DLAPI then
		if addonName == "_DebugLog" then
			-- register as DLAPI
			addon:Printf("DLAPI registered")
			DLAPI = {}

			DLAPI.RegisterFormat = GUI.DebugLog_RegisterFormat
			DLAPI.IsFormatRegistered = GUI.DebugLog_IsFormatRegistered
			DLAPI.SetFormat = GUI.DebugLog_SetFormat
			DLAPI.GetFormat = GUI.DebugLog_GetFormat
			DLAPI.DebugLog = GUI.DebugLog
			DLAPI.Reset = GUI.DebugLog_Reset
			DLAPI.TimeToString = GUI.DebugLog_TimeToString
			DLAPI.GetColCtrl = GUI.DebugLog_GetColCtrl

			DLAPI.EnableChatEvents = GUI.DebugLog_EnableChatEvents
		end
	end
	if not TEMPDLAPI then
		if addonName == "__DebugLogTemp" then
			-- register as TEMPDLAPI
			addon:Printf("TEMPDLAPI registered")
			TEMPDLAPI = {}

			TEMPDLAPI.RegisterFormat = GUI.DebugLog_RegisterFormat
			TEMPDLAPI.IsFormatRegistered = GUI.DebugLog_IsFormatRegistered
			TEMPDLAPI.SetFormat = GUI.DebugLog_SetFormat
			TEMPDLAPI.GetFormat = GUI.DebugLog_GetFormat
			TEMPDLAPI.DebugLog = GUI.DebugLog
			TEMPDLAPI.Reset = GUI.DebugLog_Reset
			TEMPDLAPI.TimeToString = GUI.DebugLog_TimeToString
			TEMPDLAPI.GetColCtrl = GUI.DebugLog_GetColCtrl

			TEMPDLAPI.EnableChatEvents = GUI.DebugLog_EnableChatEvents
		end
	end
end

-- EOF
