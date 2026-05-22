-- Ranger's Armguard (Tier 2) - Defense and health regeneration
-- Designed for solo players to improve survivability

survivalist_bracer_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Ranger's Armguard",
	directObjectTemplate = "object/tangible/wearables/base/base_bracer_l.iff",
	craftingValues = {
		{"melee_defense", 3, 10, 0},
		{"ranged_defense", 3, 10, 0},
		{"health_encumbrance", -5, -20, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("survivalist_bracer_tier2", survivalist_bracer_tier2)
