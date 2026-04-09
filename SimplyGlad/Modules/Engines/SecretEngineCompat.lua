local _G, math, pcall, rawget, setmetatable, tostring, type = _G, math, pcall, rawget, setmetatable, tostring, type

local A = _G.Action
if not A then
	return
end

local Compat = A.Compat or {}
A.Compat = Compat

local NativeSE = rawget(_G, "ActionSecretEngine")
local issecretvalue = _G.issecretvalue
local scrubsecretvalues = _G.scrubsecretvalues
local C_Secrets = _G.C_Secrets
local C_Spell = _G.C_Spell
local C_SpellBook = _G.C_SpellBook
local GetSpellCharges = C_Spell and C_Spell.GetSpellCharges or _G.GetSpellCharges
local FindBaseSpellByID = C_SpellBook and C_SpellBook.FindBaseSpellByID or _G.FindBaseSpellByID
local FindSpellOverrideByID = _G.FindSpellOverrideByID
local GetTime = _G.GetTime
local IsSpellInRange = C_Spell and C_Spell.IsSpellInRange or _G.IsSpellInRange
local math_max = math.max
local wipe = _G.wipe
local Listener = A.Listener
local GetActionInfo = _G.GetActionInfo
local GetActionCooldown = _G.GetActionCooldown
local GetActionCharges = _G.GetActionCharges
local IsUsableAction = _G.IsUsableAction
local IsActionInRange = _G.IsActionInRange
local MAX_ACTION_SLOTS = (_G.NUM_ACTIONBAR_BUTTONS or 12) * (_G.NUM_ACTIONBAR_PAGES or 15)

local function compatValueArg(first, second)
	if second ~= nil and type(first) == "table" then
		return second
	end

	return first
end

local function compatValueAndFallback(first, second, third)
	if type(first) == "table" then
		return second, third
	end

	return first, second
end

local function callNative(methodName, ...)
	local native = Compat.NativeSecretEngine or NativeSE
	local method = native and native[methodName]
	if type(method) ~= "function" then
		return false
	end

	local ok, a, b, c, d = pcall(method, native, ...)
	if ok then
		return true, a, b, c, d
	end

	return false
end

local function compatIsRestrictionEnabled(value)
	if value == nil or value == false or value == 0 then
		return false
	end

	if type(value) == "string" then
		return value ~= "" and value ~= "None" and value ~= "none" and value ~= "NonSecret"
	end

	return true
end

Compat.IsRestrictionEnabled = Compat.IsRestrictionEnabled or compatIsRestrictionEnabled

Compat.IsSecret = Compat.IsSecret or function(selfOrValue, maybeValue)
	local value = compatValueArg(selfOrValue, maybeValue)
	if type(issecretvalue) ~= "function" then
		return false
	end

	local ok, secret = pcall(issecretvalue, value)
	return ok and secret or false
end

Compat.NormalizeValue = Compat.NormalizeValue or function(selfOrValue, maybeValue)
	local value = compatValueArg(selfOrValue, maybeValue)
	if not Compat.IsSecret(value) then
		return value
	end

	if type(scrubsecretvalues) == "function" then
		local ok, scrubbed = pcall(scrubsecretvalues, value)
		if ok and not Compat.IsSecret(scrubbed) then
			return scrubbed
		end
	end

	local ok, nativeOk, nativeValue = callNative("TryUnwrap", value)
	if ok and nativeOk and not Compat.IsSecret(nativeValue) then
		return nativeValue
	end

	return nil
end

Compat.TryUnwrap = Compat.TryUnwrap or function(selfOrValue, maybeValue)
	local value = compatValueArg(selfOrValue, maybeValue)
	local normalized = Compat.NormalizeValue(value)
	if value == nil or normalized ~= nil then
		return true, normalized
	end

	return false, nil
end

Compat.UnwrapAuraField = Compat.UnwrapAuraField or function(selfOrValue, maybeValue)
	local value = compatValueArg(selfOrValue, maybeValue)
	local normalized = Compat.NormalizeValue(value)
	if normalized ~= nil or value == nil then
		return normalized
	end

	local ok, nativeValue = callNative("UnwrapAuraField", value)
	if ok then
		local finalValue = Compat.NormalizeValue(nativeValue)
		if finalValue ~= nil or nativeValue == nil then
			return finalValue
		end
		return nativeValue
	end

	return value
end

local function normalizeAuraField(value)
	local normalized = Compat.UnwrapAuraField(value)
	if normalized ~= nil or value == nil then
		return normalized
	end

	return Compat.NormalizeValue(value)
end

Compat.UntaintNumber = Compat.UntaintNumber or function(selfOrValue, maybeValue, maybeFallback)
	local value, fallback = compatValueAndFallback(selfOrValue, maybeValue, maybeFallback)
	local normalized = Compat.NormalizeValue(value)
	if type(normalized) == "number" then
		return normalized
	end

	local ok, nativeValue = callNative("UntaintNumber", value, fallback)
	if ok and type(nativeValue) == "number" then
		return nativeValue
	end

	return fallback or 0
end

local function normalizeCompatBoolean(value)
	local normalized = Compat.NormalizeValue(value)
	if normalized ~= nil or value == nil then
		value = normalized
	end

	if value == true or value == 1 then
		return true
	end

	if value == false or value == 0 then
		return false
	end

	return nil
end

Compat.NormalizeAuraData = Compat.NormalizeAuraData or function(selfOrAuraData, maybeAuraData)
	local auraData = compatValueArg(selfOrAuraData, maybeAuraData)
	if not auraData then
		return nil
	end

	if type(scrubsecretvalues) == "function" then
		local ok, scrubbed = pcall(scrubsecretvalues, auraData)
		if ok and type(scrubbed) == "table" then
			auraData = scrubbed
		end
	end

	if type(auraData) ~= "table" then
		return nil
	end

	local name = normalizeAuraField(auraData.name)
	local spellId = normalizeAuraField(auraData.spellId)
	if spellId == nil then
		spellId = normalizeAuraField(auraData.spellID)
	end
	if name == nil and spellId == nil then
		return nil
	end

	local applications = normalizeAuraField(auraData.applications)
	local duration = normalizeAuraField(auraData.duration)
	local expirationTime = normalizeAuraField(auraData.expirationTime)
	local timeMod = normalizeAuraField(auraData.timeMod)
	local sourceUnit = normalizeAuraField(auraData.sourceUnit)
	if sourceUnit == nil then
		sourceUnit = normalizeAuraField(auraData.unitCaster)
	end

	return {
		name = name,
		spellId = spellId,
		spellID = spellId,
		sourceUnit = sourceUnit,
		unitCaster = sourceUnit,
		sourceGUID = normalizeAuraField(auraData.sourceGUID),
		applications = type(applications) == "number" and applications or 0,
		count = type(applications) == "number" and applications or 0,
		points = normalizeAuraField(auraData.points),
		duration = type(duration) == "number" and duration or 0,
		expirationTime = type(expirationTime) == "number" and expirationTime or 0,
		dispelName = normalizeAuraField(auraData.dispelName),
		isStealable = normalizeCompatBoolean(auraData.isStealable),
		isHelpful = normalizeCompatBoolean(auraData.isHelpful),
		isHarmful = normalizeCompatBoolean(auraData.isHarmful),
		isBossAura = normalizeCompatBoolean(auraData.isBossAura),
		isFromPlayerOrPlayerPet = normalizeCompatBoolean(auraData.isFromPlayerOrPlayerPet),
		canApplyAura = normalizeCompatBoolean(auraData.canApplyAura),
		isNameplateOnly = normalizeCompatBoolean(auraData.isNameplateOnly),
		isRaid = normalizeCompatBoolean(auraData.isRaid),
		nameplateShowAll = normalizeCompatBoolean(auraData.nameplateShowAll),
		nameplateShowPersonal = normalizeCompatBoolean(auraData.nameplateShowPersonal),
		icon = normalizeAuraField(auraData.icon),
		auraInstanceID = normalizeAuraField(auraData.auraInstanceID),
		timeMod = type(timeMod) == "number" and timeMod or 0,
	}
end

local function actionHasSecretRestrictions()
	if Compat.HasSecretRestrictions and Compat.HasSecretRestrictions ~= actionHasSecretRestrictions then
		return Compat.HasSecretRestrictions()
	end

	if C_Secrets then
		local checker = C_Secrets.HasSecretRestrictions
		if type(checker) == "function" then
			local ok, restricted = pcall(checker, C_Secrets)
			if ok then
				return Compat.IsRestrictionEnabled(restricted)
			end

			ok, restricted = pcall(checker)
			if ok then
				return Compat.IsRestrictionEnabled(restricted)
			end
		elseif checker ~= nil then
			return Compat.IsRestrictionEnabled(checker)
		end
	end

	if _G.C_CombatLog and type(_G.C_CombatLog.IsCombatLogRestricted) == "function" then
		local ok, restricted = pcall(_G.C_CombatLog.IsCombatLogRestricted)
		if ok then
			return restricted == true
		end
	end

	return false
end

Compat.HasSecretRestrictions = Compat.HasSecretRestrictions or actionHasSecretRestrictions

Compat.ActionSpellSlotsBySpellID = Compat.ActionSpellSlotsBySpellID or {}
Compat.ActionMacroSlotsBySpellID = Compat.ActionMacroSlotsBySpellID or {}
Compat.ActionSlotCacheDirty = Compat.ActionSlotCacheDirty ~= false

local function appendUniqueValue(container, seen, value)
	if type(value) ~= "number" or value <= 0 or seen[value] then
		return
	end

	seen[value] = true
	container[#container + 1] = value
end

local function buildCandidateSpellIDs(self, spellID)
	local candidates = {}
	local seen = {}
	appendUniqueValue(candidates, seen, spellID)
	appendUniqueValue(candidates, seen, self:GetBaseSpellID(spellID))
	appendUniqueValue(candidates, seen, self:ResolveSpellID(spellID))
	return candidates
end

local function markActionSlotCacheDirty()
	Compat.ActionSlotCacheDirty = true
end

local function registerActionSpellSlot(self, slotMap, slot, spellID)
	local candidateIDs = buildCandidateSpellIDs(self, spellID)
	for i = 1, #candidateIDs do
		local candidateID = candidateIDs[i]
		local slots = slotMap[candidateID]
		if not slots then
			slots = {}
			slotMap[candidateID] = slots
		end

		slots[#slots + 1] = slot
	end
end

local function appendTMWActionSlots(self, slots, seen, spellID)
	local tmwActions = _G.TMW and _G.TMW.COMMON and _G.TMW.COMMON.Actions
	if not tmwActions then
		return
	end

	local getActionsForSpell = tmwActions.GetActionsForSpell
	if type(getActionsForSpell) ~= "function" then
		return
	end

	local candidateIDs = buildCandidateSpellIDs(self, spellID)
	for i = 1, #candidateIDs do
		local ok, mappedSlots = pcall(getActionsForSpell, candidateIDs[i])
		if ok and type(mappedSlots) == "table" then
			for j = 1, #mappedSlots do
				appendUniqueValue(slots, seen, mappedSlots[j])
			end
		end
	end
end

Compat.RebuildSpellActionSlots = Compat.RebuildSpellActionSlots or function(self)
	if type(GetActionInfo) ~= "function" or type(wipe) ~= "function" then
		self.ActionSlotCacheDirty = false
		return
	end

	wipe(self.ActionSpellSlotsBySpellID)
	wipe(self.ActionMacroSlotsBySpellID)

	for slot = 1, MAX_ACTION_SLOTS do
		local actionType, actionID, actionSubType = GetActionInfo(slot)
		if type(actionID) == "number" and actionID > 0 then
			if actionType == "spell" then
				registerActionSpellSlot(self, self.ActionSpellSlotsBySpellID, slot, actionID)
			elseif actionType == "macro" and actionSubType == "spell" then
				registerActionSpellSlot(self, self.ActionMacroSlotsBySpellID, slot, actionID)
			end
		end
	end

	self.ActionSlotCacheDirty = false
end

Compat.GetSpellActionSlots = Compat.GetSpellActionSlots or function(self, spellID)
	if self.ActionSlotCacheDirty then
		self:RebuildSpellActionSlots()
	end

	local candidateIDs = buildCandidateSpellIDs(self, spellID)
	local slots = {}
	local seen = {}

	appendTMWActionSlots(self, slots, seen, spellID)

	for i = 1, #candidateIDs do
		local directSlots = self.ActionSpellSlotsBySpellID[candidateIDs[i]]
		if directSlots then
			for j = 1, #directSlots do
				appendUniqueValue(slots, seen, directSlots[j])
			end
		end
	end

	for i = 1, #candidateIDs do
		local macroSlots = self.ActionMacroSlotsBySpellID[candidateIDs[i]]
		if macroSlots then
			for j = 1, #macroSlots do
				appendUniqueValue(slots, seen, macroSlots[j])
			end
		end
	end

	return slots
end

if Listener and type(Listener.Add) == "function" then
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "PLAYER_ENTERING_WORLD", markActionSlotCacheDirty)
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "SPELLS_CHANGED", markActionSlotCacheDirty)
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "ACTIONBAR_SLOT_CHANGED", markActionSlotCacheDirty)
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "ACTIONBAR_PAGE_CHANGED", markActionSlotCacheDirty)
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "PLAYER_TALENT_UPDATE", markActionSlotCacheDirty)
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "ACTIVE_TALENT_GROUP_CHANGED", markActionSlotCacheDirty)
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "PLAYER_SPECIALIZATION_CHANGED", markActionSlotCacheDirty)
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "UPDATE_BONUS_ACTIONBAR", markActionSlotCacheDirty)
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "UPDATE_OVERRIDE_ACTIONBAR", markActionSlotCacheDirty)
	Listener:Add("ACTION_EVENT_SECRET_COMPAT_ACTION_SLOTS", "UPDATE_VEHICLE_ACTIONBAR", markActionSlotCacheDirty)
end

Compat.GetBaseSpellID = Compat.GetBaseSpellID or function(_, spellID)
	if type(FindBaseSpellByID) == "function" then
		local ok, baseSpellID = pcall(FindBaseSpellByID, spellID)
		if ok and type(baseSpellID) == "number" and baseSpellID > 0 then
			return baseSpellID
		end
	end

	local ok, nativeSpellID = callNative("GetBaseSpellID", spellID)
	if ok and type(nativeSpellID) == "number" and nativeSpellID > 0 then
		return nativeSpellID
	end

	return spellID
end

Compat.ResolveSpellID = Compat.ResolveSpellID or function(self, spellID)
	local baseSpellID = self:GetBaseSpellID(spellID)
	if type(FindSpellOverrideByID) == "function" then
		local ok, overrideSpellID = pcall(FindSpellOverrideByID, baseSpellID)
		if ok and type(overrideSpellID) == "number" and overrideSpellID > 0 then
			return overrideSpellID
		end
	end

	local ok, nativeSpellID = callNative("ResolveSpellID", baseSpellID)
	if ok and type(nativeSpellID) == "number" and nativeSpellID > 0 then
		return nativeSpellID
	end

	return baseSpellID
end

Compat.ActionSpellCooldownSnapshots = Compat.ActionSpellCooldownSnapshots or {}

local function buildCooldownInfo(self, cooldownInfo)
	if type(cooldownInfo) ~= "table" then
		return nil
	end

	local startTime = self:UntaintNumber(cooldownInfo.startTime, 0)
	local duration = self:UntaintNumber(cooldownInfo.duration, 0)
	local modRate = math_max(self:UntaintNumber(cooldownInfo.modRate, 1), 0.0001)
	local remainsMS = 0
	if duration > 0 then
		remainsMS = math_max(0, ((startTime + duration - GetTime()) / modRate) * 1000)
	end

	return {
		kind = "exact",
		startTime = startTime,
		duration = duration,
		modRate = modRate,
		isEnabled = normalizeCompatBoolean(cooldownInfo.isEnabled),
		remainsMS = remainsMS,
	}
end

local function buildActionCooldownInfo(self, startTime, duration, isEnabled, modRate)
	startTime = self:UntaintNumber(startTime, 0)
	duration = self:UntaintNumber(duration, 0)
	modRate = math_max(self:UntaintNumber(modRate, 1), 0.0001)

	local remainsMS = 0
	if duration > 0 then
		remainsMS = math_max(0, ((startTime + duration - GetTime()) / modRate) * 1000)
	end

	return {
		kind = "action",
		startTime = startTime,
		duration = duration,
		modRate = modRate,
		isEnabled = normalizeCompatBoolean(isEnabled),
		remainsMS = remainsMS,
	}
end

Compat.GetSpellCooldownInfo = Compat.GetSpellCooldownInfo or function(selfOrSpellID, maybeSpellID)
	local self = Compat
	local spellID = selfOrSpellID
	if maybeSpellID ~= nil then
		self = type(selfOrSpellID) == "table" and selfOrSpellID or Compat
		spellID = maybeSpellID
	end

	if type(spellID) ~= "number" or spellID <= 0 then
		return {
			kind = "unknown",
			remainsMS = math.huge,
		}
	end

	local resolvedSpellID = self:ResolveSpellID(spellID)
	local baseSpellID = self:GetBaseSpellID(spellID)
	local idsToTry = { spellID }
	if resolvedSpellID ~= spellID then
		idsToTry[#idsToTry + 1] = resolvedSpellID
	end
	if baseSpellID ~= spellID and baseSpellID ~= resolvedSpellID then
		idsToTry[#idsToTry + 1] = baseSpellID
	end

	local tmwCooldowns = _G.TMW and _G.TMW.COMMON and _G.TMW.COMMON.Cooldowns
	if tmwCooldowns and type(tmwCooldowns.GetSpellCooldown) == "function" then
		for i = 1, #idsToTry do
			local ok, cooldownInfo = pcall(tmwCooldowns.GetSpellCooldown, idsToTry[i])
			if ok then
				local info = buildCooldownInfo(self, cooldownInfo)
				if info then
					self.ActionSpellCooldownSnapshots[resolvedSpellID] = info
					return info
				end
			end
		end
	end

	if C_Spell and type(C_Spell.GetSpellCooldown) == "function" then
		for i = 1, #idsToTry do
			local ok, cooldownInfo = pcall(C_Spell.GetSpellCooldown, idsToTry[i])
			if ok then
				local info = buildCooldownInfo(self, cooldownInfo)
				if info then
					self.ActionSpellCooldownSnapshots[resolvedSpellID] = info
					return info
				end
			end
		end
	end

	local ok, nativeInfo
	for i = 1, #idsToTry do
		ok, nativeInfo = callNative("GetSpellCooldownInfo", idsToTry[i])
		if ok then
			local info = buildCooldownInfo(self, nativeInfo)
			if info then
				self.ActionSpellCooldownSnapshots[resolvedSpellID] = info
				return info
			end
		end
	end

	for i = 1, #idsToTry do
		ok, nativeInfo = callNative("SafeGetSpellCooldown", idsToTry[i])
		if ok then
			local info = buildCooldownInfo(self, nativeInfo)
			if info then
				self.ActionSpellCooldownSnapshots[resolvedSpellID] = info
				return info
			end
		end
	end

	if self:HasSecretRestrictions() and type(GetActionCooldown) == "function" then
		local actionSlots = self:GetSpellActionSlots(spellID)
		for i = 1, #actionSlots do
			local okAction, startTime, duration, isEnabled, modRate = pcall(GetActionCooldown, actionSlots[i])
			if okAction then
				local info = buildActionCooldownInfo(self, startTime, duration, isEnabled, modRate)
				self.ActionSpellCooldownSnapshots[resolvedSpellID] = info
				return info
			end
		end
	end

	for i = 1, #idsToTry do
		ok, nativeInfo = callNative("GetCooldownRemaining", idsToTry[i])
		if ok then
			local remainsMS = math_max(0, self:UntaintNumber(nativeInfo, 0) * 1000)
			local info = self.ActionSpellCooldownSnapshots[resolvedSpellID] or {
				kind = "snapshot",
				startTime = 0,
				duration = 0,
				modRate = 1,
				isEnabled = true,
			}
			info.remainsMS = remainsMS
			self.ActionSpellCooldownSnapshots[resolvedSpellID] = info
			return info
		end
	end

	return self.ActionSpellCooldownSnapshots[resolvedSpellID] or {
		kind = "unknown",
		remainsMS = math.huge,
	}
end

Compat.GetCooldownRemaining = Compat.GetCooldownRemaining or function(self, spellID)
	local info = self:GetSpellCooldownInfo(spellID)
	if type(info) == "table" and type(info.remainsMS) == "number" then
		return math_max(0, info.remainsMS / 1000)
	end

	return 0
end

Compat.IsOnCooldown = Compat.IsOnCooldown or function(self, spellID)
	return self:GetCooldownRemaining(spellID) > 0.05
end

Compat.SafeIsSpellHelpful = Compat.SafeIsSpellHelpful or function(self, spellID)
	local resolvedSpellID = self:ResolveSpellID(spellID)
	local ok, result = callNative("SafeIsSpellHelpful", resolvedSpellID)
	if ok then
		local normalized = normalizeCompatBoolean(result)
		if normalized ~= nil then
			return normalized
		end
	end

	if type(IsHelpfulSpell) == "function" then
		ok, result = pcall(IsHelpfulSpell, resolvedSpellID)
		if ok then
			local normalized = normalizeCompatBoolean(result)
			if normalized ~= nil then
				return normalized
			end
		end
	end

	return false
end

Compat.SafeIsSpellHarmful = Compat.SafeIsSpellHarmful or function(self, spellID)
	local resolvedSpellID = self:ResolveSpellID(spellID)
	local ok, result = callNative("SafeIsSpellHarmful", resolvedSpellID)
	if ok then
		local normalized = normalizeCompatBoolean(result)
		if normalized ~= nil then
			return normalized
		end
	end

	if type(IsHarmfulSpell) == "function" then
		ok, result = pcall(IsHarmfulSpell, resolvedSpellID)
		if ok then
			local normalized = normalizeCompatBoolean(result)
			if normalized ~= nil then
				return normalized
			end
		end
	end

	if type(IsAttackSpell) == "function" then
		ok, result = pcall(IsAttackSpell, resolvedSpellID)
		if ok then
			local normalized = normalizeCompatBoolean(result)
			if normalized ~= nil then
				return normalized
			end
		end
	end

	return false
end

Compat.SafeIsSpellUsable = Compat.SafeIsSpellUsable or function(self, spellID)
	local resolvedSpellID = self:ResolveSpellID(spellID)
	local baseSpellID = self:GetBaseSpellID(spellID)
	local idsToTry = { spellID }
	if resolvedSpellID ~= spellID then
		idsToTry[#idsToTry + 1] = resolvedSpellID
	end
	if baseSpellID ~= spellID and baseSpellID ~= resolvedSpellID then
		idsToTry[#idsToTry + 1] = baseSpellID
	end

	if self:HasSecretRestrictions() and type(IsUsableAction) == "function" then
		local actionSlots = self:GetSpellActionSlots(spellID)
		for i = 1, #actionSlots do
			local ok, usable = pcall(IsUsableAction, actionSlots[i])
			if ok then
				local normalized = normalizeCompatBoolean(usable)
				if normalized ~= nil then
					return normalized
				end
			end
		end
	end

	local spellUsable = _G.TMW and _G.TMW.COMMON and _G.TMW.COMMON.SpellUsable
	if spellUsable and type(spellUsable.IsUsableSpell) == "function" then
		for i = 1, #idsToTry do
			local ok, result = pcall(spellUsable.IsUsableSpell, idsToTry[i])
			if ok then
				local normalized = normalizeCompatBoolean(result)
				if normalized ~= nil then
					return normalized
				end
			end
		end
	end

	local ok, result = callNative("SafeIsSpellUsable", resolvedSpellID)
	if ok then
		local normalized = normalizeCompatBoolean(result)
		if normalized ~= nil then
			return normalized
		end
	end

	if type(IsUsableSpell) == "function" then
		for i = 1, #idsToTry do
			ok, result = pcall(IsUsableSpell, idsToTry[i])
			if ok then
				local normalized = normalizeCompatBoolean(result)
				if normalized ~= nil then
					return normalized
				end
			end
		end
	end

	return false
end

Compat.SafeIsSpellInRange = Compat.SafeIsSpellInRange or function(self, spellID, unitID)
	unitID = unitID or "target"
	local resolvedSpellID = self:ResolveSpellID(spellID)
	local baseSpellID = self:GetBaseSpellID(spellID)
	local idsToTry = { spellID }
	if resolvedSpellID ~= spellID then
		idsToTry[#idsToTry + 1] = resolvedSpellID
	end
	if baseSpellID ~= spellID and baseSpellID ~= resolvedSpellID then
		idsToTry[#idsToTry + 1] = baseSpellID
	end

	if self:HasSecretRestrictions() and type(IsActionInRange) == "function" then
		local actionSlots = self:GetSpellActionSlots(spellID)
		for i = 1, #actionSlots do
			local ok, result = pcall(IsActionInRange, actionSlots[i], unitID)
			if ok then
				local normalized = normalizeCompatBoolean(result)
				if normalized ~= nil or result == nil then
					return normalized
				end
			end
		end
	end

	local spellRange = _G.LibStub and _G.LibStub("SpellRange-1.0", true)
	if spellRange and type(spellRange.IsSpellInRange) == "function" then
		for i = 1, #idsToTry do
			local ok, result = pcall(spellRange.IsSpellInRange, idsToTry[i], unitID)
			if ok then
				local normalized = normalizeCompatBoolean(result)
				if normalized ~= nil or result == nil then
					return normalized
				end
			end
		end
	end

	local ok, result = callNative("SafeIsSpellInRange", resolvedSpellID, unitID)
	if ok then
		local normalized = normalizeCompatBoolean(result)
		if normalized ~= nil or result == nil then
			return normalized
		end
	end

	if type(IsSpellInRange) == "function" then
		for i = 1, #idsToTry do
			ok, result = pcall(IsSpellInRange, idsToTry[i], unitID)
			if ok then
				local normalized = normalizeCompatBoolean(result)
				if normalized ~= nil or result == nil then
					return normalized
				end
			end
		end
	end

	return nil
end

Compat.IsSpellKnownOrOverridesKnown = Compat.IsSpellKnownOrOverridesKnown or function(self, spellID)
	local resolvedSpellID = self:ResolveSpellID(spellID)
	local baseSpellID = self:GetBaseSpellID(spellID)
	local idsToTry = { spellID }
	if resolvedSpellID ~= spellID then
		idsToTry[#idsToTry + 1] = resolvedSpellID
	end
	if baseSpellID ~= spellID and baseSpellID ~= resolvedSpellID then
		idsToTry[#idsToTry + 1] = baseSpellID
	end

	local ok, result = callNative("IsSpellKnownOrOverridesKnown", resolvedSpellID)
	if ok then
		local normalized = normalizeCompatBoolean(result)
		if normalized ~= nil then
			return normalized
		end
	end

	if type(IsSpellKnownOrOverridesKnown) == "function" then
		for i = 1, #idsToTry do
			ok, result = pcall(IsSpellKnownOrOverridesKnown, idsToTry[i])
			if ok and result then
				return true
			end
		end
	end

	if type(IsPlayerSpell) == "function" then
		for i = 1, #idsToTry do
			ok, result = pcall(IsPlayerSpell, idsToTry[i])
			if ok and result then
				return true
			end
		end
	end

	return false
end

Compat.ActionSpellChargeSnapshots = Compat.ActionSpellChargeSnapshots or {}

local function buildChargeInfo(first, second, third, fourth)
	if type(first) == "table" then
		return {
			currentCharges = Compat:UntaintNumber(first.currentCharges, 0),
			maxCharges = Compat:UntaintNumber(first.maxCharges, 0),
			cooldownStartTime = Compat:UntaintNumber(first.cooldownStartTime, 0),
			cooldownDuration = Compat:UntaintNumber(first.cooldownDuration, 0),
		}
	end

	if first == nil and second == nil and third == nil and fourth == nil then
		return nil
	end

	return {
		currentCharges = Compat:UntaintNumber(first, 0),
		maxCharges = Compat:UntaintNumber(second, 0),
		cooldownStartTime = Compat:UntaintNumber(third, 0),
		cooldownDuration = Compat:UntaintNumber(fourth, 0),
	}
end

Compat.SafeGetSpellCharges = Compat.SafeGetSpellCharges or function(self, spellID)
	local resolvedSpellID = self:ResolveSpellID(spellID)
	if self:HasSecretRestrictions() and type(GetActionCharges) == "function" then
		local actionSlots = self:GetSpellActionSlots(spellID)
		for i = 1, #actionSlots do
			local ok, currentCharges, maxCharges, cooldownStartTime, cooldownDuration = pcall(GetActionCharges, actionSlots[i])
			if ok then
				local info = buildChargeInfo(currentCharges, maxCharges, cooldownStartTime, cooldownDuration)
				if info and (info.maxCharges > 0 or info.currentCharges > 0 or info.cooldownDuration > 0) then
					self.ActionSpellChargeSnapshots[resolvedSpellID] = info
					return info
				end
			end
		end
	end

	if type(GetSpellCharges) == "function" then
		local ok, first, second, third, fourth = pcall(GetSpellCharges, resolvedSpellID)
		if ok then
			local info = buildChargeInfo(first, second, third, fourth)
			if info then
				self.ActionSpellChargeSnapshots[resolvedSpellID] = info
				return info
			end
		end
	end

	local ok, first, second, third, fourth = callNative("SafeGetSpellCharges", resolvedSpellID)
	if ok then
		local info = buildChargeInfo(first, second, third, fourth)
		if info then
			self.ActionSpellChargeSnapshots[resolvedSpellID] = info
			return info
		end
	end

	ok, first, second, third, fourth = callNative("GetSpellCharges", resolvedSpellID)
	if ok then
		local info = buildChargeInfo(first, second, third, fourth)
		if info then
			self.ActionSpellChargeSnapshots[resolvedSpellID] = info
			return info
		end
	end

	return self.ActionSpellChargeSnapshots[resolvedSpellID] or {
		currentCharges = 0,
		maxCharges = 0,
		cooldownStartTime = 0,
		cooldownDuration = 0,
	}
end

Compat.NativeSecretEngine = Compat.NativeSecretEngine or NativeSE
_G.ActionSecretEngineNative = _G.ActionSecretEngineNative or NativeSE
_G.ActionHasSecretRestrictions = actionHasSecretRestrictions
_G.ActionSecretEngine = Compat
A.SecretEngine = Compat
