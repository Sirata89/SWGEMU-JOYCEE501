generic_merc = Creature:new {
    objectName = "@mob/creature_names:commoner",           -- base name
    customName = "Hired Mercenary",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 30,                                            -- will be scaled later if you want
    chanceHit = 0.45,
    damageMin = 180,
    damageMax = 320,
    baseXp = 2800,
    baseHAM = 2400,
    baseHAMmax = 3000,
    armor = 0,
    resists = {20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20}, -- light resists
    optionsBitmask = 264,                                  -- 256 (attackable) + 8 (conversation)
    pvpBitmask = ATTACKABLE,
    creatureBitmask = NONE,
    diet = HERBIVORE,
    
    -- Visuals - change these for different looks
    templates = {
        "object/mobile/dressed_mercenary_human_male_01.iff",
        "object/mobile/dressed_mercenary_human_female_01.iff",
        "object/mobile/dressed_mercenary_human_male_02.iff"
    },
    
    lootGroups = {},
    weapons = {"ranged_weapons"},                          -- uses generic ranged weapon pool
    conversationTemplate = "",                             -- empty for companions
    attacks = {}
}

CreatureTemplates:addCreatureTemplate(generic_merc, "generic_merc")