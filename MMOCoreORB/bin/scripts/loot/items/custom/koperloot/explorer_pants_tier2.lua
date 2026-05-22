-- Ranger's Leggings (Tier 2) - Increased movement and stamina
-- Designed for solo players who need to travel faster

explorer_pants_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Ranger's Leggings",
	directObjectTemplate = "object/tangible/wearables/pants/pants_s08.iff",
	craftingValues = {
		{"slope_move", 5, 15, 0},
		{"terrain_negotiation", 5, 15, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("explorer_pants_tier2", explorer_pants_tier2)
