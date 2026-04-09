local AddonName, SkillCapped = ...
local SC = SkillCapped

local scBuffOverlayDB = {
	["profileKeys"] = {
		[SC:GetPlayerNameAndRealm()] = "SkillCapped",
	},
	["global"] = {
		["dbVer"] = 1,
	},
	["profiles"] = {
		["SkillCapped"] = {
			["buffs"] = {
				[47585] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "PRIEST",
				},
				[86657] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "PALADIN",
				},
				[74002] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "ROGUE",
				},
				[51753] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 70,
					["class"] = "HUNTER",
				},
				["Eating/Drinking"] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 90,
					["class"] = "MISC",
					["children"] = {
						["Refreshment"] = true,
						["Food & Drink"] = true,
						["Drink"] = true,
						["Food"] = true,
					},
					["UpdateChildren"] = nil --[[ skipped inline function ]],
				},
				[41425] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 20,
					["class"] = "MAGE",
				},
				[6229] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "WARLOCK",
				},
				[53476] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "HUNTER",
				},
				[543] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "MAGE",
				},
				[53480] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "HUNTER",
				},
				["Food"] = {
					["parent"] = "Eating/Drinking",
					["prio"] = 90,
					["class"] = "MISC",
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
				},
				[22842] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "DRUID",
				},
				[33206] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "PRIEST",
				},
				[31224] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 10,
					["class"] = "ROGUE",
				},
				["Drink"] = {
					["parent"] = "Eating/Drinking",
					["prio"] = 90,
					["class"] = "MISC",
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
				},
				[45182] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "ROGUE",
				},
				[48792] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "DEATHKNIGHT",
				},
				[23920] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "WARRIOR",
				},
				[27827] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 10,
					["class"] = "PRIEST",
				},
				[26064] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "HUNTER",
				},
				[66] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "MAGE",
				},
				[46924] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 10,
					["class"] = "WARRIOR",
				},
				[19263] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 10,
					["class"] = "HUNTER",
				},
				[642] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 10,
					["class"] = "PALADIN",
				},
				[1022] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 10,
					["class"] = "PALADIN",
				},
				[47788] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 10,
					["class"] = "PRIEST",
				},
				[1784] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 70,
					["class"] = "ROGUE",
				},
				[12975] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "WARRIOR",
				},
				[61336] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "DRUID",
				},
				[7812] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "WARLOCK",
				},
				["Food & Drink"] = {
					["parent"] = "Eating/Drinking",
					["prio"] = 90,
					["class"] = "MISC",
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
				},
				[22812] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "DRUID",
				},
				[47484] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "DEATHKNIGHT",
				},
				[64205] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "PALADIN",
				},
				[3411] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "WARRIOR",
				},
				[8178] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "SHAMAN",
				},
				[5215] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 70,
					["class"] = "DRUID",
				},
				[871] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "WARRIOR",
				},
				[30823] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "SHAMAN",
				},
				[74001] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "ROGUE",
				},
				[50461] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "DEATHKNIGHT",
				},
				[25771] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 20,
					["class"] = "PALADIN",
				},
				[5277] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "ROGUE",
				},
				[31821] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "PALADIN",
				},
				[20230] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "WARRIOR",
				},
				[48707] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "DEATHKNIGHT",
				},
				[2565] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "WARRIOR",
				},
				[1742] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "HUNTER",
				},
				[498] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 50,
					["class"] = "PALADIN",
				},
				[58984] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 70,
					["class"] = "MISC",
				},
				["Refreshment"] = {
					["parent"] = "Eating/Drinking",
					["prio"] = 90,
					["class"] = "MISC",
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
				},
				[45438] = {
					["state"] = {
						["Bar1"] = {
							["enabled"] = true,
							["glow"] = {
								["enabled"] = false,
								["type"] = "blizz",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["freq"] = 0.25,
								["border"] = false,
								["customColor"] = false,
								["thickness"] = 1,
								["xOff"] = 0,
								["yOff"] = 0,
								["n"] = 8,
							},
							["ownOnly"] = false,
						},
					},
					["prio"] = 10,
					["class"] = "MAGE",
				},
			},
			["welcomeMessage"] = false,
			["bars"] = {
				["Bar1"] = {
					["neverShow"] = false,
					["showCooldownSpiral"] = true,
					["iconScale"] = 0.9,
					["showInBattleground"] = true,
					["iconCount"] = 2,
					["stackCountScale"] = 0.9,
					["iconBorderSize"] = 1,
					["maxGroupSize"] = 40,
					["growDirection"] = "HORIZONTAL",
					["showStackCount"] = true,
					["cooldownNumberScale"] = 1,
					["iconBorder"] = true,
					["showCooldownNumbers"] = false,
					["name"] = "Bar1",
					["iconBorderColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["minGroupSize"] = 0,
					["iconAlpha"] = 0.8,
					["debuffIconBorderColorByDispelType"] = false,
					["id"] = "Bar1",
					["iconAnchor"] = "BOTTOM",
					["iconSpacing"] = 0,
					["showTooltip"] = false,
					["frameTypes"] = {
						["tank"] = true,
						["player"] = true,
						["raid"] = true,
						["assist"] = true,
						["arena"] = true,
						["pet"] = true,
						["party"] = true,
					},
					["showInRaid"] = true,
					["iconXOff"] = 0,
					["showInDungeon"] = true,
					["iconYOff"] = 0,
					["showInScenario"] = true,
					["showInWorld"] = true,
					["buffIconBorderColorByDispelType"] = false,
					["iconRelativePoint"] = "CENTER",
					["showInArena"] = true,
				},
			},
			["minimap"] = {
				["minimapPos"] = 187.9517269232251,
				["hide"] = true,
			},
		},
	},
}

function SC:BuffOverlayDB()
    if not SkillCappedBackupDB.BuffOverlayDB then
        SkillCappedBackupDB.BuffOverlayDB = SC:DeepCopy(BuffOverlayDB)
        SkillCappedBackupDB.addonBackupTimes["BuffOverlay"] = SC:GetDateAndTime()
    end

    BuffOverlayDB = scBuffOverlayDB
    SC:UpdateBuffOverlayProfile()
    --SC:UpdateAddonProfileKeysToSkillCapped("BuffOverlayDB")
end

function SC:UpdateBuffOverlayProfile()
    if not BuffOverlayDB then return end
    local playerNameAndRealm = SC:GetPlayerNameAndRealm()
    BuffOverlayDB.profileKeys[playerNameAndRealm] = "SkillCapped"

    for savedPlayerNameAndRealm, _ in pairs(SkillCappedDB.characters) do
        BuffOverlayDB.profileKeys[savedPlayerNameAndRealm] = "SkillCapped"
    end
end