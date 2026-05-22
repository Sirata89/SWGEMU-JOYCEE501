merc_field_medic = Creature:new {
    objectName = "@mob/creature_names:medic",
    customName = "Field Medic",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 35,
    chanceHit = 0.42,
    damageMin = 150,
    damageMax = 250,
    baseXp = 3500,
    baseHAM = 4500,
    baseHAMmax = 5500,
    armor = 1,
    resists = {20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK + HEALER,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_mercenary_medic_rodian_female_01.iff",
        "object/mobile/dressed_mercenary_elite_medic_human_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(brawlermaster,marksmanmaster,medicmid),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(merc_field_medic, "merc_field_medic")
