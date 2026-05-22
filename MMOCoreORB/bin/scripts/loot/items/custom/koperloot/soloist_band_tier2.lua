-- Ranger's Signet Ring (Tier 2) - Ring that provides +5 to +15 to all defenses
-- Designed for solo players to improve survivability

soloist_band_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Ranger's Signet Ring",
	directObjectTemplate = "object/tangible/wearables/ring/ring_s01.iff",
	craftingValues = {
		{"melee_defense", 5, 15, 0},
		{"ranged_defense", 5, 15, 0},
		{"defense", 5, 15, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("soloist_band_tier2", soloist_band_tier2)
