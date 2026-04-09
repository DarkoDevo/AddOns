# Midnight Rotation Probe

A diagnostic World of Warcraft Retail addon for Midnight that helps you answer practical questions such as:

- Is `UnitHealth("target")` readable, secret, nil, or erroring here?
- Can I inspect target / nameplate auras during combat?
- Can I read cooldowns, charges, and usability for watched spells?
- What can I read from current action bars?
- What do `target`, `focus`, `mouseover`, and `nameplateN` expose right now?

## Install

1. Copy the `MidnightRotationProbe` folder into:
   `World of Warcraft/_retail_/Interface/AddOns/`
2. Restart WoW or run `/reload`.
3. Enable the addon on the character select AddOns list if needed.

## Slash commands

- `/mrp` — show/hide the window
- `/mrp help` — print command help
- `/mrp scan` — full scan for common rotation-relevant data
- `/mrp unit target` — full scan of a specific unit token
- `/mrp lite target` — shorter scan of a unit token
- `/mrp auras target HARMFUL` — dump aura slots for a unit/filter
- `/mrp nameplates` — scan active `nameplate1..40`
- `/mrp actionbars` — scan occupied action bar slots
- `/mrp spellbook` — enumerate spellbook skill lines/items (best effort)
- `/mrp spells 61304 585 8092` — probe one or more spell IDs
- `/mrp watch 61304 585 8092` — save watched spell IDs for scans/pulse
- `/mrp pulse 1` — start 1-second pulse logging
- `/mrp pulse off` — stop pulse logging
- `/mrp clear` — clear the log

## Status values

- `OK` — value looked readable in this context
- `SECRET` — the API returned a secret value or secret-looking table/field
- `NIL` — no value in this context
- `ERROR` — the API call errored
- `MISSING` — API absent on this build

## Suggested test plan

Run the same commands in several contexts because Midnight behavior can differ by state:

1. Out of combat in the open world
2. In combat against a target dummy
3. In combat against a multi-target trash pack with many nameplates
4. Dungeon/raid boss target
5. Friendly target / party member target
6. PvP target if relevant to your use case

Recommended sequence:

1. `/mrp watch <your spec spell IDs>`
2. `/mrp scan`
3. Pull a dummy or pack
4. `/mrp scan` again
5. `/mrp nameplates`
6. `/mrp auras player HELPFUL`
7. `/mrp auras target HARMFUL`
8. `/mrp actionbars`
9. Optionally `/mrp pulse 1` during a short test pull

## Rotation-focused checklist

The addon is designed to help you validate all of these:

### Player state
- Health / max health / absorbs / incoming heals / heal absorbs
- Power / max power / current power type
- Secondary resources (combo points, holy power, chi, runes, soul shards, etc.)
- Current cast / current channel
- Helpful and harmful auras on the player
- Watched spell cooldowns, charges, usability, in-range checks
- Action bar state for occupied slots
- Spellbook enumeration (best effort)

### Target state
- Health / max health
- Cast / channel / interrupt state probes
- Helpful and harmful auras
- Threat and interact/range proxies where available
- GUID / NPC ID parsing for easier encounter testing

### Nearby enemies
- Active nameplate units only (`nameplate1..40`)
- For each: name, GUID, attackability, health, cast, aura samples

### Other unit tokens
- `focus`
- `mouseover`
- `targettarget`
- `pet`
- `boss1..5` (if present)
- `arena1..5` (if present)

## Notes

- This addon is intentionally diagnostic, not automated.
- Midnight can return opaque “secret” values that are displayable by Blizzard-provided UI paths but not safely comparable or computable in addon Lua.
- The probe therefore logs what *actually happens* on your live client/build/spec/content instead of assuming the answer.
