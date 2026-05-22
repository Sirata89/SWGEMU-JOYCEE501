merc_imperial_defector = Creature:new {
    objectName = "@mob/creature_names:stormtrooper",
    customName = "Imperial Defector",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 58,
    chanceHit = 0.63,
    damageMin = 420,
    damageMax = 680,
    baseXp = 6500,
    baseHAM = 5000,
    baseHAMmax = 5900,
    armor = 1,
    resists = {52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_stormtrooper_m.iff",
        "object/mobile/dressed_stormtrooper_sand_trooper_m.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "stormtrooper_weapons",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(brawlermaster,marksmanmaster,riflemanmaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(merc_imperial_defector, "merc_imperial_defector")
