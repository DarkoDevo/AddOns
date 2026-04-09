-- Options_All.lua — panneau unique “WoW Memory+” (scroll), safe UI widgets

WoWMemory       = WoWMemory or {}
WoWMemoryConfig = WoWMemoryConfig or {}

local function L(k) return (WoWMemory and WoWMemory.L and WoWMemory.L(k)) or k end

-- Helpers --------------------------------------------------------------------
local function ensure(tbl, key, default) if tbl[key]==nil then tbl[key]=default end return tbl[key] end
local function ensureSub(tbl, key) tbl[key]=tbl[key] or {} return tbl[key] end
local function Apply(which) if WoWMemory and WoWMemory.ApplyConfigChange then WoWMemory.ApplyConfigChange(which) end end

-- Accent helpers --------------------------------------------------------------
local function AccentRGB(key)
  if     key=="emerald" then return 0.10,0.70,0.45
  elseif key=="blue"    then return 0.18,0.45,0.95
  elseif key=="purple"  then return 0.60,0.35,0.95
  elseif key=="gold"    then return 0.95,0.75,0.20
  elseif key=="red"     then return 0.92,0.26,0.26
  elseif key=="orange"  then return 0.96,0.56,0.20
  elseif key=="teal"    then return 0.10,0.70,0.65
  elseif key=="pink"    then return 0.95,0.42,0.66
  elseif key=="gray"    then return 0.60,0.65,0.70
  else return 0.10,0.70,0.45 end
end

-- Widgets sûrs (pas de .Text implicite) --------------------------------------
local function MakeCheck(parent, label, get, set, x, y)
  local cb = CreateFrame("CheckButton", nil, parent, "ChatConfigCheckButtonTemplate")
  cb:SetPoint("TOPLEFT", x or 16, y or -36)

  -- Label manuel
  local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  fs:SetPoint("LEFT", cb, "RIGHT", 6, 0)
  fs:SetText(label)
  cb._label = fs
  cb:SetHitRectInsets(0, -fs:GetStringWidth()-10, 0, 0)

  cb:SetScript("OnShow", function(self) self:SetChecked(get() and true or false) end)
  cb:SetScript("OnClick", function(self) set(self:GetChecked() and true or false) end)
  return cb
end

local function MakeSlider(parent, label, minV, maxV, step, get, set, x, y)
  local s = CreateFrame("Slider", nil, parent, "OptionsSliderTemplate")
  s:SetPoint("TOPLEFT", x or 16, y or -36)
  s:SetMinMaxValues(minV, maxV)
  s:SetValueStep(step or 1)
  s:SetObeyStepOnDrag(true)
  s:SetWidth(280)

  -- Certains clients ne créent pas ces champs pour les sliders anonymes
  if not s.Text then
    s.Text = s:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    s.Text:SetPoint("BOTTOM", s, "TOP", 0, 0)
  end
  if not s.Low then
    s.Low = s:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    s.Low:SetPoint("TOPLEFT", s, "BOTTOMLEFT", 0, 0)
  end
  if not s.High then
    s.High = s:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    s.High:SetPoint("TOPRIGHT", s, "BOTTOMRIGHT", 0, 0)
  end

  s.Text:SetText(label)
  s.Low:SetText(tostring(minV))
  s.High:SetText(tostring(maxV))

  s:SetScript("OnShow", function(self) self:SetValue(get() or minV) end)
  s:SetScript("OnValueChanged", function(_, v) set(v) end)
  return s
end

local function MakeEdit(parent, label, w, get, set, x, y)
  local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  fs:SetPoint("TOPLEFT", x or 16, y or -36); fs:SetText(label)
  local e = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
  e:SetPoint("TOPLEFT", fs, "BOTTOMLEFT", 0, -4); e:SetAutoFocus(false); e:SetSize(w or 340, 24)
  e:SetScript("OnShow", function(self) self:SetText(get() or "") end)
  e:SetScript("OnEnterPressed", function(self) set(self:GetText() or ""); self:ClearFocus() end)
  return e
end

local function MakeSmallBtn(parent, label, click, x, y)
  local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
  b:SetPoint("TOPLEFT", x or 16, y or -36); b:SetText(label); b:SetWidth(160)
  b:SetScript("OnClick", click)
  return b
end

-- Radios de langue sûres ------------------------------------------------------
local function MakeLangRadios(parent, x, y)
  parent._langRadios = parent._langRadios or {}
  local opts = {
    { label = L("LANGUAGE_AUTO")    or "Auto",     value="auto" },
    { label = L("LANGUAGE_FRENCH")  or "Français", value="fr"   },
    { label = L("LANGUAGE_ENGLISH") or "English",  value="en"   },
  }
  local px, py = x or 16, y or -36
  for i,opt in ipairs(opts) do
    local b = CreateFrame("CheckButton", nil, parent, "UIRadioButtonTemplate")
    b:SetPoint("TOPLEFT", px + (i-1)*120, py)
    b.value = opt.value

    local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    fs:SetPoint("LEFT", b, "RIGHT", 6, 0)
    fs:SetText(opt.label)
    b._label = fs
    b:SetHitRectInsets(0, -fs:GetStringWidth()-10, 0, 0)

    b:SetScript("OnClick", function(self)
      for _,r in ipairs(parent._langRadios or {}) do r:SetChecked(false) end
      self:SetChecked(true)
      WoWMemoryConfig.language = self.value
      if WoWMemory and WoWMemory.SetLanguage then WoWMemory.SetLanguage(self.value) end
      Apply("rerender")
    end)
    table.insert(parent._langRadios, b)
  end
  parent:HookScript("OnShow", function(self)
    local cur = (WoWMemoryConfig and WoWMemoryConfig.language) or "auto"
    for _,r in ipairs(self._langRadios or {}) do r:SetChecked(r.value == cur) end
  end)
end

-- Radio générique (rafraîchissement) -----------------------------------------
local function MakeRadio(parent, label, value, x, y)
  local b = CreateFrame("CheckButton", nil, parent, "UIRadioButtonTemplate")
  b:SetPoint("TOPLEFT", x or 16, y or 0)
  b.value = value

  local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  fs:SetPoint("LEFT", b, "RIGHT", 6, 0)
  fs:SetText(label)
  b._label = fs
  b:SetHitRectInsets(0, -fs:GetStringWidth()-10, 0, 0)

  b:SetScript("OnClick", function(self)
    for _, r in ipairs(parent._radios or {}) do r:SetChecked(false) end
    self:SetChecked(true)
    WoWMemoryConfig.refresh = WoWMemoryConfig.refresh or {}
    WoWMemoryConfig.refresh.mode = self.value
    if WMP_ApplyRefreshMode then WMP_ApplyRefreshMode() end
    Apply("refresh")
  end)
  return b
end

-- Construction du panneau unique ---------------------------------------------
local function BuildPanels()
  local cfg = WoWMemoryConfig
  ensureSub(cfg, "mini");            ensure(cfg.mini, "shown", true)
  ensure(cfg, "showIlvl", true);     ensure(cfg, "compact", false); ensure(cfg, "showSeconds", false)
  ensure(cfg, "alpha", 0.92);        ensure(cfg, "scale", 1.0);     ensure(cfg, "fontP", 13)
  ensure(cfg, "accent", "emerald")
  ensureSub(cfg, "refresh");         ensure(cfg.refresh, "mode", "smart"); ensure(cfg.refresh, "every", 10)
  ensureSub(cfg, "optText");         ensure(cfg.optText, "currencies", "1602,1792"); ensure(cfg.optText, "materials", "")
  ensureSub(cfg, "collections");     ensure(cfg.collections, "mounts",""); ensure(cfg.collections, "toys",""); ensure(cfg.collections,"pets","")
  ensure(cfg, "language", cfg.language or "auto")
  ensureSub(cfg, "tabs")
  local TAB_KEYS = {"dungeons","week","quests","resources","worldq","chars","journal","collect","calendar","ah"}
  for _,k in ipairs(TAB_KEYS) do if cfg.tabs[k]==nil then cfg.tabs[k]=true end end

  local main = CreateFrame("Frame", "WoWMemory_Options_AllInOne", UIParent)
  main.name = L("app_title") or "WoW Memory+"

  local scroll = CreateFrame("ScrollFrame", nil, main, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT", 12, -12)
  scroll:SetPoint("BOTTOMRIGHT", -28, 12)
  local content = CreateFrame("Frame", nil, scroll)
  content:SetSize(860, 10)
  scroll:SetScrollChild(content)

  local y = -4
  local function H(title)
    local fs = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    fs:SetPoint("TOPLEFT", 8, y); fs:SetText(title)
    y = y - fs:GetStringHeight() - 6
    local line = content:CreateTexture(nil, "ARTWORK")
    line:SetColorTexture(1,1,1,0.10); line:SetPoint("TOPLEFT", 8, y); line:SetPoint("TOPRIGHT", -8, y); line:SetHeight(1)
    y = y - 12
  end

  -- Général -------------------------------------------------------------------
  H(L("opt_nav_general") or "General")
  MakeCheck(content, L("opt_mini") or "Show minimap button",
    function() return cfg.mini.shown end,
    function(v) cfg.mini.shown = v; Apply("minimap") end, 16, y)
  y = y - 28

  MakeCheck(content, L("opt_show_ilvl") or "Show iLvl in 'Characters'",
    function() return cfg.showIlvl end,
    function(v) cfg.showIlvl = v; Apply("rerender") end, 16, y)
  y = y - 28

  MakeCheck(content, L("opt_compact") or "Compact mode (reduced spacing)",
    function() return cfg.compact end,
    function(v) cfg.compact = v; Apply("rerender") end, 16, y)
  y = y - 28

  MakeCheck(content, L("opt_seconds") or "Show seconds in durations",
    function() return cfg.showSeconds end,
    function(v) cfg.showSeconds = v; Apply("rerender") end, 16, y)
  y = y - 36

  -- Langue --------------------------------------------------------------------
  local fsLang = content:CreateFontString(nil,"OVERLAY","GameFontNormal")
  fsLang:SetPoint("TOPLEFT", 320, -18); fsLang:SetText(L("LANGUAGE") or "Language")
  MakeLangRadios(content, 320, -36)

  -- Apparence -----------------------------------------------------------------
  H(L("opt_nav_appearance") or "Appearance")
  MakeSlider(content, L("opt_alpha") or "Background opacity", 0.60, 1.00, 0.01,
    function() return cfg.alpha end,
    function(v) cfg.alpha = v; Apply("theme") end, 16, y)
  y = y - 50

  MakeSlider(content, L("opt_scale") or "UI scale", 0.85, 1.25, 0.01,
    function() return cfg.scale end,
    function(v) cfg.scale = v; Apply("theme") end, 16, y)
  y = y - 50

  MakeSlider(content, L("opt_font") or "Font size", 10, 18, 1,
    function() return cfg.fontP end,
    function(v) cfg.fontP = v; Apply("fonts") end, 16, y)
  y = y - 40

  -- Couleur d’accent ----------------------------------------------------------
  local fsAccent = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  fsAccent:SetPoint("TOPLEFT", 16, y); fsAccent:SetText(L("opt_accent") or "Accent color :")
  y = y - 20

  content._accentRadios = {}
  local accents = {
    {"emerald", L("opt_accent_emerald") or "Emerald"},
    {"blue",    L("opt_accent_blue")    or "Blue"},
    {"purple",  L("opt_accent_purple")  or "Purple"},
    {"gold",    L("opt_accent_gold")    or "Gold"},
    {"red",     L("opt_accent_red")     or "Red"},
    {"orange",  L("opt_accent_orange")  or "Orange"},
    {"teal",    L("opt_accent_teal")    or "Teal"},
    {"pink",    L("opt_accent_pink")    or "Pink"},
    {"gray",    L("opt_accent_gray")    or "Gray"},
  }
  local startY = y
  local function MakeAccentRadioRow(parent, key, label, col, row)
    local startX = 16
    local cellW, cellH = 160, 26
    local xx = startX + (col-1)*cellW
    local yy = startY - (row-1)*cellH
    local b = CreateFrame("CheckButton", nil, parent, "UIRadioButtonTemplate")
    b:SetPoint("TOPLEFT", xx, yy); b.value = key
    local r,g,b2 = AccentRGB(key)
    local sw = parent:CreateTexture(nil, "ARTWORK")
    sw:SetColorTexture(r,g,b2, 1); sw:SetPoint("LEFT", b, "RIGHT", 6, 0); sw:SetSize(18, 18); sw:SetTexCoord(0.02,0.98,0.02,0.98)
    local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); fs:SetPoint("LEFT", sw, "RIGHT", 6, 0); fs:SetText(label)
    b:SetScript("OnClick", function(self)
      for _,rbtn in ipairs(parent._accentRadios or {}) do rbtn:SetChecked(false) end
      self:SetChecked(true); cfg.accent = self.value; Apply("theme")
    end)
    return b
  end
  for i,it in ipairs(accents) do
    local col = ((i-1)%3) + 1
    local row = math.floor((i-1)/3) + 1
    local btn = MakeAccentRadioRow(content, it[1], it[2], col, row)
    table.insert(content._accentRadios, btn)
  end
  content:HookScript("OnShow", function(self)
    local cur = cfg.accent or "emerald"
    for _,rbtn in ipairs(self._accentRadios or {}) do rbtn:SetChecked(rbtn.value == cur) end
  end)
  y = startY - (math.ceil(#accents/3)*26) - 12

  -- Rafraîchissement ----------------------------------------------------------
  H(L("opt_nav_refresh") or "Refresh")
  content._radios = {}
  content._radios[1] = MakeRadio(content, L("opt_mode_smart")  or "Mode: Smart", "smart",    16, y)
  content._radios[2] = MakeRadio(content, L("opt_mode_rt")     or "Real-time",   "realtime", 200, y)
  content._radios[3] = MakeRadio(content, L("opt_mode_manual") or "Manual",      "manual",   384, y)
  content:HookScript("OnShow", function(self)
    local cur = (cfg.refresh and cfg.refresh.mode) or "smart"
    for _,r in ipairs(self._radios or {}) do r:SetChecked(r.value == cur) end
  end)
  y = y - 32

  MakeSlider(content, L("opt_every_sec") or "Every X seconds (real-time)", 2, 60, 1,
    function() return (cfg.refresh and cfg.refresh.every) or 10 end,
    function(v) cfg.refresh = cfg.refresh or {}; cfg.refresh.every = v; if WMP_ApplyRefreshMode then WMP_ApplyRefreshMode() end end,
    16, y)
  y = y - 50

  -- Économie ------------------------------------------------------------------
  H(L("opt_nav_economy") or "Economy")
  MakeEdit(content, L("opt_currencies") or "Currency IDs (e.g. 1602,1792)", 360,
    function() return (cfg.optText and cfg.optText.currencies) or "" end,
    function(txt)
      cfg.optText = cfg.optText or {}; cfg.optText.currencies = txt or ""
      Apply("rerender")
    end, 16, y)
  y = y - 50

  MakeEdit(content, L("opt_mats") or "Materials (itemID:threshold, ...)", 360,
    function() return (cfg.optText and cfg.optText.materials) or "" end,
    function(txt)
      cfg.optText = cfg.optText or {}; cfg.optText.materials = txt or ""
      Apply("rerender")
    end, 16, y)
  y = y - 50

  -- Collections ---------------------------------------------------------------
  H(L("opt_nav_collections") or "Collections")
  MakeEdit(content, L("opt_col_mounts") or "Mounts (IDs)", 360,
    function() return (cfg.collections and cfg.collections.mounts) or "" end,
    function(v) ensureSub(cfg, "collections").mounts = v or "" end, 16, y)
  y = y - 40

  MakeEdit(content, L("opt_col_toys") or "Toys (IDs)", 360,
    function() return (cfg.collections and cfg.collections.toys) or "" end,
    function(v) ensureSub(cfg, "collections").toys = v or "" end, 16, y)
  y = y - 40

  MakeEdit(content, L("opt_col_pets") or "Pets (Species IDs)", 360,
    function() return (cfg.collections and cfg.collections.pets) or "" end,
    function(v) ensureSub(cfg, "collections").pets = v or "" end, 16, y)
  y = y - 50

  -- Fenêtre -------------------------------------------------------------------
  H(L("opt_nav_window") or "Window")
  MakeCheck(content, L("opt_window_lock") or "Lock window position",
    function() return cfg.windowLocked end,
    function(v) cfg.windowLocked = v end, 16, y)
  y = y - 28

  MakeSmallBtn(content, L("opt_window_center") or "Center window", function()
    if WoWMemory and WoWMemory.ResetWindowPos then WoWMemory.ResetWindowPos() end
  end, 16, y)
  MakeSmallBtn(content, L("opt_reset_addon") or "Reset size", function()
    if WoWMemory and WoWMemory.ResetWindowSize then WoWMemory.ResetWindowSize() end
  end, 200, y)
  y = y - 40

  -- Onglets (afficher/masquer) -----------------------------------------------
  H(L("opt_nav_tabs") or "Tabs")
  local labelsByKey = {
    dungeons = L("tab_dungeons")   or "Dungeons / Raids",
    week     = L("tab_week")       or "This Week",
    quests   = L("tab_quests")     or "Quests",
    resources= L("tab_resources")  or "Resources",
    worldq   = L("tab_worldq")     or "World Quests",
    chars    = L("tab_chars")      or "Characters",
    journal  = L("tab_journal")    or "Journal",
    collect  = L("tab_collect")    or "Collections",
    calendar = L("tab_calendar")   or "Calendar",
    ah       = L("tab_ah")         or "AH",
  }
  local col = 0
  for i,key in ipairs(TAB_KEYS) do
    col = col + 1
    local xx = 16 + (col-1)*220
    MakeCheck(content, (labelsByKey[key] or key).." — "..(L("opt_tab_show") or "show"),
      function() return cfg.tabs[key] ~= false end,
      function(v) cfg.tabs[key] = v and true or false; Apply("tabs") end, xx, y)
    if col == 3 then col = 0; y = y - 28 end
  end
  if col ~= 0 then y = y - 28 end

  -- Avancé --------------------------------------------------------------------
  H(L("opt_nav_advanced") or "Advanced")
  MakeSmallBtn(content, L("btn_refresh") or "Refresh", function()
    Apply("rerender")
  end, 16, y)
  y = y - 40

  content:SetHeight(-y + 10)

  -- Enregistrement dans le système d’options
  if Settings and Settings.RegisterCanvasLayoutCategory then
    local cat = Settings.RegisterCanvasLayoutCategory(main, main.name)
    cat.ID = cat.ID or math.random(100000)
    _G.WoWMemoryOptions_RootCategory = cat
    Settings.RegisterAddOnCategory(cat)
  elseif InterfaceOptions_AddCategory then
    InterfaceOptions_AddCategory(main)
  end
end

-- Construire une seule fois
if not _G.WoWMemory_Options_AllInOne_Built then
  _G.WoWMemory_Options_AllInOne_Built = true
  BuildPanels()
end
