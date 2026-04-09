-- ======================= EN (base) ==========================================
STRINGS_EN = {

  -- App name
  app_title = "WoW Memory+",

  -- Header / Top bar
  btn_refresh = "Refresh",
  btn_todo = "To-Do",
  btn_export = "Export",
  btn_options = "Options",
  search_quests_tip = "Filter quests (tab 'Active Quests')",

  -- Minimap tooltip
  mini_title = "WoW Memory+",
  mini_left = "Left: open/close",
  mini_right = "Right: options",
  mini_wheel = "Wheel: switch tab",
  mini_shift = "Shift+Wheel: UI zoom",
  mini_shown_print_on  = "WoW Memory+: minimap button shown.",
  mini_shown_print_off = "WoW Memory+: minimap button hidden.",

  -- Tabs
  tab_dungeons = "Dungeons / Raids",
  tab_week     = "This Week",
  tab_quests   = "Active Quests",
  tab_resources= "Resources",
  tab_worldq   = "World Quests",
  tab_chars    = "Characters",
  tab_journal  = "Journal",
  tab_collect  = "Collections",
  tab_calendar = "Calendar",
  tab_ah       = "Auctions",

  -- Dungeons / Raids
  dr_locked_title = "Locked Dungeons / Raids",
  dr_none = "No locked instance found.",
  dr_affixes = "Current affixes:",
  dr_best = "Best completed key:",
  dr_keystone_owned = "Owned keystone:",
  dr_keystone_none  = "Owned keystone: —",
  dr_reset_in = "reset in ",

  -- This Week
  week_title = "This Week",
  week_reset = "Reset:",
  week_vault_title = "Great Vault",
  week_row_raids = "Raids",
  week_row_mplus = "Dungeons (Mythic+)",
  week_row_world = "World (Delves)",
  week_best_mplus_title = "Best Mythic+ this week",
  week_pip_done  = "[✓]",
  week_pip_todo  = "[ ]",

  -- Quests
  quests_title = "Active Quests",
  quests_zone  = "Zone:",
  quests_none_filter = "No quest matches the filter.",
  quests_none_any    = "No active quest found.",
  quests_ctx_super   = "Super-track",
  quests_ctx_openmap = "Open map",

  -- Resources
  res_title = "Economy & Resources (cross-characters)",
  res_gold_hist = "Gold history (latest)",
  res_totals = "Account totals",
  res_total_gold = "Total gold — ",
  res_currencies = "Currencies — ",
  res_materials  = "Materials — ",
  res_threshold  = "threshold",
  res_wealth_rank = "Wealth ranking (gold)",
  res_none = "No data.",
  res_arrow_total = "→ total",

  -- Collections (Goals)
  col_title = "Collections Goals",
  col_mounts = "Mounts",
  col_toys   = "Toys",
  col_pets   = "Pets",
  col_owned  = "Owned",
  col_missing= "Missing",
  col_empty  = "No list set. Go to Options → Collections to add IDs.",

  -- Calendar
  cal_title = "Upcoming events (current month)",
  cal_api_missing = "Calendar API unavailable on this client.",
  cal_tail = "→ end of month",
  cal_none = "No event found (current month).",

  -- World Quests
  wq_title = "Active World Quests",
  wq_scan_zone  = "Scan Zone",
  wq_scan_world = "Scan World",
  wq_time_left  = "Time left:",
  wq_reward     = "Reward:",
  wq_go         = "Go",
  wq_none       = "No world quest detected.",

  -- Characters
  ch_title = "Multi-Character Summary",
  ch_sort_btn = "Sort:",
  ch_sort_ilvl = "iLvl",
  ch_sort_name = "Name",
  ch_sort_level= "Level",
  ch_total_gold = "Total gold (all characters) — ",
  ch_profs = "Professions:",
  ch_vault = "Vault R:%d/%d M+:%d/%d PvP:%d/%d",
  ch_worldboss = "World Boss:",
  ch_ok = "OK",

  -- Journal
  jr_title = "Activity Journal",
  jr_type  = "Type:",
  jr_type_all   = "All",
  jr_type_quest = "Quests",
  jr_type_boss  = "Boss",
  jr_type_mplus = "M+",
  jr_char = "Character:",
  jr_period = "Range:",
  jr_p_24h = "24h",
  jr_p_7d  = "7d",
  jr_p_30d = "30d",
  jr_p_all = "All",
  jr_none = "No activity for the current filters.",
  jr_quest_turnin = "Quest turned in:",
  jr_boss_kill    = "Boss killed:",
  jr_mplus_done   = "Mythic+ completed",

  -- Export
  xp_title = "WoW Memory+ — Summary",
  xp_char  = "Character: %s-%s (lvl %s, iLvl %s)",
  xp_vault = "Vault: Raid %d/%d | M+ %d/%d | PvP %d/%d",
  xp_best  = "Best M+ key (this week): +%s",
  xp_wboss = "World Boss:",
  xp_gold  = "Gold:",
  xp_active_quests = "Active quests:",

  -- Options – nav
  opt_nav_general     = "General",
  opt_nav_appearance  = "Appearance",
  opt_nav_refresh     = "Refresh",
  opt_nav_economy     = "Economy",
  opt_nav_collections = "Collections",
  opt_nav_advanced    = "Advanced",

  -- Options – General
  opt_mini = "Show minimap button",
  opt_show_ilvl = "Show iLvl in 'Characters'",
  opt_compact = "Compact mode (reduced spacing)",
  opt_seconds = "Show seconds in durations",

  opt_tabs       = "Visible tabs",
  opt_nav_window = "Window",
  opt_window_lock   = "Lock window position",
  opt_window_center = "Center window",
  opt_window_size   = "Default size",

  -- Options – Appearance
  opt_alpha = "Background opacity",
  opt_scale = "UI scale",
  opt_font  = "Font size",
  opt_accent = "Accent color : ▾",
  opt_accent_gold   = "Gold",
  opt_accent_blue   = "Blue",
  opt_accent_purple = "Purple",
  opt_accent_emerald= "Emerald",
  opt_accent_red="Red", 
  opt_accent_orange="Orange", 
  opt_accent_teal="Teal", 
  opt_accent_pink="Pink", 
  opt_accent_gray="Gray",

  -- Options – Refresh
  opt_mode_smart = "Mode: Smart",
  opt_mode_rt    = "Real-time",
  opt_mode_manual= "Manual",
  opt_every_sec  = "Every X seconds (real-time)",

  -- Options – Economy
  opt_currencies = "Currency IDs (e.g. 1602,1792)",
  opt_mats       = "Materials (itemID:threshold, ...)",

  -- Options – Collections
  opt_col_mounts = "Mounts (IDs)",
  opt_col_toys   = "Toys (IDs)",
  opt_col_pets   = "Pets (Species IDs)",

  -- Options – Advanced
  opt_reset_addon = "Reset addon",
  opt_purge_profile = "Purge DB (current profile)",

  -- Auction House tab (owner auctions)
  ah_title = "Auctions (My listings)",
  ah_last_scan = "Last scan:",
  ah_never = "never",
  ah_btn_rescan = "Rescan",
  ah_auto    = "Auto",
  ah_manual  = "Manual",
  ah_cols_item = "Item",
  ah_cols_qty  = "Qty",
  ah_cols_unit = "Unit",
  ah_cols_buy  = "Buyout",
  ah_cols_time = "Time left",
  ah_cols_stat = "Status",
  ah_none = "No current auctions.",
  ah_need_visit = "Visit the Auction House once to enable scanning.",
}

-- ======================= FR (overlay) =======================================
STRINGS_FR = {
  app_title = "WoW Memory+",

  btn_refresh = "Rafraîchir",
  btn_todo = "To-Do",
  btn_export = "Exporter",
  btn_options = "Options",
  search_quests_tip = "Filtrer les quêtes (onglet 'Quêtes en cours')",

  mini_title = "WoW Memory+",
  mini_left = "Gauche : ouvrir/fermer",
  mini_right = "Droit : options",
  mini_wheel = "Molette : changer d’onglet",
  mini_shift = "Shift+Molette : zoom interface",
  mini_shown_print_on  = "WoW Memory+ : bouton minimap affiché.",
  mini_shown_print_off = "WoW Memory+ : bouton minimap caché.",

  tab_dungeons = "Donjons / Raids",
  tab_week     = "Semaine en cours",
  tab_quests   = "Quêtes en cours",
  tab_resources= "Ressources",
  tab_worldq   = "World Quests",
  tab_chars    = "Personnages",
  tab_journal  = "Journal",
  tab_collect  = "Collections",
  tab_calendar = "Calendrier",
  tab_ah       = "HDV",

  dr_locked_title = "Donjons / Raids verrouillés",
  dr_none = "Aucun donjon verrouillé trouvé.",
  dr_affixes = "Affixes actuels :",
  dr_best = "Meilleure clé validée :",
  dr_keystone_owned = "Pierre détenue :",
  dr_keystone_none  = "Pierre détenue : —",
  dr_reset_in = "reset dans ",

  week_title = "Semaine en cours",
  week_reset = "Réinitialisation :",
  week_vault_title = "Grand Coffre (Great Vault)",
  week_row_raids = "Raids",
  week_row_mplus = "Donjons (Mythique+)",
  week_row_world = "Monde (Gouffres)",
  week_best_mplus_title = "Meilleure clé M+ de la semaine",
  week_pip_done  = "[✓]",
  week_pip_todo  = "[ ]",

  quests_title = "Quêtes en cours",
  quests_zone  = "Zone :",
  quests_none_filter = "Aucune quête ne correspond au filtre.",
  quests_none_any    = "Aucune quête active détectée.",
  quests_ctx_super   = "Super-tracker",
  quests_ctx_openmap = "Ouvrir la carte",

  res_title = "Économie & Ressources (cross-personnages)",
  res_gold_hist = "Historique d'or (récents)",
  res_totals = "Totaux compte",
  res_total_gold = "Or total — ",
  res_currencies = "Devises — ",
  res_materials  = "Matériaux — ",
  res_threshold  = "seuil",
  res_wealth_rank= "Classement richesse (or)",
  res_none = "Aucune donnée.",
  res_arrow_total = "→ total",

  col_title = "Objectifs Collections",
  col_mounts = "Montures",
  col_toys   = "Jouets",
  col_pets   = "Mascottes",
  col_owned  = "Possédé",
  col_missing= "Manque",
  col_empty  = "Aucune liste renseignée. Va dans Options → Collections pour ajouter des IDs.",

  cal_title = "Évènements à venir (mois en cours)",
  cal_api_missing = "API calendrier indisponible sur ce client.",
  cal_tail = "→ fin de mois",
  cal_none = "Aucun évènement trouvé (mois courant).",

  wq_title = "World Quests actives",
  wq_scan_zone  = "Scan Zone",
  wq_scan_world = "Scan Monde",
  wq_time_left  = "Temps restant :",
  wq_reward     = "Récompense :",
  wq_go         = "Aller",
  wq_none       = "Aucune world quest détectée.",

  ch_title = "Résumé multi-personnages",
  ch_sort_btn = "Tri :",
  ch_sort_ilvl = "iLvl",
  ch_sort_name = "Nom",
  ch_sort_level= "Niveau",
  ch_total_gold = "Or total (tous personnages) — ",
  ch_profs = "Métiers :",
  ch_vault = "Vault R:%d/%d M+:%d/%d PvP:%d/%d",
  ch_worldboss = "World Boss :",
  ch_ok = "OK",

  jr_title = "Journal d’activités",
  jr_type  = "Type :",
  jr_type_all   = "Tous",
  jr_type_quest = "Quêtes",
  jr_type_boss  = "Boss",
  jr_type_mplus = "M+",
  jr_char = "Perso :",
  jr_period = "Période :",
  jr_p_24h = "24h",
  jr_p_7d  = "7j",
  jr_p_30d = "30j",
  jr_p_all = "Tout",
  jr_none = "Aucune activité pour les filtres actuels.",
  jr_quest_turnin = "Quête rendue :",
  jr_boss_kill    = "Boss tué :",
  jr_mplus_done   = "Donjon M+ complété",

  xp_title = "WoW Memory+ — Résumé",
  xp_char  = "Perso : %s-%s (niv %s, iLvl %s)",
  xp_vault = "Vault : Raid %d/%d | M+ %d/%d | PvP %d/%d",
  xp_best  = "Meilleure clé M+ (semaine) : +%s",
  xp_wboss = "World Boss :",
  xp_gold  = "Or :",
  xp_active_quests = "Quêtes actives :",

  opt_nav_general     = "Général",
  opt_nav_appearance  = "Apparence",
  opt_nav_refresh     = "Rafraîchissement",
  opt_nav_economy     = "Économie",
  opt_nav_collections = "Collections",
  opt_nav_advanced    = "Avancé",

  opt_mini = "Afficher le bouton minimap",
  opt_show_ilvl = "Afficher l'iLvl dans 'Personnages'",
  opt_compact = "Mode compact (espacements réduits)",
  opt_seconds = "Durées avec secondes",

  opt_tabs       = "Onglets visibles",
  opt_nav_window = "Fenêtre",
  opt_window_lock   = "Verrouiller la fenêtre",
  opt_window_center = "Centrer la fenêtre",
  opt_window_size   = "Taille par défaut",

  opt_alpha = "Opacité du fond",
  opt_scale = "Échelle de l'interface",
  opt_font  = "Taille du texte",
  opt_accent = "Couleur d'accent : ▾",
  opt_accent_gold   = "Gold",
  opt_accent_blue   = "Blue",
  opt_accent_purple = "Purple",
  opt_accent_emerald= "Emerald",
  opt_accent_red="Rouge", 
  opt_accent_orange="Orange", 
  opt_accent_teal="Turquoise", 
  opt_accent_pink="Rose", 
  opt_accent_gray="Gris",

  opt_mode_smart = "Mode : Smart",
  opt_mode_rt    = "Temps réel",
  opt_mode_manual= "Manuel",
  opt_every_sec  = "Toutes les X secondes (temps réel)",

  opt_currencies = "IDs de devises (ex: 1602,1792)",
  opt_mats       = "Matériaux (itemID:seuil, ...)",

  opt_col_mounts = "Montures (IDs)",
  opt_col_toys   = "Jouets (IDs)",
  opt_col_pets   = "Mascottes (Species IDs)",

  opt_reset_addon = "Réinitialiser l’addon",
  opt_purge_profile = "Purger la base (profil courant)",

  ah_title = "HDV (Mes ventes)",
  ah_last_scan = "Dernier scan :",
  ah_never = "jamais",
  ah_btn_rescan = "Rescan",
  ah_auto    = "Auto",
  ah_manual  = "Manuel",
  ah_cols_item = "Objet",
  ah_cols_qty  = "Qté",
  ah_cols_unit = "Unitaire",
  ah_cols_buy  = "Achat im.",
  ah_cols_time = "Durée",
  ah_cols_stat = "Statut",
  ah_none = "Aucune enchère en cours.",
  ah_need_visit = "Visite l’Hôtel des ventes une fois pour activer le scan.",
}

-- ===== Compatibility keys used by the language module (don't remove) =====
-- EN
STRINGS_EN.APP_NAME         = STRINGS_EN.app_title
STRINGS_EN.LANGUAGE         = "Language"
STRINGS_EN.LANGUAGE_AUTO    = "Auto (match client)"
STRINGS_EN.LANGUAGE_FRENCH  = "French (FR)"
STRINGS_EN.LANGUAGE_ENGLISH = "English (EN)"
STRINGS_EN.LANGUAGE_SET     = "Language set to: %s"
STRINGS_EN.CMD_HELP         = "Commands: /memory options | /memory lang en|fr|auto"
STRINGS_EN.OPEN_OPTIONS_TIP = "Open options"

-- FR
STRINGS_FR.APP_NAME         = STRINGS_FR.app_title
STRINGS_FR.LANGUAGE         = "Langue"
STRINGS_FR.LANGUAGE_AUTO    = "Auto (selon le client)"
STRINGS_FR.LANGUAGE_FRENCH  = "Français (FR)"
STRINGS_FR.LANGUAGE_ENGLISH = "Anglais (EN)"
STRINGS_FR.LANGUAGE_SET     = "Langue définie sur : %s"
STRINGS_FR.CMD_HELP         = "Commandes : /memory options | /memory lang en|fr|auto"
STRINGS_FR.OPEN_OPTIONS_TIP = "Ouvrir les options"
