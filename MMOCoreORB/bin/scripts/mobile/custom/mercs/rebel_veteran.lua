rebel_veteran = Creature:new {
    objectName = "@mob/creature_names:rebel_soldier",
    customName = "Rebel Veteran",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 56,
    chanceHit = 0.62,
    damageMin = 410,
    damageMax = 670,
    baseXp = 6200,
    baseHAM = 4800,
    baseHAMmax = 5600,
    armor = 1,
    resists = {51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_rebel_scout_human_male_01.iff",
        "object/mobile/dressed_rebel_scout_human_female_01.iff",
        "object/mobile/dressed_rebel_scout_rodian_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "rebel_weapons_medium",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    attacks = merge(brawlermid,marksmanmid)
}

CreatureTemplates:addCreatureTemplate(rebel_veteran, "rebel_veteran")
