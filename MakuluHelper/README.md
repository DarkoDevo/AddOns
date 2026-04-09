# Makulu Helper

**Version:** 1.0.0  
**Author:** Makulu Framework Team  
**Type:** WoW Addon - Quick Reference & Learning Tool

Quick reference and learning tool for Makulu Framework. Look up spells, search API methods, and get helpful suggestions while writing rotations.

---

## 🎯 Features

### ✅ Slash Commands
- `/makulu help` - Show all available commands
- `/makulu spell <id|name>` - Look up spell information
- `/makulu api <method>` - Search API methods
- `/makulu class <name>` - Show class methods
- `/makulu show` - Show/hide the main UI
- `/makulu stats` - Show database statistics
- `/makulu version` - Show addon version

### ✅ Spell Database
- **12+ spells** included (Demon Hunter focus)
- Look up by spell ID or name
- Fuzzy name matching
- Shows cast time, cooldown, range, cost, school
- Wowhead links
- Checks if you know the spell

### ✅ API Reference
- **237 methods** across 16 classes
- Search by method name or description
- View method signatures, parameters, returns
- Code examples included
- Grouped by category

### ✅ Error Detection
- Detects common rotation errors
- Provides helpful suggestions
- Analyzes Lua error messages
- Suggests fixes and alternatives

### ✅ Quick Reference UI
- Draggable window
- Tabs for Spells, API, Examples, Settings
- Toggle with `/makulu show`
- Customizable settings

---

## 📦 Installation

### Method 1: Manual Installation

1. **Download** the `MakuluHelper` folder
2. **Copy** to your WoW AddOns directory:
   - **Windows:** `C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\`
   - **Mac:** `/Applications/World of Warcraft/_retail_/Interface/AddOns/`
3. **Restart** World of Warcraft
4. **Enable** the addon at character selection

### Method 2: From ZIP

1. **Download** `MakuluHelper.zip`
2. **Extract** the ZIP file
3. **Copy** the `MakuluHelper` folder to AddOns directory
4. **Restart** WoW and enable the addon

---

## 🚀 Quick Start

### Look Up a Spell

```
/makulu spell 162243
/makulu spell Demon's Bite
/makulu spell chaos
```

### Search API Methods

```
/makulu api HasBuff
/makulu api health
/makulu api cooldown
```

### View Class Methods

```
/makulu class Unit
/makulu class Spell
/makulu class MultiUnits
```

### Show Statistics

```
/makulu stats
```

---

## 📚 Usage Examples

### Example 1: Look Up Spell by ID

```
/makulu spell 162243
```

**Output:**
```
[Makulu Helper] Spell Information: Demon's Bite
  ID: 162243
  Class: DEMONHUNTER
  Spec: Havoc
  
  Quickly attack for Physical damage. Generates 20 to 30 Fury.
  
  Cast Time: Instant
  Range: 5 yards
  Cost: Generates 20-30 Fury
  School: Physical
  
  You know this spell!
  Wowhead: https://www.wowhead.com/spell=162243
```

### Example 2: Search Spells by Name

```
/makulu spell chaos
```

**Output:**
```
[Makulu Helper] Found 2 spell(s):
  1. Chaos Strike (162794)
  2. Chaos Nova (179057)
  
  Use /makulu spell <id> to see details
```

### Example 3: Search API Methods

```
/makulu api HasBuff
```

**Output:**
```
[Makulu Helper] Found 3 method(s):
  1. Unit:HasBuff
     Unit:HasBuff(spellId)
  2. Unit:HasBuffStacks
     Unit:HasBuffStacks(spellId)
  3. Unit:HasBuffRemaining
     Unit:HasBuffRemaining(spellId)
```

### Example 4: View Class Overview

```
/makulu class Unit
```

**Output:**
```
[Makulu Helper] API Class: Unit
  
  Core unit management class for player, target, and focus
  
  Methods: 147
  
  Health & Power (25 methods):
    • Health
    • HealthMax
    • Power
    • PowerMax
    • PowerDeficit
    ... and 20 more
```

---

## ⚙️ Settings

Access settings via:
- `/makulu show` → Settings tab
- Or edit saved variables in `WTF/Account/[Account]/SavedVariables/MakuluHelper.lua`

### Available Settings

- **Error Detection** - Enable/disable error detection
- **Auto Show Help** - Show help message on login
- **Verbose Mode** - Enable debug messages
- **UI Scale** - Adjust UI size
- **UI Lock** - Lock UI position

---

## 🔧 Requirements

- **WoW Version:** Retail 11.0.2+
- **Dependencies:** None (works standalone)
- **Optional:** Makulu Framework (for enhanced features)

---

## 📊 Database

### Spell Database
- 12 spells included (sample dataset)
- Demon Hunter focus (Havoc & Vengeance)
- Easily extensible

### API Database
- 16 classes documented
- 237 methods total
- Auto-generated from Makulu Framework source

---

## 🐛 Troubleshooting

### Addon Not Loading

**Problem:** Addon doesn't appear in addon list

**Solutions:**
- Verify folder name is exactly `MakuluHelper`
- Check that `MakuluHelper.toc` exists
- Ensure you're in the correct AddOns folder
- Restart WoW completely

### Commands Not Working

**Problem:** `/makulu` command not recognized

**Solutions:**
- Wait for addon to fully load (check chat for load message)
- Type `/reload` to reload UI
- Check if addon is enabled in addon list

### No Spell/API Data

**Problem:** "Not found" errors when searching

**Solutions:**
- Ensure `Data/SpellData.lua` and `Data/APIData.lua` exist
- Type `/reload` to reload data
- Check for Lua errors: `/console scriptErrors 1`

---

## 🤝 Contributing

Want to add more spells or improve the addon?

1. Edit `Data/SpellData.lua` to add spells
2. Run `node scripts/generate-api-data.js` to update API data
3. Test in-game
4. Submit a pull request

---

## 📄 License

MIT License - Free to use and modify

---

## 🔗 Links

- **Documentation:** https://yourusername.github.io/MakuluFramework/
- **GitHub:** https://github.com/yourusername/MakuluFramework
- **Discord:** Join our community
- **Wowhead:** https://www.wowhead.com/

---

## 📝 Changelog

### Version 1.0.0 (2025-01-08)
- ✅ Initial release
- ✅ Slash command system
- ✅ Spell lookup (12 spells)
- ✅ API reference (237 methods)
- ✅ Error detection
- ✅ Quick reference UI
- ✅ Database statistics

---

**Made with ❤️ for the Makulu Framework community**

