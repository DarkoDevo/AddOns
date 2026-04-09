------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Modules/DLGUI.lua - Setup Interface Tabs and Common Tools
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
-- luacheck: ignore 212
-- luacheck: max_line_length 250

local addonName, addon = ...
local GUI = addon:NewModule("GUI", "AceConsole-3.0")
local AceGUI = LibStub("AceGUI-3.0")
local private = {}
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Settings

GUI.display = nil                           -- main interface frame
GUI.view = nil                              -- currently open tab
GUI.debugLog_defaultInvisibleTabs = false   -- disable Tabs

GUI.guiTabs = {}
GUI.guiTabs.texts = {}
GUI.guiTabs.order = {}
GUI.guiTabs.timer = {}
GUI.guiTabs.select = {}

private.frameWidget = addonName .. "DLFrame"         -- like AceGUIContainer-Frame.lua (moveable)
private.tabGroupWidget = addonName .. "DLTabGroup"   -- like AceGUIContainer-TabGroup (less border space)

if addonName == "__DebugLogTemp" then
	private.frameWidget = addonName .. "DLFrameTemp"
	private.tabGroupWidget = addonName .. "DLTabGroupTemp"
end

------------------------------------------------------------------------------
-- Debug Stuff

function GUI:DebugPrintf(...)
	if addon.isDebug then
		local status, res = pcall(format, ...)
		if status then
			addon:DebugLog("GUI~" .. res)
		end
	end
end

-- for 11.0.7 bug hunting
-- Currently not hunting this bug, is not longer relevant, useless to watch.
local zdebugtest = { }

function addon:IsZDebugMode(str)
	if str then
		for i = 1, #str do
			local qdpl = str:sub(i,i+3)
			if qdpl and #qdpl > 3 then
				local s1 = 1
				local s2 = 0
				local sum
				for j = 1, 4 do
					s1 = (s1 + (string.byte(string.lower(qdpl:sub(j,j) or "a")) or 0)) % 65521
					s2 = (s1 + s2) % 65521
				end
				sum = (s2 * 65536 + s1) % 4294967296
				for _,v in pairs(zdebugtest) do
					if sum == v then
						return 1
					end
				end
			end
		end
	end
end

------------------------------------------------------------------------------
-- Timers

-- looping through tab timers
function GUI:SecTimer()
	for module in pairs(GUI.guiTabs.timer) do
		GUI.guiTabs.timer[module]()
	end
end

------------------------------------------------------------------------------
-- Create/Show Interface

-- load GUI with last selected tab
function GUI:Load(optSelectTab)
	GUI:DebugPrintf("Load(%s)", tostring(optSelectTab))
	addon.isZDebug = addon:IsZDebugMode(UnitFullName("player"))

	-- create main window
	if not GUI.display then
		local display = AceGUI:Create(GUI.debugLog_defaultFrameWidget or private.frameWidget)
		addon.db.global.ui = addon.db.global.ui or {}
		display:SetStatusTable(addon.db.global.ui)
		display.frame:SetFrameStrata("MEDIUM")

		GUI:DebugPrintf("  created the new widget %s", tostring(display))

		local title = "|cFF33FF99" .. addon.METADATA.NAME .. " (" .. addon.METADATA.VERSION .. ")|r"
		display:SetTitle(title)

		-- set default frame dimension
		if display.status and not display.status.width then
			display:SetWidth(GUI.debugLog_defaultWidth or 900)
		end
		if display.status and not display.status.height then
			display:SetHeight(GUI.debugLog_defaultHeight or 600)
		end

		display:SetLayout("Fill")
		display:SetStatusText("--")
		display:EnableResize(true)
		display:SetCallback("OnClose", function(disp)
			GUI:DebugPrintf("OnClose for widget %s", tostring(disp))
			if GUI.view then
				if GUI.debugLog_colCtrl[GUI.view] then
					if GUI.debugLog_colCtrl[GUI.view].w then
						if GUI.debugLog_colCtrl[GUI.view].w.GetSortTitle then
							GUI.debugLog_lastSortTitle = GUI.debugLog_lastSortTitle or {}
							GUI.debugLog_lastSortTitle[GUI.view] = GUI.debugLog_colCtrl[GUI.view].w:GetSortTitle()
						end
					end
				end
			end

			AceGUI:Release(disp)
			GUI.display = nil
			addon.UIClosed = true
			-- collectgarbage()
		end)

		-- MagicButton
		if GUI.debugLog_defaultMagicButtonCB then
			display:SetMagicButtonCallback(GUI.debugLog_defaultMagicButtonCB)
		end
		if GUI.debugLog_defaultMagicButtonText then
			display:SetMagicButtonText(GUI.debugLog_defaultMagicButtonText)
		end
		if GUI.debugLog_defaultMagicButtonStatusText then
			display:SetMagicButtonStatusText(GUI.debugLog_defaultMagicButtonStatusText)
		end

		GUI.display = display
	end

	if #GUI.display.children > 0 then
		GUI.display:ReleaseChildren()
	end

	local fmtstr = #GUI.guiTabs.order > 6 and " %s " or "   %s   "
	local tabNames
	if GUI.debugLog_defaultNoSelfTab then
		tabNames = {}
	else
		tabNames = { addonName }
	end
	for _, name in ipairs(GUI.guiTabs.order) do
		if name ~= addonName then
			tabNames[#tabNames + 1] = name
		end
	end
	for i, name in ipairs(tabNames) do
		if GUI.guiTabs.texts and GUI.guiTabs.texts[name] and GUI.guiTabs.texts[name].title then
			GUI.guiTabs[i] = {
				value = name,
				text = fmtstr:format(GUI.guiTabs.texts[name].title),
				disabled = GUI.guiTabs.texts[name].disabled,
			}
		end
	end

	local tabs = AceGUI:Create(GUI.debugLog_defaultTabGroupWidget or private.tabGroupWidget)
	if tabs.SetInvisibleTabs then
		tabs:SetInvisibleTabs(GUI.debugLog_defaultInvisibleTabs)
	end
	tabs:SetLayout("Flow")
	tabs:SetTabs(GUI.guiTabs)
	tabs:SetCallback("OnGroupSelected", GUI.guiTabsOnSelected)
	tabs:SetCallback("OnTabEnter", function(_, _, value, _)
		GUI:SetStatusLine(GUI.guiTabs.texts[value].desc)
	end)
	tabs:SetCallback("OnTabLeave", function() GUI:SetStatusLine("") end)

	GUI.display:AddChildren(tabs)

	if optSelectTab and optSelectTab ~= "" then
		tabs:SelectTab(optSelectTab)
	else
		GUI.guiTabs.lastSelected = GUI.guiTabs.lastSelected or tabNames[1]
		tabs:SelectTab(GUI.guiTabs.lastSelected)
	end

	GUI.display:Show()

	GUI:DebugPrintf("  <<Load(%s)", tostring(optSelectTab))
	return GUI.display
end

-- call selected tab
GUI.guiTabsOnSelected = function(container, _, group)
	GUI:DebugPrintf("guiTabsOnSelected(%s, _, %s)", tostring(container), tostring(group))
	if container then
		container:ReleaseChildren()
		GUI.guiTabs.lastSelected = group
		if GUI.guiTabs.select[group] then
			GUI.view = group
			GUI.container = container
			GUI.guiTabs.select[group](container, group)
		end
	end
	GUI:DebugPrintf("  <<guiTabsOnSelected(%s, _, %s)", tostring(container), tostring(group))
end

-- do things on logout
function GUI:Logout()
	GUI:DebugPrintf("Logout()")
end

------------------------------------------------------------------------------
-- Status Line

function GUI:SetStatusLine(txt)
	if GUI.display then
		GUI.display:SetStatusText(txt)
	end
end

-- EOF
