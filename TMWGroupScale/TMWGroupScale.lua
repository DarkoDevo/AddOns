local _G = _G
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize

local groups = {
    "TellMeWhen_Group2",
    "TellMeWhen_Group3",
    "TellMeWhen_Group4",
    "TellMeWhen_Group5",
    "TellMeWhen_Group6",
}

local groupSet = {}
local backgrounds = {}

for _, name in ipairs(groups) do
    groupSet[name] = true
end

-- Create black background frame as child of group
local function CreateBackground(group)
    local bg = CreateFrame("Frame", nil, group)
    bg:SetFrameLevel(math.max(group:GetFrameLevel() - 1, 0))
    bg:SetAllPoints(group)
    bg.texture = bg:CreateTexture(nil, "BACKGROUND")
    bg.texture:SetAllPoints(true)
    bg.texture:SetColorTexture(0, 0, 0, 1)
    return bg
end

local function ApplyScale(group, groupName)
    local myheight = select(2, GetPhysicalScreenSize())
    local myscale = 0.675 * (1080 / myheight)

    group:SetParent(nil)
    group:SetScale(myscale)
    group:SetFrameLevel(100)
    -- group:SetFrameStrata("TOOLTIP")
    -- group:SetToplevel(true)

    -- Create background if needed (only once)
    if not backgrounds[groupName] then
        backgrounds[groupName] = CreateBackground(group)
    end
    backgrounds[groupName]:Show()
end

-- Apply scale immediately after TMW finishes setting up each group
if TMW then
    TMW:RegisterCallback("TMW_GROUP_SETUP_POST", function(_, tmwFrame)
        local frameName = tmwFrame and tmwFrame:GetName()
        if frameName and groupSet[frameName] then
            ApplyScale(tmwFrame, frameName)
        end
    end)
end

-- Handle display/UI scale changes
local frame = CreateFrame("Frame")
frame:RegisterEvent("DISPLAY_SIZE_CHANGED")
frame:RegisterEvent("UI_SCALE_CHANGED")
frame:SetScript("OnEvent", function()
    C_Timer.After(0.2, function()
        if TMW then
            TMW:Update()
        end
    end)
end)
