mandalorian_scout = Creature:new {
    objectName = "@mob/creature_names:mandalorian",
    customName = "Mandalorian Scout",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 80,
    chanceHit = 0.80,
    damageMin = 750,
    damageMax = 1050,
    baseXp = 15000,
    baseHAM = 7500,
    baseHAMmax = 8800,
    armor = 2,
    resists = {88,88,88,88,88,88,88,88,88,88,88,88,88,88,88,88},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_mand_bunker_crazed_miner.iff",
        "object/mobile/dressed_mand_bunker_technician.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_heavy",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(commandomaster,marksmanmaster,brawlermaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(mandalorian_scout, "mandalorian_scout")
