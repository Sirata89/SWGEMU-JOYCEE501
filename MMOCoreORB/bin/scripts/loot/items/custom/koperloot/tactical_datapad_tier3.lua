-- Elite Tactical Datapad (Tier 3) - Enhanced situational awareness
-- Designed for solo players to track targets and terrain

tactical_datapad_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Elite Tactical Datapad",
	directObjectTemplate = "object/tangible/wearables/holdall/holdall_s01.iff",
	craftingValues = {
		{"slope_move", 10, 30, 0},
		{"terrain_negotiation", 10, 30, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("tactical_datapad_tier3", tactical_datapad_tier3)
