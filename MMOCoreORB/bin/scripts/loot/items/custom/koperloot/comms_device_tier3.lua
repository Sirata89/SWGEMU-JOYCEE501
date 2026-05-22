-- SpecOps Comms Device (Tier 3) - Enhanced communication range
-- Designed for solo players to coordinate with allies

comms_device_tier3 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "SpecOps Comms Device",
	directObjectTemplate = "object/tangible/wearables/holdall/holdall_s02.iff",
	craftingValues = {
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("comms_device_tier3", comms_device_tier3)
