hiringAgentConvoTemplate = ConvoTemplate:new {
    initialScreen = "start",
    templateType = "Normal",
    luaClassHandler = "HiringAgentConvoHandler",
    screens = {}
}

local startScreen = ConvoScreen:new {
    id = "start",
    leftDialog = "Looking for reliable muscle today, stranger?",
    stopConversation = "false",
    options = {}
}
hiringAgentConvoTemplate:addScreen(startScreen)

local hireMenuScreen = ConvoScreen:new {
    id = "hire_menu",
    leftDialog = "Excellent choice. Who would you like to hire?",
    stopConversation = "false",
    options = {}
}
hiringAgentConvoTemplate:addScreen(hireMenuScreen)

local aboutScreen = ConvoScreen:new {
    id = "about",
    leftDialog = "I recruit skilled mercenaries for adventurers like yourself. My rates are fair.",
    stopConversation = "false",
    options = {}
}
hiringAgentConvoTemplate:addScreen(aboutScreen)

local byeScreen = ConvoScreen:new {
    id = "bye",
    leftDialog = "Come back anytime if you need backup.",
    stopConversation = "true",
    options = {}
}
hiringAgentConvoTemplate:addScreen(byeScreen)

addConversationTemplate("hiring_agent_convo_template", hiringAgentConvoTemplate)