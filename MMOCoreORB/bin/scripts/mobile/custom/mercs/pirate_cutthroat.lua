merc_pirate_cutthroat = Creature:new {
    objectName = "@mob/creature_names:pirate",
    customName = "Pirate Cutthroat",
    socialGroup = "pirate",
    faction = "neutral",
    level = 55,
    chanceHit = 0.60,
    damageMin = 400,
    damageMax = 650,
    baseXp = 6000,
    baseHAM = 5200,
    baseHAMmax = 6100,
    armor = 1,
    resists = {50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_criminal_pirate_human_male_01.iff",
        "object/mobile/dressed_criminal_pirate_human_female_01.iff",
        "object/mobile/dressed_criminal_pirate_rodian_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    attacks = merge(brawlermid,marksmanmid)
}

CreatureTemplates:addCreatureTemplate(merc_pirate_cutthroat, "merc_pirate_cutthroat")
