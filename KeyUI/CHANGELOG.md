# KeyUI

## [v4.2.0](https://github.com/1onar/KeyUI/tree/v4.2.0) (2026-02-19)
[Full Changelog](https://github.com/1onar/KeyUI/compare/v4.1.1...v4.2.0) [Previous Releases](https://github.com/1onar/KeyUI/releases)

- refactor: replace toggle tab buttons with arrow-up dropdown menu on all frames  
    - Rename CreateArrowDownButton → CreateArrowUpButton with flipped TexCoords  
    - Mouse frame: menu opens upward via post-open reposition (BOTTOMRIGHT→TOPRIGHT)  
    - Add CreateToggleMenuButton for Keyboard/Controller: single arrow-up button  
      left of Options tab, dropdown with Background/ESC/Combat/Lock/Ghost  
    - All APIs (MenuUtil, GameTooltip\_SetTitle/AddNormalLine) verified compatible  
      across Classic Era, Cata, Wrath and Retail via /API  
    Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>  
- feat: add Action Bar Mode overlay with cooldown, usable, count, range  
    Adds live action bar state mirroring to key buttons via a single "Action  
    Bar Mode" toggle in the Controls panel:  
    - Cooldown swipe/countdown on action icons (CooldownFrameTemplate)  
    - Usable state: grey tint for wrong stance, blue for low mana  
    - Stack/charge count displayed bottom-right on icon  
    - Range indicator: keybind text turns red when target out of range  
    Bug fixes:  
    - Retail combat crash: pcall-guard secret-value cooldown comparisons  
    - Charge recovery swipe: GetActionCharges fallback when main CD is 0/0  
    - Overlays now initialized on open via resolve\_binding()  
    API\_COMPAT flags added: has\_modern\_action\_charges. Consolidates four  
    individual checkboxes into one show\_actionbar\_mode setting. Range checked  
    via 0.1s OnUpdate poll; other overlays event-driven.  
    Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>  
- refactor: stabilize refresh flow and add validation/pooling diagnostics  
    add strict profile/layout validation and settings normalization  
    introduce key button pooling and selective slot refresh fallback logic  
    add performance/diagnostic slash tooling and compatibility doc updates  
