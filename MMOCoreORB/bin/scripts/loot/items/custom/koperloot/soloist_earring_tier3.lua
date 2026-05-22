-- Pathfinder's Pendant (Tier 3) - Provides health/action/mind bonuses
-- Designed for solo players to increase their HAM pools

soloist_earring_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Pathfinder's Pendant",
	directObjectTemplate = "object/tangible/wearables/earring/earring_s01.iff",
	craftingValues = {
		{"health", 100, 500, 0},
		{"action", 100, 500, 0},
		{"mind", 100, 500, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("soloist_earring_tier3", soloist_earring_tier3)
