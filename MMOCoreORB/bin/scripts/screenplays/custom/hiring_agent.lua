-- Hiring Agent ScreenPlay

HiringAgentScreenPlay = ScreenPlay:new {}

-- Mercenary configuration table
HiringAgentScreenPlay.mercenaryTypes = {
    -- Lower Tier (Levels 15-22)
    {
        id = "street_thug",
        name = "Street Thug",
        template = "street_thug",
        cost = 1000,
        displayName = "Street Thug",
        jediOnly = false
    },
    {
        id = "commoner_guard",
        name = "Commoner Guard",
        template = "commoner_guard",
        cost = 1500,
        displayName = "Commoner Guard",
        jediOnly = false
    },
    {
        id = "scavenger",
        name = "Scavenger Hunter",
        template = "scavenger_hunter",
        cost = 2000,
        displayName = "Scavenger Hunter",
        jediOnly = false
    },
    {
        id = "medic_apprentice",
        name = "Medic Apprentice",
        template = "merc_medic_apprentice",
        cost = 2500,
        displayName = "Medic Apprentice",
        jediOnly = false
    },
    -- Mid-Low Tier (Levels 30-38)
    {
        id = "basic",
        name = "Basic Mercenary",
        template = "generic_merc",
        cost = 3000,
        displayName = "Hired Mercenary",
        jediOnly = false
    },
    {
        id = "rodian",
        name = "Rodian Mercenary",
        template = "rodian_mercenary",
        cost = 4000,
        displayName = "Rodian Mercenary",
        jediOnly = false
    },
    {
        id = "smuggler",
        name = "Rogue Smuggler",
        template = "rogue_smuggler",
        cost = 5000,
        displayName = "Rogue Smuggler",
        jediOnly = false
    },
    {
        id = "medic",
        name = "Field Medic",
        template = "merc_field_medic",
        cost = 5500,
        displayName = "Field Medic",
        jediOnly = false
    },
    {
        id = "medic_corpsman",
        name = "Medic Corpsman",
        template = "merc_medic_corpsman",
        cost = 7000,
        displayName = "Medic Corpsman",
        jediOnly = false
    },
    -- Mid-High Tier (Levels 36-41)
    {
        id = "pirate",
        name = "Pirate Cutthroat",
        template = "merc_pirate_cutthroat",
        cost = 6000,
        displayName = "Pirate Cutthroat",
        jediOnly = false
    },
    {
        id = "rebel",
        name = "Rebel Veteran",
        template = "rebel_veteran",
        cost = 7500,
        displayName = "Rebel Veteran",
        jediOnly = false
    },
    {
        id = "corporate",
        name = "Corporate Security",
        template = "corporate_security",
        cost = 9000,
        displayName = "Corporate Security",
        jediOnly = false
    },
    {
        id = "imperial",
        name = "Imperial Defector",
        template = "merc_imperial_defector",
        cost = 10000,
        displayName = "Imperial Defector",
        jediOnly = false
    },
    {
        id = "merc_captain",
        name = "Mercenary Captain",
        template = "merc_captain",
        cost = 12500,
        displayName = "Mercenary Captain",
        jediOnly = false
    },
    -- High Tier (Levels 42-52)
    {
        id = "bounty_hunter",
        name = "Bounty Hunter",
        template = "bounty_hunter_merc",
        cost = 15000,
        displayName = "Bounty Hunter Mercenary",
        jediOnly = false
    },
    {
        id = "mandalorian",
        name = "Mandalorian Scout",
        template = "mandalorian_scout",
        cost = 20000,
        displayName = "Mandalorian Scout",
        jediOnly = false
    },
    {
        id = "medic_surgeon",
        name = "Combat Surgeon",
        template = "merc_medic_surgeon",
        cost = 25000,
        displayName = "Combat Surgeon",
        jediOnly = false
    },
    {
        id = "dark_jedi",
        name = "Dark Jedi Acolyte",
        template = "dark_jedi_acolyte",
        cost = 30000,
        displayName = "Dark Jedi Acolyte",
        jediOnly = true
    },
    {
        id = "assassin_droid",
        name = "Assassin Droid",
        template = "assassin_droid",
        cost = 40000,
        displayName = "Assassin Droid",
        jediOnly = false
    },
    {
        id = "elite_commando",
        name = "Elite Commando",
        template = "elite_commando",
        cost = 50000,
        displayName = "Elite Commando",
        jediOnly = false
    },
    {
        id = "medic_doctor",
        name = "Field Doctor",
        template = "merc_medic_doctor",
        cost = 45000,
        displayName = "Field Doctor",
        jediOnly = false
    }
}

registerScreenPlay("HiringAgentScreenPlay", true)

function HiringAgentScreenPlay:start()
    if (isZoneEnabled("naboo")) then
        self:spawnNaboo()
    end
end

function HiringAgentScreenPlay:spawnNaboo()
    spawnMobile("naboo", "hiring_agent", 300, -12.7, 0.7, -76.7, -5, 1692102)
end

-- ====================== SUI FUNCTIONS ======================
function HiringAgentScreenPlay:openHiringWindow(pPlayer, isDebug)
    local sui = SuiListBox.new("HiringAgentScreenPlay", "hiringCallback")
    
    sui.setTargetNetworkId(0)
    sui.setForceCloseDistance(16)
    
    sui.setTitle("Hire a Companion")
    if isDebug then
        sui.setPrompt("[DEBUG MODE] Select a mercenary to hire for FREE.")
    else
        sui.setPrompt("Select a mercenary to hire. They will fight by your side until killed in battle.")
    end
    
    -- Check if player is jedi
    local player = CreatureObject(pPlayer)
    local pGhost = player:getPlayerObject()
    local isJedi = false
    
    if pGhost then
        local playerObj = PlayerObject(pGhost)
        -- Check for jedi state or jedi profession
        isJedi = playerObj:isJedi()
    end
    
    -- Add mercenary options from table
    for i, merc in ipairs(self.mercenaryTypes) do
        -- Skip jedi-only options if player is not jedi
        if merc.jediOnly and not isJedi then
            -- Skip this option
        else
            local optionText
            if isDebug then
                optionText = merc.name .. " [FREE]"
            else
                optionText = merc.name .. " - " .. merc.cost .. " credits"
            end
            sui.add(optionText, "")
        end
    end
    
    -- Store debug mode in screen play data for callback
    if isDebug then
        writeScreenPlayData(pPlayer, "HiringAgentScreenPlay", "debug_mode", "true")
    else
        deleteScreenPlayData(pPlayer, "HiringAgentScreenPlay", "debug_mode")
    end
    
    sui.sendTo(pPlayer)
end

function HiringAgentScreenPlay:hiringCallback(pPlayer, pSui, eventIndex, args)
    local cancelPressed = (eventIndex == 1)
    
    if cancelPressed then
        return
    end
    
    if args == "-1" then
        CreatureObject(pPlayer):sendSystemMessage("No option was selected, please try again.")
        return
    end
    
    -- Check if player is jedi
    local player = CreatureObject(pPlayer)
    local pGhost = player:getPlayerObject()
    local isJedi = false
    
    if pGhost then
        local playerObj = PlayerObject(pGhost)
        isJedi = playerObj:isJedi()
    end
    
    -- Build list of available mercenaries (same logic as openHiringWindow)
    local availableMercs = {}
    for i, merc in ipairs(self.mercenaryTypes) do
        if not (merc.jediOnly and not isJedi) then
            table.insert(availableMercs, merc)
        end
    end
    
    local selectedOption = tonumber(args) + 1
    
    -- Check if debug mode is active
    local isDebug = (readScreenPlayData(pPlayer, "HiringAgentScreenPlay", "debug_mode") == "true")
    
    if selectedOption > 0 and selectedOption <= #availableMercs then
        local mercData = availableMercs[selectedOption]
        local cost = isDebug and 0 or mercData.cost
        self:tryHireCompanion(pPlayer, mercData.template, cost, mercData.displayName)
    else
        CreatureObject(pPlayer):sendSystemMessage("Invalid selection, please try again.")
    end
end

-- ====================== HIRING LOGIC ======================
function HiringAgentScreenPlay:tryHireCompanion(pPlayer, companionTemplate, cost, customName)
    if pPlayer == nil then 
        print("ERROR: tryHireCompanion called with nil player")
        return 
    end

    local player = CreatureObject(pPlayer)
    local pDatapad = SceneObject(pPlayer):getSlottedObject("datapad")
    
    if pDatapad == nil then
        player:sendSystemMessage("Could not find your datapad.")
        return
    end

    -- Check if player already has a hireling
    if checkTooManyHirelings(pDatapad) then
        player:sendSystemMessage("You already have a mercenary. Dismiss them first.")
        return
    end

    if player:getCashCredits() < cost then
        player:sendSystemMessage("You need " .. cost .. " credits.")
        return
    end

    player:subtractCashCredits(cost)

    -- Give control device to player
    local pControlDevice = giveControlDevice(pDatapad, "object/intangible/pet/pet_control.iff", companionTemplate, -1, true)
    
    if pControlDevice ~= nil then
        SceneObject(pControlDevice):sendTo(pPlayer)
        player:sendSystemMessage("A hired mercenary has joined you!")
    else
        player:sendSystemMessage("Failed to create mercenary control device.")
        -- Refund credits on failure
        player:addCashCredits(cost)
    end
end