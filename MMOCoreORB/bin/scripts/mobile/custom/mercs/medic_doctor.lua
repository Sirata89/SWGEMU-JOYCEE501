merc_medic_doctor = Creature:new {
    objectName = "@mob/creature_names:medic",
    customName = "Field Doctor",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 55,
    chanceHit = 0.58,
    damageMin = 320,
    damageMax = 480,
    baseXp = 12000,
    baseHAM = 8000,
    baseHAMmax = 9500,
    armor = 3,
    resists = {45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK + HEALER,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_medic_trainer_01.iff",
        "object/mobile/dressed_medic_trainer_02.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_medium",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    attacks = merge(marksmannovice,medicmaster)
}

CreatureTemplates:addCreatureTemplate(merc_medic_doctor, "merc_medic_doctor")
