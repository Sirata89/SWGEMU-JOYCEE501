-- Solo Unique Items Loot Group (Tier 2)
-- Contains special items designed for solo players to enhance their experience
-- These items are drops from mid-level humanoid mobs with moderate stats

solo_unique_items_tier2 = {
	description = "Special items for solo players - Tier 2",
	minimumLevel = 0,
	maximumLevel = -1,
	lootItems = {
		{itemTemplate = "soloist_band_tier2", weight = 700000},
		{itemTemplate = "explorer_backpack_tier2", weight = 700000},
		{itemTemplate = "survivalist_kit_tier2", weight = 700000},
		{itemTemplate = "lucky_charm_tier2", weight = 700000},
		{itemTemplate = "soloist_earring_tier2", weight = 700000},
		{itemTemplate = "explorer_belt_tier2", weight = 700000},
		{itemTemplate = "survivalist_bracer_tier2", weight = 700000},
		{itemTemplate = "lucky_bandolier_tier2", weight = 700000},
		{itemTemplate = "soloist_shirt_tier2", weight = 700000},
		{itemTemplate = "explorer_pants_tier2", weight = 700000},
		{itemTemplate = "scout_gloves_tier2", weight = 700000},
		{itemTemplate = "scout_boots_tier2", weight = 700000},
		{itemTemplate = "scout_vest_tier2", weight = 700000},
		{itemTemplate = "tactical_datapad_tier2", weight = 700000},
		{itemTemplate = "comms_device_tier2", weight = 700000},
	}
}

addLootGroupTemplate("solo_unique_items_tier2", solo_unique_items_tier2)
