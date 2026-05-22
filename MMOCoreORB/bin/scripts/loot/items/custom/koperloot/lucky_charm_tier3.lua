-- Blessed Krayt Scale (Tier 3) - Increased drop rates, rare find
-- Designed for solo players to improve loot luck

lucky_charm_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Blessed Krayt Scale",
	directObjectTemplate = "object/tangible/wearables/necklace/necklace_s01.iff",
	craftingValues = {
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("lucky_charm_tier3", lucky_charm_tier3)
