local AddonName, SkillCapped = ...
local SC = SkillCapped

local scTalentLoadoutEx = {
["DEATHKNIGHT"] = {
{
  {
  ["name"] = "Skill Capped Blood DK",
  ["icon"] = 135771,
  ["isExpanded"] = true,
},
  {
  ["name"] = "M+",
  ["icon"] = 135770,
  ["isInGroup"] = true,
  ["text"] = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzwMmxgZbmZmmZzMzMzMmBAAAAGMzMzMjZmZMAYmZmZGAAAzMbjhxMWWasstMMZbYYBwMGAAMzAAGA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 135770,
  ["isInGroup"] = true,
  ["text"] = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzwMmxgZbmZmmZzMzMzMmBAAAAGMzMzMjZmZMAYmZmZGAAAzMbjhxMWWasstMMZbYYBwMGAAMzAAGA",
}
},
{
  {
  ["name"] = "Skill Capped Frost DK",
  ["icon"] = 135771,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Rider of the Apocalypse",
  ["icon"] = 135773,
  ["isInGroup"] = true,
  ["text"] = "CsPAAAAAAAAAAAAAAAAAAAAAAMDYmBjZmZYWmZmZYbmZkZMzMjZGDjZGMzMzMDAAAAAAAAAAbmNDDMwswQDbGzMMzAGADAzMMwA",
  ["pvp1"] = 702,
  ["pvp2"] = 5429,
  ["pvp3"] = 5591,
},
  {
  ["name"] = "Arena - Deathbringer",
  ["icon"] = 135773,
  ["isInGroup"] = true,
  ["text"] = "CsPAAAAAAAAAAAAAAAAAAAAAAMDYmBjZmZYWmZmZYbmZkZMzMjZGDjZGMzMzMDAAAAAAAAAGz2ADYDsMMBGLGzMMzAGADzMAMwA",
  ["pvp1"] = 702,
  ["pvp2"] = 5429,
  ["pvp3"] = 5591,
},
  {
  ["name"] = "M+",
  ["icon"] = 135773,
  ["isInGroup"] = true,
  ["text"] = "CsPAAAAAAAAAAAAAAAAAAAAAAMDYmZMjZAz2MzMzMLzMjmZMGmZMgxMzMzMzMDAAAAAAAAAGz2ADYBsMMhMWwMzMzMwAwwMDADM",
},
  {
  ["name"] = "Raid",
  ["icon"] = 135773,
  ["isInGroup"] = true,
  ["text"] = "CsPAAAAAAAAAAAAAAAAAAAAAAMDYmZMjZAz2MzMzMLzMjmZMGmZMgxMzMzMzMDAAAAAAAAAGz2ADYBsMMhMWwMzMzMwAwwMDADM",
}
},
{
  {
  ["name"] = "Skill Capped Unholy DK",
  ["icon"] = 135771,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena",
  ["icon"] = 135775,
  ["isInGroup"] = true,
  ["text"] = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmhhZMMzyYmZa2mZGjZMDAAAAAAAgZwMDAWmxMDzMGzMgNzihBGY2YoxCDwMAMzMzYGgZmxMjB",
  ["pvp1"] = 149,
  ["pvp2"] = 3746,
  ["pvp3"] = 5590,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 135775,
  ["isInGroup"] = true,
  ["text"] = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmBjZMjZWGzMTz2MGjhZAAAAAAAAMzwMDAWmxYMzMmxMgNzmhhMwsxQjFGgZAYMzMmBYmZMzYA",
  ["pvp1"] = 149,
  ["pvp2"] = 5430,
  ["pvp3"] = 5436,
},
  {
  ["name"] = "M+",
  ["icon"] = 135775,
  ["isInGroup"] = true,
  ["text"] = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmZMjZAz2MzMTz2MzYmZMAAAAAAAAMzwMDAWGmZ2mZGzYYw2MLmZmFNzyCzGzy0YBDYGAGzMDDmZmZYmxA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 135775,
  ["isInGroup"] = true,
  ["text"] = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmZMjZAz2MzMTz2MzYmZMAAAAAAAAMzwMDAWGmZ2mZGzYYw2MLmZmFNzyCzGzy0YBDYGAGzMDDmZmZYmxA",
}
},
},
["WARRIOR"] = {
{
  {
  ["name"] = "Skill Capped Arms Warrior",
  ["icon"] = 626008,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Colossus",
  ["icon"] = 132355,
  ["isInGroup"] = true,
  ["text"] = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMzMzYAAAAMMNMzwYZxMzMDDzMAAAAAGLmBEDYxMG2gBmRb0YwCYmxiZZmZxyMbDmZAAzYYA",
  ["pvp1"] = 31,
  ["pvp2"] = 33,
  ["pvp3"] = 3534,
},
  {
  ["name"] = "Arena - Slayer",
  ["icon"] = 132355,
  ["isInGroup"] = true,
  ["text"] = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMzMzMDAAAghphZGGLLmZmZYYmBAAAAwYZmBEzYbbgNwAmhJkZwGYmxiZZMLMjBYmBgZMMA",
  ["pvp1"] = 31,
  ["pvp2"] = 33,
  ["pvp3"] = 3534,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 132355,
  ["isInGroup"] = true,
  ["text"] = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMzMzYAAAAMMhZmZGLMzMDGzMDAAAAgxiZgtMDYxMG2gBmRb0YGWAmxiZZMsMz2gZGAwMGGA",
  ["pvp1"] = 33,
  ["pvp2"] = 31,
  ["pvp3"] = 3534,
},
  {
  ["name"] = "M+",
  ["icon"] = 132355,
  ["isInGroup"] = true,
  ["text"] = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphxwMWmZmZGzMmZAAAAAM2MDsFDYzMGWgBmRb0YwCYmhxygZzsNYmBAYmhB",
},
  {
  ["name"] = "Raid",
  ["icon"] = 132355,
  ["isInGroup"] = true,
  ["text"] = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphxwMWmZmZGzMmZAAAAAM2MDsFDYzMGWgBmRb0YwCYmhxygZzsNYmBAYmhB",
}
},
{
  {
  ["name"] = "Skill Capped Fury Warrior",
  ["icon"] = 626008,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Mountain Thane",
  ["icon"] = 132347,
  ["isInGroup"] = true,
  ["text"] = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDzMjZWYmZGjhZGzYmZmlZmZGjZZMzMAAQYgNYZxoxMgMbYGLAmZxMLDAmZAMMmxwgB",
  ["pvp1"] = 3735,
  ["pvp2"] = 3533,
  ["pvp3"] = 177,
},
  {
  ["name"] = "Arena - Slayer",
  ["icon"] = 132347,
  ["isInGroup"] = true,
  ["text"] = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDzMMWWMzMzMGmZmZMzMzyMmZmxsYMzAAAxYbbgNwEMDTgZYDYmZhZZAAwMDjxMzwgB",
  ["pvp1"] = 3735,
  ["pvp2"] = 3533,
  ["pvp3"] = 177,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 132347,
  ["isInGroup"] = true,
  ["text"] = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDzMzMzCzMzYwMzYGzMzsMzMzYMLjZmBAACDsBLLGNmBkZBzYBwMLGLDAmZAMMmxwgB",
  ["pvp1"] = 3735,
  ["pvp2"] = 177,
  ["pvp3"] = 179,
},
  {
  ["name"] = "M+",
  ["icon"] = 132347,
  ["isInGroup"] = true,
  ["text"] = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZMjlZmZGjZMzYmZGzsMzMGjZZMzMAAQYgNYZzoxMgMbYGLAmBzyAgZGADzMzMMYA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 132347,
  ["isInGroup"] = true,
  ["text"] = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZMjlZmZGjZMzYmZGzsMzMGjZZMzMAAQYgNYZzoxMgMbYGLAmBzyAgZGADzMzMMYA",
}
},
{
  {
  ["name"] = "Skill Capped Prot Warrior",
  ["icon"] = 626008,
  ["isExpanded"] = true,
},
  {
  ["name"] = "M+",
  ["icon"] = 132341,
  ["isInGroup"] = true,
  ["text"] = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzYmZmZmxsZmZZGjxoxMmZzMzMzYGmZAAAAwyMDwMGgB2glFjGzAYWiZ2wMzMzwwAgZGAAMgHA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 132341,
  ["isInGroup"] = true,
  ["text"] = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzYmZmZmxsZmZZGjxoxMmZzMzMzYGmZAAAAwyMDwMGgB2glFjGzAYWiZ2wMzMzwwAgZGAAMgHA",
}
},
},
["PALADIN"] = {
{
  {
  ["name"] = "Skill Capped Holy Paladin",
  ["icon"] = 626003,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Lightsmith",
  ["icon"] = 135920,
  ["isInGroup"] = true,
  ["text"] = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYBAMDAwglhBzsMzYZmxYGbjNzsw0EzyMMzwgtMAMAsB2MbmZAQAAzMLbL2mZYjtxAbmhZYGmBwMDgxAaA",
  ["pvp1"] = 86,
  ["pvp2"] = 5692,
  ["pvp3"] = 640,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 135920,
  ["isInGroup"] = true,
  ["text"] = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYBAMDAwglhBzsMzYZGzYGbjNzsYmmYWmhZGGslBgBgNwGbmZAQAAzMLbLtMzwCbMM2MDzwMMDgZGAMY0A",
  ["pvp1"] = 640,
  ["pvp2"] = 5692,
  ["pvp3"] = 5583,
},
  {
  ["name"] = "M+",
  ["icon"] = 135920,
  ["isInGroup"] = true,
  ["text"] = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAMLAgZAAglxMYGzMzCjxYWGbzMLmpJmFjZmhhZLAYGAbgNWmxMLz2Mzs1AAAAswCwyGMmxMYAAMzwMGjGA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 135920,
  ["isInGroup"] = true,
  ["text"] = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAMLAgZAAglxMYGzMzCjxYWGbzMLmpJmFjZmhhZLAYGAbgNWmxMLz2Mzs1AAAAswCwyGMmxMYAAMzwMGjGA",
}
},
{
  {
  ["name"] = "Skill Capped Prot Paladin",
  ["icon"] = 626003,
  ["isExpanded"] = true,
},
  {
  ["name"] = "M+",
  ["icon"] = 236264,
  ["isInGroup"] = true,
  ["text"] = "CIEAAAAAAAAAAAAAAAAAAAAAAsZMYWGLzMjZmZZbMGzsMLDDAwAAAAAAgmmZWmZMDGmt2AwADwgNAAwMTbzMbzMzsst0yMjFGmBwYMDjBAzMbzAMzAG",
},
  {
  ["name"] = "Raid",
  ["icon"] = 236264,
  ["isInGroup"] = true,
  ["text"] = "CIEAAAAAAAAAAAAAAAAAAAAAAsZMYWGLzMjZmZZbMGzsMLDDAwAAAAAAgmmZWmZMDGmt2AwADwgNAAwMTbzMbzMzsst0yMjFGmBwYMDjBAzMbzAMzAG",
}
},
{
  {
  ["name"] = "Skill Capped Ret Paladin",
  ["icon"] = 626003,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Herald of the Sun",
  ["icon"] = 135873,
  ["isInGroup"] = true,
  ["text"] = "CYEAVg1HmQqr1Dwlv86ljju8vCAAAAAQzyyMzsMzMzAAAAAAwMlZZGmZsNYbwsNjHwYmhZsw2AwsMbzMzWDCAAYBwwAjZmhZwMGzGwMzwADG",
  ["pvp1"] = 5584,
  ["pvp2"] = 752,
  ["pvp3"] = 5535,
},
  {
  ["name"] = "Arena - Templar",
  ["icon"] = 135873,
  ["isInGroup"] = true,
  ["text"] = "CYEAVg1HmQqr1Dwlv86ljju8vCAAAAAQzyyMzsNzMGAAAAAAmpMLzwMjthZbwsMjHwYmhZsx2AwsMbzMzSzMTbzMbzAA2AMAGjZYGMjxshlZmZGGDDG",
  ["pvp1"] = 5584,
  ["pvp2"] = 752,
  ["pvp3"] = 5535,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 135873,
  ["isInGroup"] = true,
  ["text"] = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQzy2MzsNmZGDAAAAAwMlZZGmZsNYbwsNjxYmhZsx2AAAyMTbzMbzAA2AMAGjZMzghxsglZwwYYwA",
  ["pvp1"] = 752,
  ["pvp2"] = 5535,
  ["pvp3"] = 5584,
},
  {
  ["name"] = "M+",
  ["icon"] = 135873,
  ["isInGroup"] = true,
  ["text"] = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAAMa22mZmtZmxMAAAAAAmpMmhZGbDz2gZZGzMGDzYhFAAgMz0yMz2MAgNADgxYGGYGzMLYbGMmBGM",
},
  {
  ["name"] = "Raid",
  ["icon"] = 135873,
  ["isInGroup"] = true,
  ["text"] = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAAMa22mZmtZmxMAAAAAAmpMmhZGbDz2gZZGzMGDzYhFAAgMz0yMz2MAgNADgxYGGYGzMLYbGMmBGM",
}
},
},
["MAGE"] = {
{
  {
  ["name"] = "Skill Capped Arcane Mage",
  ["icon"] = 626001,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Spellslinger Orb Barrage",
  ["icon"] = 135932,
  ["isInGroup"] = true,
  ["text"] = "C4DAMhlVtghLZL4RZzExaQoBYNmtlZWmZmZjHYmhmhZAAAMAAIgZmZWWmZiFAAWmxMzYsYZmZGzMzYMzMzYhZmhZAAGAAAzsAAmBAfAD",
  ["pvp1"] = 5707,
  ["pvp2"] = 5661,
  ["pvp3"] = 637,
},
  {
  ["name"] = "Arena - Spellslinger Missiles",
  ["icon"] = 135932,
  ["isInGroup"] = true,
  ["text"] = "C4DAAAAAAAAAAAAAAAAAAAAAAMmllZWmZmZz2DMzQzwMAAAGAAEwMzMLLzMxCAALzYmZwilZmZWGzMmHYmZmxCzMDzAAMAAAzMLAADA%2BAA",
  ["pvp1"] = 5707,
  ["pvp2"] = 5661,
  ["pvp3"] = 637,
},
  {
  ["name"] = "M+",
  ["icon"] = 135932,
  ["isInGroup"] = true,
  ["text"] = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFegZGamxMAAAGAwMz0wyMzMzssMzELAAsMjZmxsZWmZmxMjxYmZmxCzYGDAgBAAwMLYmBmZAwwA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 135932,
  ["isInGroup"] = true,
  ["text"] = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFegZGamxMAAAGAwMz0wyMzMzssMzELAAsMjZmxsZWmZmxMjxYmZmxCzYGDAgBAAwMLYmBmZAwwA",
}
},
{
  {
  ["name"] = "Skill Capped Fire Mage",
  ["icon"] = 626001,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Sunfury",
  ["icon"] = 135810,
  ["isInGroup"] = true,
  ["text"] = "C8DAMhlVtghLZL4RZzExaQoBYNmtlZWmZmZBzMyMMDAAgBAMzMNLLbzAAsZmZmthxMzCAAAAAsYmZmBAAGGzwMPgZWmBwMDZMwwMMA",
  ["pvp1"] = 5588,
  ["pvp2"] = 5706,
  ["pvp3"] = 5621,
},
  {
  ["name"] = "Arena - Frostfire",
  ["icon"] = 135810,
  ["isInGroup"] = true,
  ["text"] = "C8DAAAAAAAAAAAAAAAAAAAAAAMmtlZWmZmZBzMyMMDAAgZWmxMz2sABAAsYmZmtxMzMPwCAAAAAsYmZmBAAGGzMMmZWmBmZAZMAmhB",
  ["pvp1"] = 5588,
  ["pvp2"] = 5706,
  ["pvp3"] = 5621,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 135810,
  ["isInGroup"] = true,
  ["text"] = "C8DAAAAAAAAAAAAAAAAAAAAAAMmtlZWmZmZBzMyMMDAAgBCYmZaWWWmBAYzMzMbDjZmFAAAAAYxMzMDAAMMmhZYmlZAMzAjxwwMMA",
  ["pvp1"] = 5489,
  ["pvp2"] = 5706,
  ["pvp3"] = 5621,
},
  {
  ["name"] = "M+",
  ["icon"] = 135810,
  ["isInGroup"] = true,
  ["text"] = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFegZGZmZmBAAwAAmZmmlltZAA2MzM2GzMzYBAAAAAWMzYGAAYMDjZmZmZZAYmhMGjBzwA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 135810,
  ["isInGroup"] = true,
  ["text"] = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFegZGZmZmBAAwAAmZmmlltZAA2MzM2GzMzYBAAAAAWMzYGAAYMDjZmZmZZAYmhMGjBzwA",
}
},
{
  {
  ["name"] = "Skill Capped Frost Mage",
  ["icon"] = 626001,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Spellslinger",
  ["icon"] = 135846,
  ["isInGroup"] = true,
  ["text"] = "CAEAMhlVtghLZL4RZzExaQoBYNmtlZWmZmZBzMxMMzMzMzsYmZYGzMLz0Mz2sAAmZmZZZmpNAAYBAAAYDgtlxMzMwyMGzMWAAAYmlZGMDjBYwA",
  ["pvp1"] = 5708,
  ["pvp2"] = 5497,
  ["pvp3"] = 5622,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 135846,
  ["isInGroup"] = true,
  ["text"] = "CAEAAAAAAAAAAAAAAAAAAAAAAMmtlZWmZmZBzMxMMzMzMzsYmZMzYGIAAwMzMLLzMtBAALAAAAbAstMmZmBWMGzM2AAAYmFgZYMADGA",
  ["pvp1"] = 5390,
  ["pvp2"] = 5497,
  ["pvp3"] = 5581,
},
  {
  ["name"] = "M+",
  ["icon"] = 135846,
  ["isInGroup"] = true,
  ["text"] = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFmZmYmxMzMzMziZmhZMDEAAYmZmllZm2AAgFAAAgFA2WGzYGMbDjZGLAAAMzGwMMGwMYA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 135846,
  ["isInGroup"] = true,
  ["text"] = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFmZmYmxMzMzMziZmhZMDEAAYmZmllZm2AAgFAAAgFA2WGzYGMbDjZGLAAAMzGwMMGwMYA",
}
},
},
["PRIEST"] = {
{
  {
  ["name"] = "Skill Capped Disc Priest",
  ["icon"] = 626004,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Oracle",
  ["icon"] = 135940,
  ["isInGroup"] = true,
  ["text"] = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMzwyMjZmBMbzYmZGjZGAAAAAAAAAAzMzihZMGLzMzMssYamYAmZDDhxsNAjBLAAwYGGDGAzMzEM",
  ["pvp1"] = 5721,
  ["pvp2"] = 114,
  ["pvp3"] = 5570,
},
  {
  ["name"] = "Arena - Voidweaver",
  ["icon"] = 135940,
  ["isInGroup"] = true,
  ["text"] = "CAQAAAAAAAAAAAAAAAAAAAAAAADswY2YMzYmZMbwMzYmxAAAAAAAAAAYmxihZMGLzMzMssYamYGmZAQAMLz2CYsZAAYMjZMYgZGMTzwHA",
  ["pvp1"] = 5721,
  ["pvp2"] = 114,
  ["pvp3"] = 5570,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 135940,
  ["isInGroup"] = true,
  ["text"] = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMGWmZMzMDMbzYmZGjZGAAAAAAAAAAzMzyMMjZGLGzMssYamYAmZDDFjZZAGDWAAgxMMGMAmZmBM",
  ["pvp1"] = 114,
  ["pvp2"] = 5570,
  ["pvp3"] = 123,
},
  {
  ["name"] = "M+",
  ["icon"] = 135940,
  ["isInGroup"] = true,
  ["text"] = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMGWmZMmBmZbmtZmZmxMDAAAAAAAAAghZZGmZmZYGzMwMNTMAzsghwYWGgxgFAAYMzYMYGgZmRwA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 135940,
  ["isInGroup"] = true,
  ["text"] = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMGWmZMmBmZbmtZmZmxMDAAAAAAAAAghZZGmZmZYGzMwMNTMAzsghwYWGgxgFAAYMzYMYGgZmRwA",
}
},
{
  {
  ["name"] = "Skill Capped Holy Priest",
  ["icon"] = 626004,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Oracle",
  ["icon"] = 237542,
  ["isInGroup"] = true,
  ["text"] = "CEQAAAAAAAAAAAAAAAAAAAAAAADAAAAAAwMzMsMzMmZAzwMbzMzMAAAAmZmlZwYMWMzMjZZxYmCgZ2wQYMbDwYgFzMzCgmhhxgBwMzMwHA",
  ["pvp1"] = 101,
  ["pvp2"] = 124,
  ["pvp3"] = 5569,
},
  {
  ["name"] = "Arena - Archon",
  ["icon"] = 237542,
  ["isInGroup"] = true,
  ["text"] = "CEQAAAAAAAAAAAAAAAAAAAAAAADAAAAAAYDzYWGzYmhhZYmtZmZGAAAAzMzyMYMGLmZmxssYMTBAmZzMZ2MAwYwmZmZBQzwwYwYZbAmBG",
  ["pvp1"] = 101,
  ["pvp2"] = 124,
  ["pvp3"] = 5569,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 237542,
  ["isInGroup"] = true,
  ["text"] = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAGmxsMzMzMzYYGmZbmxMAAAAmZmlZYGzMWMmZYZxYmCgZ2wQYMbDoxALMzAgZYYMYAMzMDMA",
  ["pvp1"] = 124,
  ["pvp2"] = 5569,
  ["pvp3"] = 101,
},
  {
  ["name"] = "M+",
  ["icon"] = 237542,
  ["isInGroup"] = true,
  ["text"] = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAgZzwMjBjZmZGzMzYbmZmBAAAwYsMDzMzMMjZGshZqBAmZzMZ2MAwYwmZGbAaGmxYwMbLDwAG",
},
  {
  ["name"] = "Raid",
  ["icon"] = 237542,
  ["isInGroup"] = true,
  ["text"] = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAgZzwMjBjZmZGzMzYbmZmBAAAwYsMDzMzMMjZGshZqBAmZzMZ2MAwYwmZGbAaGmxYwMbLDwAG",
}
},
{
  {
  ["name"] = "Skill Capped Shadow Priest",
  ["icon"] = 626004,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Voidweaver",
  ["icon"] = 136207,
  ["isInGroup"] = true,
  ["text"] = "CIQAAAAAAAAAAAAAAAAAAAAAAMDjBAAAAAAAAAAAADLzMGLzMmZ2mZYmx2MGzMzYhJDLLmGgZmZAgAMbz2CY2YAGzMyYmZGzyYGMzgZiB",
  ["pvp1"] = 5720,
  ["pvp2"] = 5568,
  ["pvp3"] = 763,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 136207,
  ["isInGroup"] = true,
  ["text"] = "CIQAAAAAAAAAAAAAAAAAAAAAAMDjBAAAAAAAAAAAADLzMGLzMmZ2mZYmx2MzYmZGLMZYZx0AMzMDAEgZb2EMbMAjZGMmZMmlxMYmBzgB",
  ["pvp1"] = 5568,
  ["pvp2"] = 763,
  ["pvp3"] = 106,
},
  {
  ["name"] = "M+",
  ["icon"] = 136207,
  ["isInGroup"] = true,
  ["text"] = "CIQAAAAAAAAAAAAAAAAAAAAAAMMjZGAAAAAAAAAAAgBLmxYZmhZWmZYG2mZGzMzYDZGLmpBYGgZWMjmNDAZMWAwMzAjZmZMbjZ2WGgZwA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 136207,
  ["isInGroup"] = true,
  ["text"] = "CIQAAAAAAAAAAAAAAAAAAAAAAMMjZGAAAAAAAAAAAgBLmxYZmhZWmZYG2mZGzMzYDZGLmpBYGgZWMjmNDAZMWAwMzAjZmZMbjZ2WGgZwA",
}
},
},
["EVOKER"] = {
{
  {
  ["name"] = "Skill Capped Dev Evoker",
  ["icon"] = 4574311,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena",
  ["icon"] = 4622452,
  ["isInGroup"] = true,
  ["text"] = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwMzMDMDzwMjZmxYYaMzMNjxywMzMzMzMzAmZGDmZbMDMAD2glxox2AyMIYDDMzAMA",
  ["pvp1"] = 5469,
  ["pvp2"] = 5460,
  ["pvp3"] = 5464,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 4622452,
  ["isInGroup"] = true,
  ["text"] = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMzgZYGmZMzMGDTjZmpZMWmxMzMzYmZGwMzYYmZZMDMAD2glxox2AyMIYDDMzghB",
  ["pvp1"] = 5460,
  ["pvp2"] = 5469,
  ["pvp3"] = 5462,
},
  {
  ["name"] = "M+",
  ["icon"] = 4622452,
  ["isInGroup"] = true,
  ["text"] = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDmZMzYmBGGjZaMzMZw2MzMzwYmZGwMzMGzMmZGMDMjZgFwSwMMhsBWGmBYmZYA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 4622452,
  ["isInGroup"] = true,
  ["text"] = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDmZMzYmBGGjZaMzMZw2MzMzwYmZGwMzMGzMmZGMDMjZgFwSwMMhsBWGmBYmZYA",
}
},
{
  {
  ["name"] = "Skill Capped Pres Evoker",
  ["icon"] = 4574311,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Flameshaper",
  ["icon"] = 4622476,
  ["isInGroup"] = true,
  ["text"] = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ22GYYmZYmxgtBAAwMMzMzYYmYmZAAAgtZmZaGjZmZbMDAMmBWALgZYCZjxmhBwMDfA",
  ["pvp1"] = 5718,
  ["pvp2"] = 5459,
  ["pvp3"] = 5468,
},
  {
  ["name"] = "Arena - Chronowarden",
  ["icon"] = 4622476,
  ["isInGroup"] = true,
  ["text"] = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ22GYYmZYmxgtZAAAmhZmZGDzEzMDAAAsNzMTzYMzMbjZAAYMjNWgBmRDNMjFYMzAwDA",
  ["pvp1"] = 5718,
  ["pvp2"] = 5459,
  ["pvp3"] = 5468,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 4622476,
  ["isInGroup"] = true,
  ["text"] = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ22GYYmZYGGsNMAAwMjZmxMDzEjZAAAgtZmZaGjZmZZMDAAjZsxCMwMaoBjFYMzAwA",
  ["pvp1"] = 5718,
  ["pvp2"] = 5470,
  ["pvp3"] = 5468,
},
  {
  ["name"] = "M+",
  ["icon"] = 4622476,
  ["isInGroup"] = true,
  ["text"] = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ22mHADzMmFzYw2AAAMzYGDjxMTmZmBAAAMzMTGmZMLzMDAMmZMjNWswwMzMN0sxYxwYmBGjB",
},
  {
  ["name"] = "Raid",
  ["icon"] = 4622476,
  ["isInGroup"] = true,
  ["text"] = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ22mHADzMmFzYw2AAAMzYGDjxMTmZmBAAAMzMTGmZMLzMDAMmZMjNWswwMzMN0sxYxwYmBGjB",
}
},
{
  {
  ["name"] = "Skill Capped Aug Evoker",
  ["icon"] = 4574311,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena",
  ["icon"] = 5199626,
  ["isInGroup"] = true,
  ["text"] = "CEcBAAAAAAAAAAAAAAAAAAAAAgZZmtZmZGbzwMzyMmZGDAAAAAAAAYmZYmxYYmhZmBAAAAzMjNmZWGzMwMGGsALjxM2GwYmhhNMG",
  ["pvp1"] = 5563,
  ["pvp2"] = 5560,
  ["pvp3"] = 5561,
},
  {
  ["name"] = "M+",
  ["icon"] = 5199626,
  ["isInGroup"] = true,
  ["text"] = "CEcBAAAAAAAAAAAAAAAAAAAAAMmZGbzMzghHYmZZGjhZ2AAAAAAAAYmBGGjpGzMzAAAAAzMjxMzyMzMwMbGDWglxwYZAMTEbYmZwMDGM",
},
  {
  ["name"] = "Raid",
  ["icon"] = 5199626,
  ["isInGroup"] = true,
  ["text"] = "CEcBAAAAAAAAAAAAAAAAAAAAAMmZGbzMzghHYmZZGjhZ2AAAAAAAAYmBGGjpGzMzAAAAAzMjxMzyMzMwMbGDWglxwYZAMTEbYmZwMDGM",
}
},
},
["HUNTER"] = {
{
  {
  ["name"] = "Skill Capped BM Hunter",
  ["icon"] = 626000,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Pack Leader",
  ["icon"] = 461112,
  ["isInGroup"] = true,
  ["text"] = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGz2YmFzwMmZY8AzMGmxMzwYmllZmHwMzMGGNDAAAAAYGAAAmhZGwMbILYmFwiB",
  ["pvp1"] = 3599,
  ["pvp2"] = 3604,
  ["pvp3"] = 5444,
},
  {
  ["name"] = "Arena - Dark Ranger",
  ["icon"] = 461112,
  ["isInGroup"] = true,
  ["text"] = "C0PAAAAAAAAAAAAAAAAAAAAAAYzsNwAGwMsBZsAAgZMbjZWMDzYmhxDMzYYGzMDjZWWmZeAzMzYY0MAAAAAgZAAAYGmZYmBILYmFwiB",
  ["pvp1"] = 3599,
  ["pvp2"] = 3604,
  ["pvp3"] = 5444,
},
  {
  ["name"] = "M+",
  ["icon"] = 461112,
  ["isInGroup"] = true,
  ["text"] = "C0PAAAAAAAAAAAAAAAAAAAAAAYzYGzMDLwCmZ2M0M2AAwMjlZmZxMMzMzwMmZMMDzMmZmx2MzYGzgx0MAAAAAgZAAAYMmZYmZmFEwsA2MA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 461112,
  ["isInGroup"] = true,
  ["text"] = "C0PAAAAAAAAAAAAAAAAAAAAAAYzYGzMDLwCmZ2M0M2AAwMjlZmZxMMzMzwMmZMMDzMmZmx2MzYGzgx0MAAAAAgZAAAYMmZYmZmFEwsA2MA",
}
},
{
  {
  ["name"] = "Skill Capped MM Hunter",
  ["icon"] = 626000,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Sentinel",
  ["icon"] = 236179,
  ["isInGroup"] = true,
  ["text"] = "C4PAAAAAAAAAAAAAAAAAAAAAAwCMwMGNWGAzgNAAAAAAAAgZYMzyyMegZmZGDjmxYmZ2W2MzMDzMsNjtxYWGmZAAAzwMDAzotFMDwywA",
  ["pvp1"] = 651,
  ["pvp2"] = 659,
  ["pvp3"] = 653,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 236179,
  ["isInGroup"] = true,
  ["text"] = "C4PAAAAAAAAAAAAAAAAAAAAAAwCMwMGNWGQmBbAAAAAAAAAzwYGLzYmZmZMMaGjZmZbZzMzMMzw2M2GjZZYGAAgZYmBgZGbLYGglhB",
  ["pvp1"] = 651,
  ["pvp2"] = 653,
  ["pvp3"] = 660,
},
  {
  ["name"] = "M+",
  ["icon"] = 236179,
  ["isInGroup"] = true,
  ["text"] = "C4PAAAAAAAAAAAAAAAAAAAAAAwCMwMGNWGQmBbAAAAAAAAAzYGzYbGzMjZwYaGjZmZZbzMzMMzgZmlxYWGmZAAAjxMAYmx2GmBYBD",
},
  {
  ["name"] = "Raid",
  ["icon"] = 236179,
  ["isInGroup"] = true,
  ["text"] = "C4PAAAAAAAAAAAAAAAAAAAAAAwCMwMGNWGQmBbAAAAAAAAAzYGzYbGzMjZwYaGjZmZZbzMzMMzgZmlxYWGmZAAAjxMAYmx2GmBYBD",
}
},
{
  {
  ["name"] = "Skill Capped Survival Hunter",
  ["icon"] = 626000,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Pack Leader",
  ["icon"] = 461113,
  ["isInGroup"] = true,
  ["text"] = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2IbwMM0gFzMzMGPwy8AAAAAAAMDjZWWmxwMGjZ0MAAAAgBAwyyMzsYmZGzwMDYmNwCmxYmZjB",
  ["pvp1"] = 3607,
  ["pvp2"] = 3609,
  ["pvp3"] = 664,
},
  {
  ["name"] = "Arena - Sentinel",
  ["icon"] = 461113,
  ["isInGroup"] = true,
  ["text"] = "C8PAAAAAAAAAAAAAAAAAAAAAAMWgBmxoxyAYmgNjZmx4BWmBAAAAAgZYMzyyMGmxYMjmBAAAAMAAW2mZegFzMzMzwMDAzwyCmxYmZjB",
  ["pvp1"] = 3607,
  ["pvp2"] = 3609,
  ["pvp3"] = 664,
},
  {
  ["name"] = "M+",
  ["icon"] = 461113,
  ["isInGroup"] = true,
  ["text"] = "C8PAAAAAAAAAAAAAAAAAAAAAAMWwMzYmZb0ssMMDzMNYzMzMjhl5BAAAAAAYGzMzwMGzYGMmmBAAAAMAAW2mZmFzMzMjxMDYmtZYbDGjZmNG",
},
  {
  ["name"] = "Raid",
  ["icon"] = 461113,
  ["isInGroup"] = true,
  ["text"] = "C8PAAAAAAAAAAAAAAAAAAAAAAMWwMzYmZb0ssMMDzMNYzMzMjhl5BAAAAAAYGzMzwMGzYGMmmBAAAAMAAW2mZmFzMzMjxMDYmtZYbDGjZmNG",
}
},
},
["WARLOCK"] = {
{
  {
  ["name"] = "Skill Capped Affli Warlock",
  ["icon"] = 626007,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Soul Harvester",
  ["icon"] = 136145,
  ["isInGroup"] = true,
  ["text"] = "CkQAy0jxIDofkwJmoH7WhvESotMGPwMjmtZGLMzMLDAAYmZWsYmZxMAwsssMGGziZaMzMskZjhtBAAgZAAgZmZmZmZmZMjBzMzMzMYGGAgBMA",
  ["pvp1"] = 5386,
  ["pvp2"] = 16,
  ["pvp3"] = 5579,
},
  {
  ["name"] = "M+",
  ["icon"] = 136145,
  ["isInGroup"] = true,
  ["text"] = "CkQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjxmZGzyAAAmZmFbzMzyYAgZZZZMMGmphZG2ysww2AAAgBAAMzMzYGzMbzMmBzMzMGmZmBAYGYA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 136145,
  ["isInGroup"] = true,
  ["text"] = "CkQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjxmZGzyAAAmZmFbzMzyYAgZZZZMMGmphZG2ysww2AAAgBAAMzMzYGzMbzMmBzMzMGmZmBAYGYA",
}
},
{
  {
  ["name"] = "Skill Capped Demo Warlock",
  ["icon"] = 626007,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Soul Harvester",
  ["icon"] = 136172,
  ["isInGroup"] = true,
  ["text"] = "CoQAAAAAAAAAAAAAAAAAAAAAAsMGzMjmtZGLMzMLDAAAAAAwYZZgBMgZYLkxmZGjtxMmZMAgZmZMDwMjZmZmBAAYMDjxMsNzAMA",
  ["pvp1"] = 5606,
  ["pvp2"] = 5577,
  ["pvp3"] = 3624,
},
  {
  ["name"] = "Arena - Diabolist",
  ["icon"] = 136172,
  ["isInGroup"] = true,
  ["text"] = "CoQAAAAAAAAAAAAAAAAAAAAAAsMGzMjmtZGLMzMLDAAAAAAAYMjhFYglRL0wixYsNLzMzwAAzMmZmZmBwMzMzAAAMmhxYG2mxAGA",
  ["pvp1"] = 5606,
  ["pvp2"] = 5577,
  ["pvp3"] = 3624,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 136172,
  ["isInGroup"] = true,
  ["text"] = "CoQAAAAAAAAAAAAAAAAAAAAAAsMGPwMjmtZGLMzMLDAAAAAAwYZZgBMgZYLkxmZmZsNmZmZMAgZmZmZAmZmZGzMAAAjZMjxMjtZGAA",
  ["pvp1"] = 162,
  ["pvp2"] = 3624,
  ["pvp3"] = 5606,
},
  {
  ["name"] = "M+",
  ["icon"] = 136172,
  ["isInGroup"] = true,
  ["text"] = "CoQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmZ2MzYWGAAAAAAgx2yADYAzwWIjNjZGLjZMPwMDAMzMDzAMzMmxMzGAAYMzMmxgtZmBMA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 136172,
  ["isInGroup"] = true,
  ["text"] = "CoQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmZ2MzYWGAAAAAAgx2yADYAzwWIjNjZGLjZMPwMDAMzMDzAMzMmxMzGAAYMzMmxgtZmBMA",
}
},
{
  {
  ["name"] = "Skill Capped Destro Warlock",
  ["icon"] = 626007,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Hellcaller",
  ["icon"] = 136186,
  ["isInGroup"] = true,
  ["text"] = "CsQAy0jxIDofkwJmoH7WhvESotMm5BmZ0sMzYjZmZZWYGzyMmtFzAAgZmxMzsYBGYWMaMDgZL2YAAgBwsBAMzAzMzYAAAYGmBAgZYA",
  ["pvp1"] = 157,
  ["pvp2"] = 5580,
  ["pvp3"] = 3508,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 136186,
  ["isInGroup"] = true,
  ["text"] = "CsQAAAAAAAAAAAAAAAAAAAAAAsMGmZ0sNzYbmZmZZWwY2mxssYGAAMmxMzsYBGYWMaMDgZL2YAAgBYmNAgZGMzMGDAAAzYGAAmZYA",
  ["pvp1"] = 3508,
  ["pvp2"] = 157,
  ["pvp3"] = 5382,
},
  {
  ["name"] = "M+",
  ["icon"] = 136186,
  ["isInGroup"] = true,
  ["text"] = "CsQAAAAAAAAAAAAAAAAAAAAAAwMzDMzoZxM2MzYWmNGzsMzMLLmBAAjZMzMLWwMzYmllRzMDbDLzWjFGAAYAjBAmZmZwYGzMbAAAmZmBAAzwA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 136186,
  ["isInGroup"] = true,
  ["text"] = "CsQAAAAAAAAAAAAAAAAAAAAAAwMzDMzoZxM2MzYWmNGzsMzMLLmBAAjZMzMLWwMzYmllRzMDbDLzWjFGAAYAjBAmZmZwYGzMbAAAmZmBAAzwA",
}
},
},
["DEMONHUNTER"] = {
{
  {
  ["name"] = "Skill Capped Havoc DH",
  ["icon"] = 1260827,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Aldrachi Reaver",
  ["icon"] = 1247264,
  ["isInGroup"] = true,
  ["text"] = "CEkAAAAAAAAAAAAAAAAAAAAAAwMjZmZWmxMzMzYmMMAAAAAAAzixYmxMzsNzMYbGzsMYGbzsMDGGbbMJzMzYGLAAAAAAAgZGgBAAAgB",
  ["pvp1"] = 813,
  ["pvp2"] = 5433,
  ["pvp3"] = 812,
},
  {
  ["name"] = "Arena - Fel-Scarred",
  ["icon"] = 1247264,
  ["isInGroup"] = true,
  ["text"] = "CEkAAAAAAAAAAAAAAAAAAAAAAwMjZmZWmxMzMzYmMMAAAAAAAzixYmxMzsNzMYbGzsMYGbDsMLmxwsopxMzYGbAAAAAAAAMzgBAAAgB",
  ["pvp1"] = 813,
  ["pvp2"] = 5433,
  ["pvp3"] = 812,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 1247264,
  ["isInGroup"] = true,
  ["text"] = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZMzMDjZmZMzMZMzAAAAAAAmFjxMjZmZbmZw2MGbDmx2AbziZMMLaaMzMmxGAAAAAAAAzMYAAAAYA",
  ["pvp1"] = 813,
  ["pvp2"] = 806,
  ["pvp3"] = 5433,
},
  {
  ["name"] = "M+",
  ["icon"] = 1247264,
  ["isInGroup"] = true,
  ["text"] = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZ2MmZmxMzkxMDAAAAAAYWegxsNDzMz2YGbz2YGGDjlBWmNzYY200YmZMsBAAAAAgAgZGMAEAAYA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 1247264,
  ["isInGroup"] = true,
  ["text"] = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZ2MmZmxMzkxMDAAAAAAYWegxsNDzMz2YGbz2YGGDjlBWmNzYY200YmZMsBAAAAAgAgZGMAEAAYA",
}
},
{
  {
  ["name"] = "Skill Capped Vengeance DH",
  ["icon"] = 1260827,
  ["isExpanded"] = true,
},
  {
  ["name"] = "M+",
  ["icon"] = 1247265,
  ["isInGroup"] = true,
  ["text"] = "CUkAAAAAAAAAAAAAAAAAAAAAAAAWmxMzMGmRmZGMLmxMYmxMjZMzMjhZ2mZsZmZbMMAAAAAAACYGzsBAAAgBmZmZmt2mZmBAGAAAAD",
},
  {
  ["name"] = "Raid",
  ["icon"] = 1247265,
  ["isInGroup"] = true,
  ["text"] = "CUkAAAAAAAAAAAAAAAAAAAAAAAAWmxMzMGmRmZGMLmxMYmxMjZMzMjhZ2mZsZmZbMMAAAAAAACYGzsBAAAgBmZmZmt2mZmBAGAAAAD",
}
},
{
  {
  ["name"] = "Skill Capped Devourer DH",
  ["icon"] = 1260827,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Annihilator",
  ["icon"] = 1247264,
  ["isInGroup"] = true,
  ["text"] = "CgcBG5bbocFKcv%2ByIq8fPd6ORBAWmZmZmZmZmxwAAAAAAAYxYMYGAAAAAAAAmxMMzMzMzMzMDzsYGjFtsxMzMzWbzMzAYGzMjxMNLjFDDjZA",
  ["pvp1"] = 5729,
  ["pvp2"] = 5735,
  ["pvp3"] = 5734,
},
  {
  ["name"] = "Arena - Void-Scarred",
  ["icon"] = 1247264,
  ["isInGroup"] = true,
  ["text"] = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWMmZmxMzMGzMAAAAAAALGjhZGAAAAAAAAmxMMjZmZMzMzMzsNzgNtsAAADwMmZmlZmpZZmlZGmxMA",
  ["pvp1"] = 5729,
  ["pvp2"] = 5735,
  ["pvp3"] = 5734,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 1247264,
  ["isInGroup"] = true,
  ["text"] = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWmxMzMmZmxwMAAAAAAALGz2gZAAAAAAAAYGzwYmZmZmZmxMziZMW0yGzMzMbtNzMDgZMAEwYGGzA",
  ["pvp1"] = 5735,
  ["pvp2"] = 5728,
  ["pvp3"] = 5729,
}
},
},
["ROGUE"] = {
{
  {
  ["name"] = "Skill Capped Assa Rogue",
  ["icon"] = 626005,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena",
  ["icon"] = 236270,
  ["isInGroup"] = true,
  ["text"] = "CMQAAAAAAAAAAAAAAAAAAAAAAMPwMjZzMAAAAAAmtZMbzAAAAAAaZZYwMjxMzMz2MLzMGzMzMYGzwYYgBWgZMaMLgsNgtZstBMzMGD",
  ["pvp1"] = 830,
  ["pvp2"] = 5697,
  ["pvp3"] = 3480,
},
  {
  ["name"] = "M+",
  ["icon"] = 236270,
  ["isInGroup"] = true,
  ["text"] = "CMQAAAAAAAAAAAAAAAAAAAAAAYmZMLGMAAAAAwsMYbGAAAAAQbbzMzMzMjxMzMzyMbzMGzMzMGDzMGDwmZZgBsEsMMBGWMYmBgxA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 236270,
  ["isInGroup"] = true,
  ["text"] = "CMQAAAAAAAAAAAAAAAAAAAAAAYmZMLGMAAAAAwsMYbGAAAAAQbbzMzMzMjxMzMzyMbzMGzMzMGDzMGDwmZZgBsEsMMBGWMYmBgxA",
}
},
{
  {
  ["name"] = "Skill Capped Outlaw Rogue",
  ["icon"] = 626005,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena",
  ["icon"] = 236286,
  ["isInGroup"] = true,
  ["text"] = "CQQAAAAAAAAAAAAAAAAAAAAAAAAMz2MzMjZMDzYYGGMjZmxMzYbGzyMAAAAAAYZZMDmZmZDWGDAAAAzMzADsBzYMjZDM2mBLGA",
  ["pvp1"] = 5699,
  ["pvp2"] = 3421,
  ["pvp3"] = 3483,
},
  {
  ["name"] = "M+",
  ["icon"] = 236286,
  ["isInGroup"] = true,
  ["text"] = "CQQAAAAAAAAAAAAAAAAAAAAAAAgBjxMzYmxMzMjZegZ24BmZGTLD2mBAAAAAMbbzMzMzMzMzYmZ2GAAAAGADsBzY0Y2AsNhFGAMzwwA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 236286,
  ["isInGroup"] = true,
  ["text"] = "CQQAAAAAAAAAAAAAAAAAAAAAAAgBjxMzYmxMzMjZegZ24BmZGTLD2mBAAAAAMbbzMzMzMzMzYmZ2GAAAAGADsBzY0Y2AsNhFGAMzwwA",
}
},
{
  {
  ["name"] = "Skill Capped Sub Rogue",
  ["icon"] = 626005,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Trickster",
  ["icon"] = 236279,
  ["isInGroup"] = true,
  ["text"] = "CUQAAAAAAAAAAAAAAAAAAAAAAAgZ2mBAAAAAmtZmZZiZZbmxMjZgZmZmlxsNmZmllhBzMGwMGAAAAzgBwY2MMwAzmWoFbMzAmZwMzA",
  ["pvp1"] = 5406,
  ["pvp2"] = 5698,
  ["pvp3"] = 1209,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 236279,
  ["isInGroup"] = true,
  ["text"] = "CUQAAAAAAAAAAAAAAAAAAAAAAAgZ2mBAAAAAmtZmZZiZZbmxMjZgZmZmlxsNmZmllxMYmxAmxAAAAYGMAGzmhBGY20CtYjZGwMDmxA",
  ["pvp1"] = 1209,
  ["pvp2"] = 5698,
  ["pvp3"] = 5406,
},
  {
  ["name"] = "M+",
  ["icon"] = 236279,
  ["isInGroup"] = true,
  ["text"] = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGbTMbLjxMjZMMzMzYMbzYmZbbMjZmZMYMz2AAAAwgxsZWGYALglhJkZBzwMDwMzA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 236279,
  ["isInGroup"] = true,
  ["text"] = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGbTMbLjxMjZMMzMzYMbzYmZbbMjZmZMYMz2AAAAwgxsZWGYALglhJkZBzwMDwMzA",
}
},
},
["DRUID"] = {
{
  {
  ["name"] = "Skill Capped Balance Druid",
  ["icon"] = 625999,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Elune's Chosen",
  ["icon"] = 136096,
  ["isInGroup"] = true,
  ["text"] = "CYGA8cL7tpvige%2BkkmGM9zUPWDAAAAAAAAAAAAAAAAWoMLNjxMD8AmNzMzMbAegZZmlZYmZswyMLzMzgNMAYstNzssNz2sNTzMLzEAAAgFzMzYw2yYGjBgZGMzglB",
  ["pvp1"] = 185,
  ["pvp2"] = 5407,
  ["pvp3"] = 5383,
},
  {
  ["name"] = "Arena - Keeper of the Grove",
  ["icon"] = 136096,
  ["isInGroup"] = true,
  ["text"] = "CYGA8cL7tpvige%2BkkmGM9zUPWDAAAAAAAAAAAAAAAAWoMLNjxMDMmNmZmZjxwMLjlZMjZGjFzyMzMMbYAwAstN2w0MzyIAAAAbmZmxgNYMmBwMDA8BA",
  ["pvp1"] = 185,
  ["pvp2"] = 5407,
  ["pvp3"] = 5383,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 136096,
  ["isInGroup"] = true,
  ["text"] = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWGlZpZMmZAmtZmZmZDgZZmlxyMzMDWmZZmZmhNMAYA22GbYamZZEAAAgNzMzYwmxMGDAzMAwA",
  ["pvp1"] = 185,
  ["pvp2"] = 3058,
  ["pvp3"] = 5407,
},
  {
  ["name"] = "M+",
  ["icon"] = 136096,
  ["isInGroup"] = true,
  ["text"] = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsNmZmBDzYMzyMLmZmZbsMzyYmBLYYAGLbzMLbzsNbz0MzyMBAAAYhZmZGsZMjxAwMDmZgB",
},
  {
  ["name"] = "Raid",
  ["icon"] = 136096,
  ["isInGroup"] = true,
  ["text"] = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsNmZmBDzYMzyMLmZmZbsMzyYmBLYYAGLbzMLbzsNbz0MzyMBAAAYhZmZGsZMjxAwMDmZgB",
}
},
{
  {
  ["name"] = "Skill Capped Feral Druid",
  ["icon"] = 625999,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena",
  ["icon"] = 132115,
  ["isInGroup"] = true,
  ["text"] = "CcGA8cL7tpvige%2BkkmGM9zUPWDAAAAAwYMDmZmZmxstMWmZZGz4BmZAAAAYJY2MwMzUzY2MzMzsNmhBAAAAAwADAAAgmZZ2mZmZWmZpZbmlNYmZAWYwAAYmBzshB",
  ["pvp1"] = 620,
  ["pvp2"] = 5384,
  ["pvp3"] = 5647,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 132115,
  ["isInGroup"] = true,
  ["text"] = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAjZwMzMzMmtFWmZZGzMzMDAAAALBzmBmZmaGzmZmZmlxMjBAAAAAAYAAAAEAMbzs0sNzyGYmBYhBDAgZGAMA",
  ["pvp1"] = 620,
  ["pvp2"] = 5647,
  ["pvp3"] = 3053,
},
  {
  ["name"] = "M+",
  ["icon"] = 132115,
  ["isInGroup"] = true,
  ["text"] = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZ2YmZmxY2MPw2YbmZmxMDAAAALBzmhHwMjaGziZmZmlxMGAAAAAAGAAAAgmZb2mZmZ2mZrZZmlNYmZAWYwAAYmBAD",
},
  {
  ["name"] = "Raid",
  ["icon"] = 132115,
  ["isInGroup"] = true,
  ["text"] = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZ2YmZmxY2MPw2YbmZmxMDAAAALBzmhHwMjaGziZmZmlxMGAAAAAAGAAAAgmZb2mZmZ2mZrZZmlNYmZAWYwAAYmBAD",
}
},
{
  {
  ["name"] = "Skill Capped Guardian Druid",
  ["icon"] = 625999,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 132276,
  ["isInGroup"] = true,
  ["text"] = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZsYmZmZWmZhZMWGYWMjRTkZmtxMzMLjZGAAAAAAYxAW2mZwYWGATBAAA2wMDwmBGMWYDwMDgB",
  ["pvp1"] = 51,
  ["pvp2"] = 52,
  ["pvp3"] = 196,
},
  {
  ["name"] = "M+",
  ["icon"] = 132276,
  ["isInGroup"] = true,
  ["text"] = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmxsMMjZWMLzMzMWGY2MMaimZmlZmZmZZMDAAAAAAzYZGwy2MDGzyAYqZWmlZmZAAsYMzDAsYGMgFMAzMzsAfA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 132276,
  ["isInGroup"] = true,
  ["text"] = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmxsMMjZWMLzMzMWGY2MMaimZmlZmZmZZMDAAAAAAzYZGwy2MDGzyAYqZWmlZmZAAsYMzDAsYGMgFMAzMzsAfA",
}
},
{
  {
  ["name"] = "Skill Capped Resto Druid",
  ["icon"] = 625999,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena",
  ["icon"] = 136041,
  ["isInGroup"] = true,
  ["text"] = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmBzYmZMLjZGjZjZz2MAAAAAAAAAAYZGa2MjpxMDMbmZmZWMYAAAAAYAAjBstNWw0MzyAAAEwCjZmhZsAaGAMzAAGA",
  ["pvp1"] = 1215,
  ["pvp2"] = 5668,
  ["pvp3"] = 5687,
},
  {
  ["name"] = "M+",
  ["icon"] = 136041,
  ["isInGroup"] = true,
  ["text"] = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsNMMmlxsYZGAAAAAAAAAAsMoZzMmmhZMmFzMzMLzgZAAAAAAAwA22GbYamZZAAMbzs1sNziNmZGwMLgmBAzMzMAMA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 136041,
  ["isInGroup"] = true,
  ["text"] = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsNMMmlxsYZGAAAAAAAAAAsMoZzMmmhZMmFzMzMLzgZAAAAAAAwA22GbYamZZAAMbzs1sNziNmZGwMLgmBAzMzMAMA",
}
},
},
["MONK"] = {
{
  {
  ["name"] = "Skill Capped Brewmaster Monk",
  ["icon"] = 626002,
  ["isExpanded"] = true,
},
  {
  ["name"] = "M+",
  ["icon"] = 608951,
  ["isInGroup"] = true,
  ["text"] = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGzwyM2wMjBAAAAAAYZBEzMwMM2MDmZmZY2YmxMLDLbz22sNMLAAwysMtMbzsMAAz2s0MzMLMswwMzMDTjBAAMA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 608951,
  ["isInGroup"] = true,
  ["text"] = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGzwyM2wMjBAAAAAAYZBEzMwMM2MDmZmZY2YmxMLDLbz22sNMLAAwysMtMbzsMAAz2s0MzMLMswwMzMDTjBAAMA",
}
},
{
  {
  ["name"] = "Skill Capped Mistweaver Monk",
  ["icon"] = 626002,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Hybrid",
  ["icon"] = 608952,
  ["isInGroup"] = true,
  ["text"] = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgxMzyYZMbWMmZshtttZMDzsZbmxGzohZsgBDY2mZmZY2mFwsNTAAAAgZZab2mZZ2AAAAAGfwMDAMGMkBA",
  ["pvp1"] = 5395,
  ["pvp2"] = 70,
  ["pvp3"] = 5603,
},
  {
  ["name"] = "Arena - Caster",
  ["icon"] = 608952,
  ["isInGroup"] = true,
  ["text"] = "C4QAi6cZM%2BHWADeySjzG9Lwx8DAAAAAAAgxMzyYZYxixMjFsstNjZWMzitZGbMjGmZWwgBMbzMzMMbzCY2GBAAAAmlplZZmlZxyMLzyMDIAAGfwMDmBMgxkxMA",
  ["pvp1"] = 5395,
  ["pvp2"] = 70,
  ["pvp3"] = 5603,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 608952,
  ["isInGroup"] = true,
  ["text"] = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgxMzyYZMbWMmZsZmltlZMzmZ2sNzYjZ0MmBMYAz2MzMDz2AMbzEAAAAABYx2MLzyMTAAYwAwMgxALyYGA",
  ["pvp1"] = 5395,
  ["pvp2"] = 5642,
  ["pvp3"] = 1928,
},
  {
  ["name"] = "M+",
  ["icon"] = 608952,
  ["isInGroup"] = true,
  ["text"] = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgxwyMLjZZZbGzMWgllZYwstsMzYhZmmxMgBDwyMzMDzGmBLzEAAAAABYx2ssNLzMAAwgxAMDYAWkxMA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 608952,
  ["isInGroup"] = true,
  ["text"] = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgxwyMLjZZZbGzMWgllZYwstsMzYhZmmxMgBDwyMzMDzGmBLzEAAAAABYx2ssNLzMAAwgxAMDYAWkxMA",
}
},
{
  {
  ["name"] = "Skill Capped Windwalker Monk",
  ["icon"] = 626002,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Shado-Pan",
  ["icon"] = 608953,
  ["isInGroup"] = true,
  ["text"] = "C0QAAAAAAAAAAAAAAAAAAAAAAMzMjBMYbmZ2mBAAAAAAAAAAAYbYEmZ2GGAmxMjZGz2swwsMTAAbmZZmhZmZGAAbAwsNLNzMzCwwAzMAwCjJGwHA",
  ["pvp1"] = 5643,
  ["pvp2"] = 3745,
  ["pvp3"] = 3052,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 608953,
  ["isInGroup"] = true,
  ["text"] = "C0QAAAAAAAAAAAAAAAAAAAAAAMzMjBMYbmZ2mBAAAAAAAAAAAYZYEmZ2wAGmxMzMDz2swwsMTAAbmZZmhxMzAAYDANbzSzMzsAMMwMDAsMGwAG",
  ["pvp1"] = 3745,
  ["pvp2"] = 3052,
  ["pvp3"] = 77,
},
  {
  ["name"] = "M+",
  ["icon"] = 608953,
  ["isInGroup"] = true,
  ["text"] = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMghZZmZ2mxAAAAAAAAAAAALDzEmxywAmxwMzMDz2wMMLzEAwmZ2GDjZmBAwGAaWmlmZmZBYYgZGAYhBMgB",
},
  {
  ["name"] = "Raid",
  ["icon"] = 608953,
  ["isInGroup"] = true,
  ["text"] = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMghZZmZ2mxAAAAAAAAAAAALDzEmxywAmxwMzMDz2wMMLzEAwmZ2GDjZmBAwGAaWmlmZmZBYYgZGAYhBMgB",
}
},
},
["SHAMAN"] = {
{
  {
  ["name"] = "Skill Capped Ele Shaman",
  ["icon"] = 626006,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Farseer",
  ["icon"] = 136048,
  ["isInGroup"] = true,
  ["text"] = "CYQARUG2fGwHkLP0T7%2FMoTNl%2FAAAAAzMLbzMGMLLLMmhZAAAAALmZbxMzwmhFmtZmGamFAY2GzMmZbx0CzMGLGzMmZ2mNzsMDmZ2GAYmBYmZmxwMG",
  ["pvp1"] = 5660,
  ["pvp2"] = 5574,
  ["pvp3"] = 3620,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 136048,
  ["isInGroup"] = true,
  ["text"] = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMLLzMGjZZZhxMMDAAAAYxMbwAGwsxEysAAz2MzMmZbxEmZMWMmZMzsNbMLzgZmlBAmZMAmZgZMA",
  ["pvp1"] = 727,
  ["pvp2"] = 5574,
  ["pvp3"] = 3488,
},
  {
  ["name"] = "M+",
  ["icon"] = 136048,
  ["isInGroup"] = true,
  ["text"] = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMzYML2mhZMzAAAAA2Mz2mZmhNDLMbzMN0MbAwsMzMjx2iJMzsNWmZmZMsMLzYxMzYmFAgBwMzMjhhB",
},
  {
  ["name"] = "Raid",
  ["icon"] = 136048,
  ["isInGroup"] = true,
  ["text"] = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMzYML2mhZMzAAAAA2Mz2mZmhNDLMbzMN0MbAwsMzMjx2iJMzsNWmZmZMsMLzYxMzYmFAgBwMzMjhhB",
}
},
{
  {
  ["name"] = "Skill Capped Enh Shaman",
  ["icon"] = 626006,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena - Totemic",
  ["icon"] = 237581,
  ["isInGroup"] = true,
  ["text"] = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMjZGmZmZmZmZGzAAAAAAAAAALwCMjFN2GAzEsBwsNYMz2yMWGzMbjFjZGmZbMDAwMMjZMzEzMADGfA",
  ["pvp1"] = 722,
  ["pvp2"] = 5722,
  ["pvp3"] = 3622,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 237581,
  ["isInGroup"] = true,
  ["text"] = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMjZGmZmZmZmZGzAAAAAAAAAALwCMjFN2GAzEsBwsNDjx2yMWYmZjFzMzwMbjZAAmhZMjZmYmBYwYA",
  ["pvp1"] = 722,
  ["pvp2"] = 3622,
  ["pvp3"] = 5438,
},
  {
  ["name"] = "M+",
  ["icon"] = 237581,
  ["isInGroup"] = true,
  ["text"] = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzYMzMzMzMMzYAAAAAAAAAshNstNjZmtFNLbDzwMTDWAYWmxMGLLzAzMGLzMzMjhxMAAzwYmhZiZmZGMYMA",
},
  {
  ["name"] = "Raid",
  ["icon"] = 237581,
  ["isInGroup"] = true,
  ["text"] = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzYMzMzMzMMzYAAAAAAAAAshNstNjZmtFNLbDzwMTDWAYWmxMGLLzAzMGLzMzMjhxMAAzwYmhZiZmZGMYMA",
}
},
{
  {
  ["name"] = "Skill Capped Resto Shaman",
  ["icon"] = 626006,
  ["isExpanded"] = true,
},
  {
  ["name"] = "Arena",
  ["icon"] = 136052,
  ["isInGroup"] = true,
  ["text"] = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZM2WmxMjZmZmZmxwCsBzYRjtBkZgNmZGMbjZGNLLmZxMGsYMz8AzMbzGAAAwMDmZAYmBD",
  ["pvp1"] = 5723,
  ["pvp2"] = 3755,
  ["pvp3"] = 715,
},
  {
  ["name"] = "Blitz",
  ["icon"] = 136052,
  ["isInGroup"] = true,
  ["text"] = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZM2WmxMjZmZmZmxwCsBzYRjtBkZgNmZGMbjZGNWmZWMjBLGzMmZ2mNDAAAMzgZGAmZwA",
  ["pvp1"] = 5567,
  ["pvp2"] = 715,
  ["pvp3"] = 3755,
},
  {
  ["name"] = "M+",
  ["icon"] = 136052,
  ["isInGroup"] = true,
  ["text"] = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZmZbZZMzMzMzMzYYstMziNGzYZasNzCTmhxGmZwsNzMjmllZGmxglZMzYYZWmBAgBwMDmZAgBD",
},
  {
  ["name"] = "Raid",
  ["icon"] = 136052,
  ["isInGroup"] = true,
  ["text"] = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZmZbZZMzMzMzMzYYstMziNGzYZasNzCTmhxGmZwsNzMjmllZGmxglZMzYYZWmBAgBwMDmZAgBD",
}
},
},
}

function SC:TalentLoadoutsEx(contentType)
    local baseBackupKey = "TalentLoadoutsEx"
    local taggedBackupKey = baseBackupKey .. contentType

    -- Perform backup if it doesn't exist yet
    if not SkillCappedBackupDB[baseBackupKey] then
        -- Main backup for TalentLoadoutsEx
        SkillCappedBackupDB[baseBackupKey] = SC:DeepCopy(TalentLoadoutEx)
        SkillCappedBackupDB.addonBackupTimes["TalentLoadoutsEx"] = SC:GetDateAndTime()
    end

    -- Set tags for PvP and PvE without creating a new backup
    if not SkillCappedBackupDB[taggedBackupKey] then
        SkillCappedBackupDB[taggedBackupKey] = true
    end

    -- Apply the custom SkillCapped profile to TalentLoadoutsEx
    TalentLoadoutEx = scTalentLoadoutEx
    -- local profileName = (SkillCappedDB.mainContent == "PvP" and "SkillCapped") or (SkillCappedDB.mainContent == "PvE" and "SkillCapped")

    -- -- Update profile keys for all saved characters
    -- for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
    --     TalentLoadoutEx.profileKeys[savedPlayerNameAndRealm] = profileName
    -- end
end

function UpdateTalentLoadoutEx()
    if not TalentLoadoutEx then return end
    -- Loop through all classes in scTalentLoadoutEx
    for class, specs in pairs(scTalentLoadoutEx) do
        if class ~= "Option" then -- Skip the "Option" entry
            -- Loop through all specs for the class
            for specID, entries in pairs(specs) do

                -- Ensure TalentLoadoutEx[class][specID] exists
                TalentLoadoutEx[class] = TalentLoadoutEx[class] or {}
                TalentLoadoutEx[class][specID] = TalentLoadoutEx[class][specID] or {}

                local specData = TalentLoadoutEx[class][specID]

                -- Collect names of groups and talent configs in scTalentLoadoutEx
                local entryNames = {}
                for _, entry in ipairs(entries) do
                    entryNames[entry.name] = true
                end

                -- Remove existing groups and talent configs matching scTalentLoadoutEx names
                for i = #specData, 1, -1 do
                    local existingEntry = specData[i]
                    if entryNames[existingEntry.name] then
                        table.remove(specData, i) -- Remove duplicate or outdated entry
                    end
                end

                -- Re-add entries from scTalentLoadoutEx, ensuring correct order
                for _, entry in ipairs(entries) do
                    table.insert(specData, entry) -- Add the entry in order
                end
            end
        end
    end
    SkillCappedDB.newTalentsImported = true
end

function SC:NewTalentLoadouts()
    if not TalentLoadoutEx then return false end -- If the global table doesn't exist, consider no updates needed

    -- if not SkillCappedDB.enabledAddons["TalentLoadoutsExPvP"] and not SkillCappedDB.enabledAddons["TalentLoadoutsExPvE"] then
    --     return false
    -- end

    if not SkillCappedBackupDB["TalentLoadoutsEx"] then
        return false
    end

    if not SkillCappedDB.WeakAura then return false end

    -- Loop through all classes in scTalentLoadoutEx
    for class, specs in pairs(scTalentLoadoutEx) do
        if class ~= "Option" then -- Skip the "Option" entry
            -- Loop through all specs for the class
            for specID, entries in pairs(specs) do
                -- Ensure TalentLoadoutEx[class][specID] exists
                if not TalentLoadoutEx[class] or not TalentLoadoutEx[class][specID] then
                    return true -- Missing a class or spec entirely
                end

                local specData = TalentLoadoutEx[class][specID]

                -- Collect existing entries by name for comparison
                local existingEntries = {}
                for _, existingEntry in ipairs(specData) do
                    existingEntries[existingEntry.name] = existingEntry
                end

                -- Check if any of our entries are missing or mismatched
                for _, entry in ipairs(entries) do
                    local existingEntry = existingEntries[entry.name]

                    -- Missing entry
                    if not existingEntry then
                        return true
                    end

                    -- Mismatched text
                    if entry.text and existingEntry.text and entry.text ~= existingEntry.text then
                        return true
                    end

                    -- Mismatched PvP values
                    for _, pvpKey in ipairs({"pvp1", "pvp2", "pvp3"}) do
                        if entry[pvpKey] and existingEntry[pvpKey] and entry[pvpKey] ~= existingEntry[pvpKey] then
                            return true
                        end
                    end
                end
            end
        end
    end

    return false -- No updates needed
end