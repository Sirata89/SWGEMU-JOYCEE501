-- Scout's Boots (Tier 1) - Enhanced terrain negotiation
-- Designed for solo players who traverse difficult terrain

scout_boots_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Scout's Boots",
	directObjectTemplate = "object/tangible/wearables/boots/boots_s14.iff",
	craftingValues = {
		{"slope_move", 1, 5, 0},
		{"terrain_negotiation", 1, 5, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("scout_boots_tier1", scout_boots_tier1)
