-- Advanced Medkit (Tier 3) - Auto-heal over time, consumable charges
-- Designed for solo players as a self-healing item

survivalist_kit_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Advanced Medkit",
	directObjectTemplate = "object/tangible/medicine/medpack_stimpack_a.iff",
	craftingValues = {
		{"power", 50, 200, 0},
		{"charges", 10, 50, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("survivalist_kit_tier3", survivalist_kit_tier3)
