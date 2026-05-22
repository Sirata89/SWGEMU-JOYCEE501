generic_merc = Creature:new {
    objectName = "@mob/creature_names:commoner",
    customName = "Hired Mercenary",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 45,
    chanceHit = 0.52,
    damageMin = 320,
    damageMax = 520,
    baseXp = 4500,
    baseHAM = 4000,
    baseHAMmax = 4800,
    armor = 1,
    resists = {40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_mercenary_weak_hum_m.iff",
        "object/mobile/dressed_mercenary_weak_hum_f.iff",
        "object/mobile/dressed_mercenary_weak_rod_m.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    attacks = merge(marksmannovice,brawlernovice)
}

CreatureTemplates:addCreatureTemplate(generic_merc, "generic_merc")