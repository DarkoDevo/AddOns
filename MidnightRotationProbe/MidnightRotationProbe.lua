local addonName = ...

local Probe = CreateFrame("Frame")
_G.MidnightRotationProbe = Probe

local DB_NAME = "MidnightRotationProbeDB"
local MAX_LOG_LINES = 4000

local DEFAULTS = {
    log = {},
    watchedSpells = { 61304 }, -- GCD placeholder by default
    maxAuraSlots = 20,
    maxNameplates = 40,
    maxActionSlots = 180,
    pulseInterval = 1,
    traceInterval = 0.2,
    traceDuration = 6,
}

local POWER_TYPES = {
    { 0,  "Mana" },
    { 1,  "Rage" },
    { 2,  "Focus" },
    { 3,  "Energy" },
    { 4,  "ComboPoints" },
    { 5,  "Runes" },
    { 6,  "RunicPower" },
    { 7,  "SoulShards" },
    { 8,  "LunarPower" },
    { 9,  "HolyPower" },
    { 11, "Maelstrom" },
    { 12, "Chi" },
    { 13, "Insanity" },
    { 16, "ArcaneCharges" },
    { 17, "Fury" },
    { 18, "Pain" },
    { 19, "Essence" },
}

local BM_RUNTIME_SPELLS = {
    { name = "HuntersMark", id = 257284 },
    { name = "BarbedShot",  id = 217200 },
    { name = "KillCommand", id = 34026 },
    { name = "BestialWrath", id = 19574 },
    { name = "CobraShot", id = 193455 },
    { name = "CallPet1", id = 883 },
    { name = "CallPet2", id = 83242 },
    { name = "CallPet3", id = 83243 },
}

local UHDK_RUNTIME_SPELLS = {
    { name = "RaiseDead", id = 46584 },
    { name = "Outbreak", id = 77575 },
    { name = "Putrefy", id = 1247378 },
    { name = "FesteringStrike", id = 85948 },
    { name = "ScourgeStrike", id = 55090 },
    { name = "DeathCoil", id = 47541 },
}

local function normalizeProbeBoolean(value)
    if value == true or value == 1 then
        return true
    end
    if value == false or value == 0 then
        return false
    end
    return nil
end

local function pack(...)
    return { n = select("#", ...), ... }
end

local function wipeTable(tbl)
    if type(tbl) ~= "table" then
        return
    end
    if table.wipe then
        table.wipe(tbl)
        return
    end
    for key in pairs(tbl) do
        tbl[key] = nil
    end
end

local function mergeDefaults(dst, src)
    for key, value in pairs(src) do
        if type(value) == "table" then
            if type(dst[key]) ~= "table" then
                dst[key] = {}
            end
            mergeDefaults(dst[key], value)
        elseif dst[key] == nil then
            dst[key] = value
        end
    end
end

local function callPacked(fn, ...)
    if type(fn) ~= "function" then
        return false, pack("missing function")
    end

    local results
    local ok, err = pcall(function(...)
        results = pack(fn(...))
    end, ...)

    if not ok then
        return false, pack(err)
    end

    return true, results or pack()
end

local function isSecretValue(value)
    if type(_G.issecretvalue) ~= "function" then
        return false
    end
    local ok, result = pcall(_G.issecretvalue, value)
    return ok and result or false
end

local function isSecretTable(value)
    if type(_G.issecrettable) ~= "function" then
        return false
    end
    local ok, result = pcall(_G.issecrettable, value)
    return ok and result or false
end

local function normalizeSecretValue(value)
    if not isSecretValue(value) then
        return value
    end

    if type(_G.scrubsecretvalues) == "function" then
        local ok, scrubbed = pcall(_G.scrubsecretvalues, value)
        if ok and not isSecretValue(scrubbed) then
            return scrubbed
        end
    end

    return nil
end

local function normalizeSecretNumber(value, fallback)
    local normalized = normalizeSecretValue(value)
    if type(normalized) == "number" then
        return normalized
    end

    return fallback
end

local function shouldSkipProtectedCall(fn)
    if fn == CheckInteractDistance and type(InCombatLockdown) == "function" and InCombatLockdown() then
        return true, "skipped protected call in combat"
    end

    return false
end

local function tablePreview(value, depth)
    depth = depth or 0

    if isSecretTable(value) then
        return "<secret-table>"
    end

    if depth >= 2 then
        return "{...}"
    end

    local ok, text = pcall(function()
        local parts = {}
        local count = 0

        for key, subValue in pairs(value) do
            count = count + 1
            if count > 12 then
                parts[#parts + 1] = "..."
                break
            end
            parts[#parts + 1] = tostring(key) .. "=" .. Probe:ValueToString(subValue, depth + 1)
        end

        return "{ " .. table.concat(parts, ", ") .. " }"
    end)

    return ok and text or "<table:inspect-error>"
end

function Probe:ValueToString(value, depth)
    depth = depth or 0

    if isSecretValue(value) then
        return "<secret>"
    end

    local valueType = type(value)
    if value == nil then
        return "nil"
    elseif valueType == "string" then
        return string.format("%q", value)
    elseif valueType == "number" or valueType == "boolean" then
        return tostring(value)
    elseif valueType == "table" then
        return tablePreview(value, depth)
    elseif valueType == "function" then
        return "<function>"
    elseif valueType == "userdata" then
        return "<userdata>"
    elseif valueType == "thread" then
        return "<thread>"
    end

    return "<" .. valueType .. ">"
end

local function packedHasSecrets(results)
    if type(results) ~= "table" then
        return false
    end

    for index = 1, results.n or 0 do
        local value = results[index]

        if isSecretValue(value) or isSecretTable(value) then
            return true
        end

        if type(value) == "table" then
            local ok, found = pcall(function()
                for _, key in ipairs({
                    "name", "spellId", "applications", "dispelName", "duration", "expirationTime",
                    "sourceUnit", "isStealable", "isBossAura", "isFromPlayerOrPlayerPet",
                    "startTime", "modRate", "currentCharges", "maxCharges", "charges",
                }) do
                    local subValue = value[key]
                    if isSecretValue(subValue) or isSecretTable(subValue) then
                        return true
                    end
                end
                return false
            end)
            if ok and found then
                return true
            end
        end
    end

    return false
end

local function formatPacked(results)
    if type(results) ~= "table" then
        return "<not-packed>"
    end

    if (results.n or 0) == 0 then
        return "<no values>"
    end

    local parts = {}
    for index = 1, results.n do
        parts[index] = Probe:ValueToString(results[index], 0)
    end
    return table.concat(parts, " || ")
end

local function getBuildText()
    if type(GetBuildInfo) ~= "function" then
        return "unknown-build"
    end
    local version, build, dateText, interface = GetBuildInfo()
    return string.format("version=%s build=%s date=%s interface=%s", tostring(version), tostring(build), tostring(dateText), tostring(interface))
end

local function parseSpellList(text)
    local output = {}
    for token in string.gmatch(text or "", "[^,%s]+") do
        local numeric = tonumber(token)
        if numeric then
            output[#output + 1] = numeric
        else
            output[#output + 1] = token
        end
    end
    return output
end

local function getNPCIDFromGUID(guid)
    if not guid or type(strsplit) ~= "function" then
        return nil
    end

    local unitType, _, _, _, _, npcID = strsplit("-", guid)
    if unitType == "Creature" or unitType == "Vehicle" or unitType == "Pet" or unitType == "Vignette" then
        return tonumber(npcID)
    end

    return nil
end

local function safeIndex(value, key)
    if value == nil then
        return nil
    end

    local ok, result = pcall(function()
        return value[key]
    end)

    if ok then
        return result
    end

    return nil
end

local function getMakuluFramework()
    return rawget(_G, "MakuluFramework") or rawget(_G, "MakuluFramwork")
end

local function getFrameworkUnit(unit)
    local framework = getMakuluFramework()
    local constUnits = framework and safeIndex(framework, "ConstUnits")
    if type(constUnits) ~= "table" then
        return nil
    end

    return safeIndex(constUnits, unit)
end

local function getFrameworkSpell(spellId)
    local framework = getMakuluFramework()
    local spellLookup = framework and safeIndex(framework, "spellLookup")
    if type(spellLookup) ~= "table" then
        return nil
    end

    return safeIndex(spellLookup, spellId)
end

local function getUHDKSpellBook()
    local action = rawget(_G, "Action")
    local actionConst = action and safeIndex(action, "Const")
    local specID = actionConst and safeIndex(actionConst, "DEATHKNIGHT_UNHOLY")
    return specID and safeIndex(action, specID) or nil
end

local function getEditBoxTextHeight(editBox)
    if not editBox then
        return 0
    end

    local fontString = editBox.GetFontString and editBox:GetFontString()
    if fontString and fontString.GetStringHeight then
        return fontString:GetStringHeight()
    end

    local _, lineHeight = editBox:GetFont()
    lineHeight = tonumber(lineHeight) or 14

    if editBox.GetNumLines then
        return math.max(1, editBox:GetNumLines()) * lineHeight
    end

    return lineHeight
end

local function clampScrollValue(scrollFrame, value)
    if not scrollFrame or type(value) ~= "number" then
        return 0
    end

    local maxValue = scrollFrame.GetVerticalScrollRange and scrollFrame:GetVerticalScrollRange() or 0
    if maxValue < 0 then
        maxValue = 0
    end

    if value < 0 then
        return 0
    end

    if value > maxValue then
        return maxValue
    end

    return value
end

local function getScrollStep(editBox)
    local lineHeight = 14
    if editBox and editBox.GetFont then
        local _, fontHeight = editBox:GetFont()
        lineHeight = tonumber(fontHeight) or lineHeight
    end

    return math.max(14, lineHeight * 3)
end

local function updateLogEditBoxLayout(scrollFrame, editBox)
    if not scrollFrame or not editBox then
        return
    end

    local scrollBar = scrollFrame.GetName and _G[scrollFrame:GetName() .. "ScrollBar"] or nil
    local scrollBarWidth = scrollBar and scrollBar.GetWidth and scrollBar:GetWidth() or 16
    local availableWidth = math.max(1, scrollFrame:GetWidth() - scrollBarWidth - 8)
    local desiredHeight = math.max(scrollFrame:GetHeight(), getEditBoxTextHeight(editBox) + 20)

    editBox:SetWidth(availableWidth)
    editBox:SetHeight(desiredHeight)

    if scrollFrame.UpdateScrollChildRect then
        scrollFrame:UpdateScrollChildRect()
    end
end

local function scrollEditBoxByDelta(scrollFrame, editBox, delta)
    if not scrollFrame or not editBox or type(delta) ~= "number" then
        return
    end

    local current = scrollFrame.GetVerticalScroll and scrollFrame:GetVerticalScroll() or 0
    scrollFrame:SetVerticalScroll(clampScrollValue(scrollFrame, current + delta))
end

function Probe:AddLog(message)
    if not self.db then
        return
    end

    local stamp = date("%H:%M:%S")
    local line = string.format("[%s] %s", stamp, tostring(message))

    self.db.log[#self.db.log + 1] = line
    while #self.db.log > MAX_LOG_LINES do
        table.remove(self.db.log, 1)
    end

    if self.ui and self.ui.frame and self.ui.frame:IsShown() then
        self:RefreshUI()
    end
end

function Probe:RefreshUI()
    if not self.ui or not self.ui.editBox then
        return
    end

    local text = table.concat(self.db.log or {}, "\n")
    local currentScroll = self.ui.scrollFrame:GetVerticalScroll() or 0
    local currentRange = self.ui.scrollFrame:GetVerticalScrollRange() or 0
    local wasNearBottom = currentRange <= 0 or currentScroll >= (currentRange - getScrollStep(self.ui.editBox))
    local hadFocus = self.ui.editBox.HasFocus and self.ui.editBox:HasFocus() or false
    local cursorPosition = hadFocus and self.ui.editBox:GetCursorPosition() or nil

    self.ui.editBox:SetText(text)
    if hadFocus then
        self.ui.editBox:SetCursorPosition(math.min(tonumber(cursorPosition) or 0, text:len()))
    end

    updateLogEditBoxLayout(self.ui.scrollFrame, self.ui.editBox)

    if self.ui.scrollFrame.SetVerticalScroll then
        local targetScroll = wasNearBottom and self.ui.scrollFrame:GetVerticalScrollRange() or currentScroll
        self.ui.scrollFrame:SetVerticalScroll(clampScrollValue(self.ui.scrollFrame, targetScroll))
    end
end

function Probe:ToggleUI(forceShow)
    if not self.ui then
        return
    end

    if forceShow == true then
        self.ui.frame:Show()
    elseif forceShow == false then
        self.ui.frame:Hide()
    else
        if self.ui.frame:IsShown() then
            self.ui.frame:Hide()
        else
            self.ui.frame:Show()
        end
    end

    self:RefreshUI()
end

function Probe:MakeButton(parent, text, width, onClick)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetSize(width or 90, 22)
    button:SetText(text)
    button:SetScript("OnClick", onClick)
    return button
end

function Probe:RunCommand(command)
    self:HandleSlash(command or "")
end

function Probe:RunCommandSequence(commands)
    if type(commands) ~= "table" then
        return
    end

    for _, command in ipairs(commands) do
        self:RunCommand(command)
    end
end

function Probe:CreateUI()
    if self.ui then
        return
    end

    local frame = CreateFrame("Frame", addonName .. "Frame", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
    local initW = (self.db and type(self.db.windowWidth) == "number") and self.db.windowWidth or 900
    local initH = (self.db and type(self.db.windowHeight) == "number") and self.db.windowHeight or 580
    frame:SetSize(initW, initH)
    if self.db and type(self.db.windowX) == "number" and type(self.db.windowY) == "number" then
        frame:SetPoint(self.db.windowPoint or "CENTER", UIParent, self.db.windowPoint or "CENTER", self.db.windowX, self.db.windowY)
    else
        frame:SetPoint("CENTER")
    end
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(selfFrame)
        selfFrame:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(selfFrame)
        selfFrame:StopMovingOrSizing()
        local point, _, _, x, y = selfFrame:GetPoint()
        if Probe.db then
            Probe.db.windowPoint = point
            Probe.db.windowX = x
            Probe.db.windowY = y
        end
    end)
    if frame.SetBackdrop then
        frame:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        frame:SetBackdropColor(0, 0, 0, 0.9)
        frame:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
    end

    frame:SetResizable(true)
    if frame.SetResizeBounds then
        frame:SetResizeBounds(400, 250)
    elseif frame.SetMinResize then
        frame:SetMinResize(400, 250)
    end

    local resizeGrip = CreateFrame("Button", nil, frame)
    resizeGrip:SetSize(16, 16)
    resizeGrip:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
    resizeGrip:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    resizeGrip:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    resizeGrip:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    resizeGrip:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then
            frame:StartSizing("BOTTOMRIGHT")
        end
    end)
    resizeGrip:SetScript("OnMouseUp", function()
        frame:StopMovingOrSizing()
        if Probe.db then
            Probe.db.windowWidth = frame:GetWidth()
            Probe.db.windowHeight = frame:GetHeight()
        end
    end)

    frame:Hide()

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOPLEFT", 12, -10)
    title:SetText("Midnight Rotation Probe")

    local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
    subtitle:SetText("Diagnostic log for readable vs secret combat data")

    local closeButton = self:MakeButton(frame, "Close", 70, function()
        self:ToggleUI(false)
    end)
    closeButton:SetPoint("TOPRIGHT", -12, -10)

    local rowOne = CreateFrame("Frame", nil, frame)
    rowOne:SetPoint("TOPLEFT", 12, -52)
    rowOne:SetPoint("TOPRIGHT", -12, -52)
    rowOne:SetHeight(22)

    local rowTwo = CreateFrame("Frame", nil, frame)
    rowTwo:SetPoint("TOPLEFT", rowOne, "BOTTOMLEFT", 0, -6)
    rowTwo:SetPoint("TOPRIGHT", rowOne, "BOTTOMRIGHT", 0, -6)
    rowTwo:SetHeight(22)

    local setupButton = self:MakeButton(rowOne, "UHDK Setup", 100, function()
        self:RunCommandSequence({
            "clear",
            "watch 1247378",
            "uhdk",
        })
    end)
    setupButton:SetPoint("TOPLEFT", rowOne, "TOPLEFT", 0, 0)

    local uhdkButton = self:MakeButton(rowOne, "UHDK", 70, function()
        self:RunCommand("uhdk")
    end)
    uhdkButton:SetPoint("LEFT", setupButton, "RIGHT", 6, 0)

    local watchPutrefyButton = self:MakeButton(rowOne, "Watch Putrefy", 110, function()
        self:RunCommand("watch 1247378")
    end)
    watchPutrefyButton:SetPoint("LEFT", uhdkButton, "RIGHT", 6, 0)

    local pulseOneButton = self:MakeButton(rowOne, "Pulse 1", 70, function()
        self:RunCommand("pulse 1")
    end)
    pulseOneButton:SetPoint("LEFT", watchPutrefyButton, "RIGHT", 6, 0)

    local traceButton = self:MakeButton(rowOne, "Trace 6", 70, function()
        self:RunCommand("trace 6 0.5")
    end)
    traceButton:SetPoint("LEFT", pulseOneButton, "RIGHT", 6, 0)

    local clearButton = self:MakeButton(rowOne, "Clear", 70, function()
        self:RunCommand("clear")
    end)
    clearButton:SetPoint("LEFT", traceButton, "RIGHT", 6, 0)

    local runtimeButton = self:MakeButton(rowTwo, "Runtime", 80, function()
        self:RunCommand("runtime")
    end)
    runtimeButton:SetPoint("TOPLEFT", rowTwo, "TOPLEFT", 0, 0)

    local scanButton = self:MakeButton(rowTwo, "Full Scan", 90, function()
        self:RunCommand("scan")
    end)
    scanButton:SetPoint("LEFT", runtimeButton, "RIGHT", 6, 0)

    local nameplateButton = self:MakeButton(rowTwo, "Nameplates", 90, function()
        self:RunCommand("nameplates")
    end)
    nameplateButton:SetPoint("LEFT", scanButton, "RIGHT", 6, 0)

    local pulseOffButton = self:MakeButton(rowTwo, "Pulse Off", 80, function()
        self:RunCommand("pulse off")
    end)
    pulseOffButton:SetPoint("LEFT", nameplateButton, "RIGHT", 6, 0)

    local traceOffButton = self:MakeButton(rowTwo, "Trace Off", 80, function()
        self:RunCommand("trace off")
    end)
    traceOffButton:SetPoint("LEFT", pulseOffButton, "RIGHT", 6, 0)

    local scrollFrame = CreateFrame("ScrollFrame", addonName .. "ScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 12, -114)
    scrollFrame:SetPoint("BOTTOMRIGHT", -34, 12)
    scrollFrame:EnableMouseWheel(true)

    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetAutoFocus(false)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", 0, 0)
    editBox:SetWidth(840)
    editBox:SetScript("OnEscapePressed", function(selfBox)
        selfBox:ClearFocus()
    end)
    editBox:SetScript("OnTextChanged", function(selfBox)
        updateLogEditBoxLayout(scrollFrame, selfBox)
    end)
    editBox:SetScript("OnCursorChanged", function(selfBox, _, y, _, height)
        if not (selfBox.HasFocus and selfBox:HasFocus()) then
            return
        end

        local scroll = scrollFrame:GetVerticalScroll()
        local frameHeight = scrollFrame:GetHeight()
        if y < scroll then
            scrollFrame:SetVerticalScroll(clampScrollValue(scrollFrame, y))
        elseif (y + height) > (scroll + frameHeight) then
            scrollFrame:SetVerticalScroll(clampScrollValue(scrollFrame, y + height - frameHeight))
        end
    end)
    editBox:EnableMouseWheel(true)
    editBox:SetScript("OnMouseWheel", function(selfBox, delta)
        if selfBox.HasFocus and selfBox:HasFocus() then
            selfBox:ClearFocus()
        end

        scrollEditBoxByDelta(scrollFrame, editBox, -delta * getScrollStep(editBox))
    end)

    scrollFrame:SetScript("OnMouseWheel", function(_, delta)
        if editBox.HasFocus and editBox:HasFocus() then
            editBox:ClearFocus()
        end

        scrollEditBoxByDelta(scrollFrame, editBox, -delta * getScrollStep(editBox))
    end)
    scrollFrame:SetScript("OnSizeChanged", function()
        updateLogEditBoxLayout(scrollFrame, editBox)
    end)

    scrollFrame:SetScrollChild(editBox)

    self.ui = {
        frame = frame,
        scrollFrame = scrollFrame,
        editBox = editBox,
        title = title,
        subtitle = subtitle,
    }
end

function Probe:TryCall(label, fn, ...)
    local status
    local results

    if type(fn) ~= "function" then
        status = "MISSING"
        results = pack("missing function")
    else
        local skip, reason = shouldSkipProtectedCall(fn)
        if skip then
            status = "SKIPPED"
            results = pack(reason)
        else
            local ok
            ok, results = callPacked(fn, ...)
            if not ok then
                status = "ERROR"
            elseif (results.n or 0) == 0 or ((results.n or 0) == 1 and results[1] == nil) then
                status = "NIL"
            elseif packedHasSecrets(results) then
                status = "SECRET"
            else
                status = "OK"
            end
        end
    end

    self:AddLog(label .. " -> " .. status .. " :: " .. formatPacked(results))
    return status, results
end

function Probe:Evaluate(label, fn)
    local ok, results = callPacked(fn)
    local status

    if not ok then
        status = "ERROR"
    elseif (results.n or 0) == 0 or ((results.n or 0) == 1 and results[1] == nil) then
        status = "NIL"
    elseif packedHasSecrets(results) then
        status = "SECRET"
    else
        status = "OK"
    end

    self:AddLog("MATRIX " .. label .. " -> " .. status .. " :: " .. formatPacked(results))
    return status, results
end

function Probe:LogValue(label, value)
    local status

    if value == nil then
        status = "NIL"
    elseif packedHasSecrets(pack(value)) then
        status = "SECRET"
    else
        status = "OK"
    end

    self:AddLog(label .. " -> " .. status .. " :: " .. self:ValueToString(value, 0))
    return status, value
end

function Probe:CompactCastInfo(cast)
    if cast == nil then
        return nil
    end

    return {
        name = safeIndex(cast, "name"),
        spellId = safeIndex(cast, "spellId"),
        spellID = safeIndex(cast, "spellID"),
        channel = safeIndex(cast, "channel"),
        restricted = safeIndex(cast, "restricted"),
        startTime = safeIndex(cast, "startTime"),
        endTime = safeIndex(cast, "endTime"),
        castLength = safeIndex(cast, "castLength"),
        remaining = safeIndex(cast, "remaining"),
        elapsed = safeIndex(cast, "elapsed"),
        percent = safeIndex(cast, "percent"),
    }
end

function Probe:CompactSpellState(spellState)
    if spellState == nil then
        return nil
    end

    return {
        casted = safeIndex(spellState, "casted"),
        castingLockdown = safeIndex(spellState, "castingLockdown"),
        gcdHold = safeIndex(spellState, "gcdHold"),
        icon = safeIndex(spellState, "icon"),
    }
end

function Probe:CompactRuntimeSpell(spell)
    if spell == nil then
        return nil
    end

    return {
        id = safeIndex(spell, "id"),
        spellId = safeIndex(spell, "spellId"),
        wowName = safeIndex(spell, "wowName"),
        offGcd = safeIndex(spell, "offGcd"),
        ignoreCasting = safeIndex(spell, "ignoreCasting"),
        ignoreRange = safeIndex(spell, "ignoreRange"),
        ignoreMoving = safeIndex(spell, "ignoreMoving"),
        channel = safeIndex(spell, "channel"),
        targeted = safeIndex(spell, "targeted"),
        lastAttemptTime = safeIndex(spell, "lastAttemptTime"),
        lastUsed = safeIndex(spell, "lastUsed"),
    }
end

function Probe:CaptureRotationCall(primaryRotation)
    local tmw = rawget(_G, "TMW")
    local originalFire = tmw and tmw.Fire
    local fireRecord
    local fakeIcon = {
        ID = "MidnightProbeA3",
        attributes = {
            state = 0,
            texture = "",
            realAlpha = 1,
            calculatedState = { Color = "ffffffff" },
        },
    }

    function fakeIcon:SetInfo(attr, ...)
        self.lastAttr = attr
        self.lastArgs = pack(...)

        if type(attr) == "string" and string.find(attr, "state", 1, true) then
            self.lastState = select(1, ...)
        end

        if type(attr) == "string" and string.find(attr, "texture", 1, true) then
            self.lastTexture = select(select("#", ...), ...)
            self.attributes.texture = self.lastTexture
        end
    end

    if tmw then
        tmw.Fire = function(_, event, iconID, actionObject, texture)
            fireRecord = {
                event = event,
                iconID = iconID,
                texture = texture,
                actionID = safeIndex(actionObject, "ID"),
                actionType = safeIndex(actionObject, "Type"),
                actionDesc = safeIndex(actionObject, "Desc"),
            }

            local keyNameFn = actionObject and safeIndex(actionObject, "GetKeyName")
            if type(keyNameFn) == "function" then
                local okKeyName, keyName = pcall(keyNameFn, actionObject)
                if okKeyName then
                    fireRecord.keyName = keyName
                end
            end
        end
    end

    local okRotation, result = xpcall(function()
        return primaryRotation(fakeIcon)
    end, function(err)
        return tostring(err)
    end)

    if tmw then
        tmw.Fire = originalFire
    end

    if not okRotation then
        error(result, 0)
    end

    return {
        returned = result,
        fire = fireRecord,
        iconAttr = fakeIcon.lastAttr,
        iconState = fakeIcon.lastState,
        iconTexture = fakeIcon.lastTexture,
    }
end

function Probe:ScanRuntimeSpell(entry)
    local label = string.format("mak.spell.%s[%s]", tostring(entry.name), tostring(entry.id))
    local spell = getFrameworkSpell(entry.id)
    self:LogValue(label .. ".object", self:CompactRuntimeSpell(spell))

    if not spell then
        return
    end

    local target = getFrameworkUnit("target") or getFrameworkUnit("player")

    self:TryCall(label .. ":IsKnown", function()
        return spell:IsKnown()
    end)
    self:TryCall(label .. ":Cooldown", function()
        return spell:Cooldown()
    end)
    self:TryCall(label .. ":ReadyToUse", function()
        return spell:ReadyToUse()
    end)
    self:TryCall(label .. ":Usable(target)", function()
        return spell:Usable(target)
    end)
    self:TryCall(label .. ":InRange(target)", function()
        return spell:InRange(target)
    end)
    self:TryCall(label .. ":Charges", function()
        return spell:Charges()
    end)
    self:TryCall(label .. ":Fraction", function()
        return spell:Fraction()
    end)
    self:TryCall(label .. ":TimeToFullCharges", function()
        return spell:TimeToFullCharges()
    end)
end

function Probe:ScanUnholyDKRuntime()
    self:AddLog("=== UHDK RUNTIME ===")

    local action = rawget(_G, "Action")
    local actionUnit = action and safeIndex(action, "Unit")
    local actionPlayerFactory = action and safeIndex(action, "Player")
    local actionConst = action and safeIndex(action, "Const")
    local specID = actionConst and safeIndex(actionConst, "DEATHKNIGHT_UNHOLY")
    local spellBook = getUHDKSpellBook()
    local okTargetUnit, targetUnit = pcall(function()
	    return actionUnit and actionUnit("target") or nil
    end)
    local okPlayerUnit, playerUnit = pcall(function()
	    return actionUnit and actionUnit("player") or nil
    end)
    targetUnit = okTargetUnit and targetUnit or nil
    playerUnit = okPlayerUnit and playerUnit or nil
    local playerObject = actionPlayerFactory
    local lesserGhoulBuff = spellBook and safeIndex(spellBook, "LesserGhoulBuff")
    local lesserGhoulBuffID = lesserGhoulBuff and safeIndex(lesserGhoulBuff, "ID")
    local outbreakInfectingDebuffID = 196782
    local virulentPlagueDebuff = spellBook and safeIndex(spellBook, "VirulentPlagueDebuff")
    local virulentPlagueDebuffID = virulentPlagueDebuff and safeIndex(virulentPlagueDebuff, "ID")
    local dreadPlagueDebuff = spellBook and safeIndex(spellBook, "DreadPlagueDebuff")
    local dreadPlagueDebuffID = dreadPlagueDebuff and safeIndex(dreadPlagueDebuff, "ID")
    local function FindMatchingNameplateUnitID()
        if type(UnitExists) ~= "function" or type(UnitGUID) ~= "function" or not UnitExists("target") then
            return nil
        end

        local targetGUID = UnitGUID("target")
        if not targetGUID then
            return nil
        end

        for i = 1, 40 do
            local unitID = "nameplate" .. i
            if UnitExists(unitID) and UnitGUID(unitID) == targetGUID then
                return unitID
            end
        end

        return nil
    end
    local matchingNameplateUnitID = FindMatchingNameplateUnitID()
    local okMatchingNameplateUnit, matchingNameplateUnit = pcall(function()
        return matchingNameplateUnitID and actionUnit and actionUnit(matchingNameplateUnitID) or nil
    end)
    matchingNameplateUnit = okMatchingNameplateUnit and matchingNameplateUnit or nil

    local function AddUnitDebuffDiagnostics(label, unitObject, spellID)
        if type(spellID) ~= "number" then
            self:AddLog(label .. " diagnostics skipped: spell ID missing.")
            return
        end

        self:LogValue(label .. ".ID", spellID)
        self:TryCall(label .. ".HasDeBuffs(player)", function()
            return unitObject and unitObject:HasDeBuffs(spellID, true)
        end)
        self:TryCall(label .. ".HasDeBuffs(player,byID)", function()
            return unitObject and unitObject:HasDeBuffs(spellID, true, true)
        end)
        self:TryCall(label .. ".HasDeBuffs(any)", function()
            return unitObject and unitObject:HasDeBuffs(spellID)
        end)
        self:TryCall(label .. ".HasDeBuffs(any,byID)", function()
            return unitObject and unitObject:HasDeBuffs(spellID, nil, true)
        end)
        self:TryCall(label .. ".IsDebuffDown(player)", function()
            return unitObject and type(unitObject.IsDebuffDown) == "function" and unitObject:IsDebuffDown(spellID, true) or nil
        end)
        self:TryCall(label .. ".IsDebuffDown(player,byID)", function()
            return unitObject and type(unitObject.IsDebuffDown) == "function" and unitObject:IsDebuffDown(spellID, true, true) or nil
        end)
    end

    self:LogValue("uhdk.action", action ~= nil)
    self:LogValue("uhdk.specID", specID)
    self:LogValue("uhdk.spellBook", spellBook ~= nil)
    self:LogValue("uhdk.zone", action and safeIndex(action, "Zone"))

    if not action or not actionUnit or not spellBook then
        self:AddLog("UHDK runtime scan aborted: Action, Action.Unit, or spell table missing.")
        return
    end

    self:TryCall("uhdk.toggle.stopCast", function()
        return action.GetToggle and action.GetToggle(1, "StopCast")
    end)
    self:TryCall("uhdk.toggle.checkbox4", function()
        return action.GetToggle and action.GetToggle(2, "Checkbox4")
    end)
    self:TryCall("uhdk.player.castingRemains", function()
        return playerUnit and playerUnit:IsCastingRemains()
    end)
    self:TryCall("uhdk.player.quakingDebuff", function()
        return playerUnit and playerUnit:HasDeBuffs(240447)
    end)
    self:TryCall("uhdk.target.grimrailCast", function()
        return targetUnit and targetUnit:IsCastingRemains(161087)
    end)
    self:TryCall("uhdk.needStopCast", function()
        local stopToggle = action.GetToggle and action.GetToggle(1, "StopCast")
        local castingRemains = playerUnit and playerUnit:IsCastingRemains() or 0
        if not stopToggle or not castingRemains or castingRemains <= 0 then
            return false
        end

        local quaking = playerUnit and playerUnit:HasDeBuffs(240447) or 0
        if quaking and quaking > 0 and quaking < 0.5 then
            return true
        end

        local grimrail = targetUnit and targetUnit:IsCastingRemains(161087) or 0
        return grimrail and grimrail > 0 and grimrail < 0.5 or false
    end)

    self:TryCall("uhdk.gateEnemy", function()
        return action.IsUnitEnemy and action.IsUnitEnemy("target")
    end)
    self:TryCall("uhdk.gateEngage", function()
        return targetUnit and targetUnit:IsExists() and ((UnitCanAttack and UnitCanAttack("player", "target")) or targetUnit:IsEnemy())
    end)
    self:TryCall("uhdk.player.combatTime", function()
        return playerUnit and playerUnit:CombatTime()
    end)
    self:TryCall("uhdk.target.combatTime", function()
        return targetUnit and targetUnit:CombatTime()
    end)
    self:TryCall("uhdk.player.healthPercent", function()
        return playerUnit and playerUnit:HealthPercent()
    end)
    self:TryCall("uhdk.target.exists", function()
        return targetUnit and targetUnit:IsExists()
    end)
    self:TryCall("uhdk.target.enemy", function()
        return targetUnit and targetUnit:IsEnemy()
    end)
    self:TryCall("uhdk.target.canAttack", function()
        return UnitCanAttack and UnitCanAttack("player", "target")
    end)
    self:TryCall("uhdk.player.runes", function()
        return playerObject and playerObject:Rune()
    end)
    self:TryCall("uhdk.pet.alive", function()
        if type(UnitExists) ~= "function" or not UnitExists("pet") then
            return false
        end
        return not (type(UnitIsDead) == "function" and UnitIsDead("pet"))
    end)
    self:TryCall("uhdk.currentGCD", function()
        return action.GetCurrentGCD and action.GetCurrentGCD()
    end)
    self:LogValue("uhdk.target.matchingNameplate", matchingNameplateUnitID)
    AddUnitDebuffDiagnostics("uhdk.target.OutbreakInfecting", targetUnit, outbreakInfectingDebuffID)
    AddUnitDebuffDiagnostics("uhdk.target.VirulentPlague", targetUnit, virulentPlagueDebuffID)
    AddUnitDebuffDiagnostics("uhdk.target.DreadPlague", targetUnit, dreadPlagueDebuffID)
    if matchingNameplateUnitID then
        AddUnitDebuffDiagnostics("uhdk.nameplate.OutbreakInfecting", matchingNameplateUnit, outbreakInfectingDebuffID)
        AddUnitDebuffDiagnostics("uhdk.nameplate.VirulentPlague", matchingNameplateUnit, virulentPlagueDebuffID)
        AddUnitDebuffDiagnostics("uhdk.nameplate.DreadPlague", matchingNameplateUnit, dreadPlagueDebuffID)
    end
    if lesserGhoulBuffID then
        self:TryCall("uhdk.lesserGhoulStacks.Unit(player)", function()
            return playerUnit and playerUnit:HasBuffsStacks(lesserGhoulBuffID, true)
        end)
        self:TryCall("uhdk.lesserGhoulRemain.Unit(player)", function()
            return playerUnit and playerUnit:HasBuffs(lesserGhoulBuffID, true)
        end)
        self:TryCall("uhdk.lesserGhoulDown.Unit(player)", function()
            local remain = playerUnit and playerUnit:HasBuffs(lesserGhoulBuffID, true) or 0
            return remain == 0
        end)
    else
        self:AddLog("uhdk.lesserGhoul diagnostics skipped: LesserGhoulBuff missing.")
    end

    local primaryRotation = safeIndex(spellBook, 3)
    self:LogValue("uhdk.rotation[3].exists", type(primaryRotation) == "function")
    if type(primaryRotation) == "function" then
        self:TryCall("uhdk.rotation[3](probeIcon)", function()
            return self:CaptureRotationCall(primaryRotation)
        end)
    end

    for _, entry in ipairs(UHDK_RUNTIME_SPELLS) do
        local spell = safeIndex(spellBook, entry.name)
        local label = string.format("uhdk.spell.%s[%s]", tostring(entry.name), tostring(entry.id))

        self:LogValue(label .. ".object", spell ~= nil)
        if spell then
            self:TryCall(label .. ":IsTalentLearned", function()
                return spell:IsTalentLearned()
            end)
            self:TryCall(label .. ":IsBlockedByAny", function()
                return spell:IsBlockedByAny()
            end)
            self:TryCall(label .. ":GetCooldown", function()
                return spell:GetCooldown()
            end)
            self:TryCall(label .. ":GetSpellCharges", function()
                return spell:GetSpellCharges()
            end)
            self:TryCall(label .. ":GetSpellChargesMax", function()
                return spell:GetSpellChargesMax()
            end)
            self:TryCall(label .. ":GetSpellChargesFrac", function()
                return spell:GetSpellChargesFrac()
            end)
            self:TryCall(label .. ":GetSpellChargesFullRechargeTime", function()
                return spell:GetSpellChargesFullRechargeTime()
            end)
            self:TryCall(label .. ":IsCastable(target)", function()
                return spell:IsCastable("target")
            end)
            self:TryCall(label .. ":RunLua(target)", function()
                return spell:RunLua("target")
            end)
            self:TryCall(label .. ":IsReadyByPassCastGCD(target)", function()
                return spell:IsReadyByPassCastGCD("target")
            end)
            self:TryCall(label .. ":IsReady(target)", function()
                return spell:IsReady("target")
            end)
            self:TryCall(label .. ":IsUsable", function()
                return spell:IsUsable()
            end)
            self:TryCall(label .. ":IsSpellInRange(target)", function()
                return spell:IsSpellInRange("target")
            end)
        end

        self:TryCall(label .. ":TMW.IsUsableSpell", function()
            local tmw = rawget(_G, "TMW")
            local common = tmw and safeIndex(tmw, "COMMON")
            local spellUsable = common and safeIndex(common, "SpellUsable")
            local fn = spellUsable and safeIndex(spellUsable, "IsUsableSpell")
            return fn and fn(entry.id)
        end)
        self:TryCall(label .. ":SecretEngine.SafeIsSpellUsable", function()
            local secretEngine = safeIndex(action, "SecretEngine")
            local fn = secretEngine and safeIndex(secretEngine, "SafeIsSpellUsable")
            return fn and fn(secretEngine, entry.id)
        end)
        self:TryCall(label .. ":C_Spell.GetSpellCooldown", function()
            if C_Spell and type(C_Spell.GetSpellCooldown) == "function" then
                return C_Spell.GetSpellCooldown(entry.id)
            end
        end)
        self:TryCall(label .. ":C_Spell.GetSpellCharges", function()
            if C_Spell and type(C_Spell.GetSpellCharges) == "function" then
                return C_Spell.GetSpellCharges(entry.id)
            end
        end)
        self:TryCall(label .. ":C_Spell.IsSpellUsable", function()
            if C_Spell and type(C_Spell.IsSpellUsable) == "function" then
                return C_Spell.IsSpellUsable(entry.id)
            end
        end)
        self:TryCall(label .. ":IsUsableSpell", function()
            if type(IsUsableSpell) == "function" then
                return IsUsableSpell(entry.id)
            end
        end)
        self:TryCall(label .. ":BasicLikeReady", function()
            local usable
            local tmw = rawget(_G, "TMW")
            local common = tmw and safeIndex(tmw, "COMMON")
            local spellUsable = common and safeIndex(common, "SpellUsable")
            local tmwUsable = spellUsable and safeIndex(spellUsable, "IsUsableSpell")
            if type(tmwUsable) == "function" then
                local ok, value = pcall(tmwUsable, entry.id)
                if ok then
                    usable = normalizeProbeBoolean(value)
                end
            end

            if usable == nil then
                local secretEngine = safeIndex(action, "SecretEngine")
                local fn = secretEngine and safeIndex(secretEngine, "SafeIsSpellUsable")
                if type(fn) == "function" then
                    local ok, value = pcall(fn, secretEngine, entry.id)
                    if ok then
                        usable = normalizeProbeBoolean(value)
                    end
                end
            end

            if usable == nil and C_Spell and type(C_Spell.IsSpellUsable) == "function" then
                local ok, value = pcall(C_Spell.IsSpellUsable, entry.id)
                if ok then
                    usable = normalizeProbeBoolean(value)
                end
            end

            if usable == nil and type(IsUsableSpell) == "function" then
                local ok, value = pcall(IsUsableSpell, entry.id)
                if ok then
                    usable = normalizeProbeBoolean(value)
                end
            end

            if usable == false then
                return false
            end

            local gcd = action.GetCurrentGCD and action.GetCurrentGCD() or 0
            local cooldown = spell and spell.GetCooldown and spell:GetCooldown() or nil
            if type(cooldown) ~= "number" then
                return nil
            end

            return cooldown <= ((tonumber(gcd) or 0) + 0.15)
        end)
    end
end

function Probe:ScanMakuluRuntime()
    self:AddLog("=== MAKULU RUNTIME ===")

    local framework = getMakuluFramework()
    self:LogValue("makulu.framework", framework ~= nil)
    self:LogValue("makulu.action", rawget(_G, "Action") ~= nil)

    if not framework then
        return
    end

    self:LogValue("makulu.burstMode", safeIndex(framework, "burstMode"))
    self:LogValue("makulu.rampMode", safeIndex(framework, "rampMode"))
    self:LogValue("makulu.spellState", self:CompactSpellState(safeIndex(framework, "spellState")))

    local player = getFrameworkUnit("player")
    self:LogValue("mak.player.exists", player ~= nil)
    if player then
        self:LogValue("mak.player.inCombat", safeIndex(player, "inCombat"))
        self:LogValue("mak.player.combatTime", safeIndex(player, "combatTime"))
        self:LogValue("mak.player.moving", safeIndex(player, "moving"))
        self:LogValue("mak.player.hp", safeIndex(player, "hp"))
        self:LogValue("mak.player.ehp", safeIndex(player, "ehp"))
        self:LogValue("mak.player.focus", safeIndex(player, "focus"))
        self:LogValue("mak.player.focusMax", safeIndex(player, "focusMax"))
        self:LogValue("mak.player.castInfo", self:CompactCastInfo(safeIndex(player, "castInfo")))
        self:LogValue("mak.player.channelInfo", self:CompactCastInfo(safeIndex(player, "channelInfo")))
        self:LogValue("mak.player.castOrChannelInfo", self:CompactCastInfo(safeIndex(player, "castOrChannelInfo")))
    end

    self:LogValue("makulu.bmPlayerHealthSnapshot", safeIndex(framework, "bmPlayerHealthSnapshot"))
    self:LogValue("makulu.bmDefensiveDebug", safeIndex(framework, "bmDefensiveDebug"))

    local action = rawget(_G, "Action")
    local actionUnit = action and safeIndex(action, "Unit")
    if actionUnit ~= nil then
        local okActionPlayer, actionPlayer = pcall(function()
            return actionUnit("player")
        end)
        if okActionPlayer and actionPlayer then
            local okHealthPercent, actionHealthPercent = pcall(function()
                return actionPlayer:HealthPercent()
            end)
            self:LogValue("action.player.healthPercent", okHealthPercent and actionHealthPercent or nil)
        end
    end

    local target = getFrameworkUnit("target")
    self:LogValue("mak.target.exists", target ~= nil and safeIndex(target, "exists") or nil)
    if target then
        self:LogValue("mak.target.canAttack", safeIndex(target, "canAttack"))
        self:LogValue("mak.target.distance", safeIndex(target, "distance"))
        self:LogValue("mak.target.hp", safeIndex(target, "hp"))
        self:LogValue("mak.target.combatTime", safeIndex(target, "combatTime"))
        self:LogValue("mak.target.castOrChannelInfo", self:CompactCastInfo(safeIndex(target, "castOrChannelInfo")))
    end

    for _, entry in ipairs(BM_RUNTIME_SPELLS) do
        self:ScanRuntimeSpell(entry)
    end

    self:ScanUnholyDKRuntime()
end

function Probe:BuildRuntimeTraceParts(reason)
    local parts = { "reason=" .. tostring(reason or "tick") }
    local framework = getMakuluFramework()

    parts[#parts + 1] = "framework=" .. tostring(framework ~= nil)
    if not framework then
        return parts
    end

    local spellState = safeIndex(framework, "spellState")
    if spellState then
        parts[#parts + 1] = "ss.casted=" .. tostring(safeIndex(spellState, "casted"))
        parts[#parts + 1] = "ss.lock=" .. tostring(safeIndex(spellState, "castingLockdown"))
        parts[#parts + 1] = "ss.gcdHold=" .. tostring(safeIndex(spellState, "gcdHold"))
    end

    local player = getFrameworkUnit("player")
    if player then
        parts[#parts + 1] = "p.combat=" .. tostring(safeIndex(player, "inCombat"))
        parts[#parts + 1] = "p.ct=" .. self:ValueToString(safeIndex(player, "combatTime"), 0)
        parts[#parts + 1] = "p.focus=" .. self:ValueToString(safeIndex(player, "focus"), 0)
        parts[#parts + 1] = "p.moving=" .. tostring(safeIndex(player, "moving"))
        parts[#parts + 1] = "p.cast=" .. self:ValueToString(self:CompactCastInfo(safeIndex(player, "castOrChannelInfo")), 1)
    end

    local target = getFrameworkUnit("target")
    if target then
        parts[#parts + 1] = "t.exists=" .. tostring(safeIndex(target, "exists"))
        parts[#parts + 1] = "t.range=" .. self:ValueToString(safeIndex(target, "distance"), 0)
        parts[#parts + 1] = "t.hp=" .. self:ValueToString(safeIndex(target, "hp"), 0)
    end

    for _, entry in ipairs({ BM_RUNTIME_SPELLS[1], BM_RUNTIME_SPELLS[2], BM_RUNTIME_SPELLS[3] }) do
        local spell = getFrameworkSpell(entry.id)
        if spell then
            local okCd, cd = callPacked(function() return spell:Cooldown() end)
            local okReady, ready = callPacked(function() return spell:ReadyToUse() end)
            local okRange, inRange = callPacked(function()
                local pulseTarget = getFrameworkUnit("target") or getFrameworkUnit("player")
                return spell:InRange(pulseTarget)
            end)
            parts[#parts + 1] = string.format("%s.cd=%s", entry.name, okCd and formatPacked(cd) or "ERR")
            parts[#parts + 1] = string.format("%s.ready=%s", entry.name, okReady and formatPacked(ready) or "ERR")
            parts[#parts + 1] = string.format("%s.range=%s", entry.name, okRange and formatPacked(inRange) or "ERR")

            if entry.name == "BarbedShot" then
                local okFrac, frac = callPacked(function() return spell:Fraction() end)
                parts[#parts + 1] = string.format("%s.frac=%s", entry.name, okFrac and formatPacked(frac) or "ERR")
            end
        end
    end

    local spellBook = getUHDKSpellBook()
    local putrefy = spellBook and safeIndex(spellBook, "Putrefy")
    if putrefy then
        local okCharges, charges = callPacked(function() return putrefy:GetSpellCharges() end)
        local okReady, ready = callPacked(function() return putrefy:IsReadyByPassCastGCD("target") end)
        local okCastable, castable = callPacked(function() return putrefy:IsCastable("target") end)
        local okLua, luaPass = callPacked(function() return putrefy:RunLua("target") end)
        local okRange, inRange = callPacked(function() return putrefy:IsSpellInRange("target") end)
        parts[#parts + 1] = "Putrefy.charges=" .. (okCharges and formatPacked(charges) or "ERR")
        parts[#parts + 1] = "Putrefy.ready=" .. (okReady and formatPacked(ready) or "ERR")
        parts[#parts + 1] = "Putrefy.castable=" .. (okCastable and formatPacked(castable) or "ERR")
        parts[#parts + 1] = "Putrefy.lua=" .. (okLua and formatPacked(luaPass) or "ERR")
        parts[#parts + 1] = "Putrefy.range=" .. (okRange and formatPacked(inRange) or "ERR")
    end

    local primaryRotation = spellBook and safeIndex(spellBook, 3) or nil
    if type(primaryRotation) == "function" then
        local okRotation, rotationResults = callPacked(function()
            return self:CaptureRotationCall(primaryRotation)
        end)
        if okRotation and rotationResults and rotationResults[1] then
            local rotation = rotationResults[1]
            local fire = safeIndex(rotation, "fire")
            parts[#parts + 1] = "uhdk.rot=" .. tostring(safeIndex(fire, "keyName") or safeIndex(fire, "actionID") or safeIndex(rotation, "returned"))
        else
            parts[#parts + 1] = "uhdk.rot=ERR"
        end
    end

    return parts
end

function Probe:TraceSnapshot(reason)
    self:AddLog("TRACE :: " .. table.concat(self:BuildRuntimeTraceParts(reason), " | "))
end

function Probe:StartTrace(duration, interval)
    duration = tonumber(duration) or self.db.traceDuration or 6
    interval = tonumber(interval) or self.db.traceInterval or 0.2

    self.db.traceDuration = duration
    self.db.traceInterval = interval

    self:StopTrace(false)

    if not (C_Timer and type(C_Timer.NewTicker) == "function") then
        self:AddLog("Trace unavailable: C_Timer.NewTicker missing.")
        return
    end

    self.traceActive = true
    self.traceEndsAt = GetTime() + duration
    self.traceTicker = C_Timer.NewTicker(interval, function()
        if not Probe.traceActive then
            return
        end

        if Probe.traceEndsAt and GetTime() >= Probe.traceEndsAt then
            Probe:TraceSnapshot("trace-end")
            Probe:StopTrace()
            return
        end

        Probe:TraceSnapshot("tick")
    end)

    self:AddLog(string.format("Trace started: duration=%s interval=%s", tostring(duration), tostring(interval)))
    self:TraceSnapshot("trace-start")
end

function Probe:StopTrace(logMessage)
    if self.traceTicker then
        self.traceTicker:Cancel()
        self.traceTicker = nil
    end

    self.traceActive = false
    self.traceEndsAt = nil

    if logMessage ~= false then
        self:AddLog("Trace stopped.")
    end
end

function Probe:HandlePlayerCastEvent(eventName, unit, targetName, castGUID, spellID)
    if unit ~= "player" then
        return
    end

    self:AddLog(string.format("EVENT -> %s unit=%s target=%s spellID=%s castGUID=%s", tostring(eventName), tostring(unit), tostring(targetName), tostring(spellID), tostring(castGUID)))

    if self.traceActive then
        self:TraceSnapshot(eventName .. ":" .. tostring(spellID))
    end
end

function Probe:GetAuraObject(unit, index, filter)
    if C_UnitAuras and type(C_UnitAuras.GetAuraDataByIndex) == "function" then
        return C_UnitAuras.GetAuraDataByIndex(unit, index, filter)
    elseif type(UnitAura) == "function" then
        local name, icon, count, dispelType, duration, expirationTime, sourceUnit, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossAura = UnitAura(unit, index, filter)
        if name == nil then
            return nil
        end
        return {
            name = name,
            icon = icon,
            applications = count,
            dispelName = dispelType,
            duration = duration,
            expirationTime = expirationTime,
            sourceUnit = sourceUnit,
            isStealable = isStealable,
            nameplateShowPersonal = nameplateShowPersonal,
            spellId = spellId,
            canApplyAura = canApplyAura,
            isBossAura = isBossAura,
        }
    end
    return nil
end

function Probe:FormatAura(aura)
    if aura == nil then
        return "nil"
    end

    if isSecretTable(aura) then
        return "<secret-table>"
    end

    local keys = {
        "name", "spellId", "applications", "dispelName", "duration", "expirationTime",
        "sourceUnit", "isStealable", "isBossAura", "isFromPlayerOrPlayerPet",
        "canApplyAura", "nameplateShowPersonal", "timeMod", "points",
    }

    local parts = {}
    for _, key in ipairs(keys) do
        local ok, value = pcall(function()
            return aura[key]
        end)
        if ok and value ~= nil then
            parts[#parts + 1] = key .. "=" .. self:ValueToString(value, 1)
        elseif not ok then
            parts[#parts + 1] = key .. "=<error>"
        end
    end

    if #parts == 0 then
        return self:ValueToString(aura, 0)
    end

    return "{ " .. table.concat(parts, ", ") .. " }"
end

function Probe:ScanAuras(unit, filter, limit)
    limit = tonumber(limit) or self.db.maxAuraSlots or 20
    filter = string.upper(filter or "HELPFUL")

    self:AddLog(string.format("=== AURAS unit=%s filter=%s limit=%d ===", tostring(unit), filter, limit))

    if type(UnitExists) ~= "function" or not UnitExists(unit) then
        self:AddLog("Aura scan aborted: unit does not exist.")
        return
    end

    local found = 0
    for index = 1, limit do
        local secretHint = nil
        if C_Secrets and type(C_Secrets.ShouldUnitAuraIndexBeSecret) == "function" then
            local okHint, hintResults = callPacked(C_Secrets.ShouldUnitAuraIndexBeSecret, unit, index, filter)
            if okHint and (hintResults.n or 0) >= 1 then
                secretHint = hintResults[1]
            end
        end

        local ok, results = callPacked(function()
            return self:GetAuraObject(unit, index, filter)
        end)

        if not ok then
            self:AddLog(string.format("%s aura[%d] -> ERROR :: %s", filter, index, formatPacked(results)))
        elseif (results.n or 0) == 0 or results[1] == nil then
            if index == 1 then
                self:AddLog(string.format("%s aura list empty or inaccessible.", filter))
            end
            break
        else
            found = found + 1
            self:AddLog(string.format("%s aura[%d] secretHint=%s -> %s", filter, index, tostring(secretHint), self:FormatAura(results[1])))
        end
    end

    if found == 0 then
        self:AddLog(string.format("No %s auras detected in first %d slots.", filter, limit))
    end
end

function Probe:ScanResources(unit)
    if type(UnitExists) ~= "function" or not UnitExists(unit) then
        self:AddLog("Resource scan aborted: unit does not exist -> " .. tostring(unit))
        return
    end

    self:AddLog("=== RESOURCES " .. tostring(unit) .. " ===")

    for _, entry in ipairs(POWER_TYPES) do
        local powerIndex, powerName = entry[1], entry[2]
        local okMax, maxResults = callPacked(UnitPowerMax, unit, powerIndex)
        if okMax and (maxResults.n or 0) >= 1 then
            local maxValue = normalizeSecretNumber(maxResults[1], nil)
            if maxValue == nil then
                local _, currentResults = callPacked(UnitPower, unit, powerIndex)
                self:AddLog(string.format("%s -> current=%s max=%s", powerName, formatPacked(currentResults), formatPacked(maxResults)))
            elseif maxValue ~= 0 then
                local _, currentResults = callPacked(UnitPower, unit, powerIndex)
                self:AddLog(string.format("%s -> current=%s max=%s", powerName, formatPacked(currentResults), formatPacked(maxResults)))
            end
        end
    end
end

function Probe:ScanUnitBasic(unit)
    self:AddLog("=== UNIT(LITE) " .. tostring(unit) .. " ===")
    self:TryCall(unit .. ":UnitExists", UnitExists, unit)

    if type(UnitExists) ~= "function" or not UnitExists(unit) then
        return
    end

    self:TryCall(unit .. ":UnitGUID", UnitGUID, unit)
    self:TryCall(unit .. ":UnitName", UnitName, unit)
    self:TryCall(unit .. ":UnitCanAttack", UnitCanAttack, "player", unit)
    self:TryCall(unit .. ":UnitHealth", UnitHealth, unit)
    self:TryCall(unit .. ":UnitHealthMax", UnitHealthMax, unit)
    self:TryCall(unit .. ":UnitPower", UnitPower, unit)
    self:TryCall(unit .. ":UnitPowerMax", UnitPowerMax, unit)
    if type(UnitCastingInfo) == "function" then
        self:TryCall(unit .. ":UnitCastingInfo", UnitCastingInfo, unit)
    end
    if type(UnitChannelInfo) == "function" then
        self:TryCall(unit .. ":UnitChannelInfo", UnitChannelInfo, unit)
    end
    self:ScanAuras(unit, "HARMFUL", 3)
end

function Probe:ScanUnitFull(unit)
    self:AddLog("=== UNIT(FULL) " .. tostring(unit) .. " ===")
    self:TryCall(unit .. ":UnitExists", UnitExists, unit)

    if type(UnitExists) ~= "function" or not UnitExists(unit) then
        return
    end

    self:TryCall(unit .. ":UnitGUID", UnitGUID, unit)

    if type(UnitGUID) == "function" then
        local guid = UnitGUID(unit)
        local npcID = getNPCIDFromGUID(guid)
        if npcID then
            self:AddLog(unit .. ":NPCID -> " .. tostring(npcID))
        end
    end

    self:TryCall(unit .. ":UnitName", UnitName, unit)
    if type(UnitFullName) == "function" then
        self:TryCall(unit .. ":UnitFullName", UnitFullName, unit)
    end
    if type(UnitClass) == "function" then
        self:TryCall(unit .. ":UnitClass", UnitClass, unit)
    end
    if type(UnitLevel) == "function" then
        self:TryCall(unit .. ":UnitLevel", UnitLevel, unit)
    end
    if type(UnitClassification) == "function" then
        self:TryCall(unit .. ":UnitClassification", UnitClassification, unit)
    end
    if type(UnitIsPlayer) == "function" then
        self:TryCall(unit .. ":UnitIsPlayer", UnitIsPlayer, unit)
    end
    if type(UnitCanAttack) == "function" then
        self:TryCall(unit .. ":UnitCanAttack", UnitCanAttack, "player", unit)
    end
    if type(UnitCanAssist) == "function" then
        self:TryCall(unit .. ":UnitCanAssist", UnitCanAssist, "player", unit)
    end
    if type(UnitIsVisible) == "function" then
        self:TryCall(unit .. ":UnitIsVisible", UnitIsVisible, unit)
    end
    if type(UnitInRange) == "function" then
        self:TryCall(unit .. ":UnitInRange", UnitInRange, unit)
    end
    if type(CheckInteractDistance) == "function" then
        self:TryCall(unit .. ":CheckInteractDistance(4)", CheckInteractDistance, unit, 4)
    end

    self:TryCall(unit .. ":UnitHealth", UnitHealth, unit)
    self:TryCall(unit .. ":UnitHealthMax", UnitHealthMax, unit)
    if type(UnitGetTotalAbsorbs) == "function" then
        self:TryCall(unit .. ":UnitGetTotalAbsorbs", UnitGetTotalAbsorbs, unit)
    end
    if type(UnitGetIncomingHeals) == "function" then
        self:TryCall(unit .. ":UnitGetIncomingHeals", UnitGetIncomingHeals, unit, "player")
    end
    if type(UnitGetHealAbsorbs) == "function" then
        self:TryCall(unit .. ":UnitGetHealAbsorbs", UnitGetHealAbsorbs, unit)
    end

    self:TryCall(unit .. ":UnitPower", UnitPower, unit)
    self:TryCall(unit .. ":UnitPowerMax", UnitPowerMax, unit)
    if type(UnitPowerType) == "function" then
        self:TryCall(unit .. ":UnitPowerType", UnitPowerType, unit)
    end
    if type(UnitAffectingCombat) == "function" then
        self:TryCall(unit .. ":UnitAffectingCombat", UnitAffectingCombat, unit)
    end
    if type(UnitThreatSituation) == "function" then
        self:TryCall(unit .. ":UnitThreatSituation", UnitThreatSituation, "player", unit)
    end

    if C_Secrets and type(C_Secrets.ShouldUnitSpellCastingBeSecret) == "function" then
        self:TryCall(unit .. ":ShouldUnitSpellCastingBeSecret", C_Secrets.ShouldUnitSpellCastingBeSecret, unit)
    end
    if type(UnitCastingInfo) == "function" then
        self:TryCall(unit .. ":UnitCastingInfo", UnitCastingInfo, unit)
    end
    if type(UnitChannelInfo) == "function" then
        self:TryCall(unit .. ":UnitChannelInfo", UnitChannelInfo, unit)
    end

    self:ScanResources(unit)
    self:ScanAuras(unit, "HELPFUL", 6)
    self:ScanAuras(unit, "HARMFUL", 6)
end

function Probe:ScanNameplates()
    self:AddLog("=== NAMEPLATE SCAN ===")
    local any = false
    local maxNameplates = tonumber(self.db.maxNameplates) or 40

    for index = 1, maxNameplates do
        local unit = "nameplate" .. index
        if type(UnitExists) == "function" and UnitExists(unit) then
            any = true
            self:ScanUnitBasic(unit)
        end
    end

    if not any then
        self:AddLog("No active nameplates detected.")
    end
end

function Probe:ScanBossAndArenaUnits()
    for index = 1, 5 do
        local bossUnit = "boss" .. index
        if type(UnitExists) == "function" and UnitExists(bossUnit) then
            self:ScanUnitBasic(bossUnit)
        end

        local arenaUnit = "arena" .. index
        if type(UnitExists) == "function" and UnitExists(arenaUnit) then
            self:ScanUnitBasic(arenaUnit)
        end
    end
end

function Probe:ScanActionBars()
    self:AddLog("=== ACTION BAR SCAN ===")
    local any = false
    local maxSlots = tonumber(self.db.maxActionSlots) or 180

    if type(GetActionInfo) ~= "function" then
        self:AddLog("Action bar scan unavailable: GetActionInfo missing.")
        return
    end

    for slot = 1, maxSlots do
        local ok, results = callPacked(GetActionInfo, slot)
        if ok and (results.n or 0) >= 1 and results[1] ~= nil then
            local actionType = results[1]
            local actionID = results[2]
            local subType = results[3]
            any = true

            self:AddLog(string.format("slot %d -> type=%s id=%s subType=%s", slot, self:ValueToString(actionType), self:ValueToString(actionID), self:ValueToString(subType)))

            if type(IsUsableAction) == "function" then
                self:TryCall("action[" .. slot .. "]:IsUsableAction", IsUsableAction, slot)
            end
            if type(GetActionCooldown) == "function" then
                self:TryCall("action[" .. slot .. "]:GetActionCooldown", GetActionCooldown, slot)
            end
            if type(GetActionCharges) == "function" then
                self:TryCall("action[" .. slot .. "]:GetActionCharges", GetActionCharges, slot)
            end
            if type(IsActionInRange) == "function" then
                self:TryCall("action[" .. slot .. "]:IsActionInRange", IsActionInRange, slot)
            end

            if actionType == "spell" and actionID ~= nil then
                if C_Spell and type(C_Spell.GetSpellInfo) == "function" then
                    self:TryCall("action[" .. slot .. "]:C_Spell.GetSpellInfo", C_Spell.GetSpellInfo, actionID)
                end
                if C_Spell and type(C_Spell.GetSpellCooldown) == "function" then
                    self:TryCall("action[" .. slot .. "]:C_Spell.GetSpellCooldown", C_Spell.GetSpellCooldown, actionID)
                elseif type(GetSpellCooldown) == "function" then
                    self:TryCall("action[" .. slot .. "]:GetSpellCooldown", GetSpellCooldown, actionID)
                end
                if C_Spell and type(C_Spell.GetSpellCharges) == "function" then
                    self:TryCall("action[" .. slot .. "]:C_Spell.GetSpellCharges", C_Spell.GetSpellCharges, actionID)
                elseif type(GetSpellCharges) == "function" then
                    self:TryCall("action[" .. slot .. "]:GetSpellCharges", GetSpellCharges, actionID)
                end
            end
        end
    end

    if not any then
        self:AddLog("No occupied action bar slots found.")
    end
end

function Probe:ScanSpellbook(limitPerLine)
    self:AddLog("=== SPELLBOOK SCAN ===")

    if not (C_SpellBook and type(C_SpellBook.GetNumSpellBookSkillLines) == "function") then
        self:AddLog("Spellbook scan unavailable: C_SpellBook APIs missing.")
        return
    end

    local bank = Enum and Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Player or nil
    local okCount, countResults = callPacked(C_SpellBook.GetNumSpellBookSkillLines)
    if not okCount or (countResults.n or 0) == 0 or countResults[1] == nil then
        self:AddLog("Could not read spellbook skill line count.")
        return
    end

    local numLines = tonumber(countResults[1]) or 0
    self:AddLog("Spellbook skill lines -> " .. tostring(numLines))

    limitPerLine = tonumber(limitPerLine) or 20

    for lineIndex = 1, numLines do
        local okLine, lineResults = callPacked(C_SpellBook.GetSpellBookSkillLineInfo, lineIndex)
        if okLine and (lineResults.n or 0) >= 1 and lineResults[1] ~= nil then
            local lineInfo = lineResults[1]
            self:AddLog("SpellLine[" .. lineIndex .. "] -> " .. self:ValueToString(lineInfo))

            local offset = tonumber(lineInfo.itemIndexOffset or 0) or 0
            local count = tonumber(lineInfo.numSpellBookItems or 0) or 0
            local shown = 0

            if type(C_SpellBook.GetSpellBookItemInfo) == "function" and bank ~= nil then
                for itemIndex = offset + 1, offset + count do
                    shown = shown + 1
                    if shown > limitPerLine then
                        self:AddLog("SpellLine[" .. lineIndex .. "] truncated after " .. tostring(limitPerLine) .. " items.")
                        break
                    end

                    local okItem, itemResults = callPacked(C_SpellBook.GetSpellBookItemInfo, itemIndex, bank)
                    if okItem and (itemResults.n or 0) >= 1 and itemResults[1] ~= nil then
                        local itemInfo = itemResults[1]
                        self:AddLog("SpellBookItem[" .. itemIndex .. "] -> " .. self:ValueToString(itemInfo))

                        local actionID = itemInfo.actionID or itemInfo.spellID
                        if actionID and C_Spell and type(C_Spell.GetSpellCooldown) == "function" then
                            self:TryCall("SpellBookItem[" .. itemIndex .. "]:C_Spell.GetSpellCooldown", C_Spell.GetSpellCooldown, actionID)
                        end
                    else
                        self:AddLog("SpellBookItem[" .. itemIndex .. "] -> ERROR/NIL :: " .. formatPacked(itemResults))
                    end
                end
            else
                self:AddLog("Spellbook item enumeration unavailable: GetSpellBookItemInfo or bank enum missing.")
                break
            end
        else
            self:AddLog("SpellLine[" .. lineIndex .. "] -> ERROR/NIL :: " .. formatPacked(lineResults))
        end
    end
end

function Probe:ScanWatchedSpells(spellList)
    spellList = spellList or self.db.watchedSpells or {}

    self:AddLog("=== WATCHED SPELL SCAN ===")
    if #spellList == 0 then
        self:AddLog("No watched spells configured. Use /mrp watch <spellIDs>.")
        return
    end

    for _, spell in ipairs(spellList) do
        local label = "spell[" .. tostring(spell) .. "]"

        if C_Spell and type(C_Spell.GetSpellInfo) == "function" then
            self:TryCall(label .. ":C_Spell.GetSpellInfo", C_Spell.GetSpellInfo, spell)
        elseif type(GetSpellInfo) == "function" then
            self:TryCall(label .. ":GetSpellInfo", GetSpellInfo, spell)
        end

        if C_Spell and type(C_Spell.GetSpellCooldown) == "function" then
            self:TryCall(label .. ":C_Spell.GetSpellCooldown", C_Spell.GetSpellCooldown, spell)
        elseif type(GetSpellCooldown) == "function" then
            self:TryCall(label .. ":GetSpellCooldown", GetSpellCooldown, spell)
        end

        if C_Spell and type(C_Spell.GetSpellCharges) == "function" then
            self:TryCall(label .. ":C_Spell.GetSpellCharges", C_Spell.GetSpellCharges, spell)
        elseif type(GetSpellCharges) == "function" then
            self:TryCall(label .. ":GetSpellCharges", GetSpellCharges, spell)
        end

        if C_Spell and type(C_Spell.IsSpellUsable) == "function" then
            self:TryCall(label .. ":C_Spell.IsSpellUsable", C_Spell.IsSpellUsable, spell)
        elseif type(IsUsableSpell) == "function" then
            self:TryCall(label .. ":IsUsableSpell", IsUsableSpell, spell)
        end

        if C_Spell and type(C_Spell.IsSpellInRange) == "function" then
            self:TryCall(label .. ":C_Spell.IsSpellInRange(target)", C_Spell.IsSpellInRange, spell, "target")
        elseif type(IsSpellInRange) == "function" then
            self:TryCall(label .. ":IsSpellInRange(target)", IsSpellInRange, spell, "target")
        end

        if type(IsPlayerSpell) == "function" then
            self:TryCall(label .. ":IsPlayerSpell", IsPlayerSpell, spell)
        end
        if type(IsSpellKnownOrOverridesKnown) == "function" then
            self:TryCall(label .. ":IsSpellKnownOrOverridesKnown", IsSpellKnownOrOverridesKnown, spell)
        elseif type(IsSpellKnown) == "function" then
            self:TryCall(label .. ":IsSpellKnown", IsSpellKnown, spell)
        end
    end
end

function Probe:RunRotationMatrix()
    self:AddLog("=== ROTATION MATRIX ===")

    self:Evaluate("player health", function()
        return UnitHealth("player")
    end)
    self:Evaluate("player max health", function()
        return UnitHealthMax("player")
    end)
    self:Evaluate("player power", function()
        return UnitPower("player")
    end)
    self:Evaluate("player power max", function()
        return UnitPowerMax("player")
    end)
    self:Evaluate("player cast info", function()
        if type(UnitCastingInfo) == "function" then
            return UnitCastingInfo("player")
        end
    end)
    self:Evaluate("player helpful aura[1]", function()
        return self:GetAuraObject("player", 1, "HELPFUL")
    end)
    self:Evaluate("player harmful aura[1]", function()
        return self:GetAuraObject("player", 1, "HARMFUL")
    end)

    if type(UnitExists) == "function" and UnitExists("target") then
        self:Evaluate("target health", function()
            return UnitHealth("target")
        end)
        self:Evaluate("target max health", function()
            return UnitHealthMax("target")
        end)
        self:Evaluate("target cast info", function()
            if type(UnitCastingInfo) == "function" then
                return UnitCastingInfo("target")
            end
        end)
        self:Evaluate("target helpful aura[1]", function()
            return self:GetAuraObject("target", 1, "HELPFUL")
        end)
        self:Evaluate("target harmful aura[1]", function()
            return self:GetAuraObject("target", 1, "HARMFUL")
        end)
    else
        self:AddLog("MATRIX target checks skipped: no target.")
    end

    if type(UnitExists) == "function" and UnitExists("nameplate1") then
        self:Evaluate("nameplate1 health", function()
            return UnitHealth("nameplate1")
        end)
        self:Evaluate("nameplate1 cast info", function()
            if type(UnitCastingInfo) == "function" then
                return UnitCastingInfo("nameplate1")
            end
        end)
        self:Evaluate("nameplate1 harmful aura[1]", function()
            return self:GetAuraObject("nameplate1", 1, "HARMFUL")
        end)
    else
        self:AddLog("MATRIX nameplate1 checks skipped: no nameplate1.")
    end

    local watched = self.db.watchedSpells and self.db.watchedSpells[1] or nil
    if watched ~= nil then
        self:Evaluate("watched spell cooldown", function()
            if C_Spell and type(C_Spell.GetSpellCooldown) == "function" then
                return C_Spell.GetSpellCooldown(watched)
            elseif type(GetSpellCooldown) == "function" then
                return GetSpellCooldown(watched)
            end
        end)
        self:Evaluate("watched spell charges", function()
            if C_Spell and type(C_Spell.GetSpellCharges) == "function" then
                return C_Spell.GetSpellCharges(watched)
            elseif type(GetSpellCharges) == "function" then
                return GetSpellCharges(watched)
            end
        end)
        self:Evaluate("watched spell usable", function()
            if C_Spell and type(C_Spell.IsSpellUsable) == "function" then
                return C_Spell.IsSpellUsable(watched)
            elseif type(IsUsableSpell) == "function" then
                return IsUsableSpell(watched)
            end
        end)
    else
        self:AddLog("MATRIX watched spell checks skipped: no watched spells.")
    end
end

function Probe:LogEnvironment()
    self:AddLog("=== ENVIRONMENT ===")
    self:AddLog(getBuildText())
    self:AddLog("player=" .. tostring(UnitName and UnitName("player") or "unknown") .. " realm=" .. tostring(GetRealmName and GetRealmName() or "unknown"))
    self:AddLog("zone=" .. tostring(GetZoneText and GetZoneText() or "unknown") .. " subZone=" .. tostring(GetSubZoneText and GetSubZoneText() or "unknown"))
    self:AddLog("inCombat=" .. tostring(InCombatLockdown and InCombatLockdown() or false))

    if type(GetSpecialization) == "function" then
        local currentSpec = GetSpecialization()
        self:AddLog("specIndex=" .. tostring(currentSpec))
        if type(GetSpecializationInfo) == "function" and currentSpec then
            self:TryCall("GetSpecializationInfo", GetSpecializationInfo, currentSpec)
        end
    end

    self:AddLog("api:isSecretValue=" .. tostring(type(_G.issecretvalue) == "function"))
    self:AddLog("api:isSecretTable=" .. tostring(type(_G.issecrettable) == "function"))
    self:AddLog("api:scrubsecretvalues=" .. tostring(type(_G.scrubsecretvalues) == "function"))
    self:AddLog("api:C_Secrets.ShouldUnitAuraIndexBeSecret=" .. tostring(C_Secrets and type(C_Secrets.ShouldUnitAuraIndexBeSecret) == "function" or false))
    self:AddLog("api:C_Secrets.ShouldUnitSpellCastingBeSecret=" .. tostring(C_Secrets and type(C_Secrets.ShouldUnitSpellCastingBeSecret) == "function" or false))
    self:AddLog("api:C_SpellBook.GetNumSpellBookSkillLines=" .. tostring(C_SpellBook and type(C_SpellBook.GetNumSpellBookSkillLines) == "function" or false))
end

function Probe:QuickPulse()
    local parts = {}

    parts[#parts + 1] = "combat=" .. tostring(InCombatLockdown and InCombatLockdown() or false)

    if type(UnitExists) == "function" and UnitExists("player") then
        parts[#parts + 1] = "php=" .. self:ValueToString(UnitHealth and UnitHealth("player") or nil)
        parts[#parts + 1] = "pmax=" .. self:ValueToString(UnitHealthMax and UnitHealthMax("player") or nil)
        parts[#parts + 1] = "pow=" .. self:ValueToString(UnitPower and UnitPower("player") or nil)
        parts[#parts + 1] = "powmax=" .. self:ValueToString(UnitPowerMax and UnitPowerMax("player") or nil)
    end

    if type(UnitExists) == "function" and UnitExists("target") then
        parts[#parts + 1] = "target=" .. self:ValueToString(UnitName and UnitName("target") or nil)
        parts[#parts + 1] = "thp=" .. self:ValueToString(UnitHealth and UnitHealth("target") or nil)

        if type(UnitCastingInfo) == "function" then
            local okCast, castResults = callPacked(UnitCastingInfo, "target")
            if okCast and not ((castResults.n or 0) == 1 and castResults[1] == nil) then
                parts[#parts + 1] = "tcast=" .. formatPacked(castResults)
            end
        end
    end

    local watched = self.db.watchedSpells and self.db.watchedSpells[1] or nil
    if watched and C_Spell and type(C_Spell.GetSpellCooldown) == "function" then
        local okCd, cdResults = callPacked(C_Spell.GetSpellCooldown, watched)
        if okCd then
            parts[#parts + 1] = "spell" .. tostring(watched) .. "=" .. formatPacked(cdResults)
        end

        if type(C_Spell.GetSpellCharges) == "function" then
            local okCharges, chargeResults = callPacked(C_Spell.GetSpellCharges, watched)
            if okCharges then
                parts[#parts + 1] = "spell" .. tostring(watched) .. ".charges=" .. formatPacked(chargeResults)
            end
        end

        if type(C_Spell.IsSpellUsable) == "function" then
            local okUsable, usableResults = callPacked(C_Spell.IsSpellUsable, watched)
            if okUsable then
                parts[#parts + 1] = "spell" .. tostring(watched) .. ".usable=" .. formatPacked(usableResults)
            end
        end
    end

    local runtimeParts = self:BuildRuntimeTraceParts("pulse")
    for index = 1, #runtimeParts do
        parts[#parts + 1] = runtimeParts[index]
    end

    self:AddLog("PULSE :: " .. table.concat(parts, " | "))
end

function Probe:StartPulse(interval)
    interval = tonumber(interval) or self.db.pulseInterval or 1
    self.db.pulseInterval = interval

    self:StopPulse(false)

    if not (C_Timer and type(C_Timer.NewTicker) == "function") then
        self:AddLog("Pulse unavailable: C_Timer.NewTicker missing.")
        return
    end

    self.pulseTicker = C_Timer.NewTicker(interval, function()
        Probe:QuickPulse()
    end)
    self:AddLog("Pulse started at " .. tostring(interval) .. " second(s).")
end

function Probe:StopPulse(logMessage)
    if self.pulseTicker then
        self.pulseTicker:Cancel()
        self.pulseTicker = nil
        if logMessage ~= false then
            self:AddLog("Pulse stopped.")
        end
    end
end

function Probe:RunFullScan()
    self:ToggleUI(true)
    self:AddLog("========================================")
    self:AddLog("BEGIN FULL SCAN")
    self:LogEnvironment()
    self:RunRotationMatrix()
    self:ScanMakuluRuntime()
    self:ScanUnitFull("player")

    for _, unit in ipairs({ "target", "focus", "mouseover", "targettarget", "pet", "softenemy", "softfriend" }) do
        if type(UnitExists) == "function" and UnitExists(unit) then
            self:ScanUnitFull(unit)
        else
            self:AddLog("Skipping unit (not present): " .. unit)
        end
    end

    self:ScanBossAndArenaUnits()
    self:ScanNameplates()
    self:ScanWatchedSpells(self.db.watchedSpells)
    self:ScanActionBars()
    self:ScanSpellbook(15)
    self:AddLog("END FULL SCAN")
    self:AddLog("========================================")
end

function Probe:PrintHelp()
    self:AddLog("Commands: /mrp, /mrp scan, /mrp runtime, /mrp uhdk, /mrp trace <duration> <interval>|off, /mrp unit <unit>, /mrp lite <unit>, /mrp auras <unit> <HELPFUL|HARMFUL>, /mrp nameplates, /mrp actionbars, /mrp spellbook, /mrp spells <ids>, /mrp watch <ids>, /mrp pulse <seconds|off>, /mrp clear")
end

function Probe:HandleSlash(message)
    local command, rest = string.match(message or "", "^(%S*)%s*(.-)$")
    command = string.lower(command or "")

    if command == "" then
        self:ToggleUI()
        return
    end

    if command == "help" then
        self:ToggleUI(true)
        self:PrintHelp()
    elseif command == "show" then
        self:ToggleUI(true)
    elseif command == "hide" then
        self:ToggleUI(false)
    elseif command == "scan" then
        self:RunFullScan()
    elseif command == "runtime" then
        self:ToggleUI(true)
        self:ScanMakuluRuntime()
    elseif command == "uhdk" then
        self:ToggleUI(true)
        self:ScanUnholyDKRuntime()
    elseif command == "unit" and rest ~= "" then
        self:ToggleUI(true)
        self:ScanUnitFull(rest)
    elseif command == "lite" and rest ~= "" then
        self:ToggleUI(true)
        self:ScanUnitBasic(rest)
    elseif command == "auras" and rest ~= "" then
        self:ToggleUI(true)
        local unit, filter = string.match(rest, "^(%S+)%s*(%S*)$")
        filter = (filter and filter ~= "") and string.upper(filter) or "HELPFUL"
        self:ScanAuras(unit, filter, self.db.maxAuraSlots)
    elseif command == "nameplates" then
        self:ToggleUI(true)
        self:ScanNameplates()
    elseif command == "actionbars" then
        self:ToggleUI(true)
        self:ScanActionBars()
    elseif command == "spellbook" then
        self:ToggleUI(true)
        self:ScanSpellbook(20)
    elseif command == "spells" and rest ~= "" then
        self:ToggleUI(true)
        self:ScanWatchedSpells(parseSpellList(rest))
    elseif command == "watch" and rest ~= "" then
        self:ToggleUI(true)
        local spells = parseSpellList(rest)
        self.db.watchedSpells = spells
        self:AddLog("Watched spells updated -> " .. table.concat(spells, ", "))
    elseif command == "pulse" then
        self:ToggleUI(true)
        if rest == "off" or rest == "0" then
            self:StopPulse()
        else
            self:StartPulse(tonumber(rest) or 1)
        end
    elseif command == "trace" then
        self:ToggleUI(true)
        if rest == "off" or rest == "0" then
            self:StopTrace()
        else
            local durationText, intervalText = string.match(rest or "", "^(%S*)%s*(%S*)$")
            local duration = tonumber(durationText) or self.db.traceDuration or 6
            local interval = tonumber(intervalText) or self.db.traceInterval or 0.2
            self:StartTrace(duration, interval)
        end
    elseif command == "clear" then
        self:ToggleUI(true)
        wipeTable(self.db.log)
        self:AddLog("Log cleared.")
        self:RefreshUI()
    else
        self:ToggleUI(true)
        self:AddLog("Unknown command: " .. tostring(command))
        self:PrintHelp()
    end
end

function Probe:PLAYER_LOGIN()
    _G[DB_NAME] = _G[DB_NAME] or {}
    self.db = _G[DB_NAME]
    mergeDefaults(self.db, DEFAULTS)

    self:CreateUI()
    self:ToggleUI(true)

    SLASH_MIDNIGHTROTATIONPROBE1 = "/mrp"
    SlashCmdList.MIDNIGHTROTATIONPROBE = function(msg)
        Probe:HandleSlash(msg)
    end

    self:AddLog("Loaded Midnight Rotation Probe.")
    self:AddLog(getBuildText())
    self:AddLog("Use /mrp help for commands.")
end

function Probe:PLAYER_REGEN_DISABLED()
    self:AddLog("EVENT -> ENTER COMBAT")
    if self.traceActive then
        self:TraceSnapshot("enter-combat")
    end
end

function Probe:PLAYER_REGEN_ENABLED()
    self:AddLog("EVENT -> LEAVE COMBAT")
    if self.traceActive then
        self:TraceSnapshot("leave-combat")
    end
end

function Probe:PLAYER_TARGET_CHANGED()
    self:AddLog("EVENT -> TARGET CHANGED")
    if type(UnitExists) == "function" and UnitExists("target") then
        self:ScanUnitBasic("target")
    end
end

function Probe:PLAYER_FOCUS_CHANGED()
    self:AddLog("EVENT -> FOCUS CHANGED")
    if type(UnitExists) == "function" and UnitExists("focus") then
        self:ScanUnitBasic("focus")
    end
end

function Probe:UNIT_SPELLCAST_SENT(unit, targetName, castGUID, spellID)
    self:HandlePlayerCastEvent("UNIT_SPELLCAST_SENT", unit, targetName, castGUID, spellID)
end

function Probe:UNIT_SPELLCAST_START(unit, castGUID, spellID)
    self:HandlePlayerCastEvent("UNIT_SPELLCAST_START", unit, nil, castGUID, spellID)
end

function Probe:UNIT_SPELLCAST_SUCCEEDED(unit, castGUID, spellID)
    self:HandlePlayerCastEvent("UNIT_SPELLCAST_SUCCEEDED", unit, nil, castGUID, spellID)
end

function Probe:UNIT_SPELLCAST_STOP(unit, castGUID, spellID)
    self:HandlePlayerCastEvent("UNIT_SPELLCAST_STOP", unit, nil, castGUID, spellID)
end

function Probe:UNIT_SPELLCAST_FAILED(unit, castGUID, spellID)
    self:HandlePlayerCastEvent("UNIT_SPELLCAST_FAILED", unit, nil, castGUID, spellID)
end

function Probe:UNIT_SPELLCAST_INTERRUPTED(unit, castGUID, spellID)
    self:HandlePlayerCastEvent("UNIT_SPELLCAST_INTERRUPTED", unit, nil, castGUID, spellID)
end

function Probe:UNIT_SPELLCAST_CHANNEL_START(unit, castGUID, spellID)
    self:HandlePlayerCastEvent("UNIT_SPELLCAST_CHANNEL_START", unit, nil, castGUID, spellID)
end

function Probe:UNIT_SPELLCAST_CHANNEL_STOP(unit, castGUID, spellID)
    self:HandlePlayerCastEvent("UNIT_SPELLCAST_CHANNEL_STOP", unit, nil, castGUID, spellID)
end

Probe:RegisterEvent("PLAYER_LOGIN")
Probe:RegisterEvent("PLAYER_REGEN_DISABLED")
Probe:RegisterEvent("PLAYER_REGEN_ENABLED")
Probe:RegisterEvent("PLAYER_TARGET_CHANGED")
Probe:RegisterEvent("PLAYER_FOCUS_CHANGED")
Probe:RegisterEvent("UNIT_SPELLCAST_SENT")
Probe:RegisterEvent("UNIT_SPELLCAST_START")
Probe:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
Probe:RegisterEvent("UNIT_SPELLCAST_STOP")
Probe:RegisterEvent("UNIT_SPELLCAST_FAILED")
Probe:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
Probe:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
Probe:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
Probe:SetScript("OnEvent", function(self, event, ...)
    if type(self[event]) == "function" then
        self[event](self, ...)
    end
end)
