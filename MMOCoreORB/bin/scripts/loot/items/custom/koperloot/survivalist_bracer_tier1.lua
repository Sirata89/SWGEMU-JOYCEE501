-- Scout's Armguard (Tier 1) - Defense and health regeneration
-- Designed for solo players to improve survivability

survivalist_bracer_tier1 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Scout's Armguard",
	directObjectTemplate = "object/tangible/wearables/base/base_bracer_l.iff",
	craftingValues = {
		{"melee_defense", 1, 3, 0},
		{"ranged_defense", 1, 3, 0},
		{"health_encumbrance", -2, -5, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("survivalist_bracer_tier1", survivalist_bracer_tier1)
