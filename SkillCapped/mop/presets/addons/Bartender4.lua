local AddonName, SkillCapped = ...
local SC = SkillCapped

local scBartender4DB = {
["namespaces"] = {
["ActionBars"] = {
["profiles"] = {
["SkillCapped"] = {
["actionbars"] = {
{
["elements"] = {
["macro"] = {
["fontSize"] = 8,
["textOffsetY"] = 1,
["fontFlags"] = "",
},
["hotkey"] = {
["fontSize"] = 10,
["textOffsetY"] = -2,
},
["count"] = {
["fontSize"] = 10,
},
},
["showgrid"] = true,
["version"] = 3,
["position"] = {
["y"] = 45,
["x"] = -277.2,
["point"] = "BOTTOM",
["scale"] = 1.2,
},
},
{
["enabled"] = false,
["version"] = 3,
["position"] = {
["y"] = -207,
["x"] = -230.4998168945313,
["point"] = "CENTER",
},
},
{
["elements"] = {
["macro"] = {
["fontSize"] = 8,
["textOffsetY"] = 1,
},
["hotkey"] = {
["fontSize"] = 10,
["textOffsetY"] = -2,
},
["count"] = {
["fontSize"] = 10,
},
},
["showgrid"] = true,
["rows"] = 12,
["version"] = 3,
["position"] = {
["y"] = 208.0237761189055,
["x"] = -93.59920348058222,
["point"] = "RIGHT",
["scale"] = 1.200000047683716,
},
},
{
["elements"] = {
["macro"] = {
["fontSize"] = 8,
["textOffsetY"] = 1,
},
["hotkey"] = {
["fontSize"] = 10,
["textOffsetY"] = -2,
},
["count"] = {
["fontSize"] = 10,
},
},
["showgrid"] = true,
["rows"] = 12,
["version"] = 3,
["position"] = {
["y"] = 208.0237394978103,
["x"] = -47.99949463736266,
["point"] = "RIGHT",
["scale"] = 1.200000047683716,
},
},
{
["elements"] = {
["macro"] = {
["fontSize"] = 8,
["textOffsetY"] = 1,
},
["hotkey"] = {
["fontSize"] = 10,
["textOffsetY"] = -2,
},
["count"] = {
["fontSize"] = 10,
},
},
["showgrid"] = true,
["version"] = 3,
["position"] = {
["y"] = 131.7366629495882,
["x"] = -276.5999038404843,
["point"] = "BOTTOM",
["scale"] = 1.200000047683716,
},
},
{
["elements"] = {
["macro"] = {
["fontSize"] = 8,
["textOffsetY"] = 1,
},
["hotkey"] = {
["fontSize"] = 10,
["textOffsetY"] = -2,
},
["count"] = {
["fontSize"] = 10,
},
},
["showgrid"] = true,
["version"] = 3,
["position"] = {
["y"] = 88.07764327039877,
["x"] = -276.5999770826747,
["point"] = "BOTTOM",
["scale"] = 1.200000047683716,
},
},
{
},
{
},
{
},
{
},
[13] = {
},
[15] = {
},
},
},
},
},
["ExtraActionBar"] = {
["profiles"] = {
["SkillCapped"] = {
["position"] = {
["y"] = -192.4999389648438,
["x"] = -63.49957275390625,
["point"] = "CENTER",
},
["version"] = 3,
},
},
},
["MicroMenu"] = {
["profiles"] = {
["SkillCapped"] = {
["version"] = 3,
["position"] = {
["y"] = 45.23484802246094,
["x"] = -308.8331298828125,
["point"] = "BOTTOMRIGHT",
["scale"] = 1,
},
["fadeoutalpha"] = 0,
},
},
},
["BagBar"] = {
["profiles"] = {
["SkillCapped"] = {
["scale"] = 0.9,
["skin"] = {
["Zoom"] = true,
},
["keyring"] = false,
["verticalAlignment"] = "CENTER",
["version"] = 3,
["position"] = {
["y"] = 84,
["x"] = -182.05908203125,
["point"] = "BOTTOMRIGHT",
},
["padding"] = 4,
["fadeoutalpha"] = 0,
},
},
},
["MultiCast"] = {
["profiles"] = {
["SkillCapped"] = {
["version"] = 3,
["position"] = {
["y"] = 164,
["x"] = -272,
["point"] = "BOTTOM",
},
},
["Mýstík - Firemaw"] = {
["version"] = 3,
["position"] = {
["y"] = 19.50004577636719,
["x"] = -114.5,
["point"] = "CENTER",
},
},
},
},
["BlizzardArt"] = {
["profiles"] = {
["SkillCapped"] = {
["position"] = {
["y"] = 47,
["x"] = -512,
["point"] = "BOTTOM",
},
["version"] = 3,
},
},
},
["XPBar"] = {
["profiles"] = {
["SkillCapped"] = {
["enabled"] = true,
["fadeout"] = true,
["fadeoutalpha"] = 0,
["position"] = {
["y"] = 0.1,
["x"] = -440.3199737548828,
["point"] = "TOP",
["scale"] = 0.86,
},
["version"] = 3,
},
},
},
["StanceBar"] = {
["profiles"] = {
["SkillCapped"] = {
["version"] = 3,
["position"] = {
["y"] = 162,
["x"] = -275,
["point"] = "BOTTOM",
["scale"] = 1,
},
},
},
},
["Vehicle"] = {
["profiles"] = {
["SkillCapped"] = {
["position"] = {
["y"] = 187.9367065429688,
["x"] = 245.7001953125,
["point"] = "BOTTOM",
},
["version"] = 3,
},
},
},
["PetBar"] = {
["profiles"] = {
["SkillCapped"] = {
["version"] = 3,
["position"] = {
["y"] = 162,
["x"] = -49,
["point"] = "BOTTOM",
},
},
},
},
["RepBar"] = {
["profiles"] = {
["SkillCapped"] = {
["enabled"] = true,
["fadeout"] = true,
["fadeoutalpha"] = 0,
["position"] = {
["y"] = 0.1,
["x"] = -409.5999755859375,
["point"] = "TOP",
["scale"] = 0.8,
},
["version"] = 3,
},
},
},
},
["profileKeys"] = {
[SC:GetPlayerNameAndRealm()] = "SkillCapped",
},
["profiles"] = {
["SkillCapped"] = {
["selfcastmodifier"] = false,
["blizzardVehicle"] = true,
["focuscastmodifier"] = false,
["onkeydown"] = true,
["minimapIcon"] = {
["hide"] = true,
},
["outofrange"] = "hotkey",
},
},
}

function SC:Bartender4DB()
    if not SkillCappedBackupDB.Bartender4DB then
        SkillCappedBackupDB.Bartender4DB = SC:DeepCopy(Bartender4DB)
        SkillCappedBackupDB.addonBackupTimes["Bartender4"] = SC:GetDateAndTime()
    end

    Bartender4DB = scBartender4DB

    SC:UpdateBartender4Profile()
    --SC:UpdateAddonProfileKeysToSkillCapped("Bartender4DB")
end

function SC:UpdateBartender4Profile()
    if not Bartender4DB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    Bartender4DB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        Bartender4DB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end