-- Pathfinder's Rucksack (Tier 3) - Increased storage + movement speed bonus
-- Designed for solo players who need to carry more and travel faster

explorer_backpack_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Pathfinder's Rucksack",
	directObjectTemplate = "object/tangible/wearables/backpack/backpack_s01.iff",
	craftingValues = {
		{"slope_move", 10, 30, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("explorer_backpack_tier3", explorer_backpack_tier3)
