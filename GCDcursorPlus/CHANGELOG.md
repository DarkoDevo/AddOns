# Changelog

## Version 1.0.5 (2026-03-29)

### Fixed
- **Settings not saving** — Fixed a critical bug where your addon settings (like enabling/disabling the mouse ring, GCD ring, trail, etc.) were not being saved between game sessions. The addon was creating an empty settings table too early, which prevented WoW from loading your saved settings from disk. Settings now properly save and load on every login/reload.

## Version 1.0.2 (2026-03-21)

### Added
- **GCD Ring Fixed Position mode** — the GCD ring can now be anchored to a fixed point on screen instead of following the cursor. Enable via *GCD Ring → Fixed Position* in settings.
- **Fixed Position Size slider** — independent size control for the GCD ring when in fixed position mode.
- **Fixed Position X / Y sliders** — pixel offset from screen center to precisely place the fixed GCD ring anywhere on screen.

### Fixed
- Lua error on login: `attempt to index local 'c' (a nil value)` — color table values (`mouseRingColor`, `mouseRingGCDColor`, `mouseTrailColor`, etc.) could be corrupted to nil in the saved DB. All color getters are now nil-safe and `InitDB` now restores corrupted color entries on load.
- Settings sliders (Ring Size, GCD Ring Size, etc.) were resetting to their minimum value (20) on each login due to the wrong default being passed to `Settings.RegisterAddOnSetting`. Sliders now correctly read the existing saved value as their default.
- Duplicate locale keys in `enUS.lua` caused an AceLocale fatal error on load, which prevented the entire settings panel from initializing.

## Version 1.0.1 (2026-03-21)

### Changed
- Added WoW 12.0.5 (Midnight) compatibility

## Version 1.0.0 (2026-02-12)

### Initial Release

**Features:**
- ✅ Mouse Ring with customizable size and color
- ✅ GCD Ring with three animation modes:
  - Normal mode (shrink from outside in)
  - Inverted mode (grow from inside out)
  - Radial mode (pie chart sweep)
- ✅ Mouse Trail with fading effect
- ✅ Class color support for all features
- ✅ Combat-only mode options
- ✅ Full settings UI integration
- ✅ Slash command `/gcdcp`

**Technical:**
- Uses WoW's modern Settings API
- Supports WoW Retail 11.0.7, 12.0.0, 12.0.1

**Files:**
- Core.lua (486 lines) - Main addon logic
- Settings.lua (117 lines) - Settings UI
- 5 localization files (enUS, deDE, esES, frFR, zhCN)
- Required libraries (LibStub, AceLocale-3.0)
- 4 texture files (Mouse, Dot, MouseTrail, Icon)

