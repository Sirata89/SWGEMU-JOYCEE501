-- Ranger's Utility Belt (Tier 2) - Increased movement and stamina
-- Designed for solo players who need to travel faster

explorer_belt_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Ranger's Utility Belt",
	directObjectTemplate = "object/tangible/wearables/belt/belt_s01.iff",
	craftingValues = {
		{"slope_move", 5, 15, 0},
		{"terrain_negotiation", 5, 15, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("explorer_belt_tier2", explorer_belt_tier2)
