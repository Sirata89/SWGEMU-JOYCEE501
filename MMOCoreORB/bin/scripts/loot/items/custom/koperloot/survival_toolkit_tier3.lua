-- Master Repair Kit (Tier 3) - Field repair and crafting aid
-- Designed for solo players to maintain equipment in the field

survival_toolkit_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Master Repair Kit",
	directObjectTemplate = "object/tangible/crafting/station/weapon_station.iff",
	craftingValues = {
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("survival_toolkit_tier3", survival_toolkit_tier3)
