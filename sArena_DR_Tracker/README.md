# sArena DR Tracker

A standalone Diminishing Returns tracker extracted from sArena Reloaded.

## Features

- Tracks diminishing returns for all arena opponents
- Color-coded severity indicators (Green → Yellow → Red)
- Movable frames for each arena opponent
- Supports all WoW versions (Retail, Wrath, TBC, Vanilla, MoP)

## Installation

### Required Libraries

This addon requires Ace3 libraries. You need to copy the following folders from sArena_Reloaded to this addon:

1. Copy `sArena_Reloaded/Ace3/LibStub` to `sArena_DR_Tracker/Libs/LibStub`
2. Copy `sArena_Reloaded/Ace3/CallbackHandler-1.0` to `sArena_DR_Tracker/Libs/CallbackHandler-1.0`
3. Copy `sArena_Reloaded/Ace3/AceDB-3.0` to `sArena_DR_Tracker/Libs/AceDB-3.0`

### Quick Install (PowerShell)

Run this command from the AddOns directory:

```powershell
robocopy "sArena_Reloaded\Ace3\LibStub" "sArena_DR_Tracker\Libs\LibStub" /E
robocopy "sArena_Reloaded\Ace3\CallbackHandler-1.0" "sArena_DR_Tracker\Libs\CallbackHandler-1.0" /E
robocopy "sArena_Reloaded\Ace3\AceDB-3.0" "sArena_DR_Tracker\Libs\AceDB-3.0" /E
```

## Usage

### Moving Frames

- Hold **Alt** and **drag** any arena frame to reposition it
- Each arena opponent (1, 2, 3) has its own independent frame
- Positions are saved automatically

### DR Icons

- Icons appear to the right of each arena frame by default
- Green border = 50% reduction (first DR)
- Yellow border = 25% reduction (second DR)
- Red border = Immune (third DR)
- Small text shows the reduction: ½, ¼, or %

### Configuration

Type `/drtracker` in chat to open configuration options (coming soon).

## DR Categories Tracked

- **Incapacitate**: Polymorph, Sap, Hex, etc.
- **Stun**: Kidney Shot, Hammer of Justice, etc.
- **Root**: Frost Nova, Entangling Roots, etc.
- **Disorient**: Fear, Psychic Scream, Blind, etc.
- **Silence**: Silence, Garrote, etc.
- **Disarm**: Dismantle, Disarm, etc.
- **Knock**: Typhoon, Thunderstorm, etc.

## Credits

- Original sArena by Stako
- sArena Reloaded by Bodify
- DR Tracker extraction and standalone version

## License

Same as sArena Reloaded

