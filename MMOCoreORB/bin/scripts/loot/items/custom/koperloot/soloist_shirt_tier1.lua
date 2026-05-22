-- Scout's Tunic (Tier 1) - Provides health/action/mind bonuses
-- Designed for solo players to increase their HAM pools

soloist_shirt_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Scout's Tunic",
	directObjectTemplate = "object/tangible/wearables/shirt/shirt_s09.iff",
	craftingValues = {
		{"health", 10, 50, 0},
		{"action", 10, 50, 0},
		{"mind", 10, 50, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("soloist_shirt_tier1", soloist_shirt_tier1)
