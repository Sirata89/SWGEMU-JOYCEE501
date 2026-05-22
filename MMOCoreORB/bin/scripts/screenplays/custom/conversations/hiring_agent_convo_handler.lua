-- bin/scripts/screenplays/custom/conversations/hiring_agent_convo_handler.lua

-- screenplays/custom/conversations/hiring_agent_convo_handler.lua

HiringAgentConvoHandler = conv_handler:new {}

function HiringAgentConvoHandler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
    return LuaConversationTemplate(pConvTemplate):getScreen("start")
end

function HiringAgentConvoHandler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
    local screen = LuaConversationScreen(pConvScreen)
    local screenID = screen:getScreenID()

    local clonedScreen = screen:cloneScreen()
    local clonedConvo = LuaConversationScreen(clonedScreen)

    -- Clear any existing options to prevent duplicates
    clonedConvo:removeAllOptions()

    if screenID == "start" then
        clonedConvo:addOption("I'd like to hire a companion.", "hire_menu")
        clonedConvo:addOption("Tell me about your services.", "about")
        clonedConvo:addOption("[DEBUG] Hire for free", "debug_hire")
        clonedConvo:addOption("Never mind.", "bye")

    elseif screenID == "hire_menu" then
        HiringAgentScreenPlay:openHiringWindow(pPlayer)
        clonedConvo:addOption("Dismiss my current companion", "dismiss")
        clonedConvo:addOption("Back", "start")

    elseif screenID == "debug_hire" then
        HiringAgentScreenPlay:openHiringWindow(pPlayer, true)
        clonedConvo:addOption("Back", "start")

    elseif screenID == "dismiss" then
        HiringAgentScreenPlay:dismissCompanion(pPlayer)
        clonedConvo:addOption("Continue", "start")
    end

    return clonedScreen
end