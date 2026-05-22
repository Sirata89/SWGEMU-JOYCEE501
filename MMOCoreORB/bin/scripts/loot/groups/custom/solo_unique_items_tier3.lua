-- Solo Unique Items Loot Group (Tier 3)
-- Contains special items designed for solo players to enhance their experience
-- These items are drops from high-level humanoid mobs with powerful stats

solo_unique_items_tier3 = {
	description = "Special items for solo players - Tier 3",
	minimumLevel = 0,
	maximumLevel = -1,
	lootItems = {
		{itemTemplate = "soloist_band_tier3", weight = 700000},
		{itemTemplate = "explorer_backpack_tier3", weight = 700000},
		{itemTemplate = "survivalist_kit_tier3", weight = 700000},
		{itemTemplate = "lucky_charm_tier3", weight = 700000},
		{itemTemplate = "soloist_earring_tier3", weight = 700000},
		{itemTemplate = "explorer_belt_tier3", weight = 700000},
		{itemTemplate = "survivalist_bracer_tier3", weight = 700000},
		{itemTemplate = "lucky_bandolier_tier3", weight = 700000},
		{itemTemplate = "soloist_shirt_tier3", weight = 700000},
		{itemTemplate = "explorer_pants_tier3", weight = 700000},
		{itemTemplate = "scout_gloves_tier3", weight = 700000},
		{itemTemplate = "scout_boots_tier3", weight = 700000},
		{itemTemplate = "scout_vest_tier3", weight = 700000},
		{itemTemplate = "tactical_datapad_tier3", weight = 700000},
		{itemTemplate = "comms_device_tier3", weight = 700000},
	}
}

addLootGroupTemplate("solo_unique_items_tier3", solo_unique_items_tier3)
