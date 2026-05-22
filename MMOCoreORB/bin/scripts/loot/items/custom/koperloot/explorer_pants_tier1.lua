-- Scout's Leggings (Tier 1) - Increased movement and stamina
-- Designed for solo players who need to travel faster

explorer_pants_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Scout's Leggings",
	directObjectTemplate = "object/tangible/wearables/pants/pants_s08.iff",
	craftingValues = {
		{"slope_move", 1, 5, 0},
		{"terrain_negotiation", 1, 5, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("explorer_pants_tier1", explorer_pants_tier1)
