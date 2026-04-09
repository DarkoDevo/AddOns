local AddonName, SkillCapped = ...
local SC = SkillCapped

function SC:OmniCDDB(contentType)
    local scOmniCDDB = {
        ["profileKeys"] = {
        [SC:GetPlayerNameAndRealm()] = "SkillCapped",
        },
        ["namespaces"] = {
        },
        ["cooldowns"] = {
        [31661] = {
        ["type"] = "aoeCC",
        ["buff"] = 31661,
        ["class"] = "MAGE",
        ["name"] = "Dragon's Breath",
        ["charges"] = {
        ["default"] = 1,
        },
        ["spec"] = {
        31661,
        },
        ["duration"] = {
        ["default"] = 32,
        },
        ["icon"] = 134153,
        ["spellID"] = 31661,
        },
        [633] = {
        ["type"] = "externalDefensive",
        ["buff"] = 633,
        ["class"] = "PALADIN",
        ["name"] = "Lay on Hands",
        ["charges"] = {
        ["default"] = 1,
        },
        ["spec"] = {
        633,
        },
        ["duration"] = {
        ["default"] = 600,
        },
        ["icon"] = 135928,
        ["spellID"] = 633,
        },
        },
        ["version"] = 4,
        ["profiles"] = {
        ["Default"] = {
        },
        ["SkillCapped"] = {
        ["Party"] = {
        ["party"] = {
        ["extraBars"] = {
        ["raidBar2"] = {
        ["progressBar"] = false,
        ["locked"] = true,
        ["enabled"] = true,
        ["layout"] = "horizontal",
        ["name"] = "CC",
        ["growUpward"] = true,
        ["anchor"] = "BOTTOMLEFT",
        ["columns"] = 5,
        ["attach"] = "TOPRIGHT",
        ["scale"] = 0.8500000000000001,
        ["manualPos"] = {
        ["raidBar2"] = {
        ["y"] = 534.7559152350514,
        ["x"] = 450.1334428169321,
        },
        },
        },
        ["raidBar3"] = {
        ["anchor"] = "TOPLEFT",
        ["enabled"] = true,
        ["layout"] = "horizontal",
        ["name"] = "Externals",
        ["locked"] = true,
        ["manualPos"] = {
        ["raidBar3"] = {
        ["y"] = 304.3557003354308,
        ["x"] = 344.5348781982812,
        },
        },
        ["attach"] = "BOTTOMLEFT",
        ["scale"] = 0.8500000000000001,
        ["columns"] = 5,
        },
        ["raidBar1"] = {
        ["statusBarWidth"] = 173,
        ["growUpward"] = true,
        ["scale"] = 0.6000000000000001,
        ["locked"] = true,
        ["manualPos"] = {
        ["raidBar1"] = {
        ["y"] = 528.0000816989923,
        ["x"] = 344.8888164810414,
        },
        },
        },
        },
        ["spells"] = {
        ["357210"] = true,
        ["406732"] = true,
        ["197721"] = true,
        ["200851"] = true,
        ["108199"] = true,
        ["370665"] = true,
        ["108270"] = true,
        ["265221"] = true,
        ["102793"] = true,
        ["322507"] = true,
        ["221562"] = true,
        ["403876"] = true,
        ["414664"] = true,
        ["115078"] = true,
        ["55233"] = true,
        ["22570"] = true,
        ["421453"] = true,
        ["108281"] = true,
        ["498"] = true,
        ["1776"] = true,
        ["204406"] = true,
        ["49039"] = true,
        ["324312"] = true,
        ["389539"] = true,
        ["443124"] = true,
        ["200183"] = true,
        ["228920"] = true,
        ["211881"] = true,
        ["113724"] = true,
        ["455395"] = true,
        ["385059"] = true,
        ["213691"] = true,
        ["207399"] = true,
        ["32375"] = true,
        ["108238"] = true,
        ["55342"] = true,
        ["108416"] = true,
        ["49206"] = true,
        ["452930"] = true,
        ["392966"] = true,
        ["88625"] = true,
        ["374251"] = true,
        ["31850"] = true,
        ["47476"] = true,
        ["64044"] = true,
        ["48743"] = true,
        ["107570"] = true,
        ["109304"] = true,
        ["305483"] = true,
        ["360806"] = true,
        ["47481"] = true,
        ["264735"] = true,
        ["227847"] = true,
        ["383762"] = true,
        ["236776"] = true,
        ["374348"] = true,
        ["184662"] = true,
        ["198898"] = true,
        ["327574"] = true,
        ["29166"] = true,
        ["200652"] = true,
        ["198103"] = true,
        ["370960"] = true,
        ["192249"] = true,
        ["217832"] = true,
        ["110959"] = true,
        ["19236"] = true,
        ["109248"] = true,
        },
        ["icons"] = {
        ["scale"] = 0.64,
        },
        ["position"] = {
        ["offsetX"] = 1,
        ["anchor"] = "TOPRIGHT",
        ["paddingX"] = 1,
        ["preset"] = "TOPLEFT",
        ["attach"] = "TOPLEFT",
        },
        ["frame"] = {
        ["disarm"] = 2,
        ["cc"] = 2,
        },
        },
        ["arena"] = {
        ["extraBars"] = {
        ["raidBar1"] = {
        ["locked"] = true,
        ["enabled"] = true,
        ["growUpward"] = true,
        ["manualPos"] = {
        ["raidBar1"] = {
        ["y"] = 525.0271074328884,
        ["x"] = 220.4376985972776,
        },
        },
        },
        },
        ["spells"] = {
        ["2825"] = false,
        ["20230"] = false,
        ["3045"] = false,
        ["77130"] = true,
        ["6346"] = false,
        ["88423"] = true,
        ["676"] = false,
        ["213691"] = true,
        ["12043"] = false,
        ["2894"] = false,
        ["33831"] = false,
        ["12472"] = false,
        ["31884"] = false,
        ["13877"] = false,
        ["23920"] = false,
        ["108270"] = true,
        ["19505"] = false,
        ["46968"] = true,
        ["452930"] = true,
        ["2782"] = true,
        ["119381"] = true,
        ["1219201"] = true,
        ["6229"] = true,
        ["1122"] = false,
        ["19574"] = false,
        ["34433"] = false,
        ["18288"] = false,
        ["12042"] = false,
        ["99"] = true,
        ["4987"] = true,
        ["29166"] = true,
        ["13896"] = false,
        ["179057"] = true,
        ["10060"] = false,
        ["498"] = true,
        ["475"] = true,
        ["13750"] = false,
        ["12292"] = false,
        ["132158"] = true,
        ["215769"] = true,
        ["527"] = true,
        ["328530"] = true,
        ["31661"] = true,
        ["16166"] = false,
        ["14751"] = false,
        ["360823"] = true,
        ["51886"] = true,
        ["16190"] = true,
        ["473909"] = true,
        ["115450"] = true,
        ["14177"] = false,
        ["11129"] = false,
        ["236320"] = true,
        ["28880"] = false,
        ["1719"] = false,
        ["18499"] = false,
        ["26297"] = false,
        ["14183"] = false,
        ["51514"] = true,
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
        ["raidMovement"] = 9,
        ["externalDefensive"] = 11,
        ["counterCC"] = 16,
        ["taunt"] = 2,
        ["interrupt"] = 1,
        ["trinket"] = 15,
        ["defensive"] = 13,
        ["consumable"] = 15,
        ["covenant"] = 14,
        ["heal"] = 12,
        ["movement"] = 8,
        ["essence"] = 15,
        ["offensive"] = 1,
        ["raidDefensive"] = 11,
        ["tankDefensive"] = 13,
        ["immunity"] = 14,
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