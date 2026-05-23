slicingDroidConvoTemplate = ConvoTemplate:new {
    initialScreen = "greeting",
    templateType = "Lua",
    luaClassHandler = "slicingDroidConvoHandler",
    screens = {}
}

-- Greeting Screen
local greetingScreen = ConvoScreen:new {
    id = "greeting",
    customDialogText = "Beep boop. I am R2-SLIC, a specialized slicing droid. I can enhance your weapons and armor for a fee.",
    stopConversation = "false",
    options = {
        { "I want to slice a weapon", "weapon_menu" },
        { "I want to slice armor", "armor_menu" },
        { "Special: Add DOT to weapon", "special_menu" },
        { "Recharge DOT uses (50,000 credits)", "trigger_recharge" },
        { "Slice locked container (20,000 credits)", "trigger_container" },
        { "Tell me about your pricing", "pricing_info" },
        { "No thanks", "goodbye" }
    }
}
slicingDroidConvoTemplate:addScreen(greetingScreen)

-- Weapon Menu
local weaponMenuScreen = ConvoScreen:new {
    id = "weapon_menu",
    customDialogText = "I can slice your weapon for either speed or damage. Select which enhancement you prefer.",
    stopConversation = "false",
    options = {
        { "Slice for speed (20,000 credits)", "trigger_speed" },
        { "Slice for damage (20,000 credits)", "trigger_damage" },
        { "Back", "greeting" }
    }
}
slicingDroidConvoTemplate:addScreen(weaponMenuScreen)

-- Armor Menu
local armorMenuScreen = ConvoScreen:new {
    id = "armor_menu",
    customDialogText = "I can slice your armor for either effectiveness or encumbrance reduction. Select which enhancement you prefer.",
    stopConversation = "false",
    options = {
        { "Slice for effectiveness (20,000 credits)", "trigger_effectiveness" },
        { "Slice for encumbrance (20,000 credits)", "trigger_encumbrance" },
        { "Back", "greeting" }
    }
}
slicingDroidConvoTemplate:addScreen(armorMenuScreen)

-- Trigger screens (SUI will be shown by handler)
local triggerSpeedScreen = ConvoScreen:new {
    id = "trigger_speed",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerSpeedScreen)

local triggerDamageScreen = ConvoScreen:new {
    id = "trigger_damage",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerDamageScreen)

local triggerEffectivenessScreen = ConvoScreen:new {
    id = "trigger_effectiveness",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerEffectivenessScreen)

local triggerEncumbranceScreen = ConvoScreen:new {
    id = "trigger_encumbrance",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerEncumbranceScreen)

-- Special DOT Menu
local specialMenuScreen = ConvoScreen:new {
    id = "special_menu",
    customDialogText = "I can add a Damage Over Time (DOT) effect to your weapon. Choose the type of DOT you want.",
    stopConversation = "false",
    options = {
        { "Poison DOT", "poison_tier_menu" },
        { "Disease DOT", "disease_tier_menu" },
        { "Fire DOT", "fire_tier_menu" },
        { "Bleed DOT", "bleed_tier_menu" },
        { "Back", "greeting" }
    }
}
slicingDroidConvoTemplate:addScreen(specialMenuScreen)

-- Poison Tier Menu
local poisonTierMenuScreen = ConvoScreen:new {
    id = "poison_tier_menu",
    customDialogText = "Select the tier of Poison DOT you want.",
    stopConversation = "false",
    options = {
        { "Standard (500-1000 uses) - 100,000 credits", "trigger_poison_standard" },
        { "Premium (2000-2500 uses) - 250,000 credits", "trigger_poison_premium" },
        { "Elite (4000-4500 uses) - 500,000 credits", "trigger_poison_elite" },
        { "Back", "special_menu" }
    }
}
slicingDroidConvoTemplate:addScreen(poisonTierMenuScreen)

-- Disease Tier Menu
local diseaseTierMenuScreen = ConvoScreen:new {
    id = "disease_tier_menu",
    customDialogText = "Select the tier of Disease DOT you want.",
    stopConversation = "false",
    options = {
        { "Standard (500-1000 uses) - 100,000 credits", "trigger_disease_standard" },
        { "Premium (2000-2500 uses) - 250,000 credits", "trigger_disease_premium" },
        { "Elite (4000-4500 uses) - 500,000 credits", "trigger_disease_elite" },
        { "Back", "special_menu" }
    }
}
slicingDroidConvoTemplate:addScreen(diseaseTierMenuScreen)

-- Fire Tier Menu
local fireTierMenuScreen = ConvoScreen:new {
    id = "fire_tier_menu",
    customDialogText = "Select the tier of Fire DOT you want.",
    stopConversation = "false",
    options = {
        { "Standard (500-1000 uses) - 100,000 credits", "trigger_fire_standard" },
        { "Premium (2000-2500 uses) - 250,000 credits", "trigger_fire_premium" },
        { "Elite (4000-4500 uses) - 500,000 credits", "trigger_fire_elite" },
        { "Back", "special_menu" }
    }
}
slicingDroidConvoTemplate:addScreen(fireTierMenuScreen)

-- Bleed Tier Menu
local bleedTierMenuScreen = ConvoScreen:new {
    id = "bleed_tier_menu",
    customDialogText = "Select the tier of Bleed DOT you want.",
    stopConversation = "false",
    options = {
        { "Standard (500-1000 uses) - 100,000 credits", "trigger_bleed_standard" },
        { "Premium (2000-2500 uses) - 250,000 credits", "trigger_bleed_premium" },
        { "Elite (4000-4500 uses) - 500,000 credits", "trigger_bleed_elite" },
        { "Back", "special_menu" }
    }
}
slicingDroidConvoTemplate:addScreen(bleedTierMenuScreen)

-- DOT Tier trigger screens
local triggerPoisonStandardScreen = ConvoScreen:new {
    id = "trigger_poison_standard",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerPoisonStandardScreen)

local triggerPoisonPremiumScreen = ConvoScreen:new {
    id = "trigger_poison_premium",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerPoisonPremiumScreen)

local triggerPoisonEliteScreen = ConvoScreen:new {
    id = "trigger_poison_elite",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerPoisonEliteScreen)

local triggerDiseaseStandardScreen = ConvoScreen:new {
    id = "trigger_disease_standard",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerDiseaseStandardScreen)

local triggerDiseasePremiumScreen = ConvoScreen:new {
    id = "trigger_disease_premium",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerDiseasePremiumScreen)

local triggerDiseaseEliteScreen = ConvoScreen:new {
    id = "trigger_disease_elite",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerDiseaseEliteScreen)

local triggerFireStandardScreen = ConvoScreen:new {
    id = "trigger_fire_standard",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerFireStandardScreen)

local triggerFirePremiumScreen = ConvoScreen:new {
    id = "trigger_fire_premium",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerFirePremiumScreen)

local triggerFireEliteScreen = ConvoScreen:new {
    id = "trigger_fire_elite",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerFireEliteScreen)

local triggerBleedStandardScreen = ConvoScreen:new {
    id = "trigger_bleed_standard",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerBleedStandardScreen)

local triggerBleedPremiumScreen = ConvoScreen:new {
    id = "trigger_bleed_premium",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerBleedPremiumScreen)

local triggerBleedEliteScreen = ConvoScreen:new {
    id = "trigger_bleed_elite",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerBleedEliteScreen)

-- Recharge trigger screen
local triggerRechargeScreen = ConvoScreen:new {
    id = "trigger_recharge",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerRechargeScreen)

-- Container trigger screen
local triggerContainerScreen = ConvoScreen:new {
    id = "trigger_container",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerContainerScreen)

-- 
-- Pricing Info
local pricingInfoScreen = ConvoScreen:new {
    id = "pricing_info",
    customDialogText = "Weapon/Armor slicing: 20,000 credits (20-35% enhancement). DOT slicing: 100,000 credits (adds damage over time effects). Container slicing: 20,000 credits (unlocks locked containers).",
    stopConversation = "false",
    options = {
        { "Back", "greeting" }
    }
}
slicingDroidConvoTemplate:addScreen(pricingInfoScreen)

-- Goodbye
local goodbyeScreen = ConvoScreen:new {
    id = "goodbye",
    customDialogText = "Beep boop. Come back if you need my services.",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(goodbyeScreen)

addConversationTemplate("slicing_droid_conv", slicingDroidConvoTemplate)
