# GCD Cursor Plus

A standalone World of Warcraft addon that enhances your mouse cursor with customizable rings, GCD tracking, and mouse trails.

## Features

### Mouse Ring
- Customizable ring around your mouse cursor
- Adjustable size (20-240px)
- Class color or custom color support
- Combat-only mode option

### GCD Ring
- Tracks your Global Cooldown with a visual ring
- **Three animation modes:**
  1. **Normal Mode**: Ring shrinks from outside to inside as GCD progresses
  2. **Inverted Mode**: Ring grows from inside to outside (fill effect)
  3. **Radial Mode**: Pie chart style sweep animation
- Adjustable size (20-240px)
- Class color or custom color support
- Works independently from the mouse ring

### Mouse Trail
- Animated trail that follows your cursor
- Fading effect as trail elements age
- Class color or custom color support
- Combat-only mode option

## Installation

1. Extract the `GCDCursorPlus` folder to your `World of Warcraft\_retail_\Interface\AddOns\` directory
2. Restart World of Warcraft or type `/reload` in-game
3. Type `/gcdcp` to open the settings panel

## Slash Commands

- `/gcdcp` - Opens the settings panel

## Settings

All settings are accessible through the in-game settings panel:
- Type `/gcdcp` or open the game menu → Options → AddOns → GCD Cursor Plus

## Version

Current Version: 1.0.0

## Compatibility

- **Retail**: 11.0.7, 12.0.0, 12.0.1
- **Classic/TBC/Wrath**: Not tested

## File Structure

```
GCDCursorPlus/
├── GCDCursorPlus.toc    # Addon metadata and file loading order
├── Core.lua              # Main addon logic (mouse ring, GCD tracking, trail)
├── Settings.lua          # Settings UI using WoW's Settings API
├── Libs/                 # Required libraries
│   ├── LibStub/
│   └── AceLocale-3.0/
├── Locales/              # Localization files
│   ├── enUS.lua
│   ├── deDE.lua
│   ├── esES.lua
│   ├── frFR.lua
│   └── zhCN.lua
└── Media/                # Textures
    ├── Mouse.tga         # Ring texture
    ├── Dot.tga           # Dot texture
    ├── MouseTrail.tga    # Trail texture
    └── Icon.tga          # Addon icon
```

## Known Issues

None at this time.

## Future Enhancements

- Additional animation modes
- More customization options
- Rotation angle control for radial mode
- Multiple ring layers

## Support

For issues or feature requests, please contact TimeMeansNothing.

