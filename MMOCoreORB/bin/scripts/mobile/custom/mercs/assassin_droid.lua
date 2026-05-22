assassin_droid = Creature:new {
    objectName = "@mob/creature_names:ig_assassin_droid",
    customName = "Assassin Droid",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 78,
    chanceHit = 0.78,
    damageMin = 700,
    damageMax = 1000,
    baseXp = 14000,
    baseHAM = 7200,
    baseHAMmax = 8500,
    armor = 3,
    resists = {87,87,87,87,87,87,87,87,87,87,87,87,87,87,87,87},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = NONE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/ig_assassin_droid.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "battle_droid_weapons",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(brawlermaster,marksmanmaster),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(assassin_droid, "assassin_droid")
