rogue_smuggler = Creature:new {
    objectName = "@mob/creature_names:smuggler",
    customName = "Rogue Smuggler",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 52,
    chanceHit = 0.58,
    damageMin = 380,
    damageMax = 620,
    baseXp = 5500,
    baseHAM = 4500,
    baseHAMmax = 5300,
    armor = 1,
    resists = {48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/dressed_smuggler_trainer_01.iff",
        "object/mobile/dressed_smuggler_trainer_02.iff",
        "object/mobile/dressed_smuggler_trainer_03.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "pirate_weapons_light",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    attacks = merge(brawlernovice,marksmanmid)
}

CreatureTemplates:addCreatureTemplate(rogue_smuggler, "rogue_smuggler")
