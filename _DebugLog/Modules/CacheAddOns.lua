----------------------------------------------------------------------------------------------------------------------------------------------------
-- CacheAddOns.lua - Generic AddOns Metadata Cache
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-------------------------------------------------------------------------------------------------------
-- luacheck: ignore 212 globals DLAPI
-- luacheck: max_line_length 180
-- luacheck: globals GetNumAddOns GetAddOnEnableState GetAddOnInfo C_AddOns CreateSimpleTextureMarkup CreateAtlasMarkup ADDON_ACTIONS_BLOCKED GetAddOnDependencies

local addonName, addon = ...
local CacheAddOns = addon:NewModule("CacheAddOns", "AceEvent-3.0", "AceConsole-3.0")
-- local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local private = {}
private.version = "1.0.3"
-------------------------------------------------------------------------------------------------------

-- This addon provides meta data from addons.
--
-- 1. Include CacheAddOns.lua in TOC-File
--
-- 2. Initialization:
--   local addonName, addon = ...
--   addon = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0")
--   addon.modules.CacheAddOns:Login()
--
-- 3. Example
--    local cacheAddOns = CacheAddOns:GetCache()
--    local cacheKey = CacheAddOns:GetKey()
--    for k, v in ipairs(cacheAddOns[cacheKey].data.tab1) do
--      printf(v.name)
--    end
--
--    |Element         |Type   |Nilable |Hints               |
--    |----------------|-------|--------|--------------------|
--    |brec.Index      |number |false   |index
--    |brec.Name       |string |false   |name
--    |brec.Title      |string |false   |title
--    |brec.Version    |string |false   |version
--    |brec.Notes      |string |false   |notes
--    |brec.Loadable   |bool   |false   |loadable
--    |brec.Reason     |string |false   |reason
--    |brec.Security   |string |false   |security
--    |brec.Enabled    |bool   |false   |enabled
--    |brec.IconTexture|string |true    |IconTexture
--    |brec.IconAtlas  |string |true    |IconAtlas
--    |brec.TitleText  |string |true    |TitleText
--
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Configuration

CacheAddOns.isDebug = false

------------------------------------------------------------------------------
-- Debug Stuff

function CacheAddOns:DebugPrintf(...)
	local status, res
	status, res = pcall(format, ...)
	if status and (CacheAddOns.isDebug or (res and (res:match("ERR~") or res:match("WARN~")))) then
		if addon.DebugLog then
			addon:DebugLog("CAD~" .. res)
		else
			DLAPI.DebugLog(addonName, "CAD~" .. res)
		end
	end
end

------------------------------------------------------------------------------
-- Data

function CacheAddOns:Login()
	CacheAddOns.isDebug = addon.isDebug
	CacheAddOns:DebugPrintf("Login() Version %s",
		private.version)

	private.addonData = _G[addonName .. "DB"]

	-- optional: use the saved data
	-- private.addonData.CacheAddOns = private.addonData.CacheAddOns or {}

	-- currently we do not use the saved data
	private.addonData.CacheAddOns = {}

	private.currentAddonsKey = "AddOns"

	if not private.addonData.CacheAddOns[private.currentAddonsKey] then
		CacheAddOns:DebugPrintf("WARN~Login() initialize new addon data for '%s'", tostring(private.currentAddonsKey))
		private.addonData.CacheAddOns[private.currentAddonsKey] = {}
	else
		CacheAddOns:DebugPrintf("WARN~Login() using previous addon cache for '%s'", tostring(private.currentAddonsKey))
	end

	private.currentData = private.addonData.CacheAddOns[private.currentAddonsKey]
	private.currentData.data = private.currentData.data or {}

	CacheAddOns:UpdateData()
end

function CacheAddOns:GetCache()
--	CacheAddOns:DebugPrintf("GetCache()")

	if private.addonData and private.addonData.CacheAddOns then
		return private.addonData.CacheAddOns
	end
end

function CacheAddOns:GetKey()
	-- CacheAddOns:DebugPrintf("GetKey()")

	return private.currentAddonsKey
end

function CacheAddOns:RegisterOnUpdateCB(cb)
	CacheAddOns:DebugPrintf("RegisterOnUpdateCB(%s)", tostring(cb))
	if not cb then
		return
	end

	private.onUpdateCB = private.onUpdateCB or {}
	table.insert(private.onUpdateCB, cb)
end

-- check for addon data
function CacheAddOns:UpdateData()
	CacheAddOns:DebugPrintf("OK~>>UpdateData(), running=%s, time=%s",
		tostring(private.isUpdateRunning), time())

	if private.isUpdateRunning or not private.currentAddonsKey then
		CacheAddOns:DebugPrintf("ERR~ERROR: already updating addons data, running=%s",
			tostring(private.isUpdateRunning))
		return
	end

	local tab = 1
	private.isUpdateRunning = true

	CacheAddOns:DebugPrintf("# tab #%s", tostring(tab))

	-- new C_AddOns since 10.2.0
	if _G.GetNumAddOns then
		CacheAddOns:DebugPrintf("# old GetNumAddOns() present?!")
	end
	local GetNumAddOns = _G.GetNumAddOns or (C_AddOns and C_AddOns.GetNumAddOns)
	local GetAddOnEnableState = _G.GetAddOnEnableState or (C_AddOns and function(character, name) return C_AddOns.GetAddOnEnableState(name, character) end)
	local GetAddOnInfo = _G.GetAddOnInfo or (C_AddOns and C_AddOns.GetAddOnInfo)
	local GetAddOnMetadata = _G.GetAddOnMetadata or (C_AddOns and C_AddOns.GetAddOnMetadata)
	local GetAddOnDependencies = _G.GetAddOnDependencies or (C_AddOns and C_AddOns.GetAddOnDependencies)

	local currentAddons = {}
	local perusedAddons
	local addonCount = GetNumAddOns();
	for j = 1, addonCount do
		perusedAddons = true

		local brec = {}
		brec.Time = time()
		brec.Index = j
		brec.Enabled = GetAddOnEnableState(UnitFullName("player"), j) > 0
		brec.Name, brec.Title, brec.Notes, brec.Loadable, brec.Reason, brec.Security = GetAddOnInfo(j)

		brec.Name = brec.Name or "???"
		brec.TitleText = brec.Title or brec.Name or "???"
		brec.Title = brec.Title or ""
		brec.Loadable = brec.Loadable or ""
		brec.Reason = brec.Reason or ""
		brec.Security = brec.Security or ""
		brec.Version = GetAddOnMetadata(j, "Version") or ""
		brec.IconTexture = GetAddOnMetadata(j, "IconTexture")
		brec.IconAtlas = GetAddOnMetadata(j, "IconAtlas")
		brec.AddonCompartmentFunc = GetAddOnMetadata(j, "AddonCompartmentFunc")
		brec.AddonCompartmentFuncOnEnter = GetAddOnMetadata(j, "AddonCompartmentFuncOnEnter")
		brec.AddonCompartmentFuncOnLeave = GetAddOnMetadata(j, "AddonCompartmentFuncOnLeave")

		brec.Dependencies = ""
		if GetAddOnDependencies then
			brec.Dependencies = GetAddOnDependencies(j)
		end

		local iconTexture = brec.IconTexture
		if not brec.IconTexture and not brec.IconAtlas then
			iconTexture = [[Interface\ICONS\INV_Misc_QuestionMark]]
		end

		if iconTexture and CreateSimpleTextureMarkup then
			brec.TitleText = CreateSimpleTextureMarkup(iconTexture, 20, 20) .. " " .. brec.TitleText
		elseif brec.IconAtlas and CreateAtlasMarkup then
			brec.TitleText = CreateAtlasMarkup(brec.IconAtlas, 20, 20) .. " " .. brec.TitleText
		end

		-- if ADDON_ACTIONS_BLOCKED[brec.Name] then
		-- 	brec.TitleText = brec.TitleText .. CreateSimpleTextureMarkup([[Interface\DialogFrame\DialogIcon-AlertNew-16]], 16, 16)
		-- end

		CacheAddOns:DebugPrintf("  #%s, Name=%s, Version=%s, Title=%s, TitleText=%s, Notes=%s, Loadable=%s, Reason=%s, " ..
			"Security=%s, IconTexture=%s, IconAtlas=%s, CFunc=%s, CFuncOnEnter=%s, CFuncOnLeave=%s",
			tostring(j), tostring(brec.Name), tostring(brec.Version), tostring(brec.Title), tostring(brec.TitleText), tostring(brec.Notes), tostring(brec.Loadable), tostring(brec.Reason),
			tostring(brec.Security), tostring(brec.IconTexture), tostring(brec.IconAtlas),
			tostring(brec.AddonCompartmentFunc), tostring(brec.AddonCompartmentFuncOnEnter), tostring(brec.AddonCompartmentFuncOnLeave))

		currentAddons[j] = brec
	end

	if perusedAddons then
		-- lets update items
		local updated = 0
		local new = 0
		local removed = 0

		-- update previous seen slot data
		private.currentData.data["tab" .. tab] = private.currentData.data["tab" .. tab] or {}
		for j, val in pairs(currentAddons) do
			if private.currentData.data["tab" .. tab][j] then
				local changed = 0
				if val and val.Name and private.currentData.data["tab" .. tab][j].Name and val.Name ~= private.currentData.data["tab" .. tab][j].Name then
					changed = 1
				end
				updated = updated + changed
				private.currentData.data["tab" .. tab][j] = val
			else
				new = new + 1
				private.currentData.data["tab" .. tab][j] = val
			end
		end

		-- delete removed slot data
		for j, _ in pairs(private.currentData.data["tab" .. tab]) do
			if not currentAddons[j] then
				private.currentData.data["tab" .. tab][j] = nil
				removed = removed + 1
			end
		end

		private.currentData.tme = time()
	end

	private.updateStartedTime = time()

	private.isUpdateRunning = false
	private.onUpdateCB = private.onUpdateCB or {}
	for _, cb in ipairs(private.onUpdateCB) do
		pcall(cb, private.currentData.data)
	end
	CacheAddOns:DebugPrintf("<<UpdateData()")
end

function CacheAddOns:GetAddOnMetadata(name, item)
	CacheAddOns:DebugPrintf("OK~>>GetAddonMetadata(%s, %s)", tostring(name), tostring(item))

	local tab = 1
	for _, i in pairs(private.currentData.data["tab" .. tab]) do
		if i and i.Name and i.Name == (name or "???") then
			CacheAddOns:DebugPrintf("    %s", i[item or "???"] or "???")
			return i[item or "???"] or "???"
		end
	end
end


-- EOF
