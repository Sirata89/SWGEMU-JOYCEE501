slicing_droid = Creature:new {
	objectName = "@mob/creature_names:r2",
	customName = "R2-SLIC",
	socialGroup = "townsperson",
	mobType = MOB_DROID,
	faction = "",
	level = 4,
	chanceHit = 0.24,
	damageMin = 40,
	damageMax = 45,
	baseHAM = 113,
	baseHAMmax = 138,
	armor = 0,
	resists = {15,15,15,15,15,15,15,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	optionsBitmask = INVULNERABLE + CONVERSABLE,
	diet = HERBIVORE,

	templates = {"object/mobile/r2.iff"},
	lootGroups = {},

	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "slicing_droid_conv",

	primaryAttacks = {},
	secondaryAttacks = {}
}

CreatureTemplates:addCreatureTemplate(slicing_droid, "slicing_droid")
