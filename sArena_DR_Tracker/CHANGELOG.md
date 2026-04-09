# Changelog

## Version 1.0.0 (Initial Release)

### Features
- Standalone DR tracker extracted from sArena Reloaded
- Tracks diminishing returns for all arena opponents (1-3 for Retail, 1-5 for Classic)
- Color-coded severity indicators:
  - Green: 50% reduction (first DR)
  - Yellow: 25% reduction (second DR)
  - Red: Immune (third DR)
- Movable frames (Alt+Drag to reposition)
- Automatic position saving
- Support for all WoW versions (Retail, Wrath, TBC, Vanilla, MoP)

### DR Categories Tracked
- Incapacitate (Polymorph, Sap, Hex, etc.)
- Stun (Kidney Shot, Hammer of Justice, etc.)
- Root (Frost Nova, Entangling Roots, etc.)
- Disorient (Fear, Psychic Scream, Blind, etc.)
- Silence (Silence, Garrote, etc.)
- Disarm (Dismantle, Disarm, etc.)
- Knock (Typhoon, Thunderstorm, etc.)

### Commands
- `/drtracker` or `/drt` - Show help
- `/drtracker show` - Show all frames for positioning
- `/drtracker hide` - Hide all frames
- `/drtracker reset` - Reset all settings to default

### Known Issues
- Requires manual installation of Ace3 libraries (see README.md)
- Configuration GUI not yet implemented (coming in future version)
- TBC/Wrath/MoP DR spell lists are incomplete (placeholders provided)

### Installation
1. Extract to your AddOns folder
2. Run `INSTALL_LIBS.bat` to copy required Ace3 libraries from sArena_Reloaded
3. Reload UI or restart WoW

### Credits
- Original sArena by Stako
- sArena Reloaded by Bodify
- DR Tracker extraction and standalone version

