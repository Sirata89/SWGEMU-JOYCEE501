elite_commando = Creature:new {
    objectName = "@mob/creature_names:commando",
    customName = "Elite Commando",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 90,
    chanceHit = 0.90,
    damageMin = 900,
    damageMax = 1200,
    baseXp = 20000,
    baseHAM = 8500,
    baseHAMmax = 9800,
    armor = 3,
    resists = {90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_commando_trainer_human_male_01.iff",
        "object/mobile/dressed_commando_trainer_rodian_male_01.iff",
        "object/mobile/dressed_commando_trainer_trandoshan_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_heavy",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    attacks = merge(commandomaster,marksmanmaster)
}

CreatureTemplates:addCreatureTemplate(elite_commando, "elite_commando")
