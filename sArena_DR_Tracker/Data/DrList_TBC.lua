-- TBC DR Categories and Spell List
-- Note: This is a placeholder. Full TBC DR list needs to be added from sArena_Reloaded/Data/DRs/DrList_TBC.lua

DRTrackerMixin.drCategories = {
	"Incapacitate",
	"Disorient",
	"Stun",
	"RandomStun",
	"Fear",
	"Root",
	"RandomRoot",
	"MindControl",
	"Disarm",
	"Scatter",
	"Counterattack",
	"Chastise",
	"KidneyShot",
	"UnstableAffliction",
	"DeathCoil",
}

DRTrackerMixin.defaultSettings.profile.drCategories = {
	["Incapacitate"] = true,
	["Disorient"] = true,
	["Stun"] = true,
	["RandomStun"] = true,
	["Fear"] = true,
	["Root"] = true,
	["RandomRoot"] = true,
	["MindControl"] = true,
	["Disarm"] = true,
	["Scatter"] = true,
	["Counterattack"] = false,
	["Chastise"] = false,
	["KidneyShot"] = true,
	["UnstableAffliction"] = false,
	["DeathCoil"] = false,
}

DRTrackerMixin.defaultSettings.profile.drIcons = {
	["Incapacitate"] = 136071,
	["Disorient"] = 134153,
	["Stun"] = 132092,
	["RandomStun"] = 133477,
	["Fear"] = 136183,
	["Root"] = 135848,
	["RandomRoot"] = 135852,
	["MindControl"] = 136206,
	["Disarm"] = 132343,
	["Scatter"] = 132153,
	["Counterattack"] = 132336,
	["Chastise"] = 135886,
	["KidneyShot"] = 132298,
	["UnstableAffliction"] = 136228,
	["DeathCoil"] = 136145,
}

-- Placeholder DR list - copy full list from sArena_Reloaded/Data/DRs/DrList_TBC.lua
DRTrackerMixin.drList = {
	-- *** Incapacitate Effects ***
	[2637]  = "Incapacitate",     -- Hibernate (Rank 1)
	[18657] = "Incapacitate",     -- Hibernate (Rank 2)
	[18658] = "Incapacitate",     -- Hibernate (Rank 3)
	[22570] = "Incapacitate",     -- Maim
	[3355]  = "Incapacitate",     -- Freezing Trap Effect (Rank 1)
	[14308] = "Incapacitate",     -- Freezing Trap Effect (Rank 2)
	[14309] = "Incapacitate",     -- Freezing Trap Effect (Rank 3)
	[118]   = "Incapacitate",     -- Polymorph (Rank 1)
	[12824] = "Incapacitate",     -- Polymorph (Rank 2)
	[12825] = "Incapacitate",     -- Polymorph (Rank 3)
	[12826] = "Incapacitate",     -- Polymorph (Rank 4)
	[28271] = "Incapacitate",     -- Polymorph: Turtle
	[28272] = "Incapacitate",     -- Polymorph: Pig
	[20066] = "Incapacitate",     -- Repentance
	[6770]  = "Incapacitate",     -- Sap (Rank 1)
	[2070]  = "Incapacitate",     -- Sap (Rank 2)
	[11297] = "Incapacitate",     -- Sap (Rank 3)
	[1776]  = "Incapacitate",     -- Gouge (Rank 1)
	[1777]  = "Incapacitate",     -- Gouge (Rank 2)
	[8629]  = "Incapacitate",     -- Gouge (Rank 3)
	
	-- *** Stun Effects ***
	[5211]  = "Stun",             -- Bash (Rank 1)
	[6798]  = "Stun",             -- Bash (Rank 2)
	[8983]  = "Stun",             -- Bash (Rank 3)
	[853]   = "Stun",             -- Hammer of Justice (Rank 1)
	[5588]  = "Stun",             -- Hammer of Justice (Rank 2)
	[5589]  = "Stun",             -- Hammer of Justice (Rank 3)
	[10308] = "Stun",             -- Hammer of Justice (Rank 4)
	[408]   = "KidneyShot",       -- Kidney Shot (Rank 1)
	[8643]  = "KidneyShot",       -- Kidney Shot (Rank 2)
	
	-- *** Fear Effects ***
	[5782]  = "Fear",             -- Fear (Rank 1)
	[6213]  = "Fear",             -- Fear (Rank 2)
	[6215]  = "Fear",             -- Fear (Rank 3)
	[8122]  = "Fear",             -- Psychic Scream (Rank 1)
	[8124]  = "Fear",             -- Psychic Scream (Rank 2)
	[10888] = "Fear",             -- Psychic Scream (Rank 3)
	[10890] = "Fear",             -- Psychic Scream (Rank 4)
	[5484]  = "Fear",             -- Howl of Terror (Rank 1)
	[5246]  = "Fear",             -- Intimidating Shout
	
	-- *** Root Effects ***
	[339]   = "Root",             -- Entangling Roots (Rank 1)
	[1062]  = "Root",             -- Entangling Roots (Rank 2)
	[5195]  = "Root",             -- Entangling Roots (Rank 3)
	[5196]  = "Root",             -- Entangling Roots (Rank 4)
	[9852]  = "Root",             -- Entangling Roots (Rank 5)
	[9853]  = "Root",             -- Entangling Roots (Rank 6)
	[122]   = "Root",             -- Frost Nova (Rank 1)
	[865]   = "Root",             -- Frost Nova (Rank 2)
	[6131]  = "Root",             -- Frost Nova (Rank 3)
	[10230] = "Root",             -- Frost Nova (Rank 4)
	
	-- Add more spells as needed from the full TBC DR list
}

