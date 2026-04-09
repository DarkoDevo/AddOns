local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if ZGV:DoMutex("DailiesCMID") then return end
ZygorGuidesViewer.GuideMenuTier = "SHA"
ZygorGuidesViewer:RegisterGuide("Daily Guides\\Midnight\\World Quests\\Eversong Woods World Quests",{
description="This guide will assist you in completing world quests in Eversong Woods.",
condition_valid=function() return achieved(42045) end,
condition_valid_msg="You must complete the \"Midnight\" achievement on your account by completing the 5 story campaigns and reaching level 90 on a single character to unlock world quests.",
startlevel=80,
worldquestzone={2395,2393},
patch='120000',
},[[
step
label "Choose_World_Quest"
#include "MID_Choose_World_Quests"
step
label quest-92143
kill Daggerspine Infuser##247966, Daggerspine Myrmidon##247551
|tip Naga.
|tip Click {o}female Infuser naga{} to siphon them.
clicknpc Captured Mana Wyrm##247569+
|tip Small flying fish.
click Arcane Cannister+
|tip Metal and glass containers.
Gather Arcana |q 92143/1 |goto Eversong Woods M/0 36.41,65.95 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92150
kill Displaced Lynx##237400, Erratic Light Wyrm##237399
|tip Click {o}Lynxes{} after fighting.
|tip Large cats.
Help Fairbreeze |q 92150/1 |goto Eversong Woods M/0 45.66,45.89 |future
|tip Use the {o}Shoo Hawkstrider{} button ability near {o}Displaced Hawkstriders{}.
|tip Large walking birds.
|next "MID_World_Quest_Emissaries"
step
label quest-92152
kill Light Wyrm##237408, Lightbloom Ent##240644, Lightbloom Hydra##237414, Lightbloom Lasher##237395, Lightbloom Petalwing##237402, Lightfed Growth##246523
Slay Lightbloom Creatures |q 92152/1 |goto Eversong Woods M/0 42.68,55.59 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92122
clicknpc Emberstrike##249794
|tip Up on the platform.
Mount Emberstrike |q 92122/1 |goto Eversong Woods M/0 39.46,45.07 |future
step
_As You Fly:_
Disrupt the Smuggling Operations |q 92122/2 |future
|tip Bomb enemies and wooden crates.
|next "MID_World_Quest_Emissaries"
stickystart "Slay_Mana_Wyrms_92141"
step
label quest-92141
kill Invasive Lynx##246580, Encroaching Lynx##246365
|tip Cougars.
collect 6 Lynx Collar##258966 |q 92141/1 |goto Eversong Woods M/0 40.76,15.58 |future
step
label "Slay_Mana_Wyrms_92141"
kill Arcane Wyrmling##255148, Arcane Wyrm##249959
|tip Blue floating fish.
Slay #10# Mana Wyrms |q 92141/2 |goto Eversong Woods M/0 40.76,15.58 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92195
Ring the Dinner Bell for #15# Brightwing Butterflies |q 92195/1 |goto Eversong Woods M/0 63.58,29.35 |future
|tip Large butterflies inside rings.
|tip Fly through them.
|next "MID_World_Quest_Emissaries"
step
label quest-92146
kill Infused Seedling##239866, Incubating Lasher##251645, Lightfrenzied Lasher##236557, Lightbloat Trampler##236552, Bloom Propagator##236367, Bloom Dominator##236369, Lucent Hookbeak##244533, Overfester Hydra##240129
click Various Objects
Suppress the Lightbloom |q 92146/1 |goto Eversong Woods M/0 54.47,60.41 |future
|next "MID_World_Quest_Emissaries"
stickystart "Slay_Cultists_92149"
step
label quest-92149
click Various Objects
Destroy the Camp |q 92149/2 |goto Eversong Woods M/0 43.23,85.89 |future
step
label "Slay_Cultists_92149"
kill Dark Caller##242979, Darkness Evoker##242976, Death Caster##242978, Twilight Bruiser##242982, Twilight Death-Dealer##242980
Slay #10# Cultists |q 92149/1 |goto Eversong Woods M/0 43.23,85.89 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92121
kill Enclave Lurker##247603, Watchful Striker##247630
click Various Objects
Clear the Pests Out |q 92121/1 |goto Eversong Woods M/0 59.48,68.38 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92160
clicknpc Unruly Hawkstrider Fledgling##251163
Capture #15# Unruly Hatchlings |q 92160/1 |goto Eversong Woods M/0 56.65,35.37 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92560
kill Lu'ashal##244762 |q 92560/1 |goto Eversong Woods M/0 45.28,60.01 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92138
click Flyer Crate
Pick Up Flyers |q 92138/1 |goto Eversong Woods M/0 41.10,18.83 |future
step
use Recruitment Fliers##250440
|tip On Prospective Students.
|tip Blood elves in robes.
Recruit #8# People |q 92138/2 |goto Eversong Woods M/0 41.03,16.82 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92153
kill Twilight Blade##242970, Twilight Shadecaster##242971, Heavy Caster##242972, Shadeling##242973
Slay #15# Twilight Shadecasters |q 92153/1 |goto Eversong Woods M/0 43.8,68.6 |future
|polish
|next "MID_World_Quest_Emissaries"
stickystart "Slay_Amani_Defectors_92144"
step
label quest-92144
click Various Objects
Destroy #10# Supplies and Armaments |q 92144/2 |goto Eversong Woods M/0 62.85,49.86 |future
step
label "Slay_Amani_Defectors_92144"
kill Amani Defector##236372, Amani Defector##252525, Renegade Enforcer##236374, Renegade Watcher##237344
Slay #10# Amani Defectors |q 92144/1 |goto Eversong Woods M/0 62.85,49.86 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92105
click Cataloger's Carpet
Ride the Cataloger's Carpet |q 92105/1 |goto Silvermoon City M/0 32.41,68.13 |future
step
_While Flying:_
Take Pictures of Wildlife |q 92105/2 |future
|tip Point the light at NPCs.
|tip Use the abilities.
|next "MID_World_Quest_Emissaries"
stickystart "Kill_Vilebranch_Stalkers_92139"
step
label quest-92139
click Vilebranch Altar+
|tip On your minimap.
Destroy #6# Vilebranch Altars |q 92139/1 |goto Eversong Woods M/0 60.38,81.63 |future
step
label "Kill_Vilebranch_Stalkers_92139"
kill 8 Vilebranch Stalker##249965 |q 92139/2 |goto Eversong Woods M/0 60.70,81.43 |future
|tip Hidden.
|tip Altars reveal them.
|next "MID_World_Quest_Emissaries"
step
label quest-92145
talk Vehn Sorrelstride##249436
Select _"Magister Rommath is looking for a new wine. Do you have something I could taste?"_ |gossip 136160
Sample the Wine |q 92145/2 |goto Eversong Woods M/0 39.25,61.10 |count 1 hidden |future
step
talk Nara Fadebranch##249437
Select _"Magister Rommath is looking for a new wine. Do you have something I could taste?"_ |gossip 136159
Sample the Wine |q 92145/2 |goto Eversong Woods M/0 39.59,60.56 |count 2 hidden |future
step
talk Quarelestra##251408
Select _"Magister Rommath is looking for a new wine. Do you have something I could taste?"_ |gossip 136154
Sample the Wine |q 92145/2 |goto Eversong Woods M/0 39.81,60.91 |count 3 hidden |future
step
kill 10 Ornery Winebat##251339 |q 92145/1 |goto Eversong Woods M/0 39.83,60.52 |future
step
talk Razia##252656
|tip Inside the building.
Select _"Nara's Essence of Butterfly."_ |gossip 136248
Select the Wine |q 92145/3 |goto Eversong Woods M/0 41.23,61.18 |future
|next "MID_World_Quest_Emissaries"
stickystart "Slay_Invading_Wildlife_92364"
step
label quest-92364
clicknpc Wandering Leaftender##238516+
|tip Smaller walking trees.
Empower #8# Wandering Leaftenders |q 92364/2 |goto Eversong Woods M/0 51.95,75.18 |future
step
label "Slay_Invading_Wildlife_92364"
kill Agitated Wyrm##238087, Territorial Dragonhawk##238089
Slay #8# Invading Wildlife |q 92364/1 |goto Eversong Woods M/0 51.23,76.79 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92120
click Training Rod of Polymorph
Borrow the Training Rod of Polymorph |q 92120/1 |goto Silvermoon City M/0 36.24,56.12 |future
stickystart "Polymorph_Or_Dispel_Students_92120"
step
click Tome of Polymorph+
|tip Red books.
collect 4 Tome of Polymorph##258965 |q 92120/3 |goto Silvermoon City M/0 34.94,54.36 |future
step
label "Polymorph_Or_Dispel_Students_92120"
clicknpc Polymorphed Student##253634, Silvermoon Student##253635
|tip Beasts and Blood Elves.
Polymorph or Dispel #8# Students |q 92120/2 |goto Silvermoon City M/0 34.94,54.36 |future
|next "MID_World_Quest_Emissaries"
stickystart "Slay_Lightbloom_Creatures_92140"
step
label quest-92140
click Encroaching Roots##570619+
|tip Groups of yellow roots.
|tip On your minimap.
Destroy #4# Encroaching Roots |q 92140/2 |goto Eversong Woods M/0 60.97,57.60 |future
step
label "Slay_Lightbloom_Creatures_92140"
kill Invasive Shinesipper##237500, Lash'ra Mistcaller##237479, Lash'ra Thornguard##237478, Lightfrenzy Demolisher##237634, Lightfrenzy Devourer##237633, Lightfrenzy Shinesipper##240577, Lightfrenzy Tyrannosaptor##237635, Lightmad Saptor##237496
Slay #8# Lightbloom Creatures |q 92140/1 |goto Eversong Woods M/0 60.97,57.60 |future
|next "MID_World_Quest_Emissaries"
step
label "MID_World_Quest_Emissaries"
#include "MID_World_Quest_Emissaries"
]])
ZygorGuidesViewer:RegisterGuide("Daily Guides\\Midnight\\World Quests\\Harandar World Quests",{
description="This guide will assist you in completing world quests in the Harandar.",
condition_valid=function() return achieved(42045) end,
condition_valid_msg="You must complete the \"Midnight\" achievement on your account by completing the 5 story campaigns and reaching level 90 on a single character to unlock world quests.",
startlevel=80,
worldquestzone={2413,2480},
patch='120000',
},[[
step
label "Choose_World_Quest"
#include "MID_Choose_World_Quests"
step
label quest-92582
kill Wandering Stalker##248890+
|tip In the water.
collect 8 Verdant Stalker Sludge##252649 |q 92582/1 |goto Harandar/0 42.09,33.84 |future
step
Tend the Roots |q 92582/2 |goto Harandar/0 42.53,33.75 |future
|tip Use the {o}Flourishing Hope{} button ability.
|next "MID_World_Quest_Emissaries"
step
label quest-92119
click Encroaching Bitterbloom+
|tip Large yellow flowers.
Burn #10# Bitterblooms |q 92119/1 |goto Harandar/0 33.07,64.31 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92085
clicknpc Swift Grimlynx##251627
Mount the Swift Grymlinx |q 92085/1 |goto Harandar/0 52.90,52.25
step
kill 20 Scurrying Vermin##251606 |q 92085/2 |goto Harandar/0 51.29,53.87
|tip Insects.
|tip Run through them.
|next "MID_World_Quest_Emissaries"
step
label quest-93053
click Dried Acorn+
|tip Brown pine cones.
Remove #8# Dried Acorns |q 93053/1 |goto Harandar/0 51.53,53.17 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91555
clicknpc Weary Defender##247648+
|tip Kneeling friendly humanoids.
Reinvigorate #6# Weary Defenders |q 91555/1 |goto Harandar/0 58.13,52.38 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91490
Douse #18# Smoldering Fires |q 91490/1 |goto Harandar/0 35.71,36.92 |future
|tip Fly next to fires.
|next "MID_World_Quest_Emissaries"
step
label quest-91785
kill Lightbloomed Spore##248556, Lightbloomed Spore##248683
|tip Yellow orbs.
Slay #20# Lightbloom Spores |q 91785/1 |goto Harandar/0 38.09,70.29 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92583
kill Battling Moldstalker##243772, Battling Mycomancer##243771, Battling Rotseeker##243773, Battling Sporecaller##243774, Kragthar##243779, Malgar the Uprooter##248986, Opportunistic Sporeglider##243780
Fight in the Grudge Pit |q 92583/1 |goto Harandar/0 71.56,65.93 |future
|next "MID_World_Quest_Emissaries"
step
label quest-93046
click Petalwing Nest+
|tip Large bird nests.
|tip On your minimap.
Find #4# of Orweyna's Belongings |q 93046/1 |goto Harandar/0 32.63,85.95 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91927
clicknpc Escaping Ooze##249055+
|tip Small blue blobs.
Boot #6# Escaping Oozes |q 91927/1 |goto Harandar/0 62.61,56.32 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91937
click Bo'ke
Ride Bo'ke |q 91937/1 |goto Harandar/0 62.68,48.88 |future
step
_While Riding:_
Take Pictures of Wildlife |q 91937/2 |future
|tip Point the light at creatures.
|tip Use the abilities.
|next "MID_World_Quest_Emissaries"
step
label quest-92184
clicknpc Frightened Potadpole##250255+
Capture #8# Potadpoles |q 92184/1 |goto Harandar/0 68.86,39.58 |future
step
click Release Potadpole
Release the Potadpoles |q 92184/2 |goto Harandar/0 70.75,38.82 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91582
kill Deenit##245735, Kazat##237655, Lattice Crawler##245659, Lattice Elder Root##237692, Lattice Grovewarden##237640, Lattice Mistcaller##237161, Lattice Sap Weaver##237641, Lattice Thornguard##237642, Makoot##237693, Petalchomper##237711, Pilfering Petalwing##237709
Prune the Blooming Lattice |q 91582/1 |goto Harandar/0 55.21,29.16 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92162
click Ancient Visionstone
|tip Underground.
Activate the Mural |q 92162/1 |goto Harandar/0 37.57,47.70 |future
step
label "Sate_Your_Hunger_92162"
Sate Your Hunger |q 92162/2 |goto Harandar/0 36.34,45.78 |future
|tip Jump into the {o}flying insects{}.
|tip Click the {o}Visionstone{} again if you lose the disguise.
|only if haveq(92162) and hasbuff(1251530)
step
click Ancient Visionstone
|tip Underground.
Enter the Vision Walk |havebuff Vision Walk##1251530 |goto Harandar/0 37.57,47.70 |future |next "Sate_Your_Hunger_92162"
|only if haveq(92162)
step
|next "MID_World_Quest_Emissaries"
step
label quest-93071
kill Decanimated Blightbringer##246780, Decanimated Rotling##246783, Decanimated Rotseeker##246782
|tip Mushroom people.
Slay #15# Decanimated Blightbringers |q 93071/1 |goto Harandar/0 45.64,68.14 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92063
talk Nu'lan##251172
Select _"<Offer your aid as a witness and a guide.>"_ |gossip 135646
Talk to Nu'lan |q 92063/1 |goto Harandar/0 70.76,38.90 |future
step
kill Dri'hara##251525
|tip Use the {o}Hunter's Bravery{} button ability.
Slay Dri'hara |q 92063/2 |goto Harandar/0 70.09,36.98 |future
step
kill Toa'mara##251305
|tip Use the {o}Hunter's Bravery{} button ability.
Slay Toa'mara |q 92063/3 |goto Harandar/0 70.83,34.22 |future
step
kill Kham'dur##251544
|tip Use the {o}Hunter's Bravery{} button ability.
Slay Kham'dur |q 92063/4 |goto Harandar/0 72.65,34.70 |future
|next "MID_World_Quest_Emissaries"
step
label quest-93013
clicknpc Haranir Petalwing##241799
Ride the Haranir Petalwing |q 93013/1 |goto Harandar/0 33.27,75.88 |future
step
_As You Fly:_
kill enemies
Defeat the Lightbloom Rutaani |q 93013/2 |future
|next "MID_World_Quest_Emissaries"
stickystart "Collect_Savory_Saptor_Slices_92086"
stickystart "Collect_Sweet_Beetle_Wings_92086"
stickystart "Collect_Drifter_Jelly_92086"
step
label quest-92086
click Rich Loamy Soil+
|tip Piles of dirt.
collect 2 Rich Loamy Soil##252257 |q 92086/4 |goto Harandar/0 41.28,24.49 |future
step
label "Collect_Savory_Saptor_Slices_92086"
kill Salivating Saptor##249285+
|tip Plant raptors.
collect 4 Savory Saptor Slice##252234 |q 92086/1 |goto Harandar/0 41.28,24.49 |future
step
label "Collect_Sweet_Beetle_Wings_92086"
kill Peckish Beetle##248127+
|tip Flying insects.
collect 4 Sweet Beetle Wings##252246 |q 92086/2 |goto Harandar/0 41.28,24.49 |future
step
label "Collect_Drifter_Jelly_92086"
kill Delectable Root Drifter##240113+
|tip Flying jellyfish.
collect 4 Drifter Jelly##252259 |q 92086/3 |goto Harandar/0 41.28,24.49 |future
|next "MID_World_Quest_Emissaries"
stickystart "Remove_Invasive_Fungi_92062"
step
label quest-92062
click Withered Plant+
|tip Plants with yellow flowers.
|tip Run away from them.
|tip You will be attacked.
Remove #6# Withered Plants |q 92062/1 |goto Harandar/0 35.52,24.75 |future
step
label "Remove_Invasive_Fungi_92062"
click Invasive Fungi+
|tip Clusters of red mushrooms.
Remove #8# Invasive Fungi |q 92062/2 |goto Harandar/0 35.52,24.75 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92034
kill Thorm'belan##249776 |q 92034/1 |goto Harandar/0 38.89,66.52 |future
|next "MID_World_Quest_Emissaries"
stickystart "Collect_Phytogenic_Poison_Parts_91981"
step
label quest-91981
click Healing Waters of Ahl'ua+
|tip Blue tornados.
|tip In the water.
collect 4 Healing Waters of Ahl'ua##243196 |q 91981/1 |goto Harandar/0 42.17,56.43 |future
step
label "Collect_Phytogenic_Poison_Parts_91981"
kill Ahl'ua Bull##244376, Ahl'ua Chloroceros##244371, Lethal Lasher##244344, Lethal Lashling##244340, Poisonous Firefly##244363, Potatotoad Brute##244349, Toxic Potatotoadling##244326, Toxic Potatotoad##244325, Wetland Terror##244338
collect 6 Phytogenic Poison Part##243598 |q 91981/2 |goto Harandar/0 42.17,56.43 |future
|next "MID_World_Quest_Emissaries"
step
label "MID_World_Quest_Emissaries"
#include "MID_World_Quest_Emissaries"
]])
ZygorGuidesViewer:RegisterGuide("Daily Guides\\Midnight\\World Quests\\Voidstorm World Quests",{
description="This guide will assist you in completing world quests in the Voidstorm.",
condition_valid=function() return achieved(42045) end,
condition_valid_msg="You must complete the \"Midnight\" achievement on your account by completing the 5 story campaigns and reaching level 90 on a single character to unlock world quests.",
startlevel=80,
worldquestzone={2405,2479,2444},
patch='120000',
},[[
step
label "Choose_World_Quest"
#include "MID_Choose_World_Quests"
step
label quest-92566
talk Complacent Voidwalker##252328+
|tip On your minimap.
Select _"Let's spar!"_ |gossip 136045
kill Complacent Voidwalker##252328+
Train #12# Complacent Voidwalkers |q 92566/1 |goto Slayers Rise/0 73.68,75.11 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92731
talk Decimus##243907
Select _"I am ready to begin!"_ |gossip 136350
Speak with Decimus to Begin |q 92731/1 |goto Voidstorm/0 51.20,68.45 |future
step
Watch the dialogue
|tip Follow the instructions.
|tip Click the objects.
Forge the Blade |q 92731/2 |goto Voidstorm/0 51.27,68.66 |future
|next "MID_World_Quest_Emissaries"
step
label quest-94425
talk Scout Adaephus##257703
|tip Up on the platform.
Select _"<Accept the scout's Umbral Cloak.>"_ |gossip 137746
Speak to Scout Adaephus |q 94425/1 |goto Voidstorm/0 49.08,59.84 |future
stickystart "Slay_Elite_Voidspire_Forces_94425"
step
click Summoning Pylon+
|tip On your minimap.
Shatter #8# Summoning Pylons |q 94425/3 |goto Voidstorm/0 49.81,58.19 |future
More around [Voidstorm/0 53.80,52.14]
step
label "Slay_Elite_Voidspire_Forces_94425"
kill Brinkfeaster##256605, Celestial Behemoth##256598, Living Shadow##256600, Shadowguard Artificer##256611, Shadowguard Crusher##256615, Shadowguard Voidtamer##256612, Stronghold Ascendant##256597, Stronghold Enforcer##256603, Stronghold Slayer##256596, Supreme Ultradon##256607, Terrace Watcher##256614, Voidspire Harrower##256595, Voidspire Obliterator##256591, Voltaic Trigore##256606
|tip Use the {o}Umbral Cloak{} button ability.
|tip Attack them while stealthed.
Slay #8# Elite Voidspire Forces |q 94425/2 |goto Voidstorm/0 49.81,58.19 |future
More around [Voidstorm/0 53.80,52.14]
|next "MID_World_Quest_Emissaries"
step
label quest-93577
click Cataloger's Disc
Ride the Cataloger's Disc |q 93577/1 |goto Voidstorm/0 36.02,49.02 |future
step
_While Flying:_
Take Pictures of Wildlife |q 93577/2 |future
|tip Point the light at creatures.
|tip Use the abilities.
|next "MID_World_Quest_Emissaries"
step
label quest-93573
click Dark Vessel
Examine the Dark Vessel |havebuff Deciphering Dark Wisdom##1265125 |goto Voidstorm/0 41.87,74.81 |q 93573 |future
step
Decipher the Dark Vessel |q 93573/1 |future
|tip Swap the blue orbs around.
|tip Make the lines not overlap.
|next "MID_World_Quest_Emissaries"
step
label quest-93904
click Void Tear+
|tip Swirling blue portals.
|tip Inside the underground cave.
Collect Void Power |q 93904/1 |goto Voidlands Abundance/1 59.42,45.41 |future
|tip Float through {o}blue rings{}.
|tip Enter the {o}hole{} at the {o}bottom of the cave{}.
|tip Shoots you back up.
|next "MID_World_Quest_Emissaries"
step
label quest-93571
kill Blood-Starved Carnidon##243142
Slay the Void-gorged Monstrosity |q 93571/1 |goto Voidstorm/0 27.84,53.53 |count 1 hidden |future
step
kill Gorgargus the Mutinous##243141
Slay the Void-gorged Monstrosity |q 93571/1 |goto Voidstorm/0 26.10,53.17 |count 2 hidden |future
step
kill Karybdos##243140
Slay the Void-gorged Monstrosity |q 93571/1 |goto Voidstorm/0 28.06,50.33 |count 3 hidden |future
|next "MID_World_Quest_Emissaries"
step
label quest-93507
kill Arcane Elemental##245614, Shadowguard Adept##245467, Shadowguard Automaton##244621, Shadowguard Engineer##244608, Shadowguard Infuser##244610, Shadowguard Technician##244606, Shadowguard Voidweaver##245461
click Various Objects
Disrupt the Shadowguard Operation |q 93507/1 |goto Voidstorm/0 37.67,43.59 |future
|next "MID_World_Quest_Emissaries"
stickystart "Disrupt_The_Domanaar_Forces_92576"
step
label quest-92576
click Defiant Banner+
|tip Yellow poles with flags.
|tip On your minimap.
Place #6# Banners |q 92576/1 |goto Slayers Rise/0 53.82,29.37 |future
step
label "Disrupt_The_Domanaar_Forces_92576"
kill Devouring Spawn##248007, Enraged Domanaar##252354, Ramparts Watcher##247802, Spiteful Consumptor##248013, Spiteful Minder##248005, Spiteful Mindwarden##256895, Spitegraft Harrower##248081, Voidscar Controller##247994
click Void Ward+
|tip Shattered orbs.
|tip On your minimap. |notinsticky
Disrupt the Domanaar Forces |q 92576/2 |goto Slayers Rise/0 53.82,29.37 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91419
Shoot a Void Missile at Elementals or Kill Players |q 91419/1 |goto Slayers Rise/0 64.82,52.50 |future
|tip Jump inside {o}Anti-Gravity Areas{}.
|tip {o}Blue circles{} moving around.
|tip On your minimap.
|tip {o}Follow them{} as they move.
|tip Use the {o}Void Missile{} button ability on {o}Nefarious Elemental{}.
|tip Small elementals.
|next "MID_World_Quest_Emissaries"
step
label quest-87759
kill Vengeful Shredclaw##239427, Heinous Klaxid##239461
|tip They become friendly.
|tip Click them to gain a button ability.
Subdue Void Creatures or Kill Players |q 87759/1 |goto Slayers Rise/0 60.65,61.48 |future
|next "MID_World_Quest_Emissaries"
step
label quest-88679
kill Enraged Bloodfeaster##239940, Wrathful Flyer##239941
|tip They become friendly.
|tip Click them to gain a button ability.
Subdue Creatures or Kill Players |q 88679/1 |goto Slayers Rise/0 42.69,48.65 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92546
kill 8 Encroaching Shredclaw##252107 |q 92546/1 |goto Voidstorm/0 35.59,58.94 |future
|tip Stealthed demon dogs.
|next "MID_World_Quest_Emissaries"
step
label quest-88992
kill Abhorrent Shadowguard##240645, Malignant Shadowguard##240647
Kill Shadowguards or Kill Players |q 88992/1 |goto Slayers Rise/0 65.28,52.07 |future
|next "MID_World_Quest_Emissaries"
step
label quest-93397
click Slain Beast+
|tip Dead grey beasts.
|tip Gives a button ability.
kill 5 Slavering Ultradon##235498 |q 93397/2 |goto Voidstorm/0 59.97,75.61 |future
|tip Use the {o}Carrion Essence{} button ability on them.
|tip Weakens them.
|tip Large humanoid elite enemies.
|next "MID_World_Quest_Emissaries"
step
label quest-89267
kill Accursed Elemental##242459, Malefic Engineer##241447, Spiteful Shadowguard##241448
Kill Ethereals or Kill Players |q 89267/1 |goto Slayers Rise/0 35.66,53.97 |future
|next "MID_World_Quest_Emissaries"
step
label quest-93905
kill Devouring Enforcer##236860, Manaforge Netherdrifter##236859, Manaforge Siphoner##236857, Manaforge Warder##237886, Netherbreaker##241040, Recommissioned Mech##238581
clicknpc Unraveling Captive##235710+
|tip Friendly NPCs in bubbles.
click Various Objects
Disrupt the Manaforge |q 93905/1 |goto Voidstorm/0 36.33,76.18 |future
|next "MID_World_Quest_Emissaries"
step
label quest-93517
kill Overcroft Ascendant##239440, Overcroft Automaton##239439, Overcroft Inquisitor##244836, Overcroft Militant##239422, Overcroft Skypiercer##239438, Overcroft Technician##239441
collect 10 Shadowguard Intelligence##259029 |q 93517/1 |goto Voidstorm/0 46.42,70.23 |future
|next "MID_World_Quest_Emissaries"
step
label quest-89347
kill Rage-Riddled Drifter##241472 |q 89347/1 |goto Slayers Rise/0 53.71,28.19 |future
|next "MID_World_Quest_Emissaries"
step
label quest-93579
kill Failed Supplicant##255578, Famished Aspirant##257858, Feeble Supplicant##255655, Hungering Aspirant##255661, Rueful Flagellant##255706
clicknpc Failed Supplicant##255578+
|tip Dead void creatures.
click Fallow Altar
|tip Gather {o} 10 Void Essence{}.
Empower the Fallow Altar with Void Essence |q 93579/2 |goto Voidstorm/0 29.31,45.00 |count 1 hidden |future
step
kill Failed Supplicant##255578, Famished Aspirant##257858, Feeble Supplicant##255655, Hungering Aspirant##255661, Rueful Flagellant##255706
clicknpc Failed Supplicant##255578+
|tip Dead void creatures.
click Fallow Altar
|tip Gather {o} 10 Void Essence{}.
Empower the Fallow Altar with Void Essence |q 93579/2 |goto Voidstorm/0 27.18,44.19 |count 2 hidden |future
step
kill Failed Supplicant##255578, Famished Aspirant##257858, Feeble Supplicant##255655, Hungering Aspirant##255661, Rueful Flagellant##255706
clicknpc Failed Supplicant##255578+
|tip Dead void creatures.
click Fallow Altar
|tip Gather {o} 10 Void Essence{}.
Empower the Fallow Altar with Void Essence |q 93579/2 |goto Voidstorm/0 26.65,41.43 |count 3 hidden |future
|next "MID_World_Quest_Emissaries"
step
label quest-92636
kill Predaxas##238015 |q 92636/1 |goto Voidstorm/0 49.04,86.89 |future
|next "MID_World_Quest_Emissaries"
step
label quest-93244
_NOTE:_
During the Next Steps
|tip Kill ethereal enemies.
|tip They drop {o}Overflow Diverters{}.
|tip Use them on the enemies at each console.
|tip Makes them take extra damage.
Click Here to Continue |confirm |q 93244 |future
step
click Surge's Console
kill Energy Surge##256945
Reroute Surge's Power |q 93244/5 |goto Voidstorm/0 39.33,85.41 |future
step
click Dweller's Console
kill Arcane Dweller##256949
Reroute Dweller's Power |q 93244/4 |goto Voidstorm/0 38.81,86.52 |future
step
click Unbound's Console
kill Energized Unbound##256950
Reroute Unbound's Power |q 93244/3 |goto Voidstorm/0 38.06,85.80 |future
step
click Amalgam's Console
kill Arcane Amalgam##256951
Reroute Amalgam's Power |q 93244/2 |goto Voidstorm/0 38.57,84.67 |future
|next "MID_World_Quest_Emissaries"
step
label quest-93438
click Esoti
Ride the War-Wyrm |q 93438/1 |goto Voidstorm/0 35.62,69.23 |future
step
_As You Fly:_
Slay #10# Forces in the Lower Courtyard |q 93438/2 |future
|tip Shoot enemies.
step
_As You Fly:_
Eliminate #5# High Value Targets |q 93438/4 |future
|tip Enemies with red arrows.
|tip Shoot enemies.
Slay #10# Forces in the Upper Courtyard |q 93438/3 |future
step
_As You Fly:_
Destroy #5# Stormarion Supplies |q 93438/6 |future
|tip Objects with red arrows.
Slay #7# Forces in Stormarion Watch |q 93438/5 |future
|tip Shoot enemies.
|next "MID_World_Quest_Emissaries"
step
label quest-90962
click Defense Position+
|tip On your minimap.
Kill the enemies that attack in waves
|tip Defend the {o}Singularity Anchor{}.
|tip Repeat this process.
Complete the Entire Stormarion Assault Event |q 90962/1 |goto Voidstorm/0 26.76,67.91 |future
|next "MID_World_Quest_Emissaries"
step
label quest-93524
Knock Down #20# Voracious Harrowers |q 93524/1 |goto Voidstorm/0 49.57,65.95 |future
|tip Large flying bats.
|tip Fly through them.
|next "MID_World_Quest_Emissaries"
step
label quest-92746
Enter the Stellar Vortex |q 92746/1 |goto Voidstorm/0 39.23,57.74 |future
|tip Walk into the portal.
step
Collect #10# Anomalous Residue |q 92746/2 |goto Voidstorm/0 39.61,58.03 |future
|tip Float through the {o}blue circles{}.
|tip Enter the {o}blue portals{} on the ground.
|tip Launches you back up.
|next "MID_World_Quest_Emissaries"
step
label quest-89377
click Void-tainted Meat+
|tip On your minimap.
kill Bitter Beast##242481, Vicious Consumptor##241570
Kill Behemoths or Kill Players |q 89377/1 |goto Slayers Rise/0 45.27,41.81 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92549
Disperse #20# Void Anomalies |q 92549/1 |goto Voidstorm/0 65.32,61.48 |future
|tip Purple orbs in floating rings.
|tip Fy through them.
|next "MID_World_Quest_Emissaries"
step
label quest-93578
kill Alloyed Ultradon##252810, Alloyed Voidcrawler##246051, Baleful Voidwalker##246064, Desolate Wraith##246055, Gaunt Voidspawn##246063, Grief-Sworn Slayer##256376, Hate-Sworn Butcher##256377, Voracious Wraith##246073, Woeful Voidwalker##252815, Wretched Voidwalker##246057
click Various Objects
Disrupt the Battlefield Combatants |q 93578/1 |goto Slayers Rise/0 48.29,70.57 |future
|next "MID_World_Quest_Emissaries"
step
label "MID_World_Quest_Emissaries"
#include "MID_World_Quest_Emissaries"
]])
ZygorGuidesViewer:RegisterGuide("Daily Guides\\Midnight\\World Quests\\Zul'Aman World Quests",{
condition_valid=function() return achieved(42045) end,
condition_valid_msg="You must complete the \"Midnight\" achievement on your account by completing the 5 story campaigns and reaching level 90 on a single character to unlock world quests.",
worldquestzone={2437},
patch='120000',
},[[
step
label "Choose_World_Quest"
#include "MID_Choose_World_Quests"
step
label quest-91802
kill Boggorm Recluse##255154, Spiny Leechling##255141, Wallows Mukleech##255139
|tip Walking insects.
collect 100 Leech Tick##260453 |q 91802/1 |goto Zul Aman M/0 41.42,60.33 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91806
kill Bark Breaker##253991, Bark Skullcracker##253992, Mammoth Tamer##253996
click Stolen Meat+
|tip Large pieces of red meat.
collect 12 Stolen Game Meat##258324 |q 91806/1 |goto Zul Aman M/0 28.03,36.96 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91810
clicknpc Prepared Zapgut##256047+
Squeeze #5# Prepared Zapgut Eels |q 91810/1 |goto Zul Aman M/0 47.10,24.50 |future
step
Jump on the Blisterskin Kelp #8# Times |q 91810/3 |goto Zul Aman M/0 47.04,24.64 |future
|tip Jump repeatedly.
step
clicknpc Prepared Saltleaf Boar##256025+
Carve #6# Prepared Saltleaf Boars |q 91810/2 |goto Zul Aman M/0 47.14,24.82 |future
step
click Jol the Splintershell##255186
buy Bag of Skewers##260890 |q 91810/4 |goto Zul Aman M/0 47.27,25.21 |future
step
click Blistereel Boar Skewer
Cook the Blistereel Boar |q 91810/5 |goto Zul Aman M/0 47.14,24.67 |future
step
click Blistereel Boar
Taste the Blistereel Boar |q 91810/6 |goto Zul Aman M/0 47.15,24.61 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91805
click Heartwisp Shrub+
|tip Scraggly plants.
collect 20 Heartwisp Frond##252370 |q 91805/1 |goto Zul Aman M/0 39.72,47.56 |future
|next "MID_World_Quest_Emissaries"
step
label quest-92123
kill Cragpine##244424 |q 92123/1 |goto Zul Aman M/0 45.21,48.02 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91804
kill Floating Puffer##254188, Hexxa Eel##254201, Kelp Crab##254198, Ripsnout Shark##254192, Scamp Grouper##254204, Striped Lionfish##254189, Threshette Calf##254207, Threshunk##254209
|tip Underwater.
|tip Move into the {o}Underwater Airflow{} bubbles.
|tip Gives swim speed and water breathing.
collect 15 Lumpy Fish Guts##257241 |q 91804/1 |goto Zul Aman M/0 53.55,48.35 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91798
kill Carnivorous Crab##252222, Hungry Hatchling##251705, King Crab##252221, Slippery Snapper##251636, Snacking Gatherer##252225, Snacking Warrior##252224
clicknpc Slippery Snapper##251636+
|tip Fish.
|tip In the water.
click River Rowberry+
|tip Small red flowers near the water.
|tip Gives {o}swim speed{} and {o}water breathing{}.
collect 10 Slippery Snapper##252003 |q 91798/1 |goto Zul Aman M/0 39.57,80.11 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91800
kill Baleful Darkspawn##251693, Twilight Enforcer##251688, Twilight Shadowmage##251687
click Ransacked Heirloom+
|tip Piles of rubble.
collect 12 Ransacked Heirloom##258321 |q 91800/1 |goto Zul Aman M/0 24.51,62.29 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91803
kill Bogfin Tidechanter##245709, Murloc Behemoth##245714, Murloc Dredgecaller##245712, Murloc Fistfin##245710, Murloc Reefstalker##245711, Murloc Scaleguard##245713
click Stolen Supplies+
|tip Wooden crates.
collect 8 Stolen Supplies##249498 |q 91803/1 |goto Zul Aman M/0 51.40,64.80 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91808
click Stolen Equipment+
|tip Broken wooden crates.
collect 10 Stolen Equipment##238964 |q 91808/1 |goto Zul Aman M/0 30.12,29.11 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91811
clicknpc Coalesced Fire##256106
|tip You will be attacked.
|tip Top of the building.
Touch the Coalesced Fire |q 91811/1 |goto Zul Aman M/0 55.07,18.26 |future
step
Slay the Manifestation of Yourself |q 91811/2 |goto Zul Aman M/0 55.07,18.26 |future
|tip Enemy with your character's name.
|next "MID_World_Quest_Emissaries"
step
label quest-91793
talk Depthdiver Jeju##240195
Begin an Abyss Angler Dive |q 91793/1 |goto Zul Aman M/0 68.24,20.24 |future
|polish
step
|confirm
|next "MID_World_Quest_Emissaries"
step
label quest-91796
Inhabit a Loa Avatar |q 91796/1 |goto Atal Aman M/1 34.45,65.25 |future
|tip Use the {o}Surrender to the Flame{} button ability.
|tip Inside the building.
step
kill Raiding Caster##254734, Raiding Caster##255883, Raiding Rogue##254731, Raiding Rogue##255882, Raiding Warrior##254534, Raiding Warrior##255881
|tip All around Atal Aman.
Slay #50# Echoes |q 91796/2 |goto Atal Aman M/1 34.68,47.21 |future
step
kill Raid Leader##254902 |q 91796/4 |goto Atal Aman M/1 63.89,47.28 |future
|tip Use the {o}Time Flies{} ability to travel.
step
Release the Loa Avatar |outvehicle
|tip Click the arrow to leave the vehicle.
|next "MID_World_Quest_Emissaries"
step
label quest-91390
talk Kul'kul##246880
accept Dead by Dusk##91401 |goto Zul Aman M/0 28.47,76.82
step
talk Nan'kejo##246878
accept Ashes of the Void##91399 |goto Zul Aman M/0 22.73,73.16
step
talk Akovu##246879
accept Blades of the Fallen##91400 |goto Zul Aman M/0 22.48,79.67
stickystart "Collect_Cultist_Femurs_91401"
stickystart "Collect_Void_Ashes_91399"
step
click Forgotten Amani Axe+
collect 12 Amani Hatchet##246443 |q 91400/1 |goto Zul Aman M/0 25.35,76.92
step
label "Collect_Cultist_Femurs_91401"
kill Twilight Occultist##246620, Twilight Warrior##246619
|tip Humanoids.
collect 20 Cultist Femur##246440 |q 91401/1 |goto Zul Aman M/0 25.35,76.92
step
label "Collect_Void_Ashes_91399"
kill Encroaching Darkness##246615, Flickering Shadow##246614, Twilight's Shade##246616
|tip Elementals.
collect 50 Void Ashes##246439 |q 91399/1 |goto Zul Aman M/0 25.35,76.92
step
talk Kul'kul##246880
turnin Dead by Dusk##91401 |goto Zul Aman M/0 28.47,76.82
step
talk Nan'kejo##246878
turnin Ashes of the Void##91399 |goto Zul Aman M/0 22.73,73.16
step
talk Akovu##246879
turnin Blades of the Fallen##91400 |goto Zul Aman M/0 22.48,79.67
Complete #3# Daily Quests in Atal'Kaldan |q 91390/1 |goto Zul Aman M/0 22.48,79.67 |future
|next "MID_World_Quest_Emissaries"
step
label quest-91799
Inspire Eagles |q 91799/1 |goto Zul Aman M/0 52.19,80.77 |future
|tip Birds flying next to rings.
|tip Fly through them.
|tip On your minimap.
|tip Top of the mountain.
|next "MID_World_Quest_Emissaries"
stickystart "Slay_Twilights_Blade_91801"
step
label quest-91801
click Ritual Component
Destroy the Ritual Component |q 91801/2 |goto Zul Aman M/0 37.70,69.94 |count 1 hidden |future
step
click Ritual Component
Destroy the Ritual Component |q 91801/2 |goto Zul Aman M/0 37.32,72.43 |count 2 hidden |future
step
click Ritual Component
Destroy the Ritual Component |q 91801/2 |goto Zul Aman M/0 35.62,71.88 |count 3 hidden |future
step
label "Slay_Twilights_Blade_91801"
kill Shadowstalker##251159, Twilight Bonecrusher##251156, Twilight Dreadblade##251154, Twilight Mindshaper##251150, Twilight Soulbinder##251152, Twilight Voidtongue##251153, Twilight Zealot##251151
Slay #12# Twilight's Blade |q 91801/1 |goto Zul Aman M/0 37.71,72.09 |future
|next "MID_World_Quest_Emissaries"
step
label "MID_World_Quest_Emissaries"
#include "MID_World_Quest_Emissaries"
]])
ZygorGuidesViewer:RegisterGuide("Daily Guides\\The War Within (70-80)\\Special Missions Locked",{
startlevel=70,
areapoiid={7828,7823,7826,7827,7825,7886,7829,7824,8183,8185,8184,8324,8328,8612,8471,8611,8585,8524,8588,8695,8696,8523},
patch='120002',
},[[
step
Complete Additional World Quests |complete false
|tip Special Assignments require a certain number of world quests be complete in the same zone before unlocking.
|tip Complete the number of world quests or specific world quest indicated on the special assignment icon before clicking it.
|tip If you complete the indicated quests but it still won't unlock, relogging should fix it.
]])
ZGV.BETASTART()
ZygorGuidesViewer:RegisterGuide("Daily Guides\\Midnight\\Saltheril's Haven Weelkies",{
},[[
step
talk Caeris Fairdawn##240838
accept Courting Success##93930 |goto Eversong Woods M/0 43.46,47.42
|tip You need to complete the intro guide before you can start this guide.
step
label "Begin_Weekly_Quests"
talk Lord Saltheril##240832
accept Favor of the Court##89289 |goto Eversong Woods M/0 42.68,47.31
|tip You cannot accept this quest in the same week you completed the intro.
|tip You can only complete this quest once per week for your entire warband.
|tip If this quest is not offered, skip this step.
step
talk Lord Saltheril##240832
Select _"I'd like to select someone to invite for the week."_ |gossip 132893
Select an Invitation |q 89289/1 |goto Eversong Woods M/0 42.68,47.31
|tip The NPC you choose will determine which Runestone quest you are offered.
|tip It's generally preferred to choose an invitation that offered additional currency for the week.
|only if haveq(89289) or completedq(89289)
step
talk Lord Saltheril##240832
turnin Favor of the Court##89289 |goto Eversong Woods M/0 42.68,47.31
|only if haveq(89289) or completedq(89289)
step
Accept the Available Weekly Quests |autoacceptany 89276,89278,89285,89289,89307,89311,89314,90573,"90574-90576",91972,91974,"91976-91979",91983,"91986-91988",91993,92000,92002,92005,92006,92007
|tip Each week, a Fortify the Runestones quest is offered to complete the event.
|tip NPCs with bars over their head will offer weekly quests in exchange for Saltheril's Favor currency.
|tip You can exchange up to 3 Saltheril's Favor per NPC per week.
|tip Each exchange unlocks one additional weekly quest.
|tip If you only want to complete the event, only the Fortify the Runestones quests are required.
|tip Other quests are for reputation only.
confirm |goto Eversong Woods M/0 42.84,46.72
stickystart "Defend_the_Runestone_1"
stickystart "Defend_the_Runestone_2"
stickystart "Defend_the_Runestone_3"
stickystart "Defend_the_Runestone_4"
step
click Fragrant Bloodthistle+
collect 5 Fragrant Bloodthistle##249472 |q 91999/1 |goto Eversong Woods M/0 41.20,38.44
|only if haveq(91999) or completedq(91999)
stickystart "Chastise_Tideborne"
step
kill Tideborne Deckwalker##239547, Tideborne Freight Runner##239549, Freight Barker##241909
click Smuggler's Satchel
|tip Dropped by enemies.
click Sack of Coins+
|tip Small bags.
collect 50 Tideborne Dubloon##249686 |q 91978/1 |goto Eversong Woods M/0 39.58,44.62
|only if haveq(91978) or completedq(91978)
step
label "Chastise_Tideborne"
kill Tideborne Deckwalker##239547, Tideborne Freight Runner##239549
Chastise #8# Tideborne |q 91977/1 |goto Eversong Woods M/0 39.32,44.49
|only if haveq(91977) or completedq(91977)
step
kill Tideborne Freighter##239521, Tideborne Smuggler##239519
collect 12 Naga Fang##249541 |q 92005/1 |goto Eversong Woods M/0 34.94,44.71
|only if haveq(92005) or completedq(92005)
step
kill Rampaging Ent##249635 |q 91979/1 |goto Eversong Woods M/0 37.27,54.88
|tip Runs around.
|only if haveq(91979) or completedq(91979)
step
kill Lightbloom Petalwing##237402, Light Wyrm##237408, Lightfed Growth##246523, Lightbloom Hydra##237414, Irradiant Thornmaw##240644, Lightbloom Lasher##237395
Slay Lightbloom Creatures |q 91976/1 |goto Eversong Woods M/0 42.09,55.89
|only if haveq(91976) or completedq(91976)
step
use the Holy Sunfire##249691
|tip Use it on enemies to get credit.
|tip They will burn and die in a few seconds.
kill Twilight Blade##242970, Twilight Shadecaster##242971, Heavy Caster##242972, Shadeling##242973
Purge #10# Twilight Intruders |q 91974/1 |goto Eversong Woods M/0 43.53,68.75
|only if haveq(91974) or completedq(91974)
step
clicknpc Scintillant Wyrm##241374+
Siphon #6# Scintillant Wyrms |q 89276/1 |goto Eversong Woods M/0 44.61,79.75
|only if haveq(89276) or completedq(89276)
step
talk Bloodguard Nelric##249566
Report In to Thalassian Pass |q 91972/1 |goto Eversong Woods M/0 48.34,88.50
|only if haveq(91972) or completedq(91972)
step
talk Bloodguard Nelric##249566
Select _"<Accept the assignment.>"_ |gossip 135242
Kill enemies that attack in waves
Hold the Watch |q 91972/2 |goto Eversong Woods M/0 48.34,88.50
|only if haveq(91972) or completedq(91972)
step
click Bright Feather+
collect 8 Bright Feather##249439 |q 91983/1 |goto Eversong Woods M/0 56.71,35.37
|only if haveq(91983) or completedq(91983)
step
label "Defend_the_Runestone_1"
click Runestone
|tip Any Runestone in Eversong Woods can be active.
|tip Open your map and fly to the active Runestone indicated by the quest marker.
|tip Collect Latent Arcana from nearby Coalesced Light.
|tip Turn it in to the Runestone until the scenario starts.
|tip You may need to wait until the timer expires to begin a new scenario.
|tip Kill enemies and click objects around the scenario area until the boss spawns.
|tip The boss is elite, so you will likely need a group.
Defend the Runestone |q 90573/2
|only if haveq(90573) or completedq(90573)
step
label "Defend_the_Runestone_2"
click Runestone
|tip Any Runestone in Eversong Woods can be active.
|tip Open your map and fly to the active Runestone indicated by the quest marker.
|tip Collect Latent Arcana from nearby Coalesced Light.
|tip Turn it in to the Runestone until the scenario starts.
|tip You may need to wait until the timer expires to begin a new scenario.
|tip Kill enemies and click objects around the scenario area until the boss spawns.
|tip The boss is elite, so you will likely need a group.
Defend the Runestone |q 90574/2
|only if haveq(90574) or completedq(90574)
step
label "Defend_the_Runestone_3"
click Runestone
|tip Any Runestone in Eversong Woods can be active.
|tip Open your map and fly to the active Runestone indicated by the quest marker.
|tip Collect Latent Arcana from nearby Coalesced Light.
|tip Turn it in to the Runestone until the scenario starts.
|tip You may need to wait until the timer expires to begin a new scenario.
|tip Kill enemies and click objects around the scenario area until the boss spawns.
|tip The boss is elite, so you will likely need a group.
Defend the Runestone |q 90574/2
|only if haveq(90574) or completedq(90574)
step
label "Defend_the_Runestone_4"
click Runestone
|tip Any Runestone in Eversong Woods can be active.
|tip Open your map and fly to the active Runestone indicated by the quest marker.
|tip Collect Latent Arcana from nearby Coalesced Light.
|tip Turn it in to the Runestone until the scenario starts.
|tip You may need to wait until the timer expires to begin a new scenario.
|tip Kill enemies and click objects around the scenario area until the boss spawns.
|tip The boss is elite, so you will likely need a group.
Defend the Runestone |q 90574/2
|only if haveq(90574) or completedq(90574)
step
talk Magistrix Bloodflame##240834
turnin Fortify the Runestones: Magisters##90573 |goto Eversong Woods M/0 42.62,46.16 |only if haveq(90573) or completedq(90573)
turnin Light Snacks##89276 |goto Eversong Woods M/0 42.62,46.16 |only if haveq(89276) or completedq(89276)
turnin Diminutive Demand##91993 |goto Eversong Woods M/0 42.62,46.16 |only if haveq(91993) or completedq(91993)
turnin Minding Our Duty##89278 |goto Eversong Woods M/0 42.62,46.16 |only if haveq(89278) or completedq(89278)
|only if haveq(90573,89276,91993,89278) or completedq(90573,89276,91993,89278)
step
talk Knight-Lord Sunguard##240835
turnin Less Lawless##91977 |goto Eversong Woods M/0 42.40,46.67 |only if haveq(91977) or completedq(91977)
turnin Hold the Watch##91972 |goto Eversong Woods M/0 42.40,46.67 |only if haveq(91972) or completedq(91972)
turnin Lightbloom Dimmed##91976 |goto Eversong Woods M/0 42.40,46.67 |only if haveq(91976) or completedq(91976)
turnin Fortify the Runestones: Blood Knights##90574 |goto Eversong Woods M/0 42.40,46.67 |only if haveq(90574) or completedq(90574)
turnin Sunfire to the Blade##91974 |goto Eversong Woods M/0 42.40,46.67 |only if haveq(91974) or completedq(91974)
turnin Chop It Down##91979 |goto Eversong Woods M/0 42.40,46.67 |only if haveq(91979) or completedq(91979)
turnin Taxing the Tideborne##91978 |goto Eversong Woods M/0 42.40,46.67 |only if haveq(91978) or completedq(91978)
|only if haveq(91977,91972,91976,90574,91974,91979,91978) or completedq(91977,91972,91976,90574,91974,91979,91978)
step
talk Ranger-Captain Dawnfletch##240836
turnin Lovely Plumage##91983 |goto Eversong Woods M/0 42.87,46.42 |only if haveq(91983) or completedq(91983)
turnin Fortify the Runestones: Farstriders##90575 |goto Eversong Woods M/0 42.87,46.42 |only if haveq(90575) or completedq(90575)
|only if haveq(91983,90575) or completedq(91983,90575)
step
talk Vyrin the Supplier##240837
turnin A Bit of Bloodthistle##91999 |goto Eversong Woods M/0 42.82,45.64 |only if haveq(91999) or completedq(91999)
turnin Throw the Dice##92005 |goto Eversong Woods M/0 42.82,45.64 |only if haveq(92005) or completedq(92005)
turnin Fortify the Runestones: Shades of the Row##90576 |goto Eversong Woods M/0 42.82,45.64 |only if haveq(90576) or completedq(90576)
|only if haveq(91999,92005,90576) or completedq(91999,92005,90576)
step
Complete "Fortify the Runestones" at Saltheril's Soiree |q 93930/1
|tip You should have this complete from previous steps.
|only if haveq(93930)
step
talk Caeris Fairdawn##240838
turnin Courting Success##93930 |goto Eversong Woods M/0 43.46,47.42
|only if haveq(93930)
step
|gossip 135478,135479
|tip Click objects around Saltheril's Haven that are highlighted.
|tip For NPCs, click wine glasses on nearby tables and talk to them to serve them refreshments.
|tip Refreshments can be served once.
|tip Speak to the NPC inside the building to choose a song.
Tend to the Soiree's Cleaning and Entertainment |q 91966/1 |goto Eversong Woods M/0 42.52,47.59
|only if haveq(91966) or completedq(91966)
step
Wait for the Next Reset |complete not completedq(89276,89278,89285,89289,89307,89311,89314,90573,"90574-90576",91972,91974,"91976-91979",91983,"91986-91988",91993,92000,92002,92005,92006,92007)
|tip More quests will be available at that time.
]])
ZGV.BETAEND()
