scavenger_hunter = Creature:new {
    objectName = "@mob/creature_names:scavenger",
    customName = "Scavenger Hunter",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 22,
    chanceHit = 0.40,
    damageMin = 130,
    damageMax = 220,
    baseXp = 1600,
    baseHAM = 3400,
    baseHAMmax = 3900,
    armor = 0,
    resists = {15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_criminal_thug_human_male_01.iff",
        "object/mobile/dressed_criminal_thug_rodian_male_01.iff",
        "object/mobile/dressed_criminal_thug_bothan_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    attacks = merge(marksmannovice,brawlernovice)
}

CreatureTemplates:addCreatureTemplate(scavenger_hunter, "scavenger_hunter")
