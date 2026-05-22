merc_captain = Creature:new {
    objectName = "@mob/creature_names:mercenary",
    customName = "Mercenary Captain",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 65,
    chanceHit = 0.70,
    damageMin = 500,
    damageMax = 750,
    baseXp = 8000,
    baseHAM = 6000,
    baseHAMmax = 7000,
    armor = 2,
    resists = {60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_mercenary_elite_hum_m.iff",
        "object/mobile/dressed_mercenary_elite_rod_m.iff",
        "object/mobile/dressed_mercenary_elite_nikto_m.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_medium",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(brawlermaster,marksmanmaster,carbineermaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(merc_captain, "merc_captain")
