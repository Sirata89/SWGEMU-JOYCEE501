-- Field Medkit (Tier 1) - Auto-heal over time, consumable charges
-- Designed for solo players as a self-healing item

survivalist_kit_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Field Medkit",
	directObjectTemplate = "object/tangible/medicine/medpack_stimpack_a.iff",
	craftingValues = {
		{"power", 10, 30, 0},
		{"charges", 5, 10, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("survivalist_kit_tier1", survivalist_kit_tier1)
