-- =============================================================================
-- Smart Garbage Collector - Protection Module
-- Blocks external add-ons from calling garbage collection
-- Do not remove important & explanatory comments
-- =============================================================================

local SmartGarbageCollectorProtection = {}

-- =============================================================================
-- DEBUG MASTER TOGGLE
-- =============================================================================
-- Set to true to enable all debug output, false for production
local ENABLE_DEBUG = false

-- =============================================================================
-- BLOCK REPORTING SYSTEM
-- =============================================================================
-- Aggregates blocked attempts and reports them periodically

local blockCounts = {}	-- Tracks blocks by add-on: {addonName = {gc = count, memory = count}}
local reportTimer = nil

-- -----------------------------------------------------------------------------
-- Report Aggregated Blocks
-- -----------------------------------------------------------------------------

local function ReportBlocks()
	-- Print aggregated block counts
	for addonName, counts in pairs(blockCounts) do
		local gcCount = counts.gc or 0
		local memCount = counts.memory or 0

		if gcCount > 0 then
			if gcCount == 1 then
				print("|cFFAAD2FFSGC:|r |cFFFFD700" .. addonName .. "|r was |cFFFF0000blocked|r from running GC")
			else
				print("|cFFAAD2FFSGC:|r |cFFFFD700" .. addonName .. "|r was |cFFFF0000blocked|r from running GC |cFFFFAA00x" .. gcCount .. "|r")
			end
		end

		if memCount > 0 then
			if memCount == 1 then
				print("|cFFAAD2FFSGC:|r |cFFFFD700" .. addonName .. "|r was |cFFFF0000blocked|r from updating memory")
			else
				print("|cFFAAD2FFSGC:|r |cFFFFD700" .. addonName .. "|r was |cFFFF0000blocked|r from updating memory |cFFFFAA00x" .. memCount .. "|r")
			end
		end
	end

	-- Clear counts for next interval
	blockCounts = {}
	reportTimer = nil
end

-- -----------------------------------------------------------------------------
-- Record Block Attempt
-- -----------------------------------------------------------------------------

local function RecordBlock(addonName, blockType)
	-- Only record if reporting is enabled for this type
	if not SmartGarbageCollectorDB then
		return
	end

	-- Check specific setting based on block type
	if blockType == "gc" and not SmartGarbageCollectorDB.showBlockedGC then
		return
	end

	if blockType == "memory" and not SmartGarbageCollectorDB.showBlockedMemory then
		return
	end

	-- Filter out Blizzard UI blocks - these are expected and spammy
	-- Users enabled block memory updates, they know Blizzard UI can't update anymore
	if blockType == "memory" and addonName:find("^Blizzard_") then
		return
	end

	-- Initialize add-on entry if needed
	if not blockCounts[addonName] then
		blockCounts[addonName] = {gc = 0, memory = 0}
	end

	-- Increment counter
	if blockType == "gc" then
		blockCounts[addonName].gc = blockCounts[addonName].gc + 1
	elseif blockType == "memory" then
		blockCounts[addonName].memory = blockCounts[addonName].memory + 1
	end

	-- Start report timer if not already running (2 second delay)
	if not reportTimer then
		reportTimer = C_Timer.NewTimer(2, ReportBlocks)
	end
end

-- =============================================================================
-- LOCAL VARIABLES
-- =============================================================================

local oldcollectgarbage = collectgarbage
local oldUpdateAddOnMemoryUsage = UpdateAddOnMemoryUsage
local isInitialized = false

-- Set optimal garbage collector settings
oldcollectgarbage("setpause", 110)
oldcollectgarbage("setstepmul", 200)

-- =============================================================================
-- INITIALIZATION
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Ensure Database Initialized
-- -----------------------------------------------------------------------------

local function EnsureInitialized()
	if isInitialized then return end

	-- Ensure database exists with defaults
	if not SmartGarbageCollectorDB then
		SmartGarbageCollectorDB = {}
	end

	if SmartGarbageCollectorDB.blockExternalGC == nil then
		SmartGarbageCollectorDB.blockExternalGC = false
	end

	if SmartGarbageCollectorDB.blockMemoryUpdates == nil then
		SmartGarbageCollectorDB.blockMemoryUpdates = false
	end

	if SmartGarbageCollectorDB.showBlockedGC == nil then
		SmartGarbageCollectorDB.showBlockedGC = true
	end

	if SmartGarbageCollectorDB.showBlockedMemory == nil then
		SmartGarbageCollectorDB.showBlockedMemory = true
	end

	isInitialized = true
end

-- =============================================================================
-- WHITELIST CHECK FUNCTION
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Check If SmartGarbageCollector Is Calling
-- -----------------------------------------------------------------------------

local function IsSmartGarbageCollectorCalling()
	-- Get the call stack starting at level 3 (skip our hook function at level 2)
	-- Level 1 = IsSmartGarbageCollectorCalling (this function)
	-- Level 2 = UpdateAddOnMemoryUsage hook (our protection code)
	-- Level 3+ = The actual caller we want to check
	local caller = debugstack(3, 2, 0)	-- Start at level 3, get 2 lines

	-- Check if the REAL caller (not our hook) is from SmartGarbageCollector
	if string.find(caller, "SmartGarbageCollector", 1, true) then
		return true
	end

	return false
end

-- =============================================================================
-- COLLECTGARBAGE HOOK
-- =============================================================================

collectgarbage = function(opt, arg)
	EnsureInitialized()

	-- -------------------------------------------------------------------------
	-- Protection Check
	-- -------------------------------------------------------------------------
	if not SmartGarbageCollectorDB.blockExternalGC then
		-- Protection disabled - allow everything through
		return oldcollectgarbage(opt, arg)
	end

	-- -------------------------------------------------------------------------
	-- Whitelist Check
	-- -------------------------------------------------------------------------
	if IsSmartGarbageCollectorCalling() then
		-- This is SmartGarbageCollector calling - allow it unrestricted access
		return oldcollectgarbage(opt, arg)
	end

	-- -------------------------------------------------------------------------
	-- Block Detection & Logging
	-- -------------------------------------------------------------------------

	-- Extract add-on name for reporting
	local caller = debugstack(2, 1, 0)
	local addonName = caller:match("Interface/AddOns/([^/]+)/") or "Unknown"

	-- Record this block attempt (will be reported after 2 second delay)
	RecordBlock(addonName, "gc")

	-- Debug output if enabled
	if ENABLE_DEBUG then
		print("|cFFFF0000[BLOCKED]|r " .. addonName .. " tried collectgarbage('" .. tostring(opt) .. "')")
	end

	-- -------------------------------------------------------------------------
	-- Operation Filtering
	-- -------------------------------------------------------------------------

	-- Always allow "count" - it's harmless (just queries memory usage)
	if opt == "count" then
		return oldcollectgarbage(opt, arg)
	end

	-- Block full garbage collection - this is the main performance killer
	if opt == "collect" or opt == nil then
		-- Silently block - do nothing
		return
	end

	-- Block "stop" - stopping GC is bad
	if opt == "stop" then
		return
	end

	-- Block "restart" - unnecessary
	if opt == "restart" then
		return
	end

	-- Block "step" - even small steps from other add-ons can accumulate
	if opt == "step" then
		-- Block all step calls from external add-ons
		return
	end

	-- Block setpause and setstepmul changes - maintain our optimal settings
	if opt == "setpause" then
		-- Pretend to accept but keep our setting, return current value
		return oldcollectgarbage("setpause", 110)
	end

	if opt == "setstepmul" then
		-- Pretend to accept but keep our setting, return current value
		return oldcollectgarbage("setstepmul", 200)
	end

	-- If Lua adds new GC options in the future, allow them through
	-- (but SmartGarbageCollector should be updated to handle them)
	return oldcollectgarbage(opt, arg)
end

-- =============================================================================
-- UPDATEADDONMEMORYUSAGE HOOK
-- =============================================================================

UpdateAddOnMemoryUsage = function(...)
	EnsureInitialized()

	-- -------------------------------------------------------------------------
	-- Protection Check
	-- -------------------------------------------------------------------------
	if not SmartGarbageCollectorDB.blockMemoryUpdates then
		-- Protection disabled - allow through
		return oldUpdateAddOnMemoryUsage(...)
	end

	-- -------------------------------------------------------------------------
	-- Whitelist Check
	-- -------------------------------------------------------------------------
	if IsSmartGarbageCollectorCalling() then
		return oldUpdateAddOnMemoryUsage(...)
	end

	-- -------------------------------------------------------------------------
	-- Block Detection & Logging
	-- -------------------------------------------------------------------------

	-- Extract add-on name for reporting
	local caller = debugstack(2, 1, 0)
	local addonName = caller:match("Interface/AddOns/([^/]+)/") or "Unknown"

	-- Record this block attempt (will be reported after 2 second delay)
	RecordBlock(addonName, "memory")

	-- Debug output if enabled
	if ENABLE_DEBUG then
		print("|cFFFF0000[BLOCKED]|r " .. addonName .. " tried UpdateAddOnMemoryUsage()")
	end

	-- Simply return without calling the original function
	-- This makes GetAddOnMemoryUsage return 0 or cached values
end

-- =============================================================================
-- PUBLIC API
-- =============================================================================

-- Function to get the original collectgarbage (for internal use if needed)
function SmartGarbageCollectorProtection.GetOriginalCollectGarbage()
	return oldcollectgarbage
end

-- Function to get the original UpdateAddOnMemoryUsage (for internal use if needed)
function SmartGarbageCollectorProtection.GetOriginalUpdateAddOnMemoryUsage()
	return oldUpdateAddOnMemoryUsage
end

-- Function to check if an add-on is whitelisted
function SmartGarbageCollectorProtection.IsWhitelisted()
	return IsSmartGarbageCollectorCalling()
end

_G.SmartGarbageCollectorProtection = SmartGarbageCollectorProtection
