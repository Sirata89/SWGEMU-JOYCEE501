BBACraftedDroidConfig = {
	path = "object/draft_schematic/droid/",
	qualityMin = 60,
	qualityAvg = 75, -- 10% chance to use this as the min value and qualityMax as the max value
	qualityMax = 95, -- 1% Chance to get up to +5 to the max value, with qualityMax as the min value
	freq = 86400, -- Every x seconds
	eventName = "BazaarBotAddCraftedDroid",
	functionName = "addMoreCraftedDroid",
	listingChance = 100
}

-- {price, quantity, crateQuantity, "altTemplate", "templates"...},
-- price: Price * (random(QualityRoll/4, QualityRoll/2) / 100 + 1) * crateQuantity
-- quantity: How many of each item in the group will be listed every freq seconds
-- crateQuantity: Set higher than 1 to make factory crates rather than individual items
-- altTemplate: Items such as statues that have a drop down to choose alternate final objects
-- Items that don't have altTemplates and should be the same price can be grouped together

BBACraftedDroidItems = {
	{10000, 5, 1, 0, "droid_3p0_advanced"},
	{5000, 5, 1, 0, "droid_3p0"},
	{2500, 5, 1, 0, "droid_dz70"},
	{10000, 5, 1, 0, "droid_dz70_advanced"},
	{1000, 5, 1, 0, "droid_mse"},
	{2500, 5, 1, 0, "droid_mse_advanced"},
	{5000, 5, 1, 0, "droid_r2"},
	{10000, 5, 1, 0, "droid_r2_advanced"},
	{10000, 5, 1, 0, "droid_r3"},
	{10000, 5, 1, 0, "droid_r3_advanced"},
	{10000, 5, 1, 0, "droid_r4"},
	{10000, 5, 1, 0, "droid_r4_advanced"},
	{10000, 5, 1, 0, "droid_r5"},
	{10000, 5, 1, 0, "droid_r5_advanced"},
	{10000, 5, 1, 0, "droid_surgical"},
	{10000, 5, 1, 0, "droid_surgical_advanced"}
}
