-- Localization.lua
WoWMemory       = WoWMemory or {}
WoWMemoryConfig = WoWMemoryConfig or {}

-- Langue active (auto = selon le client)
function WoWMemory.GetActiveLanguage()
  local forced = WoWMemoryConfig.language -- "auto" | "fr" | "en" | nil
  if forced and forced ~= "auto" then return forced end
  local loc = GetLocale()
  if loc and loc:lower():find("^fr") then return "fr" end
  return "en"
end

-- Brancher tes tables + fallback FR->EN
local EN = STRINGS_EN or {}
local FR = setmetatable(STRINGS_FR or {}, { __index = EN })
WoWMemory.LOCALES = { en = EN, fr = FR }

-- Getter de chaîne
function WoWMemory.L(key)
  local lang = WoWMemory.GetActiveLanguage()
  local t = WoWMemory.LOCALES[lang] or EN
  return (t and t[key]) or (EN and EN[key]) or key
end

-- Setter de langue (persisté) + refresh UI si dispo
function WoWMemory.SetLanguage(lang) -- "fr" | "en" | "auto"
  if lang ~= "fr" and lang ~= "en" and lang ~= "auto" then return end
  WoWMemoryConfig.language = lang
  if WoWMemory.RefreshUI and type(WoWMemory.RefreshUI) == "function" then
    WoWMemory.RefreshUI()
  end
end


