rodian_mercenary = Creature:new {
    objectName = "@mob/creature_names:rodian_mercenary",
    customName = "Rodian Mercenary",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 48,
    chanceHit = 0.55,
    damageMin = 350,
    damageMax = 580,
    baseXp = 5000,
    baseHAM = 4200,
    baseHAMmax = 5000,
    armor = 1,
    resists = {45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_criminal_thug_rodian_male_01.iff",
        "object/mobile/dressed_criminal_thug_rodian_female_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(brawlermaster,marksmanmaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(rodian_mercenary, "rodian_mercenary")
