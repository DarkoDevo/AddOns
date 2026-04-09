## Unholy DK Handoff

Date: 2026-04-09

### Source Of Truth

The active Unholy rotation source is:

`W:\CODE\Rotations\Deathknight\Deathknight_Unholy - v3.lua`

Do not treat `TellMeWhen.lua` as the source of truth. The user now uses an autobuilder and explicitly asked to stop all manual TMW syncing.

### Workflow Rules

- Do not recreate or use any manual sync-to-TMW flow.
- Do not touch `W:\WOW\World of Warcraft\_retail_\WTF\...\SavedVariables\TellMeWhen.lua` unless the user explicitly asks.
- The old sync script and backup artifacts were deleted on purpose.

### Manual Sync Cleanup Already Done

Removed:

- `W:\WOW\World of Warcraft\_retail_\Interface\AddOns\SimplyGlad\scripts\sync-unholy-to-tmw.ps1`
- `W:\WOW\World of Warcraft\_retail_\WTF\Account\305702212#2\SavedVariables\TellMeWhen.lua.bak`
- `W:\WOW\World of Warcraft\_retail_\WTF\Account\305702212#2\SavedVariables\TellMeWhen.lua.pre-restore-20260408-234811.bak`
- `W:\WOW\World of Warcraft\_retail_\WTF\Account\305702212#2\SavedVariables\TellMeWhen.lua.soulreaper-livefix-20260408-233436.bak`
- `W:\WOW\World of Warcraft\_retail_\WTF\Account\305702212#2\SavedVariables\TellMeWhen.lua.soulreaper-priority.bak`
- the now-empty `scripts` directory in this workspace

### Main Issue Still Open

The remaining bug is defensive behavior in the Unholy rotation.

Observed by user:

- player health dropped to about `55%`
- no defensive spells showed in the rotation

Important context:

- that health level should have been enough for at least some defensives based on the current Unholy profile values previously inspected from the live profile data:
  - `Death Strike = 65`
  - `Lichborne = 65`
  - `Anti-Magic Shell = 55`
  - `Death Pact = 45`
  - `Icebound Fortitude = 35`
- so `55%` not showing anything strongly suggests the runtime player-state read is still wrong or the defensive section is still being skipped

### Major Changes Already Made In The Unholy File

1. Fixed the Lua forward-reference issue for `tempSpellCooldown`.
- added a forward declaration
- changed the later definition to assignment
- this solved the earlier `attempt to call global 'tempSpellCooldown'` style runtime problem

2. Added direct cooldown helpers and cast-memory logic.
- `tempSpellCooldown`
- `GetTMWSpellCooldown`
- Soul Reaper cast memory and readiness helpers
- Army of the Dead cast memory and combat lockout helpers
- Dark Transformation cast memory and readiness helpers

3. Removed deprecated or unwanted offensive logic.
- removed active Unholy Assault usage and definition
- removed active Summon Gargoyle usage and related pooling logic

4. Added target-health fallback logic because probe data was showing secret or inaccessible target HP.
- `SafeHealthPercent`
- nameplate fallback
- direct health reads
- short-lived per-GUID health snapshots

5. Added a defensive lockout helper.
- `DefensiveSpellReady`
- used for `Death Pact`
- used for `Icebound Fortitude`
- later also wired into the earlier PvP auto-cast checks for `Icebound Fortitude` and `Lichborne`

6. Reworked player-only health/combat reads several times.
- first pass tried to use generic fallback logic for player and target
- later pass split player handling from target handling
- current state prefers direct `UnitHealth/UnitHealthMax` for player before trusting the Action engine percent helper
- current state also treats combat lockdown as a valid combat signal for entering the defensive section

### Why The Player Health Path Was Suspected

One earlier probe dump showed this mismatch:

- `action.player.healthPercent -> 100`
- `uhdk.player.healthPercent -> 0`

That strongly suggested the Action layer could still see the player state while the rotation's own derived `PlayerHealth` value was wrong.

### Current Relevant Landmarks In `Deathknight_Unholy - v3.lua`

All line numbers below refer to:

`W:\CODE\Rotations\Deathknight\Deathknight_Unholy - v3.lua`

- `SafeHealthPercent`: line `625`
- `GetPlayerCombatTime`: line `946`
- `RotationsVariables`: line `1136`
- `tempSpellCooldown`: line `1182`
- `CanEngageTarget`: line `1293`
- `DefensiveSpellReady`: line `1382`
- `SoulReaperReady`: line `1566`
- `ArmyoftheDeadReady`: line `1574`
- `EmitFallbackDebug`: line `1611`
- early PvP `Icebound Fortitude` gate: line `1989`
- early PvP `Lichborne` gate: line `1992`
- combat-gated defensive section starts around line `2011`
- `DeathPact` defensive check: line `2018`
- `Icebound Fortitude` defensive check: line `2021`

### Relevant Engine Context In This Workspace

Useful files if the next Codex needs to inspect the Action/Makulu side:

- `W:\WOW\World of Warcraft\_retail_\Interface\AddOns\SimplyGlad\Modules\Engines\Unit.lua`
- `W:\WOW\World of Warcraft\_retail_\Interface\AddOns\SimplyGlad\Modules\Engines\Combat.lua`
- `W:\WOW\World of Warcraft\_retail_\Interface\AddOns\SimplyGlad\Action.lua`

Important engine behavior already inspected:

- `Unit.lua` has a `HealthPercent` path that can return `100` for a living unit if direct values are not usable
- `Combat.lua` has player combat fallback logic using `InCombatLockdown()` and `UnitAffectingCombat()`

That is why the Unholy file was changed to trust direct player health first and to fall back to combat lockdown for defensive gating.

### What Was Tested

- Lua parse check was run after edits using:
  - `W:\Lua\5.1\luac.exe -p W:\CODE\Rotations\Deathknight\Deathknight_Unholy - v3.lua`
- parse was passing after the latest edits

### Best Next Step

The next Codex should probably stop guessing and add a short, throttled debug line near the defensive block in `A[3]` that prints:

- `PlayerHealth`
- `combatTime`
- `playerCombatActive`
- `GetToggle(2, "DeathStrikeSlider")`
- `GetToggle(2, "LichborneSlider")`
- `GetToggle(2, "AntiMagicShellSlider")`
- readiness of `DeathStrike`, `Lichborne`, `AMS`, `DeathPact`, and `Icebound Fortitude`

That should make it obvious whether:

- the player HP is still wrong
- combat gating is still false
- the spell-ready checks are the actual blocker

### User Preference Notes

- user is okay with direct code changes
- user does not want to keep being asked to manually sync into TMW
- user wants the autobuilder workflow respected
