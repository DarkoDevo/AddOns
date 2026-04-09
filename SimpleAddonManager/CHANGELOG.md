# Simple Addon Manager

## [v1.62](https://github.com/Eliote/SimpleAddonManager/tree/v1.62) (2026-03-22)
[Full Changelog](https://github.com/Eliote/SimpleAddonManager/compare/v1.61...v1.62) [Previous Releases](https://github.com/Eliote/SimpleAddonManager/releases)

- Add profile selection to the addon list right-click menu  
    https://github.com/Eliote/SimpleAddonManager/issues/72  
- Migrate the addon list right-click menu to the new implementation  
- Fix unselected addons showing in profile menu  
    Make sure the addon is actually enabled for the profile before listing or counting it.  
    This was only a visual bug, loading a profile already accounted for it  
