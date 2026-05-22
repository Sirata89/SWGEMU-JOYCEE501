merc_medic_surgeon = Creature:new {
    objectName = "@mob/creature_names:medic",
    customName = "Combat Surgeon",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 48,
    chanceHit = 0.52,
    damageMin = 250,
    damageMax = 380,
    baseXp = 7500,
    baseHAM = 6500,
    baseHAMmax = 7800,
    armor = 2,
    resists = {35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK + HEALER,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_combatmedic_trainer_human_male_01.iff",
        "object/mobile/dressed_combatmedic_trainer_rodian_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_medium",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(brawlermaster,marksmanmaster,medicmaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(merc_medic_surgeon, "merc_medic_surgeon")
