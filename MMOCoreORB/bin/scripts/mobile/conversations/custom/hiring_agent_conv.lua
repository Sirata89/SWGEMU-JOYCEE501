-- bin/scripts/mobile/conversations/custom/hiring_agent_conv.lua

hiringAgentConvoTemplate = ConvoTemplate:new {
    initialScreen = "start",
    templateType = "Lua",
    luaClassHandler = "HiringAgentConvoHandler",
    screens = {}
}

-- ====================== MAIN SCREENS ======================

local startScreen = ConvoScreen:new {
    id = "start",
    customDialogText = "Looking for reliable muscle today, stranger?",
    stopConversation = "false",
    options = {}
}
hiringAgentConvoTemplate:addScreen(startScreen)

local hireMenuScreen = ConvoScreen:new {
    id = "hire_menu",
    customDialogText = "Excellent. Who would you like to hire?",
    stopConversation = "false",
    options = {}
}
hiringAgentConvoTemplate:addScreen(hireMenuScreen)

local aboutScreen = ConvoScreen:new {
    id = "about",
    customDialogText = "I recruit skilled mercenaries for adventurers like yourself. They fight by your side, help with missions, and scale with difficulty.",
    stopConversation = "false",
    options = {
        { "Back", "start" }
    }
}
hiringAgentConvoTemplate:addScreen(aboutScreen)

local byeScreen = ConvoScreen:new {
    id = "bye",
    customDialogText = "Come back anytime if you need backup.",
    stopConversation = "true",
    options = {}
}
hiringAgentConvoTemplate:addScreen(byeScreen)

local successScreen = ConvoScreen:new {
    id = "success",
    customDialogText = "They're on their way. Good hunting!",
    stopConversation = "false",
    options = {
        { "Continue", "start" }
    }
}
hiringAgentConvoTemplate:addScreen(successScreen)

local debugHireScreen = ConvoScreen:new {
    id = "debug_hire",
    customDialogText = "Debug mode activated.",
    stopConversation = "false",
    options = {}
}
hiringAgentConvoTemplate:addScreen(debugHireScreen)

addConversationTemplate("hiring_agent_convo_template", hiringAgentConvoTemplate)