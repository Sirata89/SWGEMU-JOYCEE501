-- Scout's Rucksack (Tier 1) - Increased storage + movement speed bonus
-- Designed for solo players who need to carry more and travel faster

explorer_backpack_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Scout's Rucksack",
	directObjectTemplate = "object/tangible/wearables/backpack/backpack_s01.iff",
	craftingValues = {
		{"slope_move", 2, 5, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("explorer_backpack_tier1", explorer_backpack_tier1)
