commoner_guard = Creature:new {
    objectName = "@mob/creature_names:commoner",
    customName = "Commoner Guard",
    socialGroup = "townsperson",
    faction = "neutral",
    level = 18,
    chanceHit = 0.35,
    damageMin = 100,
    damageMax = 180,
    baseXp = 1200,
    baseHAM = 3200,
    baseHAMmax = 3700,
    armor = 0,
    resists = {12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_commoner_old_human_male_01.iff",
        "object/mobile/dressed_commoner_old_human_female_01.iff",
        "object/mobile/dressed_commoner_twk_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    attacks = merge(marksmannovice)
}

CreatureTemplates:addCreatureTemplate(commoner_guard, "commoner_guard")
