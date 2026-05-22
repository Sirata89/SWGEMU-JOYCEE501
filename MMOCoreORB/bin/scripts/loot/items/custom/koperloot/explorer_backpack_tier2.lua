-- Ranger's Rucksack (Tier 2) - Increased storage + movement speed bonus
-- Designed for solo players who need to carry more and travel faster

explorer_backpack_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Ranger's Rucksack",
	directObjectTemplate = "object/tangible/wearables/backpack/backpack_s01.iff",
	craftingValues = {
		{"slope_move", 5, 15, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("explorer_backpack_tier2", explorer_backpack_tier2)
