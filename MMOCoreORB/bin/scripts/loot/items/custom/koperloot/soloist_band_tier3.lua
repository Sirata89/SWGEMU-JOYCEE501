-- Pathfinder's Signet Ring (Tier 3) - Ring that provides +10 to +25 to all defenses
-- Designed for solo players to improve survivability

soloist_band_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Pathfinder's Signet Ring",
	directObjectTemplate = "object/tangible/wearables/ring/ring_s01.iff",
	craftingValues = {
		{"melee_defense", 10, 25, 0},
		{"ranged_defense", 10, 25, 0},
		{"defense", 10, 25, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("soloist_band_tier3", soloist_band_tier3)
