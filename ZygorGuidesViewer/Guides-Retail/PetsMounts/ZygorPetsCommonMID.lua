local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if ZGV:DoMutex("PetsCMID") then return end
ZygorGuidesViewer.GuideMenuTier = "SHA"
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Aquatic Pets\\Dali",{
patch='120000',
source='Drop',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Dali companion pet.",
keywords={"Drop","Aquatic","Treasures","Eversong"},
pet=4974,
startlevel=1,
},[[
step
click Burbling Paint Pot##555351
|tip On the ground, next to the painting.
collect Burbling Blob of Paint##246314 |goto Eversong Woods M/0 48.74,75.44 |or
'|complete haspet(4974) |or
step
use Burbling Blob of Paint##246314
|tip Use it while standing in water.
|tip This pet does not have stats, and can not battle.
learnpet Dali##4974
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Beast Pets\\Ebon Snapling",{
patch='120000',
source='Zone',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Ebon Snapling companion pet.",
keywords={"Zone","Beast"},
pet=4878,
startlevel=1,
},[[
step
clicknpc Ebon Snapling##249818
collect Ebon Snapling##250139 |goto Zul'Aman/0 41.33,48.35
step
use Ebon Snapling##250139
learnpet Ebon Snapling##4878
Also found at:
[Zul Aman M/0 55.78,85.61]
[Zul Aman M/0 42.08,59.51]
[Zul Aman M/0 74.58,69.01]
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Beast Pets\\Flicker",{
patch='120000',
source='Vendor',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Flicker companion pet.",
keywords={"Vendor","Beast"},
pet=4982,
startlevel=1,
},[[
step
earn 200 Brimming Arcana##3379 |goto Eversong Woods/0 43.40,47.40 |or
|tip Obtain these by completing quests, killing mobs, and opening treasures in Eversong Woods.
'|complete haspet(4982) |or
step
talk Apprentice Diell##242723
buy Flicker##264909 |goto Eversong Woods/0 43.40,47.40 |or
'|complete haspet(4982) |or
step
use Flicker##264909
learnpet Flicker##4982
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Beast Pets\\Hexed Bunny",{
patch='120000',
source='Drop',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Hexed Bunny companion pet.",
keywords={"Drop","Beast"},
pet=4959,
startlevel=1,
},[[
step
Run Delves and Open the End of Run Chests
|tip The pet item can drop in the chests.
collect Hexed Bunny##262395
step
use Hexed Bunny##262395
learnpet Hexed Bunny##4959
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Beast Pets\\Sootpaw",{
patch='120100',
source='Achievement',
author="support@zygorguides.com",
description="This guide will teach you how to obtain the Sootpaw companion pet.",
keywords={"Achievement","Beast"},
pet=5012,
startlevel=80,
},[[
step
This companion pet is a reward for completing "Treasures of Eversong Woods" Achievement.
|tip Use the "Treasures of Eversong Woods" Achievement guide to accomplish this.
loadguide "Achievement Guides\\Exploration\\Midnight\\Treasures of Eversong Woods"
collect Sootpaw##269028
step
use Sootpaw##269028
learnpet Sootpaw##5012
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Beast Pets\\Striped Snakebiter",{
patch='100000',
source='Pet Battle',
author="support@zygorguides.com",
description="This guide will teach you to acquire the Striped Snakebiter companion pet.",
keywords={"Pet Battle","Beast"},
pet=3364,
startlevel=80,
},[[
step
click Striped Snakebiter##192368
collect Striped Snakebiter##251004 |goto Zul Aman M/0 51.71,67.28 |or
'|complete haspet(3364) |or
step
use Striped Snakebiter##251004
learnpet Striped Snakebiter##3364
Can also be found at:
[Zul Aman M/0 46.41,57.58]
[Zul Aman M/0 51.81,59.00]
[Zul Aman M/0 38.80,47.38]
[Zul Aman M/0 42.22,63.18]
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Beast Pets\\Willie",{
patch='120000',
source='Drop',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Willie companion pet.",
keywords={"Drop","Beast"},
pet=4972,
startlevel=86,
},[[
step
Enter the cave |goto Voidstorm/0 38.00,68.70
|tip Go left after entering the cave.
click Half-Digested Viscera##613317
|tip This looks like a chunk of meat and bones on the floor of the cave.
collect Willie##264303 |goto Voidstorm/0 37.71,69.77
step
use Willie##264303
learnpet Willie##4972
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Critter Pets\\Amber Treeflitter",{
patch='120000',
source='Zone',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Amber Treeflitter companion pet.",
keywords={"Zone","Critter"},
pet=3277,
startlevel=1,
},[[
step
clicknpc Amber Treeflitter##241500
collect Amber Treeflitter##193068 |goto Eversong Woods/0 40.78,38.61
step
use Amber Treeflitter##193068
learnpet Amber Treeflitter##3277
Can also be found at
[Eversong Woods/0 42.80,38.60]
[Eversong Woods/0 50.01,59.58]
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Critter Pets\\Naloki",{
patch='120000',
source='Vendor',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Naloki companion pet.",
keywords={"Vendor","Critter"},
pet=4888,
startlevel=1,
},[[
step
Reach Renown {y}Rank 12{} with {p}Amani Tribe{} |complete factionrenown(2696) >= 12 |or
|tip Use the {b}Amani Tribe{} Reputation Guide to achieve this.
loadguide "Reputation Guides\\The War Within Reputations\\Amani Tribe"
'|complete haspet(4816) |or
step
earn 2500 Voidlight Marl##3316 |or
|tip You get this currency by killing rare enemies, opening treasures and caches, completing quests, world quests, delves, dungeons, and prey hunts, in Zul'Aman.
'|complete haspet(4888) |or
step
talk Magovu##240279
|tip Inside the building.
buy Naloki##250863 |goto Zul Aman M/0 45.95,65.92 |or
'|complete haspet(4888) |or
step
use Naloki##25086
learnpet Naloki##4888
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Companion Pets\\Magic Pets\\Vibrant Manaling",{
patch='120000',
source='Zone',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Vibrant Manaling companion pet.",
keywords={"Zone","Magic"},
pet=4890,
startlevel=1,
},[[
step
clicknpc Vibrant Manaling##250572
collect Vibrant Manaling##251001 |goto Eversong Woods M/0 39.32,56.71
You can also find one at [Eversong Woods M/0 53.82,55.22]
step
use Vibrant Manaling##251001
learnpet Vibrant Manaling##4890
]])
