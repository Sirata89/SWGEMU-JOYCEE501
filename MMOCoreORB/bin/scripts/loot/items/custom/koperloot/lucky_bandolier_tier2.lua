-- Freelancer's Bandolier (Tier 2) - Storage and luck (cosmetic for now)
-- Designed for solo players who need extra storage

lucky_bandolier_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Freelancer's Bandolier",
	directObjectTemplate = "object/tangible/wearables/bandolier/bandolier_s01.iff",
	craftingValues = {
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("lucky_bandolier_tier2", lucky_bandolier_tier2)
