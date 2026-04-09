-- =============================================================================
-- Smart Garbage Collector
-- Do not remove important & explanatory comments
-- =============================================================================

local SmartGarbageCollector = {}

local function MB(megabytes)
	return megabytes * 1024
end

-- =============================================================================
-- DATABASE DEFAULTS
-- =============================================================================

local defaults = {
	enabled = false,				-- Disabled by default
	autoDelay = 40,					-- 40 second default
	showMemoryInfo = true,			-- Show memory freed info
	minimumThreshold = MB(78),		-- Only run if total memory > this value
	hasInitialized = false,			-- Track if this is first install
	hideAutoChatPrint = false,		-- Hide chat output for auto clean-ups only
	showCriticalWarnings = true,	-- Show critical inefficient clean-up warnings
	stepSize = 128,					-- Step size higher = more aggressive clean-ups 512 max
	autoAdjustStepSize = true,		-- Auto-adjust step size on inefficient clean-ups
	manualStepSize = 128,			-- User's manual step size preference
	disableInDungeon = true,
	disableInRaid = true,
	disableInPVP = true,
	disableInScenario = true,
	blockExternalGC = false,		-- Block other add-ons from calling garbage collection
	blockMemoryUpdates = false,		-- Block UpdateAddOnMemoryUsage (default off to show memory usage)
	showBlockedGC = true,			-- Show chat messages when GC is blocked
	showBlockedMemory = true,		-- Show chat messages when memory updates are blocked

}

-- =============================================================================
-- LOCAL VARIABLES
-- =============================================================================

local autoTimer = nil
local isLoadingScreen = false
local isInitialized = false
local inefficientCleanupCount = 0
local consecutiveInefficientCount = 0
local hasShownFinalWarning = false
local hasShownInstanceMessage = false
local retryCount = 0			-- Track retry attempts in current cycle
local MAX_RETRIES = 10			-- Maximum retries per cycle (64 -> 384)
local SHOW_RETRY_DEBUG = false	-- Set to true to see retry messages
local SHOW_FPS_DEBUG = false	-- Set to true to see FPS detection messages
local isCleanupRunning = false	-- Prevent overlapping clean-ups

-- =============================================================================
-- AUTO TIMER FUNCTIONS
-- =============================================================================

local function StartAutoTimer()
	if autoTimer then
		autoTimer:Cancel()
		autoTimer = nil
	end

	if SmartGarbageCollectorDB and SmartGarbageCollectorDB.enabled and SmartGarbageCollectorDB.autoDelay > 0 then
		autoTimer = C_Timer.NewTicker(SmartGarbageCollectorDB.autoDelay, function()
			DoGarbageCollection("auto")
		end)
	end
end

local function StopAutoTimer()
	if autoTimer then
		autoTimer:Cancel()
		autoTimer = nil
	end
end

-- =============================================================================
-- CORE GARBAGE COLLECTION FUNCTION
-- =============================================================================

function DoGarbageCollection(source)
	-- -------------------------------------------------------------------------
	-- Prevent overlapping clean-ups
	-- -------------------------------------------------------------------------
	if isCleanupRunning then
		if SHOW_RETRY_DEBUG then
			print("|cFFAAD2FFSGC:|r Clean-up already in progress, skipping...")
		end
		return
	end

	isCleanupRunning = true

	-- -------------------------------------------------------------------------
	-- Check if add-on is initialized
	-- -------------------------------------------------------------------------
	if not isInitialized or not SmartGarbageCollectorDB then
		isCleanupRunning = false
		print("|cFFFF0000SGC:|r Add-on not yet initialized. Please wait a moment and try again.")
		return
	end

	-- -------------------------------------------------------------------------
	-- Determine effective step size
	-- -------------------------------------------------------------------------
	-- Use maximum step size for manual clean-ups, current setting for auto
	local effectiveStepSize = (source == "manual" or source == "command") and 512 or SmartGarbageCollectorDB.stepSize

	-- -------------------------------------------------------------------------
	-- FPS check: Skip if window appears to be out of focus
	-- -------------------------------------------------------------------------
	local backgroundFPS = tonumber(GetCVar("maxFPSBk"))
	local foregroundFPS = tonumber(GetCVar("maxFPS"))
	local bgEnabled = tonumber(GetCVar("useMaxFPSBk")) == 1
	local fgEnabled = tonumber(GetCVar("useMaxFPS")) == 1
	local currentFPS = GetFramerate()

	if backgroundFPS and backgroundFPS > 0 and bgEnabled then
		local threshold

		if foregroundFPS and foregroundFPS > 0 then
			-- Both limits set: use 20% of the gap as buffer
			local gap = foregroundFPS - backgroundFPS
			threshold = backgroundFPS + (gap * 0.20)

			if SHOW_FPS_DEBUG then
				print(string.format("DEBUG FPS: BG-%d-%s - FG-%d-%s - Current-%.1f - Threshold-%.1f - Gap-%.1f",
				backgroundFPS, bgEnabled and "ON" or "OFF",
				foregroundFPS, fgEnabled and "ON" or "OFF",
				currentFPS, threshold, gap))
			end
		else
			-- Only background limit set: use 15% buffer
			threshold = backgroundFPS * 1.15

			if SHOW_FPS_DEBUG then
				print(string.format("DEBUG FPS: BG-%d-%s - FG-uncapped - Current-%.1f - Threshold-%.1f",
				backgroundFPS, bgEnabled and "ON" or "OFF",
				currentFPS, threshold))
			end
		end

		if currentFPS <= threshold then
			isCleanupRunning = false
			retryCount = 0	-- Cancel any pending retries
			if SHOW_FPS_DEBUG then
				print("DEBUG FPS: PAUSING - low FPS detected")
			end
			return
		end
	elseif SHOW_FPS_DEBUG then
		print(string.format("DEBUG FPS: Detection disabled - BG-%s - Current-%.1f", tostring(backgroundFPS), currentFPS))
	end

	-- -------------------------------------------------------------------------
	-- Skip if in combat or loading screen (auto clean-up only)
	-- -------------------------------------------------------------------------
	if source == "auto" and (InCombatLockdown() or isLoadingScreen) then
		if SmartGarbageCollectorDB.showMemoryInfo and not SmartGarbageCollectorDB.hideAutoChatPrint then
			local reason = InCombatLockdown() and "player in combat" or "loading screen active"
			print("|cFFAAD2FFSGC:|r Skipping clean-up - " .. reason)
		end
		retryCount = 0
		isCleanupRunning = false
		return
	end

	-- -------------------------------------------------------------------------
	-- Skip if in disabled instance type (auto clean-up only)
	-- -------------------------------------------------------------------------
	if source == "auto" then
		local inInstance, instanceType = IsInInstance()
		if inInstance then
			local shouldSkip = false
			local instanceName = ""

			if instanceType == "party" and SmartGarbageCollectorDB.disableInDungeon then
				shouldSkip = true
				instanceName = "dungeons"
			elseif instanceType == "raid" and SmartGarbageCollectorDB.disableInRaid then
				shouldSkip = true
				instanceName = "raids"
			elseif (instanceType == "pvp" or instanceType == "arena") and SmartGarbageCollectorDB.disableInPVP then
				shouldSkip = true
				instanceName = instanceType == "arena" and "arenas" or "battlegrounds"
			elseif instanceType == "scenario" and SmartGarbageCollectorDB.disableInScenario then
				shouldSkip = true
				instanceName = "scenarios"
			end

			if shouldSkip then
				if not hasShownInstanceMessage then
					if SmartGarbageCollectorDB.showMemoryInfo and not SmartGarbageCollectorDB.hideAutoChatPrint then
						print("|cFFAAD2FFSGC:|r Auto clean-up disabled in " .. instanceName)
					end
					hasShownInstanceMessage = true
				end
				retryCount = 0
				isCleanupRunning = false
				return
			end
		else
			hasShownInstanceMessage = false
		end
	end

	-- -------------------------------------------------------------------------
	-- Check if memory meets minimum threshold
	-- -------------------------------------------------------------------------
	local memBefore = collectgarbage("count")

	if memBefore < SmartGarbageCollectorDB.minimumThreshold then
		if SmartGarbageCollectorDB.showMemoryInfo and not (source == "auto" and SmartGarbageCollectorDB.hideAutoChatPrint) then
			print("|cFFAAD2FFSGC:|r No garbage to clean! - skipping...")
		end
		retryCount = 0
		isCleanupRunning = false
		return
	end

	-- -------------------------------------------------------------------------
	-- Show startup message for manual clean-ups
	-- -------------------------------------------------------------------------
	-- Show "please wait" message for manual clean-up only (and not for retries)
	if SmartGarbageCollectorDB.showMemoryInfo and not (source == "auto" and SmartGarbageCollectorDB.hideAutoChatPrint) then
		if (source == "manual" or source == "command") and retryCount == 0 then
			print("|cFFAAD2FFSGC:|r Clean-up started, please wait...")
		end
	end

	-- -------------------------------------------------------------------------
	-- Calculate dynamic clean-up window
	-- -------------------------------------------------------------------------
	local startTime = GetTime()

	-- Dynamic window calculation based on memory pressure
	local memoryMB = memBefore / 1024
	local baseDuration = 2.0
	local memoryFactor = math.max(1.0, memoryMB / 100)
	local maxDuration = math.min(baseDuration * memoryFactor, 6.0)

	-- -------------------------------------------------------------------------
	-- Initialize progress tracking
	-- -------------------------------------------------------------------------
	-- Track progress for early completion
	local lastMemCheck = memBefore
	local noProgressCount = 0
	local checkInterval = 0.5
	local lastProgressCheck = startTime

	-- -------------------------------------------------------------------------
	-- Unified completion handler
	-- -------------------------------------------------------------------------
	local function PrintCompletionMessage()
		isCleanupRunning = false  -- Reset flag when clean-up completes

		local finalMem = collectgarbage("count")
		local totalFreed = memBefore - finalMem
		local elapsed = GetTime() - startTime

		-- ---------------------------------------------------------------------
		-- Handle inefficient clean-ups
		-- ---------------------------------------------------------------------
		if totalFreed <= 0 then
			inefficientCleanupCount = inefficientCleanupCount + 1
			consecutiveInefficientCount = consecutiveInefficientCount + 1

			-- -----------------------------------------------------------------
			-- AUTO-ADJUST: React immediately on first failure
			-- -----------------------------------------------------------------
			if source == "auto" and SmartGarbageCollectorDB.autoAdjustStepSize and SmartGarbageCollectorDB.stepSize < 512 then
				local oldStepSize = SmartGarbageCollectorDB.stepSize
				SmartGarbageCollectorDB.stepSize = math.min(SmartGarbageCollectorDB.stepSize + 32, 512)

				-- Only retry immediately if we haven't hit the retry limit yet
				if retryCount < MAX_RETRIES then
					retryCount = retryCount + 1

					-- Only show retry messages if debug is enabled
					if SHOW_RETRY_DEBUG and SmartGarbageCollectorDB.showCriticalWarnings then
						print(string.format("|cFFAAD2FFSGC:|r |cFFFFD700Inefficient clean-up detected! Increased step size from %d to %d, retrying...|r", oldStepSize, SmartGarbageCollectorDB.stepSize))
					end

					-- Static 5 second delay between retries
					C_Timer.After(5, function()
						-- Cancel and restart the auto timer before retry
						StopAutoTimer()
						DoGarbageCollection(source)
						-- Restart timer after the retry cleanup completes
						if SmartGarbageCollectorDB.enabled then
							StartAutoTimer()
						end
					end)
				else
					-- Hit retry limit, but step size was still increased for next cycle
					retryCount = 0
					if SHOW_RETRY_DEBUG and SmartGarbageCollectorDB.showCriticalWarnings then
						print(string.format("|cFFAAD2FFSmartGarbageCollector:|r |cFFFF9933Retry limit reached. Step size increased to %d for next cycle.|r", SmartGarbageCollectorDB.stepSize))
					end
				end
			else
				-- -----------------------------------------------------------------
				-- Manual mode warnings OR auto mode with auto-adjust disabled
				-- -----------------------------------------------------------------
				retryCount = 0
				if SmartGarbageCollectorDB.showCriticalWarnings and not hasShownFinalWarning then
					-- Only show warnings if NOT in auto-adjust mode
					if not SmartGarbageCollectorDB.autoAdjustStepSize then
						if inefficientCleanupCount == 1 then
							print("|cFFAAD2FFSGC:|r |cFFFFD700Inefficient clean-up!|r")
						elseif inefficientCleanupCount == 2 then
							print("|cFFAAD2FFSGC:|r |cFFFF9933Inefficient clean-up!|r")
						elseif inefficientCleanupCount >= 3 then
							print("|cFFAAD2FFSGC:|r |cFFFF0000Inefficient clean-up! - Increase step size by 32 or 64, or enable Auto-Adjust|r")
							hasShownFinalWarning = true
						end
					end
				end
			end
		else
			-- -----------------------------------------------------------------
			-- Successful clean-up - reset counters and show results
			-- -----------------------------------------------------------------
			consecutiveInefficientCount = 0
			retryCount = 0

			if SmartGarbageCollectorDB.showMemoryInfo and not (source == "auto" and SmartGarbageCollectorDB.hideAutoChatPrint) then
				print(string.format("|cFFAAD2FFSGC:|r cleaned-up |cFF80FF80(%.2f MB)|r of Garbage in %.1fs", totalFreed / 1024, elapsed))
			end
		end
	end

	-- -------------------------------------------------------------------------
	-- Iterative garbage collection step function
	-- -------------------------------------------------------------------------
	local function DoFasterStep()
		collectgarbage("step", effectiveStepSize)

		local elapsed = GetTime() - startTime
		local currentMem = collectgarbage("count")

		-- Check for early completion based on progress
		if elapsed >= checkInterval and (elapsed - (lastProgressCheck - startTime)) >= checkInterval then
			local memFreedSinceLastCheck = lastMemCheck - currentMem

			if memFreedSinceLastCheck < 1024 then
				noProgressCount = noProgressCount + 1
			else
				noProgressCount = 0
				lastMemCheck = currentMem
			end

			lastProgressCheck = GetTime()

			-- Early exit if no progress for 4 consecutive checks
			if noProgressCount >= 4 then
				PrintCompletionMessage()
				return
			end
		end

		-- Continue if within time limit
		if elapsed < maxDuration then
			C_Timer.After(0, DoFasterStep)
		else
			-- Time limit reached
			PrintCompletionMessage()
		end
	end

	DoFasterStep()
end

-- =============================================================================
-- SLASH COMMAND
-- =============================================================================

SLASH_SMARTGARBAGECOLLECTOR1 = "/sgc"
SLASH_SMARTGARBAGECOLLECTOR2 = "/smartgc"
SlashCmdList["SMARTGARBAGECOLLECTOR"] = function(msg)
	msg = msg:lower():trim()

	-- -------------------------------------------------------------------------
	-- Check if add-on is initialized
	-- -------------------------------------------------------------------------
	if not isInitialized or not SmartGarbageCollectorDB then
		print("|cFFFF0000SGC:|r Add-on not yet initialized. Please wait a moment and try again.")
		return
	end

	-- -------------------------------------------------------------------------
	-- Handle slash commands
	-- -------------------------------------------------------------------------
	if msg == "run" or msg == "collect" then
		DoGarbageCollection("command")
	elseif msg == "on" or msg == "enable" then
		SmartGarbageCollectorDB.enabled = true
		StartAutoTimer()
		print(string.format("|cFFAAD2FFSGC:|r Auto clean will run every %d seconds", SmartGarbageCollectorDB.autoDelay))
	elseif msg == "off" or msg == "disable" then
		SmartGarbageCollectorDB.enabled = false
		StopAutoTimer()
		print("|cFFAAD2FFSGC:|r Auto collection disabled")
	elseif msg == "retry on" then
		SHOW_RETRY_DEBUG = true
		print("|cFFAAD2FFSGC:|r Retry debug messages enabled")
	elseif msg == "retry off" then
		SHOW_RETRY_DEBUG = false
		print("|cFFAAD2FFSGC:|r Retry debug messages disabled")
	elseif msg == "fps on" then
		SHOW_FPS_DEBUG = true
		print("|cFFAAD2FFSGC:|r FPS debug messages enabled")
	elseif msg == "fps off" then
		SHOW_FPS_DEBUG = false
		print("|cFFAAD2FFSGC:|r FPS debug messages disabled")
	elseif msg == "status" then
		local currentMemory = collectgarbage("count")
		print(string.format("|cFFAAD2FFSGC:|r Status: %s | Memory: %.1f MB | Auto Delay: %ds | Hide Auto Chat: %s | Auto-Adjust: %s",
			SmartGarbageCollectorDB.enabled and "Enabled" or "Disabled",
			currentMemory / 1024,
			SmartGarbageCollectorDB.autoDelay,
			SmartGarbageCollectorDB.hideAutoChatPrint and "On" or "Off",
			SmartGarbageCollectorDB.autoAdjustStepSize and "On" or "Off"))
	else
		-- Ensure database is fully initialized before creating UI
		if not SmartGarbageCollectorDB.autoDelay then
			for key, value in pairs(defaults) do
				if SmartGarbageCollectorDB[key] == nil then
					SmartGarbageCollectorDB[key] = value
				end
			end
		end

		SmartGarbageCollectorUI.ToggleUI()
	end
end

-- =============================================================================
-- INITIALIZATION
-- =============================================================================

local function Initialize()
	-- Initialize saved variables
	if not SmartGarbageCollectorDB then
		SmartGarbageCollectorDB = {}
	end

	-- Check if this is first install BEFORE applying any defaults
	local isFirstInstall = (SmartGarbageCollectorDB.hasInitialized ~= true)

	-- Apply defaults for missing values
	for key, value in pairs(defaults) do
		if key ~= "hasInitialized" and SmartGarbageCollectorDB[key] == nil then
			SmartGarbageCollectorDB[key] = value
		end
	end

	-- Migrate old showBlockedAttempts setting to new separate settings
	if SmartGarbageCollectorDB.showBlockedAttempts ~= nil then
		-- User had the old setting, migrate it to both new settings
		SmartGarbageCollectorDB.showBlockedGC = SmartGarbageCollectorDB.showBlockedAttempts
		SmartGarbageCollectorDB.showBlockedMemory = SmartGarbageCollectorDB.showBlockedAttempts
		-- Remove old setting
		SmartGarbageCollectorDB.showBlockedAttempts = nil
	end

	-- Reset step size based on auto-adjust state
	if SmartGarbageCollectorDB.autoAdjustStepSize then
		-- Auto mode: always start at 64 for decent efficiency
		SmartGarbageCollectorDB.stepSize = 64
	else
		-- Manual mode: use their saved manual preference
		SmartGarbageCollectorDB.stepSize = SmartGarbageCollectorDB.manualStepSize
	end

	-- Mark as initialized
	isInitialized = true

	-- Start auto timer if enabled
	if SmartGarbageCollectorDB.enabled then
		StartAutoTimer()
	end

	-- Show welcome message only on first install
	if isFirstInstall then
		print("|cFFAAD2FFSGC:|r Loaded. Type /sgc to open settings or /sgc run to collect now.")
		SmartGarbageCollectorDB.hasInitialized = true
	end
end

-- =============================================================================
-- EVENT HANDLING
-- =============================================================================

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("LOADING_SCREEN_ENABLED")
eventFrame:RegisterEvent("LOADING_SCREEN_DISABLED")
eventFrame:SetScript("OnEvent", function(self, event, addonName)
	if event == "ADDON_LOADED" and addonName == "SmartGarbageCollector" then
		Initialize()
		self:UnregisterEvent("ADDON_LOADED")
	elseif event == "LOADING_SCREEN_ENABLED" then
		isLoadingScreen = true
	elseif event == "LOADING_SCREEN_DISABLED" then
		isLoadingScreen = false
	end
end)

-- =============================================================================
-- PUBLIC API
-- =============================================================================

SmartGarbageCollector.StartAutoTimer = StartAutoTimer
SmartGarbageCollector.StopAutoTimer = StopAutoTimer
SmartGarbageCollector.DoGarbageCollection = DoGarbageCollection

_G.SmartGarbageCollector = SmartGarbageCollector
