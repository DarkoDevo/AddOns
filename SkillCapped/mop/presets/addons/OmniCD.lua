local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:OmniCDDB(contentType)
    local scOmniCDDB = {
    ["version"] = 4,
    ["namespaces"] = {
    },
    ["cooldowns"] = {
    },
    ["profileKeys"] = {
    ["Mýstíc - Firemaw"] = "SkillCapped",
    },
    ["profiles"] = {
    ["SkillCapped"] = {
    ["Party"] = {
    ["arena"] = {
    ["extraBars"] = {
    ["raidBar1"] = {
    ["locked"] = true,
    ["enabled"] = true,
    ["growUpward"] = true,
    ["manualPos"] = {
    ["raidBar1"] = {
    ["y"] = 525.5886308787558,
    ["x"] = 218.2150911422832,
    },
    },
    },
    },
    ["spells"] = {
    ["740"] = false,
    ["51490"] = false,
    ["1719"] = false,
    ["86346"] = false,
    ["10060"] = false,
    ["48743"] = false,
    ["124974"] = false,
    ["64382"] = false,
    ["18499"] = false,
    ["31821"] = false,
    ["18540"] = false,
    ["108270"] = false,
    ["1122"] = false,
    ["113860"] = false,
    ["64901"] = false,
    ["31842"] = false,
    ["113072"] = false,
    ["115176"] = false,
    ["122288"] = false,
    ["127361"] = false,
    ["32379"] = false,
    ["34433"] = false,
    ["51753"] = false,
    ["15286"] = false,
    ["114203"] = false,
    ["118000"] = false,
    ["51271"] = false,
    ["121471"] = false,
    ["107574"] = false,
    ["108281"] = false,
    ["633"] = false,
    ["89485"] = false,
    ["47568"] = false,
    ["22842"] = true,
    ["20549"] = false,
    ["114207"] = false,
    ["13750"] = false,
    ["108921"] = false,
    ["49039"] = false,
    ["126135"] = false,
    ["57755"] = false,
    ["51533"] = false,
    ["16166"] = false,
    ["102558"] = false,
    ["2062"] = false,
    ["23920"] = false,
    ["11129"] = false,
    ["4987"] = false,
    ["116841"] = false,
    ["114157"] = false,
    ["51690"] = false,
    ["126458"] = false,
    ["129176"] = false,
    ["53271"] = false,
    ["3045"] = false,
    ["3411"] = false,
    ["132469"] = false,
    ["126449"] = false,
    ["676"] = false,
    ["2894"] = false,
    ["115213"] = false,
    ["1044"] = false,
    ["32375"] = false,
    ["31884"] = false,
    ["122286"] = false,
    ["55342"] = false,
    ["19505"] = false,
    ["79140"] = false,
    ["49206"] = false,
    ["16190"] = false,
    ["49016"] = false,
    ["113861"] = false,
    ["19574"] = false,
    ["86698"] = false,
    ["50334"] = false,
    ["12042"] = false,
    ["42650"] = false,
    ["113858"] = false,
    ["29166"] = false,
    ["115450"] = false,
    ["64843"] = false,
    ["108269"] = false,
    ["121818"] = false,
    ["58875"] = false,
    ["113277"] = false,
    ["12472"] = false,
    ["114039"] = false,
    ["6346"] = false,
    ["112071"] = false,
    ["108201"] = false,
    ["114049"] = false,
    ["49028"] = false,
    ["106951"] = false,
    ["120668"] = false,
    ["108200"] = false,
    ["116844"] = false,
    ["106922"] = false,
    ["51713"] = false,
    ["131894"] = false,
    ["117368"] = false,
    ["51722"] = false,
    ["110959"] = false,
    ["123995"] = false,
    ["122278"] = false,
    },
    ["icons"] = {
    ["scale"] = 0.75,
    },
    ["position"] = {
    ["columns"] = 9,
    ["attach"] = "TOPLEFT",
    ["preset"] = "TOPLEFT",
    ["anchor"] = "TOPRIGHT",
    },
    ["priority"] = {
    ["other"] = 6,
    ["freedom"] = 10,
    ["racial"] = 17,
    ["disarm"] = 4,
    ["aoeCC"] = 5,
    ["pvptrinket"] = 18,
    ["dispel"] = 16,
    ["cc"] = 3,
    ["counterCC"] = 16,
    ["externalDefensive"] = 11,
    ["taunt"] = 2,
    ["interrupt"] = 1,
    ["trinket"] = 15,
    ["defensive"] = 13,
    ["immunity"] = 14,
    ["heal"] = 12,
    ["movement"] = 8,
    ["consumable"] = 15,
    ["offensive"] = 1,
    ["raidDefensive"] = 11,
    ["tankDefensive"] = 13,
    ["raidMovement"] = 9,
    },
    },
    ["visibility"] = {
    ["party"] = false,
    },
    },
    },
    },
    }

    local baseBackupKey = "OmniCDDB"
    local taggedBackupKey = baseBackupKey .. contentType

    -- Perform backup if it doesn't exist yet
    if not SkillCappedBackupDB[baseBackupKey] then
        -- Main backup for OmniCDDB
        SkillCappedBackupDB[baseBackupKey] = SC:DeepCopy(OmniCDDB)
        SkillCappedBackupDB.addonBackupTimes["OmniCD"] = SC:GetDateAndTime()
    end

    -- Set tags for PvP and PvE without creating a new backup
    if not SkillCappedBackupDB[taggedBackupKey] then
        SkillCappedBackupDB[taggedBackupKey] = true
    end

    -- Apply the custom SkillCapped profile to OmniCDDB
    OmniCDDB = scOmniCDDB
    local profileName = (SkillCappedDB.mainContent == "PvP" and "SkillCapped") or (SkillCappedDB.mainContent == "PvE" and "SkillCapped PvE")

    -- Update profile keys for all saved characters
    OmniCDDB.profileKeys[SC:GetPlayerNameAndRealm()] = profileName

    for savedPlayerNameAndRealm, assignedContent in pairs(SkillCappedDB.characters) do
        if assignedContent == "PvP" then
            OmniCDDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
        elseif assignedContent == "PvE" then
            OmniCDDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped PvE"
        end
    end
end

-- Update OmniCD profile for a specific content type
function SC:UpdateOmniCDProfile(contentType)
    if not OmniCDDB or not SkillCappedBackupDB["OmniCDDB"] then return end

    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    local profileName = (SkillCappedDB.mainContent == "PvP" and "SkillCapped") or (SkillCappedDB.mainContent == "PvE" and "SkillCapped PvE")

    OmniCDDB.profileKeys[playerNameAndRealm] = profileName

    for savedPlayerNameAndRealm, assignedContent in pairs(SkillCappedDB.characters) do
        if assignedContent == "PvP" then
            OmniCDDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
        elseif assignedContent == "PvE" then
            OmniCDDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped PvE"
        end
    end
end