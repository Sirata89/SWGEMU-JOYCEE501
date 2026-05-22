merc_medic_corpsman = Creature:new {
    objectName = "@mob/creature_names:medic",
    customName = "Medic Corpsman",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 38,
    chanceHit = 0.45,
    damageMin = 180,
    damageMax = 280,
    baseXp = 4000,
    baseHAM = 4800,
    baseHAMmax = 5800,
    armor = 1,
    resists = {25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK + HEALER,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_mercenary_elite_medic_human_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(brawlermaster,marksmanmaster,medicmaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(merc_medic_corpsman, "merc_medic_corpsman")
