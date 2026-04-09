------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLOptions.lua - Addon Options
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: ignore 212

local addonName, addon = ...
local Options = addon:NewModule("Options", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LibDBIcon = LibStub("LibDBIcon-1.0")
--------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Deprecated Stuff

local GetAddOnMetadata = GetAddOnMetadata
if C_AddOns and C_AddOns.GetAddOnMetadata then
	GetAddOnMetadata = C_AddOns.GetAddOnMetadata
end

------------------------------------------------------------------------------
-- Settings

Options.defaults = {
	profile = {
	},
	global = {
		showMinimapButton = true,
		timeFormat = "default",
		maxVerbosity = "6",
		showExport = false,
		textSize = "12",
		minimap = {
			hide = false,
		},
	},
}

Options.timeFormat = {}
Options.timeFormat["ago"]  = L["_ Hr. _ Min. ago"]
Options.timeFormat["%d.%m %H:%M:%S"] = "DD.MM HH:MM"
Options.timeFormat["%m/%d %H:%M:%S"] = "MM/DD HH:MM"
Options.timeFormat["%m-%d %H:%M:%S"] = "MM-DD HH:MM"

Options.textSizes = {}
Options.textSizes["10"]  = "10"
Options.textSizes["11"]  = "11"
Options.textSizes["12"]  = "12"
Options.textSizes["13"]  = "13"

------------------------------------------------------------------------------
-- Debug Stuff

function Options:DebugPrintf(...)
	if addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			addon:DebugLog("Opt~" .. res)
		end
	end
end

------------------------------------------------------------------------------
-- Addon Loading / Player Login/Logout

function Options.GetOptions(uiType, uiName, appName)
	if appName == addonName then

		local wowV, wowP = GetBuildInfo()
		local wowVersion = "|nGame: WoW (ID " .. WOW_PROJECT_ID .. "), Version: " .. wowV .. ", Build: " .. wowP

		local options = {
			type = "group",
			name = addon.METADATA.NAME .. " (" .. addon.METADATA.VERSION .. ")",
			get = function(info)
					return addon.db.global[info[#info]] or ""
				end,
			set = function(info, value)
					addon.db.global[info[#info]] = value
					Options:DebugPrintf("OK~Set %s = %s", tostring(info[#info]), tostring(value))
					if addon.GUI.display then
						addon.GUI.container:Reload()
					end
				end,
			args = {
				desc0 = {
					type = "description",
					order = 0,
					name = "|cff99ccff-: by " .. GetAddOnMetadata(addonName, "Author") .. " :-|r|n|n" .. GetAddOnMetadata(addonName, "Notes"),
					fontSize = "medium",
				},
				desc001 = {
					type = "description",
					order = 0.01,
					name = wowVersion,
				},
				header100 = {
					type = "header",
					name = L["UI"],
					order = 1.00,
				},
				showMinimapButton = {
					type = "toggle",
					name = L["Show Minimap Button"],
					desc = L["If checked, the minimap button is present."],
					order = 1.001,
					width = "double",
					get = function(info) return addon.db.global[info[#info]] end,
					set = function(info, value)
							addon.db.global[info[#info]] = value
							if value then
								LibDBIcon:Show(addonName)
							else
								LibDBIcon:Hide(addonName)
							end
							Options:DebugPrintf("OK~Set %s = %s", tostring(info[#info]), tostring(value))
						end,
				},
				desc102 = {
					type = "description",
					order = 1.002,
					name = L["|cffff8888Changing the font size causes an user interface reload!|r"],
					fontSize = "medium",
				},
				textSize = {
					type = "select",
					style = "dropdown",
					name = L["Font Size"],
					desc = L["Choose the font size. Changing the size causes an user interface reload!"],
					order = 1.003,
					width = "double",
					values = Options.textSizes,
					set = function(info, value)
						addon.db.global[info[#info]] = value
						Options:DebugPrintf("OK~Set %s = %s", tostring(info[#info]), tostring(value))
						ReloadUI()
					end
				},
				header200 = {
					type = "header",
					name = L["Misc."],
					order = 2.00,
				},
				timeFormat = {
					type = "select",
					style = "dropdown",
					name = L["Time Format"],
					desc = L["Select the format to display times."],
					order = 2.001,
					width = "double",
					values = Options.timeFormat,
				},
				maxVerbosity = {
					type = "input",
					name = L["Max. Verbosity Level"],
					desc = L["Select the maximum verbosity level to show up in the log. Values: 1 to 9. Default: 6."],
					order = 2.01,
					width = "double",
					validate = function(info, value)
						if tonumber(value) and tonumber(value) >= 1 and tonumber(value) <= 9 then
							addon.db.global[info[#info]] = value
							return true
						end
						return false
					end,
				},
				showExport = {
					type = "toggle",
					name = L["Show Search/Export"],
					desc = L["If checked, search and export is always displayed, regardless of the lack of categories/verbosity."],
					order = 2.02,
					width = "double",
					get = function(info) return addon.db.global[info[#info]] end,
				},
			},
		}

		return options
	end
end

-- EOF
