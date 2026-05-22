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
        { "Slice for speed (FREE)", "trigger_speed" },
        { "Slice for damage (FREE)", "trigger_damage" },
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
        { "Slice for effectiveness (FREE)", "trigger_effectiveness" },
        { "Slice for encumbrance (FREE)", "trigger_encumbrance" },
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
        { "Add Poison DOT (FREE for testing)", "trigger_poison" },
        { "Add Disease DOT (FREE for testing)", "trigger_disease" },
        { "Add Fire DOT (FREE for testing)", "trigger_fire" },
        { "Add Bleed DOT (FREE for testing)", "trigger_bleed" },
        { "Back", "greeting" }
    }
}
slicingDroidConvoTemplate:addScreen(specialMenuScreen)

-- Special trigger screens
local triggerPoisonScreen = ConvoScreen:new {
    id = "trigger_poison",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerPoisonScreen)

local triggerDiseaseScreen = ConvoScreen:new {
    id = "trigger_disease",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerDiseaseScreen)

local triggerFireScreen = ConvoScreen:new {
    id = "trigger_fire",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerFireScreen)

local triggerBleedScreen = ConvoScreen:new {
    id = "trigger_bleed",
    customDialogText = "",
    stopConversation = "true",
    options = {}
}
slicingDroidConvoTemplate:addScreen(triggerBleedScreen)

-- Pricing Info
local pricingInfoScreen = ConvoScreen:new {
    id = "pricing_info",
    customDialogText = "All slicing services are currently FREE for testing. Standard slicing: 20-35% enhancement. DOT slicing adds damage over time effects.",
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
