-- Scout's Gloves (Tier 1) - Improved grip and weapon handling
-- Designed for solo players to enhance combat effectiveness

scout_gloves_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Scout's Gloves",
	directObjectTemplate = "object/tangible/wearables/base/base_gloves.lua",
	craftingValues = {
		{"melee_defense", 1, 3, 0},
		{"ranged_defense", 1, 3, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("scout_gloves_tier1", scout_gloves_tier1)
