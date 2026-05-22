-- Tactical Datapad (Tier 1) - Enhanced situational awareness
-- Designed for solo players to track targets and terrain

tactical_datapad_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Tactical Datapad",
	directObjectTemplate = "object/tangible/wearables/holdall/holdall_s01.iff",
	craftingValues = {
		{"slope_move", 1, 5, 0},
		{"terrain_negotiation", 1, 5, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("tactical_datapad_tier1", tactical_datapad_tier1)
