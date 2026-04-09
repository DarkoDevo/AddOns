-- ChargeDuration DogTag for TellMeWhen
-- Returns remaining cooldown for both charge-based and regular spells
-- Usage in TMW text display: [ChargeDuration:TMWFormatDuration]

if not TMW then return end

local DogTag = LibStub("LibDogTag-3.0")
local issecretvalue = TMW.issecretvalue or function() return false end
local format = string.format

DogTag:AddTag("TMW", "ChargeDuration", {
    code = function(icon)
        icon = TMW.GUIDToOwner[icon]
        if not icon then return 0 end

        local attributes = icon.attributes

        -- Charge-based: Midnight secrets path
        if attributes.chargeDurObj then
            return attributes.chargeDurObj:GetRemainingDuration()
        end

        -- Charge-based: legacy numeric path
        local chargeDur = attributes.chargeDur
        if chargeDur and not issecretvalue(chargeDur) and chargeDur > 0 then
            local modRate = attributes.modRate
            if issecretvalue(modRate) then return 0 end
            local remaining = (chargeDur - (TMW.time - attributes.chargeStart)) / modRate
            if remaining > 0 then
                return tonumber(format("%.1f", remaining)) or 0
            end
        end

        -- DEBUG: dump all attribute keys once per icon to find cooldown attribute names
        if not icon._cdDebugDone then
            icon._cdDebugDone = true
            local keys = {}
            for k, v in pairs(attributes) do
                local vtype = type(v)
                local vstr
                if issecretvalue(v) then
                    vstr = "SECRET"
                elseif vtype == "number" then
                    vstr = tostring(v)
                elseif vtype == "table" or vtype == "userdata" then
                    vstr = vtype
                else
                    vstr = tostring(v)
                end
                keys[#keys + 1] = k .. "=" .. vstr
            end
            print("ChargeDuration attrs: " .. table.concat(keys, ", "))
        end

        -- Non-charge: Midnight secrets path (skip GCD)
        if attributes.durObj then
            if attributes.durObj.isOnGCD then
                return 0
            end
            return attributes.durObj:GetRemainingDuration()
        end

        -- Non-charge: legacy numeric path
        local duration = attributes.duration
        local start = attributes.start
        if duration and start and not issecretvalue(duration) and not issecretvalue(start) and duration > 0 then
            local remaining = duration - (TMW.time - start)
            if remaining > 0 then
                return tonumber(format("%.1f", remaining)) or 0
            end
        end

        return 0
    end,
    arg = {
        'icon', 'string', '@req',
    },
    events = "FastUpdate",
    ret = "number",
    doc = "Returns remaining cooldown for charge-based spells (recharge time) or regular spells (cooldown time).",
    example = '[ChargeDuration:TMWFormatDuration] => "5.3"',
    category = "TellMeWhen",
})
