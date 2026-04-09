------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- DebugLog.lua
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
--
------------------------------------------------------------------------------
-- DebugLog: Collect and View Debug Logs
--
-- Writing to debug logs during addon development is nice for finding bugs, but
-- the code to display the logs doesn't necessarily have to be in the addon itself.
--
-- The addon DebugLog is useful for this, it creates a separate window from
-- one or more scrollable, searchable debug logs.
--
-- If required, each log can be exported to CSV or HTML for later review.
--
-- Since the log content of each debug log is created in the memory space
-- of this addon, there is no bad memory impact of your addon if
-- the debug output is left switched on in your addon.
--
-- To write to a debug log just write:
--      if DLAPI then DLAPI.DebugLog(addonName, ...) end
-- where addonName is the name of your addon. If not already there, a new
-- log tab is created.
--
-- You can create addional tabs, e.g. a "Testing" tab by writing:
--      if DLAPI then DLAPI.DebugLog("Testing", ...) end
--
-- "..." can be anything that works correctly as argument for format():
--    "Debug this thinky."           (simple text)
--    "Value = %s", tostring(v)      (String with arg.)
--    L["Check this value: %d"], v   (Localized string with arg.)
--
-- Debug messages can have a category and/or a verbosity level, like
--    "UI~Debug message", "1~Debug message", "UI~3~Debug message" etc.
-- Verbosity levels are numbers from "1" to "9", a category may be
-- any short text string.
--
-- The Verbosity Level option (addon.db.global.maxVerbosity) is 6
-- by default and can be used to reduce some clutter.
--
-- The Time Format option (addon.db.global.timeFormat) is used to provide
-- the displayed time format (as valid argument for date(), e.g."%m-%d %H:%M:%S").
--
-- The interface is opened with /dl or by clicking on the LDB header (of Titan
-- Panel, Bazooka etc.)
--
-- Default log format -- the specification of the scroll table columns and
-- it's content -- can be changed to support other debug content.
--
-- See the example of the "short" format in GUI_debuglog_fmt.lua and how to
-- register other formats with DLAPI.RegisterFormat().
------------------------------------------------------------------------------
-- luacheck: ignore 212, globals DLAPI TEMPDLAPI debugWidgets WorldFrame

local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- General Settings

local GetAddOnMetadata = GetAddOnMetadata
if C_AddOns and C_AddOns.GetAddOnMetadata then
	GetAddOnMetadata = C_AddOns.GetAddOnMetadata
end

addon.METADATA = {
	NAME = GetAddOnMetadata(..., "Title"),
	VERSION = GetAddOnMetadata(..., "Version"),
	NOTES = GetAddOnMetadata(..., "Notes"),
}

------------------------------------------------------------------------------
-- Debug Stuff

function addon:DebugLog(...)
	-- debugging this addon by external instance
	if addonName == "__DebugLogTemp" then
		if addon.isDebug then
			addon.GUI.DebugLog(addonName, ...)
		end
	else
		if TEMPDLAPI then
			TEMPDLAPI.DebugLog(addonName, ...)
		elseif addon.isDebug then
			addon.GUI.DebugLog(addonName, ...)
		end
	end
end

function addon:DebugPrintf(...)
	if addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			addon:DebugLog(res)
		end
	end
end

------------------------------------------------------------------------------
-- Addon Initialization

-- called by AceAddon when Addon is fully loaded
function addon:OnInitialize()
	for modle in pairs(addon.modules) do
		addon[modle] = addon.modules[modle]
	end

	-- Register DLAPI
	addon.GUI.DebugLog_RegisterAPI()

	if DLAPI and DLAPI.SetFormat then DLAPI.SetFormat(addonName, "default") end
	addon:DebugPrintf("OnInitialize()")

	addon.handle = "dl"
	addon.isDebug = false

	addon.timerSec = 1

	if addonName == "__DebugLogTemp" then
		addon.handle = "dlt"
		addon.isDebug = false
	end

	-- loads data and options
	addon.db = AceDB:New(addonName .. "DB", addon.Options.defaults, true)
	AceConfigRegistry:RegisterOptionsTable(addonName, addon.Options.GetOptions)
	local optionsFrame = AceConfigDialog:AddToBlizOptions(addonName, GetAddOnMetadata(addonName, "Title"))
	addon.optionsFrame = optionsFrame

	-- initialize standard time format
	if addon.db.global.timeFormat == "default" then
		if (GetLocale() == "deDE") then
			addon.db.global.timeFormat = "%d.%m %H:%M:%S";
		else
			addon.db.global.timeFormat = "%m-%d %H:%M:%S";
		end
	end

	addon:RegisterChatCommand(addon.handle, function(param)
		local cmd, arg1 = addon:GetArgs(param, 2)

		if cmd then
			if cmd == "table" then
				if arg1 and _G[arg1] then
					addon.Tables:Load(tostring(arg1), _G[arg1])
				else
					addon.Printf("There is not table %s!", tostring(arg1))
				end
			end
		else
			if addon.GUI.display then
				addon.GUI.display:Fire("OnClose")
			else
				addon:ShowGUI()
			end
		end
		end)

	addon:RegisterChatCommand(addon.handle .. "c", function()
		addon.GUI.DebugLog_EnableChatEvents()
	end)
	addon:RegisterChatCommand(addon.handle .. "g", function()
		addon.Tables:Load("Globals", _G)
	end)
	addon:RegisterChatCommand(addon.handle .. "e", function()
		addon.GUI.DebugLog_EnableEvents("Events")
	end)
	addon:RegisterChatCommand(addon.handle .. "u", function()
		addon.Tables:Load("UIParent", { UIParent:GetChildren() })
	end)
	addon:RegisterChatCommand(addon.handle .. "w", function()
		addon.Tables:Load("WorldFrame", { WorldFrame:GetChildren() })
	end)
	addon:RegisterChatCommand(addon.handle .. "a", function()
		addon.AddOns:Load("AddOns")
	end)
end

function addon:ShowGUI()
	addon.GUI:Load()
end

-- called by AceAddon on PLAYER_LOGIN
function addon:OnEnable()
	addon:DebugPrintf("OnEnable()")
	addon:Printf("|cFF33FF99(" .. addon.METADATA.VERSION .. ")|r: " ..
		format(L["enter /%s for interface"], addon.handle))

	addon:DebugPrintf("Calling Login() in all modules")
	for modle in pairs(addon.modules) do
		if addon.modules[modle].Login then
			addon:DebugPrintf(" -> %s:Login()", modle)
			addon.modules[modle]:Login()
		end
	end
	addon:Login()

	-- initializing *:Logout loop
	addon:RegisterEvent("PLAYER_LOGOUT", function()
		addon:OnLogout()
		end)

	addon.sectimer = C_Timer.NewTicker(addon.timerSec, function() addon:SecTimer() end)
end

-- called on PLAYER_LOGOUT
function addon:OnLogout()
	-- loop through all modules calling *:Logout()
	addon:DebugPrintf("Calling Logout() in all modules")
	for modle in pairs(addon.modules) do
		if addon.modules[modle].Logout then
			addon:DebugPrintf(" -> %s:Logout()", modle)
			addon.modules[modle]:Logout()
		end
	end
end

------------------------------------------------------------------------------
-- Timers

-- loop through all module timers once a second
function addon:SecTimer()
	-- addon:DebugPrintf("SecTimer()")
	local oldDebug = addon.isDebug

	-- to disable debug during timers:
	--	addon.isDebug = false

	for modle in pairs(addon.modules) do
		if addon.modules[modle].SecTimer then
			addon.modules[modle]:SecTimer()
		end
	end

	addon.isDebug = oldDebug
end

------------------------------------------------------------------------------
-- Initialization at Login/Logout

function addon:Login()
	addon.GUI.DebugLog(addonName, "")
	addon.GUI.DebugLog(addonName, "OK~" .. addon.METADATA.NAME .. " v" .. addon.METADATA.VERSION .. "- " .. addon.METADATA.NOTES)
	addon.GUI.DebugLog(addonName, "")

	local wowV, wowP = GetBuildInfo()
	local wowVersion = "Game: WoW (ID " .. WOW_PROJECT_ID .. "), Version: " .. wowV .. ", Build: " .. wowP
	addon.GUI.DebugLog(addonName, wowVersion)

	-----------------------------------------------------
	-- debugging widgets by external instance
	if TEMPDLAPI and addonName ~= "__DebugLogTemp" then
		debugWidgets = debugWidgets or {}
		--[[
		debugWidgets.DLData = {}
		debugWidgets.DLData.tag = addonName
		debugWidgets.DLData.DLAPI = TEMPDLAPI
		]]
	end
	-----------------------------------------------------
end

-- EOF
