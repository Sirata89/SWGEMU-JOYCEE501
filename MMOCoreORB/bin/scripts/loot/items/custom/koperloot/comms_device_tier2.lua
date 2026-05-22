-- Military Comms Device (Tier 2) - Enhanced communication range
-- Designed for solo players to coordinate with allies

comms_device_tier2 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Military Comms Device",
	directObjectTemplate = "object/tangible/wearables/holdall/holdall_s02.iff",
	craftingValues = {
		{"hitpoints", 1000, 1000, 0},
	},
	customizationStringNames = {},
	customizationValues = {}
}

addLootItemTemplate("comms_device_tier2", comms_device_tier2)
