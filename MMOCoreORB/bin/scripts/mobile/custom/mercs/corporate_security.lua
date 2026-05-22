corporate_security = Creature:new {
    objectName = "@mob/creature_names:corsec_agent",
    customName = "Corporate Security",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 60,
    chanceHit = 0.65,
    damageMin = 450,
    damageMax = 700,
    baseXp = 7000,
    baseHAM = 5500,
    baseHAMmax = 6400,
    armor = 1,
    resists = {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_corsec_captain_human_male_01.iff",
        "object/mobile/dressed_corsec_sergeant_human_male_01.iff",
        "object/mobile/dressed_corsec_pilot_human_male_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(brawlermaster,marksmanmaster,carbineermaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(corporate_security, "corporate_security")
