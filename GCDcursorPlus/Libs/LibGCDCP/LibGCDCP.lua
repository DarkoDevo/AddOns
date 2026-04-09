-- Umbrella entry point for LibGCDCP sub-libraries.
-- Loaded after the concrete modules (see LibGCDCP.xml) so it can surface them under a single table.

local LibStub = _G.LibStub
assert(LibStub, "LibGCDCP requires LibStub")

local GLOBAL_NAME = "LibGCDCP"
local EditModeMajor = "LibGCDCPEditMode-1.0"
local SettingsModeMajor = "LibGCDCPSettingsMode-1.0"

local umbrella = _G[GLOBAL_NAME] or {}
_G[GLOBAL_NAME] = umbrella

local function bindModule(key, major)
	umbrella[key] = umbrella[key] or LibStub:GetLibrary(major, true)
end

bindModule("EditMode", EditModeMajor)
bindModule("SettingsMode", SettingsModeMajor)

function umbrella.GetModule(_, name)
	if name == "EditMode" then
		return LibStub:GetLibrary(EditModeMajor, true)
	elseif name == "SettingsMode" then
		return LibStub:GetLibrary(SettingsModeMajor, true)
	end
	return nil
end

return umbrella
