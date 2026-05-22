-- Ranger's Vest (Tier 2) - Protection and HAM enhancement
-- Designed for solo players to improve survivability

scout_vest_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Ranger's Vest",
	directObjectTemplate = "object/tangible/wearables/vest/vest_s15.iff",
	craftingValues = {
		{"health", 50, 200, 0},
		{"action", 50, 200, 0},
		{"mind", 50, 200, 0},
		{"melee_defense", 3, 10, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("scout_vest_tier2", scout_vest_tier2)
