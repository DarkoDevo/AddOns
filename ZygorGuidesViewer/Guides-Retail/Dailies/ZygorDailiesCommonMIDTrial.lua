local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if ZGV:DoMutex("DailiesCMID") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
ZygorGuidesViewer:RegisterGuidePlaceholder("Daily Guides\\Midnight\\World Quests\\Eversong Woods World Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Daily Guides\\Midnight\\World Quests\\Harandar World Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Daily Guides\\Midnight\\World Quests\\Voidstorm World Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Daily Guides\\Midnight\\World Quests\\Zul'Aman World Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Daily Guides\\The War Within (70-80)\\Special Missions Locked")
ZGV.BETASTART()
ZygorGuidesViewer:RegisterGuidePlaceholder("Daily Guides\\Midnight\\Saltheril's Haven Weelkies")
ZGV.BETAEND()
