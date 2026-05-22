-- Combat Medkit (Tier 2) - Auto-heal over time, consumable charges
-- Designed for solo players as a self-healing item

survivalist_kit_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Combat Medkit",
	directObjectTemplate = "object/tangible/medicine/medpack_stimpack_a.iff",
	craftingValues = {
		{"power", 30, 100, 0},
		{"charges", 10, 25, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("survivalist_kit_tier2", survivalist_kit_tier2)
