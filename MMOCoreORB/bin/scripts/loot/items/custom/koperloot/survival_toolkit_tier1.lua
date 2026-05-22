-- Survival Toolkit (Tier 1) - Field repair and crafting aid
-- Designed for solo players to maintain equipment in the field

survival_toolkit_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Survival Toolkit",
	directObjectTemplate = "object/tangible/crafting/station/weapon_station.iff",
	craftingValues = {
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("survival_toolkit_tier1", survival_toolkit_tier1)
