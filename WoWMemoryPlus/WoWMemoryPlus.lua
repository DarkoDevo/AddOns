-- WoW Memory+ — main file (v0.7.x restored + safeties)
-- Toutes les options sont dans Interface → AddOns (via Options_All.lua)

----------------------------------------------------------------
-- LOCALISATION (wrapper local pratique)
----------------------------------------------------------------
WoWMemory = WoWMemory or {}

local ui = { tabs = {} }
local function L(k)
  return (WoWMemory and WoWMemory.L and WoWMemory.L(k)) or k
end

----------------------------------------------------------------
-- CONFIG & DB
----------------------------------------------------------------
local function ShallowCopy(tbl) if type(tbl)~="table" then return tbl end local t={} for k,v in pairs(tbl) do t[k]=v end return t end

local CFG_DFLT = {
  alpha=0.92, scale=1.00, fontP=13, showSeconds=false,
  pos={ point="CENTER", x=0, y=0 },
  size={ w=760, h=520 },
  lastTab=2,
  mini={ shown=true, angle=210 },
  charSort="ilvl", showIlvl=true, compact=false, accent="emerald",
  journal={ type="all", char="all", days=7 },
  resourcesUI = { profFilter="all", profSort="progress" },

  -- Visibilité par onglet (true=visible)
  tabs = {
    dungeons = true,
    week     = true,
    quests   = true,
    resources= true,
    worldq   = true,
    chars    = true,
    journal  = true,
    collect  = true,
    calendar = true,
    ah       = true,
  },

  worldBosses = {
    { name="Kordac, the Dormant Protector", zone="Isle of Dorn", questID=nil },
    { name="Aggregation of Horrors",        zone="Ringing Deeps", questID=nil },
    { name="Shurrai, Atrocity of the Undersea", zone="Hallowfall", questID=nil },
    { name="Orta, the Broken Mountain",     zone="Azj-Kahet", questID=nil },
  },
  track = { currencies = {1602,1792}, materials = {} },
  briefing = { showOnLogin=false },
  refresh = { mode="smart", every=10 },
  language = "auto",
}

WoWMemoryConfig = WoWMemoryConfig or ShallowCopy(CFG_DFLT)
local function CFG()
  WoWMemoryConfig = WoWMemoryConfig or {}
  for k,v in pairs(CFG_DFLT) do
    if WoWMemoryConfig[k]==nil then
      WoWMemoryConfig[k] = type(v)=="table" and ShallowCopy(v) or v
    end
  end
  for k,v in pairs(CFG_DFLT) do
    if type(v)=="table" then
      WoWMemoryConfig[k] = WoWMemoryConfig[k] or {}
      for kk,vv in pairs(v) do if WoWMemoryConfig[k][kk]==nil then WoWMemoryConfig[k][kk]=vv end end
    end
  end
  return WoWMemoryConfig
end

local currentKey
local function DBInit()
  WoWMemoryDB = WoWMemoryDB or {}

  local name  = UnitName("player") or "?"
  local realm = GetRealmName() or "?"
  currentKey = realm .. "-" .. name

  WoWMemoryDB[currentKey] = WoWMemoryDB[currentKey] or {}

  local d = WoWMemoryDB[currentKey]
  d.Chars     = d.Chars     or {}
  d.char      = d.char      or {}
  d.activity  = d.activity  or {}
  d.ledger    = d.ledger    or {}
  d.resources = d.resources or {}
  d.dungeons  = d.dungeons  or {}
  d.quests    = d.quests    or {}
  d.weekly    = d.weekly    or {}
end

  -- Assurer la présence de toutes les clés de visibilité des onglets
  WoWMemoryConfig.tabs = WoWMemoryConfig.tabs or {}
  local _tabKeys = {"dungeons","week","quests","resources","worldq","chars","journal","collect","calendar","ah"}
  for _,k in ipairs(_tabKeys) do
    if WoWMemoryConfig.tabs[k] == nil then WoWMemoryConfig.tabs[k] = true end
  end

local function DB()
  DBInit()
  return WoWMemoryDB[currentKey]
end

----------------------------------------------------------------
-- UTILS
----------------------------------------------------------------
local function Clamp(x,a,b) if x<a then return a elseif x>b then return b else return x end end
local function TryCall(fn, ...) return (type(fn)=="function") and fn(...) or nil end


local function TryCall(fn, ...) if type(fn)~="function" then return end local ok,a,b,c,d=pcall(fn,...) if ok then return a,b,c,d end end
local function Clamp(v,a,b) if v<a then return a elseif v>b then return b else return v end end
local function PrettyTime(secs)
  secs=tonumber(secs or 0) or 0
  if CFG().showSeconds and SecondsToTime then return SecondsToTime(secs) end
  local d=math.floor(secs/86400); secs=secs%86400
  local h=math.floor(secs/3600);  secs=secs%3600
  local m=math.floor(secs/60)
  local t={}
  if d>0 then t[#t+1]=d.."d" end
  if h>0 then t[#t+1]=h.."h" end
  if m>0 and d==0 then t[#t+1]=m.."m" end
  return (#t>0) and table.concat(t," ") or "0m"
end

local ICON_G = "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12:0:0|t"
local ICON_S = "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0|t"
local ICON_C = "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t"

local function FormatMoneyFR(copper, opts)
  local v = tonumber(copper or 0) or 0
  local sign = ""
  if opts and opts.signed then
    if v < 0 then sign = "-" ; v = -v else sign = "+" end
  elseif v < 0 then v = -v end
  local g  = math.floor(v / 10000)
  local s  = math.floor((v % 10000) / 100)
  local c  = v % 100
  local parts = {}
  if g > 0        then parts[#parts+1] = string.format("%d%s", g, ICON_G) end
  if s > 0 or g>0 then parts[#parts+1] = string.format("%d%s", s, ICON_S) end
  parts[#parts+1] = string.format("%d%s", c, ICON_C)
  local txt = (sign ~= "" and (sign.." ") or "") .. table.concat(parts, " ")
  if opts and opts.colored and sign ~= "" then
    local color = (sign == "+") and "|cff88ff88" or "|cffff8888"
    return color .. txt .. "|r"
  end
  return txt
end
local function FormatGold(copper) return FormatMoneyFR(copper) end

-- Accent color
local function GetAccentRGB()
  local a = (CFG().accent or "emerald")
  if     a == "blue"    then return 0.18, 0.45, 0.95
  elseif a == "purple"  then return 0.60, 0.35, 0.95
  elseif a == "gold"    then return 0.95, 0.75, 0.20
  elseif a == "emerald" then return 0.10, 0.70, 0.45
  elseif a == "red"     then return 0.92, 0.26, 0.26
  elseif a == "orange"  then return 0.96, 0.56, 0.20
  elseif a == "teal"    then return 0.10, 0.70, 0.65
  elseif a == "pink"    then return 0.95, 0.42, 0.66
  elseif a == "gray"    then return 0.60, 0.65, 0.70
  else                       return 0.10, 0.70, 0.45
  end
end

local function ParseCurrenciesText(txt) local ids={} for id in tostring(txt or ""):gmatch("(%d+)") do ids[#ids+1]=tonumber(id) end return ids end
local function ParseMaterialsText(txt) local mats={} for pair in tostring(txt or ""):gmatch("([^,]+)") do local id,need=pair:match("(%d+)%s*:%s*(%d+)") if id and need then mats[tonumber(id)]=tonumber(need) end end return mats end
local function ParseWorldBossesText(txt) local out={} ; for pair in tostring(txt or ""):gmatch("([^,]+)") do local name,id = pair:match("^%s*(.-)%s*:%s*(%d+)%s*$") if name and id then out[#out+1]={ name=name, questID=tonumber(id) } end end ; return out end

local function LogActivity(kind, text)
  local A = DB().activity or {}
  A[#A+1] = { ts = (time and time() or 0), type = tostring(kind or "?"), text = tostring(text or "") }
  if #A>500 then for i=1,(#A-500) do table.remove(A,1) end end
  DB().activity = A
end

-- Affixes (fallback robuste)
if not GetCurrentAffixNames then
  function GetCurrentAffixNames()
    local names = {}
    local aff = TryCall(C_MythicPlus and C_MythicPlus.GetCurrentAffixes) or {}
    if type(aff) == "table" then
      for _, a in ipairs(aff) do
        local id = a.id or a.affixID
        local name = nil
        if C_ChallengeMode and C_ChallengeMode.GetAffixInfo and id then
          name = select(1, C_ChallengeMode.GetAffixInfo(id))
        end
        name = name or a.name or ("Affix "..tostring(id or "?"))
        names[#names+1] = name
      end
    end
    return (#names > 0) and table.concat(names, " / ") or "—"
  end
end

----------------------------------------------------------------
-- EXPORT (texte)
----------------------------------------------------------------
local function BuildExportText()
  local d=DB(); local lines={}
  lines[#lines+1]=L("xp_title")
  lines[#lines+1]=string.rep("-",30)
  local c=d.char or {}
  lines[#lines+1]=string.format(L("xp_char"), c.name or "?", c.realm or "?", tostring(c.level or "?"), tostring(c.ilvl or "?"))
  local w=d.weekly or {}; local v=w.vault or {}
  lines[#lines+1]=string.format(L("xp_vault"),
    v.raid and v.raid.done or 0, v.raid and v.raid.total or 0,
    v.mplus and v.mplus.done or 0, v.mplus and v.mplus.total or 0,
    v.pvp and v.pvp.done or 0, v.pvp and v.pvp.total or 0)
  lines[#lines+1]=string.format(L("xp_best"), tostring(w.bestMPlus or 0))
  lines[#lines+1]=L("xp_wboss").." "..(w.worldBossDone and L("ch_ok") or "—")
  local R=d.resources or {}
  lines[#lines+1]=L("xp_gold").." "..FormatGold(R.gold or 0)
  lines[#lines+1]="" ; lines[#lines+1]=L("xp_active_quests")
  for _,q in ipairs(d.quests or {}) do lines[#lines+1]="- "..(q.title or ("Quest "..tostring(q.id or "?"))) end
  return table.concat(lines,"\n")
end

----------------------------------------------------------------
-- LEDGER (gold history) + ECONOMIE
----------------------------------------------------------------
local function Ledger_Init()
  local d = DB()
  d.ledger = d.ledger or {}
  d.ledger.last = tonumber(d.ledger.last) or (GetMoney() or 0)
  if type(d.ledger.history) ~= "table" then d.ledger.history = {} end
end

local function Ledger_OnMoneyChanged()
  local d = DB()
  d.ledger = d.ledger or {}
  d.ledger.last = tonumber(d.ledger.last) or (GetMoney() or 0)
  if type(d.ledger.history) ~= "table" then d.ledger.history = {} end

  local now = time and time() or 0
  local cur = GetMoney() or 0
  local last = d.ledger.last or cur
  local delta = cur - last

  if delta ~= 0 then
    d.ledger.history[#d.ledger.history + 1] = { ts = now, delta = delta, after = cur }
    while #d.ledger.history > 200 do table.remove(d.ledger.history, 1) end
    d.ledger.last = cur
  end
end

local function ScanEconomy()
  local R = DB().resources or {}
  R.gold = GetMoney and GetMoney() or 0
  R.currencies = {}
  for _,cid in ipairs(CFG().track.currencies or {}) do
    local info = TryCall(C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo, cid)
    if type(info)=="table" then
      R.currencies[cid] = { name = info.name or ("Currency "..cid), quantity = info.quantity or 0, icon=info.iconFileID }
    end
  end
  R.mats = {}
  for itemID,_ in pairs(CFG().track.materials or {}) do
    local qty = (GetItemCount and GetItemCount(itemID, true)) or 0
    R.mats[itemID] = qty
  end
  DB().resources = R
end
----------------------------------------------------------------
-- PERSONNAGE (nom, realm, niveau, classe, iLvl)
----------------------------------------------------------------
local function ScanCharacter()
  local d = DB().char or {}
  d.name  = UnitName("player")
  d.realm = GetRealmName()
  if UnitClass then d.class = select(2, UnitClass("player")) end
  if UnitLevel then d.level = UnitLevel("player") end
  if GetAverageItemLevel then
    local avg, equipped = GetAverageItemLevel()
    local val = equipped or avg or 0
    if type(val) == "number" then d.ilvl = math.floor(val + 0.5) end
  end
  DB().char = d
end

----------------------------------------------------------------
-- SCANS (weekly, lockouts, quests, world quests)
----------------------------------------------------------------
local function ScanLockouts()
  DB().dungeons = {}
  local n = GetNumSavedInstances and (GetNumSavedInstances() or 0) or 0
  for i=1,n do
    local name,_,reset,_,locked,extended,_,isRaid,maxPlayers,diffName = GetSavedInstanceInfo(i)
    if locked or extended then
      table.insert(DB().dungeons, { name=name or "?", reset=reset or 0, diffName=diffName or (isRaid and "Raid" or "Dungeon"), maxPlayers=maxPlayers or 0 })
    end
  end
end

local function WeeklyResetSeconds() local s = TryCall(C_DateAndTime and C_DateAndTime.GetSecondsUntilWeeklyReset) return (s and s>0) and s or (3*24*60*60) end

local function DetectWorldBossKilledThisWeek()
  local n = TryCall(GetNumSavedWorldBosses) or 0
  if n>0 then for i=1,n do local _,_,reset = GetSavedWorldBossInfo(i) if reset and reset>0 then return true end end return false end
  return nil
end

local function ScanWeekly()
  local d = DB()
  d.weekly = d.weekly or {}
  local w = d.weekly

  w.lastScan = time and time() or 0
  if C_WeeklyRewards and C_WeeklyRewards.RequestInfo then
    C_WeeklyRewards.RequestInfo()
  end

  w.vault = {
    raid  = { done = 0, total = 0, thresholds = {} },
    mplus = { done = 0, total = 0, thresholds = {} },
    pvp   = { done = 0, total = 0, thresholds = {} },
  }

  local acts = TryCall(C_WeeklyRewards and C_WeeklyRewards.GetActivities)
  if type(acts) == "table" then
    for _, a in ipairs(acts) do
      local info = TryCall(C_WeeklyRewards and C_WeeklyRewards.GetActivityInfo, a.id or a.activityID) or a
      local t  = a.type or a.activityType
      local p  = (info and info.progress) or a.progress or 0
      local th = (info and info.threshold) or a.threshold or 0

      local bucket =
        (t == 1 or t == "Raid") and w.vault.raid or
        (t == 2 or t == "MythicPlus") and w.vault.mplus or
        (t == 3 or t == "PvP") and w.vault.pvp or nil

      if bucket then
        bucket.done = math.max(bucket.done or 0, p or 0)
        if th and th > 0 then
          bucket.thresholds[th] = true
        end
      end
    end

    local function finalize(b)
      local arr = {}
      for th in pairs(b.thresholds or {}) do
        arr[#arr + 1] = th
      end
      table.sort(arr)
      b.thresholds = arr
      b.total = arr[#arr] or 0
    end

    finalize(w.vault.raid)
    finalize(w.vault.mplus)
    finalize(w.vault.pvp)
  end

  local best = 0
  local hist = TryCall(C_MythicPlus and C_MythicPlus.GetRunHistory, false, true)
  if type(hist) == "table" then
    for _, r in ipairs(hist) do
      best = math.max(best, r.level or 0)
    end
  else
    local b = TryCall(C_MythicPlus and C_MythicPlus.GetWeeklyBestLevel)
    if type(b) == "number" then
      best = b
    end
  end

  w.bestMPlus = best or 0

  local auto = DetectWorldBossKilledThisWeek()
  if auto ~= nil then
    w.worldBossDone = auto
  end

  w.professions = w.professions or { crafts = false, quests = false }
  w.worldManual = w.worldManual or { p1 = false, p4 = false, p8 = false }
end

local function ScanQuests()
  DB().quests = {}
  local logCount = C_QuestLog and C_QuestLog.GetNumQuestLogEntries and C_QuestLog.GetNumQuestLogEntries() or 0
  for i=1,logCount do
    local info = C_QuestLog.GetInfo and C_QuestLog.GetInfo(i) or nil
    if info and not info.isHeader and info.questID then
      local qid = info.questID
      local objectives={}
      local obj = C_QuestLog.GetQuestObjectives and C_QuestLog.GetQuestObjectives(qid)
      if type(obj)=="table" then for _,o in ipairs(obj) do local line = o.text or "?" if o.numFulfilled and o.numRequired then line = line .. (" (%d/%d)"):format(o.numFulfilled, o.numRequired) end objectives[#objectives+1]=line end end
      DB().quests[#DB().quests+1] = { id=qid, title=info.title or ("Quest "..qid), zone=info.campaignName or info.header or "", objectives=objectives, }
    end
  end
end


-- World Quests
local function GatherWorldQuestsForMap(mapID, zoneName)
  local out = {}
  if not (C_TaskQuest and C_TaskQuest.GetQuestsForPlayerByMapID) then return out end
  local tasks = C_TaskQuest.GetQuestsForPlayerByMapID(mapID) or {}
  for _,t in ipairs(tasks) do
    local qid = t.questId or t.questID
    if qid and (C_QuestLog and C_QuestLog.IsWorldQuest and C_QuestLog.IsWorldQuest(qid)) then
      local ttl = TryCall(C_TaskQuest.GetQuestTimeLeftSeconds, qid) or 0
      local title = (C_TaskQuest.GetQuestInfoByQuestID and C_TaskQuest.GetQuestInfoByQuestID(qid)) or (C_QuestLog.GetTitleForQuestID and C_QuestLog.GetTitleForQuestID(qid)) or ("World Quest "..qid)
      local reward=""
      local ni = GetNumQuestLogRewards and GetNumQuestLogRewards(qid) or 0
      if ni and ni>0 and GetQuestLogRewardInfo then local iname=GetQuestLogRewardInfo(1,qid) if iname then reward=iname end end
      if reward=="" and GetNumQuestLogRewardCurrencies and GetQuestLogRewardCurrencyInfo then
        local nc=GetNumQuestLogRewardCurrencies(qid) or 0
        if nc>0 then local cname,qty=GetQuestLogRewardCurrencyInfo(1,qid) if cname and qty then reward=(qty.."x "..cname) end end
      end
      table.insert(out, { id=qid, zone=zoneName or ("Map "..mapID), title=title, ttl=ttl, reward=reward, mapID=mapID, x=t.x or t.poiX or t.X, y=t.y or t.poiY or t.Y })
    end
  end
  table.sort(out, function(a,b) if (a.ttl or 0)==(b.ttl or 0) then return (a.title or "")<(b.title or "") end return (a.ttl or 0)<(b.ttl or 0) end)
  return out
end

local function GatherWorldQuests_AllZones()
  if not (C_Map and C_Map.GetMapChildrenInfo) then return {} end
  local out={}
  local function traverse(parent)
    local children = C_Map.GetMapChildrenInfo(parent, nil, true) or {}
    for _,inf in ipairs(children) do
      if inf.mapType==Enum.UIMapType.Zone then
        local list = GatherWorldQuestsForMap(inf.mapID, inf.name or "")
        for _,x in ipairs(list) do out[#out+1]=x end
      end
      traverse(inf.mapID)
    end
  end
  traverse(946) -- Monde
  return out
end

----------------------------------------------------------------
-- THEME / FONTS
----------------------------------------------------------------
local function EnsureFonts()
  local p=math.floor(CFG().fontP)
  ui.FontP  = ui.FontP  or CreateFont("WMP_FontP")
  ui.FontH1 = ui.FontH1 or CreateFont("WMP_FontH1")
  ui.FontH2 = ui.FontH2 or CreateFont("WMP_FontH2")
  local base = "Fonts\\FRIZQT__.TTF"
  ui.FontP:SetFont(base, p, "")
  ui.FontH1:SetFont(base, p+6, "")
  ui.FontH2:SetFont(base, p+3, "")
  ui.FontP:SetTextColor(0.95,0.96,0.98,1)
  ui.FontH1:SetTextColor(1.00,0.90,0.35,1)
  ui.FontH2:SetTextColor(0.85,0.86,1.00,1)
end

local function ApplyTheme()
  if not ui.frame then return end
  local cf = CFG()
  local accR, accG, accB = GetAccentRGB()

  ui.frame:SetBackdrop({
    bgFile="Interface\\Buttons\\WHITE8x8",
    edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize=14,
    insets={left=10,right=10,top=10,bottom=10},
  })
  ui.frame:SetBackdropColor(0.06,0.07,0.09, cf.alpha)
  ui.frame:SetBackdropBorderColor(0.30,0.33,0.48, 1.0)
  ui.frame:SetScale(cf.scale or 1.0)

  if ui.topBar and ui.topBar._accentLine then
    ui.topBar._accentLine:SetVertexColor(accR, accG, accB, 0.85)
  end

  EnsureFonts()
end


----------------------------------------------------------------
-- UI HELPERS
----------------------------------------------------------------
local function AddText(parent,font,text,x,y) local fs=parent:CreateFontString(nil,"ARTWORK",nil) fs:SetFontObject(font); fs:SetJustifyH("LEFT"); fs:SetJustifyV("TOP") fs:SetPoint("TOPLEFT",x or 0,y); fs:SetWidth(CFG().size.w-80); fs:SetText(text) fs:SetSpacing(CFG().compact and 2 or 4) local h=fs:GetStringHeight(); return (y-h- (CFG().compact and 4 or 6)), fs end
local function AddTitle(parent,text,y) return AddText(parent, ui.FontH1, text, 0, y) end
local function AddSub(parent,text,y)   return AddText(parent, ui.FontH2, text, 0, y) end
local function AddUnderline(parent, y, padLeft, padRight)
  local accR,accG,accB = GetAccentRGB()
  local tx = parent:CreateTexture(nil, "ARTWORK")
  tx:SetColorTexture(accR,accG,accB, 0.18)
  tx:SetPoint("TOPLEFT", padLeft or 0, y - 2)
  tx:SetPoint("TOPRIGHT", -(padRight or 0), y - 2)
  tx:SetHeight(1)
end
local function AddTitleU(parent, text, y) local yy,fs=AddTitle(parent,text,y); AddUnderline(parent,yy,0,0); return yy-10,fs end
local function AddSubU(parent, text, y)   local yy,fs=AddSub(parent,text,y);   AddUnderline(parent,yy,0,0); return yy-8,fs end
local function AddPara(parent,text,y)     return AddText(parent, ui.FontP, text, 0, y) end
local function AddBullet(parent, text, y)
  local fs = parent:CreateFontString(nil,"ARTWORK",nil)
  fs:SetFontObject(ui.FontP)
  fs:SetJustifyH("LEFT"); fs:SetJustifyV("TOP")
  fs:SetPoint("TOPLEFT", 14, y)
  fs:SetWidth(CFG().size.w - 96)
  fs:SetText("•  "..text)
  fs:SetSpacing(CFG().compact and 2 or 4)
  local h = fs:GetStringHeight()
  return (y - h - (CFG().compact and 3 or 5)), fs
end

-- Bouton compact
if not WMP_MakeSmallButton then
  function WMP_MakeSmallButton(parent, txt, onClick)
    local b=CreateFrame("Button", nil, parent)
    b:SetHeight(22)
    local lbl=b:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
    lbl:SetPoint("CENTER"); lbl:SetText(txt); b.label=lbl
    b:SetWidth(math.max(64, lbl:GetStringWidth()+18))
    local accR,accG,accB = GetAccentRGB()
    local n=b:CreateTexture(nil,"BACKGROUND"); n:SetAllPoints()
    n:SetTexture("Interface\\Buttons\\WHITE8x8"); n:SetVertexColor(0.16,0.18,0.28,0.95)
    local h=b:CreateTexture(nil,"HIGHLIGHT"); h:SetAllPoints()
    h:SetTexture("Interface\\Buttons\\WHITE8x8"); h:SetVertexColor(accR,accG,accB,0.25)
    b:SetScript("OnMouseDown", function() n:SetVertexColor(accR,accG,accB,0.95); lbl:SetTextColor(0,0,0,1) end)
    b:SetScript("OnMouseUp",   function() n:SetVertexColor(0.16,0.18,0.28,0.95); lbl:SetTextColor(1,1,1,1) end)
    b:SetScript("OnClick", onClick)
    return b
  end
end

local function WMP_OpenMenu(menuTable, uniqueName, anchor, x, y)
  if ui._popup then ui._popup:Hide() end
  local f = ui._popup or CreateFrame("Frame", "WMP_PopupMenu", UIParent, "BackdropTemplate")
  f:SetBackdrop({ bgFile="Interface\\Buttons\\WHITE8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=12, insets={left=8,right=8,top=8,bottom=8}, })
  f:SetBackdropColor(0,0,0,0.92)
  f:SetBackdropBorderColor(0.35,0.35,0.50,1)
  f:SetFrameStrata("TOOLTIP")
  f:EnableMouse(true)
  if f._items then for _,w in ipairs(f._items) do w:Hide() end end
  f._items = {}

  local yoff, maxw = -6, 120
  for _,it in ipairs(menuTable or {}) do
    if it.text then
      if it.isTitle then
        local fs=f:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
        fs:SetPoint("TOPLEFT",10,yoff); fs:SetText(it.text)
        maxw = math.max(maxw, fs:GetStringWidth()+20)
        yoff = yoff - fs:GetStringHeight() - 6
        table.insert(f._items, fs)
      else
        local b=CreateFrame("Button", nil, f)
        b:SetPoint("TOPLEFT", 6, yoff); b:SetHeight(20)
        local hl=b:CreateTexture(nil,"HIGHLIGHT")
        hl:SetAllPoints(); hl:SetTexture("Interface\\Buttons\\WHITE8x8"); hl:SetVertexColor(1,1,1,0.12)
        local fs=b:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
        fs:SetPoint("LEFT",8,0); fs:SetText(it.text)
        local w=fs:GetStringWidth()+18; b:SetWidth(w)
        maxw = math.max(maxw, w+6)
        b:SetScript("OnClick", function() if it.func then it.func() end f:Hide() end)
        table.insert(f._items, b)
        yoff = yoff - 22
      end
    end
  end
  f:SetSize(maxw, -yoff+8)

  if anchor=="cursor" or not anchor then
    local px,py=GetCursorPosition(); local s=UIParent:GetEffectiveScale()
    f:ClearAllPoints(); f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", px/s + (x or 0), py/s + (y or 0))
  else
    f:ClearAllPoints(); f:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", x or 0, y or 0)
  end

  f:SetScript("OnMouseDown", function(self, btn) if btn=="RightButton" then self:Hide() end end)
  if not f._hider then
    f._hider = CreateFrame("Frame", nil, UIParent); f._hider:EnableMouse(true); f._hider:SetFrameStrata("FULLSCREEN_DIALOG")
    f._hider:SetAllPoints(UIParent); f._hider:Hide()
    f._hider:SetScript("OnMouseDown", function() f:Hide() end)
    f:HookScript("OnShow", function() f._hider:Show() end)
    f:HookScript("OnHide", function() f._hider:Hide() end)
  end
  f:Show()
  ui._popup = f
end

----------------------------------------------------------------
-- HEADER + MINIMAP
----------------------------------------------------------------
local function BuildHeader(parent)
  local accR,accG,accB = GetAccentRGB()

  local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  bar:SetPoint("TOPLEFT", 10, -10)
  bar:SetPoint("TOPRIGHT",-10, -10)
  bar:SetHeight(36)
  bar:SetBackdrop({ bgFile="Interface\\Buttons\\WHITE8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=12 })
  bar:SetBackdropColor(0,0,0,0.28)
  bar:SetBackdropBorderColor(0.28,0.30,0.46,1)
  bar:SetClipsChildren(true)

  local line = bar:CreateTexture(nil,"OVERLAY")
  line:SetTexture("Interface\\Buttons\\WHITE8x8")
  line:SetVertexColor(accR,accG,accB,0.85)
  line:SetPoint("BOTTOMLEFT", 1, -1)
  line:SetPoint("BOTTOMRIGHT", -1, -1)
  line:SetHeight(2)
  bar._accentLine = line   

  local title = bar:CreateFontString(nil,"OVERLAY","GameFontNormal")
  title:SetPoint("LEFT", 10, 0)
  title:SetText("|cffffff00"..L("app_title").."|r")
  bar._titleFS = title

  local prev
  local function addBtn(label, handler)
    local b = WMP_MakeSmallButton(bar, label, handler)
    if prev then b:SetPoint("LEFT", prev, "RIGHT", 6, 0) else b:SetPoint("LEFT", title, "RIGHT", 16, 0) end
    prev=b; return b
  end

 bar._btnRefresh = addBtn(L("btn_refresh"), function()
    ScanLockouts(); ScanWeekly(); ScanQuests(); ScanEconomy(); ScanCharacter()  
    if ui and ui.tabs and #ui.tabs>0 then
      local i=Clamp(CFG().lastTab or 1,1,#ui.tabs); ui.tabs[i]:Click()
    end
  end)

  addBtn(WoWMemory.L("btn_options"), function()
    WoWMemory.OpenOptionsPanel()
  end)

  local e = CreateFrame("EditBox", nil, bar, "InputBoxTemplate")
  e:SetAutoFocus(false)
  e:SetPoint("RIGHT", -8, 0)
  e:SetSize(240, 20)
  e:SetTextInsets(6,6,2,2)
  e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
  e:SetScript("OnTextChanged", function() if CFG().lastTab==3 and ui.tabs[3] and ui.tabs[3].Click then ui.tabs[3]:Click() end end)
  e.tooltipText = L("search_quests_tip")
  ui.topBar = bar
  ui.questFilter = e
end

BuildMinimapButton = function()
  if ui.minimap then return end
  local m=CreateFrame("Button","WMP_MinimapButton",Minimap); m:SetSize(32,32); m:SetFrameStrata("MEDIUM")
  local i=m:CreateTexture(nil,"BACKGROUND"); i:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder"); i:SetSize(52,52); i:SetPoint("TOPLEFT")
  local icon=m:CreateTexture(nil,"ARTWORK"); icon:SetTexture("Interface\\FriendsFrame\\informationicon"); icon:SetPoint("CENTER",-1,1); icon:SetSize(20,20)
  m:SetScript("OnEnter",function(self)
    GameTooltip:SetOwner(self,"ANCHOR_LEFT")
    GameTooltip:AddLine(L("mini_title"),1,1,1)
    GameTooltip:AddLine(L("mini_left"),.9,.9,.9)
    GameTooltip:AddLine(L("mini_right"),.9,.9,.9)
    GameTooltip:AddLine(L("mini_wheel"),.9,.9,.9)
    GameTooltip:AddLine(L("mini_shift"),.9,.9,.9)
    GameTooltip:Show()
  end)
  m:SetScript("OnLeave",function() GameTooltip:Hide() end)
  m:SetScript("OnMouseWheel",function(_,delta)
    if IsShiftKeyDown() then local s=Clamp((CFG().scale or 1.0)+(delta>0 and 0.05 or -0.05),0.85,1.25) CFG().scale=s; ApplyTheme()
    else local idx=(CFG().lastTab or 1)+(delta>0 and -1 or 1) if idx<1 then idx=#ui.tabs elseif idx>#ui.tabs then idx=1 end if ui.tabs[idx] and ui.tabs[idx].Click then ui.tabs[idx]:Click() end end
  end)
  m:RegisterForClicks("AnyUp")
  m:SetScript("OnClick", function(_, btn)
  if btn == "RightButton" then
    WoWMemory.OpenOptionsPanel()
  else
    if not ui.frame:IsShown() then ui.frame:Show() else ui.frame:Hide() end
  end
end)
  m:RegisterForDrag("LeftButton")
  m:SetScript("OnDragStart",function(self) self.isMoving=true self:LockHighlight() end)
  m:SetScript("OnDragStop",function(self) self.isMoving=nil self:UnlockHighlight() end)
  m:SetScript("OnUpdate",function(self) if not self.isMoving then return end local mx,my=Minimap:GetCenter(); local px,py=GetCursorPosition(); local s=UIParent:GetEffectiveScale(); px=px/s; py=py/s; local ang=math.atan2(py-my,px-mx); local r=(Minimap:GetWidth()/2)-10; CFG().mini.angle=math.deg(ang); self:SetPoint("CENTER",Minimap,"CENTER",math.cos(ang)*r,math.sin(ang)*r) end)
  local function Place() local ang=math.rad(CFG().mini.angle or 210); local r=(Minimap:GetWidth()/2)-10; m:SetPoint("CENTER",Minimap,"CENTER",math.cos(ang)*r,math.sin(ang)*r) end
  Place(); ui.minimap=m
end

----------------------------------------------------------------
-- BUILD UI
----------------------------------------------------------------
function WoWMemory.RefreshUI()
  local _L = L
  if ui and ui.topBar and ui.topBar._titleFS then
    ui.topBar._titleFS:SetText("|cffffff00".._L("app_title").."|r")
  end
  if ui and ui.topBar then
    if ui.topBar._btnRefresh and ui.topBar._btnRefresh.label then
      ui.topBar._btnRefresh.label:SetText(_L("btn_refresh"))
    end
    if ui.topBar._btnOptions and ui.topBar._btnOptions.label then
      ui.topBar._btnOptions.label:SetText(_L("btn_options"))
    end
  end
  if not ui.tabs or #ui.tabs==0 then return end
  local tabs = {
    _L("tab_dungeons"), _L("tab_week"), _L("tab_quests"), _L("tab_resources"),
    _L("tab_worldq"),   _L("tab_chars"),_L("tab_journal"),_L("tab_collect"),
    _L("tab_calendar"), _L("tab_ah"),
  }
  for i,btn in ipairs(ui.tabs) do
    if btn and btn.label and tabs[i] then btn.label:SetText(tabs[i]) end
  end
end

local function BuildUI()
  if ui.frame then return end
  local cfg=CFG()
  local f=CreateFrame("Frame","WMP_Main",UIParent,"BackdropTemplate")
  f:SetSize(cfg.size.w,cfg.size.h); f:SetPoint(cfg.pos.point,UIParent,cfg.pos.point,cfg.pos.x,cfg.pos.y)
  f:EnableMouse(true); f:SetMovable(true); f:RegisterForDrag("LeftButton")
  f:SetScript("OnDragStart", function(self) if not self.isSizing and not (CFG().windowLocked) then self:StartMoving() end end)
  f:SetScript("OnDragStop",function(self) self:StopMovingOrSizing(); local p,_,_,x,y=self:GetPoint(1); cfg.pos.point,cfg.pos.x,cfg.pos.y=p,x,y end)
  f:Hide(); f:SetClipsChildren(true)
  ui.frame=f

  f:SetResizable(true)
  local grab=CreateFrame("Button",nil,f); grab:SetPoint("BOTTOMRIGHT",-6,6); grab:SetSize(16,16)
  local t=grab:CreateTexture(nil,"OVERLAY"); t:SetAllPoints(); t:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up"); t:SetAlpha(0.6)
  grab:SetScript("OnEnter",function() t:SetAlpha(1) end); grab:SetScript("OnLeave",function() t:SetAlpha(0.6) end)
  grab:SetScript("OnMouseDown",function() f.isSizing=true; f:StartSizing("BOTTOMRIGHT") end)
  grab:SetScript("OnMouseUp",function()
    f.isSizing=nil; f:StopMovingOrSizing()
    local w,h=Clamp(f:GetWidth(),540,1100),Clamp(f:GetHeight(),380,860)
    f:SetSize(w,h); cfg.size.w, cfg.size.h=w,h;
    if ui.scroll and ui.content then ui.content:SetWidth(w-60) end
  end)

  local title=f:CreateFontString(nil,"OVERLAY","GameFontNormalLarge"); title:SetPoint("TOP",0,-12); title:SetText("")
  local btnClose=CreateFrame("Button",nil,f,"UIPanelCloseButton"); btnClose:SetPoint("TOPRIGHT",-4,-4)

  BuildHeader(f)
  ApplyTheme()

  -- Tabs + zone de contenu/scroll
  local TAB_W, TAB_H, TAB_GAP, TABS_PER_ROW = 128, 26, 8, 5
  local function CreateTab(parent, row, col, label, onClick, index)
    local btn=CreateFrame("Button", nil, parent, "BackdropTemplate")
    local x = 16 + (col-1)*(TAB_W + TAB_GAP)
    local y = -58 - (row-1)*(TAB_H + 10)
    btn:SetPoint("TOPLEFT", x, y)
    btn:SetSize(TAB_W, TAB_H)
    btn:SetBackdrop({ bgFile="Interface\\Buttons\\WHITE8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=10 })
    btn:SetBackdropColor(0.12,0.13,0.18,0.95)
    btn:SetBackdropBorderColor(0.25,0.27,0.42,1)

    local lbl=btn:CreateFontString(nil,"OVERLAY","GameFontNormal")
    lbl:SetPoint("CENTER"); lbl:SetText(label); btn.label=lbl

    btn:SetScript("OnClick", function() CFG().lastTab = index; onClick() end)
    btn:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(0.50,0.55,0.95,1) end)
    btn:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(0.25,0.27,0.42,1) end)
    return btn
  end

    -- Clés stables des onglets (ordre = index UI existant)
  local TAB_KEYS = {"dungeons","week","quests","resources","worldq","chars","journal","collect","calendar","ah"}

  -- Réorganisation visuelle des onglets visibles (sans changer leurs index logiques)
  local function ReflowTabs()
    if not ui.tabs or #ui.tabs==0 then return end
    local cfg = CFG()
    local v = 0
    for i,btn in ipairs(ui.tabs) do
      local key = TAB_KEYS[i]
      local visible = (cfg.tabs[key] ~= false)
      if visible then
        v = v + 1
        local row = math.floor((v-1)/TABS_PER_ROW) + 1
        local col = ((v-1)%TABS_PER_ROW) + 1
        local x = 16 + (col-1)*(TAB_W + TAB_GAP)
        local y = -58 - (row-1)*(TAB_H + 10)
        btn:ClearAllPoints()
        btn:SetPoint("TOPLEFT", ui.frame, "TOPLEFT", x, y)
        btn:Show()
      else
        btn:Hide()
      end
    end
    -- Si l’onglet courant est masqué, sélectionne le premier visible
    local cur = Clamp(CFG().lastTab or 1, 1, #ui.tabs)
    local curKey = TAB_KEYS[cur]
    if cfg.tabs[curKey] == false then
      for i=1,#ui.tabs do
        local k = TAB_KEYS[i]
        if cfg.tabs[k] ~= false and ui.tabs[i] and ui.tabs[i].Click then
          ui.tabs[i]:Click()
          break
        end
      end
    end
  end

  -- Rend disponible pour ApplyConfigChange
  ui._reflowTabs = ReflowTabs


  local function TabSetSelected(i)
    local accR,accG,accB = GetAccentRGB()
    for idx,btn in ipairs(ui.tabs) do
      local active=(idx==i)
      if active then
        btn:SetBackdropColor(accR*0.22, accG*0.22, accB*0.22, 1)
        btn.label:SetTextColor(1,1,1,1)
      else
        btn:SetBackdropColor(0.12,0.13,0.18,0.95)
        btn.label:SetTextColor(0.85,0.86,1.00,1)
      end
    end
  end

  local panelContent = CreateFrame("Frame", nil, f)
  panelContent:SetPoint("TOPLEFT", 16, -132)
  panelContent:SetPoint("BOTTOMRIGHT", -36, 16)
  local scroll = CreateFrame("ScrollFrame", nil, panelContent, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT")
  scroll:SetPoint("BOTTOMRIGHT")
  ui.panelContent, ui.scroll = panelContent, scroll

  local function NewContentFrame()
    if ui.content then ui.content:Hide() end
    local fr = CreateFrame("Frame", nil, ui.scroll or panelContent) -- safe fallback
    fr:SetSize(CFG().size.w - 60, 10)
    if ui.scroll then ui.scroll:SetScrollChild(fr) end
    ui.content = fr
    EnsureFonts()
    return fr
  end

  local function addTab(label, onClick)
    local idx = #ui.tabs + 1
    local row = math.floor((idx-1)/TABS_PER_ROW) + 1
    local col = ((idx-1)%TABS_PER_ROW) + 1
    local b = CreateTab(f, row, col, label, function()
      TabSetSelected(idx)
      if ui.panelContent then ui.panelContent:Show() end
      onClick()
    end, idx)
    ui.tabs[#ui.tabs+1] = b
  end

  function WoWMemory.ResetWindowPos()
  local cfg = CFG()
  cfg.pos = { point="CENTER", x=0, y=0 }
  if ui.frame then
    ui.frame:ClearAllPoints()
    ui.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  end
    if ui._reflowTabs then ui._reflowTabs() end

end

function WoWMemory.ResetWindowSize()
  local cfg = CFG()
  cfg.size = { w=760, h=520 }
  if ui.frame then
    ui.frame:SetSize(cfg.size.w, cfg.size.h)
    if ui.scroll and ui.content then ui.content:SetWidth(cfg.size.w - 60) end
  end
end

if type(WMP_RegisterCharEvents) == "function" then
  WMP_RegisterCharEvents()
end

----------------------------------------------------------------
-- EVENTS pour tenir l’iLvl à jour en live
----------------------------------------------------------------
local _WMP_CHAR_EV
local function WMP_RegisterCharEvents()
  if _WMP_CHAR_EV then return end
  _WMP_CHAR_EV = CreateFrame("Frame")
  _WMP_CHAR_EV:RegisterEvent("PLAYER_LOGIN")
  _WMP_CHAR_EV:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
  _WMP_CHAR_EV:RegisterEvent("PLAYER_AVG_ITEM_LEVEL_UPDATE")
  -- on capture aussi la connexion/reco, pour être safe :
  _WMP_CHAR_EV:RegisterEvent("PLAYER_ENTERING_WORLD")
  _WMP_CHAR_EV:SetScript("OnEvent", function(_, event)
    -- Petite protection : la DB doit exister
    if not WoWMemoryDB then return end
    ScanCharacter()
    -- Si l’onglet Personnages est l’onglet courant, on le rerend (facultatif)
    if ui and ui.tabs and CFG().lastTab == 6 and ui.tabs[6] and ui.tabs[6].Click then
      ui.tabs[6]:Click()
    end
  end)
end

-- Appel d’amorçage (par exemple à la fin de BuildUI() ou juste après)
WMP_RegisterCharEvents()





  -------------------------------------------------
  -- 1) Donjons / Raids
  -------------------------------------------------
  addTab(L("tab_dungeons"), function()
    local content=NewContentFrame(); local y=-2
    y=select(1, AddTitleU(content, L("dr_locked_title"), y))-(CFG().compact and 4 or 6)
    content._timers = {}
    ScanLockouts()
    local items=DB().dungeons
    if #items>0 then
      for _,d in ipairs(items) do
        local mp=(d.maxPlayers and d.maxPlayers>0) and (" ["..d.maxPlayers.."]") or ""
        local base = string.format("%s - %s%s - %s", d.name or "?", d.diffName or "?", mp, L("dr_reset_in"))
        local remain = tonumber(d.reset or 0) or 0
        local line = base .. PrettyTime(remain)
        local yy, fs = AddBullet(content, line, y); y = yy
        table.insert(content._timers, { fs=fs, base=base, expiresAt=(time and time() or 0)+remain })
      end
    else
      y=select(1, AddPara(content, L("dr_none"), y))
    end

    y = y - 6
    y = select(1, AddSubU(content, L("week_row_mplus"), y))
    y = select(1, AddBullet(content, L("dr_affixes").." "..(GetCurrentAffixNames() or "—"), y))
    local best = (DB().weekly and DB().weekly.bestMPlus) or 0
    y = select(1, AddBullet(content, L("dr_best").." "..(best > 0 and ("+"..best) or "—"), y))
    local ownedLevel   = TryCall(C_MythicPlus and C_MythicPlus.GetOwnedKeystoneLevel)
    local ownedMapID   = TryCall(C_MythicPlus and C_MythicPlus.GetOwnedKeystoneMapID)
    local ownedMapName = ownedMapID and TryCall(C_ChallengeMode and C_ChallengeMode.GetMapUIInfo, ownedMapID) or nil
    if ownedLevel and ownedLevel > 0 then
      y = select(1, AddBullet(content, string.format("%s %s +%d", L("dr_keystone_owned"), ownedMapName or "—", ownedLevel), y))
    else
      y = select(1, AddBullet(content, L("dr_keystone_none"), y))
    end

    content._acc=0
    content:SetScript("OnUpdate", function(self, elapsed)
      self._acc = (self._acc or 0) + (elapsed or 0)
      if self._acc < (CFG().showSeconds and 0.25 or 1.0) then return end
      self._acc = 0
      local now=time and time() or 0
      for _,t in ipairs(self._timers or {}) do
        local left = math.max(0, (t.expiresAt or now)-now)
        t.fs:SetText("- "..t.base..PrettyTime(left))
      end
    end)
    content:SetHeight(-y+10)
  end)

  -------------------------------------------------
  -- 2) This Week
  -------------------------------------------------
  local function CollectVaultState()
    local vault = {
      raid  = { done = 0, thresholds = {1,4,6}, reached = {}, slotText = {} },
      mplus = { done = 0, thresholds = {1,4,8}, reached = {}, slotText = {} },
      world = { done = 0, thresholds = {2,4,8}, reached = {}, slotText = {} },
    }
    local acts = TryCall(C_WeeklyRewards and C_WeeklyRewards.GetActivities)
    if type(acts) == "table" then
      for _, a in ipairs(acts) do
        local info  = TryCall(C_WeeklyRewards and C_WeeklyRewards.GetActivityInfo, a.id or a.activityID) or a
        local t     = a.type or a.activityType or a.thresholdType
        local prog  = (info and info.progress) or a.progress or 0
        local thres = (info and info.threshold) or a.threshold or 0
        local bucket = (t == 1 or t == "Raid") and vault.raid
                    or (t == 2 or t == "MythicPlus") and vault.mplus
                    or vault.world
        bucket.done = math.max(bucket.done or 0, prog or 0)
        if thres and thres > 0 then bucket.reached[thres] = true end
      end
    end
    local levels = {}
    local hist = TryCall(C_MythicPlus and C_MythicPlus.GetRunHistory, false, true)
    if type(hist) == "table" then for _, r in ipairs(hist) do levels[#levels+1] = r.level or 0 end
    else local best = TryCall(C_MythicPlus and C_MythicPlus.GetWeeklyBestLevel) if type(best) == "number" then levels[#levels+1] = best end end
    table.sort(levels, function(a,b) return (a or 0) > (b or 0) end)
    for _, need in ipairs({1,4,8}) do
      local lv = 0
      if #levels >= need then
        lv = math.huge
        for i=1,need do lv = math.min(lv, levels[i]) end
        if lv == math.huge then lv = 0 end
      else
        lv = levels[need] or levels[#levels] or 0
      end
      if lv > 0 then vault.mplus.slotText[need] = "M+ "..lv end
    end
    return vault
  end

  local function RenderPipRow(content, y, label, state)
    y = select(1, AddSubU(content, label, y))
    local function boxText(th)
      local reached = (state.done or 0) >= th
      local text = reached and L("week_pip_done") or L("week_pip_todo")
      local extra = state.slotText and state.slotText[th]
      if extra and extra~="" then text = text .. " " .. extra end
      return text
    end
    local line = string.format("- %s — %s / %s / %s", label, boxText(state.thresholds[1]), boxText(state.thresholds[2]), boxText(state.thresholds[3]))
    y = select(1, AddPara(content, line, y)) - 6
    return y
  end

  addTab(L("tab_week"), function()
    local content = NewContentFrame(); local y = -2
    y = select(1, AddTitleU(content, L("week_title"), y))
    local yy, fsReset = AddPara(content, L("week_reset").." "..PrettyTime(WeeklyResetSeconds()), y); y = yy - 10
    y = select(1, AddTitleU(content, L("week_vault_title"), y))
    local vault = CollectVaultState()
    y = RenderPipRow(content, y, L("week_row_raids"),   vault.raid)
    y = RenderPipRow(content, y, L("week_row_mplus"),   vault.mplus)
    y = RenderPipRow(content, y, L("week_row_world"),   vault.world)
    y = y - 4
    y = select(1, AddSubU(content, L("week_best_mplus_title"), y))
    local best = (DB().weekly and DB().weekly.bestMPlus) or 0
    y = select(1, AddBullet(content, (best>0) and ("+"..best) or "—", y)) - 8
    content:SetScript("OnUpdate", function(self, elapsed)
      self._acc = (self._acc or 0) + (elapsed or 0)
      if self._acc < (CFG().showSeconds and 0.25 or 1.0) then return end
      self._acc = 0
      if fsReset then fsReset:SetText(L("week_reset").." "..PrettyTime(WeeklyResetSeconds())) end
    end)
    content:SetHeight(-y+10)
  end)

  -------------------------------------------------
  -- 3) Quêtes
  -------------------------------------------------
  local function MakeQuestRow(parent,q,y)
    local yy,fs=AddSub(parent, q.title or "?", y)
    fs:SetWordWrap(false); fs:EnableMouse(true)
    fs:SetScript("OnMouseUp", function(_,btn)
      if btn=="LeftButton" then
        if IsShiftKeyDown() then local eb=ChatFrame1EditBox or ChatFrameEditBox if eb then eb:Show(); eb:SetText((q.title or "?").." ("..(q.id or 0)..")"); eb:SetFocus() end
        else if C_SuperTrack and C_SuperTrack.SetSuperTrackedQuestID and q.id then C_SuperTrack.SetSuperTrackedQuestID(q.id) end end
      elseif btn=="RightButton" then
        local menu={
          { text=q.title or "Quest", isTitle=true, notCheckable=true },
          { text=L("quests_ctx_super"),   notCheckable=true, func=function() if C_SuperTrack and C_SuperTrack.SetSuperTrackedQuestID and q.id then C_SuperTrack.SetSuperTrackedQuestID(q.id) end end },
          { text=L("quests_ctx_openmap"), notCheckable=true, func=function() if QuestMapFrame_OpenToQuestDetails and q.id then QuestMapFrame_OpenToQuestDetails(q.id) end end },
          { text=CANCEL, notCheckable=true },
        }
        WMP_OpenMenu(menu, "WMPQuestMenu", "cursor", 0, 0)
      end
    end)
    return yy
  end

  addTab(L("tab_quests"), function()
    local content=NewContentFrame(); local y=-2
    ScanQuests()
    local filter=(ui.questFilter and ui.questFilter:GetText() or ""):lower()
    y=select(1, AddTitleU(content,L("quests_title"),y))-6
    local shown=0
    for _,k in ipairs(DB().quests or {}) do
      local t=(k.title or ""):lower(); local z=(k.zone or ""):lower()
      if filter=="" or t:find(filter,1,true) or z:find(filter,1,true) then
        y=MakeQuestRow(content,k,y)
        if k.zone and k.zone~="" then y=select(1, AddPara(content,L("quests_zone").." "..k.zone,y)) end
        if k.objectives and #k.objectives>0 then for _,o in ipairs(k.objectives) do y=select(1, AddBullet(content,o,y)) end end
        y=y-4; shown=shown+1
      end
    end
    if shown==0 then
      y=select(1, AddPara(content,(filter~="" and L("quests_none_filter")) or L("quests_none_any"),y))
    end
    content:SetHeight(-y+10)
  end)

  -------------------------------------------------
  -- 4) Ressources
  -------------------------------------------------
  addTab(L("tab_resources"), function()
    local content=NewContentFrame(); local y=-2
    ScanEconomy()
    y=select(1, AddTitleU(content,L("res_title"),y))-6

    -- Ledger (10 derniers)
    y = select(1, AddSub(content, L("res_gold_hist"), y)) - 2
    local hist = (DB().ledger and DB().ledger.history) or {}
    for i = #hist, math.max(1, #hist - 10), -1 do
      local h = hist[i]
      local when = date and date("%d/%m %H:%M", h.ts) or ""
      local deltaTxt = FormatMoneyFR(h.delta, { signed = true, colored = true })
      local totalTxt = FormatGold(h.after or 0)
      y = select(1, AddBullet(content,
            string.format("%s %s  %s %s", when, deltaTxt, L("res_arrow_total"), totalTxt), y))
    end

    -- Totaux compte (tous persos)
    local db=WoWMemoryDB or {}
    local totalGoldAll=0
    local totalCurrencies = {}
    local matsTotals = {}
    local wealthList={}
    for key,data in pairs(db) do
      local R=data.resources or {}
      totalGoldAll = totalGoldAll + (tonumber(R.gold) or 0)
      for _,cid in ipairs(CFG().track.currencies or {}) do
        local cur = (R.currencies or {})[cid]
        if cur then totalCurrencies[cid]=(totalCurrencies[cid] or 0) + (cur.quantity or 0) end
      end
      for itemID,_ in pairs(CFG().track.materials or {}) do
        local qty=(R.mats or {})[itemID] or 0
        matsTotals[itemID]=(matsTotals[itemID] or 0)+qty
      end
      wealthList[#wealthList+1] = { key=key, gold=tonumber(R.gold) or 0 }
    end

    y=select(1, AddSub(content, L("res_totals"), y)) - 2
    y=select(1, AddBullet(content, L("res_total_gold")..FormatGold(totalGoldAll), y))
    if #(CFG().track.currencies or {})>0 then
      local names={}
      for _,cid in ipairs(CFG().track.currencies or {}) do
        local info = TryCall(C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo, cid)
        local nm = (info and info.name) or ("Currency "..cid)
        names[#names+1]=string.format("%s: %s", nm, tostring(totalCurrencies[cid] or 0))
      end
      y=select(1, AddBullet(content, L("res_currencies")..table.concat(names, " / "), y))
    end
    if next(CFG().track.materials or {}) then
      local arr={}
      for itemID,need in pairs(CFG().track.materials or {}) do
        local iname = (GetItemInfo and select(1, GetItemInfo(itemID))) or ("Item "..itemID)
        arr[#arr+1] = string.format("%s: %d (%s %d)", iname, matsTotals[itemID] or 0, L("res_threshold"), need or 0)
      end
      table.sort(arr)
      y=select(1, AddBullet(content, L("res_materials")..table.concat(arr, " / "), y))
    end
    y=y-6

    table.sort(wealthList, function(a,b) return (a.gold or 0)>(b.gold or 0) end)
    y=select(1, AddSub(content, L("res_wealth_rank"), y)) - 2
    if #wealthList==0 then y=select(1, AddPara(content, L("res_none"), y))
    else for i=1,#wealthList do local k=wealthList[i]; local chname=k.key:gsub("^.-%-",""); y=select(1, AddBullet(content, string.format("#%d %s — %s", i, chname, FormatGold(k.gold or 0)), y)) end end
    y=y-6
    content:SetHeight(-y+10)
  end)

  -------------------------------------------------
  -- 5) World Quests
  -------------------------------------------------
  addTab(L("tab_worldq"), function()
    local content=NewContentFrame(); local y=-2
    y=select(1, AddTitleU(content,L("wq_title"),y))-6
    local btnZone = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    btnZone:SetPoint("TOPLEFT", 0, y+2); btnZone:SetSize(110,22); btnZone:SetText(L("wq_scan_zone"))
    local btnWorld = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    btnWorld:SetPoint("LEFT", btnZone, "RIGHT", 6, 0); btnWorld:SetSize(120,22); btnWorld:SetText(L("wq_scan_world"))
    local list = {}
    local function render()
      if content._rows then for _,r in ipairs(content._rows) do r:Hide() end end
      content._rows = {}
      local yy = y - 28
      if #list==0 then yy = select(1, AddPara(content, L("wq_none"), yy)) end
      for _,wq in ipairs(list) do
        yy = select(1, AddSub(content, wq.title or "?", yy))
        yy = select(1, AddPara(content, L("quests_zone").." "..(wq.zone or "?"), yy))
        yy = select(1, AddPara(content, L("wq_time_left").." "..PrettyTime(wq.ttl or 0), yy))
        if wq.reward and wq.reward~="" then yy = select(1, AddPara(content, L("wq_reward").." "..wq.reward, yy)) end
        local row=CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        row:SetSize(70,20); row:SetText(L("wq_go"))
        row:SetPoint("TOPLEFT", 0, yy-2)
        row:SetScript("OnClick", function()
          if C_SuperTrack and C_SuperTrack.SetSuperTrackedQuestID and wq.id then C_SuperTrack.SetSuperTrackedQuestID(wq.id) end
          if C_Map and C_Map.CanSetUserWaypoint and C_Map.CanSetUserWaypoint() then
            local point=nil
            if wq.mapID and wq.x and wq.y then point=UiMapPoint.CreateFromCoordinates(wq.mapID, wq.x, wq.y)
            elseif wq.id and UiMapPoint and UiMapPoint.CreateFromQuestID then point=UiMapPoint.CreateFromQuestID(wq.id) end
            if point then C_Map.SetUserWaypoint(point); if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then C_SuperTrack.SetSuperTrackedUserWaypoint(true) end end
          end
          if WorldMapFrame then WorldMapFrame:Show(); if wq.mapID and WorldMapFrame.SetMapID then WorldMapFrame:SetMapID(wq.mapID) end end
          if QuestMapFrame_OpenToQuestDetails and wq.id then QuestMapFrame_OpenToQuestDetails(wq.id) end
        end)
        content._rows[#content._rows+1]=row
        yy = yy - 26
      end
      content:SetHeight(-yy+10)
    end
    local function scanZone()
      local mapID = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player") or nil
      local name = mapID and C_Map.GetMapInfo and (C_Map.GetMapInfo(mapID) and C_Map.GetMapInfo(mapID).name) or ""
      list = mapID and GatherWorldQuestsForMap(mapID, name) or {}
      render()
    end
    local function scanWorld() list = GatherWorldQuests_AllZones(); render() end
    btnZone:SetScript("OnClick", scanZone)
    btnWorld:SetScript("OnClick", scanWorld)
    scanZone()
  end)

  -------------------------------------------------
  -- 6) Personnages
  -------------------------------------------------
  addTab(L("tab_chars"), function()
    local content=NewContentFrame(); local y=-2
    y=select(1, AddTitleU(content,L("ch_title"),y))-6
    local function setSort(mode) CFG().charSort = mode or "ilvl"; ui.tabs[6]:Click() end
    local triBtn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    triBtn:SetSize(130,22); triBtn:SetPoint("TOPLEFT", 0, y+2)
    triBtn:SetText(L("ch_sort_btn").." "..(CFG().charSort=="ilvl" and L("ch_sort_ilvl") or CFG().charSort=="name" and L("ch_sort_name") or L("ch_sort_level")).."  ▾")
    triBtn:SetScript("OnClick", function()
      local menu = {
        { text=L("ch_sort_ilvl"),  notCheckable=true, func=function() setSort("ilvl") end },
        { text=L("ch_sort_name"),  notCheckable=true, func=function() setSort("name") end },
        { text=L("ch_sort_level"), notCheckable=true, func=function() setSort("level") end },
      }
      WMP_OpenMenu(menu, "WMPCharSortMenu", "cursor", 0, 0)
    end)
    y = y - 28

    local db=WoWMemoryDB or {}
    local keys={} for k in pairs(db) do keys[#keys+1]=k end
    table.sort(keys, function(ka, kb)
      local a=db[ka] and db[ka].char or {} ; local b=db[kb] and db[kb].char or {}
      local sort=CFG().charSort or "ilvl"
      if sort=="name" then local an=((a.realm and a.name) and (a.realm.."-"..a.name) or ka):lower(); local bn=((b.realm and b.name) and (b.realm.."-"..b.name) or kb):lower(); return an<bn
      elseif sort=="level" then local al=tonumber(a.level or 0) or 0; local bl=tonumber(b.level or 0) or 0; if al==bl then return (a.name or ""):lower()<(b.name or ""):lower() end return al>bl
      else local ai=tonumber(a.ilvl or 0) or 0; local bi=tonumber(b.ilvl or 0) or 0; if ai==bi then return (a.name or ""):lower()<(b.name or ""):lower() end return ai>bi end
    end)

    local function ClassHex(class) local c=RAID_CLASS_COLORS and RAID_CLASS_COLORS[class or ""] if not c then return "|cffffffff" end return string.format("|cff%02x%02x%02x", math.floor(c.r*255), math.floor(c.g*255), math.floor(c.b*255)) end
    local totalGoldAll = 0
    for _,k in ipairs(keys) do local d=db[k]; if type(d)=="table" then totalGoldAll = totalGoldAll + (tonumber(d.resources and d.resources.gold) or 0) end end
    y = select(1, AddSub(content, L("ch_total_gold")..FormatGold(totalGoldAll), y)) - 4

    local any=false
    for _,key in ipairs(keys) do
      local d=db[key]; if type(d)=="table" then any=true
        local ch=d.char or {}
        local shownName = (ch.realm and ch.name) and (ch.realm.."-"..ch.name) or key
        local ilvlTxt = (CFG().showIlvl and ch.ilvl) and (" iLvl "..ch.ilvl) or ""
        local classHex = ClassHex(ch.class)
        y = select(1, AddSub(content, string.format("%s%s|r — %s %s", classHex, shownName, L("ch_sort_level"), tostring(ch.level or "?")..ilvlTxt), y)) - 2
        if ch.profs and #ch.profs>0 then
          local arr={} for _,p in ipairs(ch.profs) do if p.rank and p.max then arr[#arr+1]=(p.name.." "..p.rank.."/"..p.max) else arr[#arr+1]=p.name end end
          y = select(1, AddPara(content, L("ch_profs").." "..table.concat(arr, ", "), y))
        end
        local w=d.weekly or {}; local v=w.vault or { raid={done=0,total=0}, mplus={done=0,total=0}, pvp={done=0,total=0} }
        local vt=string.format(L("ch_vault"), v.raid.done or 0, v.raid.total or 0, v.mplus.done or 0, v.mplus.total or 0, v.pvp.done or 0, v.pvp.total or 0)
        y = select(1, AddPara(content, vt, y))
        y = select(1, AddPara(content, L("ch_worldboss").." "..(w.worldBossDone and L("ch_ok") or "—"), y)) - 4
      end
    end
    if not any then y=select(1, AddPara(content,"Aucune donnée. Connecte chaque personnage au moins une fois.",y)) end
    content:SetHeight(-y+10)
  end)

  -------------------------------------------------
  -- 7) Journal
  -------------------------------------------------
  addTab(L("tab_journal"), function()
    local content=NewContentFrame(); local y=-2
    y=select(1, AddTitleU(content,L("jr_title"),y))-6
    local cfgJ = CFG().journal or {type="all",char="all",days=7}

    local btnType = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    btnType:SetSize(140,22); btnType:SetPoint("TOPLEFT", 0, y+2)
    local function labelType() local m={all=L("jr_type_all"), quest=L("jr_type_quest"), boss=L("jr_type_boss"), mplus=L("jr_type_mplus")}; btnType:SetText(L("jr_type").." "..(m[cfgJ.type] or L("jr_type_all")).." ▾") end
    labelType()
    local render=nil
    btnType:SetScript("OnClick", function()
      local menu={
        { text=L("jr_type_all"),   notCheckable=true, func=function() cfgJ.type="all"; CFG().journal.type="all"; labelType(); render() end },
        { text=L("jr_type_quest"), notCheckable=true, func=function() cfgJ.type="quest"; CFG().journal.type="quest"; labelType(); render() end },
        { text=L("jr_type_boss"),  notCheckable=true, func=function() cfgJ.type="boss";  CFG().journal.type="boss";  labelType(); render() end },
        { text=L("jr_type_mplus"), notCheckable=true, func=function() cfgJ.type="mplus"; CFG().journal.type="mplus"; labelType(); render() end },
      }
      WMP_OpenMenu(menu, "WMPJournalType", "cursor", 0, 0)
    end)

    local btnChar = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    btnChar:SetSize(220,22); btnChar:SetPoint("LEFT", btnType, "RIGHT", 6, 0)
    local allKeys={} for k in pairs(WoWMemoryDB or {}) do allKeys[#allKeys+1]=k end table.sort(allKeys)
    local function labelChar() btnChar:SetText(L("jr_char").." "..(cfgJ.char=="all" and L("jr_type_all") or cfgJ.char).." ▾") end
    labelChar()
    btnChar:SetScript("OnClick", function()
      local menu={{ text=L("jr_type_all"), notCheckable=true, func=function() cfgJ.char="all"; CFG().journal.char="all"; labelChar(); render() end }}
      for _,k in ipairs(allKeys) do table.insert(menu, { text=k, notCheckable=true, func=function() cfgJ.char=k; CFG().journal.char=k; labelChar(); render() end }) end
      WMP_OpenMenu(menu, "WMPJournalChar", "cursor", 0, 0)
    end)

    local btnDays = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    btnDays:SetSize(130,22); btnDays:SetPoint("LEFT", btnChar, "RIGHT", 6, 0)
    local function labelDays()
      local txt = (cfgJ.days==1 and L("jr_p_24h")) or (cfgJ.days==7 and L("jr_p_7d")) or (cfgJ.days==30 and L("jr_p_30d")) or L("jr_p_all")
      btnDays:SetText(L("jr_period").." "..txt.." ▾")
    end
    labelDays()
    btnDays:SetScript("OnClick", function()
      local function pick(d) return function() cfgJ.days=d; CFG().journal.days=d; labelDays(); render() end end
      local menu={ { text=L("jr_p_24h"), notCheckable=true, func=pick(1) }, { text=L("jr_p_7d"), notCheckable=true, func=pick(7) }, { text=L("jr_p_30d"), notCheckable=true, func=pick(30) }, { text=L("jr_p_all"), notCheckable=true, func=pick(9999) }, }
      WMP_OpenMenu(menu, "WMPJournalDays", "cursor", 0, 0)
    end)
    y = y - 32

    function render()
      if content._rows then for _,r in ipairs(content._rows) do r:Hide() end end
      content._rows={}
      local yy=y
      local now=time and time() or 0
      local cutoff = cfgJ.days and (now - (cfgJ.days*24*60*60)) or 0
      local all={}
      for key,data in pairs(WoWMemoryDB or {}) do
        if cfgJ.char=="all" or cfgJ.char==key then
          for _,e in ipairs(data.activity or {}) do
            if (not cfgJ.days or cfgJ.days>=9999 or (e.ts or 0)>=cutoff) then
              if cfgJ.type=="all" or e.type==cfgJ.type then
                all[#all+1] = { ts=e.ts or 0, type=e.type or "?", text=e.text or "", key=key }
              end
            end
          end
        end
      end
      table.sort(all, function(a,b) return (a.ts or 0)>(b.ts or 0) end)
      if #all==0 then yy = select(1, AddPara(content, L("jr_none"), yy))
      else
        for _,e in ipairs(all) do
          local when = date and date("%d/%m %H:%M", e.ts) or tostring(e.ts)
          local color = (e.type=="boss" and "|cffffa64d") or (e.type=="mplus" and "|cff7fbfff") or (e.type=="quest" and "|cff88ff88") or "|cffffffff"
          yy = select(1, AddPara(content, string.format("%s — %s — %s%s|r", when, e.key, color, e.text), yy))
        end
      end
      content:SetHeight(-yy+10)
    end
    render()
  end)

  -------------------------------------------------
  -- 8) Collections
  -------------------------------------------------
  local function OpenCollections(tabIndex, query)
    tabIndex = tonumber(tabIndex) or 1
    if UIParentLoadAddOn then pcall(UIParentLoadAddOn, "Blizzard_Collections") end
    local function setSearch()
      if not query or query == "" then return end
      local box = nil
      if tabIndex == 1 and MountJournal then
        box = MountJournal.SearchBox or _G.MountJournalSearchBox
      elseif tabIndex == 2 and PetJournal then
        box = PetJournal.SearchBox or _G.PetJournalSearchBox
      elseif tabIndex == 3 and ToyBox then
        box = ToyBox.searchBox or ToyBox.SearchBox or _G.ToyBoxSearchBox
      end
      if box and box.SetText then
        box:SetText(query)
        box:ClearFocus()
      end
    end
    if not CollectionsJournal or not CollectionsJournal:IsShown() then
      ToggleCollectionsJournal(tabIndex); C_Timer.After(0.05, setSearch)
    else
      if CollectionsJournal_SetTab then CollectionsJournal_SetTab(tabIndex) else ToggleCollectionsJournal(tabIndex) end
      C_Timer.After(0.01, setSearch)
    end
  end

  local function ListMounts(filter, q)
    local out={}
    if not (C_MountJournal and C_MountJournal.GetMountIDs) then return out end
    local ids = C_MountJournal.GetMountIDs() or {}
    for _,mid in ipairs(ids) do
      local name, _, icon, _, _, _, _, _, _, _, collected = C_MountJournal.GetMountInfoByID(mid)
      local show=true
      if filter=="owned"   and not collected then show=false end
      if filter=="missing" and     collected then show=false end
      if q~="" and name and not name:lower():find(q,1,true) then show=false end
      if show then out[#out+1] = {name=name or ("Mount #"..tostring(mid)), id=mid, owned=collected and true or false, icon=icon} end
    end
    table.sort(out, function(a,b) if a.owned~=b.owned then return a.owned end return (a.name or "")<(b.name or "") end)
    return out
  end
  local function ListToys(filter, q)
    local out={}
    if not C_ToyBox or not C_ToyBox.GetNumToys then return out end
    local n = C_ToyBox.GetNumToys() or 0
    for i=1,n do
      local itemID = C_ToyBox.GetToyFromIndex(i)
      if itemID then
        local name, icon = C_ToyBox.GetToyInfo(itemID)
        local owned = PlayerHasToy and PlayerHasToy(itemID) and true or false
        local show=true
        if filter=="owned"   and not owned then show=false end
        if filter=="missing" and     owned then show=false end
        if q~="" and name and not name:lower():find(q,1,true) then show=false end
        if show then out[#out+1] = {name=name or ("Toy #"..itemID), id=itemID, owned=owned, icon=icon} end
      end
    end
    table.sort(out, function(a,b) if a.owned~=b.owned then return a.owned end return (a.name or "")<(b.name or "") end)
    return out
  end
  local function ListPets(filter, q)
    local out, seen={}, {}
    if not C_PetJournal or not C_PetJournal.GetNumPets then return out end
    local n = C_PetJournal.GetNumPets() or 0
    for i=1,n do
      local petID, speciesID, owned, customName, level, favorite, revoked, speciesName, icon = C_PetJournal.GetPetInfoByIndex(i)
      local nm = customName or speciesName or "Pet"
      local key = speciesID or nm
      if not seen[key] then
        seen[key]=true
        local show=true
        if filter=="missing" then show=false end
        if q~="" and nm and not nm:lower():find(q,1,true) then show=false end
        if show then out[#out+1] = {name=nm, id=speciesID or 0, owned=owned and true or false, icon=icon} end
      end
    end
    table.sort(out, function(a,b) return (a.name or "")<(b.name or "") end)
    return out
  end
  local function StatusText(ok) return ok and L("col_owned") or L("col_missing") end

  addTab(L("tab_collect"), function()
    local content = NewContentFrame(); local y = -2
    y = select(1, AddTitleU(content, L("col_title"), y)) - 4

    local curCat   = ui._col_cat   or "mounts"
    local curFilt  = ui._col_filter or "all"
    local curQuery = ui._col_query or ""

    local function labelCat()
      return (curCat=="mounts" and L("col_mounts")) or (curCat=="pets" and L("col_pets")) or L("col_toys")
    end
    local function labelFilt()
      return (curFilt=="owned" and L("col_owned")) or (curFilt=="missing" and L("col_missing")) or L("jr_type_all")
    end

    local function render() end
    local function UpdateHeaderButtons()
      if content._btnCat  and content._btnCat.label  then
        content._btnCat.label:SetText("Catégorie : "..labelCat().." ▾")
      end
      if content._btnFilt and content._btnFilt.label then
        content._btnFilt.label:SetText("Filtre : "..labelFilt().." ▾")
      end
    end

    local bCat = WMP_MakeSmallButton(content, "Catégorie : "..labelCat().." ▾", function()
      local menu = {
        { text=L("col_mounts"),  notCheckable=true, func=function() curCat="mounts"; ui._col_cat=curCat; UpdateHeaderButtons(); render() end },
        { text=L("col_pets"),    notCheckable=true, func=function() curCat="pets";   ui._col_cat=curCat; UpdateHeaderButtons(); render() end },
        { text=L("col_toys"),    notCheckable=true, func=function() curCat="toys";   ui._col_cat=curCat; UpdateHeaderButtons(); render() end },
      }
      WMP_OpenMenu(menu, "WMP_ColCat", "cursor", 0, 0)
    end)
    bCat:SetPoint("TOPLEFT", 0, y+2); content._btnCat = bCat

    local bFilt = WMP_MakeSmallButton(content, "Filtre : "..labelFilt().." ▾", function()
      local menu = {
        { text=L("jr_type_all"), notCheckable=true, func=function() curFilt="all";    ui._col_filter=curFilt; UpdateHeaderButtons(); render() end },
        { text=L("col_owned"),   notCheckable=true, func=function() curFilt="owned";  ui._col_filter=curFilt; UpdateHeaderButtons(); render() end },
        { text=L("col_missing"), notCheckable=true, func=function() curFilt="missing";ui._col_filter=curFilt; UpdateHeaderButtons(); render() end },
      }
      WMP_OpenMenu(menu, "WMP_ColFilter", "cursor", 0, 0)
    end)
    bFilt:SetPoint("LEFT", bCat, "RIGHT", 6, 0); content._btnFilt = bFilt

    local eSearch = CreateFrame("EditBox", nil, content, "InputBoxTemplate")
    eSearch:SetAutoFocus(false); eSearch:SetSize(220, 20)
    eSearch:SetPoint("LEFT", bFilt, "RIGHT", 8, 0)
    eSearch:SetText(curQuery); eSearch:SetCursorPosition(0)
    eSearch:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    eSearch:SetScript("OnTextChanged", function(self) curQuery = (self:GetText() or ""):lower(); ui._col_query = curQuery; render() end)

    y = y - 30
    y = select(1, AddSubU(content, "Liste — "..labelCat(), y))

    local function clearRows()
      if content._rows then for _,r in ipairs(content._rows) do r:Hide() end end
      content._rows = {}
    end

    function render()
      clearRows()
      local yy = y
      local list = (curCat=="mounts" and ListMounts(curFilt, curQuery))
                or (curCat=="toys"   and ListToys(curFilt,  curQuery))
                or ListPets(curFilt,   curQuery)

      if #list==0 then
        yy = select(1, AddPara(content, "Aucun résultat.", yy))
        content:SetHeight(-yy+10); return
      end

      local w = CFG().size.w - 60
      local nameW, stateW, btnW = math.floor(w*0.62), 110, 70
      local xName, xState, xBtn = 0, nameW+12, nameW+12+stateW+12

      local headName = content:CreateFontString(nil,"OVERLAY","GameFontNormalSmall"); headName:SetPoint("TOPLEFT", xName, yy); headName:SetText("Nom")
      local headState= content:CreateFontString(nil,"OVERLAY","GameFontNormalSmall"); headState:SetPoint("TOPLEFT", xState, yy); headState:SetText("Statut")
      yy = yy - 18; AddUnderline(content, yy+14, 0, 0)

      for _,it in ipairs(list) do
        local fsName = content:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
        fsName:SetPoint("TOPLEFT", xName, yy); fsName:SetWidth(nameW); fsName:SetJustifyH("LEFT")
        fsName:SetText((it.icon and ("|T"..it.icon..":16:16:0:0|t ") or "")..(it.name or "?"))

        local fsSt = content:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
        fsSt:SetPoint("TOPLEFT", xState, yy); fsSt:SetWidth(stateW); fsSt:SetText(StatusText(it.owned))

        local bView = WMP_MakeSmallButton(content, L("wq_go"), function()
          if curCat=="mounts" then OpenCollections(1, it.name)
          elseif curCat=="pets" then OpenCollections(2, it.name)
          else OpenCollections(3, it.name) end
        end)
        bView:SetPoint("TOPLEFT", xBtn, yy-2); bView:SetWidth(btnW)

        content._rows[#content._rows+1] = fsName
        content._rows[#content._rows+1] = fsSt
        content._rows[#content._rows+1] = bView

        yy = yy - 24
      end
      content:SetHeight(-yy+10)
      UpdateHeaderButtons()
    end

    render()
  end)

  -------------------------------------------------
  -- 9) Calendrier
  -------------------------------------------------
  local function WMP_OpenCalendarAt(year, month, day)
    if UIParentLoadAddOn then pcall(UIParentLoadAddOn, "Blizzard_Calendar") end
    if ToggleCalendar then ToggleCalendar() end
    if C_Calendar and C_Calendar.SetAbsMonth then pcall(C_Calendar.SetAbsMonth, month, year) end
    if C_Calendar and C_Calendar.SetDay then pcall(C_Calendar.SetDay, day) end
  end

  addTab(L("tab_calendar"), function()
    local content = NewContentFrame(); local y = -2
    local function AddMonths(y, m, off)
      local nm = m + off
      local yy = y + math.floor((nm-1)/12)
      local mm = ((nm-1)%12)+1
      return yy, mm
    end
    local function timeStr(t)
      if type(t) == "table" and t.hour ~= nil and t.minute ~= nil then
        return string.format("%02d:%02d", t.hour, t.minute)
      end
      return "—"
    end
    local function typeStr(e) return (e and e.calendarType) or "—" end

    y = select(1, AddTitleU(content, L("cal_title"), y)) - 6
    local calCfg = CFG().calendar or {}; calCfg.monthsAhead = tonumber(calCfg.monthsAhead or 3); calCfg.monthsBack = tonumber(calCfg.monthsBack or 0); CFG().calendar = calCfg

    local btnRange = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    local function rangeLabel()
      if (calCfg.monthsBack or 0) == 0 then
        return ("Période : %d mois à venir ▾"):format(calCfg.monthsAhead or 0)
      else
        return ("Période : -%d / +%d mois ▾"):format(calCfg.monthsBack or 0, calCfg.monthsAhead or 0)
      end
    end
    btnRange:SetSize(210,22); btnRange:SetPoint("TOPLEFT", 0, y+2); btnRange:SetText(rangeLabel())

    local totalW = (CFG().size.w - 60)
    local colDate, colHeure, colType = 90, 60, 130
    local colTitre = totalW - (colDate + colHeure + colType + 86)

    local header = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    header:SetPoint("TOPLEFT", 0, y-26); header:SetJustifyH("LEFT")
    header:SetText( string.format("%-10s %-5s %-18s %s", "Date", "Heure", "Type", "Titre") )

    local underline = content:CreateTexture(nil, "ARTWORK")
    underline:SetColorTexture(1,1,1,0.10)
    underline:SetPoint("TOPLEFT", 0, y-38); underline:SetPoint("TOPRIGHT", 0, y-38); underline:SetHeight(1)

    local listFrame = CreateFrame("Frame", nil, content)
    listFrame:SetPoint("TOPLEFT", 0, y-44); listFrame:SetWidth(totalW)

    local rows = {}
    local function clearRows() for _,r in ipairs(rows) do r:Hide() end rows = {} end

    local function collectEvents()
      if not C_Calendar then return {} end
      C_Calendar.OpenCalendar()
      local now = date("*t")
      local baseY, baseM = now.year, now.month
      local ev = {}
      for offset = -(calCfg.monthsBack or 0), (calCfg.monthsAhead or 0) do
        local mi = C_Calendar.GetMonthInfo and C_Calendar.GetMonthInfo(offset)
        local yy, mm = AddMonths(baseY, baseM, offset)
        local numDays = (mi and mi.numDays) or 31
        for day = 1, numDays do
          local n = (C_Calendar.GetNumDayEvents and C_Calendar.GetNumDayEvents(offset, day)) or 0
          for i = 1, n do
            local e = C_Calendar.GetDayEvent and C_Calendar.GetDayEvent(offset, day, i)
            if e and e.title and e.title ~= "" then
              if not e.sequenceType or e.sequenceType == "START" then
                ev[#ev+1] = { year = yy, month = mm, day = day, title = e.title or "?", calendarType = e.calendarType, startTime = e.startTime }
              end
            end
          end
        end
      end
      table.sort(ev, function(a,b)
        if a.year ~= b.year then return a.year < b.year end
        if a.month ~= b.month then return a.month < b.month end
        if a.day ~= b.day then return a.day < b.day end
        local ah = (a.startTime and a.startTime.hour) or -1
        local bh = (b.startTime and b.startTime.hour) or -1
        if ah ~= bh then return ah < bh end
        local am = (a.startTime and a.startTime.minute) or -1
        local bm = (b.startTime and b.startTime.minute) or -1
        if am ~= bm then return am < bm end
        return (a.title or "") < (b.title or "")
      end)
      return ev
    end

    local function render()
      clearRows()
      local data = collectEvents()
      local yy = -2
      local rowH = 22
      for _,e in ipairs(data) do
        local line = CreateFrame("Frame", nil, listFrame)
        line:SetPoint("TOPLEFT", 0, yy); line:SetSize(totalW, rowH)
        local fsDate = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fsDate:SetPoint("LEFT", 0, 0); fsDate:SetWidth(colDate); fsDate:SetJustifyH("LEFT")
        fsDate:SetText(string.format("%02d/%02d/%04d", e.day, e.month, e.year))
        local fsHeure = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fsHeure:SetPoint("LEFT", fsDate, "RIGHT", 8, 0); fsHeure:SetWidth(colHeure); fsHeure:SetJustifyH("LEFT"); fsHeure:SetText(timeStr(e.startTime))
        local fsType = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fsType:SetPoint("LEFT", fsHeure, "RIGHT", 8, 0); fsType:SetWidth(colType); fsType:SetJustifyH("LEFT"); fsType:SetText(typeStr(e))
        local fsTitre = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fsTitre:SetPoint("LEFT", fsType, "RIGHT", 8, 0); fsTitre:SetWidth(colTitre); fsTitre:SetJustifyH("LEFT"); fsTitre:SetText(e.title or "?")
        local btn = CreateFrame("Button", nil, line, "UIPanelButtonTemplate")
        btn:SetSize(80, 18); btn:SetPoint("RIGHT", -2, 0); btn:SetText(L("wq_go"))
        btn:SetScript("OnClick", function() WMP_OpenCalendarAt(e.year, e.month, e.day) end)
        rows[#rows+1] = line
        yy = yy - rowH
      end
      local totalH = (-yy) + 8
      listFrame:SetHeight(totalH)
      content:SetHeight((listFrame:GetTop() - listFrame:GetBottom()) + 72)
    end

    btnRange:SetScript("OnClick", function()
      local function set(back, ahead)
        return function() calCfg.monthsBack, calCfg.monthsAhead = back, ahead; btnRange:SetText(rangeLabel()); render() end
      end
      local menu = {
        { text="Mois courant",   notCheckable=true, func=set(0, 0) },
        { text="+1 mois",         notCheckable=true, func=set(0, 1) },
        { text="+3 mois",         notCheckable=true, func=set(0, 3) },
        { text="+6 mois",         notCheckable=true, func=set(0, 6) },
        { text="+12 mois",        notCheckable=true, func=set(0,12) },
        { text="-1 / +1 mois",    notCheckable=true, func=set(1, 1) },
        { text="-1 / +3 mois",    notCheckable=true, func=set(1, 3) },
        { text="-3 / +3 mois",    notCheckable=true, func=set(3, 3) },
      }
      WMP_OpenMenu(menu, "WMPCalendarRange", "cursor", 0, 0)
    end)
    render()
  end)

  -------------------------------------------------
  -- 10) HDV (mes ventes)
  -------------------------------------------------
  -- cache + helpers
  WMP_AH = WMP_AH or { data = {}, lastFetch = 0, isCache = false }
  local function AH_TimeBandToSeconds(band) local map={ [0]=0,[1]=1800,[2]=7200,[3]=43200,[4]=172800 } return map[tonumber(band or 0)] or 0 end
  local function AH_GetItemNameSafe(link, fallback) if link and GetItemInfo then local name = select(1, GetItemInfo(link)); if name and name~="" then return name end end return fallback or L("ah_cols_item") end
  local function WMP_AH_SaveSnapshot()
    local d = DB(); d.ah = d.ah or {}
    local items = {}
    for _,r in ipairs(WMP_AH.data or {}) do
      items[#items+1] = { n=r.name, q=r.quantity, u=r.unit, b=r.buyout, bid=r.bid, t=r.timeLeft, s=r.status }
    end
    d.ah.items = items
    d.ah.last  = WMP_AH.lastFetch or (time and time() or 0)
  end
  local function WMP_AH_LoadSnapshot()
    local d = DB() and DB().ah
    if not d or not d.items then return false end
    local items = {}
    for _,r in ipairs(d.items) do
      items[#items+1] = { name=r.n, quantity=r.q, unit=r.u, buyout=r.b, bid=r.bid, timeLeft=r.t, status=r.s }
    end
    WMP_AH.data      = items
    WMP_AH.lastFetch = d.last or 0
    WMP_AH.isCache   = true
    return true
  end
  local function WMP_AH_BuildSnapshotFromAPI()
    if not C_AuctionHouse then return false, "API" end
    local list = nil
    if C_AuctionHouse.GetOwnedAuctions then list = C_AuctionHouse.GetOwnedAuctions()
    elseif C_AuctionHouse.GetNumOwnedAuctions and C_AuctionHouse.GetOwnedAuctionInfo then
      list = {}; local n = C_AuctionHouse.GetNumOwnedAuctions() or 0
      for i=1,n do list[#list+1] = C_AuctionHouse.GetOwnedAuctionInfo(i) end
    end
    if type(list) ~= "table" then return false, "nodata" end
    local out = {}
    for _,a in ipairs(list) do
      local link   = a.itemLink or a.itemLinkSpell or (a.item and a.item.itemLink) or nil
      local name   = a.itemName or AH_GetItemNameSafe(link, L("ah_cols_item"))
      local qty    = tonumber(a.quantity or a.totalQuantity or 1) or 1
      local buy    = tonumber(a.buyoutAmount or a.buyout or 0) or 0
      local bid    = tonumber(a.bidAmount or a.currentBid or 0) or 0
      local left   = tonumber(a.timeLeftSeconds) or AH_TimeBandToSeconds(a.timeLeft)
      local unit   = (qty > 0) and math.floor(buy / qty) or 0
      out[#out+1] = { name=name, quantity=qty, unit=unit, buyout=buy, bid=bid, timeLeft=left, status="" }
    end
    table.sort(out, function(x,y) return (x.name or "") < (y.name or "") end)
    WMP_AH.data      = out
    WMP_AH.lastFetch = (time and time() or 0)
    WMP_AH.isCache   = false
    WMP_AH_SaveSnapshot()
    return true
  end
  function WMP_AH_Query()
    if C_AuctionHouse and C_AuctionHouse.QueryOwnedAuctions then pcall(C_AuctionHouse.QueryOwnedAuctions, {}) end
    WMP_AH_BuildSnapshotFromAPI()
    if WMP_AH._render then WMP_AH._render() end
  end
  local _WMP_AH_Ev
  local function _safeRegister(frame, ev) pcall(frame.RegisterEvent, frame, ev) end
  function WMP_AH_RegisterEvents()
    if _WMP_AH_Ev then return end
    _WMP_AH_Ev = CreateFrame("Frame")
    _WMP_AH_Ev:SetScript("OnEvent", function(_, event)
      if event == "OWNED_AUCTIONS_UPDATED"
         or event == "AUCTION_OWNED_LIST_UPDATE"
         or event == "AUCTION_HOUSE_AUCTION_CREATED"
         or event == "AUCTION_HOUSE_AUCTION_REMOVED"
         or event == "AUCTION_CANCELED"
         or event == "AUCTION_HOUSE_SHOW" then
        WMP_AH_BuildSnapshotFromAPI()
        if WMP_AH._render then WMP_AH._render() end
      end
    end)
    for _,ev in ipairs({
      "OWNED_AUCTIONS_UPDATED","AUCTION_OWNED_LIST_UPDATE","AUCTION_HOUSE_AUCTION_CREATED",
      "AUCTION_HOUSE_AUCTION_REMOVED","AUCTION_CANCELED","AUCTION_HOUSE_SHOW",
    }) do _safeRegister(_WMP_AH_Ev, ev) end
  end

  addTab(L("tab_ah"), function()
    local content = NewContentFrame(); local y = -2
    y = select(1, AddTitleU(content, L("ah_title"), y)) - 8
    local btnR = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    btnR:SetSize(100, 22); btnR:SetPoint("TOPLEFT", 0, y+2); btnR:SetText(L("ah_btn_rescan"))
    btnR:SetScript("OnClick", function() WMP_AH_Query() end)
    y = y - 28

    local W = (CFG().size.w or 760) - 60
    local GAP = 8
    local COLW = { qty=40, unit=110, buy=120, bid=120, time=70, stat=60 }
    local FIXED = COLW.qty + COLW.unit + COLW.buy + COLW.bid + COLW.time + COLW.stat + GAP*5
    local NAMEW = math.max(120, W - FIXED)

    local x = 0
    local function head(label, w)
      local fs = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
      fs:SetPoint("TOPLEFT", x, y); fs:SetWidth(w); fs:SetJustifyH("LEFT"); fs:SetText(label)
      x = x + w + GAP
    end
    head(L("ah_cols_item"), NAMEW)
    head(L("ah_cols_qty"),  COLW.qty)
    head(L("ah_cols_unit"), COLW.unit)
    head(L("ah_cols_buy"),  COLW.buy)
    local function L2(key, default) local v=L(key); return (v==key) and (default or key) or v end
    head(L2("ah_cols_bid","Bid"), COLW.bid)
    head(L("ah_cols_time"), COLW.time)
    head(L("ah_cols_stat"), COLW.stat)
    y = y - 20

    if not content._lastFS then content._lastFS = content:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall") end
    content._lastFS:ClearAllPoints(); content._lastFS:SetPoint("TOPLEFT", 0, y)
    y = y - 16

    local lineH = (CFG().compact and 16 or 18)
    local function wipeRows() if content._rows then for _,r in ipairs(content._rows) do r:Hide() end end content._rows = {} end
    local function addRow(info)
      local row = CreateFrame("Frame", nil, content); row:SetPoint("TOPLEFT", 0, y); row:SetSize(W, lineH)
      local function cell(txt, w, align)
        local fs = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fs:SetPoint("LEFT", x, 0); fs:SetWidth(w); fs:SetWordWrap(false); fs:SetJustifyH(align or "LEFT"); fs:SetText(txt or ""); x = x + w + GAP
        return fs
      end
      x = 0
      local qty  = tonumber(info.quantity or 0) or 0
      local buy  = tonumber(info.buyout   or 0) or 0
      local unit = tonumber(info.unit     or ((qty > 0) and math.floor(buy/qty) or 0)) or 0
      local bid  = tonumber(info.bid      or 0) or 0
      local left = tonumber(info.timeLeft or 0) or 0
      if WMP_AH.lastFetch > 0 and time then left = math.max(0, left - (time() - WMP_AH.lastFetch)) end
      cell(info.name or L("ah_cols_item"), NAMEW, "LEFT")
      cell(tostring(qty),      COLW.qty,  "RIGHT")
      cell(FormatMoneyFR(unit),COLW.unit, "RIGHT")
      cell(FormatMoneyFR(buy), COLW.buy,  "RIGHT")
      cell(FormatMoneyFR(bid), COLW.bid,  "RIGHT")
      cell(PrettyTime(left),   COLW.time, "RIGHT")
      cell(info.status or "",  COLW.stat, "LEFT")
      content._rows[#content._rows+1] = row
      y = y - lineH
    end

    local function render()
      wipeRows()
      local list = WMP_AH.data or {}
      if WMP_AH.lastFetch > 0 and date then
        content._lastFS:SetText((L("ah_last_scan") or "Last scan:").." "..date("%d/%m %H:%M:%S", WMP_AH.lastFetch))
      else
        content._lastFS:SetText((L("ah_last_scan") or "Last scan:").." "..(L("ah_never") or "never"))
      end
      local yy = y
      if #list == 0 then
        local msg = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        msg:SetPoint("TOPLEFT", 0, yy); msg:SetWidth(W); msg:SetJustifyH("LEFT"); msg:SetWordWrap(true)
        msg:SetText((L("ah_none") or "No current auctions.").."\n"..(L("ah_need_visit") or "Visit the Auction House once to enable scanning."))
        content._rows[#content._rows+1] = msg
        yy = yy - msg:GetStringHeight() - 6
      else
        for _,info in ipairs(list) do addRow(info) end
        yy = y
      end
      content:SetHeight(-yy + 10)
    end

    WMP_AH._render = render
    WMP_AH_RegisterEvents()
    if not (WMP_AH.data and #WMP_AH.data > 0) then WMP_AH_LoadSnapshot() end
    render()
  end)

 -- Sélection onglet courant (labels)
  local labels = { L("tab_dungeons"), L("tab_week"), L("tab_quests"), L("tab_resources"), L("tab_worldq"), L("tab_chars"), L("tab_journal"), L("tab_collect"), L("tab_calendar"), L("tab_ah") }
  for i=1,#labels do if ui.tabs[i] and ui.tabs[i].label then ui.tabs[i].label:SetText(labels[i]) end end
end

----------------------------------------------------------------
-- OPTIONS HELPERS (ouverts depuis le header/minimap)
----------------------------------------------------------------
WoWMemory = WoWMemory or {}

function WoWMemory.OpenOptionsPanel()
  local LL = (WoWMemory and WoWMemory.L) or function(x) return x end
  if Settings and Settings.OpenToCategory then
    local cat = _G.WoWMemoryOptions_RootCategory
    local id  = cat and cat.GetID and cat:GetID()
    Settings.OpenToCategory(id or LL("app_title"))
  elseif InterfaceOptionsFrame_OpenToCategory then
    InterfaceOptionsFrame_OpenToCategory("WoW Memory+")
    InterfaceOptionsFrame_OpenToCategory("WoW Memory+")
  end
end

function WoWMemory.ApplyConfigChange(which)
  which = which or "rerender"
  if which == "minimap" then
    if CFG().mini and CFG().mini.shown then
      if not ui.minimap and BuildMinimapButton then BuildMinimapButton() end
      if ui.minimap then ui.minimap:Show() end
    else
      if ui.minimap then ui.minimap:Hide() end
    end
  elseif which == "theme" then
    if ApplyTheme then ApplyTheme() end
    if ui and ui.tabs and ui.tabs[CFG().lastTab or 1] then ui.tabs[CFG().lastTab or 1]:Click() end
  elseif which == "fonts" then
    if EnsureFonts then EnsureFonts() end
    if ui and ui.tabs and ui.tabs[CFG().lastTab or 1] then ui.tabs[CFG().lastTab or 1]:Click() end
  elseif which == "refresh" then
    if WMP_ApplyRefreshMode then WMP_ApplyRefreshMode() end
  elseif which == "tabs" then
    if WoWMemory and WoWMemory.ReflowTabs then WoWMemory.ReflowTabs() end
  else
    if ui and ui.tabs and ui.tabs[CFG().lastTab or 1] then ui.tabs[CFG().lastTab or 1]:Click() end
  end
end

-- Reflow des onglets (global) -------------------------------------------------
-- Remplacer TOUTE la fonction par cette version
function WoWMemory.ReflowTabs()
  if not ui or not ui.tabs or not ui.frame then return end

  local cfg = CFG()
  local TAB_W, TAB_H, TAB_GAP, TABS_PER_ROW = 128, 26, 8, 5
  local TAB_KEYS = {"dungeons","week","quests","resources","worldq","chars","journal","collect","calendar","ah"}

  -- Poser / cacher les boutons selon la visibilité configurée
  local v = 0
  for i, btn in ipairs(ui.tabs) do
    local key = TAB_KEYS[i]
    local visible = not (cfg.tabs and cfg.tabs[key] == false)
    if visible then
      v = v + 1
      local row = math.floor((v-1)/TABS_PER_ROW) + 1
      local col = ((v-1)%TABS_PER_ROW) + 1
      local x = 16 + (col-1)*(TAB_W + TAB_GAP)
      local y = -58 - (row-1)*(TAB_H + 10)
      btn:ClearAllPoints()
      btn:SetPoint("TOPLEFT", ui.frame, "TOPLEFT", x, y)
      btn:Show()
    else
      btn:Hide()
    end
  end

  -- Si l’onglet courant est masqué, sélectionner le premier visible
  local cur = math.max(1, math.min(#ui.tabs, CFG().lastTab or 1))
  local curKey = TAB_KEYS[cur]
  if cfg.tabs and cfg.tabs[curKey] == false then
    for i = 1, #ui.tabs do
      local k = TAB_KEYS[i]
      if not (cfg.tabs[k] == false) and ui.tabs[i] and ui.tabs[i].Click then
        ui.tabs[i]:Click()
        break
      end
    end
  end
end


----------------------------------------------------------------
-- REFRESH MODES
----------------------------------------------------------------
local _WMP_refreshTicker
function WMP_ApplyRefreshMode()
  if _WMP_refreshTicker and _WMP_refreshTicker.Cancel then _WMP_refreshTicker:Cancel() end
  _WMP_refreshTicker = nil
  local cfg = CFG().refresh or { mode="smart", every=10 }
  local mode = cfg.mode or "smart"
  if mode == "realtime" and C_Timer and C_Timer.NewTicker then
    local sec = Clamp(tonumber(cfg.every) or 10, 2, 60)
    _WMP_refreshTicker = C_Timer.NewTicker(sec, function()
      ScanLockouts(); ScanWeekly(); ScanQuests(); ScanEconomy()
      if ui and ui.tabs and #ui.tabs>0 then
        local i = Clamp(CFG().lastTab or 1, 1, #ui.tabs)
        if ui.tabs[i] and ui.tabs[i].Click then ui.tabs[i]:Click() end
      end
    end)
  end
end
local function WMP_ShouldReactToEvent(evt)
  local mode = (CFG().refresh and CFG().refresh.mode) or "smart"
  if mode == "manual" then return evt == "PLAYER_ENTERING_WORLD" end
  return true
end

----------------------------------------------------------------
-- EVENTS
----------------------------------------------------------------
local evAuto=CreateFrame("Frame")
evAuto:RegisterEvent("PLAYER_ENTERING_WORLD")
evAuto:RegisterEvent("QUEST_LOG_UPDATE")
evAuto:RegisterEvent("UPDATE_INSTANCE_INFO")
evAuto:RegisterEvent("CHALLENGE_MODE_COMPLETED")
evAuto:RegisterEvent("WEEKLY_REWARDS_UPDATE")
evAuto:RegisterEvent("PLAYER_MONEY")
evAuto:RegisterEvent("MERCHANT_UPDATE")
evAuto:RegisterEvent("BAG_UPDATE_DELAYED")
evAuto:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
evAuto:RegisterEvent("BANKFRAME_OPENED")
evAuto:RegisterEvent("BANKFRAME_CLOSED")
evAuto:RegisterEvent("TASK_PROGRESS_UPDATE")
evAuto:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
evAuto:RegisterEvent("BOSS_KILL")
evAuto:SetScript("OnEvent",function(_,evt)
  if evt=="PLAYER_MONEY" or evt=="MERCHANT_UPDATE" or evt=="BAG_UPDATE_DELAYED" or evt=="PLAYERBANKSLOTS_CHANGED" or evt=="BANKFRAME_OPENED" or evt=="BANKFRAME_CLOSED" then
    Ledger_OnMoneyChanged(); ScanEconomy()
    if ui and ui.tabs and ui.tabs[4] and (CFG().lastTab==4) then ui.tabs[4]:Click() end
    return
  end
  if not WMP_ShouldReactToEvent(evt) then return end
  if evAuto._pending then return end
  evAuto._pending=true
  local mode = (CFG().refresh and CFG().refresh.mode) or "smart"
  local wait = (mode=="realtime") and 0.3 or 0.8
  C_Timer.After(wait, function()
    evAuto._pending=nil
    ScanLockouts(); ScanWeekly(); ScanQuests(); ScanEconomy()
    if ui and ui.tabs and #ui.tabs>0 then local i=Clamp(CFG().lastTab or 1,1,#ui.tabs); if ui.tabs[i] and ui.tabs[i].Click then ui.tabs[i]:Click() end end
  end)
end)

local evAct=CreateFrame("Frame")
evAct:RegisterEvent("QUEST_TURNED_IN")
evAct:RegisterEvent("BOSS_KILL")
evAct:RegisterEvent("CHALLENGE_MODE_COMPLETED")
evAct:SetScript("OnEvent", function(_, event, ...)
  if event=="QUEST_TURNED_IN" then
    local qid = ...
    local title = (C_QuestLog and C_QuestLog.GetTitleForQuestID and C_QuestLog.GetTitleForQuestID(qid)) or ("Quest "..tostring(qid or "?"))
    LogActivity("quest", L("jr_quest_turnin").." "..title.." ("..tostring(qid or "?")..")")
  elseif event=="BOSS_KILL" then
    local id, name = ...
    LogActivity("boss", L("jr_boss_kill").." "..tostring(name or "?").." ("..tostring(id or "?")..")")
  elseif event=="CHALLENGE_MODE_COMPLETED" then
    local info = TryCall(C_ChallengeMode and C_ChallengeMode.GetCompletionInfo)
    local txt=L("jr_mplus_done")
    if type(info)=="table" then
      local mapName = (info.mapChallengeModeID and TryCall(C_ChallengeMode and C_ChallengeMode.GetMapUIInfo, info.mapChallengeModeID)) or nil
      if info.level then txt = txt.." +"..tostring(info.level) end
      if mapName then txt = txt.." — "..tostring(mapName) end
    end
    LogActivity("mplus", txt)
  end
end)

----------------------------------------------------------------
-- INIT
----------------------------------------------------------------
local ev=CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:SetScript("OnEvent", function()
  DBInit()
  CFG().track.currencies = ParseCurrenciesText(CFG().optText.currencies)
  CFG().track.materials  = ParseMaterialsText(CFG().optText.materials)
  if (CFG().optText.worldbosses or "") ~= "" then CFG().worldBosses = ParseWorldBossesText(CFG().optText.worldbosses) end
  BuildUI()
  WMP_ApplyRefreshMode()
  Ledger_Init()
  ScanLockouts(); ScanWeekly(); ScanQuests(); ScanEconomy()
  if ui and ui.tabs and ui.tabs[CFG().lastTab] and ui.tabs[CFG().lastTab].Click then ui.tabs[CFG().lastTab]:Click() end
  if CFG().mini.shown and BuildMinimapButton then BuildMinimapButton() end
end)
