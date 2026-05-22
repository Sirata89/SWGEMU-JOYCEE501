merc_medic_apprentice = Creature:new {
    objectName = "@mob/creature_names:medic",
    customName = "Medic Apprentice",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 20,
    chanceHit = 0.38,
    damageMin = 120,
    damageMax = 200,
    baseXp = 1800,
    baseHAM = 3500,
    baseHAMmax = 4200,
    armor = 0,
    resists = {15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK + HEALER,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_mercenary_medic_rodian_female_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(brawlermid,marksmanmid,medicmid),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(merc_medic_apprentice, "merc_medic_apprentice")
