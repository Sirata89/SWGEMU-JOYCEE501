-- Ranger's Pendant (Tier 2) - Provides health/action/mind bonuses
-- Designed for solo players to increase their HAM pools

soloist_earring_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Ranger's Pendant",
	directObjectTemplate = "object/tangible/wearables/earring/earring_s01.iff",
	craftingValues = {
		{"health", 50, 200, 0},
		{"action", 50, 200, 0},
		{"mind", 50, 200, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("soloist_earring_tier2", soloist_earring_tier2)
