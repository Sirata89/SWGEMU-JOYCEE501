bounty_hunter_merc = Creature:new {
    objectName = "@mob/creature_names:bounty_hunter",
    customName = "Bounty Hunter Mercenary",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 75,
    chanceHit = 0.75,
    damageMin = 650,
    damageMax = 950,
    baseXp = 12000,
    baseHAM = 7000,
    baseHAMmax = 8200,
    armor = 2,
    resists = {85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_bountyhunter_trainer_01.iff",
        "object/mobile/dressed_bountyhunter_trainer_02.iff",
        "object/mobile/dressed_bountyhunter_trainer_03.iff"
    },

    lootGroups = {},
    primaryWeapon = "pirate_weapons_medium",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(bountyhuntermaster,marksmanmaster,brawlermaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(bounty_hunter_merc, "bounty_hunter_merc")
