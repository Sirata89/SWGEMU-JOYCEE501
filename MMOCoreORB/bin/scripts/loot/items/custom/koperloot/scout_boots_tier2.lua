-- Ranger's Boots (Tier 2) - Enhanced terrain negotiation
-- Designed for solo players who traverse difficult terrain

scout_boots_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Ranger's Boots",
	directObjectTemplate = "object/tangible/wearables/boots/boots_s14.iff",
	craftingValues = {
		{"slope_move", 5, 15, 0},
		{"terrain_negotiation", 5, 15, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("scout_boots_tier2", scout_boots_tier2)
