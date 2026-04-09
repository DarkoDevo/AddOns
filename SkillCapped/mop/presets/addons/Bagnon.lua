local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:BrotherBags()
    local scBrotherBags = {}

    if not SkillCappedBackupDB.BrotherBags then
        SkillCappedBackupDB.BrotherBags = true
        SkillCappedBackupDB.addonBackupTimes["Bagnon"] = SC:GetDateAndTime()
    end

    --BrotherBags = scBrotherBags

    SC:UpdateBetterBagsProfile()
end

function SC:UpdateBetterBagsProfile()
    -- if not BrotherBags then return end
    -- if not SkillCappedBackupDB.BrotherBags then return end
    -- local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    -- BrotherBags.profileKeys[playerNameAndRealm] = "Default"

    -- for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
    --     BrotherBags.profileKeys[savedPlayerNameAndRealm] = "Default"
    -- end
end