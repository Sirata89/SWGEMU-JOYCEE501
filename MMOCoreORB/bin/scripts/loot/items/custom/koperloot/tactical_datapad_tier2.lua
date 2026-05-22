-- Advanced Tactical Datapad (Tier 2) - Enhanced situational awareness
-- Designed for solo players to track targets and terrain

tactical_datapad_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Advanced Tactical Datapad",
	directObjectTemplate = "object/tangible/wearables/holdall/holdall_s01.iff",
	craftingValues = {
		{"slope_move", 5, 15, 0},
		{"terrain_negotiation", 5, 15, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("tactical_datapad_tier2", tactical_datapad_tier2)
