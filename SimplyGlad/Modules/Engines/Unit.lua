local _G, setmetatable, unpack, select, next, type, pairs, ipairs, math, error =
	  _G, setmetatable, unpack, select, next, type, pairs, ipairs, math, error

local huge 									= math.huge
local math_max								= math.max
local math_floor							= math.floor
local math_random							= math.random
local wipe									= _G.wipe
local strsplit								= _G.strsplit
local strjoin								= _G.strjoin
local debugstack							= _G.debugstack

local TMW 									= _G.TMW
local CNDT 									= TMW.CNDT
local Env 									= CNDT.Env
--local AuraTooltipNumber					= Env.AuraTooltipNumber -- this is broken
local AuraTooltipNumberPacked 				= Env.AuraTooltipNumberPacked
local AuraVariableNumber 					= Env.AuraVariableNumber
local strlowerCache  						= TMW.strlowerCache

local A   									= _G.Action
local BuildToC								= A.BuildToC
local CONST 								= A.Const
local Listener								= A.Listener
local function SafeInsertMulti(t, ...)
        local fn = A and A.TableInsertMulti
        if type(fn) == "function" then
                return fn(t, ...)
        end

        for i = 1, select("#", ...) do
                t[#t + 1] = (select(i, ...))
        end
end

local insertMulti                                                   = SafeInsertMulti
local toNum                                                         = A.toNum
local strElemBuilder						= A.strElemBuilder
local InstanceInfo							= A.InstanceInfo
local Player 								= A.Player
local UnitCooldown							= A.UnitCooldown
local CombatTracker							= A.CombatTracker
local MultiUnits							= A.MultiUnits
local GetToggle								= A.GetToggle
local MouseHasFrame							= A.MouseHasFrame
local UnitInLOS								= A.UnitInLOS
local PlayerClass							= A.PlayerClass
local UnitSpecsMap							= A.UnitSpecsMap

local LibStub								= _G.LibStub
local LibRangeCheck  						= LibStub("LibRangeCheck-3.0")
local LibBossIDs							= LibStub("LibBossIDs-1.0").BossIDs

local TeamCache								= A.TeamCache
local TeamCacheFriendly 					= TeamCache.Friendly
local TeamCacheFriendlyUNITs				= TeamCacheFriendly.UNITs
local TeamCacheFriendlyGUIDs				= TeamCacheFriendly.GUIDs
local TeamCacheFriendlyIndexToPLAYERs		= TeamCacheFriendly.IndexToPLAYERs
local TeamCacheFriendlyIndexToPETs			= TeamCacheFriendly.IndexToPETs
local TeamCacheFriendlyHEALER				= TeamCacheFriendly.HEALER
local TeamCacheFriendlyTANK					= TeamCacheFriendly.TANK
local TeamCacheFriendlyDAMAGER				= TeamCacheFriendly.DAMAGER
local TeamCacheFriendlyDAMAGER_MELEE		= TeamCacheFriendly.DAMAGER_MELEE
--local TeamCacheFriendlyDAMAGER_RANGE		= TeamCacheFriendly.DAMAGER_RANGE
local TeamCacheEnemy 						= TeamCache.Enemy
local TeamCacheEnemyUNITs					= TeamCacheEnemy.UNITs
local TeamCacheEnemyGUIDs					= TeamCacheEnemy.GUIDs
local TeamCacheEnemyIndexToPLAYERs			= TeamCacheEnemy.IndexToPLAYERs
local TeamCacheEnemyIndexToPETs				= TeamCacheEnemy.IndexToPETs
local TeamCacheEnemyHEALER					= TeamCacheEnemy.HEALER
local TeamCacheEnemyTANK					= TeamCacheEnemy.TANK
local TeamCacheEnemyDAMAGER					= TeamCacheEnemy.DAMAGER
local TeamCacheEnemyDAMAGER_MELEE			= TeamCacheEnemy.DAMAGER_MELEE
--local TeamCacheEnemyDAMAGER_RANGE			= TeamCacheEnemy.DAMAGER_RANGE
local ActiveUnitPlates                                              = MultiUnits and MultiUnits:GetActiveUnitPlates() or {}
local ActiveUnitPlatesAny                                           = MultiUnits and MultiUnits:GetActiveUnitPlatesAny() or {}

local CACHE_DEFAULT_TIMER_UNIT				= CONST.CACHE_DEFAULT_TIMER_UNIT

local GameLocale 							= A.FormatGameLocale(_G.GetLocale())
local CombatLogGetCurrentEventInfo			= _G.CombatLogGetCurrentEventInfo
local GetUnitSpeed							= _G.GetUnitSpeed
local C_Spell								= _G.C_Spell
local GetSpellName 							= C_Spell and C_Spell.GetSpellName or _G.GetSpellInfo
local GetSpellInfo							= C_Spell and C_Spell.GetSpellInfo or _G.GetSpellInfo
local GetPartyAssignment 					= _G.GetPartyAssignment
local UnitIsUnit, UnitPlayerOrPetInRaid, UnitInAnyGroup, UnitPlayerOrPetInParty, UnitInRange, UnitInVehicle, UnitIsQuestBoss, UnitEffectiveLevel, UnitLevel, UnitThreatSituation, UnitRace, UnitClass, UnitGroupRolesAssigned, UnitClassification, UnitExists, UnitIsConnected, UnitIsCharmed, UnitIsGhost, UnitIsDeadOrGhost, UnitIsFeignDeath, UnitIsPlayer, UnitPlayerControlled, UnitCanAttack, UnitIsEnemy, UnitAttackSpeed,
	  UnitPowerType, UnitPowerMax, UnitPower, UnitName, UnitCanCooperate, UnitCastingInfo, UnitChannelInfo, UnitCreatureType, UnitCreatureFamily, UnitHealth, UnitHealthMax, UnitGetIncomingHeals, UnitGUID, UnitHasIncomingResurrection, UnitIsVisible, UnitGetTotalHealAbsorbs, UnitStagger, UnitAura =
	  UnitIsUnit, UnitPlayerOrPetInRaid, UnitInAnyGroup, UnitPlayerOrPetInParty, UnitInRange, UnitInVehicle, UnitIsQuestBoss, UnitEffectiveLevel, UnitLevel, UnitThreatSituation, UnitRace, UnitClass, UnitGroupRolesAssigned, UnitClassification, UnitExists, UnitIsConnected, UnitIsCharmed, UnitIsGhost, UnitIsDeadOrGhost, UnitIsFeignDeath, UnitIsPlayer, UnitPlayerControlled, UnitCanAttack, UnitIsEnemy, UnitAttackSpeed,
	  UnitPowerType, UnitPowerMax, UnitPower, UnitName, UnitCanCooperate, UnitCastingInfo, UnitChannelInfo, UnitCreatureType, UnitCreatureFamily, UnitHealth, UnitHealthMax, UnitGetIncomingHeals, UnitGUID, UnitHasIncomingResurrection, UnitIsVisible, UnitGetTotalHealAbsorbs, UnitStagger, _G.C_UnitAuras.GetAuraDataByIndex
-------------------------------------------------------------------------------
-- Remap
-------------------------------------------------------------------------------
local NullUnit = setmetatable({}, {
__index = function()
return function()
return false
end
end,
})

local function SafeAUnit(unitID)
if A and type(A.Unit) == "function" then
local ok, unit = pcall(A.Unit, unitID)
if ok and unit then
return unit
end
end

return NullUnit
end

local function SafeGetSpellInfo(...)
local fn = A and A.GetSpellInfo or GetSpellInfo
if type(fn) == "function" then
return fn(...)
end
end

local function SafeGetGCD(...)
local fn = A and A.GetGCD
if type(fn) == "function" then
return fn(...)
end
return 0
end

local function SafeGetCurrentGCD(...)
local fn = A and A.GetCurrentGCD
if type(fn) == "function" then
return fn(...)
end
return 0
end

local function SafeIsTalentLearned(...)
local fn = A and A.IsTalentLearned
if type(fn) == "function" then
return fn(...)
end
return false
end

local function SafeIsSpellInRange(...)
local fn = A and A.IsSpellInRange
if type(fn) == "function" then
return fn(...)
end
return false
end

local function SafeEnemyTeam(...)
local fn = A and A.EnemyTeam
if type(fn) == "function" then
return fn(...)
end
return nil
end

local function SafeGetUnitItem(...)
local fn = A and A.GetUnitItem
if type(fn) == "function" then
return fn(...)
end
return nil
end

local A_Unit, A_GetSpellInfo, A_GetGCD, A_GetCurrentGCD, A_IsTalentLearned, A_IsSpellInRange, A_EnemyTeam, A_GetUnitItem =
SafeAUnit, SafeGetSpellInfo, SafeGetGCD, SafeGetCurrentGCD, SafeIsTalentLearned, SafeIsSpellInRange, SafeEnemyTeam, SafeGetUnitItem

local SE = _G.ActionSecretEngine
local Compat = A and A.Compat or {}
local issecretvalue_local = _G.issecretvalue
local UnwrapField

local function GetCompat()
	local compat = A and A.Compat or Compat
	if compat then
		Compat = compat
	end
	return compat
end

local function NormalizeCompatValue(value)
	local compat = GetCompat()
	if compat and type(compat.NormalizeValue) == "function" then
		local ok, normalized = pcall(compat.NormalizeValue, value)
		if ok and normalized ~= nil then
			return normalized
		end

		ok, normalized = pcall(compat.NormalizeValue, compat, value)
		if ok and normalized ~= nil and normalized ~= compat then
			return normalized
		end
	end

	return nil
end

local function NormalizeCompatAuraData(auraData)
	local compat = GetCompat()
	if compat and type(compat.NormalizeAuraData) == "function" then
		local ok, normalized = pcall(compat.NormalizeAuraData, auraData)
		if ok and normalized then
			return normalized
		end

		ok, normalized = pcall(compat.NormalizeAuraData, compat, auraData)
		if ok and normalized and normalized ~= compat then
			return normalized
		end
	end

	return nil
end

local function NormalizeBoolean(value)
	local normalized = NormalizeCompatValue(value)
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

local function UntaintNumber(value, fallback)
	local hasFallback = fallback ~= nil
	local requestedFallback = hasFallback and fallback or -huge

	if type(value) == "number" and not (issecretvalue_local and issecretvalue_local(value)) then
		return value
	end

	local compat = GetCompat()
	if compat and type(compat.UntaintNumber) == "function" then
		local ok, normalized = pcall(compat.UntaintNumber, compat, value, requestedFallback)
		if ok and type(normalized) == "number" and (hasFallback or normalized ~= requestedFallback) then
			return normalized
		end

		ok, normalized = pcall(compat.UntaintNumber, value, requestedFallback)
		if ok and type(normalized) == "number" and (hasFallback or normalized ~= requestedFallback) then
			return normalized
		end
	end

	if SE and type(SE.UntaintNumber) == "function" then
		local ok, normalized = pcall(SE.UntaintNumber, SE, value, requestedFallback)
		if ok and type(normalized) == "number" and (hasFallback or normalized ~= requestedFallback) then
			return normalized
		end
	end

	local normalized = NormalizeCompatValue(value)
	if type(normalized) == "number" then
		return normalized
	end

	local unwrapped = UnwrapField(value)
	if type(unwrapped) == "number" then
		return unwrapped
	end

	if hasFallback then
		return fallback
	end

	return nil
end

local function IsLivingExistingUnit(unitID)
	local existsFn = _G.UnitExists or UnitExists
	local deadFn = _G.UnitIsDeadOrGhost or UnitIsDeadOrGhost

	if type(existsFn) == "function" then
		local ok, exists = pcall(existsFn, unitID)
		if ok and NormalizeBoolean(exists) == false then
			return false
		end
	end

	if type(deadFn) == "function" then
		local ok, dead = pcall(deadFn, unitID)
		if ok and NormalizeBoolean(dead) == true then
			return false
		end
	end

	return true
end

function UnwrapField(value)
	if value == nil then return nil end
	if not issecretvalue_local or not issecretvalue_local(value) then return value end
	local normalized = NormalizeCompatValue(value)
	if normalized ~= nil then return normalized end
	if SE then
		local ok, ret = SE:TryUnwrap(value)
		if ok then return ret end
	end
	return nil
end

local function UnwrapAuraData(auraData)
	if not auraData then return nil end
	local normalized = NormalizeCompatAuraData(auraData)
	if normalized then return normalized end
	if not issecretvalue_local then return auraData end

	auraData.spellId = UnwrapField(auraData.spellId or auraData.spellID)
	auraData.spellID = auraData.spellId
	auraData.name = UnwrapField(auraData.name)
	auraData.duration = UnwrapField(auraData.duration)
	auraData.expirationTime = UnwrapField(auraData.expirationTime)
	auraData.applications = UnwrapField(auraData.applications)
	auraData.count = auraData.applications
	auraData.sourceUnit = UnwrapField(auraData.sourceUnit or auraData.unitCaster)
	auraData.unitCaster = auraData.sourceUnit
	auraData.points = UnwrapField(auraData.points)
	auraData.dispelName = UnwrapField(auraData.dispelName)
	auraData.isStealable = UnwrapField(auraData.isStealable)
	auraData.nameplateShowAll = UnwrapField(auraData.nameplateShowAll)
	auraData.nameplateShowPersonal = UnwrapField(auraData.nameplateShowPersonal)

	return auraData
end

local function UnwrapValue(value)
	return UnwrapField(value)
end

Listener:Add("ACTION_EVENT_UNIT", "ADDON_LOADED", function(addonName)
        if addonName == CONST.ADDON_NAME then
                A_Unit                                          = type(A.Unit) == "function" and A.Unit or SafeAUnit
                A_GetSpellInfo                          = type(A.GetSpellInfo) == "function" and A.GetSpellInfo or SafeGetSpellInfo
                A_GetGCD                                        = type(A.GetGCD) == "function" and A.GetGCD or SafeGetGCD
                A_GetCurrentGCD                         = type(A.GetCurrentGCD) == "function" and A.GetCurrentGCD or SafeGetCurrentGCD
                A_IsTalentLearned                       = type(A.IsTalentLearned) == "function" and A.IsTalentLearned or SafeIsTalentLearned
                A_IsSpellInRange                        = type(A.IsSpellInRange) == "function" and A.IsSpellInRange or SafeIsSpellInRange
                A_EnemyTeam                                     = type(A.EnemyTeam) == "function" and A.EnemyTeam or SafeEnemyTeam
                A_GetUnitItem                           = type(A.GetUnitItem) == "function" and A.GetUnitItem or SafeGetUnitItem 
                SE                                                     = _G.ActionSecretEngine or SE
                Compat                                                 = A and A.Compat or Compat
                issecretvalue_local                     = _G.issecretvalue or issecretvalue_local

                Listener:Remove("ACTION_EVENT_UNIT", "ADDON_LOADED")
        end
end)
-------------------------------------------------------------------------------

local function GetGUID(unitID)
	return TeamCacheFriendlyUNITs[unitID] or TeamCacheEnemyUNITs[unitID] or UnitGUID(unitID)
end

-------------------------------------------------------------------------------
-- Cache
-------------------------------------------------------------------------------
local str_none = "none"
local str_empty = ""

local function PseudoClass(methods)
    local Class = setmetatable(methods, {
		__call = function(self, ...)
			self:New(...)
			return self
		end,
    })
    return Class
end

local Cache = {
	bufer = {},
	newEl = function(this, inv, keyArg, func, ...)
		if not this.bufer[func][keyArg] then
			this.bufer[func][keyArg] = { v = {} }
		else
			wipe(this.bufer[func][keyArg].v)
		end
		this.bufer[func][keyArg].t = TMW.time + (inv or CACHE_DEFAULT_TIMER_UNIT) + 0.001  -- Add small delay to make sure what it's not previous corroute
		insertMulti(this.bufer[func][keyArg].v, func(...))
		return unpack(this.bufer[func][keyArg].v)
	end,
	Wrap = function(this, func, name)
		if CONST.CACHE_DISABLE then
			return func
		end

		if not this.bufer[func] then
			this.bufer[func] = {}
		end

   		return function(...)
			-- The reason of all this view look is memory hungry eating, this way use around 0 memory now
			local self = ...
			local keyArg = strElemBuilder(name == "UnitGUID" and self.UnitID and UnitGUID(self.UnitID) or self.UnitID or self.ROLE or name, ...)

	        if TMW.time > (this.bufer[func][keyArg] and this.bufer[func][keyArg].t or 0) then
	            return this:newEl(self.Refresh, keyArg, func, ...)
	        else
	            return unpack(this.bufer[func][keyArg].v)
	        end
        end
    end,
	Pass = function(this, func, name)
		if CONST.CACHE_MEM_DRIVE and not CONST.CACHE_DISABLE then
			return this:Wrap(func, name)
		end

		return func
	end,
}

local AuraList = {
    -- CC SCHOOL TYPE
    Magic = {
        118, -- Polymorph
        605, -- Mind Control
        9484, -- Shackle Undead
        2637, -- Hibernate
        20066, -- Repentance
        5782, -- Fear
        3355, -- Freezing Trap
        278468, -- Freezing Trap
        209790, -- Freezing Arrow (hunter pvp)
        6358, -- Seduction
        82691, -- Ring of Frost
        198909, -- Song of Chi-ji (mistweaver monk talent)
        5484, -- Howl of Terror
        6789, -- Mortal Coil
        87204, -- Sin and Punishment
        8122, -- Psychic Scream
        31661, -- Dragon's Breath
        105421, -- Bliding light (paladin talent)
        202274, -- Incendiary brew (brewmaster monk pvp talent)
        15487, -- Silence
        31935, -- Avenger's Shield
        199683, -- Last Word
        47476, -- Strangulate
        31117, -- Unstable Affliction
        853, -- Hammer of Justice
        64044, -- Psychic Horror
        30283, -- Shadowfury
        117526, -- Binding Shot
        118905, -- Static Charge
        179057, -- Chaos Nova
        205630, -- Illidan's Grasp (demon hunter)
        209749, -- Faerie Swarm (Moonkin Disarm)
        204399, -- Earthfury (enhancement shaman pvp talent)
        217832, -- Imprison
        286349, -- Gladiator's Maledict
		22703, -- Summon Infernal
		200166, -- Metamorphosis
		208618, -- Illidan's Grasp (secondary effect)
		211881, -- Fel Eruption
		200200, -- Holy word: Chastise (stunned)
		--200196, -- Holy word: Chastise (incapacitated)
    },
    MagicRooted = {
        233395, -- Frozen Center (DK PvP Frost)
        339, -- Entangling Roots
        122, -- Frost Nova
        102359, -- Mass Entanglement
        96294, -- Chains of Ice
        183218, -- Retri's -70%
    },
    Curse = {
        51514, -- Hex
        -- Warlock BFA
        12889, -- Curse of Tongues
        17227, -- Curse of Weakness
        199954, -- Curse of Fragility
    },
    Disease = {
        196782, -- Outbreak (5 sec infecting dot)
        191587, -- Outbreak (21+ sec dot)
        58180, -- Infected Wounds (Feral slow)
        -- [Blood Plague]
        -- [Frost Fever]
    },
    Poison = {
        19386, -- Wyvern Sting
        202933, -- Spider Sting
        202797, -- Viper Sting
        202900, -- Scorpid Sting
    },
    Physical = {
        115078, -- Paralysis
        6770, -- Sap
        107079, -- Quaking Palm
        207685, -- Sigil of Misery (Havoc Demon hunter)
        5246, -- Intimidating Shout
        99, -- Incapacitating Roar
        1776, -- Gouge
        2094, -- Blind
        186387, -- Bursting Shot (hunter marks ability)
        213691, -- Scatter Shot (hunter pvp talent)
        --25, -- Stun
        1833, -- Cheap Shot
        408, -- Kidney Shot
        5211, -- Mighty Bash
        24394, -- Intimidation
        89766, -- Axe Toss
        108194, -- Asphyxiate (DK)
        118345, -- Pulverize
        119381, -- Leg Sweep
        163505, -- Rake
        199804, -- Between the Eyes
        203123, -- Maim
        236025, -- Enraged Maim
        204399, -- Earthfury (enhancement shaman pvp talent)
        47481, -- Gnaw (DK pet)
        212332, -- Smash (DK transformation pet)
        -- 207167, -- Blinding Sleet (is it physical ? )
        207777, -- Dismantle
        236077, -- Disarm
        233759, -- Grapple Weapon
        212638, -- Tracker's Net (Hunter PvP talent)
        162480, -- Steel Trap (Hunter SV PvE talent)
		-- Warrior
		132168, -- Shockwave
        132169, -- Storm Bolt
		--237744, -- Warbringer
		-- Tauren
		--20549, -- War Stomp
		-- Kul Tiran
		287712, -- Haymaker
    },
    -- CC CONTROL TYPE
    CrowdControl = {
        -- Deprecated
		118, -- Hibernate
    },
    Incapacitated = {
		-- Druid
        99, -- Incapacitating Roar
		203126, -- Maim (Feral PvP talent)
		-- Hunter
		213691, -- Scatter Shot
        3355, -- Freezing Trap
        209790, -- Freezing Arrow
		19386, -- Wyvern Sting
		-- Mage
        118, -- Polymorph
		82691, -- Ring of Frost
		-- Monk
        115078, -- Paralysis
		-- Paladin
        20066, -- Repentance
		-- Priest
        200196, -- Holy Word: Chastise (Holy)
		--605, -- Dominate Mind (Mind Control) this is buff type
		9484, -- Shackle Undead
		-- Rogue
        6770, -- Sap
		1776, -- Gouge
		-- Shaman
        51514, -- Hex (also 211004, 210873, 211015, 211010)
		-- Warlock
		710, -- Banish
		6789, -- Mortal Coil
        -- Pandaren
        107079, -- Quaking Palm
		-- Demon Hunter
		217832, -- Imprison
		--221527, -- Improve Imprison
    },
    Disoriented = {
		-- Death Knight
		207167, -- Blinding Sleet (Frost)
		-- Demon Hunter
		207685, -- Sigil of Misery (Havoc)
		115268, -- Mesmerize
		-- Druid
		--33786, -- Cyclone
		--209753, -- Cyclone (Balance)
		-- Hunter
		--224729, -- Bursting Shot
		186387, -- Bursting Shot (MM)
		-- Mage
		31661, -- Dragon's Breath (Fire)
		-- Monk
		202274, -- Incendiary brew (BW)
		198909, -- Song of Chi-ji (MW)
        -- Paladin
        105421, -- Bliding light (Holy)
		-- Priest
		8122, -- Psychic Scream
		-- Rogue
        2094, -- Blind
		-- Warlock
		5782, -- Fear
		--118699, -- Fear
		--130616, -- Fear
		5484, -- Howl of Terror
		115268, -- Mesmerize (Shivarra)
		6358, -- Seduction (Succubus)
		-- Warrior
		5246, -- Intimidating Shout
    },
    Fear = {
        5782, -- Fear
        5484, -- Howl of Terror
        5246, -- Intimidating Shout
        8122, -- Psychic Scream
        87204, -- Sin and Punishment
        207685, -- Sigil of Misery (Havoc Demon hunter)
    },
    Charmed = {
		-- Deprecated
        605, -- Mind Control
        9484, -- Shackle Undead
    },
    Sleep = {
        2637, -- Hibernate
    },
    Stuned = {
		-- Death Knight
        47481, -- Gnaw (pet)
        212332, -- Smash (transformation pet)
        108194, -- Asphyxiate
		207171, -- Winter is Coming (Remorseless winter stun)
		-- Demon Hunter
		179057, -- Chaos Nova
		200166, -- Metamorphosis
		205630, -- Illidan's Grasp (primary effect)
		208618, -- Illidan's Grasp (secondary effect)
		211881, -- Fel Eruption
		-- Druid
		203123, -- Maim
        5211, -- Mighty Bash
		163505, -- Rake
		--2637, -- Hibernate --FIXME: Not sure if Human race can avert it as stunned effect but it has stun DR
		--236025, -- Enraged Maim --FIXME: same
		-- Hunter
        117526, -- Binding Shot
        19577, -- Intimidation (pet)
		-- Monk
        119381, -- Leg Sweep
		-- Paladin
		853, -- Hammer of Justice
		-- Priest
		200200, -- Holy word: Chastise
		64044, -- Psychic Horror
		-- Rogue
		1833, -- Cheap Shot
        408, -- Kidney Shot
        199804, -- Between the Eyes
		-- Shaman
		118345, -- Pulverize (Primal Earth Elemental)
		118905, -- Static Charge (Capacitor Totem)
		-- Warlock
        30283, -- Shadowfury
        89766, -- Axe Toss (pet)
		22703, -- Summon Infernal
		-- Warrior
        132168, -- Shockwave
        132169, -- Storm Bolt
		237744, -- Warbringer
		-- Tauren
		20549, -- War Stomp
		-- Kul Tiran
		287712, -- Haymaker
    },
    PhysStuned = {
		-- Death Knight
		47481, -- Gnaw (pet)
        212332, -- Smash (transformation pet)
        108194, -- Asphyxiate
		-- Druid
        203123, -- Maim
        5211, -- Mighty Bash
		163505, -- Rake
		-- Hunter
		117526, -- Binding Shot
        19577, -- Intimidation (pet)
		-- Monk
        119381, -- Leg Sweep
        -- Rogue
        1833, -- Cheap Shot
        408, -- Kidney Shot
        199804, -- Between the Eyes
		-- Shaman
		118345, -- Pulverize (Primal Earth Elemental)
        -- Warlock
		89766, -- Axe Toss (pet)
        -- Druid
		203123, -- Maim
        5211, -- Mighty Bash
		163505, -- Rake
		--236025, -- Enraged Maim --FIXME: it's desorient but DR trigger it as stun
		-- Warrior
        132168, -- Shockwave
        132169, -- Storm Bolt
		237744, -- Warbringer
		-- Tauren
		20549, -- War Stomp
		-- Kul Tiran
		287712, -- Haymaker
    },
    Silenced = {
		-- Death Knight
		47476, -- Strangulate (Unholy/Blood)
		-- Demon Hunter
        204490, -- Sigil of Silence (Havoc)
		-- Druid
        78675, -- Solar Beam (Balance)
		-- Hunter
        202933, -- Spider Sting
		-- Paladin
        31935, -- Avenger's Shield	(Prot)
		-- Priest
        15487, -- Silence (Shadow)
		199683, -- Last Word (Holy)
		-- Rogue
        1330, -- Garrote - Silence
        -- Warlock
        31117, -- Unstable Affliction
    },
    Disarmed = {
		-- Rogue
        207777, -- Dismantle
		-- Warrior
        236077, -- Disarm
		-- Monk
        233759, -- Grapple Weapon
		-- Druid
        209749, -- Faerie Swarm
    },
    Rooted = {
        339, -- Entangling Roots Dispel able
        235963, -- Entangling Roots NO Dispel able
        122, -- Frost Nova
        33395, -- Freeze (frost mage water elemental)
        45334, -- Immobilized (wild charge, bear form)
        53148, -- Charge
        64695, -- Earthgrab
        91807, -- Shambling Rush (DK pet)
        102359, -- Mass Entanglement
        105771, -- Charge
        116706, -- Disable
        157997, -- Ice Nova (frost mage talent)
        190927, -- harpoon (survival hunter)
        199042, -- Thunderstruck (Warrior PVP)
        -- 200108, -- Ranger's Net (Hunter talent) (REMOVED)
        201158, -- Super Sticky Tar (Expert Trapper, Hunter talent, Tar Trap effect)
        204085, -- Deathchill (DK PVP)
        212638, -- Tracker's Net (Hunter PvP talent)
        162480, -- Steel Trap (Hunter SV PvE talent)
        228600, -- glacial spike (frost mage talent)
        233395, -- Frozen Center (DK PvP Frost)
        183218, -- Retri's -70%
    },
    Slowed = {
        116, -- Frostbolt
        120, -- Cone of Cold
        2120, -- Flamestrike
        6343, -- Thunder Clap
        1715, -- Hamstring
        3409, -- Crippling Poison
        3600, -- Earthbind
        5116, -- Concussive Shot
        12544, -- Frost Armor
        7992, -- Slowing Poison
        26679, -- Deadly Throw
        35346, -- Warp Time
        44614, -- Flurry
        45524, -- Chains of Ice
        50259, -- Dazed (Wild Charge, druid talent, cat form)
        50433, -- Ankle Crack
        51490, -- Thunderstorm
        61391, -- Typhoon
        12323, -- Piercing Howl
        13810, -- Ice Trap
        15407, -- Mind Flay
        31589, -- Slow
        58180, -- Infected Wounds
        102793, -- Ursol's Vortex
        116095, -- Disable
        121253, -- Keg Smash
        123586, -- Flying Serpent Kick
        135299, -- Tar Trap
        147732, -- Frostbrand Attack
        157981, -- Blast Wave
        160065, -- Tendon Rip
        160067, -- Web Spray
        169733, -- Brutal Bash
        183218, -- Hand of Hindrance
        185763, -- Pistol Shot
        190780, -- Frost Breath (dk frost artifact ability)
        191397, -- Bestial Cunning
        194279, -- Caltrops
        194858, -- Dragonsfire Grenade
        195645, -- Wing Clip
        196840, -- Frost Shock
        198813, -- Vengeful Retreat
        201142, -- Frozen Wake (freezing trap break slow from master trapper survival hunter talent)
        204263, -- Shining Force
        204843, -- Sigil of Chains
        205021, -- Ray of Frost (frost mage talent)
        205320, -- Strike of the Windlord
        205708, -- Chilled (frost mage effect)
        206755, -- Ranger's Net
        206760, -- Night Terrors
        206930, -- Heart Strike
        208278, -- Debilitating Infestation (DK unholy talent)
        209786, -- Goremaw's Bite
        211793, -- Remorseless Winter
        211831, -- Abomination's Might
        212764, -- White Walker
        212792, -- Cone of Cold (frost mage)
        222775, -- Strike from the Shadows
        228354, -- Flurry (frost mage ability)
        210979, -- Focus in the light (holy priest artifact trait)
        248744, -- Shiv
        198145, -- System Shock
    },
    MagicSlowed = {
        116, -- Frostbolt
        120, -- Cone of Cold
        3600, -- Earthbind
        12544, -- Frost Armor
        44614, -- Flurry
        61391, -- Typhoon
        123586, -- Flying Serpent Kick
        147732, -- Frostbrand Attack
        183218, -- Hand of Hindrance
        190780, -- Frost Breath (dk frost artifact ability)
        196840, -- Frost Shock
        201142, -- Frozen Wake (freezing trap break slow from master trapper survival hunter talent)
        204263, -- Shining Force
        204843, -- Sigil of Chains
        205320, -- Strike of the Windlord
        205708, -- Chilled (frost mage effect)
        206760, -- Night Terrors
        209786, -- Goremaw's Bite
        212764, -- White Walker
        212792, -- Cone of Cold (frost mage)
        228354, -- Flurry (frost mage ability)
        210979, -- Focus in the light (holy priest artifact trait)
    },
    BreakAble = {
        118, -- Polymorph
        6770, -- Sap
        20066, -- Repentance
        51514, -- Hex
        2637, -- Hibernate
        5782, -- Fear
        3355, -- Freezing Trap
        209790, -- Freezing Arrow
        6358, -- Seduction
        2094, -- Blind
        19386, -- Wyvern Sting
        82691, -- Ring of Frost
        115078, -- Paralysis
        5484, -- Howl of Terror
        5246, -- Intimidating Shout
        --6789, -- Mortal Coil
        8122, -- Psychic Scream
        99, -- Incapacitating Roar
        1776, -- Gouge
        31661, -- Dragon's Breath
        105421, -- Blinding Light
        186387, -- Bursting Shot
        202274, -- Incendiary brew (brewmaster monk pvp talent)
        207167, -- Blinding Sleet
        213691, -- Scatter Shot
        217832, -- Imprison
        236025, -- Enraged Maim
        207685, -- Sigil of Misery (Havoc Demon hunter)
        -- Rooted CC
        --339, -- Entagle Roots
        212638, -- tracker's net (hunter PvP )
        --102359, -- Mass Entanglement
        --122, -- Frost Nova
        233395, -- Frozen Center (DK PvP Frost)
        107079, -- Quaking Palm
    },
    -- Imun Specific Buffs
    FearImun = {
        212704, -- The Beast Within (Hunter BM PvP)
        287081, -- Lichborne
        8143, -- Tremor Totem
    },
    StunImun = {
        48792, -- Icebound Fortitude
        6615, -- Free Action (Human)
        1953, -- Blink (micro buff)
        287081, -- Lichborne
    },
    Freedom = {
        1044, -- Blessing of Freedom
        48265, -- Death's Advance
        287081, -- Lichborne
        212552, -- Wraith Walk
        227847, -- Bladestorm
        53271, -- Master's Call
        116841, -- Tiger's Lust
        216113, -- Way of the Crane (Monk TT PvP)
    },
    TotalImun = {
		710, -- Banish
        642, -- Divine Shield
        45438, -- Ice Block
        186265, -- Aspect of Turtle
        215769, -- Spirit of Redemption
    },
    DamagePhysImun = {
        1022, -- Blessing of Protection
        188499, -- Blade Dance
        196555, -- Netherwalk
    },
    DamageMagicImun = {    -- When we can't totally damage
        31224, -- Cloak of Shadows
        204018, -- Blessing of Spellwarding
        196555, -- Netherwalk
    },
    CCTotalImun = {
        213610, -- Holy Ward
        227847, -- Bladestorm
    },
    CCMagicImun = {
        31224, -- Cloak of Shadows
        204018, -- Blessing of Spellwarding
        48707, -- Anti-Magic Shell
        8178, -- Grounding Totem Effect
        23920, -- Spell Reflection
        213915, -- Mass reflect
        212295, -- Nether Ward (Warlock)
    },
    Reflect = {            -- Only to cancel reflect effect
        8178, -- Grounding Totem Effect
        23920, -- Spell Reflection
        213915, -- Mass reflect
        212295, -- Nether Ward (Warlock)
    },
    KickImun = { -- Imun Silence too
        209584, -- Zen Focus Tea (Monk TT PvP)
        221703, -- Casting Circle (Warlock PvP)
        196762, -- Inner Focus
        289657, -- Holy Word: Concentration (Holy Priest PvP)
    },
    -- Purje
    ImportantPurje = {
        1022, -- Blessing of Protection
        79206, -- Spiritwalker's Grace
        190319, -- Combustion
        10060, -- Power Infusion
        12042, -- Arcane Power
        12472, -- Icy Veins
        213610, -- Holy Ward
        198111, -- Temporal Shield
        210294, -- Divine Favor
        212295, -- Nether Ward
        271466, -- Luminous Barrier
		311203, -- Moment of Glory
    },
    SecondPurje = {
        1044, -- Blessing of Freedom
        -- We need purje druid only in bear form
        33763, -- Lifebloom
        774, -- Rejuvenation
        155777, -- Rejuvenation (Germination)
        48438, -- Wild Growth
        8936, -- Regrow
        289318, -- Mark of the Wild
    },
    PvEPurje = {
        197797, 210662, 211632, 209033, 198745, 194615, 282098, 301629, 297133, 266201, 258938, 268709, 268375, 274210, 276265,
    },
    -- Speed
    Speed = {
        2983, -- Sprint
        2379, -- Speed
        2645, -- Ghost Wolf
        7840, -- Swim Speed
        36554, -- Shadowstep
        54861, -- Nitro Boosts
        58875, -- Spirit Walk
        65081, -- Body and Soul
        68992, -- Darkflight
        85499, -- Speed of Light
        87023, -- Cauterize
        61684, -- Dash
        77761, -- Stampeding Roar
        108843, -- Blazing Speed
        111400, -- Burning Rush
        116841, -- Tiger's Lust
        118922, -- Posthaste
        119085, -- Chi Torpedo
        121557, -- Angelic Feather
        137452, -- Displacer Beast
        137573, -- Burst of Speed
        192082, -- Wind Rush (shaman wind rush totem talent)
        196674, -- Planewalker (warlock artifact trait)
        197023, -- Cut to the chase (rogue pvp talent)
        199407, -- Light on your feet (mistweaver monk artifact trait)
        201233, -- whirling kicks (windwalaker monk pvp talent)
        201447, -- Ride the wind (windwalaker monk pvp talent)
        209754, -- Boarding Party (rogue pvp talent)
        210980, -- Focus in the light (holy priest artifact trait)
        213177, -- swift as a coursing river (brewmaster artifact trait)
        214121, -- Body and Mind (priest talent)
        215572, -- Frothing Berserker (warrior talent)
        231390, -- Trailblazer (hunter talent)
        186257, -- Aspect of the Cheetah
        204475, -- Windburst (marks hunter artifact ability)
    },
    -- Deff
    DeffBuffsMagic = {
        116849, -- Life Cocoon
        114030, -- Vigilance
        47788, -- Guardian Spirit
        31850, -- Ardent Defender
        871, -- Shield Wall
        118038, -- Die by the Sword
        104773, -- Unending Resolve
        108271, -- Astral Shift
        6940, -- Blessing of Sacrifice
        31224, -- Cloak of Shadows
        48707, -- Anti-Magic Shell
        8178, -- Grounding Totem Effect
        23920, -- Spell Reflection
        213915, -- Mass reflect
        212295, -- Nether Ward (Warlock)
        33206, -- Pain Suppression
        47585, -- Dispersion
        186265, -- Aspect of Turtle
        115176, -- Zen Meditation
        122783, -- Diffuse Magic
        86659, -- Guardian of Ancient Kings
        642, -- Divine Shield
        45438, -- Ice Block
        122278, -- Dampen Harm
        61336, -- Survival Instincts
        45182, -- Cheating Death
        204018, -- Blessing of Spellwarding
        196555, -- Netherwalk
        206803, -- Rain from Above
    },
    DeffBuffs = {
        76577, -- Smoke Bomb
        53480, -- Road of Sacriface
        116849, -- Life Cocoon
        114030, -- Vigilance
        47788, -- Guardian Spirit
        31850, -- Ardent Defender
        871, -- Shield Wall
        118038, -- Die by the Sword
        104773, -- Unending Resolve
        6940, -- Blessing of Sacrifice
        108271, -- Astral Shift
        5277, -- Evasion
        102342, -- Ironbark
        -- 1022, -- Blessing of Protection
        74001, -- Combat Readiness
        -- 31224, -- Cloak of Shadows
        33206, -- Pain Suppression
        47585, -- Dispersion
        186265, -- Aspect of Turtle
        -- 48792, -- Icebound Fortitude
        115176, -- Zen Meditation
        122783, -- Diffuse Magic
        86659, -- Guardian of Ancient Kings
        642, -- Divine Shield
        45438, -- Ice Block
        -- 498, -- Divine Protection
        -- 157913, -- Evanesce
        115203, -- Fortifying Brew
        22812, -- Barkskin
        122278, -- Dampen Harm
        61336, -- Survival Instincts
        45182, -- Cheating Death
        198589, -- Blur
        196555, -- Netherwalk
        243435, -- Fortifying Brew
        206803, -- Rain from Above
    },
    -- Damage buffs / debuffs
    Rage = {
        18499, -- Berserker Rage
        184361, -- Enrage
    },
    DamageBuffs = {
        51690, -- Killing Spree
        -- 79140, -- Vendetta (debuff)
        121471, -- Shadow of Blades
        185313, -- Shadow Dance
        13750, -- Adrenaline Rush
        191427, -- Metamorphosis
        19574, -- Bestial Wrath
        -- 193530, -- Aspect of the Wild (small burst)
        266779, -- Coordinated Assault
        193526, -- Trueshot
        -- 5217, -- Tiger's Fury (small burst)
        106951, -- Berserk
        102560, -- Incarnation: Chosen of Elune
        102543, -- Incarnation: King of the Jungle
        190319, -- Combustion
        12042, -- Arcane Power
        12472, -- Icy Veins
        51271, -- Pillar of Frost
        207289, -- Unholy Frenzy
        31884, -- Avenging Wrath
        236321, -- Warbanner
        107574, -- Avatar
        114050, -- Ascendance
        113858, -- Dark Soul: Instability
        267217, -- Nether Portal
        113860, -- Dark Soul: Misery
        137639, -- Storm, Earth, and Fire
        152173, -- Serenity
    },
    DamageBuffs_Melee = {
        51690, -- Killing Spree
        121471, -- Shadow of Blades
        185313, -- Shadow Dance
        13750, -- Adrenaline Rush
        191427, -- Metamorphosis
        266779, -- Coordinated Assault
        106951, -- Berserk
        102543, -- Incarnation: King of the Jungle
        51271, -- Pillar of Frost
        207289, -- Unholy Frenzy
        31884, -- Avenging Wrath
        236321, -- Warbanner
        107574, -- Avatar
        114050, -- Ascendance
        137639, -- Storm, Earth, and Fire
        152173, -- Serenity
    },
    BurstHaste = {
        90355, -- Ancient Hysteria
        146555, -- Drums of Rage
        178207, -- Drums of Fury
        230935, -- Drums of the Mountain
        2825, -- Bloodlust
        80353, -- Time Warp
        160452, -- Netherwinds
        32182, -- Heroism
        230935, -- Drums of the Mountain
        256740, -- Drums of the Maelstrom
        264667, -- Primal Rage
        390386, -- Fury of the Aspects
        386540, -- Temporal Warp
        381301, -- Feral Hide Drums
    },
    -- SOME SPECIAL
    DamageDeBuffs = {
        79140, -- Vendetta (debuff)
        115080, -- Touhc of Death (debuff)
        122470, -- KARMA
    },
    Flags = {
        156621, -- Alliance flag
        23333,  -- Horde flag
        34976,  -- Netherstorm Flag
        121164, -- Orb of Power
    },
    -- Cast Bars
    Reshift = {
        {118, 45}, -- Polymorph (45 coz of blink available)
        {20066, 30}, -- Repentance
        {51514, 30}, -- Hex
        {19386, 40}, -- Wyvern Sting
    },
    Premonition = {
        {113724, 30}, -- Ring of Frost
        {118, 45}, -- Polymorph (45 coz of blink available while cast)
        {20066, 30}, -- Repentance
        {51514, 30}, -- Hex
        {19386, 40}, -- Wyvern Sting
        {5782, 30}, -- Fear
    },
    CastBarsCC = {
        113724, -- Ring of Frost
        118, -- Polymorph
        20066, -- Repentance
        51514, -- Hex
        19386, -- Wyvern Sting
        5782, -- Fear
        33786, -- Cyclone
        605, -- Mind Control
    },
    AllPvPKickCasts = {
        118, -- Polymorph
        20066, -- Repentance
        51514, -- Hex
        19386, -- Wyvern Sting
        5782, -- Fear
        33786, -- Cyclone
        605, -- Mind Control
        982, -- Revive Pet
        32375, -- Mass Dispel
        203286, -- Greatest Pyroblast
        116858, -- Chaos Bolt
        20484, -- Rebirth
        203155, -- Sniper Shot
        47540, -- Penance
        596, -- Prayer of Healing
        2060, -- Heal
        2061, -- Flash Heal
        32546, -- Binding Heal                        (priest, holy)
        33076, -- Prayer of Mending
        64843, -- Divine Hymn
        120517, -- Halo                                (priest, holy/disc)
        186263, -- Shadow Mend
        194509, -- Power Word: Radiance
        265202, -- Holy Word: Salvation                (priest, holy)
        289666, -- Greater Heal                        (priest, holy)
        740, -- Tranquility
        8936, -- Regrowth
        48438, -- Wild Growth
        289022, -- Nourish                             (druid, restoration)
        1064, -- Chain Heal
        8004, -- Healing Surge
        73920, -- Healing Rain
        77472, -- Healing Wave
        197995, -- Wellspring                          (shaman, restoration)
        207778, -- Downpour                            (shaman, restoration)
        19750, -- Flash of Light
        82326, -- Holy Light
        116670, -- Vivify
        124682, -- Enveloping Mist
        209525, -- Soothing Mist
        227344, -- Surging Mist                        (monk, mistweaver)
    },
}

local InCombatLockdown = _G.InCombatLockdown

local GetPlayerAuraBySpellID = _G.C_UnitAuras and _G.C_UnitAuras.GetPlayerAuraBySpellID
local GetAuraDataBySpellName = _G.C_UnitAuras and _G.C_UnitAuras.GetAuraDataBySpellName

local function TryDirectAuraLookup(unitID, spellID, filter)
	if not spellID or type(spellID) ~= "number" then return nil end
	if UnitIsUnit(unitID, "player") and GetPlayerAuraBySpellID then
		local ok, ad = pcall(GetPlayerAuraBySpellID, spellID)
		if ok and ad then
			local auraData = UnwrapAuraData(ad)
			if not auraData or type(auraData.spellId) ~= "number" then
				return nil
			end

			local expTime = auraData.expirationTime
			if type(expTime) ~= "number" then
				return nil
			end

			local dur = type(auraData.duration) == "number" and auraData.duration or 0
			local apps = type(auraData.applications) == "number" and auraData.applications or 0
			return expTime == 0 and huge or expTime - TMW.time, dur, apps == 0 and 1 or apps
		end
	end
	return nil
end

local function TryDirectAuraLookupMulti(unitID, spell, filter)
	if not InCombatLockdown() then return nil end
	local spellType = type(spell)
	if spellType == "number" then
		local remain, dur, stacks = TryDirectAuraLookup(unitID, spell, filter)
		if remain then return remain, dur, stacks end
		if AuraList[spell] then
			for _, auraID in ipairs(AuraList[spell]) do
				remain, dur, stacks = TryDirectAuraLookup(unitID, auraID, filter)
				if remain then return remain, dur, stacks end
			end
		end
	elseif spellType == "table" then
		for i = 1, #spell do
			local v = spell[i]
			if type(v) == "number" then
				local remain, dur, stacks = TryDirectAuraLookup(unitID, v, filter)
				if remain then return remain, dur, stacks end
				if AuraList[v] then
					for _, auraID in ipairs(AuraList[v]) do
						remain, dur, stacks = TryDirectAuraLookup(unitID, auraID, filter)
						if remain then return remain, dur, stacks end
					end
				end
			end
		end
	end
	return nil
end

local function TrySECacheAura(unitID, spell, filter)
	if not SE or not SE.GetCachedAura then return nil end
	if not InCombatLockdown() then return nil end
	local spellType = type(spell)
	if spellType == "number" then
		local remain, dur = SE:GetCachedAura(unitID, spell, filter)
		if remain and remain > 0 then return remain, dur end
		if AuraList[spell] then
			for _, auraID in ipairs(AuraList[spell]) do
				remain, dur = SE:GetCachedAura(unitID, auraID, filter)
				if remain and remain > 0 then return remain, dur end
			end
		end
	elseif spellType == "table" then
		local bestRemain, bestDur = 0, 0
		for i = 1, #spell do
			local v = spell[i]
			if type(v) == "number" then
				local remain, dur = SE:GetCachedAura(unitID, v, filter)
				if remain and remain > bestRemain then bestRemain = remain; bestDur = dur end
				if AuraList[v] then
					for _, auraID in ipairs(AuraList[v]) do
						remain, dur = SE:GetCachedAura(unitID, auraID, filter)
						if remain and remain > bestRemain then bestRemain = remain; bestDur = dur end
					end
				end
			elseif type(v) == "string" and AuraList[v] then
				for _, auraID in ipairs(AuraList[v]) do
					local remain, dur = SE:GetCachedAura(unitID, auraID, filter)
					if remain and remain > bestRemain then bestRemain = remain; bestDur = dur end
				end
			end
		end
		if bestRemain > 0 then return bestRemain, bestDur end
	elseif spellType == "string" and AuraList[spell] then
		local bestRemain, bestDur = 0, 0
		for _, auraID in ipairs(AuraList[spell]) do
			local remain, dur = SE:GetCachedAura(unitID, auraID, filter)
			if remain and remain > bestRemain then bestRemain = remain; bestDur = dur end
		end
		if bestRemain > 0 then return bestRemain, bestDur end
	end
	if SE.GetWatchedBuff and filter == "HELPFUL" and UnitIsUnit(unitID, "player") then
		if spellType == "number" then
			local r, d = SE:GetWatchedBuff(spell)
			if r > 0 then return r, d end
		elseif spellType == "table" then
			for i = 1, #spell do
				if type(spell[i]) == "number" then
					local r, d = SE:GetWatchedBuff(spell[i])
					if r > 0 then return r, d end
				end
			end
		end
	end
	return nil
end

local function TrySECacheStacks(unitID, spell, filter)
	if not SE or not SE.GetCachedAuraStacks then return nil end
	if not InCombatLockdown() then return nil end
	local spellType = type(spell)
	if spellType == "number" then
		local stacks = SE:GetCachedAuraStacks(unitID, spell, filter)
		if stacks and stacks > 0 then return stacks end
		if AuraList[spell] then
			for _, auraID in ipairs(AuraList[spell]) do
				stacks = SE:GetCachedAuraStacks(unitID, auraID, filter)
				if stacks and stacks > 0 then return stacks end
			end
		end
	elseif spellType == "table" then
		for i = 1, #spell do
			local v = spell[i]
			if type(v) == "number" then
				local stacks = SE:GetCachedAuraStacks(unitID, v, filter)
				if stacks and stacks > 0 then return stacks end
				if AuraList[v] then
					for _, auraID in ipairs(AuraList[v]) do
						stacks = SE:GetCachedAuraStacks(unitID, auraID, filter)
						if stacks and stacks > 0 then return stacks end
					end
				end
			elseif type(v) == "string" and AuraList[v] then
				for _, auraID in ipairs(AuraList[v]) do
					local stacks = SE:GetCachedAuraStacks(unitID, auraID, filter)
					if stacks and stacks > 0 then return stacks end
				end
			end
		end
	elseif spellType == "string" and AuraList[spell] then
		for _, auraID in ipairs(AuraList[spell]) do
			local stacks = SE:GetCachedAuraStacks(unitID, auraID, filter)
			if stacks and stacks > 0 then return stacks end
		end
	end
	if SE.GetWatchedBuffStacks and filter == "HELPFUL" and UnitIsUnit(unitID, "player") then
		if spellType == "number" then
			local s = SE:GetWatchedBuffStacks(spell)
			if s > 0 then return s end
		elseif spellType == "table" then
			for i = 1, #spell do
				if type(spell[i]) == "number" then
					local s = SE:GetWatchedBuffStacks(spell[i])
					if s > 0 then return s end
				end
			end
		end
	end
	return nil
end

local AssociativeTables = setmetatable({ NullTable = {} }, { -- Only for Auras!
	--__mode = "kv",
	__index = function(t, v)
	-- @return table
	-- Returns converted array like table to associative like with key-val as spellName and spellID with true val
	-- For situations when Action is not initialized and when 'v' is table always return self 'v' to keep working old profiles which use array like table
	-- Note: GetSpellName instead of A_GetSpellInfo because we will use it one time either if GC collected dead links, pointless for performance A_GetSpellInfo anyway
	if not v then
		if A.IsInitialized then -- old profiles are funky some times..
			local error_snippet = debugstack():match("%p%l+%s\"?%u%u%u%s%u%l.*")
			if error_snippet then
				error("Unit.lua script tried to put in AssociativeTables 'nil' as index and it caused null table return. The script successfully found the first occurrence of the error stack in the TMW snippet: " .. error_snippet, 0)
			else
				error("Unit.lua script tried to put in AssociativeTables 'nil' as index and it caused null table return.\n" .. debugstack())
			end
		end
		return t.NullTable
	end

	local v_type = type(v)
	if v_type == "table" then
		if not A.IsInitialized then
			--print("NON-STATIC:", tostring(v), " Key:", next(v))
			return v
		end

		if #v > 0 then
			t[v] = {}

			local index, val = next(v)
			while index ~= nil do
				if type(val) == "string" then
					if AuraList[val] then
						-- Put associatived spellName (@string) and spellID (@number)
						for spellNameOrID, spellBoolean in pairs(t[val]) do
							t[v][spellNameOrID] = spellBoolean
						end
					else -- Here is expected name of the spell always
						-- Put associatived spellName (@string)
						t[v][val] = true
					end
				else -- Here is expected id of the spell always
					-- Put associatived spellName (@string)
					local spellName = GetSpellName(val)
					if spellName then
						t[v][spellName] = true
					end

					-- Put associatived spellID (@number)
					t[v][val] = true
				end

				index, val = next(v, index)
			end
		else
			t[v] = v
		end
	elseif AuraList[v] then
		t[v] = {}

		local spellName
		for _, spellID in ipairs(AuraList[v]) do
			spellName = GetSpellName(spellID)
			if spellName then
				t[v][spellName] = true
			end
			t[v][spellID] = true
		end
	else
		-- Otherwise create new table and put spellName with spellID (if possible) for single entrance to keep return @table
		t[v] = {}

		local spellName = GetSpellName(v_type == "string" and not v:find("%D") and toNum[v] or v) -- TMW lua code passing through 'thisobj.Name' @string type
		if spellName then
			t[v][spellName] = true
		end

		t[v][v] = true
	end

	--print("Created associatived table:")
	--print(tostring(v), "  Output:", tostring(t[v]), " Key:", next(t[v]))

	return t[v]
end })

local IsMustBeByID = {
	-- Note: This table holds all spellIDs which must be always query byID since they have shared spellNames but different effects!
	-- Warlock
	[31117] 		= true, 	-- Unstable Affliction (silence after dispel)
	-- Druid
	[163505] 		= true, 	-- Rake (stun from stealth)
	--[231052] 		= true, 	-- Rake (dot) spell -- seems old id which is not valid in BFA
	[155722] 		= true, 	-- Rake (dot)
	[203123] 		= true, 	-- Maim (stun)
	[236025] 		= true, 	-- Enraged Maim (incapacitate)
	[339] 			= true, 	-- Entangling Roots (dispel able)
	[235963] 		= true, 	-- Entangling Roots (NO dispel able)
	-- Death Knight
	[204085] 		= true, 	-- Deathchill (Frost - PvP Roots)
	[207171] 		= true, 	-- Winter is Coming (Frost - Remorseless Winter Stun)
	-- Rogue
	[703] 			= true, 	-- Garroute - Dot
	[1330] 			= true, 	-- Garroute - Silence
	-- Paladin
	--[216411] 		= true, 	-- BUFFS: Holy Shock 	(Divine Purpose)
	--[216413] 		= true, 	-- BUFFS: Light of Down (Divine Purpose)
	-- Priest
	[200200] 		= true, 	-- Holy word: Chastise (Holy stun)
	[200196] 		= true, 	-- Holy Word: Chastise (Holy incapacitate)
	-- Demon Hunter
	[217832]		= true, 	-- Imprison
	[200166]		= true, 	-- Metamorphosis
}

local function IsAuraEqual(spellName, spellID, spellInput, byID)
	-- @return boolean
	local ok, result = pcall(function()
		if byID then
			if #spellInput > 0 then 				-- ArrayTables
				for i = 1, #spellInput do
					if AuraList[spellInput[i]] then
						for _, auraListID in ipairs(AuraList[spellInput[i]]) do
							if spellID == auraListID then
								return true
							end
						end
					elseif spellID == spellInput[i] then
						return true
					end
				end
			else 									-- AssociativeTables
				return spellInput[spellID]
			end
		else
			if #spellInput > 0 then 				-- ArrayTables
				for i = 1, #spellInput do
					if AuraList[spellInput[i]] then
						for _, auraListID in ipairs(AuraList[spellInput[i]]) do
							if spellName == A_GetSpellInfo(auraListID) then
								return true
							end
						end
					elseif type(spellInput[i]) == "number" and spellID == spellInput[i] then
						return true
					elseif IsMustBeByID[spellInput[i]] then -- Retail only
						if spellID == spellInput[i] then
							return true
						end
					elseif spellName == A_GetSpellInfo(spellInput[i]) then
						return true
					end
				end
			else 									-- AssociativeTables
				return spellInput[spellName] or spellInput[spellID]
			end
		end
	end)
	return ok and result
end

-------------------------------------------------------------------------------
-- API: Core (Action Rotation Conditions)
-------------------------------------------------------------------------------
function A.GetAuraList(key)
	-- @return table
    return AuraList[key]
end

function A.IsUnitFriendly(unitID)
	-- @return boolean
	if unitID == "mouseover" then
		return 	GetToggle(2, unitID) and MouseHasFrame() and not A_Unit(unitID):IsEnemy()
	else
		return 	(
					not GetToggle(2, "mouseover") or
					not A_Unit("mouseover"):IsExists() or
					A_Unit("mouseover"):IsEnemy()
				) and
				not A_Unit(unitID):IsEnemy() and
				A_Unit(unitID):IsExists()
	end
end
A.IsUnitFriendly = A.MakeFunctionCachedDynamic(A.IsUnitFriendly)

function A.IsUnitEnemy(unitID)
	-- @return boolean
	if unitID == "mouseover" then
		return  GetToggle(2, unitID) and A_Unit(unitID):IsEnemy()
	elseif unitID == "focustarget" then
		return 	GetToggle(2, unitID) and
				( not GetToggle(2, "mouseover") or not A_Unit("mouseover"):IsEnemy() ) and
				not A_Unit("target"):IsEnemy() and
				-- Exception to don't pull by mistake mob
				A_Unit(unitID):CombatTime() > 0 and
				A_Unit(unitID):IsEnemy() and
				-- LOS checking
				not UnitInLOS(unitID)
	elseif unitID == "targettarget" then
		return 	GetToggle(2, unitID) and
				( not GetToggle(2, "mouseover") or not A_Unit("mouseover"):IsEnemy() ) and
				( not GetToggle(2, "focustarget") or not A_Unit("focustarget"):IsEnemy() ) and
				not A_Unit("target"):IsEnemy() and
				-- Exception to don't pull by mistake mob
				A_Unit(unitID):CombatTime() > 0 and
				A_Unit(unitID):IsEnemy() and
				-- LOS checking
				not UnitInLOS(unitID)
	else
		return 	( not GetToggle(2, "mouseover") or not MouseHasFrame() ) and A_Unit(unitID):IsEnemy()
	end
end
A.IsUnitEnemy = A.MakeFunctionCachedDynamic(A.IsUnitEnemy)

-------------------------------------------------------------------------------
-- API: Unit
-------------------------------------------------------------------------------
local Info = {
	CacheMoveIn					= setmetatable({}, { __mode = "kv" }),
	CacheMoveOut				= setmetatable({}, { __mode = "kv" }),
	CacheMoving 				= setmetatable({}, { __mode = "kv" }),
	CacheStaying				= setmetatable({}, { __mode = "kv" }),
	CacheInterrupt 				= setmetatable({}, { __mode = "kv" }),
	SpecsWithExecute			= {71, 72},
	SpecsMoonkinRestor			= {102, 105},
	SpecsFeralGuardian			= {103, 104},
	SpecIs 						= {
        ["MELEE"] 				= {251, 252, 577, 1480, 103, BuildToC >= 70003 and 255 or nil, 269, 70, 259, 260, 261, 263, 71, 72, 250, 581, 104, 268, 66, 73},
        ["RANGE"] 				= {102, 253, 254, BuildToC < 70003 and 255 or nil, 62, 63, 64, 258, 262, 265, 266, 267},
        ["HEALER"] 				= {105, 270, 65, 256, 257, 264, 1468, 1473},
        ["TANK"] 				= {250, 581, 104, 268, 66, 73},
        ["DAMAGER"] 			= {251, 252, 577, 1480, 103, 255, 269, 70, 259, 260, 261, 263, 71, 72, 102, 253, 254, 62, 63, 64, 258, 262, 265, 266, 267, 1467},
    },
	ClassSpecBuffs				= {
		["WARRIOR"] 			= {
			[CONST.WARRIOR_ARMS] = {
				56638, 								-- Taste for Blood
				64976, 								-- Juggernaut
			}, 
			[CONST.WARRIOR_FURY] = 29801, 			-- Rampage
			[CONST.WARRIOR_PROTECTION] = 50227, 	-- Sword and Board
		},
		["PALADIN"]	= {
			[CONST.PALADIN_RETRIBUTION] = 20375,	-- Seal of Command
			[CONST.PALADIN_HOLY] = 31836,			-- Light's Grace
			[CONST.PALADIN_PROTECTION] = 25781,		-- Righteous Fury
		},
		["HUNTER"] = {
			[CONST.HUNTER_BEASTMASTERY] = 20895,	-- Spirit Bond
			[CONST.HUNTER_MARKSMANSHIP] = 19506,	-- Trueshot Aura
		},
		["ROGUE"] = {
			[CONST.ROGUE_SUBTLETY] = {
				36554, 								-- Shadowstep
				31223,								-- Master of Subtlety
			},
			[CONST.ROGUE_OUTLAW] = 51690,			-- Killing Spree
		},
		["PRIEST"] = {
			[CONST.PRIEST_HOLY] = 47788,			-- Guardian Spirit
			[CONST.PRIEST_DISCIPLINE] = 52800,		-- Borrowed Time
			[CONST.PRIEST_SHADOW] = {
				15473, 								-- Shadowform
				15286,								-- Vampiric Embrace
			},
		},
		["SHAMAN"] = {
			[CONST.SHAMAN_ELEMENTAL] = {
				57663,								-- Totem of Wrath
				51470,								-- Elemental Oath
			},
			[CONST.SHAMAN_ENCHANCEMENT] = 30809,	-- Unleashed Rage
			[CONST.SHAMAN_RESTORATION] = 49284,		-- Earth Shield
		},
		["MAGE"] = {
			[CONST.MAGE_FROST] = 43039,				-- Ice Barrier
			[CONST.MAGE_FIRE] = 11129,				-- Combustion
			[CONST.MAGE_ARCANE] = 31583,			-- Arcane Empowerment
		},
		["WARLOCK"] = {
			[CONST.WARLOCK_DESTRUCTION] = 30302,	-- Nether Protection
		},
		["DRUID"] = {
			[CONST.DRUID_BALANCE] = 24907,			-- Moonkin Aura
			[CONST.DRUID_FERAL] = 24932,			-- Leader of the Pack
			[CONST.DRUID_RESTORATION] = 34123,		-- Tree of Life
		},
		["DEATHKNIGHT"] = {
			[CONST.DEATHKNIGHT_UNHOLY] = 49222,		-- Bone Shield
			[CONST.DEATHKNIGHT_FROST] = 55610,		-- Icy Talons
			[CONST.DEATHKNIGHT_BLOOD] = {
				49016,								-- Hysteria
				53138,								-- Abomination's Might
			},
		},
	},
	ClassSpecSpells 			= {
		["WARRIOR"]				= {
			[CONST.WARRIOR_ARMS] = {
				47486,								-- Mortal Strike
				46924,								-- Bladestorm
				56638, 								-- Taste for Blood
				64976, 								-- Juggernaut
			},
			[CONST.WARRIOR_FURY] = {
				23881,								-- Bloodthirst
				29801, 								-- Rampage
			},
			[CONST.WARRIOR_PROTECTION] = {
				47498,								-- Devastate
				50227, 								-- Sword and Board
			},
		},
		["PALADIN"]	= {
			[CONST.PALADIN_RETRIBUTION] = {
				35395,								-- Crusader Strike
				53385,								-- Divine Storm
				20066,								-- Repentance
				20375,								-- Seal of Command
			}, 
			[CONST.PALADIN_HOLY] = {
				48825,								-- Holy Shock
				31836,								-- Light's Grace
			},
			[CONST.PALADIN_PROTECTION] = 48827,		-- Avenger's Shield
		},
		["HUNTER"] = {
			[CONST.HUNTER_BEASTMASTERY] = {
				19577,								-- Intimidation
				20895,								-- Spirit Bond
			},
			[CONST.HUNTER_MARKSMANSHIP] = {
				34490,								-- Silencing Shot
				53209,								-- Chimera Shot
				19506,								-- Trueshot Aura
			},
			[CONST.HUNTER_SURVIVAL] = {
				60053,								-- Explosive Shot
			},
		},
		["ROGUE"] = {
			[CONST.ROGUE_ASSASSINATION] = 48666,	-- Mutilate
			[CONST.ROGUE_OUTLAW] = {
				51690, 								-- Killing Spree
				13877,								-- Blade Flurry
				13750,								-- Adrenaline Rush
			},
			[CONST.ROGUE_SUBTLETY] = {
				48660,								-- Hemorrhage
				36554, 								-- Shadowstep
				31223,								-- Master of Subtlety
			},
		},
		["PRIEST"] = {
			[CONST.PRIEST_HOLY] = {
				34861,								-- Circle of Healing
				47788,								-- Guardian Spirit
			},
			[CONST.PRIEST_DISCIPLINE] = {
				33206,								-- Pain Suppression
				10060,								-- Power Infusion
				53007,								-- Penance
				52800,								-- Borrowed Time
			},
			[CONST.PRIEST_SHADOW] = {
				15473, 								-- Shadowform
				15286,								-- Vampiric Embrace
				15487,								-- Silence
				48160,								-- Vampiric Touch
			},
		},
		["SHAMAN"] = {
			[CONST.SHAMAN_ELEMENTAL] = {
				57663,								-- Totem of Wrath
				51470,								-- Elemental Oath
				59159,								-- Thunderstorm
				16166,								-- Elemental Mastery
			},
			[CONST.SHAMAN_ENCHANCEMENT] = {
				30809,								-- Unleashed Rage
				51533,								-- Feral Spirit
				30823,								-- Shamanistic Rage
				17364,								-- Stormstrike
			},
			[CONST.SHAMAN_RESTORATION] = {
				49284,								-- Earth Shield
				61301,								-- Riptide
				51886,								-- Cleanse Spirit
			},
		},
		["MAGE"] = {
			[CONST.MAGE_FROST] = {
				43039,								-- Ice Barrier
				44572,								-- Deep Freeze
			},
			[CONST.MAGE_FIRE] = {
				11129,								-- Combustion
				42945,								-- Blast Wave
				42950,								-- Dragon's Breath
				55360,								-- Living Bomb
			},
			[CONST.MAGE_ARCANE] = {
				31583,								-- Arcane Empowerment
				44781,								-- Arcane Barrage
			},
		},
		["WARLOCK"] = {
			[CONST.WARLOCK_AFFLICTION] = {
				59164,								-- Haunt
				47843,								-- Unstable Affliction
			},
			[CONST.WARLOCK_DEMONOLOGY] = 59672,		-- Metamorphosis
			[CONST.WARLOCK_DESTRUCTION] = {
				30302,								-- Nether Protection
				59172,								-- Chaos Bolt
				47847,								-- Shadowfury
			},
		},
		["DRUID"] = {
			[CONST.DRUID_BALANCE] = {
				24907,								-- Moonkin Aura
				53201,								-- Starfall
				61384,								-- Typhoon
			},
			[CONST.DRUID_FERAL] = {
				24932,								-- Leader of the Pack
				48566,								-- Mangle (Cat)
				48564,								-- Mangle (Bear)
			},
			[CONST.DRUID_RESTORATION] = {
				34123,								-- Tree of Life
				18562,								-- Swiftmend
			},
		},
		["DEATHKNIGHT"] = {
			[CONST.DEATHKNIGHT_UNHOLY] = {
				49222,								-- Bone Shield
				55271,								-- Scourge Strike
			},
			[CONST.DEATHKNIGHT_FROST] = {
				55610,								-- Icy Talons
				55268,								-- Frost Strike
				51411,								-- Howling Blast
				49203,								-- Hungering Cold
			},
			[CONST.DEATHKNIGHT_BLOOD] = {
				49016,								-- Hysteria
				53138,								-- Abomination's Might
				55262,								-- Heart Strike
			},
		},
	},
	ClassIsMelee = {
        ["WARRIOR"] 			= true,
        ["PALADIN"] 			= true,
        ["HUNTER"] 				= false,
        ["ROGUE"] 				= true,
        ["PRIEST"] 				= false,
        ["DEATHKNIGHT"] 		= true,
        ["SHAMAN"] 				= false,
        ["MAGE"] 				= false,
        ["WARLOCK"] 			= false,
        ["MONK"] 				= true,
        ["DRUID"] 				= false,
        ["DEMONHUNTER"] 		= true,
    },
	ClassCanBeHealer			= {
		["PALADIN"] 			= true,
		["PRIEST"]				= true,
		["SHAMAN"] 				= true,
		["DRUID"] 				= true,
		["MONK"]				= true,
		["EVOKER"]				= true,
	},
	ClassCanBeTank				= {
        ["WARRIOR"] 			= 71,						-- Defensive Stance
        ["PALADIN"] 			= 25781, 					-- Righteous Fury
        ["DRUID"] 				= {5487, 9634},				-- Bear Form, Dire Bear Form
		["MONK"]				= true,
		["SHAMAN"]				= BuildToC < 30000, 		-- T3 tank in Classic/TBC possible 
		["DEMONHUNTER"]			= true,
		["DEATHKNIGHT"]			= 48263,					-- Blood Presence		
	},
	ClassCanBeMelee				= {
        ["WARRIOR"] 			= true,
        ["PALADIN"] 			= true,
		["HUNTER"]				= BuildToC >= 70003,
        ["ROGUE"] 				= true,
        ["SHAMAN"] 				= true,
        ["DRUID"] 				= true,
		["MONK"]				= true,
		["DEMONHUNTER"]			= true,
		["DEATHKNIGHT"]			= true,
	},
	AllCC 						= {"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"},
	CreatureType				= setmetatable(
		-- Formats localization to English locale
		-- Revision BFA 8.3.0.33941 April 2020
		{
			enUS				= {
				["Beast"]				= "Beast",				-- [1]
				["Dragonkin"]			= "Dragonkin",			-- [2]
				["Demon"]				= "Demon",				-- [3]
				["Elemental"]			= "Elemental",			-- [4]
				["Giant"]				= "Giant",				-- [5]
				["Undead"]				= "Undead",				-- [6]
				["Humanoid"]			= "Humanoid",			-- [7]
				["Critter"]				= "Critter",			-- [8]
				["Mechanical"]			= "Mechanical",			-- [9]
				["Not specified"]		= "Not specified",		-- [10]
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["Totem"]				= "Totem",				-- [11]
				["Non-combat Pet"]		= "Non-combat Pet",		-- [12]
				["Gas Cloud"]			= "Gas Cloud",			-- [13]
				["Wild Pet"]			= "Wild Pet",			-- [14]
				["Aberration"]			= "Aberration",			-- [15]
			},
			ruRU				= {
				["Ãâ€“ÃÂ¸ÃÂ²ÃÂ¾Ã‘â€šÃÂ½ÃÂ¾ÃÂµ"]			= "Beast",				-- [1]
				["Ãâ€Ã‘â‚¬ÃÂ°ÃÂºÃÂ¾ÃÂ½"]				= "Dragonkin",			-- [2]
				["Ãâ€ÃÂµÃÂ¼ÃÂ¾ÃÂ½"]				= "Demon",				-- [3]
				["ÃÂ­ÃÂ»ÃÂµÃÂ¼ÃÂµÃÂ½Ã‘â€šÃÂ°ÃÂ»Ã‘Å’"]			= "Elemental",			-- [4]
				["Ãâ€™ÃÂµÃÂ»ÃÂ¸ÃÂºÃÂ°ÃÂ½"]				= "Giant",				-- [5]
				["ÃÂÃÂµÃÂ¶ÃÂ¸Ã‘â€šÃ‘Å’"]				= "Undead",				-- [6]
				["Ãâ€œÃ‘Æ’ÃÂ¼ÃÂ°ÃÂ½ÃÂ¾ÃÂ¸ÃÂ´"]			= "Humanoid",			-- [7]
				["ÃÂ¡Ã‘Æ’Ã‘â€°ÃÂµÃ‘ÂÃ‘â€šÃÂ²ÃÂ¾"]			= "Critter",			-- [8]
				["ÃÅ“ÃÂµÃ‘â€¦ÃÂ°ÃÂ½ÃÂ¸ÃÂ·ÃÂ¼"]			= "Mechanical",			-- [9]
				["ÃÂÃÂµ Ã‘Æ’ÃÂºÃÂ°ÃÂ·ÃÂ°ÃÂ½ÃÂ¾"]			= "Not specified",		-- [10]
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["ÃÂ¢ÃÂ¾Ã‘â€šÃÂµÃÂ¼"]				= "Totem",				-- [11]
				["ÃÂ¡ÃÂ¿Ã‘Æ’Ã‘â€šÃÂ½ÃÂ¸ÃÂº"]				= "Non-combat Pet",		-- [12]
				["ÃÅ¾ÃÂ±ÃÂ»ÃÂ°ÃÂºÃÂ¾ ÃÂ³ÃÂ°ÃÂ·ÃÂ°"]			= "Gas Cloud",			-- [13]
				["Ãâ€ÃÂ¸ÃÂºÃÂ¸ÃÂ¹ ÃÂ¿ÃÂ¸Ã‘â€šÃÂ¾ÃÂ¼ÃÂµÃ‘â€ "]		= "Wild Pet",			-- [14]
				["ÃÂÃÂ±ÃÂµÃ‘â‚¬Ã‘â‚¬ÃÂ°Ã‘â€ ÃÂ¸Ã‘Â"]			= "Aberration",			-- [15]
			},
			frFR				= {
				["BÃƒÂªte"]				= "Beast",				-- [1]
				["Draconien"]			= "Dragonkin",			-- [2]
				["DÃƒÂ©mon"]				= "Demon",				-- [3]
				["Ãƒâ€°lÃƒÂ©mentaire"]			= "Elemental",			-- [4]
				["GÃƒÂ©ant"]				= "Giant",				-- [5]
				["Mort-vivant"]			= "Undead",				-- [6]
				["HumanoÃƒÂ¯de"]			= "Humanoid",			-- [7]
				["Bestiole"]			= "Critter",			-- [8]
				["MÃƒÂ©canique"]			= "Mechanical",			-- [9] -- Classic
				["Machine"]				= "Mechanical",			-- [9] -- Retail
				["Non spÃƒÂ©cifiÃƒÂ©"]		= "Not specified",		-- [10]
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["Totem"]				= "Totem",				-- [11]
				["Mascotte pacifique"]	= "Non-combat Pet",		-- [12]
				["Nuage de gaz"]		= "Gas Cloud",			-- [13]
				["Mascotte sauvage"]	= "Wild Pet",			-- [14]
				["Aberration"]			= "Aberration",			-- [15]
			},
			deDE				= {
				["Wildtier"]			= "Beast",				-- [1]
				["Drachkin"]			= "Dragonkin",			-- [2]
				["DÃƒÂ¤mon"]				= "Demon",				-- [3]
				["Elementar"]			= "Elemental",			-- [4]
				["Riese"]				= "Giant",				-- [5]
				["Untoter"]				= "Undead",				-- [6]
				["Humanoid"]			= "Humanoid",			-- [7]
				["Tier"]				= "Critter",			-- [8] -- Classic
				["Kleintier"]			= "Critter",			-- [8] -- Retail
				["Mechanisch"]			= "Mechanical",			-- [9]
				["Nicht spezifiziert"]	= "Not specified",		-- [10]
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["Totem"]				= "Totem",				-- [11]
				["Haustier"]			= "Non-combat Pet",		-- [12]
				["Gaswolke"]			= "Gas Cloud",			-- [13]
				["UngezÃƒÂ¤hmtes Tier"]	= "Wild Pet",			-- [14]
				["Entartung"]			= "Aberration",			-- [15]
			},
			esES				= {
				["Bestia"]				= "Beast",				-- [1]
				["Dragonante"]			= "Dragonkin",			-- [2]
				["Demonio"]				= "Demon",				-- [3]
				["Elemental"]			= "Elemental",			-- [4]
				["Gigante"]				= "Giant",				-- [5]
				["No-muerto"]			= "Undead",				-- [6]
				["Humanoide"]			= "Humanoid",			-- [7]
				["AlimaÃƒÂ±a"]				= "Critter",			-- [8]
				["MecÃƒÂ¡nico"]			= "Mechanical",			-- [9]
				["Sin especificar"]		= "Not specified",		-- [10]
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["TÃƒÂ³tem"]				= "Totem",				-- [11]
				["Mascota mansa"]		= "Non-combat Pet",		-- [12]
				["Nube de gas"]			= "Gas Cloud",			-- [13]
				["Mascota salvaje"]		= "Wild Pet",			-- [14]
				["AberraciÃƒÂ³n"]			= "Aberration",			-- [15]
			},
			ptPT				= {
				["Fera"]				= "Beast",				-- [1]
				["Draconiano"]			= "Dragonkin",			-- [2]
				["DemÃƒÂ´nio"]				= "Demon",				-- [3]
				["Elemental"]			= "Elemental",			-- [4]
				["Gigante"]				= "Giant",				-- [5]
				["Morto-vivo"]			= "Undead",				-- [6]
				["Humanoide"]			= "Humanoid",			-- [7]
				["Bicho"]				= "Critter",			-- [8]
				["MecÃƒÂ¢nico"]			= "Mechanical",			-- [9]
				["NÃƒÂ£o Especificado"]	= "Not specified",		-- [10]
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["Totem"]				= "Totem",				-- [11]
				["Mascote"]				= "Non-combat Pet",		-- [12]
				["Nuvem de GÃƒÂ¡s"]		= "Gas Cloud",			-- [13]
				["Mascote Selvagem"]	= "Wild Pet",			-- [14]
				["AberraÃƒÂ§ÃƒÂ£o"]			= "Aberration",			-- [15]
			},
			itIT				= {
				["Bestia"]				= "Beast",				-- [1]
				["Dragoide"]			= "Dragonkin",			-- [2]
				["Demone"]				= "Demon",				-- [3]
				["Elementale"]			= "Elemental",			-- [4]
				["Gigante"]				= "Giant",				-- [5]
				["Non Morto"]			= "Undead",				-- [6]
				["Umanoide"]			= "Humanoid",			-- [7]
				["Animale"]				= "Critter",			-- [8]
				["UnitÃƒÂ  Meccanica"]		= "Mechanical",			-- [9]
				["Non Specificato"]		= "Not specified",		-- [10]
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["Totem"]				= "Totem",				-- [11]
				["Mascotte"]			= "Non-combat Pet",		-- [12]
				["Nuvola di Gas"]		= "Gas Cloud",			-- [13]
				["Mascotte Selvatica"]	= "Wild Pet",			-- [14]
				["Aberrazione"]			= "Aberration",			-- [15]
			},
			koKR				= {
				["Ã¬â€¢Â¼Ã¬Ë†Ëœ"]					= "Beast",				-- [1]
				["Ã¬Å¡Â©Ã¬Â¡Â±"]					= "Dragonkin",			-- [2]
				["Ã¬â€¢â€¦Ã«Â§Ë†"]					= "Demon",				-- [3]
				["Ã¬Â â€¢Ã«Â Â¹"]					= "Elemental",			-- [4]
				["ÃªÂ±Â°Ã¬ÂÂ¸"]					= "Giant",				-- [5]
				["Ã¬â€“Â¸Ã«ÂÂ°Ã«â€œÅ“"]					= "Undead",				-- [6]
				["Ã¬ÂÂ¸ÃªÂ°â€žÃ­Ëœâ€¢"]					= "Humanoid",			-- [7]
				["Ã«Ââ„¢Ã«Â¬Â¼"]					= "Critter",			-- [8]
				["ÃªÂ¸Â°ÃªÂ³â€ž"]					= "Mechanical",			-- [9]
				["ÃªÂ¸Â°Ã­Æ’â‚¬"]					= "Not specified",		-- [10]
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["Ã­â€ Â Ã­â€¦Å“"]					= "Totem",				-- [11]
				["Ã¬â€¢Â Ã¬â„¢â€žÃ«Ââ„¢Ã«Â¬Â¼"]				= "Non-combat Pet",		-- [12]
				["ÃªÂ°â‚¬Ã¬Å Â¤ ÃªÂµÂ¬Ã«Â¦â€ž"]				= "Gas Cloud",			-- [13]
				["Ã¬â€¢Â¼Ã¬Æ’Â Ã¬â€¢Â Ã¬â„¢â€žÃ«Ââ„¢Ã«Â¬Â¼"]			= "Wild Pet",			-- [14]
				["Ã«ÂÅ’Ã¬â€”Â°Ã«Â³â‚¬Ã¬ÂÂ´"]				= "Aberration",			-- [15]
			},
			zhCN				= {
				["Ã©â€¡Å½Ã¥â€¦Â½"]				= "Beast",				-- [1]
				["Ã©Â¾â„¢Ã§Â±Â»"]					= "Dragonkin",			-- [2]
				["Ã¦ÂÂ¶Ã©Â­â€"]				= "Demon",				-- [3]
				["Ã¥â€¦Æ’Ã§Â´Â Ã§â€Å¸Ã§â€°Â©"]				= "Elemental",			-- [4]
				["Ã¥Â·Â¨Ã¤ÂºÂº"]				= "Giant",				-- [5]
				["Ã¤ÂºÂ¡Ã§ÂÂµ"]				= "Undead",				-- [6]
				["Ã¤ÂºÂºÃ¥Å¾â€¹Ã§â€Å¸Ã§â€°Â©"]				= "Humanoid",			-- [7]
				["Ã¥Â°ÂÃ¥Å Â¨Ã§â€°Â©"]				= "Critter",			-- [8]
				["Ã¦Å“ÂºÃ¦Â¢Â°"]				= "Mechanical",			-- [9]
				["Ã¦Å“ÂªÃ¦Å’â€¡Ã¥Â®Å¡"]				= "Not specified",		-- [10]
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["Ã¥â€ºÂ¾Ã¨â€¦Â¾"]				= "Totem",				-- [11]
				["Ã©ÂÅ¾Ã¦Ë†ËœÃ¦â€“â€”Ã¥Â®Â Ã§â€°Â©"]			= "Non-combat Pet",		-- [12]
				["Ã¦Â°â€Ã¤Â½â€œÃ¤Âºâ€˜Ã©â€ºÂ¾"]				= "Gas Cloud",			-- [13]
				["Ã©â€¡Å½Ã§â€Å¸Ã¥Â®Â Ã§â€°Â©"]				= "Wild Pet",			-- [14]
				["Ã§â€¢Â¸Ã¥ÂËœÃ¦â‚¬Âª"]				= "Aberration",			-- [15]
			},
			zhTW				= {
				["Ã©â€¡Å½Ã§ÂÂ¸"]				= "Beast",				-- [1]
				["Ã©Â¾ÂÃ©Â¡Å¾"]				= "Dragonkin",			-- [2]
				["Ã¦Æ’Â¡Ã©Â­â€"]				= "Demon",				-- [3]
				["Ã¥â€¦Æ’Ã§Â´Â Ã§â€Å¸Ã§â€°Â©"]				= "Elemental",			-- [4]
				["Ã¥Â·Â¨Ã¤ÂºÂº"]				= "Giant",				-- [5]
				["Ã¤Â¸ÂÃ¦Â­Â»Ã¦â€”Â"]				= "Undead",				-- [6]
				["Ã¤ÂºÂºÃ¥Å¾â€¹Ã§â€Å¸Ã§â€°Â©"]				= "Humanoid",			-- [7] Classic
				["Ã¤ÂºÂºÃ¥Â½Â¢Ã§â€Å¸Ã§â€°Â©"]				= "Humanoid",			-- [7] Retail
				["Ã¥Â°ÂÃ¥â€¹â€¢Ã§â€°Â©"]				= "Critter",			-- [8]
				["Ã¦Â©Å¸Ã¦Â¢Â°"]				= "Mechanical",			-- [9]
				["Ã¦Å“ÂªÃ¦Å’â€¡Ã¥Â®Å¡"]				= "Not specified",		-- [10] Classic
				["Ã¤Â¸ÂÃ¦ËœÅ½"]				= "Not specified",		-- [10] Retail
				[""]					= "Not specified",		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
				["Ã¥Å“â€“Ã©Â¨Â°"]				= "Totem",				-- [11]
				["Ã©ÂÅ¾Ã¦Ë†Â°Ã©Â¬Â¥Ã¥Â¯ÂµÃ§â€°Â©"]			= "Non-combat Pet",		-- [12]
				["Ã¦Â°Â£Ã©Â«â€Ã©â€ºÂ²"]				= "Gas Cloud",			-- [13]
				["Ã©â€¡Å½Ã§â€Å¸Ã¥Â¯ÂµÃ§â€°Â©"]				= "Wild Pet",			-- [14]
				["Ã¨Â®Å Ã§â€¢Â°Ã¦â‚¬Âª"]				= "Aberration",			-- [15]
			},
		},
		{
			__index = function(t, v)
				return t[GameLocale][v]
			end,
		}
	),
	CreatureFamily				= setmetatable(
		-- Formats localization to English locale
		-- Revision BFA 8.3.0.33941 April 2020
		{
			enUS				= {
				["Wolf"]					= "Wolf",					-- [1]
				["Cat"]						= "Cat",					-- [2]
				["Spider"]					= "Spider",					-- [3]
				["Bear"]					= "Bear",					-- [4]
				["Boar"]					= "Boar",					-- [5]
				["Crocolisk"]				= "Crocolisk",				-- [6]
				["Carrion Bird"]			= "Carrion Bird",			-- [7]
				["Crab"]					= "Crab",					-- [8]
				["Gorilla"]					= "Gorilla",				-- [9]
				["Raptor"]					= "Raptor",					-- [11]
				["Tallstrider"]				= "Tallstrider",			-- [12]
				["Felhunter"]				= "Felhunter",				-- [15]
				["Voidwalker"]				= "Voidwalker",				-- [16]
				["Succubus"]				= "Succubus",				-- [17]
				["Doomguard"]				= "Doomguard",				-- [19]
				["Scorpid"]					= "Scorpid",				-- [20]
				["Turtle"]					= "Turtle",					-- [21]
				["Imp"]						= "Imp",					-- [23]
				["Bat"]						= "Bat",					-- [24]
				["Hyena"]					= "Hyena",					-- [25]
				["Owl"]						= "Owl",					-- [26] Classic
				["Bird of Prey"]			= "Bird of Prey",			-- [26] Retail
				["Wind Serpent"]			= "Wind Serpent",			-- [27]
				["Remote Control"]			= "Remote Control",			-- [28]
				["Felguard"]				= "Felguard",				-- [29]
				["Dragonhawk"]				= "Dragonhawk",				-- [30]
				["Ravager"]					= "Ravager",				-- [31]
				["Warp Stalker"]			= "Warp Stalker",			-- [32]
				["Sporebat"]				= "Sporebat",				-- [33]
				["Ray"]						= "Ray",					-- [34]
				["Serpent"]					= "Serpent",				-- [35]
				["Moth"]					= "Moth",					-- [37]
				["Chimaera"]				= "Chimaera",				-- [38]
				["Devilsaur"]				= "Devilsaur",				-- [39]
				["Ghoul"]					= "Ghoul",					-- [40]
				["Silithid"]				= "Silithid",				-- [41]
				["Worm"]					= "Worm",					-- [42]
				["Clefthoof"]				= "Clefthoof",				-- [43]
				["Wasp"]					= "Wasp",					-- [44]
				["Core Hound"]				= "Core Hound",				-- [45]
				["Spirit Beast"]			= "Spirit Beast",			-- [46]
				["Water Elemental"]			= "Water Elemental",		-- [49]
				["Fox"]						= "Fox",					-- [50]
				["Monkey"]					= "Monkey",					-- [51]
				["Dog"]						= "Dog",					-- [52]
				["Beetle"]					= "Beetle",					-- [53]
				["Shale Spider"]			= "Shale Spider",			-- [55]
				["Zombie"]					= "Zombie",					-- [56]
				["<< QA TEST FAMILY >>"]	= "<< QA TEST FAMILY >>",	-- [57]
				["Hydra"]					= "Hydra",					-- [68]
				["Fel Imp"]					= "Fel Imp",				-- [100]
				["Voidlord"]				= "Voidlord",				-- [101]
				["Shivarra"]				= "Shivarra",				-- [102]
				["Observer"]				= "Observer",				-- [103]
				["Wrathguard"]				= "Wrathguard",				-- [104]
				["Infernal"]				= "Infernal",				-- [108]
				["Fire Elemental"]			= "Fire Elemental",			-- [116]
				["Earth Elemental"]			= "Earth Elemental",		-- [117]
				["Crane"]					= "Crane",					-- [125]
				["Water Strider"]			= "Water Strider",			-- [126]
				["Rodent"]					= "Rodent",					-- [127]
				["Quilen"]					= "Quilen",					-- [128]
				["Goat"]					= "Goat",					-- [129]
				["Basilisk"]				= "Basilisk",				-- [130]
				["Direhorn"]				= "Direhorn",				-- [138]
				["Storm Elemental"]			= "Storm Elemental",		-- [145]
				["Terrorguard"]				= "Terrorguard",			-- [147]
				["Abyssal"]					= "Abyssal",				-- [148]
				["Riverbeast"]				= "Riverbeast",				-- [150]
				["Stag"]					= "Stag",					-- [151]
				["Mechanical"]				= "Mechanical",				-- [154]
				["Abomination"]				= "Abomination",			-- [155]
				["Scalehide"]				= "Scalehide",				-- [156]
				["Oxen"]					= "Oxen",					-- [157]
				["Feathermane"]				= "Feathermane",			-- [160]
				["Lizard"]					= "Lizard",					-- [288]
				["Pterrordax"]				= "Pterrordax",				-- [290]
				["Toad"]					= "Toad",					-- [291]
				["Krolusk"]					= "Krolusk",				-- [292]
				["Blood Beast"]				= "Blood Beast",			-- [296]
			},
			ruRU				= {
				["Ãâ€™ÃÂ¾ÃÂ»ÃÂº"]					= "Wolf",					-- [1]
				["ÃÅ¡ÃÂ¾Ã‘Ë†ÃÂºÃÂ°"]					= "Cat",					-- [2]
				["ÃÅ¸ÃÂ°Ã‘Æ’ÃÂº"]					= "Spider",					-- [3]
				["ÃÅ“ÃÂµÃÂ´ÃÂ²ÃÂµÃÂ´Ã‘Å’"]					= "Bear",					-- [4]
				["Ãâ€™ÃÂµÃÂ¿Ã‘â‚¬Ã‘Å’"]					= "Boar",					-- [5]
				["ÃÅ¡Ã‘â‚¬ÃÂ¾ÃÂºÃÂ¾ÃÂ»ÃÂ¸Ã‘ÂÃÂº"]				= "Crocolisk",				-- [6]
				["ÃÅ¸ÃÂ°ÃÂ´ÃÂ°ÃÂ»Ã‘Å’Ã‘â€°ÃÂ¸ÃÂº"]				= "Carrion Bird",			-- [7]
				["ÃÅ¡Ã‘â‚¬ÃÂ°ÃÂ±"]					= "Crab",					-- [8]
				["Ãâ€œÃÂ¾Ã‘â‚¬ÃÂ¸ÃÂ»ÃÂ»ÃÂ°"]					= "Gorilla",				-- [9]
				["ÃÂ¯Ã‘â€°ÃÂµÃ‘â‚¬"]					= "Raptor",					-- [11]
				["Ãâ€ÃÂ¾ÃÂ»ÃÂ³ÃÂ¾ÃÂ½ÃÂ¾ÃÂ³"]				= "Tallstrider",			-- [12]
				["ÃÅ¾Ã‘â€¦ÃÂ¾Ã‘â€šÃÂ½ÃÂ¸ÃÂº ÃÂ¡ÃÂºÃÂ²ÃÂµÃ‘â‚¬ÃÂ½Ã‘â€¹"]			= "Felhunter",				-- [15]
				["Ãâ€ÃÂµÃÂ¼ÃÂ¾ÃÂ½ Ãâ€˜ÃÂµÃÂ·ÃÂ´ÃÂ½Ã‘â€¹"]			= "Voidwalker",				-- [16]
				["ÃÂ¡Ã‘Æ’ÃÂºÃÂºÃ‘Æ’ÃÂ±"]					= "Succubus",				-- [17]
				["ÃÂ¡Ã‘â€šÃ‘â‚¬ÃÂ°ÃÂ¶ Ã‘Æ’ÃÂ¶ÃÂ°Ã‘ÂÃÂ°"]				= "Doomguard",				-- [19]
				["ÃÂ¡ÃÂºÃÂ¾Ã‘â‚¬ÃÂ¿ÃÂ¸ÃÂ´"]					= "Scorpid",				-- [20]
				["ÃÂ§ÃÂµÃ‘â‚¬ÃÂµÃÂ¿ÃÂ°Ã‘â€¦ÃÂ°"]				= "Turtle",					-- [21]
				["Ãâ€˜ÃÂµÃ‘Â"]						= "Imp",					-- [23]
				["Ãâ€ºÃÂµÃ‘â€šÃ‘Æ’Ã‘â€¡ÃÂ°Ã‘Â ÃÂ¼Ã‘â€¹Ã‘Ë†Ã‘Å’"]			= "Bat",					-- [24]
				["Ãâ€œÃÂ¸ÃÂµÃÂ½ÃÂ°"]					= "Hyena",					-- [25]
				["ÃÂ¡ÃÂ¾ÃÂ²ÃÂ°"]					= "Owl",					-- [26] Classic
				["ÃÂ¥ÃÂ¸Ã‘â€°ÃÂ½ÃÂ°Ã‘Â ÃÂ¿Ã‘â€šÃÂ¸Ã‘â€ ÃÂ°"]			= "Bird of Prey",			-- [26] Retail
				["ÃÅ¡Ã‘â‚¬Ã‘â€¹ÃÂ»ÃÂ°Ã‘â€šÃ‘â€¹ÃÂ¹ ÃÂ·ÃÂ¼ÃÂµÃÂ¹"]			= "Wind Serpent",			-- [27]
				["ÃÂ£ÃÂ¿Ã‘â‚¬ÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂµ"]				= "Remote Control",			-- [28]
				["ÃÂ¡Ã‘â€šÃ‘â‚¬ÃÂ°ÃÂ¶ ÃÂ¡ÃÂºÃÂ²ÃÂµÃ‘â‚¬ÃÂ½Ã‘â€¹"]			= "Felguard",				-- [29]
				["Ãâ€Ã‘â‚¬ÃÂ°ÃÂºÃÂ¾ÃÂ½ÃÂ´ÃÂ¾Ã‘â‚¬"]				= "Dragonhawk",				-- [30]
				["ÃÅ¾ÃÂ¿Ã‘Æ’Ã‘ÂÃ‘â€šÃÂ¾Ã‘Ë†ÃÂ¸Ã‘â€šÃÂµÃÂ»Ã‘Å’"]			= "Ravager",				-- [31]
				["ÃÅ¸Ã‘â‚¬Ã‘â€¹ÃÂ³Ã‘Æ’ÃÂ°ÃÂ½ÃÂ°"]				= "Warp Stalker",			-- [32]
				["ÃÂ¡ÃÂ¿ÃÂ¾Ã‘â‚¬ÃÂ¾Ã‘ÂÃÂºÃÂ°Ã‘â€š"]				= "Sporebat",				-- [33]
				["ÃÂ¡ÃÂºÃÂ°Ã‘â€š"]					= "Ray",					-- [34]
				["Ãâ€”ÃÂ¼ÃÂµÃÂ¹"]					= "Serpent",				-- [35]
				["ÃÅ“ÃÂ¾Ã‘â€šÃ‘â€¹ÃÂ»ÃÂµÃÂº"]					= "Moth",					-- [37]
				["ÃÂ¥ÃÂ¸ÃÂ¼ÃÂµÃ‘â‚¬ÃÂ°"]					= "Chimaera",				-- [38]
				["Ãâ€Ã‘Å’Ã‘ÂÃÂ²ÃÂ¾ÃÂ·ÃÂ°ÃÂ²Ã‘â‚¬"]				= "Devilsaur",				-- [39]
				["Ãâ€™Ã‘Æ’Ã‘â‚¬ÃÂ´ÃÂ°ÃÂ»ÃÂ°ÃÂº"]				= "Ghoul",					-- [40]
				["ÃÂ¡ÃÂ¸ÃÂ»ÃÂ¸Ã‘â€šÃÂ¸ÃÂ´"]					= "Silithid",				-- [41]
				["ÃÂ§ÃÂµÃ‘â‚¬ÃÂ²Ã‘Å’"]					= "Worm",					-- [42]
				["ÃÅ¡ÃÂ¾ÃÂ¿Ã‘â€¹Ã‘â€šÃÂµÃÂ½Ã‘Å’"]				= "Clefthoof",				-- [43]
				["ÃÅ¾Ã‘ÂÃÂ°"]						= "Wasp",					-- [44]
				["Ãâ€œÃÂ¾ÃÂ½Ã‘â€¡ÃÂ°Ã‘Â ÃÂ½ÃÂµÃÂ´Ã‘â‚¬"]				= "Core Hound",				-- [45]
				["Ãâ€Ã‘Æ’Ã‘â€¦ ÃÂ·ÃÂ²ÃÂµÃ‘â‚¬Ã‘Â"]				= "Spirit Beast",			-- [46]
				["ÃÂ­ÃÂ»ÃÂµÃÂ¼ÃÂµÃÂ½Ã‘â€šÃÂ°ÃÂ»Ã‘Å’ ÃÂ²ÃÂ¾ÃÂ´Ã‘â€¹"]			= "Water Elemental",		-- [49]
				["Ãâ€ºÃÂ¸Ã‘ÂÃÂ¸Ã‘â€ ÃÂ°"]					= "Fox",					-- [50]
				["ÃÅ¾ÃÂ±ÃÂµÃÂ·Ã‘Å’Ã‘ÂÃÂ½ÃÂ°"]				= "Monkey",					-- [51]
				["ÃÂ¡ÃÂ¾ÃÂ±ÃÂ°ÃÂºÃÂ°"]					= "Dog",					-- [52]
				["Ãâ€“Ã‘Æ’ÃÂº"]						= "Beetle",					-- [53]
				["ÃÂ¡ÃÂ»ÃÂ°ÃÂ½Ã‘â€ ÃÂµÃÂ²Ã‘â€¹ÃÂ¹ ÃÂ¿ÃÂ°Ã‘Æ’ÃÂº"]			= "Shale Spider",			-- [55]
				["Ãâ€”ÃÂ¾ÃÂ¼ÃÂ±ÃÂ¸"]					= "Zombie",					-- [56]
				["<< QA TEST FAMILY >>"]	= "<< QA TEST FAMILY >>",	-- [57]
				["Ãâ€œÃÂ¸ÃÂ´Ã‘â‚¬ÃÂ°"]					= "Hydra",					-- [68]
				["Ãâ€˜ÃÂµÃ‘Â ÃÂ¡ÃÂºÃÂ²ÃÂµÃ‘â‚¬ÃÂ½Ã‘â€¹"]				= "Fel Imp",				-- [100]
				["ÃÅ¸ÃÂ¾ÃÂ²ÃÂµÃÂ»ÃÂ¸Ã‘â€šÃÂµÃÂ»Ã‘Å’ Ãâ€˜ÃÂµÃÂ·ÃÂ´ÃÂ½Ã‘â€¹"]		= "Voidlord",				-- [101]
				["ÃÂ¨ÃÂ¸ÃÂ²ÃÂ°Ã‘â‚¬Ã‘â‚¬ÃÂ°"]					= "Shivarra",				-- [102]
				["ÃÂÃÂ°ÃÂ±ÃÂ»Ã‘Å½ÃÂ´ÃÂ°Ã‘â€šÃÂµÃÂ»Ã‘Å’"]				= "Observer",				-- [103]
				["ÃÂ¡Ã‘â€šÃ‘â‚¬ÃÂ°ÃÂ¶ ÃÂ³ÃÂ½ÃÂµÃÂ²ÃÂ°"]				= "Wrathguard",				-- [104]
				["ÃËœÃÂ½Ã‘â€žÃÂµÃ‘â‚¬ÃÂ½ÃÂ°ÃÂ»"]				= "Infernal",				-- [108]
				["ÃÂ­ÃÂ»ÃÂµÃÂ¼ÃÂµÃÂ½Ã‘â€šÃÂ°ÃÂ»Ã‘Å’ ÃÂ¾ÃÂ³ÃÂ½Ã‘Â"]			= "Fire Elemental",			-- [116]
				["ÃÂ­ÃÂ»ÃÂµÃÂ¼ÃÂµÃÂ½Ã‘â€šÃÂ°ÃÂ»Ã‘Å’ ÃÂ·ÃÂµÃÂ¼ÃÂ»ÃÂ¸"]		= "Earth Elemental",		-- [117]
				["Ãâ€“Ã‘Æ’Ã‘â‚¬ÃÂ°ÃÂ²ÃÂ»Ã‘Å’"]					= "Crane",					-- [125]
				["Ãâ€™ÃÂ¾ÃÂ´ÃÂ½Ã‘â€¹ÃÂ¹ ÃÂ´ÃÂ¾ÃÂ»ÃÂ³ÃÂ¾ÃÂ½ÃÂ¾ÃÂ³"]			= "Water Strider",			-- [126]
				["Ãâ€œÃ‘â‚¬Ã‘â€¹ÃÂ·Ã‘Æ’ÃÂ½"]					= "Rodent",					-- [127]
				["ÃÂ¦ÃÂ¸ÃÂ¹ÃÂ»ÃÂ¸ÃÂ½Ã‘Å’"]					= "Quilen",					-- [128]
				["ÃÅ¡ÃÂ¾ÃÂ·ÃÂµÃÂ»"]					= "Goat",					-- [129]
				["Ãâ€™ÃÂ°Ã‘ÂÃÂ¸ÃÂ»ÃÂ¸Ã‘ÂÃÂº"]				= "Basilisk",				-- [130]
				["Ãâ€ÃÂ¸ÃÂºÃÂ¾Ã‘â‚¬ÃÂ¾ÃÂ³"]					= "Direhorn",				-- [138]
				["ÃÂ­ÃÂ»ÃÂµÃÂ¼ÃÂµÃÂ½Ã‘â€šÃÂ°ÃÂ»Ã‘Å’ ÃÂ±Ã‘Æ’Ã‘â‚¬ÃÂ¸"]			= "Storm Elemental",		-- [145]
				["ÃÂ¡Ã‘â€šÃ‘â‚¬ÃÂ°ÃÂ¶ÃÂ½ÃÂ¸ÃÂº ÃÂ¶Ã‘Æ’Ã‘â€šÃÂ¸"]			= "Terrorguard",			-- [147]
				["ÃÂÃÂ±ÃÂ¸Ã‘ÂÃ‘ÂÃÂ°ÃÂ»"]					= "Abyssal",				-- [148]
				["ÃÂ ÃÂµÃ‘â€¡ÃÂ½ÃÂ¾ÃÂµ Ã‘â€¡Ã‘Æ’ÃÂ´ÃÂ¸Ã‘â€°ÃÂµ"]			= "Riverbeast",				-- [150]
				["ÃÅ¾ÃÂ»ÃÂµÃÂ½Ã‘Å’"]					= "Stag",					-- [151]
				["ÃÅ“ÃÂµÃ‘â€¦ÃÂ°ÃÂ½ÃÂ¸ÃÂ·ÃÂ¼"]				= "Mechanical",				-- [154]
				["ÃÅ¸ÃÂ¾ÃÂ³ÃÂ°ÃÂ½ÃÂ¸Ã‘â€°ÃÂµ"]				= "Abomination",			-- [155]
				["ÃÂ§ÃÂµÃ‘Ë†Ã‘Æ’ÃÂµÃ‘Ë†ÃÂºÃ‘Æ’Ã‘â‚¬Ã‘â€¹ÃÂµ"]				= "Scalehide",				-- [156]
				["Ãâ€˜Ã‘â€¹ÃÂºÃÂ¸"]					= "Oxen",					-- [157]
				["ÃÂ¨ÃÂµÃ‘â‚¬Ã‘ÂÃ‘â€šÃÂ¾ÃÂ¿ÃÂµÃ‘â‚¬Ã‘â€¹ÃÂµ"]				= "Feathermane",			-- [160]
				["ÃÂ¯Ã‘â€°ÃÂµÃ‘â‚¬ÃÂ¸Ã‘â€ ÃÂ°"]					= "Lizard",					-- [288]
				["ÃÂ¢ÃÂµÃ‘â‚¬Ã‘â‚¬ÃÂ¾ÃÂ´ÃÂ°ÃÂºÃ‘â€šÃÂ¸ÃÂ»Ã‘Å’"]			= "Pterrordax",				-- [290]
				["Ãâ€“ÃÂ°ÃÂ±ÃÂ°"]					= "Toad",					-- [291]
				["ÃÅ¡Ã‘â‚¬ÃÂ¾ÃÂ»Ã‘Æ’Ã‘ÂÃÂº"]					= "Krolusk",				-- [292]
				["ÃÅ¡Ã‘â‚¬ÃÂ¾ÃÂ²ÃÂ°ÃÂ²ÃÂ¾ÃÂµ Ã‘â€¡Ã‘Æ’ÃÂ´ÃÂ¾ÃÂ²ÃÂ¸Ã‘â€°ÃÂµ"]		= "Blood Beast",			-- [296]
			},
			frFR				= {
				["Loup"]					= "Wolf",					-- [1]
				["FÃƒÂ©lin"]					= "Cat",					-- [2]
				["AraignÃƒÂ©e"]				= "Spider",					-- [3]
				["Ours"]					= "Bear",					-- [4]
				["Sanglier"]				= "Boar",					-- [5]
				["Crocilisque"]				= "Crocolisk",				-- [6]
				["Charognard"]				= "Carrion Bird",			-- [7]
				["Crabe"]					= "Crab",					-- [8]
				["Gorille"]					= "Gorilla",				-- [9]
				["Raptor"]					= "Raptor",					-- [11]
				["Haut-trotteur"]			= "Tallstrider",			-- [12]
				["Chasseur corrompu"]		= "Felhunter",				-- [15]
				["Marcheur du Vide"]		= "Voidwalker",				-- [16]
				["Succube"]					= "Succubus",				-- [17]
				["Garde funeste"]			= "Doomguard",				-- [19]
				["Scorpide"]				= "Scorpid",				-- [20]
				["Tortue"]					= "Turtle",					-- [21]
				["Diablotin"]				= "Imp",					-- [23]
				["Chauve-souris"]			= "Bat",					-- [24]
				["HyÃƒÂ¨ne"]					= "Hyena",					-- [25]
				["Chouette"]				= "Owl",					-- [26] Classic
				["Oiseau de proie"]			= "Bird of Prey",			-- [26] Retail
				["Serpent des vents"]		= "Wind Serpent",			-- [27]
				["TÃƒÂ©lÃƒÂ©commande"]			= "Remote Control",			-- [28]
				["Gangregarde"]				= "Felguard",				-- [29]
				["Faucon-dragon"]			= "Dragonhawk",				-- [30]
				["Ravageur"]				= "Ravager",				-- [31]
				["Traqueur dim."]			= "Warp Stalker",			-- [32]
				["SporoptÃƒÂ¨re"]				= "Sporebat",				-- [33]
				["Raie"]					= "Ray",					-- [34]
				["Serpent"]					= "Serpent",				-- [35]
				["PhalÃƒÂ¨ne"]					= "Moth",					-- [37]
				["ChimÃƒÂ¨re"]					= "Chimaera",				-- [38]
				["Diablosaure"]				= "Devilsaur",				-- [39]
				["Goule"]					= "Ghoul",					-- [40]
				["Silithide"]				= "Silithid",				-- [41]
				["Ver"]						= "Worm",					-- [42]
				["Sabot-fourchu"]			= "Clefthoof",				-- [43]
				["GuÃƒÂªpe"]					= "Wasp",					-- [44]
				["Chien du magma"]			= "Core Hound",				-- [45]
				["Esprit de bÃƒÂªte"]			= "Spirit Beast",			-- [46]
				["Ãƒâ€°lÃƒÂ©mentaire d'eau"]		= "Water Elemental",		-- [49]
				["Renard"]					= "Fox",					-- [50]
				["Singe"]					= "Monkey",					-- [51]
				["Chien"]					= "Dog",					-- [52]
				["Hanneton"]				= "Beetle",					-- [53]
				["AraignÃƒÂ©e de schiste"]		= "Shale Spider",			-- [55]
				["Zombie"]					= "Zombie",					-- [56]
				["<< QA TEST FAMILY >>"]	= "<< QA TEST FAMILY >>",	-- [57]
				["Hydre"]					= "Hydra",					-- [68]
				["Diablotin gangrenÃƒÂ©"]		= "Fel Imp",				-- [100]
				["Seigneur du Vide"]		= "Voidlord",				-- [101]
				["Shivarra"]				= "Shivarra",				-- [102]
				["Observateur"]				= "Observer",				-- [103]
				["Garde-courroux"]			= "Wrathguard",				-- [104]
				["Infernal"]				= "Infernal",				-- [108]
				["Ãƒâ€°lÃƒÂ©mentaire de feu"]		= "Fire Elemental",			-- [116]
				["Ãƒâ€°lÃƒÂ©mentaire de terre"]	= "Earth Elemental",		-- [117]
				["Grue"]					= "Crane",					-- [125]
				["Trotteur aquatique"]		= "Water Strider",			-- [126]
				["Rongeur"]					= "Rodent",					-- [127]
				["Quilen"]					= "Quilen",					-- [128]
				["ChÃƒÂ¨vre"]					= "Goat",					-- [129]
				["Basilic"]					= "Basilisk",				-- [130]
				["Navrecorne"]				= "Direhorn",				-- [138]
				["Ãƒâ€°lÃƒÂ©m. de tempÃƒÂªte"]		= "Storm Elemental",		-- [145]
				["Garde de terreur"]		= "Terrorguard",			-- [147]
				["Abyssal"]					= "Abyssal",				-- [148]
				["Potamodonte"]				= "Riverbeast",				-- [150]
				["Cerf"]					= "Stag",					-- [151]
				["MÃƒÂ©canique"]				= "Mechanical",				-- [154]
				["Abomination"]				= "Abomination",			-- [155]
				["Peau ÃƒÂ©cailleuse"]			= "Scalehide",				-- [156]
				["Bovin"]					= "Oxen",					-- [157]
				["Crin-de-plume"]			= "Feathermane",			-- [160]
				["LÃƒÂ©zard"]					= "Lizard",					-- [288]
				["Pterreurdactyle"]			= "Pterrordax",				-- [290]
				["Crapaud"]					= "Toad",					-- [291]
				["Krolusk"]					= "Krolusk",				-- [292]
				["BÃƒÂªte de sang"]			= "Blood Beast",			-- [296]
			},
			deDE				= {
				["Wolf"]					= "Wolf",					-- [1]
				["Katze"]					= "Cat",					-- [2]
				["Spinne"]					= "Spider",					-- [3]
				["BÃƒÂ¤r"]						= "Bear",					-- [4]
				["Eber"]					= "Boar",					-- [5]
				["Krokilisk"]				= "Crocolisk",				-- [6]
				["Aasvogel"]				= "Carrion Bird",			-- [7]
				["Krebs"]					= "Crab",					-- [8]
				["Gorilla"]					= "Gorilla",				-- [9]
				["Raptor"]					= "Raptor",					-- [11]
				["Weitschreiter"]			= "Tallstrider",			-- [12]
				["TeufelsjÃƒÂ¤ger"]			= "Felhunter",				-- [15]
				["Leerwandler"]				= "Voidwalker",				-- [16]
				["Sukkubus"]				= "Succubus",				-- [17]
				["Verdammniswache"]			= "Doomguard",				-- [19]
				["Skorpid"]					= "Scorpid",				-- [20]
				["SchildkrÃƒÂ¶te"]				= "Turtle",					-- [21]
				["Wichtel"]					= "Imp",					-- [23]
				["Fledermaus"]				= "Bat",					-- [24]
				["HyÃƒÂ¤ne"]					= "Hyena",					-- [25]
				["Eule"]					= "Owl",					-- [26] Classic
				["Raubvogel"]				= "Bird of Prey",			-- [26] Retail
				["Windnatter"]				= "Wind Serpent",			-- [27]
				["Ferngesteuert"]			= "Remote Control",			-- [28]
				["Teufelswache"]			= "Felguard",				-- [29]
				["Drachenfalke"]			= "Dragonhawk",				-- [30]
				["Felshetzer"]				= "Ravager",				-- [31]
				["SphÃƒÂ¤renjÃƒÂ¤ger"]			= "Warp Stalker",			-- [32]
				["Sporensegler"]			= "Sporebat",				-- [33]
				["Rochen"]					= "Ray",					-- [34]
				["Schlange"]				= "Serpent",				-- [35]
				["Motte"]					= "Moth",					-- [37]
				["SchimÃƒÂ¤re"]				= "Chimaera",				-- [38]
				["Teufelssaurier"]			= "Devilsaur",				-- [39]
				["Ghul"]					= "Ghoul",					-- [40]
				["Silithid"]				= "Silithid",				-- [41]
				["Wurm"]					= "Worm",					-- [42]
				["Grollhuf"]				= "Clefthoof",				-- [43]
				["Wespe"]					= "Wasp",					-- [44]
				["Kernhund"]				= "Core Hound",				-- [45]
				["Geisterbestie"]			= "Spirit Beast",			-- [46]
				["Wasserelementar"]			= "Water Elemental",		-- [49]
				["Fuchs"]					= "Fox",					-- [50]
				["Affe"]					= "Monkey",					-- [51]
				["Hund"]					= "Dog",					-- [52]
				["KÃƒÂ¤fer"]					= "Beetle",					-- [53]
				["Schieferspinne"]			= "Shale Spider",			-- [55]
				["Zombie"]					= "Zombie",					-- [56]
				["<< QA TEST FAMILY >>"]	= "<< QA TEST FAMILY >>",	-- [57]
				["Hydra"]					= "Hydra",					-- [68]
				["Teufelswichtel"]			= "Fel Imp",				-- [100]
				["LeerenfÃƒÂ¼rst"]				= "Voidlord",				-- [101]
				["Shivarra"]				= "Shivarra",				-- [102]
				["Beobachter"]				= "Observer",				-- [103]
				["ZornwÃƒÂ¤chter"]				= "Wrathguard",				-- [104]
				["HÃƒÂ¶llenbestie"]			= "Infernal",				-- [108]
				["Feuerelementar"]			= "Fire Elemental",			-- [116]
				["Erdelementar"]			= "Earth Elemental",		-- [117]
				["Kranich"]					= "Crane",					-- [125]
				["Wasserschreiter"]			= "Water Strider",			-- [126]
				["Nager"]					= "Rodent",					-- [127]
				["Qilen"]					= "Quilen",					-- [128]
				["Ziege"]					= "Goat",					-- [129]
				["Basilisk"]				= "Basilisk",				-- [130]
				["Terrorhorn"]				= "Direhorn",				-- [138]
				["Sturmelementar"]			= "Storm Elemental",		-- [145]
				["Terrorwache"]				= "Terrorguard",			-- [147]
				["Abyssal"]					= "Abyssal",				-- [148]
				["Flussbestie"]				= "Riverbeast",				-- [150]
				["Hirsch"]					= "Stag",					-- [151]
				["Mechanisch"]				= "Mechanical",				-- [154]
				["MonstrositÃƒÂ¤t"]			= "Abomination",			-- [155]
				["Schuppenbalg"]			= "Scalehide",				-- [156]
				["Ochse"]					= "Oxen",					-- [157]
				["FedermÃƒÂ¤hnen"]				= "Feathermane",			-- [160]
				["Echse"]					= "Lizard",					-- [288]
				["Pterrordax"]				= "Pterrordax",				-- [290]
				["KrÃƒÂ¶te"]					= "Toad",					-- [291]
				["Krolusk"]					= "Krolusk",				-- [292]
				["Blutbestie"]				= "Blood Beast",			-- [296]
			},
			esES				= {
				["Lobo"]					= "Wolf",					-- [1]
				["Felino"]					= "Cat",					-- [2]
				["AraÃƒÂ±a"]					= "Spider",					-- [3]
				["Oso"]						= "Bear",					-- [4]
				["JabalÃƒÂ­"]					= "Boar",					-- [5]
				["Crocolisco"]				= "Crocolisk",				-- [6]
				["CarroÃƒÂ±ero"]				= "Carrion Bird",			-- [7]
				["Cangrejo"]				= "Crab",					-- [8]
				["Gorila"]					= "Gorilla",				-- [9]
				["Raptor"]					= "Raptor",					-- [11]
				["Zancudo"]					= "Tallstrider",			-- [12] Spain Classic
				["Zancaalta"]				= "Tallstrider",			-- [12] Spain Retail / Mexico Classic
				["ManÃƒÂ¡fago"]				= "Felhunter",				-- [15]
				["Abisario"]				= "Voidwalker",				-- [16]
				["SÃƒÂºcubo"]					= "Succubus",				-- [17]
				["Guardia maldito"]			= "Doomguard",				-- [19] Spain Classic
				["Guardia apocalÃƒÂ­ptico"]	= "Doomguard",				-- [19] Spain Retail / Mexico Classic
				["EscÃƒÂ³rpido"]				= "Scorpid",				-- [20]
				["Tortuga"]					= "Turtle",					-- [21]
				["Diablillo"]				= "Imp",					-- [23]
				["MurciÃƒÂ©lago"]				= "Bat",					-- [24]
				["Hiena"]					= "Hyena",					-- [25]
				["BÃƒÂºho"]					= "Owl",					-- [26] Classic
				["Ave rapaz"]				= "Bird of Prey",			-- [26] Retail
				["DragÃƒÂ³n alado"]			= "Wind Serpent",			-- [27] Spain
				["Serpiente alada"]			= "Wind Serpent",			-- [27] Mexico
				["Control remoto"]			= "Remote Control",			-- [28]
				["Guardia vil"]				= "Felguard",				-- [29]
				["DracohalcÃƒÂ³n"]				= "Dragonhawk",				-- [30]
				["Devastador"]				= "Ravager",				-- [31]
				["Acechador deformado"]		= "Warp Stalker",			-- [32]
				["EsporiÃƒÂ©lago"]				= "Sporebat",				-- [33]
				["Raya"]					= "Ray",					-- [34] Spain
				["Mantarraya"]				= "Ray",					-- [34] Mexico
				["Serpiente"]				= "Serpent",				-- [35]
				["Palomilla"]				= "Moth",					-- [37]
				["Quimera"]					= "Chimaera",				-- [38]
				["Demosaurio"]				= "Devilsaur",				-- [39]
				["NecrÃƒÂ³fago"]				= "Ghoul",					-- [40]
				["SilÃƒÂ­tido"]				= "Silithid",				-- [41]
				["Gusano"]					= "Worm",					-- [42]
				["UÃƒÂ±agrieta"]				= "Clefthoof",				-- [43]
				["Avispa"]					= "Wasp",					-- [44]
				["Can del NÃƒÂºcleo"]			= "Core Hound",				-- [45]
				["Bestia espÃƒÂ­ritu"]			= "Spirit Beast",			-- [46]
				["Elemental de agua"]		= "Water Elemental",		-- [49]
				["Zorro"]					= "Fox",					-- [50]
				["Mono"]					= "Monkey",					-- [51]
				["Perro"]					= "Dog",					-- [52]
				["Alfazaque"]				= "Beetle",					-- [53]
				["AraÃƒÂ±a de esquisto"]		= "Shale Spider",			-- [55]
				["Zombi"]					= "Zombie",					-- [56]
				["<< QA TEST FAMILY >>"]	= "<< QA TEST FAMILY >>",	-- [57]
				["Hidra"]					= "Hydra",					-- [68]
				["Diablillo vil"]			= "Fel Imp",				-- [100]
				["SeÃƒÂ±or del VacÃƒÂ­o"]			= "Voidlord",				-- [101]
				["Shivarra"]				= "Shivarra",				-- [102]
				["Observador"]				= "Observer",				-- [103]
				["Guardia de cÃƒÂ³lera"]		= "Wrathguard",				-- [104]
				["Infernal"]				= "Infernal",				-- [108]
				["Elemental de fuego"]		= "Fire Elemental",			-- [116]
				["Elemental de tierra"]		= "Earth Elemental",		-- [117]
				["Grulla"]					= "Crane",					-- [125]
				["Zancudo acuÃƒÂ¡tico"]		= "Water Strider",			-- [126]
				["Roedor"]					= "Rodent",					-- [127]
				["Quilen"]					= "Quilen",					-- [128]
				["Cabra"]					= "Goat",					-- [129]
				["Basilisco"]				= "Basilisk",				-- [130]
				["Cuernoatroz"]				= "Direhorn",				-- [138]
				["Elem. de tormenta"]		= "Storm Elemental",		-- [145] Spain
				["Elemental tormenta"]		= "Storm Elemental",		-- [145] Mexico
				["Guarda terrorÃƒÂ­fico"]		= "Terrorguard",			-- [147]
				["Abisal"]					= "Abyssal",				-- [148]
				["Bestia fluvial"]			= "Riverbeast",				-- [150] Spain
				["Bestia del rÃƒÂ­o"]			= "Riverbeast",				-- [150] Mexico
				["Venado"]					= "Stag",					-- [151]
				["MÃƒÂ¡quina"]					= "Mechanical",				-- [154] Spain
				["MecÃƒÂ¡nico"]				= "Mechanical",				-- [154] Mexico
				["AbominaciÃƒÂ³n"]				= "Abomination",			-- [155]
				["Pielescama"]				= "Scalehide",				-- [156]
				["Buey"]					= "Oxen",					-- [157]
				["Cuellipluma"]				= "Feathermane",			-- [160] Spain
				["Crinpluma"]				= "Feathermane",			-- [160] Mexico
				["Lagarto"]					= "Lizard",					-- [288]
				["PterrordÃƒÂ¡ctilo"]			= "Pterrordax",				-- [290]
				["Sapo"]					= "Toad",					-- [291]
				["Crolusco"]				= "Krolusk",				-- [292] Spain
				["Krolusko"]				= "Krolusk",				-- [292] Maxico
				["Bestia de sangre"]		= "Blood Beast",			-- [296]
			},
			ptPT				= {
				["Lobo"]					= "Wolf",					-- [1]
				["Gato"]					= "Cat",					-- [2]
				["Aranha"]					= "Spider",					-- [3]
				["Urso"]					= "Bear",					-- [4]
				["Javali"]					= "Boar",					-- [5]
				["Crocolisco"]				= "Crocolisk",				-- [6]
				["Ave Carniceira"]			= "Carrion Bird",			-- [7]
				["Caranguejo"]				= "Crab",					-- [8]
				["Gorila"]					= "Gorilla",				-- [9]
				["Raptor"]					= "Raptor",					-- [11]
				["Moa"]						= "Tallstrider",			-- [12]
				["CaÃƒÂ§ador Vil"]				= "Felhunter",				-- [15]
				["EmissÃƒÂ¡rio do Caos"]		= "Voidwalker",				-- [16]
				["SÃƒÂºcubo"]					= "Succubus",				-- [17]
				["Demonarca"]				= "Doomguard",				-- [19]
				["EscorpÃƒÂ­deo"]				= "Scorpid",				-- [20]
				["Tartaruga"]				= "Turtle",					-- [21]
				["Diabrete"]				= "Imp",					-- [23]
				["Morcego"]					= "Bat",					-- [24]
				["Hiena"]					= "Hyena",					-- [25]
				["Coruja"]					= "Owl",					-- [26] Classic
				["Ave de Rapina"]			= "Bird of Prey",			-- [26] Retail
				["Serpente Alada"]			= "Wind Serpent",			-- [27]
				["Controle Remoto"]			= "Remote Control",			-- [28]
				["Guarda Vil"]				= "Felguard",				-- [29]
				["Falcodrago"]				= "Dragonhawk",				-- [30]
				["Assolador"]				= "Ravager",				-- [31]
				["Espreitador Dimens."]		= "Warp Stalker",			-- [32]
				["QuirÃƒÂ³sporo"]				= "Sporebat",				-- [33]
				["Arraia"]					= "Ray",					-- [34]
				["Serpente"]				= "Serpent",				-- [35]
				["Mariposa"]				= "Moth",					-- [37]
				["Quimera"]					= "Chimaera",				-- [38]
				["Demossauro"]				= "Devilsaur",				-- [39]
				["CarniÃƒÂ§al"]				= "Ghoul",					-- [40]
				["SilitÃƒÂ­deo"]				= "Silithid",				-- [41]
				["Verme"]					= "Worm",					-- [42]
				["Fenoceronte"]				= "Clefthoof",				-- [43]
				["Vespa"]					= "Wasp",					-- [44]
				["CÃƒÂ£o-magma"]				= "Core Hound",				-- [45]
				["Fera Espiritual"]			= "Spirit Beast",			-- [46]
				["Elemental da ÃƒÂgua"]		= "Water Elemental",		-- [49]
				["Raposa"]					= "Fox",					-- [50]
				["Macaco"]					= "Monkey",					-- [51]
				["Cachorro"]				= "Dog",					-- [52]
				["Besouro"]					= "Beetle",					-- [53]
				["Aranha Xistosa"]			= "Shale Spider",			-- [55]
				["Zumbi"]					= "Zombie",					-- [56]
				["Beetle <zzOLD>"]			= "<< QA TEST FAMILY >>",	-- [57]
				["Hidra"]					= "Hydra",					-- [68]
				["Diabrete Vil"]			= "Fel Imp",				-- [100]
				["Senhor do Caos"]			= "Voidlord",				-- [101]
				["Shivarra"]				= "Shivarra",				-- [102]
				["Observador"]				= "Observer",				-- [103]
				["GuardiÃƒÂ£o ColÃƒÂ©rico"]		= "Wrathguard",				-- [104]
				["Infernal"]				= "Infernal",				-- [108]
				["Elemental do Fogo"]		= "Fire Elemental",			-- [116]
				["Elemental da Terra"]		= "Earth Elemental",		-- [117]
				["GarÃƒÂ§a"]					= "Crane",					-- [125]
				["Caminhante das ÃƒÂguas"]	= "Water Strider",			-- [126]
				["Roedor"]					= "Rodent",					-- [127]
				["QuÃƒÂ­len"]					= "Quilen",					-- [128]
				["Bode"]					= "Goat",					-- [129]
				["Basilisco"]				= "Basilisk",				-- [130]
				["Escornante"]				= "Direhorn",				-- [138]
				["Elemental Tempestade"]	= "Storm Elemental",		-- [145]
				["Deimoguarda"]				= "Terrorguard",			-- [147]
				["Abissal"]					= "Abyssal",				-- [148]
				["Fera-do-rio"]				= "Riverbeast",				-- [150]
				["Cervo"]					= "Stag",					-- [151]
				["MecÃƒÂ¢nico"]				= "Mechanical",				-- [154]
				["AbominaÃƒÂ§ÃƒÂ£o"]				= "Abomination",			-- [155]
				["Courescama"]				= "Scalehide",				-- [156]
				["Boi"]						= "Oxen",					-- [157]
				["AquifÃƒÂ©lix"]				= "Feathermane",			-- [160]
				["Lagarto"]					= "Lizard",					-- [288]
				["Pterrordax"]				= "Pterrordax",				-- [290]
				["Sapo"]					= "Toad",					-- [291]
				["Crolusco"]				= "Krolusk",				-- [292]
				["Fera Sangrenta"]			= "Blood Beast",			-- [296]
			},
			itIT				= {
				["Lupo"]					= "Wolf",					-- [1]
				["Felino"]					= "Cat",					-- [2]
				["Ragno"]					= "Spider",					-- [3]
				["Orso"]					= "Bear",					-- [4]
				["Cinghiale"]				= "Boar",					-- [5]
				["Crocolisco"]				= "Crocolisk",				-- [6]
				["Mangiacarogne"]			= "Carrion Bird",			-- [7]
				["Granchio"]				= "Crab",					-- [8]
				["Gorilla"]					= "Gorilla",				-- [9]
				["Raptor"]					= "Raptor",					-- [11]
				["Zampalunga"]				= "Tallstrider",			-- [12]
				["Vilsegugio"]				= "Felhunter",				-- [15]
				["Ombra del Vuoto"]			= "Voidwalker",				-- [16]
				["Succube"]					= "Succubus",				-- [17]
				["Demone Guardiano"]		= "Doomguard",				-- [19]
				["Scorpide"]				= "Scorpid",				-- [20]
				["Tartaruga"]				= "Turtle",					-- [21]
				["Imp"]						= "Imp",					-- [23]
				["Pipistrello"]				= "Bat",					-- [24]
				["Iena"]					= "Hyena",					-- [25]
				["Rapace"]					= "Bird of Prey",			-- [26]
				["Serpente Volante"]		= "Wind Serpent",			-- [27]
				["Controllo a Distanza"]	= "Remote Control",			-- [28]
				["Vilguardia"]				= "Felguard",				-- [29]
				["Dragofalco"]				= "Dragonhawk",				-- [30]
				["Devastatore"]				= "Ravager",				-- [31]
				["Segugio Distorcente"]		= "Warp Stalker",			-- [32]
				["Sporofago"]				= "Sporebat",				-- [33]
				["Pastinaca"]				= "Ray",					-- [34]
				["Serpente"]				= "Serpent",				-- [35]
				["Falena"]					= "Moth",					-- [37]
				["Chimera"]					= "Chimaera",				-- [38]
				["Gigantosauro"]			= "Devilsaur",				-- [39]
				["Ghoul"]					= "Ghoul",					-- [40]
				["Silitide"]				= "Silithid",				-- [41]
				["Verme"]					= "Worm",					-- [42]
				["Mammuceronte"]			= "Clefthoof",				-- [43]
				["Vespa"]					= "Wasp",					-- [44]
				["Segugio del Nucleo"]		= "Core Hound",				-- [45]
				["Bestia Eterea"]			= "Spirit Beast",			-- [46]
				["Elementale d'Acqua"]		= "Water Elemental",		-- [49]
				["Volpe"]					= "Fox",					-- [50]
				["Scimmia"]					= "Monkey",					-- [51]
				["Cane"]					= "Dog",					-- [52]
				["Scarabeo"]				= "Beetle",					-- [53]
				["Ragno Roccioso"]			= "Shale Spider",			-- [55]
				["Zombi"]					= "Zombie",					-- [56]
				["<< QA TEST FAMILY >>"]	= "<< QA TEST FAMILY >>",	-- [57]
				["Idra"]					= "Hydra",					-- [68]
				["Vilimp"]					= "Fel Imp",				-- [100]
				["Signore del Vuoto"]		= "Voidlord",				-- [101]
				["Shivarra"]				= "Shivarra",				-- [102]
				["Osservatore"]				= "Observer",				-- [103]
				["Guardia dell'Ira"]		= "Wrathguard",				-- [104]
				["Infernale"]				= "Infernal",				-- [108]
				["Elementale del Fuoco"]	= "Fire Elemental",			-- [116]
				["Elementale di Terra"]		= "Earth Elemental",		-- [117]
				["Gru"]						= "Crane",					-- [125]
				["Gerride"]					= "Water Strider",			-- [126]
				["Roditore"]				= "Rodent",					-- [127]
				["Quilen"]					= "Quilen",					-- [128]
				["Caprone"]					= "Goat",					-- [129]
				["Basilisco"]				= "Basilisk",				-- [130]
				["Cornofurente"]			= "Direhorn",				-- [138]
				["Elementale Tempesta"]		= "Storm Elemental",		-- [145]
				["Guardia Maligna"]			= "Terrorguard",			-- [147]
				["Abission"]				= "Abyssal",				-- [148]
				["Bestia dei Fiumi"]		= "Riverbeast",				-- [150]
				["Cervo"]					= "Stag",					-- [151]
				["UnitÃƒÂ  Meccanica"]			= "Mechanical",				-- [154]
				["Abominio"]				= "Abomination",			-- [155]
				["Scagliamanto"]			= "Scalehide",				-- [156]
				["Yak"]						= "Oxen",					-- [157]
				["Piumanto"]				= "Feathermane",			-- [160]
				["Lucertola"]				= "Lizard",					-- [288]
				["Pterrordattilo"]			= "Pterrordax",				-- [290]
				["Rospo"]					= "Toad",					-- [291]
				["Krolusk"]					= "Krolusk",				-- [292]
				["Bestia di Sangue"]		= "Blood Beast",			-- [296]
			},
			koKR				= {
				["Ã«Å â€˜Ã«Å’â‚¬"]						= "Wolf",					-- [1]
				["Ã¬â€šÂ´Ã¬Â¾Â¡Ã¬ÂÂ´"]					= "Cat",					-- [2]
				["ÃªÂ±Â°Ã«Â¯Â¸"]						= "Spider",					-- [3]
				["ÃªÂ³Â°"]						= "Bear",					-- [4]
				["Ã«Â©Â§Ã«ÂÂ¼Ã¬Â§â‚¬"]					= "Boar",					-- [5]
				["Ã¬â€¢â€¦Ã¬â€“Â´"]						= "Crocolisk",				-- [6]
				["Ã«Ââ€¦Ã¬Ë†ËœÃ«Â¦Â¬"]					= "Carrion Bird",			-- [7]
				["ÃªÂ²Å’"]						= "Crab",					-- [8]
				["ÃªÂ³Â Ã«Â¦Â´Ã«ÂÂ¼"]					= "Gorilla",				-- [9]
				["Ã«Å¾Â©Ã­â€žÂ°"]						= "Raptor",					-- [11]
				["Ã­Æ’â‚¬Ã¬Â¡Â°"]						= "Tallstrider",			-- [12]
				["Ã¬Â§â‚¬Ã¬ËœÂ¥Ã¬â€šÂ¬Ã«Æ’Â¥ÃªÂ°Å“"]				= "Felhunter",				-- [15]
				["Ã«Â³Â´Ã¬ÂÂ´Ã«â€œÅ“Ã¬â€ºÅ’Ã¬Â»Â¤"]				= "Voidwalker",				-- [16] Classic
				["ÃªÂ³ÂµÃ­â€”Ë†Ã«Â°Â©Ã«Å¾â€˜Ã¬Å¾Â"]				= "Voidwalker",				-- [16] Retail
				["Ã¬â€žÅ“Ã­ÂÂÃ«Â²â€žÃ¬Å Â¤"]					= "Succubus",				-- [17]
				["Ã­Å’Å’Ã«Â©Â¸Ã¬ÂËœÃ¬Ë†ËœÃ­ËœÂ¸Ã«Â³â€˜"]				= "Doomguard",				-- [19] Classic
				["Ã­Å’Å’Ã«Â©Â¸Ã¬Ë†ËœÃ­ËœÂ¸Ã«Â³â€˜"]				= "Doomguard",				-- [19] Retail
				["Ã¬Â â€žÃªÂ°Ë†"]						= "Scorpid",				-- [20]
				["ÃªÂ±Â°Ã«Â¶Â"]						= "Turtle",					-- [21]
				["Ã¬Å¾â€žÃ­â€â€ž"]						= "Imp",					-- [23]
				["Ã«Â°â€¢Ã¬Â¥Â"]						= "Bat",					-- [24]
				["Ã­â€¢ËœÃ¬ÂÂ´Ã¬â€”ÂÃ«â€šËœ"]					= "Hyena",					-- [25]
				["Ã¬ËœÂ¬Ã«Â¹Â¼Ã«Â¯Â¸"]					= "Owl",					-- [26] Classic
				["Ã«Â§Â¹ÃªÂ¸Ë†"]						= "Bird of Prey",			-- [26] Retail
				["Ã¬Â²Å“Ã«â€˜Â¥Ã«Â§Â¤"]					= "Wind Serpent",			-- [27]
				["Ã«Â¬Â´Ã¬â€žÂ Ã¬Â¡Â°Ã¬Â¢â€¦ Ã¬Å¾Â¥Ã«â€šÅ“ÃªÂ°Â"]			= "Remote Control",			-- [28]
				["Ã¬Â§â‚¬Ã¬ËœÂ¥Ã¬Ë†ËœÃ­ËœÂ¸Ã«Â³â€˜"]				= "Felguard",				-- [29]
				["Ã¬Å¡Â©Ã«Â§Â¤"]						= "Dragonhawk",				-- [30]
				["Ã¬Â¹Â¼Ã«â€šÂ Ã«Â°Å“Ã­â€ Â±"]					= "Ravager",				-- [31]
				["Ã¬Â°Â¨Ã¬â€ºÂÃ¬ÂËœ Ã¬Â¶â€Ã¬Â ÂÃ¬Å¾Â"]				= "Warp Stalker",			-- [32]
				["Ã­ÂÂ¬Ã¬Å¾ÂÃ«Â°â€¢Ã¬Â¥Â"]					= "Sporebat",				-- [33]
				["ÃªÂ°â‚¬Ã¬ËœÂ¤Ã«Â¦Â¬"]					= "Ray",					-- [34]
				["Ã«Â±â‚¬"]						= "Serpent",				-- [35]
				["Ã«â€šËœÃ«Â°Â©"]						= "Moth",					-- [37]
				["Ã­â€šÂ¤Ã«Â©â€Ã«ÂÂ¼"]					= "Chimaera",				-- [38]
				["Ã«ÂÂ°Ã«Â¹Å’Ã¬â€šÂ¬Ã¬Å¡Â°Ã«Â£Â¨Ã¬Å Â¤"]				= "Devilsaur",				-- [39]
				["ÃªÂµÂ¬Ã¬Å¡Â¸"]						= "Ghoul",					-- [40]
				["Ã¬â€¹Â¤Ã«Â¦Â¬Ã¬â€¹Å“Ã«â€œÅ“"]					= "Silithid",				-- [41]
				["Ã«Â²Å’Ã«Â Ë†"]						= "Worm",					-- [42]
				["ÃªÂ°Ë†Ã«Å¾ËœÃ«Â°Å“ÃªÂµÂ½"]					= "Clefthoof",				-- [43]
				["Ã«Â§ÂÃ«Â²Å’"]						= "Wasp",					-- [44]
				["Ã¬â€¹Â¬Ã¬Å¾Â¥Ã«Â¶â‚¬ Ã¬â€šÂ¬Ã«Æ’Â¥ÃªÂ°Å“"]				= "Core Hound",				-- [45]
				["Ã¬â€¢Â¼Ã¬Ë†Ëœ Ã¬Â â€¢Ã«Â Â¹"]				= "Spirit Beast",			-- [46]
				["Ã«Â¬Â¼Ã¬ÂËœ Ã¬Â â€¢Ã«Â Â¹"]				= "Water Elemental",		-- [49]
				["Ã¬â€”Â¬Ã¬Å¡Â°"]						= "Fox",					-- [50]
				["Ã¬â€ºÂÃ¬Ë†Â­Ã¬ÂÂ´"]					= "Monkey",					-- [51]
				["ÃªÂ°Å“"]						= "Dog",					-- [52]
				["Ã«â€Â±Ã¬Â â€¢Ã«Â²Å’Ã«Â Ë†"]					= "Beetle",					-- [53]
				["Ã­ËœË†Ã¬â€¢â€ÃªÂ±Â°Ã«Â¯Â¸"]					= "Shale Spider",			-- [55]
				["Ã¬Â¢â‚¬Ã«Â¹â€ž"]						= "Zombie",					-- [56]
				["<< QA Ã­â€¦Å’Ã¬Å Â¤Ã­Å Â¸Ã¬Å¡Â© >>"]		= "<< QA TEST FAMILY >>",	-- [57]
				["Ã­Å¾Ë†Ã«â€œÅ“Ã«ÂÂ¼"]					= "Hydra",					-- [68]
				["Ã¬Â§â‚¬Ã¬ËœÂ¥ Ã¬Å¾â€žÃ­â€â€ž"]				= "Fel Imp",				-- [100]
				["ÃªÂ³ÂµÃ­â€”Ë†ÃªÂµÂ°Ã¬Â£Â¼"]					= "Voidlord",				-- [101]
				["Ã¬â€°Â¬Ã«Â°â€Ã«ÂÂ¼"]					= "Shivarra",				-- [102]
				["ÃªÂ°ÂÃ¬â€¹Å“Ã¬Å¾Â"]					= "Observer",				-- [103]
				["ÃªÂ²Â©Ã«â€¦Â¸Ã¬Ë†ËœÃ­ËœÂ¸Ã«Â³â€˜"]				= "Wrathguard",				-- [104]
				["Ã¬Â§â‚¬Ã¬ËœÂ¥Ã«Â¶Ë†Ã¬Â â€¢Ã«Â Â¹"]				= "Infernal",				-- [108]
				["Ã«Â¶Ë†Ã¬ÂËœ Ã¬Â â€¢Ã«Â Â¹"]				= "Fire Elemental",			-- [116]
				["Ã«Å’â‚¬Ã¬Â§â‚¬Ã¬ÂËœ Ã¬Â â€¢Ã«Â Â¹"]				= "Earth Elemental",		-- [117]
				["Ã­â€¢â„¢"]						= "Crane",					-- [125]
				["Ã¬â€ Å’ÃªÂ¸Ë†Ã¬Å¸ÂÃ¬ÂÂ´"]					= "Water Strider",			-- [126]
				["Ã¬â€žÂ¤Ã¬Â¹ËœÃ«Â¥Ëœ"]					= "Rodent",					-- [127]
				["ÃªÂ¸Â°Ã«Â Å’"]						= "Quilen",					-- [128]
				["Ã¬â€”Â¼Ã¬â€ Å’"]						= "Goat",					-- [129]
				["Ã«Â°â€Ã¬â€¹Â¤Ã«Â¦Â¬Ã¬Å Â¤Ã­ÂÂ¬"]				= "Basilisk",				-- [130]
				["ÃªÂ³ÂµÃ­ÂÂ¬Ã«Â¿â€"]					= "Direhorn",				-- [138]
				["Ã­ÂÂ­Ã­â€™ÂÃ¬ÂËœ Ã¬Â â€¢Ã«Â Â¹"]				= "Storm Elemental",		-- [145]
				["ÃªÂ³ÂµÃ­ÂÂ¬Ã¬Ë†ËœÃ­ËœÂ¸Ã«Â³â€˜"]				= "Terrorguard",			-- [147]
				["Ã¬â€¹Â¬Ã¬â€”Â°Ã«Â¶Ë†Ã¬Â â€¢Ã«Â Â¹"]				= "Abyssal",				-- [148]
				["ÃªÂ°â€¢Ã«Â¬Â¼Ã­â€¢ËœÃ«Â§Ë†"]					= "Riverbeast",				-- [150]
				["Ã¬Ë†Å“Ã«Â¡Â"]						= "Stag",					-- [151]
				["ÃªÂ¸Â°ÃªÂ³â€ž"]						= "Mechanical",				-- [154]
				["Ã«Ë†â€žÃ«Ââ€ÃªÂ¸Â°ÃªÂ³Â¨Ã«Â Ëœ"]				= "Abomination",			-- [155]
				["Ã«Â¹â€žÃ«Å ËœÃªÂ°â‚¬Ã¬Â£Â½"]					= "Scalehide",				-- [156]
				["Ã¬â€ Å’"]						= "Oxen",					-- [157]
				["Ã«Â¾Â°Ã¬Â¡Â±ÃªÂ°Ë†ÃªÂ¸Â°"]					= "Feathermane",			-- [160]
				["Ã«Ââ€žÃ«Â§Ë†Ã«Â±â‚¬"]					= "Lizard",					-- [288]
				["Ã­â€¦Å’Ã«Å¸Â¬Ã«â€¹Â¥Ã¬Å Â¤"]					= "Pterrordax",				-- [290]
				["Ã«â€˜ÂÃªÂºÂ¼Ã«Â¹â€ž"]					= "Toad",					-- [291]
				["Ã­ÂÂ¬Ã«Â¡Â¤Ã«Å¸Â¬Ã¬Å Â¤Ã­ÂÂ¬"]				= "Krolusk",				-- [292]
				["Ã­â€Â¼Ã¬ÂËœ ÃªÂ´Â´Ã«Â¬Â¼"]				= "Blood Beast",			-- [296]
			},
			zhCN				= {
				["Ã§â€¹Â¼"]						= "Wolf",					-- [1]
				["Ã¨Â±Â¹"]						= "Cat",					-- [2]
				["Ã¨Å“ËœÃ¨â€ºâ€º"]						= "Spider",					-- [3]
				["Ã§â€ Å "]						= "Bear",					-- [4]
				["Ã©â€¡Å½Ã§Å’Âª"]						= "Boar",					-- [5]
				["Ã©Â³â€žÃ©Â±Â¼"]						= "Crocolisk",				-- [6]
				["Ã©Â£Å¸Ã¨â€¦ÂÃ©Â¸Å¸"]					= "Carrion Bird",			-- [7]
				["Ã¨Å¾Æ’Ã¨Å¸Â¹"]						= "Crab",					-- [8]
				["Ã§Å’Â©Ã§Å’Â©"]						= "Gorilla",				-- [9]
				["Ã¨Â¿â€¦Ã§Å’â€ºÃ©Â¾â„¢"]					= "Raptor",					-- [11]
				["Ã©â„¢â€ Ã¨Â¡Å’Ã©Â¸Å¸"]					= "Tallstrider",			-- [12]
				["Ã¥Å“Â°Ã§â€¹Â±Ã§Å’Å½Ã§Å Â¬"]					= "Felhunter",				-- [15]
				["Ã¨â„¢Å¡Ã§Â©ÂºÃ¨Â¡Å’Ã¨â‚¬â€¦"]					= "Voidwalker",				-- [16]
				["Ã©Â­â€¦Ã©Â­â€"]						= "Succubus",				-- [17]
				["Ã¦Å“Â«Ã¦â€”Â¥Ã¥Â®Ë†Ã¥ÂÂ«"]					= "Doomguard",				-- [19]
				["Ã¨ÂÅ½Ã¥Â­Â"]						= "Scorpid",				-- [20]
				["Ã¦ÂµÂ·Ã©Â¾Å¸"]						= "Turtle",					-- [21]
				["Ã¥Â°ÂÃ©Â¬Â¼"]						= "Imp",					-- [23]
				["Ã¨Ââ„¢Ã¨ÂÂ "]						= "Bat",					-- [24]
				["Ã¥Å“Å¸Ã§â€¹Â¼"]						= "Hyena",					-- [25]
				["Ã§Å’Â«Ã¥Â¤Â´Ã©Â¹Â°"]					= "Owl",					-- [26] Classic
				["Ã§Å’â€ºÃ§Â¦Â½"]						= "Bird of Prey",			-- [26] Retail
				["Ã©Â£Å½Ã¨â€ºâ€¡"]						= "Wind Serpent",			-- [27]
				["Ã¨Â¿Å“Ã§Â¨â€¹Ã¦Å½Â§Ã¥Ë†Â¶"]					= "Remote Control",			-- [28]
				["Ã¦ÂÂ¶Ã©Â­â€Ã¥ÂÂ«Ã¥Â£Â«"]					= "Felguard",				-- [29]
				["Ã©Â¾â„¢Ã©Â¹Â°"]						= "Dragonhawk",				-- [30]
				["Ã¦Å½Â Ã©Â£Å¸Ã¨â‚¬â€¦"]					= "Ravager",				-- [31]
				["Ã¨Â¿ÂÃ¨Â·Æ’Ã¦Ââ€¢Ã§Å’Å½Ã¨â‚¬â€¦"]				= "Warp Stalker",			-- [32]
				["Ã¥Â­Â¢Ã¥Â­ÂÃ¨ÂÂ "]					= "Sporebat",				-- [33]
				["Ã©Â³ÂÃ©Â±Â¼"]						= "Ray",					-- [34]
				["Ã¨â€ºâ€¡"]						= "Serpent",				-- [35]
				["Ã¨â€ºÂ¾Ã¥Â­Â"]						= "Moth",					-- [37]
				["Ã¥Â¥â€¡Ã§Â¾Å½Ã¦â€¹â€°"]					= "Chimaera",				-- [38]
				["Ã©Â­â€Ã¦Å¡Â´Ã©Â¾â„¢"]					= "Devilsaur",				-- [39]
				["Ã©Â£Å¸Ã¥Â°Â¸Ã©Â¬Â¼"]					= "Ghoul",					-- [40]
				["Ã¥Â¼â€šÃ§Â§ÂÃ¨â„¢Â«"]					= "Silithid",				-- [41]
				["Ã¨Â â€¢Ã¨â„¢Â«"]						= "Worm",					-- [42]
				["Ã¨Â£â€šÃ¨Â¹â€žÃ§â€°â€º"]					= "Clefthoof",				-- [43]
				["Ã¥Â·Â¨Ã¨Å“â€š"]						= "Wasp",					-- [44]
				["Ã§â€ â€Ã¥Â²Â©Ã§Å Â¬"]					= "Core Hound",				-- [45]
				["Ã§ÂÂµÃ©Â­â€šÃ¥â€¦Â½"]					= "Spirit Beast",			-- [46]
				["Ã¦Â°Â´Ã¥â€¦Æ’Ã§Â´Â "]					= "Water Elemental",		-- [49]
				["Ã§â€¹ÂÃ§â€¹Â¸"]						= "Fox",					-- [50]
				["Ã§Å’Â´Ã¥Â­Â"]						= "Monkey",					-- [51]
				["Ã§â€¹â€”"]						= "Dog",					-- [52]
				["Ã§â€Â²Ã¨â„¢Â«"]						= "Beetle",					-- [53]
				["Ã©Â¡ÂµÃ¥Â²Â©Ã¨â€ºâ€º"]					= "Shale Spider",			-- [55]
				["Ã¥Æ’ÂµÃ¥Â°Â¸"]						= "Zombie",					-- [56]
				["<< QA TEST FAMILY >>"]	= "<< QA TEST FAMILY >>",	-- [57]
				["Ã¤Â¹ÂÃ¥Â¤Â´Ã¨â€ºâ€¡"]					= "Hydra",					-- [68]
				["Ã©â€šÂªÃ¨Æ’Â½Ã¥Â°ÂÃ©Â¬Â¼"]					= "Fel Imp",				-- [100]
				["Ã§Â©ÂºÃ§ÂÂµÃ©Â¢â€ Ã¤Â¸Â»"]					= "Voidlord",				-- [101]
				["Ã§Â Â´Ã¥ÂÂÃ©Â­â€"]					= "Shivarra",				-- [102]
				["Ã§Å“Â¼Ã©Â­â€"]						= "Observer",				-- [103]
				["Ã¦â€žÂ¤Ã¦â‚¬â€™Ã¥ÂÂ«Ã¥Â£Â«"]					= "Wrathguard",				-- [104]
				["Ã¥Å“Â°Ã§â€¹Â±Ã§ÂÂ«"]					= "Infernal",				-- [108]
				["Ã§ÂÂ«Ã¥â€¦Æ’Ã§Â´Â "]					= "Fire Elemental",			-- [116]
				["Ã¥Å“Å¸Ã¥â€¦Æ’Ã§Â´Â "]					= "Earth Elemental",		-- [117]
				["Ã©Â¹Â¤"]						= "Crane",					-- [125]
				["Ã¦Â°Â´Ã©Â»Â¾"]						= "Water Strider",			-- [126]
				["Ã¥â€¢Â®Ã©Â½Â¿Ã¥Å Â¨Ã§â€°Â©"]					= "Rodent",					-- [127]
				["Ã©Â­ÂÃ©ÂºÅ¸"]						= "Quilen",					-- [128]
				["Ã¥Â±Â±Ã§Â¾Å "]						= "Goat",					-- [129]
				["Ã§Å¸Â³Ã¥Å’â€“Ã¨Å“Â¥Ã¨Å“Â´"]					= "Basilisk",				-- [130]
				["Ã¦ÂÂÃ¨Â§â€™Ã©Â¾â„¢"]					= "Direhorn",				-- [138]
				["Ã©Â£Å½Ã¦Å¡Â´Ã¥â€¦Æ’Ã§Â´Â "]					= "Storm Elemental",		-- [145]
				["Ã¦ÂÂÃ¦Æ’Â§Ã¥ÂÂ«Ã¥Â£Â«"]					= "Terrorguard",			-- [147]
				["Ã¦Â·Â±Ã¦Â¸Å Ã©Â­â€"]					= "Abyssal",				-- [148]
				["Ã¦Â·Â¡Ã¦Â°Â´Ã¥â€¦Â½"]					= "Riverbeast",				-- [150]
				["Ã©â€ºâ€žÃ©Â¹Â¿"]						= "Stag",					-- [151]
				["Ã¦Å“ÂºÃ¦Â¢Â°"]						= "Mechanical",				-- [154]
				["Ã¦â€ Å½Ã¦ÂÂ¶"]						= "Abomination",			-- [155]
				["Ã©Â³Å¾Ã§â€Â²Ã§Â±Â»"]					= "Scalehide",				-- [156]
				["Ã§â€°â€º"]						= "Oxen",					-- [157]
				["Ã§Â¾Â½Ã©Â¬Æ’Ã¥â€¦Â½"]					= "Feathermane",			-- [160]
				["Ã¨Å“Â¥Ã¨Å“Â´"]						= "Lizard",					-- [288]
				["Ã§Â¿Â¼Ã¦â€°â€¹Ã©Â¾â„¢"]					= "Pterrordax",				-- [290]
				["Ã¨Å¸Â¾Ã¨Å“Â"]						= "Toad",					-- [291]
				["Ã¤Â¸â€°Ã¥ÂÂ¶Ã¨â„¢Â«"]					= "Krolusk",				-- [292]
				["Ã¨Â¡â‚¬Ã¥â€¦Â½"]						= "Blood Beast",			-- [296]
			},
			zhTW				= {
				["Ã§â€¹Â¼"]						= "Wolf",					-- [1]
				["Ã¨Â±Â¹"]						= "Cat",					-- [2] Classic
				["Ã¥Â¤Â§Ã¨Â²â€œ"]						= "Cat",					-- [2] Retail
				["Ã¨Å“ËœÃ¨â€ºâ€º"]						= "Spider",					-- [3]
				["Ã§â€ Å "]						= "Bear",					-- [4]
				["Ã©â€¡Å½Ã¨Â±Â¬"]						= "Boar",					-- [5]
				["Ã©Â±Â·Ã©Â­Å¡"]						= "Crocolisk",				-- [6]
				["Ã©Â£Å¸Ã¨â€¦ÂÃ©Â³Â¥"]					= "Carrion Bird",			-- [7]
				["Ã¨Å¾Æ’Ã¨Å¸Â¹"]						= "Crab",					-- [8]
				["Ã§Å’Â©Ã§Å’Â©"]						= "Gorilla",				-- [9]
				["Ã¨Â¿â€¦Ã§Å’â€ºÃ©Â¾Â"]					= "Raptor",					-- [11]
				["Ã©â„¢Â¸Ã¨Â¡Å’Ã©Â³Â¥"]					= "Tallstrider",			-- [12]
				["Ã¥Å“Â°Ã§Ââ€žÃ§ÂÂµÃ§Å Â¬"]					= "Felhunter",				-- [15] Classic
				["Ã¦Æ’Â¡Ã©Â­â€Ã§ÂÂµÃ§Å Â¬"]					= "Felhunter",				-- [15] Retail
				["Ã¨â„¢â€ºÃ§Â©ÂºÃ¨Â¡Å’Ã¨â‚¬â€¦"]					= "Voidwalker",				-- [16] Classic
				["Ã¨â„¢â€ºÃ§â€žÂ¡Ã¨Â¡Å’Ã¨â‚¬â€¦"]					= "Voidwalker",				-- [16] Retail
				["Ã©Â­â€¦Ã©Â­â€"]						= "Succubus",				-- [17]
				["Ã¦Å“Â«Ã¦â€”Â¥Ã¥Â®Ë†Ã¨Â¡â€º"]					= "Doomguard",				-- [19]
				["Ã¨Â ÂÃ¥Â­Â"]						= "Scorpid",				-- [20]
				["Ã¦ÂµÂ·Ã©Â¾Å“"]						= "Turtle",					-- [21]
				["Ã¥Â°ÂÃ©Â¬Â¼"]						= "Imp",					-- [23]
				["Ã¨Ââ„¢Ã¨ÂÂ "]						= "Bat",					-- [24]
				["Ã¥Å“Å¸Ã§â€¹Â¼"]						= "Hyena",					-- [25]
				["Ã¨Â²â€œÃ©Â Â­Ã©Â·Â¹"]					= "Owl",					-- [26] Classic
				["Ã§Å’â€ºÃ§Â¦Â½"]						= "Bird of Prey",			-- [26] Retail
				["Ã©Â¢Â¨Ã¨â€ºâ€¡"]						= "Wind Serpent",			-- [27]
				["Ã©Ââ„¢Ã¦Å½Â§"]						= "Remote Control",			-- [28]
				["Ã¦Æ’Â¡Ã©Â­â€Ã¥Â®Ë†Ã¨Â¡â€º"]					= "Felguard",				-- [29]
				["Ã©Â¾ÂÃ©Â·Â¹"]						= "Dragonhawk",				-- [30]
				["Ã¥Å Â«Ã¦Â¯â‚¬Ã¨â‚¬â€¦"]					= "Ravager",				-- [31]
				["Ã¦â€°Â­Ã¦â€ºÂ²Ã¥Â·Â¡Ã¨â‚¬â€¦"]					= "Warp Stalker",			-- [32]
				["Ã¥Â­Â¢Ã¥Â­ÂÃ¨Ââ„¢Ã¨ÂÂ "]					= "Sporebat",				-- [33]
				["Ã©Â­Å¸Ã©Â­Å¡"]						= "Ray",					-- [34]
				["Ã¦Â¯â€™Ã¨â€ºâ€¡"]						= "Serpent",				-- [35]
				["Ã¨â€ºÂ¾"]						= "Moth",					-- [37]
				["Ã¥Â¥â€¡Ã§Â¾Å½Ã¦â€¹â€°"]					= "Chimaera",				-- [38]
				["Ã©Â­â€Ã¦Å¡Â´Ã©Â¾Â"]					= "Devilsaur",				-- [39]
				["Ã©Â£Å¸Ã¥Â±ÂÃ©Â¬Â¼"]					= "Ghoul",					-- [40]
				["Ã§â€¢Â°Ã§Â¨Â®Ã¨Å¸Â²Ã¦â€”Â"]					= "Silithid",				-- [41]
				["Ã¨Å¸Â²"]						= "Worm",					-- [42]
				["Ã¨Â£â€šÃ¨Â¹â€ž"]						= "Clefthoof",				-- [43]
				["Ã©Â»Æ’Ã¨Å“â€š"]						= "Wasp",					-- [44]
				["Ã§â€ â€Ã¦Â Â¸Ã§Å Â¬"]					= "Core Hound",				-- [45]
				["Ã©ÂË†Ã§ÂÂ¸"]						= "Spirit Beast",			-- [46]
				["Ã¦Â°Â´Ã¥â€¦Æ’Ã§Â´Â "]					= "Water Elemental",		-- [49]
				["Ã§â€¹ÂÃ§â€¹Â¸"]						= "Fox",					-- [50]
				["Ã§Å’Â´Ã¥Â­Â"]						= "Monkey",					-- [51]
				["Ã§â€¹â€”"]						= "Dog",					-- [52]
				["Ã§â€Â²Ã¨Å¸Â²"]						= "Beetle",					-- [53]
				["Ã¥Â²Â©Ã¨â€ºâ€º"]						= "Shale Spider",			-- [55]
				["Ã¦Â®Â­Ã¥Â±Â"]						= "Zombie",					-- [56]
				["<< QA TEST FAMILY >>"]	= "<< QA TEST FAMILY >>",	-- [57]
				["Ã¥Â¤Å¡Ã©Â Â­Ã¨â€ºâ€¡"]					= "Hydra",					-- [68]
				["Ã©Â­â€Ã¥Å’â€“Ã¥Â°ÂÃ©Â¬Â¼"]					= "Fel Imp",				-- [100]
				["Ã¨â„¢â€ºÃ§â€žÂ¡Ã©Â ËœÃ¤Â¸Â»"]					= "Voidlord",				-- [101]
				["Ã¥Â¸Å’Ã§â€œÂ¦Ã¦â€¹â€°"]					= "Shivarra",				-- [102]
				["Ã¨Â§â‚¬Ã¥Â¯Å¸Ã¨â‚¬â€¦"]					= "Observer",				-- [103]
				["Ã¦â€ Â¤Ã¦â‚¬â€™Ã¥Â®Ë†Ã¨Â¡â€º"]					= "Wrathguard",				-- [104]
				["Ã§â€¦â€°Ã§Ââ€žÃ§ÂÂ«"]					= "Infernal",				-- [108]
				["Ã§ÂÂ«Ã¥â€¦Æ’Ã§Â´Â "]					= "Fire Elemental",			-- [116]
				["Ã¥Å“Å¸Ã¥â€¦Æ’Ã§Â´Â "]					= "Earth Elemental",		-- [117]
				["Ã©Â¶Â´"]						= "Crane",					-- [125]
				["Ã¦Â°Â´Ã©Â»Â½"]						= "Water Strider",			-- [126]
				["Ã©Â½Â§Ã©Â½â€™Ã©Â¡Å¾"]					= "Rodent",					-- [127]
				["Ã©Âºâ€™Ã©ÂºÅ¸Ã§ÂÂ¸"]					= "Quilen",					-- [128]
				["Ã¥Â±Â±Ã§Â¾Å "]						= "Goat",					-- [129]
				["Ã¨Å“Â¥Ã¨Å“Â´"]						= "Basilisk",				-- [130]
				["Ã¦ÂÂÃ¨Â§â€™Ã©Â¾Â"]					= "Direhorn",				-- [138]
				["Ã©Â¢Â¨Ã¦Å¡Â´Ã¥â€¦Æ’Ã§Â´Â "]					= "Storm Elemental",		-- [145]
				["Ã¦ÂÂÃ¦â€¡Â¼Ã¨Â­Â·Ã¨Â¡â€º"]					= "Terrorguard",			-- [147]
				["Ã¥â€ Â¥Ã¦Â·ÂµÃ§ÂÂ«"]					= "Abyssal",				-- [148]
				["Ã¦Â²Â³Ã§ÂÂ¸"]						= "Riverbeast",				-- [150]
				["Ã©â€ºâ€žÃ©Â¹Â¿"]						= "Stag",					-- [151]
				["Ã¦Â©Å¸Ã¦Â¢Â°"]						= "Mechanical",				-- [154]
				["Ã¦â€ Å½Ã¦Æ’Â¡Ã©Â«â€"]					= "Abomination",			-- [155]
				["Ã©Â±â€”Ã§Å¡Â®"]						= "Scalehide",				-- [156]
				["Ã§Å½â€žÃ§â€°â€º"]						= "Oxen",					-- [157]
				["Ã§Â¾Â½Ã©Â¬Æ’"]						= "Feathermane",			-- [160]
				["Ã¨Å“Â¥Ã¨Å“Â´"]						= "Lizard",					-- [288]
				["Ã§Â¿Â¼Ã¦â€°â€¹Ã©Â¾Â"]					= "Pterrordax",				-- [290]
				["Ã©Ââ€™Ã¨â€ºâ„¢"]						= "Toad",					-- [291]
				["Ã¨â€˜â€°Ã¦Â®Â¼Ã¨Å¸Â²"]					= "Krolusk",				-- [292]
				["Ã¨Â¡â‚¬Ã§ÂÂ¸"]						= "Blood Beast",			-- [296]
			},
		},
		{
			__index = function(t, v)
				return t[GameLocale][v]
			end,
		}
	),
	IsDummy 					= {
		-- City (SW, Orgri, ...)
		[31146] = true, -- Raider's Training Dummy
		[31144] = true, -- Training Dummy
		[32666] = true, -- Training Dummy
		[32667] = true, -- Training Dummy
		[46647] = true, -- Training Dummy
		-- MoP Shrine of Two Moons
		[67127] = true, -- Training Dummy
		-- WoD Alliance Garrison
		[87317] = true, -- Mage Tower Damage Training Dummy
		[87318] = true, -- Mage Tower Damage Dungeoneer's Training Dummy (& Garrison)
		[87320] = true, -- Mage Tower Damage Raider's Training Dummy
		[88314] = true, -- Tanking Dungeoneer's Training Dummy
		[88316] = true, -- Healing Training Dummy ----> FRIENDLY
		-- WoD Horde Garrison
		[87760] = true, -- Mage Tower Damage Training Dummy
		[87761] = true, -- Mage Tower Damage Dungeoneer's Training Dummy (& Garrison)
		[87762] = true, -- Mage Tower Damage Raider's Training Dummy
		[88288] = true, -- Tanking Dungeoneer's Training Dummy
		[88289] = true, -- Healing Training Dummy ----> FRIENDLY
		-- Legion Rogue Class Order Hall
		[92164] = true, -- Training Dummy
		[92165] = true, -- Dungeoneer's Training Dummy
		[92166] = true, -- Raider's Training Dummy
		-- Legion Priest Class Order Hall
		[107555] = true, -- Bound void Wraith
		[107556] = true, -- Bound void Walker
		-- Legion Druid Class Order Hall
		[113964] = true, -- Raider's Training Dummy
		[113966] = true, -- Dungeoneer's Training Dummy
		-- Legion Warlock Class Order Hall
		[102052] = true, -- Rebellious imp
		[102048] = true, -- Rebellious Felguard
		[102045] = true, -- Rebellious WrathGuard
		[101956] = true, -- Rebellious Fel Lord
		-- Legion Mage Class Order Hall
		[103397] = true, -- Greater Bullwark Construct
		[103404] = true, -- Bullwark Construct
		[103402] = true, -- Lesser Bullwark Construct
		-- BfA Dazar'Alor
		[144081] = true, -- Training Dummy
		[144082] = true, -- Training Dummy
		[144085] = true, -- Training Dummy
		[144086] = true, -- Raider's Training Dummy
		-- Misc/Unknown
		[79987]  = true, -- Location Unknown
		[92169]  = true, -- Tanking (Eastern Plaguelands)
		[96442]  = true, -- Damage (Location Unknown)
		[109595] = true, -- Location Unknown
		[113963] = true, -- Damage (Location Unknown)
		[131985] = true, -- Damage (Zuldazar)
		[131990] = true, -- Tanking (Zuldazar)
		[132976] = true, -- Morale Booster (Zuldazar)
		-- Level 1
		[17578]  = true, -- Lvl 1 (The Shattered Halls)
		[60197]  = true, -- Lvl 1 (Scarlet Monastery)
		[64446]  = true, -- Lvl 1 (Scarlet Monastery)
		[144077] = true, -- Lvl 1 (Dazar'alor) - Morale Booster
		-- Level 3
		[44171]  = true, -- Lvl 3 (New Tinkertown, Dun Morogh)
		[44389]  = true, -- Lvl 3 (Coldridge Valley)
		[44848]  = true, -- Lvl 3 (Camp Narache, Mulgore)
		[44548]  = true, -- Lvl 3 (Elwynn Forest)
		[44614]  = true, -- Lvl 3 (Teldrassil, Shadowglen)
		[44703]  = true, -- Lvl 3 (Ammen Vale)
		[44794]  = true, -- Lvl 3 (Dethknell, Tirisfal Glades)
		[44820]  = true, -- Lvl 3 (Valley of Trials, Durotar)
		[44937]  = true, -- Lvl 3 (Eversong Woods, Sunstrider Isle)
		[48304]  = true, -- Lvl 3 (Kezan)
		-- Level 55
		[32541]  = true, -- Lvl 55 (Plaguelands: The Scarlet Enclave)
		[32545]  = true, -- Lvl 55 (Eastern Plaguelands)
		-- Level 65
		[32542]  = true, -- Lvl 65 (Eastern Plaguelands)
		-- Level 75
		[32543]  = true, -- Lvl 75 (Eastern Plaguelands)
		-- Level 80
		[32546]  = true, -- Lvl 80 (Eastern Plaguelands)
		-- Level 95
		[79414]  = true, -- Lvl 95 (Broken Shore, Talador)
		-- Level 100
		[87321]  = true, -- Lvl 100 (Stormshield) - Healing
		[88835]  = true, -- Lvl 100 (Warspear) - Healing
		[88906]  = true, -- Lvl 100 (Nagrand)
		[88967]  = true, -- Lvl 100 (Lunarfall, Frostwall)
		[89078]  = true, -- Lvl 100 (Frostwall, Lunarfall)
		-- Levl 100 - 110
		[92167]  = true, -- Lvl 100 - 110 (The Maelstrom, Eastern Plaguelands, The Wandering Isle)
		[92168]  = true, -- Lvl 100 - 110 (The Wandering Isles, Easter Plaguelands)
		[100440] = true, -- Lvl 100 - 110 (The Wandering Isles)
		[100441] = true, -- Lvl 100 - 110 (The Wandering Isles)
		[107483] = true, -- Lvl 100 - 110 (Skyhold)
		[107557] = true, -- Lvl 100 - 110 (Netherlight Temple) - Healing
		[108420] = true, -- Lvl 100 - 110 (Stormwind City, Durotar)
		[111824] = true, -- Lvl 100 - 110 (Azsuna)
		[113674] = true, -- Lvl 100 - 110 (Mardum, the Shattered Abyss) - Dungeoneer
		[113676] = true, -- Lvl 100 - 110 (Mardum, the Shattered Abyss)
		[113687] = true, -- Lvl 100 - 110 (Mardum, the Shattered Abyss) - Swarm
		[113858] = true, -- Lvl 100 - 110 (Trueshot Lodge) - Damage
		[113859] = true, -- Lvl 100 - 110 (Trueshot Lodge) - Damage
		[113862] = true, -- Lvl 100 - 110 (Trueshot Lodge) - Damage
		[113863] = true, -- Lvl 100 - 110 (Trueshot Lodge) - Damage
		[113871] = true, -- Lvl 100 - 110 (Trueshot Lodge) - Damage
		[113967] = true, -- Lvl 100 - 110 (The Dreamgrove) - Healing
		[114832] = true, -- Lvl 100 - 110 (Stormwind City)
		[114840] = true, -- Lvl 100 - 110 (Orgrimmar)
		-- Level 102
		[87322]  = true, -- Lvl 102 (Stormshield) - Tank
		[88836]  = true, -- Lvl 102 (Warspear) - Tank
		[93828]  = true, -- Lvl 102 (Hellfire Citadel)
		[97668]  = true, -- Lvl 102 (Highmountain)
		[98581]  = true, -- Lvl 102 (Highmountain)
		-- Level 110 - 120
		[126781] = true, -- Lvl 110 - 120 (Boralus) - Damage
		[131989] = true, -- Lvl 110 - 120 (Boralus) - Damage
		[131994] = true, -- Lvl 110 - 120 (Boralus) - Healing
		[153285] = true, -- Lvl 110 - 120 (Ogrimmar) - Damage
		[153292] = true, -- Lvl 110 - 120 (Stormwind) - Damage
		-- Level 111 - 120
		[131997] = true, -- Lvl 111 - 120 (Boralus, Zuldazar) - PVP Damage
		[131998] = true, -- Lvl 111 - 120 (Boralus, Zuldazar) - PVP Healing
		-- Level 112 - 120
		[144074] = true, -- Lvl 112 - 120 (Dazar'alor) - PVP Healing
		-- Level 112 - 122
		[131992] = true, -- Lvl 112 - 122 (Boralus) - Tanking
		-- Level 113 - 120
		[132036] = true, -- Lvl 113 - 120 (Boralus) - Healing
		-- Level 113 - 122
		[144078] = true, -- Lvl 113 - 122 (Dazar'alor) - Tanking
		-- Level 114 - 120
		[144075] = true, -- Lvl 114 - 120 (Dazar'alor) - Healing
		-- Level ??
		[24792]  = true, -- Lvl ?? Boss (Location Unknown)
		[30527]  = true, -- Lvl ?? Boss (Location Unknown)
		[87329]  = true, -- Lvl ?? (Stormshield) - Tank
		[88837]  = true, -- Lvl ?? (Warspear) - Tank
		[107202] = true, -- Lvl ?? (Broken Shore) - Raider
		[107484] = true, -- Lvl ?? (Skyhold)
		[113636] = true, -- Lvl ?? (Mardum, the Shattered Abyss) - Raider
		[113860] = true, -- Lvl ?? (Trueshot Lodge) - Damage
		[113864] = true, -- Lvl ?? (Trueshot Lodge) - Damage
		[70245]  = true, -- Lvl ?? (Throne of Thunder)
		[131983] = true, -- Lvl ?? (Boralus) - Damage
		  -- Shadowlands Kyrian
		[154586] = true, -- Stalwart Phalanx
		[154585] = true, -- Valiant's Resolve
		[154583] = true, -- Starlwart Guardian
		[154580] = true, -- Reinforced Guardian
		[160325] = true, -- Humility's Obedience
		[154564] = true, -- Valiant's Humility
		[154567] = true, -- Purity's Cleaning
		[160435] = true, --?? Kyrian Combat Trainer Raider's Training Dummy
		[160432] = true, --60 Kyrian Combat Trainer Training Dummy
		[160434] = true, --62 Kyrian Combat Trainer Dungeoneer's Training Dummy
		-- Shadowlands Venthyr
		[173942] = true, -- Training Dummy
		[175449] = true, -- Raider's Training Dummy
		[175450] = true, -- Dungeoneer's Training Dummy
		[175451] = true, -- Dungeoneer's Tanking Dummy
		[175452] = true, -- Raider's Tanking Dummy
		[175455] = true, -- Cleave Training Dummy
		[175456] = true, -- Swarm Training Dummy
		[175462] = true, -- Sinfall Fiend
		[173072] = true, --60 Training Dummy
		-- Shadowlands Night Fae
		[174565] = true, -- Dungeoneer's Tanking Dummy
		[174566] = true, -- Raider's Tanking Dummy
		[174567] = true, -- Raider's Training Dummy
		[174568] = true, -- Dungeoneer's Training Dummy
		[174569] = true, -- Training Dummy
		[174570] = true, -- Swarm Training Dummy
		[175471] = true, -- Cleave Training Dummy
		[174571] = true, --60 Cleave Training Dummy
		-- Shadowlands Necrolord
		[174491] = true, -- Tanking Dummy
		[174488] = true, -- Raider's Training Dummy
		[174484] = true, -- Dungeoneer's Training Dummy
		[174487] = true, -- Training Dummy
		[174489] = true, --60 Necromantic Guide Healing Dummy
		-- Other
		[65310] = true, -- Turnip Punching Bag
		[173877] = true, -- Reinforced Target Dungeoneer's Training Dummy
		[173867] = true, -- Stalwart Totem Raider's Training Dummy
		[151022] = true, -- Training Dummy
		[171961] = true, -- Damaged Kyrian Combat Trainer Training Dummy
		[173873] = true, -- Reinforced Death Elemental Dungeoneer's Training Dummy
		[173866] = true, -- Reinforced Totem Dungeoneer's Training Dummy
		[173870] = true, -- Stalwart Death Elemental Raider's Training Dummy
		[173879] = true, -- Stalwart Target Raider's Training Dummy
		[149860] = true, -- Training Dummy
		[174435] = true, -- Training Dummy
		-- DragonFlight
		[198594] = true, -- Cleave Training Dummy
		[194648] = true, -- Training Dummy
		[189632] = true, -- Animated Duelist
		[194643] = true, -- Dungeoneer's Training Dummy
		[197833] = true, -- PvP Training Dummy
		[194644] = true, -- Dungeoneer's Training Dummy
		[189617] = true, -- Boulderfist Raider's Tanking Dummy
		[194649] = true, -- Normal Tanking Dummy
		[194645] = true, -- Healing Training Dummy
		[197834] = true, -- Healing PvP Training Dummy
		[194646] = true, -- Healing Training Dummy
		[193563] = true, -- Azure Span Training Dummy
		-- The War Within Dornogal
		[219250] = true, -- PvP Training Dummy <Damage>
		[225982] = true, -- Cleave Training Dummy <Damage>
		[225982] = true, -- Cleave Training Dummy <Damage>
		[225980] = true, -- Training Dummy <Healing>
		[225976] = true, -- Normal Tank Dummy <Tanking>
		[225977] = true, -- Dungeoneer's Training Dummy <Tanking>
		[225978] = true, -- Crystalmaw <Raider's Tanking Dummy>
		[225983] = true, -- Dungeoneer's Training Dummy <Damage>
		[225985] = true, -- Kelpfist <Raider's Training Dummy>
		[225984] = true, -- Training Dummy <Damage>
	},
	IsDummyPvP 					= {
		-- City (SW, Orgri, ...)
		[114840] = true, -- Raider's Training Dummy
		[114832] = true,
		[131997] = true,
		-- The War Within Dornogal
		[219250] = true, -- PvP Training Dummy <Damage>
	},
	IsCondemnedDemon			= {
		[169428]				= "Wrathguard",
		[169421]				= "Felguard",
		[169426]				= "Infernal",
		[169429]				= "Shivarra",
		[168932]				= "Doomguard",
		[169304]				= "Condemned Demon",
		[169425]				= "Felhound",
		[169430]				= "Ur'zul",
	},
	IsVoidTendril				= {
		[65282]					= "Void Tendril",
	},
	ExplosivesName				= {
		[GameLocale] 			= "Explosives",
		ruRU					= "Ãâ€™ÃÂ·Ã‘â‚¬Ã‘â€¹ÃÂ²Ã‘â€¡ÃÂ°Ã‘â€šÃÂºÃÂ°",
		enGB					= "Explosives",
		enUS					= "Explosives",
		deDE					= "Sprengstoff",
		esES					= "Explosivos",
		esMX					= "Explosivos",
		frFR					= "Explosifs",
		itIT					= "Esplosivi",
		ptPT					= "Explosivos",
		ptBR					= "Explosivos",
		koKR					= "Ã­ÂÂ­Ã«Â°Å“Ã«Â¬Â¼",
		zhCN					= "Ã§Ë†â€ Ã§â€šÂ¸Ã§â€°Â©",
		zhTW					= "Ã§Ë†â€ Ã§â€šÂ¸Ã§â€°Â©",
	},
	IncorporealBeingName		= {
		[GameLocale] 			= "Incorporeal Being",
		ruRU					= "Ãâ€˜ÃÂµÃ‘ÂÃ‘â€šÃÂµÃÂ»ÃÂµÃ‘ÂÃÂ½Ã‘â€¹ÃÂ¹ ÃÂ´Ã‘Æ’Ã‘â€¦",
		enGB					= "Incorporeal Being",
		enUS					= "Incorporeal Being",
		deDE					= "KÃƒÂ¶rperloses Wesen",
		esES					= "Ser incorpÃƒÂ³reo",
		esMX					= "Ser incorpÃƒÂ³reo",
		frFR					= "Etre immatÃƒÂ©riel",
		itIT					= "Essere Incorporeo",
		ptPT					= "Ser IncorpÃƒÂ³reo",
		ptBR					= "Ser IncorpÃƒÂ³reo",
		koKR					= "Ã«Â¬Â´Ã­Ëœâ€¢Ã¬ÂËœ Ã¬Â¡Â´Ã¬Å¾Â¬",
		zhCN					= "Ã¨â„¢Å¡Ã¤Â½â€œÃ§â€Å¸Ã§â€°Â©",
		zhTW					= "Ã¨â„¢Å¡Ã¤Â½â€œÃ§â€Å¸Ã§â€°Â©",
	},
	OrbOfAscendanceName			= {
		[GameLocale] 			= "Orb of Ascendance",
		ruRU					= "ÃÂ¡Ã‘â€žÃÂµÃ‘â‚¬ÃÂ° ÃÂ²ÃÂ¾ÃÂ·ÃÂ½ÃÂµÃ‘ÂÃÂµÃÂ½ÃÂ¸Ã‘Â",
		enGB					= "Orb of Ascendance",
		enUS					= "Orb of Ascendance",
		deDE					= "Kugel der Aszendenz",
		esES					= "Orbe de AscensiÃƒÂ³n",
		esMX					= "Orbe de AscensiÃƒÂ³n",
		frFR					= "Orbe de Sublimation",
		itIT					= "Globo dell'Ascesa",
		ptPT					= "Orbe da AscendÃƒÂªncia",
		ptBR					= "Orbe da AscendÃƒÂªncia",
		koKR					= "Ã¬Å Â¹Ã¬Â²Å“Ã¬ÂËœ Ã«Â³Â´Ã¬Â£Â¼",
		zhCN					= "Ã¦â€°Â¬Ã¥Ââ€¡Ã¥Â®ÂÃ§ÂÂ ",
		zhTW					= "Ã¦â€°Â¬Ã¥Ââ€¡Ã¥Â®ÂÃ§ÂÂ ",
	},
	IsBoss 						= {
		-- City (SW, Orgri, ...)
		[31146] = true, -- Raider's Training Dummy
		-- WoD Alliance Garrison
		[87320] = true, -- Mage Tower Damage Raider's Training Dummy
		[88314] = true, -- Tanking Dungeoneer's Training Dummy
		[88316] = true, -- Healing Training Dummy ----> FRIENDLY
		-- WoD Horde Garrison
		[87762] = true, -- Mage Tower Damage Raider's Training Dummy
		[88288] = true, -- Tanking Dungeoneer's Training Dummy
		[88289] = true, -- Healing Training Dummy ----> FRIENDLY
		-- Legion Druid Class Order Hall
		[113964] = true, -- Raider's Training Dummy
		-- Legion Rogue Class Order Hall
		[92166] = true, -- Raider's Training Dummy
		-- BfA Dazar'Alor
		[144086] = true, -- Raider's Training Dummy
		-- Level ??
		[24792]  = true, -- Lvl ?? Boss (Location Unknown)
		[30527]  = true, -- Lvl ?? Boss (Location Unknown)
		[87329]  = true, -- Lvl ?? (Stormshield) - Tank
		[88837]  = true, -- Lvl ?? (Warspear) - Tank
		[107202] = true, -- Lvl ?? (Broken Shore) - Raider
		[107484] = true, -- Lvl ?? (Skyhold)
		[113636] = true, -- Lvl ?? (Mardum, the Shattered Abyss) - Raider
		[113860] = true, -- Lvl ?? (Trueshot Lodge) - Damage
		[113864] = true, -- Lvl ?? (Trueshot Lodge) - Damage
		[70245]  = true, -- Lvl ?? (Throne of Thunder)
		[131983] = true, -- Lvl ?? (Boralus) - Damage
	},
	IsNotBoss 					= {
		-- BfA
		-- Shadow of Zul
		[138489] = true,
	},
	ControlAbleClassification 	= {
		["trivial"] 			= true,
		["minus"] 				= true,
		["normal"] 				= true,
		["rare"] 				= true,
		["rareelite"] 			= true,
		["elite"] 				= true,
		["worldboss"] 			= false,
		[""] 					= true,
	},
	FlagsBuffs					= {
		[156621] 				= true,
		[156618] 				= true,
		[34976] 				= true,
		[GetSpellName(156621)] 	= true,
		[GetSpellName(156618)]	= true,
		[GetSpellName(34976)] 	= true,
	},
	Cyclone 					= {
		SpellName 				= {
			[GetSpellName(33786)] = true, 	-- Cyclone
			[GetSpellName(710)] = true,		-- Banish
		},
		OnEvent					= {
			["SPELL_AURA_APPLIED"] = "Add",
			["SPELL_AURA_REFRESH"] = "Add",
			["SPELL_AURA_REMOVED"] = "Remove",
		},
		GUIDs 					= {},
	},
}

local InfoCacheMoveIn						= Info.CacheMoveIn
local InfoCacheMoveOut						= Info.CacheMoveOut
local InfoCacheMoving						= Info.CacheMoving
local InfoCacheStaying						= Info.CacheStaying
local InfoCacheInterrupt					= Info.CacheInterrupt

local InfoSpecsWithExecute 					= Info.SpecsWithExecute
local InfoSpecsMoonkinRestor 				= Info.SpecsMoonkinRestor
local InfoSpecsFeralGuardian 				= Info.SpecsFeralGuardian
local InfoSpecIs 							= Info.SpecIs
local InfoClassSpecBuffs					= Info.ClassSpecBuffs
local InfoClassSpecSpells					= Info.ClassSpecSpells
local InfoClassIsMelee 						= Info.ClassIsMelee
local InfoClassCanBeHealer 					= Info.ClassCanBeHealer
local InfoClassCanBeTank 					= Info.ClassCanBeTank
local InfoClassCanBeMelee 					= Info.ClassCanBeMelee
local InfoAllCC 							= Info.AllCC

local InfoCreatureType 						= Info.CreatureType
local InfoCreatureFamily					= Info.CreatureFamily
local InfoIsDummy							= Info.IsDummy
local InfoIsDummyPvP						= Info.IsDummyPvP
local InfoIsVoidTendriln					= Info.IsVoidTendril
local InfoIsCondemnedDemon					= Info.IsCondemnedDemon
local InfoExplosivesName 					= Info.ExplosivesName
local InfoIncorporealBeingName				= Info.IncorporealBeingName
local InfoOrbOfAscendanceName				= Info.OrbOfAscendanceName

local InfoIsBoss 							= Info.IsBoss
local InfoIsNotBoss 						= Info.IsNotBoss
local InfoControlAbleClassification			= Info.ControlAbleClassification
local InfoFlagsBuffs 						= Info.FlagsBuffs

local InfoCyclone							= Info.Cyclone
local InfoCycloneSpellName					= InfoCyclone.SpellName
local InfoCycloneOnEvent					= InfoCyclone.OnEvent
local InfoCycloneGUIDs						= InfoCyclone.GUIDs

A.Unit = PseudoClass({
	-- If it's by "UnitGUID" then it will use cache for different unitID with same unitGUID (which is not really best way to waste performance)
	-- Use "UnitGUID" only on high required resource functions
	-- Pass - no cache at all
	-- Wrap - is a cache
	Name 									= Cache:Pass(function(self)
		-- @return string
		local unitID 						= self.UnitID
		local name = UnitName(unitID)
		if issecretvalue_local and issecretvalue_local(name) then return str_none end
		return name or str_none
	end, "UnitID"),
	Race 									= Cache:Pass(function(self)
		-- @return string
		local unitID 						= self.UnitID
		if UnitIsUnit(unitID, "player") then
			return A.PlayerRace
		end

		local ok, val = pcall(function() return select(2, UnitRace(unitID)) end)
		if not ok then return str_none end
		if issecretvalue_local and issecretvalue_local(val) then return str_none end
		return val or str_none
	end, "UnitID"),
	Class 									= Cache:Pass(function(self)
		-- @return string
		local unitID 						= self.UnitID
		if UnitIsUnit(unitID, "player") then
			return PlayerClass
		end

		local ok, val = pcall(function() return select(2, UnitClass(unitID)) end)
		if not ok then return str_none end
		if issecretvalue_local and issecretvalue_local(val) then return str_none end
		return val or str_none
	end, "UnitID"),
	Role 									= Cache:Pass(function(self, hasRole)
		-- @param hasRole 	- nil or string one of follows: "TANK", "HEALER", "DAMAGER", "NONE"
		-- @return boolean	- if 'hasRole' passed as string
		-- @return string	- otherwise returns role of unitID: "TANK", "HEALER", "DAMAGER", "NONE"
		local unitID 						= self.UnitID
		local rok, role						= pcall(UnitGroupRolesAssigned, unitID)
		if not rok then role = "NONE" end
		if _G.issecretvalue and _G.issecretvalue(role) then role = "NONE" end

		if not role or role == "NONE" then
			if A.ZoneID == 480 then
				-- Proving Grounds
				local npcID = self(unitID):InfoGUID()
				if npcID == 72218 then
					-- Oto the Protector
					role = "TANK"
				elseif npcID == 71828 then
					-- Sikari the Mistweaver
					role = "HEALER"
				else
					role = "DAMAGER"
				end
			elseif hasRole then 
				if hasRole == "HEALER" then 
					return self(unitID):IsHealer()
				elseif hasRole == "TANK" then 
					return self(unitID):IsTank()
				elseif hasRole == "DAMAGER" then 
					return self(unitID):IsDamager()
				elseif hasRole == "NONE" then 
					return true
				else 
					return false
				end 
			else 
				if self(unitID):IsHealer() then 
					return "HEALER"
				elseif self(unitID):IsTank() then 
					return "TANK"
				elseif self(unitID):IsDamager() then 
					return "DAMAGER"
				else 
					return "NONE"
				end 
			end
		end

		return (hasRole and hasRole == role) or (not hasRole and role)
	end, "UnitID"),
	Classification							= Cache:Pass(function(self)
		-- @return string or empty string
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitClassification, unitID)
		if not ok then return str_empty end
		if issecretvalue_local and issecretvalue_local(val) then return str_empty end
		return val or str_empty
	end, "UnitID"),
	CreatureType							= Cache:Pass(function(self)
		-- @return string or empty string
		-- Returns formated string to English, possible string returns:
		-- "Beast"				-- [1]
		-- "Dragonkin"			-- [2]
		-- "Demon"				-- [3]
		-- "Elemental"			-- [4]
		-- "Giant"				-- [5]
		-- "Undead"				-- [6]
		-- "Humanoid"			-- [7]
		-- "Critter"			-- [8]
		-- "Mechanical",		-- [9]
		-- "Not specified"		-- [10]
		-- "Not specified"		-- [10]	(The default UI displays an empty string instead of "Not specified" for units with that creature type)
		-- "Totem"				-- [11]
		-- "Non-combat Pet"		-- [12]
		-- "Gas Cloud"			-- [13]
		-- "Wild Pet"			-- [14]
		-- "Aberration"			-- [15]
		local unitID 						= self.UnitID
		local ok, unitCreatureType 			= pcall(UnitCreatureType, unitID)
		if not ok then return str_empty end
		if not unitCreatureType then return str_empty end
		if _G.issecretvalue and _G.issecretvalue(unitCreatureType) then return str_empty end
		return InfoCreatureType[unitCreatureType] or str_empty
	end, "UnitID"),
	CreatureFamily							= Cache:Pass(function(self)
		-- @return string or empty string
		-- Returns formated string to English, possible string returns:
		-- "Wolf"					-- [1]
		-- "Cat"					-- [2]
		-- "Spider"					-- [3]
		-- "Bear"					-- [4]
		-- "Boar"					-- [5]
		-- "Crocolisk"				-- [6]
		-- "Carrion Bird"			-- [7]
		-- "Crab"					-- [8]
		-- "Gorilla"				-- [9]
		-- "Raptor"					-- [11]
		-- "Tallstrider"			-- [12]
		-- "Felhunter"				-- [15]
		-- "Voidwalker"				-- [16]
		-- "Succubus"				-- [17]
		-- "Doomguard"				-- [19]
		-- "Scorpid"				-- [20]
		-- "Turtle"					-- [21]
		-- "Imp"					-- [23]
		-- "Bat"					-- [24]
		-- "Hyena"					-- [25]
		-- "Bird of Prey"			-- [26]
		-- "Wind Serpent"			-- [27]
		-- "Remote Control"			-- [28]
		-- "Felguard"				-- [29]
		-- "Dragonhawk"				-- [30]
		-- "Ravager"				-- [31]
		-- "Warp Stalker"			-- [32]
		-- "Sporebat"				-- [33]
		-- "Ray"					-- [34]
		-- "Serpent"				-- [35]
		-- "Moth"					-- [37]
		-- "Chimaera"				-- [38]
		-- "Devilsaur"				-- [39]
		-- "Ghoul"					-- [40]
		-- "Silithid"				-- [41]
		-- "Worm"					-- [42]
		-- "Clefthoof"				-- [43]
		-- "Wasp"					-- [44]
		-- "Core Hound"				-- [45]
		-- "Spirit Beast"			-- [46]
		-- "Water Elemental"		-- [49]
		-- "Fox"					-- [50]
		-- "Monkey"					-- [51]
		-- "Dog"					-- [52]
		-- "Beetle"					-- [53]
		-- "Shale Spider"			-- [55]
		-- "Zombie"					-- [56]
		-- "<< QA TEST FAMILY >>"	-- [57]
		-- "Hydra"					-- [68]
		-- "Fel Imp"				-- [100]
		-- "Voidlord"				-- [101]
		-- "Shivarra"				-- [102]
		-- "Observer"				-- [103]
		-- "Wrathguard"				-- [104]
		-- "Infernal"				-- [108]
		-- "Fire Elemental"			-- [116]
		-- "Earth Elemental"		-- [117]
		-- "Crane"					-- [125]
		-- "Water Strider"			-- [126]
		-- "Rodent"					-- [127]
		-- "Quilen"					-- [128]
		-- "Goat"					-- [129]
		-- "Basilisk"				-- [130]
		-- "Direhorn"				-- [138]
		-- "Storm Elemental"		-- [145]
		-- "Terrorguard"			-- [147]
		-- "Abyssal"				-- [148]
		-- "Riverbeast"				-- [150]
		-- "Stag"					-- [151]
		-- "Mechanical"				-- [154]
		-- "Abomination"			-- [155]
		-- "Scalehide"				-- [156]
		-- "Oxen"					-- [157]
		-- "Feathermane"			-- [160]
		-- "Lizard"					-- [288]
		-- "Pterrordax"				-- [290]
		-- "Toad"					-- [291]
		-- "Krolusk"				-- [292]
		-- "Blood Beast"			-- [296]
		local unitID 						= self.UnitID
		local ok, unitCreatureFamily = pcall(UnitCreatureFamily, unitID)
		if not ok then return str_empty end
		if issecretvalue_local and issecretvalue_local(unitCreatureFamily) then return str_empty end
		return unitCreatureFamily and InfoCreatureFamily[unitCreatureFamily] or str_empty
	end, "UnitID"),
	InfoGUID 								= Cache:Wrap(function(self, unitGUID)
		-- @return
		-- For players: Player-[server ID]-[player UID] (Example: "Player-970-0002FD64")
		-- For creatures, pets, objects, and vehicles: [Unit type]-0-[server ID]-[instance ID]-[zone UID]-[ID]-[spawn UID] (Example: "Creature-0-970-0-11-31146-000136DF91")
		-- Unit Type Names: "Player", "Creature", "Pet", "GameObject", "Vehicle", and "Vignette" they are always in English
		-- [1] utype
		-- [2] zero 		or server_id
		-- [3] server_id 	or player_uid
		-- [4] instance_id	or nil
		-- [5] zone_uid		or nil
		-- [6] npc_id		or nil
		-- [7] spawn_uid 	or nil
		-- or nil
		-- Nill-able: unitGUID
		local unitID 						= self.UnitID
		local GUID 							= unitGUID or UnitGUID(unitID)
		if GUID then
			local utype, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", GUID)
			if utype then
				return utype, toNum[zero], toNum[server_id], instance_id and toNum[instance_id], zone_uid and toNum[zone_uid], npc_id and toNum[npc_id], spawn_uid and toNum[spawn_uid]
			end
		end
	end, "UnitID"),
	InLOS 									= Cache:Pass(function(self, unitGUID)
		-- @return boolean
		-- Nill-able: unitGUID
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitInLOS, unitID, unitGUID)
		if not ok then return true end
		if issecretvalue_local and issecretvalue_local(val) then return true end
		return val
	end, "UnitID"),
	InGroup 								= Cache:Pass(function(self, includeAnyGroups, unitGUID)
		-- @return boolean
		local unitID 						= self.UnitID
		if includeAnyGroups then
			local ok, val = pcall(UnitInAnyGroup, unitID)
			if not ok then return false end
			if issecretvalue_local and issecretvalue_local(val) then return false end
			return val and true or false
		else
			local GUID = unitGUID or GetGUID(unitID)
			if issecretvalue_local and GUID and issecretvalue_local(GUID) then return false end
			return GUID and (TeamCacheFriendlyGUIDs[GUID] or TeamCacheEnemyGUIDs[GUID])
		end
	end, "UnitID"),
	InParty									= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitPlayerOrPetInParty, unitID)
		if not ok then return false end
		if issecretvalue_local and issecretvalue_local(val) then return false end
		return val and true or false
	end, "UnitID"),
	InRaid									= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitPlayerOrPetInRaid, unitID)
		if not ok then return false end
		if issecretvalue_local and issecretvalue_local(val) then return false end
		return val and true or false
	end, "UnitID"),
	InRange 								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local isSelf = UnitIsUnit(unitID, "player")
		if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = false end
		if isSelf then return true end
		local inRange, checkedRange = UnitInRange(unitID)
		if issecretvalue_local then
			if issecretvalue_local(checkedRange) or issecretvalue_local(inRange) then return true end
		end
		if not checkedRange then return true end
		return inRange and true or false
	end, "UnitID"),
	InVehicle								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitInVehicle, unitID)
		if not ok then return false end
		if issecretvalue_local and issecretvalue_local(val) then return false end
		return val and true or false
	end, "UnitID"),
	InCC 									= Cache:Pass(function(self, index)
		-- @return number (time in seconds of remain crownd control)
		-- Nill-able: index
		local unitID 						= self.UnitID
		local value 						= self(unitID):DeBuffCyclone()
		if value == 0 then
			for i = (index or 1), #InfoAllCC do
				value = self(unitID):HasDeBuffs(InfoAllCC[i])
				if value ~= 0 then
					break
				end
			end
		end
		return value
	end, "UnitID"),
	IsEnemy									= Cache:Wrap(function(self, isPlayer)
		-- @return boolean
		-- Nill-able: isPlayer
		local unitID 						= self.UnitID
		if not unitID then return false end

		local canAttack
		local attackFn = _G.UnitCanAttack or UnitCanAttack
		if type(attackFn) == "function" then
			local ok, val = pcall(attackFn, "player", unitID)
			if ok then
				canAttack = NormalizeBoolean(val)
			end
		end

		local isEnemy
		local enemyFn = _G.UnitIsEnemy or UnitIsEnemy
		if type(enemyFn) == "function" then
			local ok, val = pcall(enemyFn, "player", unitID)
			if ok then
				isEnemy = NormalizeBoolean(val)
			end
		end

		local matchesPlayerGate = true
		if isPlayer then
			local isPlayerFn = _G.UnitIsPlayer or UnitIsPlayer
			if type(isPlayerFn) ~= "function" then
				return false
			end

			local ok, val = pcall(isPlayerFn, unitID)
			if not ok then
				return false
			end

			matchesPlayerGate = NormalizeBoolean(val) == true
		end

		return (canAttack == true or isEnemy == true) and matchesPlayerGate
	end, "UnitGUID"),
	IsHealer 								= Cache:Pass(function(self, class)  
		-- @return boolean
		-- Nill-able: class
		local unitID 						= self.UnitID
		local unitID_class 					= class or self(unitID):Class()		
		if InfoClassCanBeHealer[unitID_class] then
			local isEnemy 					= self(unitID):IsEnemy()
			if isEnemy then
				if TeamCacheEnemyHEALER[unitID] or self(unitID):HasSpec(InfoSpecIs.HEALER) then
					return true
				elseif BuildToC >= 50500 and (A.Zone == "pvp" or A.Zone == "arena") then
					return false
				end
			else
				if TeamCacheFriendlyHEALER[unitID] then
					return true
				end
				
				local role = UnitGroupRolesAssigned(unitID)
				if role == "HEALER" or (UnitIsUnit(unitID, "player") and self(unitID):HasSpec(InfoSpecIs.HEALER)) then
					return true
				elseif role and role ~= "NONE" then
					return false
				elseif GetPartyAssignment("maintank", unitID) or GetPartyAssignment("mainassist", unitID) then
					return false
				end
			end
			
			-- Fallback
			if unitID_class == "PALADIN" then 				
				local _, power = UnitPowerType(unitID)
				local _, offhand = UnitAttackSpeed(unitID)
				if power ~= "MANA" or offhand ~= nil then
					return false
				else
					local tankBuff = self(unitID):HasBuffs(InfoClassCanBeTank[unitID_class])
					if tankBuff > 0 then 
						-- Protection
						if not A_GetUnitItem or isEnemy or A_GetUnitItem(unitID, CONST.INVSLOT_OFFHAND, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD, nil, true) then -- byPassDistance, so if buff is up he's more likely tank
							return false
						end
					else
						-- Retribution
						if not isEnemy and A_GetUnitItem and not A_GetUnitItem(unitID, CONST.INVSLOT_OFFHAND, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD) then
							return false
						end
					end
				end				
			elseif unitID_class == "DRUID" then 
				local _, power = UnitPowerType(unitID)
				if power ~= "MANA" or self(unitID):HasBuffs(InfoClassCanBeTank[unitID_class]) > 0 then
					return false
				end
			elseif unitID_class == "MONK" then
				local _, power = UnitPowerType(unitID)
				local _, offhand = UnitAttackSpeed(unitID)
				if power == "MANA" then
					return true
				elseif offhand ~= nil then
					return false
				elseif UnitStagger and (UnwrapValue(UnitStagger(unitID)) or 0) ~= 0 then
					return false
				end					
			elseif unitID_class == "PRIEST" then
				local _, power = UnitPowerType(unitID)
				if power ~= "MANA" then
					return false
				end
			elseif unitID_class == "SHAMAN" then
				local _, power = UnitPowerType(unitID)
				local _, offhand = UnitAttackSpeed(unitID)
				if power ~= "MANA" or offhand ~= nil then
					return false
				end			
			end
			
			if not A.IsInPvP then
				local unitIDtarget = strjoin("", unitID, "target")
				local okUU, isUU = pcall(UnitIsUnit, unitID, strjoin("", unitIDtarget, "target"))
				local okTest, testVal = pcall(function() return isUU and true or false end)
				if okUU and okTest and testVal and self(unitIDtarget):IsBoss() then
					return false
				end
			end

											-- bypass it in PvP
			local taken_dmg 				= (self(unitID):IsEnemy() and self(unitID):IsPlayer() and 0) or CombatTracker:GetDMG(unitID)
			local done_dmg					= CombatTracker:GetDPS(unitID)
			local done_hps					= CombatTracker:GetHPS(unitID)
			return done_hps > taken_dmg and done_hps > done_dmg  
		end 
	end, "UnitID"),
	IsHealerClass							= Cache:Pass(function(self)  
		-- @return boolean
		local unitID 						= self.UnitID
		return InfoClassCanBeHealer[self(unitID):Class()]
	end, "UnitID"),	
	IsTank 									= Cache:Pass(function(self, class)    
		-- @return boolean 
		-- Nill-able: class
		local unitID 						= self.UnitID
		local unitID_class 					= class or self(unitID):Class()
		local tankBuffsOrCanBeTank			= InfoClassCanBeTank[unitID_class]
		if tankBuffsOrCanBeTank then 
			local isEnemy 					= self(unitID):IsEnemy()
			if isEnemy then
				if TeamCacheEnemyTANK[unitID] or self(unitID):HasSpec(InfoSpecIs.TANK) then
					return true
				elseif BuildToC >= 50500 and (A.Zone == "pvp" or A.Zone == "arena") then
					return false
				end
			else
				if TeamCacheFriendlyTANK[unitID] then
					return true
				end
				
				local role = UnitGroupRolesAssigned(unitID)
				if role == "TANK" or GetPartyAssignment("maintank", unitID) or (UnitIsUnit(unitID, "player") and self(unitID):HasSpec(InfoSpecIs.TANK)) then
					return true
				elseif role and role ~= "NONE" then
					return false
				end	
			end		
			
			-- Fallback
			if unitID_class == "PALADIN" then 
				local _, power = UnitPowerType(unitID)
				local _, offhand = UnitAttackSpeed(unitID)
				if power ~= "MANA" or offhand ~= nil then
					return false
				else
					local tankBuff = self(unitID):HasBuffs(tankBuffsOrCanBeTank)
					if tankBuff > 0 then 
						-- Protection
						if not A_GetUnitItem or isEnemy or A_GetUnitItem(unitID, CONST.INVSLOT_OFFHAND, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD, nil, true) then -- byPassDistance, so if buff is up he's more likely tank
							return true
						end
					else
						-- Retribution
						if A.IsInPvP or self(unitID):ThreatSituation(strjoin("", unitID, "target")) < 3 then
							return false
						end
					end
				end
			elseif unitID_class == "DRUID" then 
				local _, power = UnitPowerType(unitID)
				return power == "RAGE" or self(unitID):HasBuffs(tankBuffsOrCanBeTank) > 0
			elseif unitID_class == "WARRIOR" then				
				local _, offhand = UnitAttackSpeed(unitID)
				-- 1h+shield ensures he's friendly tank
				if offhand == nil and not isEnemy and A_GetUnitItem and A_GetUnitItem(unitID, CONST.INVSLOT_OFFHAND, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD) then -- don't byPassDistance
					return true
				end
				
				if self(unitID):HasBuffs(tankBuffsOrCanBeTank) == 0 and (A.IsInPvP or self(unitID):ThreatSituation(strjoin("", unitID, "target")) < 3) then
					return false
					-- Ã¢â€ â€œÃ¢â€ â€œÃ¢â€ â€œ if warrior in Defensive Stance or has threat he can be tank even without shield equipped aka fury tank, then we will use generic approach below to recognize it Ã¢â€ â€œÃ¢â€ â€œÃ¢â€ â€œ
				end
			elseif unitID_class == "MONK" then
				local _, power = UnitPowerType(unitID)
				local _, offhand = UnitAttackSpeed(unitID)
				if power == "MANA" or offhand ~= nil then
					return false
				elseif UnitStagger and (UnwrapValue(UnitStagger(unitID)) or 0) ~= 0 then
					return true
				end				
			elseif unitID_class == "DEATHKNIGHT" then
				local _, offhand = UnitAttackSpeed(unitID)
				return offhand == nil and self(unitID):HasBuffs(tankBuffsOrCanBeTank) > 0
			end
			
			if not A.IsInPvP then
				local unitIDtarget = strjoin("", unitID, "target")
				local okUU, isUnit = pcall(UnitIsUnit, unitID, strjoin("", unitIDtarget, "target"))
				local okTest, testResult = pcall(function() return isUnit and true or false end)
				if okUU and okTest and testResult and self(unitIDtarget):IsBoss() then
					return true
				end
			end					
			
			local taken_dmg 				= CombatTracker:GetDMG(unitID)
			local done_dmg					= CombatTracker:GetDPS(unitID)
			local done_hps					= CombatTracker:GetHPS(unitID)
			return taken_dmg > done_dmg and taken_dmg > done_hps
		end 
	end, "UnitID"),	
	IsTankClass								= Cache:Pass(function(self)  
		-- @return boolean
		local unitID 						= self.UnitID
		return InfoClassCanBeTank[self(unitID):Class()] and true -- don't touch true otherwise it may return table or number because of tank buffs
	end, "UnitID"),	
	IsDamager								= Cache:Pass(function(self, class)    
		-- @return boolean 
		local unitID 						= self.UnitID
		local unitID_class 					= class or self(unitID):Class()
		local isEnemy 						= self(unitID):IsEnemy()
	    if isEnemy then
			if TeamCacheEnemyDAMAGER[unitID] or self(unitID):HasSpec(InfoSpecIs.DAMAGER) then
				return true
			elseif BuildToC >= 50500 and (A.Zone == "pvp" or A.Zone == "arena") then
				return false
			end
		else
			if TeamCacheFriendlyDAMAGER[unitID] then
				return true
			end
			
			local role = UnitGroupRolesAssigned(unitID)
			if role == "DAMAGER" or (UnitIsUnit(unitID, "player") and self(unitID):HasSpec(InfoSpecIs.DAMAGER)) then
				return true
			elseif role and role ~= "NONE" then
				return false
			elseif GetPartyAssignment("maintank", unitID) then
				return false
			end
		end
		
		-- Fallback
		if unitID_class == "PALADIN" then 
			local _, power = UnitPowerType(unitID)
			local _, offhand = UnitAttackSpeed(unitID)
			if power ~= "MANA" or offhand ~= nil then
				return true
			else
				local tankBuff = self(unitID):HasBuffs(InfoClassCanBeTank[unitID_class])
				if tankBuff > 0 then 
					-- Protection
					if not A_GetUnitItem or isEnemy or A_GetUnitItem(unitID, CONST.INVSLOT_OFFHAND, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD, nil, true) then -- byPassDistance, so if buff is up he's more likely tank
						return false
					end
				else
					-- Retribution
					if not isEnemy and A_GetUnitItem and not A_GetUnitItem(unitID, CONST.INVSLOT_OFFHAND, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD) then
						return true
					end
				end
			end			
		elseif unitID_class == "DRUID" then 			
			if self(unitID):HasBuffs(InfoClassCanBeTank[unitID_class]) > 0 then
				return false
			end
			
			local _, power = UnitPowerType(unitID)
			return power == "ENERGY" or power == "LUNARPOWER" 
		elseif unitID_class == "MONK" then
			local _, power = UnitPowerType(unitID)
			local _, offhand = UnitAttackSpeed(unitID)
			if power == "MANA" then
				return false
			elseif offhand ~= nil or (UnitStagger and (UnwrapValue(UnitStagger(unitID)) or 0) == 0) then
				return true
			end
		elseif unitID_class == "PRIEST" then
			local _, power = UnitPowerType(unitID)
			if power ~= "MANA" then
				return true
			end
		elseif unitID_class == "SHAMAN" then
			local _, power = UnitPowerType(unitID)
			local _, offhand = UnitAttackSpeed(unitID)
			if power ~= "MANA" or offhand ~= nil then
				return true
			end	
		end
		
		if not A.IsInPvP then
			local unitIDtarget = strjoin("", unitID, "target")
			local okUU, isUU = pcall(UnitIsUnit, unitID, strjoin("", unitIDtarget, "target"))
			local okTest, testVal = pcall(function() return isUU and true or false end)
			if okUU and okTest and testVal and self(unitIDtarget):IsBoss() then
				return false
			end
		end

											-- bypass it in PvP
		local taken_dmg 					= (isEnemy and self(unitID):IsPlayer() and 0) or CombatTracker:GetDMG(unitID) 
		local done_dmg						= CombatTracker:GetDPS(unitID)
		local done_hps						= CombatTracker:GetHPS(unitID)
		return done_dmg > taken_dmg and done_dmg > done_hps 
	end, "UnitID"),	
	IsMelee 								= Cache:Pass(function(self, class) 
		-- @return boolean 
		local unitID 						= self.UnitID
		local unitID_class 					= class or self(unitID):Class()		
		if InfoClassCanBeMelee[unitID_class] then
			local isEnemy 					= self(unitID):IsEnemy()
			if isEnemy then
				if TeamCacheEnemyDAMAGER_MELEE[unitID] or self(unitID):HasSpec(InfoSpecIs.MELEE) then
					return true
				elseif BuildToC >= 50500 and (A.Zone == "pvp" or A.Zone == "arena") then
					return false
				end
			else
				if TeamCacheFriendlyDAMAGER_MELEE[unitID] then
					return true
				end

				local role = UnitGroupRolesAssigned(unitID)
				if role == "TANK" or (role == "DAMAGER" and (unitID_class == "PALADIN" or unitID_class == "MONK")) or GetPartyAssignment("maintank", unitID) or (UnitIsUnit(unitID, "player") and self(unitID):HasSpec(InfoSpecIs.MELEE)) then
					return true
				elseif role == "HEALER" then
					return false
				end
			end 
			
			-- Fallback
			if unitID_class == "PALADIN" then	
				local _, power = UnitPowerType(unitID)
				local _, offhand = UnitAttackSpeed(unitID)
				if power ~= "MANA" or offhand ~= nil then
					return true
				else
					local tankBuff = self(unitID):HasBuffs(InfoClassCanBeTank[unitID_class])
					if tankBuff > 0 then 
						-- Protection
						if not A_GetUnitItem or isEnemy or A_GetUnitItem(unitID, CONST.INVSLOT_OFFHAND, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD, nil, true) then -- byPassDistance, so if buff is up he's more likely tank
							return true
						end
					else
						-- Retribution
						if not isEnemy and A_GetUnitItem and not A_GetUnitItem(unitID, CONST.INVSLOT_OFFHAND, LE_ITEM_CLASS_ARMOR, LE_ITEM_ARMOR_SHIELD) then
							return true
						end
						
															-- bypass it in PvP 
						local taken_dmg 					= (isEnemy and self(unitID):IsPlayer() and 0) or CombatTracker:GetDMG(unitID) 
						local done_dmg						= CombatTracker:GetDPS(unitID)
						local done_hps						= CombatTracker:GetHPS(unitID)
						return done_dmg > taken_dmg and done_dmg > done_hps 
					end
				end
			elseif unitID_class == "HUNTER" then
				return
				(
					self(unitID):GetSpellCounter(186270) > 0 or -- Raptor Strike
					self(unitID):GetSpellCounter(259387) > 0 or -- Mongoose Bite
					self(unitID):GetSpellCounter(190925) > 0 or -- Harpoon
					self(unitID):GetSpellCounter(259495) > 0    -- Firebomb
				)
			elseif unitID_class == "SHAMAN" then
				local _, offhand = UnitAttackSpeed(unitID)
				return offhand ~= nil
			elseif unitID_class == "MONK" then
				local _, power = UnitPowerType(unitID)
				local _, offhand = UnitAttackSpeed(unitID)
				if power == "MANA" then
					return false
				elseif offhand ~= nil or (UnitStagger and (UnwrapValue(UnitStagger(unitID)) or 0) > 0) then
					return true
				else
														-- bypass it in PvP 
					local taken_dmg 					= (isEnemy and self(unitID):IsPlayer() and 0) or CombatTracker:GetDMG(unitID) 
					local done_dmg						= CombatTracker:GetDPS(unitID)
					local done_hps						= CombatTracker:GetHPS(unitID)
					return done_dmg > taken_dmg and done_dmg > done_hps 
				end
			elseif unitID_class == "DRUID" then
				local _, power = UnitPowerType(unitID)
				return power == "ENERGY" or power == "RAGE"
			else 				
				return true -- Warrior, Rogue, DH, DK
			end
		end 
	end, "UnitID"),
	IsMeleeClass							= Cache:Pass(function(self)  
		-- @return boolean
		local unitID 						= self.UnitID
		return InfoClassCanBeMelee[self(unitID):Class()]
	end, "UnitID"),
	IsDead 									= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(function()
			return UnitIsDeadOrGhost(unitID) and not UnitIsFeignDeath(unitID)
		end)
		if not ok then return false end
		if _G.issecretvalue and _G.issecretvalue(val) then return false end
		return val and true or false
	end, "UnitID"),
	IsGhost									= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitIsGhost, unitID)
		if not ok then return false end
		if _G.issecretvalue and _G.issecretvalue(val) then return false end
		return val and true or false
	end, "UnitID"),
	IsPlayer								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitIsPlayer, unitID)
		if not ok then return false end
		if _G.issecretvalue and _G.issecretvalue(val) then return false end
		return val and true or false
	end, "UnitID"),
	IsPet									= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(function()
			return not UnitIsPlayer(unitID) and UnitPlayerControlled(unitID)
		end)
		if not ok then return false end
		if _G.issecretvalue and _G.issecretvalue(val) then return false end
		return val and true or false
	end, "UnitID"),
	IsPlayerOrPet							= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(function() return UnitIsPlayer(unitID) or UnitPlayerControlled(unitID) end)
		if not ok then return false end
		if issecretvalue_local and issecretvalue_local(val) then return false end
		return val and true or false
	end, "UnitID"),
	IsNPC									= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitPlayerControlled, unitID)
		if not ok then return false end
		if issecretvalue_local and issecretvalue_local(val) then return false end
		return not val
	end, "UnitID"),
	IsVisible								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitIsVisible, unitID)
		if not ok then return true end
		if issecretvalue_local and issecretvalue_local(val) then return true end
		return val and true or false
	end, "UnitID"),
	IsExists 								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitExists, unitID)
		if not ok then return false end
		if issecretvalue_local and issecretvalue_local(val) then return false end
		return val and true or false
	end, "UnitID"),
	IsNameplate								= Cache:Pass(function(self)
		-- @return boolean, nameplateUnitID or nil
		-- Note: Only enemy plates
		local unitID 						= self.UnitID
		for nameplateUnit in pairs(ActiveUnitPlates) do
			local ok, val = pcall(UnitIsUnit, unitID, nameplateUnit)
			if ok then
				local bok, bval = pcall(function() return val and true or false end)
				if bok and bval then
					return true, nameplateUnit
				end
			end
		end
	end, "UnitID"),
	IsNameplateAny							= Cache:Pass(function(self)
		-- @return boolean, nameplateUnitID or nil
		-- Note: Any plates
		local unitID 						= self.UnitID
		for nameplateUnit in pairs(ActiveUnitPlatesAny) do
			local ok, val = pcall(UnitIsUnit, unitID, nameplateUnit)
			if ok then
				local bok, bval = pcall(function() return val and true or false end)
				if bok and bval then
					return true, nameplateUnit
				end
			end
		end
	end, "UnitID"),
	IsConnected								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitIsConnected, unitID)
		if not ok then return true end
		local bok, bval = pcall(function() return val and true or false end)
		return bok and bval or true
	end, "UnitID"),
	IsCharmed								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitIsCharmed, unitID)
		if not ok then return false end
		local bok, bval = pcall(function() return val and true or false end)
		return bok and bval or false
	end, "UnitID"),
	IsMounted								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local isSelf = UnitIsUnit(unitID, "player")
		if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = false end
		if isSelf then
			return Player:IsMounted()
		end
		local ok, val = pcall(function() return select(2, self(unitID):GetCurrentSpeed()) >= 200 end)
		return ok and val or false
	end, "UnitID"),
	IsMovingOut								= Cache:Pass(function(self, snap_timer)
		-- @return boolean
		-- snap_timer must be in miliseconds e.g. 0.2 or leave it empty, it's how often unit must be updated between snapshots to understand in which side he's moving
		local unitID 						= self.UnitID
		local isSelf = UnitIsUnit(unitID, "player")
		if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = false end
		if isSelf then
			return true
		end

		local unitSpeed 					= self(unitID):GetCurrentSpeed()
		if unitSpeed > 0 then
			if unitSpeed == self("player"):GetCurrentSpeed() then
				return true
			end

			local GUID 						= UnitGUID(unitID)
			if issecretvalue_local and issecretvalue_local(GUID) then return false end
			local _, min_range				= self(unitID):GetRange()
			if not InfoCacheMoveOut[GUID] then
				InfoCacheMoveOut[GUID] = {
					Snapshot 	= 1,
					TimeStamp 	= TMW.time,
					Range 		= min_range,
					Result 		= false,
				}
				return false
			end

			if TMW.time - InfoCacheMoveOut[GUID].TimeStamp <= (snap_timer or 0.2) then
				return InfoCacheMoveOut[GUID].Result
			end

			InfoCacheMoveOut[GUID].TimeStamp = TMW.time

			if min_range == InfoCacheMoveOut[GUID].Range then
				return InfoCacheMoveOut[GUID].Result
			end

			if min_range > InfoCacheMoveOut[GUID].Range then
				InfoCacheMoveOut[GUID].Snapshot = InfoCacheMoveOut[GUID].Snapshot + 1
			else
				InfoCacheMoveOut[GUID].Snapshot = InfoCacheMoveOut[GUID].Snapshot - 1
			end

			InfoCacheMoveOut[GUID].Range = min_range

			if InfoCacheMoveOut[GUID].Snapshot >= 3 then
				InfoCacheMoveOut[GUID].Snapshot = 2
				InfoCacheMoveOut[GUID].Result = true
				return true
			else
				if InfoCacheMoveOut[GUID].Snapshot < 0 then
					InfoCacheMoveOut[GUID].Snapshot = 0
				end
				InfoCacheMoveOut[GUID].Result = false
				return false
			end
		end
	end, "UnitGUID"),
	IsMovingIn								= Cache:Pass(function(self, snap_timer)
		-- @return boolean
		-- snap_timer must be in miliseconds e.g. 0.2 or leave it empty, it's how often unit must be updated between snapshots to understand in which side he's moving
		local unitID 						= self.UnitID
		local isSelf = UnitIsUnit(unitID, "player")
		if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = false end
		if isSelf then
			return true
		end

		local unitSpeed 					= self(unitID):GetCurrentSpeed()
		if unitSpeed > 0 then
			if unitSpeed == self("player"):GetCurrentSpeed() then
				return true
			end

			local GUID 						= UnitGUID(unitID)
			if issecretvalue_local and issecretvalue_local(GUID) then return false end
			local _, min_range				= self(unitID):GetRange()
			if not InfoCacheMoveIn[GUID] then
				InfoCacheMoveIn[GUID] = {
					Snapshot 	= 1,
					TimeStamp 	= TMW.time,
					Range 		= min_range,
					Result 		= false,
				}
				return false
			end

			if TMW.time - InfoCacheMoveIn[GUID].TimeStamp <= (snap_timer or 0.2) then
				return InfoCacheMoveIn[GUID].Result
			end

			InfoCacheMoveIn[GUID].TimeStamp = TMW.time

			if min_range == InfoCacheMoveIn[GUID].Range then
				return InfoCacheMoveIn[GUID].Result
			end

			if min_range < InfoCacheMoveIn[GUID].Range then
				InfoCacheMoveIn[GUID].Snapshot = InfoCacheMoveIn[GUID].Snapshot + 1
			else
				InfoCacheMoveIn[GUID].Snapshot = InfoCacheMoveIn[GUID].Snapshot - 1
			end

			InfoCacheMoveIn[GUID].Range = min_range

			if InfoCacheMoveIn[GUID].Snapshot >= 3 then
				InfoCacheMoveIn[GUID].Snapshot = 2
				InfoCacheMoveIn[GUID].Result = true
				return true
			else
				if InfoCacheMoveIn[GUID].Snapshot < 0 then
					InfoCacheMoveIn[GUID].Snapshot = 0
				end
				InfoCacheMoveIn[GUID].Result = false
				return false
			end
		end
	end, "UnitGUID"),
	IsMoving								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local isSelf = UnitIsUnit(unitID, "player")
		if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = false end
		if isSelf then
			return Player:IsMoving()
		else
			local ok, val = pcall(function() return self(unitID):GetCurrentSpeed() ~= 0 end)
			return ok and val or false
		end
	end, "UnitID"),
	IsMovingTime							= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local isSelf = UnitIsUnit(unitID, "player")
		if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = false end
		if isSelf then
			return Player:IsMovingTime()
		else
			local GUID						= UnitGUID(unitID)
			if issecretvalue_local and issecretvalue_local(GUID) then return -1 end
			local isMoving  				= self(unitID):IsMoving()
			if isMoving then
				if not InfoCacheMoving[GUID] or InfoCacheMoving[GUID] == 0 then
					InfoCacheMoving[GUID] = TMW.time
				end
			else
				InfoCacheMoving[GUID] = 0
			end
			return (InfoCacheMoving[GUID] == 0 and -1) or TMW.time - InfoCacheMoving[GUID]
		end
	end, "UnitGUID"),
	IsStaying								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local isSelf = UnitIsUnit(unitID, "player")
		if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = false end
		if isSelf then
			return Player:IsStaying()
		else
			local ok, val = pcall(function() return self(unitID):GetCurrentSpeed() == 0 end)
			return ok and val or false
		end
	end, "UnitID"),
	IsStayingTime							= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local isSelf = UnitIsUnit(unitID, "player")
		if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = false end
		if isSelf then
			return Player:IsStayingTime()
		else
			local GUID						= UnitGUID(unitID)
			if issecretvalue_local and issecretvalue_local(GUID) then return -1 end
			local isMoving  				= self(unitID):IsMoving()
			if not isMoving then
				if not InfoCacheStaying[GUID] or InfoCacheStaying[GUID] == 0 then
					InfoCacheStaying[GUID] = TMW.time
				end
			else
				InfoCacheStaying[GUID] = 0
			end
			return (InfoCacheStaying[GUID] == 0 and -1) or TMW.time - InfoCacheStaying[GUID]
		end
	end, "UnitGUID"),
	IsCasting 								= Cache:Wrap(function(self)
		-- @return:
		-- [1] castName (@string or @nil)
		-- [2] castStartedTime (@number or @nil)
		-- [3] castEndTime (@number or @nil)
		-- [4] notInterruptable (@boolean, false is able to be interrupted)
		-- [5] spellID (@number or @nil)
		-- [6] isChannel (@boolean)
		local unitID 						= self.UnitID
		local isChannel
		local castName, _, _, castStartTime, castEndTime, _, _, notInterruptable, spellID = UnitCastingInfo(unitID)
		castName = UnwrapValue(castName)
		if not castName then
			local cName, _, _, cStart, cEnd, _, cNotInt, cSpellID = UnitChannelInfo(unitID)
			cName = UnwrapValue(cName)
			if cName then
				castName = cName
				castStartTime = cStart
				castEndTime = cEnd
				notInterruptable = cNotInt
				spellID = cSpellID
				isChannel = true
			end
		end
		castStartTime = UnwrapValue(castStartTime)
		castEndTime = UnwrapValue(castEndTime)
		spellID = UnwrapValue(spellID)
		if issecretvalue_local and issecretvalue_local(notInterruptable) then notInterruptable = false end
		return castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel
	end, "UnitGUID"),
	IsCastingRemains						= Cache:Pass(function(self, argSpellID)
		-- @return:
		-- [1] Currect Casting Left Time (seconds) (@number)
		-- [2] Current Casting Left Time (percent) (@number)
		-- [3] spellID (@number)
		-- [4] spellName (@string)
		-- [5] notInterruptable (@boolean, false is able to be interrupted)
		-- [6] isChannel (@boolean)
		-- Nill-able: argSpellID
		local unitID 						= self.UnitID
		return select(2, self(unitID):CastTime(argSpellID))
	end, "UnitGUID"),
	CastTime								= Cache:Pass(function(self, argSpellID)
		-- @return:
		-- [1] Total Casting Time (@number)
		-- [2] Currect Casting Left (X -> 0) Time (seconds) (@number)
		-- [3] Current Casting Done (0 -> 100) Time (percent) (@number)
		-- [4] spellID (@number)
		-- [5] spellName (@string)
		-- [6] notInterruptable (@boolean, false is able to be interrupted)
		-- [7] isChannel (@boolean)
		-- Nill-able: argSpellID
		local unitID 						= self.UnitID
		local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = self(unitID):IsCasting()

		local TotalCastTime, CurrentCastTimeSeconds, CurrentCastTimeLeftPercent = 0, 0, 0
		if unitID == "player" and (argSpellID or spellID) then
			local s, _, _, castTime = GetSpellInfo(argSpellID or spellID) -- Must be real-time data
			if type(s) == "table" then
				castTime = s.castTime
			end
			TotalCastTime = (castTime or 0) / 1000
			CurrentCastTimeSeconds = TotalCastTime
		end

		if type(castName) == "string" and (not argSpellID or A_GetSpellInfo(argSpellID) == castName) then
			local cok = pcall(function()
				TotalCastTime = (castEndTime - castStartTime) / 1000
				CurrentCastTimeSeconds = (TMW.time * 1000 - castStartTime) / 1000
				CurrentCastTimeLeftPercent = CurrentCastTimeSeconds * 100 / TotalCastTime
			end)
		end

		local rok, remainResult = pcall(function() return TotalCastTime - CurrentCastTimeSeconds end)
		return TotalCastTime, rok and remainResult or 0, CurrentCastTimeLeftPercent, spellID, castName, notInterruptable, isChannel
	end, "UnitGUID"),
	MultiCast 								= Cache:Pass(function(self, spells, range)
		-- @return
		-- [1] Total CastTime
		-- [2] Current CastingTime Left
		-- [3] Current CastingTime Percent (from 0% as start til 100% as finish)
		-- [4] SpellID
		-- [5] SpellName
		-- [6] notInterruptable (@boolean, false is able to be interrupted)
		-- Note: spells accepts only table or nil to get list from "CastBarsCC"
		local unitID 						= self.UnitID
		local castTotal, castLeft, castLeftPercent, castID, castName, notInterruptable = self(unitID):CastTime()

		if castLeft > 0 and (not range or self(unitID):GetRange() <= range) then
			local query = (type(spells) == "table" and spells) or AuraList.CastBarsCC
			for i = 1, #query do
				if castID == query[i] or castName == A_GetSpellInfo(query[i]) then
					return castTotal, castLeft, castLeftPercent, castID, castName, notInterruptable
				end
			end
		end

		return 0, 0, 0
	end, "UnitGUID"),
	IsControlAble 							= Cache:Pass(function(self, drCat, DR_Tick)
		-- @return boolean
		-- DR_Tick is Tick (number: 100 -> 50 -> 25 -> 0) where 0 is fully imun, 100 is no imun
		-- "taunt" has unique Tick (number: 100 -> 65 -> 42 -> 27 -> 0)
		-- DR_Remain is remain in seconds time before DR_Application will be reset
		-- DR_Application is how much DR stacks were applied currently and DR_ApplicationMax is how much by that category can be applied in total
		--[[ drCat accepts:
			"disorient"						-- TBC Retail
			"incapacitate"					-- Any
			"silence"						-- WOTLK+ Retail
			"stun"							-- Any
			"random_stun"					-- non-Retail
			"taunt"							-- Retail
			"root"							-- Any
			"random_root"					-- non-Retail
			"disarm"						-- Classic+ Retail
			"knockback"						-- Retail
			"counterattack"					-- TBC+ non-Retail
			"chastise"						-- TBC
			"kidney_shot"					-- Classic TBC
			"unstable_affliction"			-- TBC
			"death_coil"					-- TBC
			"fear"							-- Classic+ non-Retail
			"mind_control"					-- Classic+ non-Retail
			"horror"						-- WOTLK+ non-Retail
			"opener_stun"					-- WOTLK
			"scatter"						-- TBC+ non-Retail
			"cyclone"						-- WOTLK+ non-Retail
			"charge"						-- WOTLK
			"deep_freeze_rof"				-- CATA+ non-Retail
			"bind_elemental"				-- CATA+ non-Retail
			"frost_shock"					-- Classic

			non-Player unitID considered as PvE spells and accepts only:
			"stun", "kidney_shot"						-- Classic
			"stun", "random_stun", "kidney_shot"		-- TBC
			"stun", "random_stun", "opener_stun"		-- WOTLK
			"stun", "random_stun", "cyclone"			-- CATA
			"taunt", "stun"								-- Retail

			Same note should be kept in Unit(unitID):IsControlAble, Unit(unitID):GetDR(), CombatTracker.GetDR(unitID)
		]]
		-- Nill-able: DR_Tick, if its nil function returns true whenever non-imun drCat is apply able
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			if not A.IsInPvP then
				return not self(unitID):IsBoss() and InfoControlAbleClassification[self(unitID):Classification()] and (not drCat or self(unitID):GetDR(drCat) > (drDiminishing or 0))
			else
				return not drCat or self(unitID):GetDR(drCat) > (drDiminishing or 0)
			end
		end)
		return ok and result
	end, "UnitID"),
	-- CreatureType: Bool extenstion
	IsUndead								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		return self(unitID):CreatureType() == "Undead"
	end, "UnitID"),
	IsDemon									= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		return self(unitID):CreatureType() == "Demon"
	end, "UnitID"),
	IsHumanoid								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		return self(unitID):CreatureType() == "Humanoid"
	end, "UnitID"),
	IsElemental								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		return self(unitID):CreatureType() == "Elemental"
	end, "UnitID"),
	IsTotem 								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		return self(unitID):CreatureType() == "Totem"
	end, "UnitID"),
	-- CreatureType: End
	IsDummy									= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			local _, _, _, _, _, npc_id 	= self(unitID):InfoGUID()
			return npc_id and InfoIsDummy[npc_id]
		end)
		return ok and result
	end, "UnitID"),
	IsDummyPvP								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			local _, _, _, _, _, npc_id 	= self(unitID):InfoGUID()
			return npc_id and InfoIsDummyPvP[npc_id]
		end)
		return ok and result
	end, "UnitID"),
	IsVoidTendril							= Cache:Pass(function(self)
		-- @return string
		-- Returns english name of the Void Tendril
		-- Note: DF+ Priest's talent Void Tendrils
		if BuildToC >= 100000 then
			local unitID 					= self.UnitID
			local ok, result = pcall(function()
				if self(unitID):IsNPC() and self(unitID):CreatureType() == "Not specified" then
					local npc_id			= select(6, self(unitID):InfoGUID())
					return npc_id and InfoIsVoidTendriln[npc_id]
				end
			end)
			return ok and result
		end
	end, "UnitID"),
	IsCondemnedDemon						= Cache:Pass(function(self)
		-- @return string
		-- Returns english name of the Condemned Demon
		-- Note: Shadowlands+ "Fodder to the Flame" summoned NPC by Demon Hunter's Necrolord Covenant
		if BuildToC >= 90000 and PlayerClass == "DEMONHUNTER" then
			local unitID 					= self.UnitID
			local ok, result = pcall(function()
				if self(unitID):IsNPC() and self(unitID):IsDemon() then
					local npc_id			= select(6, self(unitID):InfoGUID())
					return npc_id and InfoIsCondemnedDemon[npc_id]
				end
			end)
			return ok and result
		end
	end, "UnitID"),
	IsExplosives							= Cache:Pass(function(self)
		-- @return boolean
		-- Note: Legion+ dungeon 7+ key
		if InstanceInfo.KeyStone and InstanceInfo.KeyStone >= 7 then
			local unitID 					= self.UnitID
			local ok, result = pcall(function()
				local Name 					= UnitName(unitID)
				return Name and InfoExplosivesName[GameLocale] == Name
			end)
			return ok and result
		end
	end, "UnitID"),
	IsIncorporealBeing						= Cache:Pass(function(self)
		-- @return boolean
		-- Note: DF 10.1+
		if InstanceInfo.KeyStone and InstanceInfo.KeyStone >= 7 then
			local unitID 					= self.UnitID
			local ok, result = pcall(function()
				local Name 					= UnitName(unitID)
				return Name and InfoIncorporealBeingName[GameLocale] == Name
			end)
			return ok and result
		end
	end, "UnitID"),
	IsOrbOfAscendance						= Cache:Pass(function(self)
		-- @return boolean
		-- Note: TWW 11.0+
		if InstanceInfo.KeyStone and InstanceInfo.KeyStone >= 2 then
			local unitID 					= self.UnitID
			local ok, result = pcall(function()
				local Name 					= UnitName(unitID)
				return Name and InfoOrbOfAscendanceName[GameLocale] == Name
			end)
			return ok and result
		end
	end, "UnitID"),
	IsCracklingShard						= Cache:Pass(function(self)
		-- @return boolean
		-- Note: 1580 is Ny'alotha - Vision of Destiny, patch 8.3
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			if A.ZoneID == 1580 and select(6, self(unitID):InfoGUID()) == 158327 then
				return true
			end
		end)
		return ok and result
	end, "UnitID"),
	IsBoss 									= Cache:Pass(function(self)
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			local _, _, _, _, _, npc_id 	= self(unitID):InfoGUID()
			if npc_id and not InfoIsNotBoss[npc_id] then
				if InfoIsBoss[npc_id] or LibBossIDs[npc_id] or self(unitID):GetLevel() == -1 or UnitIsQuestBoss(unitID) or UnitEffectiveLevel(unitID) == -1 then
					return true
				else
					for i = 1, CONST.MAX_BOSS_FRAMES do
						if UnitIsUnit(unitID, "boss" .. i) then
							return true
						end
					end
				end
			end
		end)
		return ok and result
	end, "UnitID"),
	ThreatSituation							= Cache:Pass(function(self, otherunit)
		-- @return number
		-- Returns: status (0 -> 3), percent of threat, value or threat
		-- Nill-able: otherunit
		local unitID 						= self.UnitID
		local raw = UnitThreatSituation(unitID, otherunit or "target")
		if raw == nil then return 0 end
		if SE and SE.IsSecret and SE:IsSecret(raw) then return 0 end
		return raw
	end, "UnitID"),
	IsTanking 								= Cache:Pass(function(self, otherunit, range)
		-- @return boolean
		-- Nill-able: otherunit, range
		local unitID 						= self.UnitID
		local ThreatThreshold 				= 3
		local ThreatSituation 				= self(unitID):ThreatSituation(otherunit or "target")
		local ok, val = pcall(function()
			return ((A.IsInPvP and UnitIsUnit(unitID, (otherunit or "target") .. "target")) or (not A.IsInPvP and ThreatSituation >= ThreatThreshold)) or self(unitID):IsTankingAoE(range)
		end)
		return ok and val or false
	end, "UnitID"),
	IsTankingAoE 							= Cache:Pass(function(self, range)
		-- @return boolean
		-- Nill-able: range
		local unitID 						= self.UnitID
		local ThreatThreshold 				= 3
		for unit in pairs(ActiveUnitPlates) do
			local ThreatSituation 			= self(unitID):ThreatSituation(unit)
			local ok, val = pcall(function()
				return ((A.IsInPvP and UnitIsUnit(unitID, unit .. "target")) or (not A.IsInPvP and ThreatSituation >= ThreatThreshold)) and (not range or self(unit .. "target"):CanInterract(range))
			end)
			if ok and val then
				return true
			end
		end
	end, "UnitID"),
	IsPenalty								= Cache:Pass(function(self)
		-- @return boolean
		-- Note: Returns true if unit has penalty for healing or damage
		local unitID 						= self.UnitID
		local unitLvL						= self(unitID):GetLevel()
		return unitLvL > 0 and unitLvL < A.PlayerLevel - 10
	end, "UnitID"),
	GetLevel 								= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitLevel, unitID)
		if not ok then return 0 end
		if issecretvalue_local and issecretvalue_local(val) then return 0 end
		return val or 0
	end, "UnitID"),
	GetCurrentSpeed 						= Cache:Wrap(function(self)
		-- @return number (current), number (max)
		local unitID 						= self.UnitID
		local ok, current_speed, max_speed = pcall(function()
			local c, m = GetUnitSpeed(unitID)
			return math_floor(c / 7 * 100), math_floor(m / 7 * 100)
		end)
		if not ok then return 0, 0 end
		return current_speed, max_speed
	end, "UnitGUID"),
	GetMaxSpeed								= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		return select(2, self(unitID):GetCurrentSpeed())
	end, "UnitGUID"),
	GetTotalHealAbsorbs						= Cache:Pass(function(self)
		-- @return number
		-- Note:
		-- Returns the total amount of healing the unit can absorb without gaining health
		-- Abilities like Necrotic Strike cause affected units to absorb healing without gaining health
		local unitID 						= self.UnitID
		if BuildToC < 50500 then
			return 0
		end
		return UnwrapValue(UnitGetTotalHealAbsorbs(unitID)) or 0
	end, "UnitID"),
	GetTotalHealAbsorbsPercent				= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			local maxHP = self(unitID):HealthMax()
			if maxHP == 0 then
				return 0
			else
				return self(unitID):GetTotalHealAbsorbs() * 100 / maxHP
			end
		end)
		return ok and result or 0
	end, "UnitID"),
	-- Combat: Diminishing
	GetDR 									= Cache:Pass(function(self, drCat)
		-- @return: DR_Tick (@number), DR_Remain (@number: 0 -> 18), DR_Application (@number: 0 -> 5), DR_ApplicationMax (@number: 5 <-> 0)
		-- DR_Tick is Tick (number: 100 -> 50 -> 25 -> 0) where 0 is fully imun, 100 is no imun
		-- "taunt" has unique Tick (number: 100 -> 65 -> 42 -> 27 -> 0)
		-- DR_Remain is remain in seconds time before DR_Application will be reset
		-- DR_Application is how much DR stacks were applied currently and DR_ApplicationMax is how much by that category can be applied in total
		--[[ drCat accepts:
			"disorient"						-- TBC Retail
			"incapacitate"					-- Any
			"silence"						-- WOTLK+ Retail
			"stun"							-- Any
			"random_stun"					-- non-Retail
			"taunt"							-- Retail
			"root"							-- Any
			"random_root"					-- non-Retail
			"disarm"						-- Classic+ Retail
			"knockback"						-- Retail
			"counterattack"					-- TBC+ non-Retail
			"chastise"						-- TBC
			"kidney_shot"					-- Classic TBC
			"unstable_affliction"			-- TBC
			"death_coil"					-- TBC
			"fear"							-- Classic+ non-Retail
			"mind_control"					-- Classic+ non-Retail
			"horror"						-- WOTLK+ non-Retail
			"opener_stun"					-- WOTLK
			"scatter"						-- TBC+ non-Retail
			"cyclone"						-- WOTLK+ non-Retail
			"charge"						-- WOTLK
			"deep_freeze_rof"				-- CATA+ non-Retail
			"bind_elemental"				-- CATA+ non-Retail
			"frost_shock"					-- Classic

			non-Player unitID considered as PvE spells and accepts only:
			"stun", "kidney_shot"						-- Classic
			"stun", "random_stun", "kidney_shot"		-- TBC
			"stun", "random_stun", "opener_stun"		-- WOTLK
			"stun", "random_stun", "cyclone"			-- CATA
			"taunt", "stun"								-- Retail

			Same note should be kept in Unit(unitID):IsControlAble, Unit(unitID):GetDR(), CombatTracker.GetDR(unitID)
		]]
		local unitID 						= self.UnitID
		return CombatTracker:GetDR(unitID, drCat)
	end, "UnitID"),
	-- Combat: UnitCooldown
	GetCooldown								= Cache:Pass(function(self, spellID)
		-- @return number, number (remain cooldown time in seconds, start time stamp when spell was used and counter launched)
		local unitID 						= self.UnitID
		return UnitCooldown:GetCooldown(unitID, spellID)
	end, "UnitID"),
	GetMaxDuration							= Cache:Pass(function(self, spellID)
		-- @return number (max cooldown of the spell on a unit)
		local unitID 						= self.UnitID
		return UnitCooldown:GetMaxDuration(unitID, spellID)
	end, "UnitID"),
	GetUnitID								= Cache:Pass(function(self, spellID)
		-- @return unitID (who last casted spell) otherwise nil
		local unitID 						= self.UnitID
		return UnitCooldown:GetUnitID(unitID, spellID)
	end, "UnitID"),
	GetBlinkOrShrimmer						= Cache:Pass(function(self)
		-- @return number, number, number
		-- [1] Current Charges, [2] Current Cooldown, [3] Summary Cooldown
		local unitID 						= self.UnitID
		return UnitCooldown:GetBlinkOrShrimmer(unitID)
	end, "UnitID"),
	IsSpellInFly							= Cache:Pass(function(self, spellID)
		-- @return boolean
		local unitID 						= self.UnitID
		return UnitCooldown:IsSpellInFly(unitID, spellID) -- Retail has spellID
	end, "UnitID"),
	-- Combat: CombatTracker
	CombatTime 								= Cache:Pass(function(self)
		-- @return number, unitGUID
		local unitID 						= self.UnitID
		return CombatTracker:CombatTime(unitID)
	end, "UnitID"),
	GetLastTimeDMGX 						= Cache:Pass(function(self, x)
		-- @return number: taken amount in the last 'x' seconds
		local unitID 						= self.UnitID
		return CombatTracker:GetLastTimeDMGX(unitID, x)
	end, "UnitID"),
	GetRealTimeDMG							= Cache:Pass(function(self, index)
		local unitID 						= self.UnitID
		if index then
			local val = select(index, CombatTracker:GetRealTimeDMG(unitID))
			if (val or 0) > 0 then return val end
			if SE and SE.GetPlayerRealTimeDMG and UnitIsUnit(unitID, "player") then
				local seVal = select(index, SE:GetPlayerRealTimeDMG())
				if seVal and seVal > 0 then return seVal end
			end
			return val or 0
		else
			local total, hits, phys, magic, swing = CombatTracker:GetRealTimeDMG(unitID)
			if (total or 0) > 0 then return total or 0, hits or 0, phys or 0, magic or 0, swing or 0 end
			if SE and SE.GetPlayerRealTimeDMG and UnitIsUnit(unitID, "player") then
				return SE:GetPlayerRealTimeDMG()
			end
			return total or 0, hits or 0, phys or 0, magic or 0, swing or 0
		end
	end, "UnitID"),
	GetRealTimeDPS 							= Cache:Pass(function(self, index)
		-- @return number: done total, hits, phys, magic, swing
		local unitID 						= self.UnitID
		if index then
			return select(index, CombatTracker:GetRealTimeDPS(unitID)) or 0
		else
			local total, hits, phys, magic, swing = CombatTracker:GetRealTimeDPS(unitID)
			return total or 0, hits or 0, phys or 0, magic or 0, swing or 0
		end
	end, "UnitID"),
	GetDMG 									= Cache:Pass(function(self, index)
		local unitID 						= self.UnitID
		if index then
			local val = select(index, CombatTracker:GetDMG(unitID))
			if (val or 0) > 0 then return val end
			if SE and SE.GetPlayerDamagePerSec and UnitIsUnit(unitID, "player") then
				local seVal = select(index, SE:GetPlayerDamagePerSec())
				if seVal and seVal > 0 then return seVal end
			end
			return val or 0
		else
			local total, hits, phys, magic = CombatTracker:GetDMG(unitID)
			if (total or 0) > 0 then return total or 0, hits or 0, phys or 0, magic or 0 end
			if SE and SE.GetPlayerDamagePerSec and UnitIsUnit(unitID, "player") then
				local seDmg, seHits = SE:GetPlayerDamagePerSec()
				if seDmg > 0 then return seDmg, seHits, seDmg, 0 end
			end
			return total or 0, hits or 0, phys or 0, magic or 0
		end
	end, "UnitID"),
	GetDPS 									= Cache:Pass(function(self, index)
		-- @return number: done total, hits, phys, magic
		local unitID 						= self.UnitID
		if index then
			return select(index, CombatTracker:GetDPS(unitID)) or 0
		else
			local total, hits, phys, magic = CombatTracker:GetDPS(unitID)
			return total or 0, hits or 0, phys or 0, magic or 0
		end
	end, "UnitID"),
	GetHEAL 								= Cache:Pass(function(self, index)
		-- @return number: taken total, hits
		local unitID 						= self.UnitID
		if index then
			return select(index, CombatTracker:GetHEAL(unitID)) or 0
		else
			local total, hits = CombatTracker:GetHEAL(unitID)
			return total or 0, hits or 0
		end
	end, "UnitID"),
	GetHPS 									= Cache:Pass(function(self, index)
		-- @return number: done total, hits
		local unitID 						= self.UnitID
		if index then
			return select(index, CombatTracker:GetHPS(unitID)) or 0
		else
			local total, hits = CombatTracker:GetHPS(unitID)
			return total or 0, hits or 0
		end
	end, "UnitID"),
	GetSchoolDMG							= Cache:Pass(function(self, index)
		-- @return number
		-- [1] Holy
		-- [2] Fire
		-- [3] Nature
		-- [4] Frost
		-- [5] Shadow
		-- [6] Arcane
		-- Note: By @player only!
		local unitID 						= self.UnitID
		if index then
			return select(index, CombatTracker:GetSchoolDMG(unitID)) or 0
		else
			local h, f, n, fr, s, a = CombatTracker:GetSchoolDMG(unitID)
			return h or 0, f or 0, n or 0, fr or 0, s or 0, a or 0
		end
	end, "UnitID"),
	GetSpellAmountX 						= Cache:Pass(function(self, spell, x)
		-- @return number: if was taken in the last 'x' seconds by 'spell'
		local unitID 						= self.UnitID
		return CombatTracker:GetSpellAmountX(unitID, spell, x) or 0
	end, "UnitID"),
	GetSpellAmount 							= Cache:Pass(function(self, spell)
		-- @return number: taken last time by 'spell'
		local unitID 						= self.UnitID
		return CombatTracker:GetSpellAmount(unitID, spell)
	end, "UnitID"),
	GetSpellLastCast 						= Cache:Pass(function(self, spell)
		-- @return number, number
		-- time in seconds since last cast, timestamp of start
		local unitID 						= self.UnitID
		return CombatTracker:GetSpellLastCast(unitID, spell)
	end, "UnitID"),
	GetSpellCounter 						= Cache:Pass(function(self, spell)
		-- @return number (counter of total used 'spell' during all fight)
		local unitID 						= self.UnitID
		return CombatTracker:GetSpellCounter(unitID, spell)
	end, "UnitID"),
	GetAbsorb 								= Cache:Pass(function(self, spell)
		-- @return number: taken absorb total (or by specified 'spell')
		local unitID 						= self.UnitID
		return CombatTracker:GetAbsorb(unitID, spell) or 0
	end, "UnitID"),
	TimeToDieX 								= Cache:Pass(function(self, x)
		-- @return number
		local unitID 						= self.UnitID
		return CombatTracker:TimeToDieX(unitID, x)
	end, "UnitID"),
	TimeToDie 								= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		return CombatTracker:TimeToDie(unitID)
	end, "UnitID"),
	TimeToDieMagicX 						= Cache:Pass(function(self, x)
		-- @return number
		local unitID 						= self.UnitID
		return CombatTracker:TimeToDieMagicX(unitID, x)
	end, "UnitID"),
	TimeToDieMagic							= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		return CombatTracker:TimeToDieMagic(unitID)
	end, "UnitID"),
	-- Combat: End
	GetIncomingResurrection					= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		local ok, val = pcall(UnitHasIncomingResurrection, unitID)
		if not ok then return false end
		if issecretvalue_local and issecretvalue_local(val) then return false end
		return val and true or false
	end, "UnitID"),
	GetIncomingHeals						= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		return UnwrapValue(UnitGetIncomingHeals(unitID)) or 0
	end, "UnitID"),
	GetRange 								= Cache:Wrap(function(self)
		-- @return number (max), number (min)
		local unitID 						= self.UnitID
		local ok, min_range, max_range 		= pcall(function() return LibRangeCheck:GetRange(unitID) end)
		if not ok then return 40, 0 end
		if issecretvalue_local then
			if (min_range and issecretvalue_local(min_range)) or (max_range and issecretvalue_local(max_range)) then
				return 40, 0
			end
		end
		if not max_range then
			local inRange, checkedRange = UnitInRange(unitID)
			if issecretvalue_local then
				if issecretvalue_local(inRange) or issecretvalue_local(checkedRange) then
					return 40, 0
				end
			end
			if checkedRange and inRange then
				return 40, 0
			end
			return huge, min_range or huge
		end

		if max_range > CONST.CACHE_DEFAULT_NAMEPLATE_MAX_DISTANCE and self(unitID):IsNameplateAny() then
			if min_range > CONST.CACHE_DEFAULT_NAMEPLATE_MAX_DISTANCE then
				min_range = CONST.CACHE_DEFAULT_NAMEPLATE_MAX_DISTANCE
			end
			return CONST.CACHE_DEFAULT_NAMEPLATE_MAX_DISTANCE, min_range
		end

	    return max_range, min_range
	end, "UnitGUID"),
	CanInterract							= Cache:Pass(function(self, range)
		-- @return boolean
		local unitID 						= self.UnitID
		local max_range, min_range 			= self(unitID):GetRange()

		if self("player"):HasSpec(65) and self("player"):HasBuffs(214202, true) > 0 then
			range = range * 1.5
		end
		if self("player"):HasSpec(InfoSpecsMoonkinRestor) and A_IsTalentLearned(197488) then
			range = range + 5
		end
		if self("player"):HasSpec(InfoSpecsFeralGuardian) and A_IsTalentLearned(197488) then
			range = range + 3
		end

		if max_range and max_range > 0 and range and max_range <= range then
			return true
		end

		if range and min_range and min_range <= range then
			local ok, result = pcall(CheckInteractDistance, unitID, 3)
			if ok and result then
				return true
			end
		end

		return false
	end, "UnitID"),
	CanInterrupt							= Cache:Pass(function(self, kickAble, auras, minX, maxX)
		-- @return boolean
		-- Nill-able: kickAble, auras, minX, maxX
		local unitID 						= self.UnitID
		local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = self(unitID):IsCasting()
		if castName and (not kickAble or not notInterruptable) then
			if auras and self(unitID):HasBuffs(auras) > 0 then
				return false
			end

			local GUID 						= UnitGUID(unitID)
			if not InfoCacheInterrupt[GUID] then
				InfoCacheInterrupt[GUID] = {}
			end

			if InfoCacheInterrupt[GUID].LastCast ~= castName then
				-- Soothing Mist
				if castName ~= A_GetSpellInfo(209525) then
					InfoCacheInterrupt[GUID].LastCast 	= castName
					InfoCacheInterrupt[GUID].Timer 		= math_random(minX or 34, maxX or 68)
				else
					InfoCacheInterrupt[GUID].LastCast 	= castName
					InfoCacheInterrupt[GUID].Timer 		= math_random(minX or 7, maxX or 13)
				end
			end

			local cpOk, castPercent = pcall(function()
				return ((TMW.time * 1000) - castStartTime) * 100 / (castEndTime - castStartTime)
			end)
			if not cpOk then return false end
			return castPercent >= InfoCacheInterrupt[GUID].Timer
		end
	end, "UnitID"),
	CanCooperate							= Cache:Pass(function(self, otherunit)
		-- @return boolean
		local unitID 						= self.UnitID
		return UnitCanCooperate(unitID, otherunit)
	end, "UnitID"),
	HasSpec									= Cache:Pass(function(self, specID)	
		-- @return boolean 
		local unitID 						= self.UnitID
		
		if UnitIsUnit(unitID, "player") then
			local playerSpecID = A.PlayerSpec
			if type(specID) == "table" then
				for i = 1, #specID do if specID[i] == playerSpecID then return true end end
			else
				return specID == playerSpecID
			end
		else
			local name, server = UnitName(unitID)
			if not name or (issecretvalue_local and issecretvalue_local(name)) then
				return
			elseif server and not (issecretvalue_local and issecretvalue_local(server)) then
				name = strjoin("-", name, server)
			end
			
			if UnitSpecsMap[name] then
				if type(specID) == "table" then
					for i = 1, #specID do if specID[i] == UnitSpecsMap[name] then return true end end
				else
					return specID == UnitSpecsMap[name]
				end
			else
				local unitClass = self(unitID):Class()
				
				-- Search by auras 
				local unitClassBuffs = InfoClassSpecBuffs[unitClass]
				if unitClassBuffs then 
					local unitSpecBuffs
					if type(specID) == "table" then
						for i = 1, #specID do
							unitSpecBuffs = unitClassBuffs[specID[i]]
							if unitSpecBuffs and self(unitID):HasBuffs(unitSpecBuffs) > 0 then 
								return true 
							end 
						end  
					else
						unitSpecBuffs = unitClassBuffs[specID]
						if unitSpecBuffs and self(unitID):HasBuffs(unitSpecBuffs) > 0 then 
							return true 
						end 
					end 
				end 
				
				-- Search by used spells 
				-- Note: Used in PvP for any players. Doesn't work in PvE mode.
				local unitClassSpells = InfoClassSpecSpells[unitClass]
				if unitClassSpells then 
					local unitSpecSpells
					if type(specID) == "table" then
						for i = 1, #specID do
							unitSpecSpells = unitClassSpells[specID[i]]
							
							if unitSpecSpells then 
								if type(unitSpecSpells) == "table" then 
									for _, spellID in ipairs(unitSpecSpells) do 
										if self(unitID):GetSpellCounter(spellID) > 0 then 
											return true 
										end 
									end 
								else 
									if self(unitID):GetSpellCounter(unitSpecSpells) > 0 then 
										return true 
									end 
								end 
							end 
						end  
					else
						unitSpecSpells = unitClassSpells[specID]
						if unitSpecSpells then 
							if type(unitSpecSpells) == "table" then 
								for _, spellID in ipairs(unitSpecSpells) do 
									if self(unitID):GetSpellCounter(spellID) > 0 then 
										return true 
									end 
								end 
							else 
								if self(unitID):GetSpellCounter(unitSpecSpells) > 0 then 
									return true 
								end 
							end 
						end 
					end 
				end 				
			end
		end
	end, "UnitID"),
	HasFlags 								= Cache:Pass(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
	    return self(unitID):HasBuffs(InfoFlagsBuffs) > 0 or self(unitID):HasDeBuffs(121177) > 0
	end, "UnitID"),
	Health									= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local healthFn = _G.UnitHealth or UnitHealth
		local raw = type(healthFn) == "function" and healthFn(unitID) or 0
		local normalized = UntaintNumber(raw)
		if type(normalized) == "number" then return normalized end
		local isSecret = issecretvalue_local and issecretvalue_local(raw)
		if isSecret and SE and SE.GetHealth then
			local ok, derived = SE:GetHealth(unitID)
			if ok then return UntaintNumber(derived, 0) end
		end
		if isSecret then return 0 end
		local val = UnwrapValue(raw)
		if type(val) == "number" then return val end
		return UntaintNumber(raw, 0)
	end, "UnitID"),
	HealthMax								= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local healthMaxFn = _G.UnitHealthMax or UnitHealthMax
		local raw = type(healthMaxFn) == "function" and healthMaxFn(unitID) or 0
		local normalized = UntaintNumber(raw)
		if type(normalized) == "number" then return normalized end
	    return UnwrapValue(raw) or UntaintNumber(raw, 0)
	end, "UnitID"),
	HealthDeficit							= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			return self(unitID):HealthMax() - self(unitID):Health()
		end)
		if ok then return result end
		if SE and SE.GetHealthDeficit then
                        local dok, deficit = SE:GetHealthDeficit(unitID)
                        if dok then return deficit end
                end
		return 0
	end, "UnitID"),
	HealthDeficitPercent					= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local maxHP = self(unitID):HealthMax()
		if maxHP > 0 then
			local ok, result = pcall(function()
				return self(unitID):HealthDeficit() * 100 / maxHP
			end)
			if ok then return result end
		end
		if SE and SE.GetHealthPercent then
                        local pok, pct = SE:GetHealthPercent(unitID)
                        if pok then
				pct = UntaintNumber(pct)
				if type(pct) == "number" then
					if pct > 0 or not IsLivingExistingUnit(unitID) then
						return 100 - pct
					end
				end
			end
                end
		if IsLivingExistingUnit(unitID) and maxHP > 0 then
			return 0
		end
		return 0
	end, "UnitID"),
	HealthPercent							= Cache:Pass(function(self)
		-- @return number (0-100)
		local unitID 						= self.UnitID
		local maxHP 						= UntaintNumber(self(unitID):HealthMax(), 0)
		local likelyAlive 					= IsLivingExistingUnit(unitID)
		if SE and SE.GetHealthPercent then
                        local cok, pct = SE:GetHealthPercent(unitID)
                        if cok then
				pct = UntaintNumber(pct)
                                if type(pct) == "number" then
					if pct > 0 or not likelyAlive then
						return pct
					end
				end
                        end
                end
		if maxHP > 0 then
			local ok, result = pcall(function()
				local health = UntaintNumber(self(unitID):Health(), 0)
				return health * 100 / maxHP
			end)
			if ok and type(result) == "number" then
				if result > 0 or not likelyAlive then
					return result
				end
			end
		end
		if likelyAlive and maxHP > 0 then
			return 100
		end
		return 0
	end, "UnitID"),
	HealthPercentLosePerSecond				= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			local maxHP = self(unitID):HealthMax()
			if maxHP == 0 then
				return 0
			else
				return math_max((self(unitID):GetDMG() * 100 / maxHP) - (self(unitID):GetHEAL() * 100 / maxHP), 0)
			end
		end)
		return ok and result or 0
	end, "UnitID"),
	HealthPercentGainPerSecond				= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			local maxHP = self(unitID):HealthMax()
			if maxHP == 0 then
				return 0
			else
				return math_max((self(unitID):GetHEAL() * 100 / maxHP) - (self(unitID):GetDMG() * 100 / maxHP), 0)
			end
		end)
		return ok and result or 0
	end, "UnitID"),
	Power									= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local powerFn = _G.UnitPower or UnitPower
		local raw = type(powerFn) == "function" and powerFn(unitID) or 0
		local normalized = UntaintNumber(raw)
		if type(normalized) == "number" then return normalized end
		local val = UnwrapValue(raw)
		if val == nil or (SE and SE:IsSecret(val)) then
			if SE and SE.GetPower then
                                local ok, derived = SE:GetPower(unitID)
                                if ok then return UntaintNumber(derived, 0) end
                        end
			return 0
		end
	    return val
	end, "UnitID"),
	PowerType								= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local ok, val = pcall(function() return select(2, UnitPowerType(unitID)) end)
		if not ok then return "MANA" end
		if issecretvalue_local and issecretvalue_local(val) then return "MANA" end
	    return val
	end, "UnitID"),
	PowerMax								= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local powerMaxFn = _G.UnitPowerMax or UnitPowerMax
		local raw = type(powerMaxFn) == "function" and powerMaxFn(unitID) or 0
		local normalized = UntaintNumber(raw)
		if type(normalized) == "number" then return normalized end
	    return UnwrapValue(raw) or UntaintNumber(raw, 0)
	end, "UnitID"),
	PowerDeficit							= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			return self(unitID):PowerMax() - self(unitID):Power()
		end)
		if ok then return result end
		if SE and SE.GetPowerDeficit then
                        local dok, deficit = SE:GetPowerDeficit(unitID)
                        if dok then return deficit end
                end
		return 0
	end, "UnitID"),
	PowerDeficitPercent						= Cache:Pass(function(self)
		-- @return number
		local unitID 						= self.UnitID
		local ok, result = pcall(function()
			local maxPower = self(unitID):PowerMax()
			if maxPower == 0 then return 0 end
			return self(unitID):PowerDeficit() * 100 / maxPower
		end)
		if ok then return result end
		if SE and SE.GetPowerPercent then
                        local pok, pct = SE:GetPowerPercent(unitID)
                        if pok then return 100 - pct end
                end
		return 0
	end, "UnitID"),
	PowerPercent							= Cache:Pass(function(self)
		-- @return number (0-100)
		local unitID 						= self.UnitID
		if SE and SE.GetPowerPercent then
                        local cok, pct = SE:GetPowerPercent(unitID)
                        if cok then
                                local aok = pcall(function() return pct + 0 end)
                                if aok then return pct end
                        end
                end
		local ok, result = pcall(function()
			local maxPower = self(unitID):PowerMax()
			if maxPower == 0 then return 0 end
			return self(unitID):Power() * 100 / maxPower
		end)
		if ok then return result end
		return 0
	end, "UnitID"),
	AuraTooltipNumberByIndex				= Cache:Wrap(function(self, spell, filter, caster, byID, kindKey, requestedIndex)
		-- @return number
		-- Arguments
		-- kindKey @string "applications"|"isStealable"|"sourceUnit"|"isNameplateOnly"|"isHelpful"|"name"|"canApplyAura"|"isHarmful"|"isRaid"|"timeMod"|"auraInstanceID"|"nameplateShowAll"|"nameplateShowPersonal"|"icon"|"points"(returns table)|"isFromPlayerOrPlayerPet"|"expirationTime"|"duration"|"isBossAura"|"spellId"
		-- 		This argument used to identify instance of aura on tooltip (can be 2+ identical auras applied but with different attributes, example: procs from same weapon enchants on both hands) 
		--
		-- requestedIndex @number 
		--		This argument selects number by using index on tooltip (can return 0 on index which is not supposed to be zero, just skipping such index by adding +1 will help)
		-- Nill-able: filter, byID, kindKey, requestedIndex
		local unitID 						= self.UnitID
		local filter 						= filter or "HELPFUL"
		local auraData, foundData, name
		for i = 1, huge do
			auraData = UnwrapAuraData(UnitAura(unitID, i, filter))
			if not auraData then
				break
			elseif IsAuraEqual(auraData.name, auraData.spellId, AssociativeTables[spell], byID) then
				foundData = auraData
				name = strlowerCache[auraData.name]
				break
			end
		end
				
		if foundData then 
			-- Since LARGE_NUMBER_SEPERATOR is no longer correct and TMW has no fix for this we will use AuraTooltipNumberPacked function by index for now instead of AuraTooltipNumber
			local kindKey = kindKey or (filter ~= "HELPFUL" and "isHarmful") or "isHelpful"
			local requestedIndex = requestedIndex or 1
			return AuraTooltipNumberPacked(unitID, name, kindKey, caster, requestedIndex)
		end 
		
		return 0
	end, "UnitGUID"),
	AuraVariableNumber						= Cache:Wrap(function(self, spell, filter, caster, byID)
		-- @return number
		-- Nill-able: filter, caster, byID
		local unitID 						= self.UnitID
		local filter 						= filter or "HELPFUL"
		local auraData, foundData
		for i = 1, huge do
			auraData = UnwrapAuraData(UnitAura(unitID, i, filter))
			if not auraData then
				break
			elseif IsAuraEqual(auraData.name, auraData.spellId, AssociativeTables[spell], byID) then
				if not caster then
					foundData = auraData
					break
				else
					local sok, smatch = pcall(UnitIsUnit, "player", auraData.sourceUnit)
					if sok and smatch then
						foundData = auraData
						break
					end
				end
			end
		end

		if foundData then
			local ok, pts = pcall(function()
				for i = 1, #foundData.points do
					local v = foundData.points[i]
					if v and v > 0 then return v end
				end
				return 0
			end)
			return ok and pts or 0
		end

		return 0
	end, "UnitGUID"),
	DeBuffCyclone 							= Cache:Pass(function(self, customGUID)
		-- @return number
		-- Note: Supports Banish
		local unitID 						= self.UnitID
		local unitGUID 						= customGUID or UnitGUID(unitID)

		local guidOk, guidMatch = pcall(function() return InfoCycloneGUIDs[unitGUID] end)
		if guidOk and guidMatch then
			local _, auraData
			for i = 1, huge do
				auraData = UnwrapAuraData(UnitAura(unitID, i, "HARMFUL"))
				if not auraData then
					break
				else
					local cok, cmatch = pcall(function() return InfoCycloneSpellName[auraData.name] end)
					if cok and cmatch then
						local eok, etime = pcall(function() return auraData.expirationTime == 0 and huge or auraData.expirationTime - TMW.time end)
						if eok then return etime end
					end
				end
			end
		end
		-- SE cache fallback for Cyclone (33786) and Banish (710)
		if SE and SE.GetCachedAura then
			local cycloneIDs = {33786, 710}
			for ci = 1, #cycloneIDs do
				local remain = SE:GetCachedAura(unitID, cycloneIDs[ci], "HARMFUL")
				if remain then return remain end
			end
		end

		return 0
	end, "UnitID"),
	--[[HasDeBuffs 								= Cache:Pass(function(self, spell, caster, byID)
		-- @return number, number
		-- current remain, total applied duration
		-- Sorting method
		-- Nill-able: caster, byID
		local unitID 						= self.UnitID
        return self(unitID):SortDeBuffs(spell, caster, byID or IsMustBeByID[spell])
    end, "UnitID"),]]
	SortDeBuffs								= Cache:Wrap(function(self, spell, caster, byID)
		-- @return number, number
		-- Returns sorted by highest and limited by 1-3 firstly found: current remain, total applied duration
		-- Nill-able: caster, byID
		local unitID 						= self.UnitID
		local filter
		if caster then
			filter = "HARMFUL PLAYER"
		else
			filter = "HARMFUL"
		end
		local remain_dur, total_dur 		= 0, 0

		local c = 0
		local _, auraData
		for i = 1, huge do
			auraData = UnwrapAuraData(UnitAura(unitID, i, filter))

			if not auraData then break
			elseif IsAuraEqual(auraData.name, auraData.spellId, AssociativeTables[spell], byID) then
				local expTime = UnwrapField(auraData.expirationTime)
				local dur = UnwrapField(auraData.duration)
				if expTime == nil then expTime = 0 end
				if dur == nil then dur = 0 end
				local current_dur = expTime == 0 and huge or expTime - TMW.time
				if current_dur > remain_dur then
					c = c + 1
					remain_dur = current_dur
					total_dur = dur

					if remain_dur == huge or c >= (type(spell) == "table" and 3 or 1) then
						break
					end
				end
			end
		end

		if remain_dur == 0 then
			local dRemain, dDur = TryDirectAuraLookupMulti(unitID, spell, "HARMFUL")
			if dRemain then return dRemain, dDur end
			local seRemain, seDur = TrySECacheAura(unitID, spell, "HARMFUL")
			if seRemain then return seRemain, seDur end
		end
		return remain_dur, total_dur
    end, "UnitGUID"),
	HasDeBuffsStacks						= Cache:Wrap(function(self, spell, caster, byID)
		-- @return number
		-- Nill-able: caster, byID
		local unitID 						= self.UnitID
		local filter
		if caster then
			filter = "HARMFUL PLAYER"
		else
			filter = "HARMFUL"
		end

		local _, auraData
		for i = 1, huge do
			auraData = UnwrapAuraData(UnitAura(unitID, i, filter))
			if not auraData then
				break
			elseif IsAuraEqual(auraData.name, auraData.spellId, AssociativeTables[spell], byID) then
				local apps = UnwrapField(auraData.applications)
				if apps == nil then apps = 0 end
				return apps == 0 and 1 or apps
			end
		end
		local _, _, dStacks = TryDirectAuraLookupMulti(unitID, spell, "HARMFUL")
		if dStacks then return dStacks end
		local seStacks = TrySECacheStacks(unitID, spell, "HARMFUL")
		if seStacks then return seStacks end
		return 0
	end, "UnitGUID"),
	-- Pandemic Threshold
	PT										= Cache:Wrap(function(self, spell, debuff, byID)
		-- @return boolean
		-- Note: If duration remains <= 30% only for auras applied by @player
		-- Nill-able: debuff, byID
		local unitID 						= self.UnitID
		local filter
		if debuff then
			filter = "HARMFUL PLAYER"
		else
			filter = "HELPFUL"
		end

		local duration = 0
		local _, auraData
		for i = 1, huge do
			auraData = UnwrapAuraData(UnitAura(unitID, i, filter))
			if not auraData then
				break
			elseif IsAuraEqual(auraData.name, auraData.spellId, AssociativeTables[spell], byID) then
				local expTime = UnwrapField(auraData.expirationTime)
				local dur = UnwrapField(auraData.duration)
				if expTime == nil then expTime = 0 end
				if dur == nil or dur == 0 then dur = 1 end
				duration = expTime == 0 and 1 or ((expTime - TMW.time) / dur)
				if duration <= 0.3 then
					return true
				end
			end
		end

		if duration == 0 then
			local baseFilter = debuff and "HARMFUL" or "HELPFUL"
			local seRemain, seDur = TrySECacheAura(unitID, spell, baseFilter)
			if seRemain and seDur and seDur > 0 then
				return (seRemain / seDur) <= 0.3
			end
		end
		return duration <= 0.3
	end, "UnitGUID"),
	HasBuffs 								= Cache:Wrap(function(self, spell, caster, byID)
		-- @return number, number
		-- current remain, total applied duration
		-- Nill-able: caster, byID
		local unitID 						= self.UnitID
		local filter 						= "HELPFUL"
		if caster then
			filter = "HELPFUL"
		end
		local _, auraData
		for i = 1, huge do
			auraData = UnwrapAuraData(UnitAura(unitID, i, filter))
			if not auraData then break end
			if IsAuraEqual(auraData.name, auraData.spellId, AssociativeTables[spell], byID) then
				local expTime = UnwrapField(auraData.expirationTime)
				local dur = UnwrapField(auraData.duration)
				if expTime == nil then expTime = 0 end
				if dur == nil then dur = 0 end
				return expTime == 0 and huge or expTime - TMW.time, dur
			end
		end
		local dRemain, dDur = TryDirectAuraLookupMulti(unitID, spell, filter)
		if dRemain then return dRemain, dDur end
		local seRemain, seDur = TrySECacheAura(unitID, spell, filter)
		if seRemain then return seRemain, seDur end
		return 0, 0
	end, "UnitGUID"),
	SortBuffs 								= Cache:Wrap(function(self, spell, caster, byID)
		-- @return number, number
		-- Returns sorted by highest: current remain, total applied duration
		-- Nill-able: caster, byID
		local unitID 						= self.UnitID
		local filter 						= "HELPFUL"
		if caster then
			filter = "HELPFUL"
		end
		local remain_dur, total_dur 		= 0, 0

		local _, auraData
		for i = 1, huge do
			auraData = UnwrapAuraData(UnitAura(unitID, i, filter))
			if not auraData then
				break
			elseif IsAuraEqual(auraData.name, auraData.spellId, AssociativeTables[spell], byID) then
				local expTime = UnwrapField(auraData.expirationTime)
				local dur = UnwrapField(auraData.duration)
				if expTime == nil then expTime = 0 end
				if dur == nil then dur = 0 end
				local current_dur = expTime == 0 and huge or expTime - TMW.time
				if current_dur > remain_dur then
					remain_dur, total_dur = current_dur, dur
					if remain_dur == huge then
						break
					end
				end
			end
		end
		if remain_dur == 0 then
			local dRemain, dDur = TryDirectAuraLookupMulti(unitID, spell, filter)
			if dRemain then return dRemain, dDur end
			local seRemain, seDur = TrySECacheAura(unitID, spell, filter)
			if seRemain then return seRemain, seDur end
		end
		return remain_dur, total_dur
	end, "UnitGUID"),
	HasBuffsStacks 							= Cache:Wrap(function(self, spell, caster, byID)
		-- @return number
		-- Nill-able: caster, byID
		local unitID 						= self.UnitID
		local filter 						= "HELPFUL"
		if caster then
			filter = "HELPFUL"
		end

		local _, auraData
		for i = 1, huge do
			auraData = UnwrapAuraData(UnitAura(unitID, i, filter))
			if not auraData then
				break
			elseif IsAuraEqual(auraData.name, auraData.spellId, AssociativeTables[spell], byID) then
				local apps = UnwrapField(auraData.applications)
				if apps == nil then apps = 0 end
				return apps == 0 and 1 or apps
			end
		end
		local _, _, dStacks = TryDirectAuraLookupMulti(unitID, spell, filter)
		if dStacks then return dStacks end
		local seStacks = TrySECacheStacks(unitID, spell, filter)
		if seStacks then return seStacks end
		return 0
	end, "UnitGUID"),
	WithOutKarmed 							= Cache:Wrap(function(self)
		-- @return boolean
		local unitID 						= self.UnitID

		if self(unitID):IsEnemy() then
			if TeamCacheFriendly.Size > 0 and self(unitID):HasBuffs(122470) > 0 then
				for i = 1, TeamCacheFriendly.MaxSize do
					local member = TeamCacheFriendlyIndexToPLAYERs[i]
					-- Forbearance players
					if member and self(member):HasDeBuffs(25771) >= 20 then
						return true
					end

					member = TeamCacheFriendlyIndexToPETs[i]
					-- Forbearance pets
					if member and self(member):HasDeBuffs(25771) >= 20 then
						return true
					end
				end

				return false
			end
		else
			local arena
			if TeamCacheEnemy.Size > 0 and self(unitID):HasBuffs(122470) > 0 then
				for i = 1, TeamCacheEnemy.MaxSize do
					arena = TeamCacheEnemyIndexToPLAYERs[i]
					-- Forbearance players
					if arena and self(arena):HasDeBuffs(25771) >= 20 then
						return true
					end

					arena = TeamCacheEnemyIndexToPETs[i]
					-- Forbearance pets
					if arena and self(arena):HasDeBuffs(25771) >= 20 then
						return true
					end
				end

				return false
			end
		end

		return true
	end, "UnitGUID"),
	IsFocused 								= Cache:Wrap(function(self, specs, burst, deffensive, range)
		-- @return boolean
		-- Nill-able: specs, burst, deffensive, range
		local unitID 						= self.UnitID

		if self(unitID):IsEnemy() then
			if next(TeamCacheFriendlyDAMAGER) then
				local member
				for member in pairs(TeamCacheFriendlyDAMAGER) do
					local isTarget = UnitIsUnit(member .. "target", unitID)
					if issecretvalue_local and issecretvalue_local(isTarget) then isTarget = false end
					local isSelf = UnitIsUnit(member, "player")
					if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = true end
					if isTarget
					and not isSelf
					and (not specs or 		(specs == "MELEE" and self(member):IsMelee()))
					and (not burst or 		self(member):HasBuffs("DamageBuffs") > 2)
					and (not deffensive or 	self(unitID):HasBuffs("DeffBuffs") < 2)
					and (not range or 		self(member):GetRange() <= range) then
						return true
					end
				end
			end
		else
			local arena
			local specsmap = (specs and InfoSpecIs[specs]) or specs or false
			if next(TeamCacheEnemyDAMAGER) then
				for arena in pairs(TeamCacheEnemyDAMAGER) do
					local isTarget = UnitIsUnit(arena .. "target", unitID)
					if issecretvalue_local and issecretvalue_local(isTarget) then isTarget = false end
					if isTarget
					and (not specsmap or 	self(arena):HasSpec(specsmap))
					and (not burst or 		self(arena):HasBuffs("DamageBuffs") > 2)
					and (not deffensive or 	self(unitID):HasBuffs("DeffBuffs") < 2)
					and (not range or 		self(arena):GetRange() <= range) then
						return true
					end
				end
			else
				for arena in pairs(ActiveUnitPlates) do
					local isTarget = UnitIsUnit(arena .. "target", unitID)
					if issecretvalue_local and issecretvalue_local(isTarget) then isTarget = false end
					if isTarget
					and (not specsmap or 	self(arena):HasSpec(specsmap))
					and (not burst or 		self(arena):HasBuffs("DamageBuffs") > 2)
					and (not deffensive or 	self(unitID):HasBuffs("DeffBuffs") < 2)
					and (not range or 		self(arena):GetRange() <= range) then
						return true
					end
				end
			end
		end
	end, "UnitGUID"),
	IsExecuted 								= Cache:Wrap(function(self)
		-- @return boolean
		local unitID 						= self.UnitID

		if self(unitID):IsEnemy() then
			return self(unitID):TimeToDieX(20) <= A_GetGCD() + A_GetCurrentGCD()
		else
			if next(TeamCacheEnemyDAMAGER_MELEE) and self(unitID):TimeToDieX(20) <= A_GetGCD() + A_GetCurrentGCD() then
				for arena in pairs(TeamCacheEnemyDAMAGER_MELEE) do
					local isTarget = UnitIsUnit(arena .. "target", unitID)
					if issecretvalue_local and issecretvalue_local(isTarget) then isTarget = false end
					local isSelf = UnitIsUnit(unitID, "player")
					if issecretvalue_local and issecretvalue_local(isSelf) then isSelf = false end
					if self(arena):HasSpec(InfoSpecsWithExecute) and isTarget and self(arena):Power() >= 20 and (not isSelf or self(arena):GetRange() < 7) then
						return true
					end
				end
			end
		end
	end, "UnitGUID"),
	UseBurst 								= Cache:Wrap(function(self, pBurst)
		-- @return boolean
		-- Nill-able: pBurst
		local unitID 						= self.UnitID

		if self(unitID):IsEnemy() then
			return self(unitID):IsPlayer() and
			(
				A.Zone == str_none or
				self(unitID):TimeToDieX(25) <= A_GetGCD() * 4 or
				(
					self(unitID):IsHealer() and
					(
						(
							self(unitID):CombatTime() > 5 and
							self(unitID):TimeToDie() <= 10 and
							self(unitID):HasBuffs("DeffBuffs") == 0
						) or
						self(unitID):HasDeBuffs("Silenced") >= A_GetGCD() * 2 or
						self(unitID):HasDeBuffs("Stuned") >= A_GetGCD() * 2
					)
				) or
				self(unitID):IsFocused(nil, true) or
				A_EnemyTeam("HEALER"):GetCC() >= A_GetGCD() * 3 or
				(
					pBurst and
					self("player"):HasBuffs("DamageBuffs") >= A_GetGCD() * 3
				)
			)
		elseif A.IamHealer then
			-- For HealingEngine as Healer
			return self(unitID):IsPlayer() and
			(
				self(unitID):IsExecuted() or
				(
					A.IsInPvP and
					(
						(
							self(unitID):HasFlags() and
							self(unitID):CombatTime() > 0 and
							self(unitID):GetRealTimeDMG() > 0 and
							self(unitID):TimeToDie() <= 14 and
							(
								self(unitID):TimeToDie() <= 8 or
								self(unitID):HasBuffs("DeffBuffs") < 1
							)
						) or
						(
							self(unitID):IsFocused(nil, true) and
							(
								self(unitID):TimeToDie() <= 10 or
								self(unitID):HealthPercent() <= 70
							)
						)
					)
				)
			)
		end
	end, "UnitGUID"),
	UseDeff 								= Cache:Wrap(function(self)
		-- @return boolean
		local unitID 						= self.UnitID
		return
		(
			self(unitID):IsExecuted() or
			self(unitID):IsFocused(nil, true) or
			(
				self(unitID):TimeToDie() < 8 and
				self(unitID):IsFocused()
			) or
			self(unitID):HasDeBuffs("DamageDeBuffs") > 5
		)
	end, "UnitGUID"),
})
A.Unit.HasDeBuffs = A.Unit.SortDeBuffs

function A.Unit:New(UnitID, Refresh)
	if not UnitID then
		local error_snippet = debugstack():match("%p%l+%s\"?%u%u%u%s%u%l.*")
		if error_snippet then
			error("Unit.lua Action.Unit():.. was used with 'nil' unitID. Found problem in TMW snippet here:" .. error_snippet, 0)
		else
			error("Unit.lua Action.Unit():.. was used with 'nil' unitID.\n" .. debugstack())
		end
	end
	self.UnitID 	= UnitID
	self.Refresh 	= Refresh
end

------------------------------------------------------------------------------- -- STOPPED HERE, For UNIT need to check self() how it will works
-- API: FriendlyTeam
-------------------------------------------------------------------------------
A.FriendlyTeam = PseudoClass({
	-- Note: Return field 'unitID' will return "none" if is not found
	-- Note: If 'ROLE' specified then it will except "player", otherwise will include
	GetUnitID 								= Cache:Pass(function(self, range)
		-- @return string
		-- Nill-able: range
		local ROLE 							= self.ROLE

		if ROLE then
			if TeamCacheFriendly[ROLE] then
				for member in pairs(TeamCacheFriendly[ROLE]) do
					if not A_Unit(member):IsDead() and A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) then
						return member
					end
				end
			end
		else
			if TeamCacheFriendly.Type then
				local member
				for i = 1, TeamCacheFriendly.MaxSize do
					member = TeamCacheFriendlyIndexToPLAYERs[i]
					if member and not A_Unit(member):IsDead() and A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) then
						return member
					end
				end
			end
		end

		return str_none
	end, "ROLE"),
	GetCC 									= Cache:Wrap(function(self, spells)
		-- @return number, unitID
		-- Nill-able: spells
		local ROLE 							= self.ROLE
		local duration, member

		if TeamCacheFriendly.Size <= 1 then
			member = "player"
			if A_Unit(member):Role(ROLE) then
				if spells then
					duration = A_Unit(member):HasDeBuffs(spells)
					if duration ~= 0 then
						return duration, member
					end
				else
					duration = A_Unit(member):InCC()
					if duration ~= 0 then
						return duration, member
					end
				end
			end

			return 0, str_none
		end

		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if spells then
					duration = A_Unit(member):HasDeBuffs(spells)
				else
					duration = A_Unit(member):InCC()
				end

				if duration ~= 0 then
					return duration, member
				end
			end
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member then
					if spells then
						duration = A_Unit(member):HasDeBuffs(spells)
					else
						duration = A_Unit(member):InCC()
					end

					if duration ~= 0 then
						return duration, member
					end
				end
			end

			if not TeamCacheFriendly.Type then
				duration = A_Unit("player"):HasDeBuffs(spells)
				if duration ~= 0 then
					return duration, "player"
				end
			end
		end

		return 0, str_none
	end, "ROLE"),
	GetBuffs 								= Cache:Wrap(function(self, spells, range, source)
		-- @return number, unitID
		-- Nill-able: range, source
		local ROLE 							= self.ROLE
		local duration, member

		if TeamCacheFriendly.Size <= 1 then
			if A_Unit("player"):Role(ROLE) then
				duration = A_Unit("player"):HasBuffs(spells, source)
				if duration ~= 0 then
					return duration, "player"
				end
			end
			return 0, str_none
		end

		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) then
					duration = A_Unit(member):HasBuffs(spells, source)
					if duration ~= 0 then
						return duration, member
					end
				end
			end
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member and A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) then
					duration = A_Unit(member):HasBuffs(spells, source)
					if duration ~= 0 then
						return duration, member
					end
				end
			end

			if not TeamCacheFriendly.Type then
				duration = A_Unit("player"):HasBuffs(spells, source)
				if duration ~= 0 then
					return duration, "player"
				end
			end
		end

		return 0, str_none
	end, "ROLE"),
	GetBuffsCount							= Cache:Wrap(function(self, spells, duration, source, byID)
		-- @return number
		-- Nill-able: duration, source, byID
		local ROLE = self.ROLE
		local total = 0
		local member

		if TeamCacheFriendly.Size <= 1 then
			if A_Unit("player"):Role(ROLE) then
				if A_Unit("player"):HasBuffs(spells, source, byID) > (duration or 0) then
					return 1
				end
			end
			return 0
		end

		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if A_Unit(member):HasBuffs(spells, source, byID) > (duration or 0) then
					total = total + 1
				end
			end
			return total
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member and A_Unit(member):HasBuffs(spells, source, byID) > (duration or 0) then
					total = total + 1
				end
			end
			return total
		end
	end, "ROLE"),
	GetDeBuffs		 						= Cache:Wrap(function(self, spells, range)
		-- @return number, unitID
		-- Nill-able: range
		local ROLE 							= self.ROLE
		local duration, member

		if TeamCacheFriendly.Size <= 1 then
			if A_Unit("player"):Role(ROLE) then
				duration = A_Unit("player"):HasDeBuffs(spells)
				if duration ~= 0 then
					return duration, "player"
				end
			end
			return 0, str_none
		end

		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) then
					duration = A_Unit(member):HasDeBuffs(spells)
					if duration ~= 0 then
						return duration, member
					end
				end
			end
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member and A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) then
					duration = A_Unit(member):HasDeBuffs(spells)
					if duration ~= 0 then
						return duration, member
					end
				end
			end

			if not TeamCacheFriendly.Type then
				duration = A_Unit("player"):HasDeBuffs(spells)
				if duration ~= 0 then
					return duration, "player"
				end
			end
		end

		return 0, str_none
	end, "ROLE"),
	GetDeBuffsCount							= Cache:Wrap(function(self, spells, duration, source, byID)
		-- @return number
		-- Nill-able: duration, source, byID
		local ROLE = self.ROLE
		local total = 0
		local member

		if TeamCacheFriendly.Size <= 1 then
			if A_Unit("player"):Role(ROLE) then
				if A_Unit("player"):HasDeBuffs(spells, source, byID) > (duration or 0) then
					return 1
				end
			end
			return 0
		end

		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if A_Unit(member):HasDeBuffs(spells, source, byID) > (duration or 0) then
					total = total + 1
				end
			end
			return total
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member and A_Unit(member):HasDeBuffs(spells, source, byID) > (duration or 0) then
					total = total + 1
				end
			end
			return total
		end
	end, "ROLE"),
	GetTTD 									= Cache:Pass(function(self, count, seconds, range)
		-- @return boolean, counter, unitID
		-- Nill-able: range
		local ROLE 							= self.ROLE

		if TeamCacheFriendly.Size <= 1 then
			if A_Unit("player"):Role(ROLE) and A_Unit("player"):TimeToDie() <= seconds then
				return 1 >= count, 1, "player"
			end

			return false, 0, str_none
		end

		local counter = 0
		local member, lastmember
		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) and A_Unit(member):TimeToDie() <= seconds then
					counter = counter + 1
					if counter >= count then
						return true, counter, member
					end
					lastmember = member
				end
			end
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member and A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) and A_Unit(member):TimeToDie() <= seconds then
					counter = counter + 1
					if counter >= count then
						return true, counter, member
					end
					lastmember = member
				end
			end

			if not TeamCacheFriendly.Type and A_Unit("player"):TimeToDie() <= seconds then
				counter = counter + 1
				if counter >= count then
					return true, counter, "player"
				end
				lastmember = "player"
			end
		end

		return false, counter, lastmember or str_none
	end, "ROLE"),
	AverageTTD 								= Cache:Pass(function(self, range)
		-- @return number, number
		-- Returns average time to die of valid players in group, count of valid players in group
		-- Nill-able: range
		local ROLE 							= self.ROLE

		if TeamCacheFriendly.Size <= 1 then
			if A_Unit("player"):Role(ROLE) then
				return A_Unit("player"):TimeToDie(), 1
			end
			return 0, 0
		end

		local member
		local value, members				= 0, 0
		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) then
					value = value + A_Unit(member):TimeToDie()
					members = members + 1
				end
			end
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member and A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) then
					value = value + A_Unit(member):TimeToDie()
					members = members + 1
				end
			end

			if not TeamCacheFriendly.Type then
				value = value + A_Unit("player"):TimeToDie()
				members = members + 1
			end
		end

		if members > 0 then
			value = value / members
		end

		return value, members
	end, "ROLE"),
	MissedBuffs 							= Cache:Wrap(function(self, spells, source)
		-- @return boolean, unitID
		-- Nill-able: source
		local ROLE 							= self.ROLE

		if TeamCacheFriendly.Size <= 1 then
			if A_Unit("player"):Role(ROLE) then
				if A_Unit("player"):HasBuffs(spells, source) == 0 then
					return true, "player"
				end
			end
			return false, str_none
		end

		local member
		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if A_Unit(member):InRange() and not A_Unit(member):IsDead() and A_Unit(member):HasBuffs(spells, source) == 0 then
					return true, member
				end
			end
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member and A_Unit(member):InRange() and not A_Unit(member):IsDead() and A_Unit(member):HasBuffs(spells, source) == 0 then
					return true, member
				end
			end

			if not TeamCacheFriendly.Type and A_Unit("player"):HasBuffs(spells, source) == 0 then
				return true, "player"
			end
		end

		return false, str_none
	end, "ROLE"),
	PlayersInCombat 						= Cache:Wrap(function(self, range, combatTime)
		-- @return boolean, unitID
		-- Nill-able: range, combatTime
		local ROLE 							= self.ROLE
		local member

		if TeamCacheFriendly.Size <= 1 then
			if A_Unit("player"):Role(ROLE) then
				if A_Unit("player"):CombatTime() > 0 and (not combatTime or A_Unit("player"):CombatTime() <= combatTime) then
					return true, "player"
				end
			end
			return false, str_none
		end

		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) and A_Unit(member):CombatTime() > 0 and (not combatTime or A_Unit(member):CombatTime() <= combatTime) then
					return true, member
				end
			end
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member and A_Unit(member):InRange() and (not range or A_Unit(member):GetRange() <= range) and A_Unit(member):CombatTime() > 0 and (not combatTime or A_Unit(member):CombatTime() <= combatTime) then
					return true, member
				end
			end

			if not TeamCacheFriendly.Type and A_Unit("player"):CombatTime() > 0 and (not combatTime or A_Unit("player"):CombatTime() <= combatTime) then
				return true, "player"
			end
		end

		return false, str_none
	end, "ROLE"),
	HealerIsFocused 						= Cache:Wrap(function(self, burst, deffensive, range)
		-- @return boolean, unitID
		-- Nill-able: burst, deffensive, range
		-- Note: No 'ROLE' here

		for member in pairs(TeamCacheFriendlyHEALER) do
			if A_Unit(member):InRange() and A_Unit(member):IsFocused(nil, burst, deffensive, range) then
				return true, member
			end
		end

		return false, str_none
	end, "ROLE"),
	ArcaneTorrentMindControl 				= Cache:Pass(function(self)
		-- @return boolean, unitID
		-- Note: This is a buff type since MindControl is a buff
		-- Note: Doesn't checking "player" here since it's poinless
		local ROLE 							= self.ROLE
		local member

		if ROLE and TeamCacheFriendly[ROLE] then
			for member in pairs(TeamCacheFriendly[ROLE]) do
				if not UnitIsUnit(member, "player") and A_Unit(member):HasBuffs(605) > 0 and A_Unit(member):GetRange() <= 8 then
					return true, member
				end
			end
		else
			for i = 1, TeamCacheFriendly.MaxSize do
				member = TeamCacheFriendlyIndexToPLAYERs[i]
				if member and A_Unit(member):HasBuffs(605) > 0 and A_Unit(member):GetRange() <= 8 then
					return true, member
				end
			end
		end

		return false, str_none
	end, "ROLE"),
})

function A.FriendlyTeam:New(ROLE, Refresh)
    self.ROLE = ROLE
    self.Refresh = Refresh or 0.05
end

-------------------------------------------------------------------------------
-- API: EnemyTeam
-------------------------------------------------------------------------------
A.EnemyTeam = PseudoClass({
	-- Note: Return field 'unitID' will return "none" if is not found
	GetUnitID 								= Cache:Pass(function(self, range, specs)
		-- @return string
		-- Nill-able: range, specs
		local ROLE 							= self.ROLE

		if ROLE then
			if TeamCacheEnemy[ROLE] then
				for arena in pairs(TeamCacheEnemy[ROLE]) do
					if not A_Unit(arena):IsDead() and (not specs or A_Unit(arena):HasSpec(specs)) and (not range or A_Unit(arena):GetRange() <= range) then
						return arena
					end
				end
			end
		else
			if TeamCacheEnemy.Type then
				local arena
				for i = 1, TeamCacheEnemy.MaxSize do
					arena = TeamCacheEnemyIndexToPLAYERs[i]
					if arena and not A_Unit(arena):IsDead() and (not specs or A_Unit(arena):HasSpec(specs)) and (not range or (A_Unit(arena):GetRange() > 0 and A_Unit(arena):GetRange() <= range)) then
						return arena
					end
				end
			end
		end

		return str_none
	end, "ROLE"),
	GetCC 									= Cache:Wrap(function(self, spells)
		-- @return number, unitID
		-- Note: If 'ROLE' is "HEALER" then it will except healers if they are in @target
		-- Nill-able: spells
		local ROLE 							= self.ROLE
		local duration, arena

		if ROLE and TeamCacheEnemy[ROLE] then
			for arena in pairs(TeamCacheEnemy[ROLE]) do
				if ROLE ~= "HEALER" or not UnitIsUnit(arena, "target") then
					if spells then
						duration = A_Unit(arena):HasDeBuffs(spells)
						if duration ~= 0 then
							return duration, arena
						end
					else
						duration = A_Unit(arena):InCC()
						if duration ~= 0 then
							return duration, arena
						end
					end
				end
			end
		else
			for i = 1, TeamCacheEnemy.MaxSize do
				arena = TeamCacheEnemyIndexToPLAYERs[i]
				if arena then
					if spells then
						duration = A_Unit(arena):HasDeBuffs(spells)
						if duration ~= 0 then
							return duration, arena
						end
					else
						duration = A_Unit(arena):InCC()
						if duration ~= 0 then
							return duration, arena
						end
					end
				end
			end
		end

		return 0, str_none
	end, "ROLE"),
	GetBuffs 								= Cache:Wrap(function(self, spells, range, source)
		-- @return number, unitID
		-- Nill-able: range, source
		local ROLE 							= self.ROLE
		local duration, arena

		if ROLE and TeamCacheEnemy[ROLE] then
			for arena in pairs(TeamCacheEnemy[ROLE]) do
				if not range or A_Unit(arena):GetRange() <= range then
					duration = A_Unit(arena):HasBuffs(spells, source)
					if duration ~= 0 then
						return duration, arena
					end
				end
			end
		else
			for i = 1, TeamCacheEnemy.MaxSize do
				arena = TeamCacheEnemyIndexToPLAYERs[i]
				if arena and (not range or A_Unit(arena):GetRange() <= range) then
					duration = A_Unit(arena):HasBuffs(spells, source)
					if duration ~= 0 then
						return duration, arena
					end
				end
			end
		end

		return 0, str_none
	end, "ROLE"),
	GetDeBuffs 								= Cache:Wrap(function(self, spells, range)
		-- @return number, unitID
		-- Nill-able: range
		local ROLE 							= self.ROLE
		local duration, arena

		if ROLE and TeamCacheEnemy[ROLE] then
			for arena in pairs(TeamCacheEnemy[ROLE]) do
				if not range or A_Unit(arena):GetRange() <= range then
					duration = A_Unit(arena):HasDeBuffs(spells)
					if duration ~= 0 then
						return duration, arena
					end
				end
			end
		else
			for i = 1, TeamCacheEnemy.MaxSize do
				arena = TeamCacheEnemyIndexToPLAYERs[i]
				if arena and (not range or A_Unit(arena):GetRange() <= range) then
					duration = A_Unit(arena):HasDeBuffs(spells)
					if duration ~= 0 then
						return duration, arena
					end
				end
			end
		end

		return 0, str_none
	end, "ROLE"),
	GetTTD 									= Cache:Pass(function(self, count, seconds, range)
		-- @return boolean, counter, unitID
		-- Nill-able: range
		local ROLE 							= self.ROLE
		local counter = 0
		local arena, lastarena

		if ROLE and TeamCacheEnemy[ROLE] then
			for arena in pairs(TeamCacheEnemy[ROLE]) do
				if (not range or A_Unit(arena):GetRange() <= range) and A_Unit(arena):TimeToDie() <= seconds then
					counter = counter + 1
					if counter >= count then
						return true, counter, arena
					end
					lastarena = arena
				end
			end
		else
			for i = 1, TeamCacheEnemy.MaxSize do
				arena = TeamCacheEnemyIndexToPLAYERs[i]
				if arena and (not range or A_Unit(arena):GetRange() <= range) and A_Unit(arena):TimeToDie() <= seconds then
					counter = counter + 1
					if counter >= count then
						return true, counter, arena
					end
					lastarena = arena
				end
			end
		end

		return false, counter, lastarena or str_none
	end, "ROLE"),
	AverageTTD 								= Cache:Pass(function(self, range)
		-- @return number, number
		-- Returns average time to die of valid players, count of valid players
		-- Nill-able: range
		local ROLE 							= self.ROLE
		local value, members				= 0, 0

		if ROLE and TeamCacheEnemy[ROLE] then
			for arena in pairs(TeamCacheEnemy[ROLE]) do
				if (not range or A_Unit(arena):GetRange() <= range) then
					value = value + A_Unit(arena):TimeToDie()
					arenas = arenas + 1
				end
			end
		else
			for i = 1, TeamCacheEnemy.MaxSize do
				arena = TeamCacheEnemyIndexToPLAYERs[i]
				if arena and (not range or A_Unit(arena):GetRange() <= range) then
					value = value + A_Unit(arena):TimeToDie()
					arenas = arenas +  1
				end
			end
		end

		if arenas > 0 then
			value = value / arenas
		end

		return value, arenas
	end, "ROLE"),
	IsBreakAble 							= Cache:Wrap(function(self, range)
		-- @return boolean, unitID
		-- Nill-able: range
		local ROLE 							= self.ROLE
		local arena

		if ROLE and TeamCacheEnemy[ROLE] then
			for arena in pairs(TeamCacheEnemy[ROLE]) do
				if not UnitIsUnit(arena, "target") and (not range or A_Unit(arena):GetRange() <= range) and A_Unit(arena):HasDeBuffs("BreakAble") ~= 0 then
					return true, arena
				end
			end
		else
			-- Note: It's much faster than querying through index
			for arena in pairs(ActiveUnitPlates) do
				if A_Unit(arena):IsPlayer() and A_Unit(arena):Role(ROLE) and not UnitIsUnit("target", arena) and (not range or A_Unit(arena):GetRange() <= range) and A_Unit(arena):HasDeBuffs("BreakAble") ~= 0 then
					return true, arena
				end
			end
		end

		return false, str_none
	end, "ROLE"),
	PlayersInRange 							= Cache:Pass(function(self, stop, range)
		-- @return boolean, number, unitID
		-- Nill-able: stop, range
		local ROLE 							= self.ROLE
		local count 						= 0
		local arena

		if ROLE and TeamCacheEnemy[ROLE] then
			for arena in pairs(TeamCacheEnemy[ROLE]) do
				if not range or A_Unit(arena):GetRange() <= range then
					count = count + 1
					if not stop or count >= stop then
						return true, count, arena
					end
				end
			end
		else
			for arena in pairs(ActiveUnitPlates) do
				if A_Unit(arena):IsPlayer() and A_Unit(arena):Role(ROLE) and (not range or A_Unit(arena):GetRange() <= range) then
					count = count + 1
					if not stop or count >= stop then
						return true, count, arena
					end
				end
			end
		end

		return false, count, arena or str_none
	end, "ROLE"),
	-- [[ Without ROLE argument ]]
	HasInvisibleUnits 						= Cache:Pass(function(self, checkVisible)
		-- @return boolean, unitID, unitClass
		-- Nill-able: checkVisible
		local arena, class

		for i = 1, TeamCacheEnemy.MaxSize do
			arena = TeamCacheEnemyIndexToPLAYERs[i]
			if arena and not A_Unit(arena):IsDead() then
				class = A_Unit(arena):Class()
				if (class == "MAGE" or class == "ROGUE" or class == "DRUID") and (not checkVisible or not A_Unit(arena):IsVisible()) then
					return true, arena, class
				end
			end
		end

		return false, str_none, str_none
	end, "ROLE"),
	IsTauntPetAble 							= Cache:Pass(function(self, spell, max_index)
		-- @return boolean, unitID
		-- Nill-able: max_index
		if TeamCacheEnemy.Size > 0 then
			local pet, spell_type
			for i = 1, (max_index or (TeamCacheEnemy.MaxSize >= 3 and 3) or TeamCacheEnemy.MaxSize) do -- Retail 3, Classic 10
				pet = TeamCacheEnemyIndexToPETs[i]
				if pet then
					spell_type = type(spell)
					if not spell or (spell_type == "table" and spell:IsInRange(pet)) or (spell_type ~= "table" and A_IsSpellInRange(spell, pet)) then
						return true, pet
					end
				end
			end
		end

		return false, str_none
	end, "ROLE"),
	IsCastingBreakAble 						= Cache:Pass(function(self, offset)
		-- @return boolean, unitID
		-- Nill-able: offset
		local arena

		for i = 1, TeamCacheEnemy.MaxSize do
			arena = TeamCacheEnemyIndexToPLAYERs[i]
			if arena then
				local _, castRemain, _, _, castName = A_Unit(arena):CastTime()
				if castRemain > 0 and castRemain <= (offset or 0.5) then
					for _, spell in ipairs(AuraList.Premonition) do
						if A_GetSpellInfo(spell[1]) == castName and A_Unit(arena):GetRange() <= spell[2] then
							return true, arena
						end
					end
				end
			end
		end

		return false, str_none
	end, "ROLE"),
	IsReshiftAble 							= Cache:Pass(function(self, offset)
		-- @return boolean, unitID
		-- Nill-able: offset
		local arena

		if not A_Unit("player"):IsFocused("MELEE") then
			for i = 1, TeamCacheEnemy.MaxSize do
				arena = TeamCacheEnemyIndexToPLAYERs[i]
				if arena then
					local _, castRemain, _, _, castName = A_Unit(arena):CastTime()
					if castRemain > 0 and castRemain <= A_GetCurrentGCD() + A_GetGCD() + (offset or 0.05) then
						for _, spell in ipairs(AuraList.Reshift) do
							if A_GetSpellInfo(spell[1]) == castName and A_Unit(arena):GetRange() <= spell[2] then
								return true, arena
							end
						end
					end
				end
			end
		end

		return false, str_none
	end, "ROLE"),
	IsPremonitionAble 						= Cache:Pass(function(self, offset)
		-- @return boolean, unitID
		-- Nill-able: offset
		local arena

		for i = 1, TeamCacheEnemy.MaxSize do
			arena = TeamCacheEnemyIndexToPLAYERs[i]
			if arena then
				local _, castRemain, _, _, castName = A_Unit(arena):CastTime()
				if castRemain > 0 and castRemain <= A_GetGCD() + (offset or 0.05) then
					for _, spell in ipairs(AuraList.Premonition) do
						if A_GetSpellInfo(spell[1]) == castName and A_Unit(arena):GetRange() <= spell[2] then
							return true, arena
						end
					end
				end
			end
		end

		return false, str_none
	end, "ROLE"),
})

function A.EnemyTeam:New(ROLE, Refresh)
    self.ROLE = ROLE
    self.Refresh = Refresh or 0.05
end

-------------------------------------------------------------------------------
-- Events
-------------------------------------------------------------------------------
local EventInfo		 					= {
	["UNIT_DIED"] 						= "RESET",
	["UNIT_DESTROYED"]					= "RESET",
	["UNIT_DISSIPATES"]					= "RESET",
	["PARTY_KILL"] 						= "RESET",
	["SPELL_INSTAKILL"] 				= "RESET",
}
Listener:Add("ACTION_EVENT_UNIT", "COMBAT_LOG_EVENT_UNFILTERED", 		function(...)
	if C_CombatLog and C_CombatLog.IsCombatLogRestricted and C_CombatLog.IsCombatLogRestricted() then return end
	local _, EVENT, _, _, _, _, _, DestGUID, _, _, _, _, spellName = CombatLogGetCurrentEventInfo()
	if EventInfo[EVENT] == "RESET" then
		InfoCacheMoveIn[DestGUID] 		= nil
		InfoCacheMoveOut[DestGUID] 		= nil
		InfoCacheMoving[DestGUID]		= nil
		InfoCacheStaying[DestGUID]		= nil
		InfoCacheInterrupt[DestGUID]	= nil
		InfoCycloneGUIDs[DestGUID]		= nil
	end

	if spellName and InfoCycloneSpellName[spellName] then
		if InfoCycloneOnEvent[EVENT] == "Add" then
			InfoCycloneGUIDs[DestGUID] 	= true
		elseif InfoCycloneOnEvent[EVENT] == "Remove" then
			InfoCycloneGUIDs[DestGUID]	= nil
		end
	end
end)

Listener:Add("ACTION_EVENT_UNIT", "PLAYER_REGEN_ENABLED", 				function()
	if A.Zone ~= "arena" and A.Zone ~= "pvp" and not A.IsInDuel then
		for _, tfunc in pairs(Cache.bufer) do
			for keyArg, tkeyArg in pairs(tfunc) do
				if TMW.time - tkeyArg.t > 10 then
					tfunc[keyArg] = nil
				end
			end
		end
		wipe(InfoCacheMoveIn)
		wipe(InfoCacheMoveOut)
		wipe(InfoCacheMoving)
		wipe(InfoCacheStaying)
		wipe(InfoCacheInterrupt)
	end
end)

Listener:Add("ACTION_EVENT_UNIT", "PLAYER_REGEN_DISABLED", 				function()
	-- Need leave slow delay to prevent reset Data which was recorded before combat began for flyout spells, otherwise it will cause a bug
	local LastTimeCasted = CombatTracker:GetSpellLastCast("player", A.LastPlayerCastID)
	if (LastTimeCasted == 0 or LastTimeCasted > 1.5) and A.Zone ~= "arena" and A.Zone ~= "pvp" and not A.IsInDuel and not Player:IsStealthed() and Player:CastTimeSinceStart() > 5 then
		wipe(InfoCacheMoveIn)
		wipe(InfoCacheMoveOut)
		wipe(InfoCacheMoving)
		wipe(InfoCacheStaying)
		wipe(InfoCacheInterrupt)
	end
end)

TMW:RegisterCallback("TMW_ACTION_ENTERING",								function(event, subevent)
	if subevent ~= "UPDATE_INSTANCE_INFO" then
		for _, tfunc in pairs(Cache.bufer) do
			for keyArg, tkeyArg in pairs(tfunc) do
				if TMW.time - tkeyArg.t > 10 then
					tfunc[keyArg] = nil
				end
			end
		end
		wipe(InfoCacheMoveIn)
		wipe(InfoCacheMoveOut)
		wipe(InfoCacheMoving)
		wipe(InfoCacheStaying)
		wipe(InfoCacheInterrupt)
		-- Only here InfoCycloneGUIDs
		wipe(InfoCycloneGUIDs)
	end
end)
