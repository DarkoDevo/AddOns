--[[
    Makulu Helper - Spell Database
    Sample spell data for demonstration
]]

MakuluHelper_SpellData = {
    -- Demon Hunter - Havoc
    {
        id = 162243,
        name = "Demon's Bite",
        class = "DEMONHUNTER",
        spec = "Havoc",
        icon = 1344650,
        description = "Quickly attack for Physical damage. Generates 20 to 30 Fury.",
        castTime = "Instant",
        cooldown = 0,
        range = 5,
        cost = "Generates 20-30 Fury",
        school = "Physical"
    },
    {
        id = 162794,
        name = "Chaos Strike",
        class = "DEMONHUNTER",
        spec = "Havoc",
        icon = 1305156,
        description = "Slice your target for Chaos damage. Chaos Strike has a 20% chance to refund 20 Fury.",
        castTime = "Instant",
        cooldown = 0,
        range = 5,
        cost = "40 Fury",
        school = "Chaos"
    },
    {
        id = 198013,
        name = "Eye Beam",
        class = "DEMONHUNTER",
        spec = "Havoc",
        icon = 1305156,
        description = "Blast all enemies in front of you for Chaos damage over 2 sec. Deals reduced damage beyond 5 targets.",
        castTime = "2 sec channel",
        cooldown = 30,
        range = 20,
        cost = "30 Fury",
        school = "Chaos"
    },
    {
        id = 191427,
        name = "Metamorphosis",
        class = "DEMONHUNTER",
        spec = "Havoc",
        icon = 1247262,
        description = "Transform to demon form for 30 sec, increasing Haste by 25% and Leech by 10%.",
        castTime = "Instant",
        cooldown = 240,
        range = 0,
        cost = "None",
        school = "Physical"
    },
    {
        id = 188499,
        name = "Blade Dance",
        class = "DEMONHUNTER",
        spec = "Havoc",
        icon = 1305149,
        description = "Quickly attack all nearby enemies for Physical damage.",
        castTime = "Instant",
        cooldown = 9,
        range = 8,
        cost = "35 Fury",
        school = "Physical"
    },
    {
        id = 195072,
        name = "Fel Rush",
        class = "DEMONHUNTER",
        spec = "Havoc",
        icon = 1247261,
        description = "Rush forward 20 yards, dealing Fire damage to all enemies in your path.",
        castTime = "Instant",
        cooldown = 10,
        range = 20,
        cost = "None",
        school = "Fire"
    },
    {
        id = 198793,
        name = "Vengeful Retreat",
        class = "DEMONHUNTER",
        spec = "Havoc",
        icon = 1348401,
        description = "Remove all snares and vault backwards. Deals Fire damage to all enemies within 8 yards.",
        castTime = "Instant",
        cooldown = 25,
        range = 0,
        cost = "None",
        school = "Fire"
    },
    
    -- Demon Hunter - Vengeance
    {
        id = 203782,
        name = "Shear",
        class = "DEMONHUNTER",
        spec = "Vengeance",
        icon = 1344648,
        description = "Strike the enemy, dealing Physical damage and generating 10 Fury.",
        castTime = "Instant",
        cooldown = 0,
        range = 5,
        cost = "Generates 10 Fury",
        school = "Physical"
    },
    {
        id = 228477,
        name = "Soul Cleave",
        class = "DEMONHUNTER",
        spec = "Vengeance",
        icon = 1344653,
        description = "Viciously strike up to 2 enemies in front of you for Physical damage and heal yourself.",
        castTime = "Instant",
        cooldown = 0,
        range = 8,
        cost = "30 Fury",
        school = "Physical"
    },
    {
        id = 204021,
        name = "Fiery Brand",
        class = "DEMONHUNTER",
        spec = "Vengeance",
        icon = 1344647,
        description = "Brand an enemy with a demonic symbol, reducing damage they deal to you by 40% for 8 sec.",
        castTime = "Instant",
        cooldown = 60,
        range = 30,
        cost = "None",
        school = "Fire"
    },
    {
        id = 187827,
        name = "Metamorphosis",
        class = "DEMONHUNTER",
        spec = "Vengeance",
        icon = 1247263,
        description = "Transform to demon form for 15 sec, increasing current and maximum health by 50%.",
        castTime = "Instant",
        cooldown = 180,
        range = 0,
        cost = "None",
        school = "Physical"
    },
    
    -- Defensive abilities
    {
        id = 198589,
        name = "Blur",
        class = "DEMONHUNTER",
        spec = "Both",
        icon = 1305150,
        description = "Blur your form, increasing dodge chance by 20% for 10 sec.",
        castTime = "Instant",
        cooldown = 60,
        range = 0,
        cost = "None",
        school = "Physical"
    }
}

-- Add more spells here as needed
-- This is a sample dataset. In production, you would include all relevant spells

