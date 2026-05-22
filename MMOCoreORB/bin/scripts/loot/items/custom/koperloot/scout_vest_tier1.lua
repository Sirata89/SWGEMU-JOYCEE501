-- Scout's Vest (Tier 1) - Protection and HAM enhancement
-- Designed for solo players to improve survivability

scout_vest_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Scout's Vest",
	directObjectTemplate = "object/tangible/wearables/vest/vest_s15.iff",
	craftingValues = {
		{"health", 10, 50, 0},
		{"action", 10, 50, 0},
		{"mind", 10, 50, 0},
		{"melee_defense", 1, 3, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("scout_vest_tier1", scout_vest_tier1)
