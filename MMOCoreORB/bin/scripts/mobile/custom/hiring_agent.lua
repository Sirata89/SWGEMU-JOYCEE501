hiring_agent= Creature:new {
    objectName = "@mob/creature_names:twilek_female",   -- or male
    customName = "Hiring Agent",
    socialGroup = "townsperson",
    faction = "neutral",
    level = 777,
    chanceHit = 0.35,
    damageMin = 200,
    damageMax = 350,
    baseXp = 2500,
    baseHAM = 2200,
    baseHAMmax = 2800,
    armor = 0,
    resists = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    optionsBitmask = 264,          -- Conversation + Vendor
    pvpBitmask = NONE,
    creatureBitmask = NONE,
    diet = HERBIVORE,
    templates = {"object/mobile/twilek_female.iff"},   -- Change to your favorite twilek outfit
    lootGroups = {},
    weapons = {},
    conversationTemplate = "hiring_agent_convo_template",
    attacks = {}
}

CreatureTemplates:addCreatureTemplate(hiring_agent, "hiring_agent")