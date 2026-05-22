-- Pathfinder's Gloves (Tier 3) - Improved grip and weapon handling
-- Designed for solo players to enhance combat effectiveness

scout_gloves_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Pathfinder's Gloves",
	directObjectTemplate = "object/tangible/wearables/base/base_gloves.lua",
	craftingValues = {
		{"melee_defense", 5, 20, 0},
		{"ranged_defense", 5, 20, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("scout_gloves_tier3", scout_gloves_tier3)
