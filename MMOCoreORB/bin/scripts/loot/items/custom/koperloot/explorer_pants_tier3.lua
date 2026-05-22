-- Pathfinder's Leggings (Tier 3) - Increased movement and stamina
-- Designed for solo players who need to travel faster

explorer_pants_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Pathfinder's Leggings",
	directObjectTemplate = "object/tangible/wearables/pants/pants_s08.iff",
	craftingValues = {
		{"slope_move", 10, 30, 0},
		{"terrain_negotiation", 10, 30, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("explorer_pants_tier3", explorer_pants_tier3)
