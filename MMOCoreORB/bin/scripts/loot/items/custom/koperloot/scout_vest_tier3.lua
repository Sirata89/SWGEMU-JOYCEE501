-- Pathfinder's Vest (Tier 3) - Protection and HAM enhancement
-- Designed for solo players to improve survivability

scout_vest_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Pathfinder's Vest",
	directObjectTemplate = "object/tangible/wearables/vest/vest_s15.iff",
	craftingValues = {
		{"health", 100, 500, 0},
		{"action", 100, 500, 0},
		{"mind", 100, 500, 0},
		{"melee_defense", 5, 20, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("scout_vest_tier3", scout_vest_tier3)
