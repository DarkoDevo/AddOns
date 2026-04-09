# Libs - Addon Tools Changelog

## 📅 Last Month Summary

This update vastly improves the Addon Manager with a new side panel in Blizzard's addon list, letting you manage profiles, favorites, and even set up addons differently for each character. The profile system now has cleaner exports, uses simpler IDs, and fixes issues like showing too much personal data or causing errors. You'll also find a much better setup wizard, along with many other bug fixes and performance boosts.

## 🎯 This Release

This update makes finding addon save data much faster, fixing the "script ran too long" error. It also updates the addon to work with the new Midnight game patch.

## Version 0.2.1 (2026-04-02)

### 🐛 Fixes
- Addon discovery no longer causes 'script ran too long' error

### 📝 Changes
- FindGlobal uses TOC metadata instead of scanning _G
- Old buggrabber code path
- Interface version for Midnight launch


## Version 0.2.0 (2026-03-15)

### 🚀 Features
- Addon favorites and lock feature
- Favorite button UI component

### 🐛 Fixes
- Use EventRegistry for BugGrabber callbacks and display registration
- Error display no longer loads when BugSack is active
- Profile export no longer includes per-character data from all characters
- Composite export errors and checkbox toggle not working
- Setup wizard no longer spams chat or pollutes addon logs
- Composite export button now works
- False "Reload UI" prompt in Addon List
- Favorite star now shows on all addon list entries, including sub-addons

### 📝 Changes
- DevUI Errors tab hidden when BugSack handles errors
- Profile exports use cleaner BaseDB/Namespaces structure
- Profile exports no longer contain profile names
- Add master toggle to enable or disable Addon Manager features
- Fine-tune setup wizard scrollbar horizontal offset
- Wizard scrollbar and bottom buttons to better positions
- Setup wizard now remembers completed pages and lists addons
- Setup wizard supports child pages, viewed tracking, and dynamic page registration
- Unneeded event
- Type definitions updated for int-ID profile system
- Sidecar panel uses numeric profile IDs
- Profile dropdown replaced with custom popup
- Profile API uses numeric IDs with display names
- Profile system uses numeric IDs instead of name strings
- Filter Discord notifications to reduce noise
- Export strings now include addon ID and game version
- Addon management and profile handling
- Addon list UI and favorites handling
- Blizzard's AddonList UI
- Addon dependency and profile management

### 🔧 Other
- Enables per-character addon configurations
- Refines profile manager UI and filters
- Enables resizing of the DevUI window



---

## Links

- **Support**: [Discord](//discord.gg/Qc9TRBv) | [Report Issues](https://github.com/spartanui-wow/Libs-AddonTools/issues)
