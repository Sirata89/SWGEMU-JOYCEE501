-- Ranger's Gloves (Tier 2) - Improved grip and weapon handling
-- Designed for solo players to enhance combat effectiveness

scout_gloves_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Ranger's Gloves",
	directObjectTemplate = "object/tangible/wearables/base/base_gloves.lua",
	craftingValues = {
		{"melee_defense", 3, 10, 0},
		{"ranged_defense", 3, 10, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("scout_gloves_tier2", scout_gloves_tier2)
