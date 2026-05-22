-- Scout's Signet Ring (Tier 1) - Ring that provides +1 to +5 to all defenses
-- Designed for solo players to improve survivability

soloist_band_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Scout's Signet Ring",
	directObjectTemplate = "object/tangible/wearables/ring/ring_s01.iff",
	craftingValues = {
		{"melee_defense", 1, 5, 0},
		{"ranged_defense", 1, 5, 0},
		{"defense", 1, 5, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("soloist_band_tier1", soloist_band_tier1)
