local HiringAgentScreenPlay = require("screenplays.custom.hiring_agent")

HiringAgentConvoHandler = conv_handler:new {}

function HiringAgentConvoHandler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
    return LuaConversationTemplate(pConvTemplate):getScreen("start")
end

function HiringAgentConvoHandler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
    local screen = LuaConversationScreen(pConvScreen)
    local screenID = screen:getScreenID()
    local clonedScreen = screen:cloneScreen()
    local clonedConvo = LuaConversationScreen(clonedScreen)

    if screenID == "start" then
        clonedConvo:addOption("I'd like to hire a companion.", "hire_menu")
        clonedConvo:addOption("Tell me about your services.", "about")
        clonedConvo:addOption("Never mind.", "bye")

    elseif screenID == "hire_menu" then
        clonedConvo:addOption("Basic Mercenary (5,000 credits)", "hire_basic")
        clonedConvo:addOption("Dismiss my current companion", "dismiss")
        clonedConvo:addOption("Back", "start")

    elseif screenID == "about" then
        clonedConvo:addOption("Back", "start")

    elseif screenID == "hire_basic" then
        HiringAgentScreenPlay:tryHireCompanion(pPlayer, "generic_merc", 5000, 1800, "Hired Mercenary")
        clonedConvo:addOption("Continue", "start")

    elseif screenID == "dismiss" then
        HiringAgentScreenPlay:dismissCompanion(pPlayer)
        clonedConvo:addOption("Continue", "start")
    end

    return clonedScreen
end