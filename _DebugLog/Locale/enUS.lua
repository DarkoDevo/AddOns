------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Locale/enUS.lua - Strings for enUS
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
local addonName, _ = ...
local silent = true
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true, silent)
if not L then return end
------------------------------------------------------------------------------

-- DebugLog.lua
L["enter /%s for interface"] = true
L["Debug is off"] = true
L["Debug is on"] = true

-- Options.lua
L["Misc."] = true
L["Time Format"] = true
L["Select the format to display times."] = true
L["Max. Verbosity Level"] = true
L["Select the maximum verbosity level to show up in the log. Values: 1 to 9. Default: 9."] = true
L["Discard Silver"] = true
L["If checked, any values below 1g are not displayed."] = true
L["Discard Copper"] = true
L["If checked, any values below 1s are not displayed."] = true
L["Show Minimap Button"] = true
L["If checked, the minimap button is present."] = true
L["Font Size"] = true
L["Choose the font size. Changing the size causes an user interface reload!"] = true

-- EOF
