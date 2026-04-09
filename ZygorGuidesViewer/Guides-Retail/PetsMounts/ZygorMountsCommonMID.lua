local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if ZGV:DoMutex("MountsCMID") then return end
ZygorGuidesViewer.GuideMenuTier = "SHA"
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Ground Mounts\\Vendor Mounts\\Amani Blessed Bear",{
patch='120000',
source='Vendor',
author="support@zygorguides.com",
description="This guide will help you acquire the Amani Blessed Bear mount.",
keywords={"Vendor","Ground"},
mounts={1261357},
mounttype="Ground",
startlevel=10,
},[[
step
Reach Renown {p}Rank 17{} with {y}Amani Tribe{} |complete factionrenown(2696) >= 17 |or
|tip Use the {b}Amani Tribe{} Reputation Guide to achieve this.
loadguide "Reputation Guides\\The War Within Reputations\\Amani Tribe"
'|complete hasmount(1261357) |or
step
earn 6000 Voidlight Marl##3316 |or
|tip You get this currency by killing rare enemies, opening treasures and caches, completing quests, world quests, delves, dungeons, and prey hunts, in Zul'Aman.
'|complete hasmount(1261357) |or
step
talk Magovu##240279
|tip Inside the building.
buy Amani Blessed Bear##257219 |goto Zul Aman M/0 45.95,65.92 |or
'|complete hasmount(1261357) |or
step
use Amani Blessed Bear##257219
learnmount Amani Blessed Bear##1261357
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Ground Mounts\\Dropped Mounts\\Rootstalker Grimlynx",{
patch='120000',
source='Dropped',
author="support@zygorguides.com",
description="This guide will help you acquire the Rootstalker Grimlynx mount.",
keywords={"Dropped","Ground"},
mounts={1243597},
mounttype="Ground",
startlevel=10,
},[[
step
Defeat Rares in Harandar
|tip The mount item has a chance to drop from any rare in Harandar.
|tip Click the rare you wish to kill.
kill Rhazul##248741 |goto Harandar/0 51.15,45.33
kill Ha'kalawe##249849 |goto Harandar/0 70.17,60.87
kill Queen Lashtongue##249962 |goto Harandar/0 60.16,47.11
kill Stumpy##250086 |goto Harandar/0 65.34,32.95
kill Mindrot##250226 |goto Harandar/0 46.11,32.17
kill Treetop##250246 |goto Harandar/0 36.34,75.35
kill Pterrock##250321 |goto Harandar/0 27.39,71.39
|tip Inside the cave
kill Annulus the Worldshaker##250358 |goto Harandar/0 43.76,16.78
|tip This rare patrols around here.
kill Chironex##249844 |goto Harandar/0 68.70,40.61
kill Tallcap the Truthspreader##249902 |goto Harandar/0 72.62,69.35
kill Chlorokyll##249997 |goto Harandar/0 64.47,47.68
kill Serrasa##250180 |goto Harandar/0 55.94,31.63
kill Dracaena##250231 |goto Harandar/0 40.53,43.27
kill Oro'ohna##250317 |goto Harandar/0 28.19,81.81
kill Ahl'ua'huhi##250347 |goto Harandar/0 39.75,60.21
collect Rootstalker Grimlynx##246735
step
use Rootstalker Grimlynx##246735
learnmount Rootstalker Grimlynx##1243597
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Flying Mounts\\Vendor Mounts\\Amani Windcaller",{
patch='120000',
source='Vendor',
author="support@zygorguides.com",
description="This guide will help you acquire the Amani Windcaller mount.",
keywords={"Vendor","Flying"},
mounts={1251630},
mounttype="Flying",
startlevel=10,
},[[
step
Reach Renown {p}Rank 19{} with {y}Amani Tribe{} |complete factionrenown(2696) >= 19 |or
|tip Use the {b}Amani Tribe{} Reputation Guide to achieve this.
loadguide "Reputation Guides\\The War Within Reputations\\Amani Tribe"
'|complete hasmount(1251630) |or
step
earn 6000 Voidlight Marl##3316 |or
|tip You get this currency by killing rare enemies, opening treasures and caches, completing quests, world quests, delves, dungeons, and prey hunts, in Zul'Aman.
'|complete hasmount(1251630) |or
step
talk Magovu##240279
|tip Inside the building.
buy Amani Windcaller##250889 |goto Zul Aman M/0 45.95,65.92 |or
'|complete hasmount(1251630) |or
step
use Amani Windcaller##250889
learnmount Amani Windcaller##1251630
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Flying Mounts\\Trading Post Mounts\\Comfy Bel'ameth Flying Quilt",{
patch='120000',
source='Trading Post',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Comfy Bel'ameth Flying Quilt mount.",
keywords={"Trading Post","Flying"},
mounts={1270522},
mounttype="Flying",
startlevel=20,
},[[
step
earn 550 Trader's Tender##2032 |or
|tip You receive these from the Trading Post Tour quest, opening the chest each month, and from Adventure Guide activities.
'|complete hasmount(1270522) |or
step
Talk to the Trading Post Vendor
buy Comfy Bel'ameth Flying Quilt##263451 |or
|tip Purchase this from the Trading Post in your capital city.
'|complete hasmount(1270522) |or
step
use Comfy Bel'ameth Flying Quilt##263451
|tip Unwrap this in your mount collection.
learnmount Comfy Bel'ameth Flying Quilt##1270522
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Flying Mounts\\Trading Post Mounts\\Comfy Silvermoon Flying Quilt",{
patch='120000',
source='Trading Post',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Comfy Silvermoon Flying Quilt mount.",
keywords={"Trading Post","Flying"},
mounts={1270523},
mounttype="Flying",
startlevel=20,
},[[
step
earn 550 Trader's Tender##2032 |or
|tip You receive these from the Trading Post Tour quest, opening the chest each month, and from Adventure Guide activities.
'|complete hasmount(1270523) |or
step
Talk to the Trading Post Vendor
buy Comfy Silvermoon Flying Quilt##263452 |or
|tip Purchase this from the Trading Post in your capital city.
'|complete hasmount(1270523) |or
step
use Comfy Silvermoon Flying Quilt##263452
|tip Unwrap this in your mount collection.
learnmount Comfy Silvermoon Flying Quilt##1270523
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Flying Mounts\\Promotion Mounts\\Scorching Valor",{
patch='120000',
source='In-Game Shop',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Scorching Valor mount.",
keywords={"In-Game Shop","Flying"},
mounts={1247422},
mounttype="Flying",
startlevel=10,
},[[
step
May be Available for Purchase in the Blizzard Online Store
|tip Once purchased or awarded, you may need to unwrap in your mount inventory.
|tip Check the Blizzard Store and purchase a 6 month subscription to acquire this mount.
learnmount Scorching Valor##1247422
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Flying Mounts\\Achievement Mounts\\Tenebrous Harrower",{
patch='120000',
source='Achievement',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Tenebrous Harrower mount.",
keywords={"Achievement","Flying","Glory","Midnight","Raider"},
mounts={1266980},
mounttype="Flying",
startlevel=20,
},[[
step
achieve 61380
learnmount Tenebrous Harrower##1266980
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Flying Mounts\\Dropped Mounts\\Vibrant Petalwing",{
patch='120000',
source='Dropped',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Vibrant Petalwing mount.",
keywords={"Dropped","Flying"},
mounts={1253927},
mounttype="Flying",
startlevel=20,
},[[
step
Defeat Rares in Harandar
|tip The mount item has a chance to drop from any rare in Harandar.
|tip Click the rare you wish to kill.
kill Rhazul##248741 |goto Harandar/0 51.15,45.33
kill Ha'kalawe##249849 |goto Harandar/0 70.17,60.87
kill Queen Lashtongue##249962 |goto Harandar/0 60.16,47.11
kill Stumpy##250086 |goto Harandar/0 65.34,32.95
kill Mindrot##250226 |goto Harandar/0 46.11,32.17
kill Treetop##250246 |goto Harandar/0 36.34,75.35
kill Pterrock##250321 |goto Harandar/0 27.39,71.39
|tip Inside the cave
kill Annulus the Worldshaker##250358 |goto Harandar/0 43.76,16.78
|tip This rare patrols around here.
kill Chironex##249844 |goto Harandar/0 68.70,40.61
kill Tallcap the Truthspreader##249902 |goto Harandar/0 72.62,69.35
kill Chlorokyll##249997 |goto Harandar/0 64.47,47.68
kill Serrasa##250180 |goto Harandar/0 55.94,31.63
kill Dracaena##250231 |goto Harandar/0 40.53,43.27
kill Oro'ohna##250317 |goto Harandar/0 28.19,81.81
kill Ahl'ua'huhi##250347 |goto Harandar/0 39.75,60.21
collect Vibrant Petalwing##252012
step
use Vibrant Petalwing##252012
learnmount Vibrant Petalwing##1253927
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Flying Mounts\\Trading Post Mounts\\Vicious Snapvine",{
patch='120000',
source='Trading Post',
author="support@zygorguides.com",
description="This guide will help you acquire the Vicious Snapvine mount.",
keywords={"Trading Post","Flying"},
mounts={1269273},
mounttype="Flying",
startlevel=10,
},[[
step
earn 600 Trader's Tender##2032 |or
|tip You receive these from the Trading Post Tour quest, opening the chest each month, and from Adventure Guide activities.
'|complete hasmount(1269273) |or
step
Talk to the Trading Post Vendor
buy Vicious Snapvine##262705 |or
|tip Purchase this from the Trading Post in your capital city.
'|complete hasmount(1269273) |or
step
use Vicious Snapvine##262705
|tip Unwrap this in your mount collection.
learnmount Vicious Snapvine##1269273
]])
ZygorGuidesViewer:RegisterGuide("Pets & Mounts\\Mounts\\Aquatic Mounts\\Trading Post Mounts\\Savage Crimson Battle Turtle",{
patch='120000',
source='Trading Post',
author="support@zygorguides.com",
description="This guide will teach you how to acquire the Savage Crimson Battle Turtle mount.",
keywords={"Trading Post","Aquatic"},
mounts={1266248},
mounttype="Aquatic",
startlevel=20,
},[[
step
earn 500 Trader's Tender##2032 |or
|tip You receive these from the Trading Post Tour quest, opening the chest each month, and from Adventure Guide activities.
'|complete hasmount(1266248) |or
step
Talk to the Trading Post Vendor
buy Savage Crimson Battle Turtle##260409 |or
|tip Purchase this from the Trading Post in your capital city.
'|complete hasmount(1266248) |or
step
use Savage Crimson Battle Turtle##260409
|tip Unwrap this in your mount collection.
learnmount Savage Crimson Battle Turtle##1266248
]])
