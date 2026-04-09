------------------------------------------------------------------------------
-- DebugLog -- Collect and View Debug Logs
------------------------------------------------------------------------------
-- Locale/deDE.lua - Strings for deDE
--
-- Author: Expelliarm5s / February 2026 / All Rights Reserved
--
-- Version 1.3.3
------------------------------------------------------------------------------
local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "deDE")
if not L then return end
------------------------------------------------------------------------------
-- luacheck: max_line_length 250

-- DebugLog.lua
L["enter /%s for interface"] = "/%s zum Anzeigen"
L["Debug is off"] = "Fehlersuche aus"
L["Debug is on"] = "Fehlersuche an"

-- Options.lua
L["Misc."] = "Verschiedenes"
L["Time Format"] = "Zeitformat"
L["Select the format to display times."] = "Wähle das gewünschte Zeitformat aus."
L["Max. Verbosity Level"] = "Max. Ausführlichkeitswert"
L["Select the maximum verbosity level to show up in the log. Values: 1 to 9. Default: 6."] = "Wähle den maximalen Ausführlichkeitswert der Zeilen, die im Log erscheinen sollen. Werte von 1 bis 9. Default: 6."
L["Discard Silver"] = "Keine Silberwerte anzeigen"
L["If checked, any values below 1g are not displayed."] = "Wenn aktiviert, werden keine Werte unter 1g angezeigt."
L["Discard Copper"] = "Keine Kupferwerte anzeigen"
L["If checked, any values below 1s are not displayed."] = "Wenn aktiviert, werden keine Werte unter 1s angezeigt."
L["Show Minimap Button"] = "Minimap-Knopf anzeigen"
L["If checked, the minimap button is present."] = "Wenn aktiviert, wird ein Minimap-Knopf angezeigt"

L["Font Size"] = "Textgröße"
L["Choose the font size. Changing the size causes an user interface reload!"] = "Textgröße der Rezeptabelle festlegen. Eine Änderung läd das Interface neu!"
L["|cffff8888Changing the font size causes an user interface reload!|r"] = "|cffff8888Welchseln der Schriftgröße führt zum Neuladen der Oberfläche!|r"
L["Show Search/Export"] = "Suchen/Export anzeigen"
L["If checked, search and export is always displayed, regardless of the lack of categories/verbosity."] = "Wenn aktiviert, werden die Suche und die Export-Knöpfe immer angezeigt."

-- EOF
