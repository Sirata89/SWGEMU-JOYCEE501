dark_jedi_acolyte = Creature:new {
    objectName = "@mob/creature_names:dark_jedi_knight",
    customName = "Dark Jedi Acolyte",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 55,
    chanceHit = 0.62,
    damageMin = 420,
    damageMax = 680,
    baseXp = 6500,
    baseHAM = 5200,
    baseHAMmax = 6100,
    armor = 1,
    resists = {52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_dark_jedi_human_male_01.iff",
        "object/mobile/dressed_dark_jedi_human_female_01.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "lightsaber_weapons",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(lightsabermaster,forcepowermaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(dark_jedi_acolyte, "dark_jedi_acolyte")
