local AddonName, SkillCapped = ...
local SC = SkillCapped

local gameVersion = select(1, GetBuildInfo())
SC.isMidnight = gameVersion:match("^12")
SC.isRetail = gameVersion:match("^11")
SC.isMoP = gameVersion:match("^5%.")
SC.isTBC = gameVersion:match("^2%.")
SC.isEra = gameVersion:match("^1%.")