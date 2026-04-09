-- Register the addon
local SimplyWork = CreateFrame("Frame")

-- Event registration
SimplyWork:RegisterEvent("ADDON_LOADED")
SimplyWork:RegisterEvent("PLAYER_LOGIN")
SimplyWork:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

-- Define class/spec templates
local keyBindings = {
    ["WARRIOR"] = {
        [1] = { key = "1", action = "Charge" },     -- Arms Warrior
        [2] = { key = "2", action = "Shield Slam" }  -- Fury Warrior
    },
    ["DRUID"] = {
        [1] = { key = "Q", action = "Moonfire" },    -- Balance Druid
        [2] = { key = "E", action = "Rejuvenation" } -- Restoration Druid
    }
    -- Add more classes and specs as needed
}

-- Helper function to get class and specialization
local function GetClassAndSpec()
    local class, _ = UnitClass("player")
    local specIndex = GetSpecialization() -- Returns an index based on player's spec
    return class, specIndex
end

-- Function to update key bindings based on class and spec
local function UpdateKeyBindings()
    local class, specIndex = GetClassAndSpec()
    if not keyBindings[class] or not keyBindings[class][specIndex] then
        print("No key bindings available for this class/spec.")
        return
    end

    -- Clear previous key bindings (optional)
    for i = 1, GetNumBindings() do
        SetBinding(GetBinding(i)) -- Clear out old bindings if needed
    end

    -- Apply new bindings
    local specBindings = keyBindings[class][specIndex]
    for _, binding in ipairs(specBindings) do
        SetBinding(binding.key, binding.action)
        print("Binding " .. binding.key .. " to " .. binding.action)
    end

    -- Save bindings
    SaveBindings(GetCurrentBindingSet())
end

-- Event handler function
SimplyWork:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "SimplyWork" then
        print("SimplyWork Loaded!")
    elseif event == "PLAYER_LOGIN" then
        UpdateKeyBindings() -- Apply bindings on login
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        UpdateKeyBindings() -- Update bindings on spec change
    end
end)
