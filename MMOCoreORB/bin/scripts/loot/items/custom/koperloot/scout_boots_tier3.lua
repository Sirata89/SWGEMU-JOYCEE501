-- Pathfinder's Boots (Tier 3) - Enhanced terrain negotiation
-- Designed for solo players who traverse difficult terrain

scout_boots_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Pathfinder's Boots",
	directObjectTemplate = "object/tangible/wearables/boots/boots_s14.iff",
	craftingValues = {
		{"slope_move", 10, 30, 0},
		{"terrain_negotiation", 10, 30, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("scout_boots_tier3", scout_boots_tier3)
