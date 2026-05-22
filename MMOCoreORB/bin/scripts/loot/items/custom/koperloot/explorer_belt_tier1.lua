-- Scout's Utility Belt (Tier 1) - Increased movement and stamina
-- Designed for solo players who need to travel faster

explorer_belt_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Scout's Utility Belt",
	directObjectTemplate = "object/tangible/wearables/belt/belt_s01.iff",
	craftingValues = {
		{"slope_move", 1, 5, 0},
		{"terrain_negotiation", 1, 5, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("explorer_belt_tier1", explorer_belt_tier1)
