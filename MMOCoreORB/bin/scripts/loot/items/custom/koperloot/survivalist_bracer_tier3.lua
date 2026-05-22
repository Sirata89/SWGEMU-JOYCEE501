-- Pathfinder's Armguard (Tier 3) - Defense and health regeneration
-- Designed for solo players to improve survivability

survivalist_bracer_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Pathfinder's Armguard",
	directObjectTemplate = "object/tangible/wearables/base/base_bracer_l.iff",
	craftingValues = {
		{"melee_defense", 5, 20, 0},
		{"ranged_defense", 5, 20, 0},
		{"health_encumbrance", -10, -50, 0},
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("survivalist_bracer_tier3", survivalist_bracer_tier3)
