local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if ZGV:DoMutex("AchievementsCMID") then return end
ZygorGuidesViewer.GuideMenuTier = "SHA"
ZygorGuidesViewer:RegisterGuide("Achievement Guides\\Exploration\\Midnight\\Treasures of Eversong Woods",{
patch='120000',
author="support@zygorguides.com",
description="This guide will help you discover the Treasures of Eversong Woods.",
achieveid={61960},
startlevel=80,
},[[
step
click Sunstrider Vessel##613708
|tip On the platform.
|tip You will pick this up and carry it.
Gain the "Sunstrider Vessel" Buff |complete hasbuff(126567) |goto Eversong Woods M/0 40.96,19.45 |or
'|complete achieved(61960,3) |or
step
Catch 5 Phoenix Cinders in the Basin
|tip Little phoenixes will appear and drop cinders.
|tip Stand in the circles under the little flying phoenixes that appear.
|tip Stand in the circles to collect them.
Gain 5 Stacks of the "Phoenix Ember" Buff |complete hasbuff(1264565,5) |goto Eversong Woods M/0 40.84,19.76 |or
'|complete achieved(61960,3) |or
step
click Gift of the Phoenix##613697
|tip Return the basin to the stand.
collect Gilded Eversong Cup##263211 |goto Eversong Woods M/0 40.96,19.45 |n
achieve 61960/3
step
talk Farstrider Aerieminder##258550
buy 5 Tasty Meat##265674 |goto Silvermoon City M/0 24.83,69.42 |or
'|complete achieved(61960,1) |or
step
Click the Tasty Meat Plate |goto Silvermoon City M/0 24.12,69.43
|tip Place the meat on the plate in front of the Mischievous Chick.
click Rookery Cache Key##263870
|tip It appears next to the plate.
collect Rookery Cache Key##263870 |goto Silvermoon City M/0 24.16,69.40 |or
'|complete achieved(61960,1) |or
step
click Rookery Cache##617881
collect Sunwing Hatchling##259728 |goto Silvermoon City M/0 24.34,69.28 |n
achieve 61960/1
step
click Antique Nobleman's Signet Ring##613242
|tip On the ground floor, inside the building, on the desk behind the privacy screen.
collect Noble's Signet Ring##265814 |goto Eversong Woods M/0 52.34,45.44 |n
achieve 61960/6
step
click Gilded Armillary Sphere##617534
|tip Upstairs inside the building.
|tip It looks like a small globe with metal rings around it.
collect Gilded Armillary Sphere##265828 |goto Eversong Woods M/0 44.62,45.55 |n
achieve 61960/5
step
click Ripe Grapes##587443
|tip They are growing on the grapevines on this balcony.
collect 10 Bunch of Ripe Grapes##256232 |goto Eversong Woods M/0 40.65,60.74 |or
'|complete achieved(61960,8) |or
step
click Stone Vat##587307
Select _"<Deposit 10 Bunches of Ripe Grapes into the vat.>"_ |gossip 136681
Jump on the Grapes |goto Eversong Woods M/0 40.44,60.90
Watch the dialogue
|tip Goldenmist Vintner will tell you when the grapes are crushed.
confirm |or
'|complete achieved(61960,8) |or
step
talk Sheri##251405
|tip On the same balcony as the grapes you picked.
Select _"Let me browse your goods."_ |gossip 136683
buy Packet of Instant Yeast##256397 |goto Eversong Woods M/0 40.83,60.48 |or
'|complete achieved(61960,8) |or
step
click Stone Vat##587307
Select _"<Deposit Packet of Instant Yeast into the vat.>"_ |gossip 136684
collect Goldenmist Grapes##251912  |goto Eversong Woods M/0 40.47,60.91 |n
achieve 61960/8
step
click Forgotten Ink and Quill##617432
|tip Inside the second floor building, in the bookshelf.
collect Lively Songwriter's Quill##262616 |goto Eversong Woods M/0 43.28,69.50 |n
achieve 61960/4
step
click Burning Torch
Gain the Carrying Torch Buff |complete hasbuff("spell:420847") |goto Eversong Woods M/0 38.85,76.05 |or
'|complete achieved(61960,2) |or
step
Do Not Mount Up
click Tarnished Safebox Key##258770
|tip In the grass near the boulders.
collect Tarnished Safebox Key##258770 |goto Eversong Woods M/0 40.25,75.81 |or
'|complete achieved(61960,2) |or
step
Do Not Mount Up
click Worn Safebox Key##258769
|tip In the grass, next to some construct parts.
collect Worn Safebox Key##258769 |goto Eversong Woods M/0 38.45,73.48 |or
'|complete achieved(61960,2) |or
step
Do Not Mount Up
click Battered Safebox Key##258768
|tip
collect Battered Safebox Key##258768 |goto Eversong Woods M/0 37.63,74.80 |or
'|complete achieved(61960,2) |or
step
click Triple-Locked Safebox##613252
|tip Under one end of the broken-down carriage.
collect Gemmed Eversong Lantern##243106 |goto Eversong Woods M/0 38.90,76.07 |n
achieve 61960/2
step
click Burbling Paint Pot##555351
|tip On the ground by the table and easel.
collect Burbling Blob of Paint##246314 |goto Eversong Woods M/0 48.74,75.45 |n
achieve 61960/9
step
click Farstrider's Lost Quiver##613267
|tip It's leaning against a rock.
collect Lost Quiver##265816 |goto Eversong Woods M/0 60.69,67.29 |n
achieve 61960/7
]])
