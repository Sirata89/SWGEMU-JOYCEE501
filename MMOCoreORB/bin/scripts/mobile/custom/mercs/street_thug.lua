street_thug = Creature:new {
    objectName = "@mob/creature_names:thug",
    customName = "Street Thug",
    socialGroup = "thug",
    faction = "neutral",
    level = 15,
    chanceHit = 0.30,
    damageMin = 80,
    damageMax = 150,
    baseXp = 1000,
    baseHAM = 3000,
    baseHAMmax = 3500,
    armor = 0,
    resists = {10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_criminal_thug_human_male_01.iff",
        "object/mobile/dressed_criminal_thug_zabrak_male_01.iff",
        "object/mobile/dressed_criminal_thug_rodian_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "melee_weapons",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    attacks = merge(brawlernovice)
}

CreatureTemplates:addCreatureTemplate(street_thug, "street_thug")
