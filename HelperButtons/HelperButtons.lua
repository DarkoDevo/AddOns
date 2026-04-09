---@diagnostic disable: undefined-global, undefined-field
local addonName, ns = ...

-- ==========================================
-- 1. SYSTEME DE TRADUCTION (LOCALES)
-- ==========================================
local lang = GetLocale()
local L = {}

L["GRAPHICS"] = "GRAPHICS"; L["INTERFACE"] = "INTERFACE & AUDIO"
L["SHARPEN_OFF"] = "Sharpen: OFF"; L["MSG_SHARPEN_OFF"] = "Sharpen Disabled"
L["SHARPEN_ON"] = "Sharpen: ON"; L["MSG_SHARPEN_ON"] = "Sharpen Enabled"
L["AA_ON"] = "Anti-Aliasing: ON"; L["MSG_AA_ON"] = "Anti-Aliasing Enabled"
L["ANTI_LAG"] = "Anti-Lag"; L["MSG_ANTI_LAG"] = "Latency Optimized"
L["CLEAN_MEM"] = "Clean Memory"; L["MSG_CLEAN_MEM"] = "Memory Cleaned"
L["VOLUME"] = "Volume (50%)"; L["MSG_VOLUME"] = "Volume set to 50%"
L["MAX_CAM"] = "Max Camera"; L["MSG_MAX_CAM"] = "Camera Distance Maxed"
L["HIDE_NAMES"] = "Hide Names"; L["MSG_HIDE_NAMES"] = "Names Hidden"
L["SHOW_NAMES"] = "Show Names"; L["MSG_SHOW_NAMES"] = "Names Shown"
L["LEAVE_PARTY"] = "Leave Party"; L["MSG_LEAVE_PARTY"] = "Party Left"
L["RELOAD"] = "RELOAD UI"

if lang == "frFR" then
    L["GRAPHICS"] = "GRAPHISMES"; L["MSG_SHARPEN_OFF"] = "Sharpen Désactivé"
    L["MSG_SHARPEN_ON"] = "Sharpen Activé"; L["MSG_AA_ON"] = "Anti-Aliasing Activé"
    L["ANTI_LAG"] = "Anti-Lag"; L["MSG_ANTI_LAG"] = "Latence Optimisée"
    L["CLEAN_MEM"] = "Nettoyer Mémoire"; L["MSG_CLEAN_MEM"] = "Mémoire Vidée"
    L["VOLUME"] = "Volume (50%)"; L["MSG_VOLUME"] = "Volume réglé à 50%"
    L["MAX_CAM"] = "Caméra Max"; L["MSG_MAX_CAM"] = "Distance Caméra Max"
    L["HIDE_NAMES"] = "Masquer Noms"; L["MSG_HIDE_NAMES"] = "Noms Masqués"
    L["SHOW_NAMES"] = "Afficher Noms"; L["MSG_SHOW_NAMES"] = "Noms Affichés"
    L["LEAVE_PARTY"] = "Quitter Groupe"; L["MSG_LEAVE_PARTY"] = "Groupe Quitté"
    L["RELOAD"] = "RECHARGER UI"
end

-- ==========================================
-- 2. FENÊTRE PRINCIPALE (DESIGN DARK)
-- ==========================================
local f = CreateFrame("Frame", "HelperButtonsFrame", UIParent, "BackdropTemplate")
f:SetSize(520, 310); f:SetPoint("CENTER"); f:SetFrameStrata("HIGH")
f:SetMovable(true); f:EnableMouse(true); f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing); f:Hide()

f:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1})
f:SetBackdropColor(0.02, 0.02, 0.02, 0.95); f:SetBackdropBorderColor(0, 0.5, 1, 0.8)

f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
f.title:SetPoint("TOP", f, "TOP", 0, -12); f.title:SetText("|cff00ccffH E L P E R|r |cffffffffP A N E L|r")

f.ms = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
f.ms:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 15, 12) 
f:SetScript("OnUpdate", function(self, elap)
    self.t = (self.t or 0) + elap
    if self.t > 1 then 
        local _, _, home, world = GetNetStats()
        if f.ms then f.ms:SetText(string.format("|cff00ff00MS:|r %d (H) / %d (W)", home, world)) end
        self.t = 0 
    end
end)

local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -2, -2)

-- ==========================================
-- 3. FONCTION BOUTON (CLIC RÉPARÉ)
-- ==========================================
local function AddBtn(text, cmd, msg, x, y, width, isTitle, color)
    local b = CreateFrame("Button", nil, f, "SecureActionButtonTemplate, UIPanelButtonTemplate")
    b:SetSize(width or 235, 26); b:SetPoint("TOPLEFT", f, "TOPLEFT", x, y)
    local fs = b:GetFontString()
    if isTitle then
        b:Disable(); b:SetText("|cff00ccff" .. text .. "|r")
        if fs then fs:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE") end
    else
        b:SetText(text); if color and fs then fs:SetTextColor(color.r, color.g, color.b) end
        b:RegisterForClicks("AnyUp", "AnyDown")
        local fullCmd = cmd
        if msg then fullCmd = cmd .. "\n/run print('|cff00ccff[Helper]|r " .. msg .. "')" end
        b:SetAttribute("type", "macro"); b:SetAttribute("macrotext", fullCmd)
    end
end

-- ==========================================
-- 4. PLACEMENT (V2.0 STABLE)
-- ==========================================
local blue, green, red = {r=0.2, g=0.6, b=1}, {r=0.2, g=1, b=0.2}, {r=1, g=0.2, b=0.2}

AddBtn(L["GRAPHICS"], "", nil, 15, -50, 235, true)
AddBtn(L["SHARPEN_OFF"], "/console set ResampleAlwaysSharpen 0", L["MSG_SHARPEN_OFF"], 15, -80, 235, false, blue)
AddBtn(L["SHARPEN_ON"], "/console set ResampleAlwaysSharpen 1", L["MSG_SHARPEN_ON"], 15, -110, 235, false, blue)
AddBtn(L["AA_ON"], "/run SetCVar('ffxAntiAliasingMode', 3)", L["MSG_AA_ON"], 15, -140, 235, false, green)
AddBtn(L["ANTI_LAG"], "/run SetCVar('SpellQueueWindow', 150)", L["MSG_ANTI_LAG"], 15, -170, 235, false, blue)
AddBtn(L["CLEAN_MEM"], "/run collectgarbage('collect')", L["MSG_CLEAN_MEM"], 15, -200, 235, false, blue)

AddBtn(L["INTERFACE"], "", nil, 270, -50, 235, true)
AddBtn(L["VOLUME"], "/run SetCVar('Sound_MasterVolume', 0.5)", L["MSG_VOLUME"], 270, -80, 235, false, green)
AddBtn(L["MAX_CAM"], "/run SetCVar('cameraDistanceMaxZoomFactor', 2.6) CameraZoomOut(50)", L["MSG_MAX_CAM"], 270, -110, 235, false, green)
AddBtn(L["HIDE_NAMES"], "/run SetCVar('UnitNameFriendlyPlayerName', 0)", L["MSG_HIDE_NAMES"], 270, -140, 235, false, green)
AddBtn(L["SHOW_NAMES"], "/run SetCVar('UnitNameFriendlyPlayerName', 1)", L["MSG_SHOW_NAMES"], 270, -170, 235, false, green)
AddBtn(L["LEAVE_PARTY"], "/run C_PartyInfo.LeaveParty()", L["MSG_LEAVE_PARTY"], 270, -200, 235, false, red)

AddBtn(L["RELOAD"], "/reload", nil, 130, -265, 260, false, red)

-- ==========================================
-- 5. MINIMAP (V2.5 - ROND & MOBILE)
-- ==========================================
local mm = CreateFrame("Button", "HelperMinimapButton", Minimap)
mm:SetSize(31, 31); mm:SetFrameLevel(10)
mm:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

local icon = mm:CreateTexture(nil, "BACKGROUND")
icon:SetTexture(132307); icon:SetSize(20, 20); icon:SetPoint("CENTER", 0, 0)

local border = mm:CreateTexture(nil, "OVERLAY")
border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
border:SetSize(53, 53); border:SetPoint("TOPLEFT", 0, 0)

local function UpdateMapPos()
    local angle = HelperDB and HelperDB.angle or 203
    mm:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 52 - (80 * cos(angle)), (80 * sin(angle)) - 52)
end

mm:RegisterForDrag("LeftButton")
mm:SetScript("OnDragStart", function(self) self:SetScript("OnUpdate", function()
    local x, y = GetCursorPosition(); local sc = Minimap:GetEffectiveScale()
    local mx, my = Minimap:GetCenter()
    HelperDB = HelperDB or {}; HelperDB.angle = deg(atan2(y/sc - my, x/sc - mx))
    UpdateMapPos()
end) end)
mm:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) end)
mm:SetScript("OnClick", function() if f:IsShown() then f:Hide() else f:Show() end end)

mm:RegisterEvent("ADDON_LOADED")
mm:SetScript("OnEvent", function(self, event, addon) if addon == addonName then UpdateMapPos() end end)

SLASH_HELPER1 = "/hb"
SlashCmdList["HELPER"] = function() if f:IsShown() then f:Hide() else f:Show() end end