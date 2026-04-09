local _G, pairs, type, table, string, math, assert =
	  _G, pairs, type, table, string, math, assert


local A	 							= _G.Action


A.BossMods 							= { EngagedBosses = {} }

-------------------------------------------------------------------------------
-- Locals DBM
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Locals BigWigs
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- API
-------------------------------------------------------------------------------
-- DBM commands:
-- /dbm pull <5>
-- /dbm timer <10> <Name>
--
-- BigWigs commands:
-- /pull <5>

function A.BossMods:HasAnyAddon()
	-- @return boolean
	return false
end

function A.BossMods:GetPullTimer()
	-- @return @number, @number
	local remaining, expirationTime = 0, 0
	return remaining, expirationTime
end

function A.BossMods:GetTimer(name)
	-- @return @number, @number
	-- @arg name can be number (spellID, works only on DBM) or string (localizated name of the timer)
	local remaining, expirationTime = 0, 0
	return remaining, expirationTime
end

function A.BossMods:GetNameplateTimer(spellID)
    return -1, -1
end

function A.BossMods:IsEngage(name)
	return false
end