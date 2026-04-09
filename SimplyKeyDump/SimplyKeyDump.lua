SimplyKeyDump = SimplyKeyDump or {}

local function safe_tostring(v)
  local ok, s = pcall(tostring, v)
  if ok then return s end
  return "<tostring error>"
end

local function dump_table(tbl, out, prefix, depth, seen)
  if depth <= 0 or type(tbl) ~= "table" then return end
  seen = seen or {}
  if seen[tbl] then return end
  seen[tbl] = true

  for k, v in pairs(tbl) do
    local key = safe_tostring(k)
    local t = type(v)
    local full = prefix .. key
    if t == "function" and debug and debug.getinfo then
      local info = debug.getinfo(v, "nS")
      out[full] = "function:" .. (info.name or "") .. ":" .. (info.short_src or "")
    else
      out[full] = t
    end
    if t == "table" then
      dump_table(v, out, full .. ".", depth - 1, seen)
    end
  end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
  if not Action then return end
  SimplyKeyDump = {}
  dump_table(Action, SimplyKeyDump, "Action.", 3, {})
end)
