local ObjectManager = require("managers.object.object_manager")
-- local Logger = require("utils.logger")   -- remove if not used

HiringAgentScreenPlay = ScreenPlay:new {}     -- Global, no "local"

registerScreenPlay("HiringAgentScreenPlay", true)

function HiringAgentScreenPlay:start()
  if (isZoneEnabled("naboo")) then
    self:spawnNaboo()
  end
end

function HiringAgentScreenPlay:spawnNaboo()
  -- Theed Starport
  spawnMobile("naboo", "hiring_agent", 300, -18.5, 0.7, -67.8, 126.881, 1692102)
end

-- ====================== HIRING LOGIC ======================
function HiringAgentScreenPlay:tryHireCompanion(pPlayer, companionTemplate, cost, durationSeconds, customName)
    if pPlayer == nil then return end

    local player = LuaCreatureObject(pPlayer)

    -- Check if player already has a companion (optional limit)
    if self:hasActiveCompanion(pPlayer) then
        player:sendSystemMessage("You already have a companion. Dismiss them first.")
        return
    end

    if player:getCashCredits() < cost then
        player:sendSystemMessage("You need " .. cost .. " credits to hire this companion.")
        return
    end

    player:subtractCashCredits(cost)

    -- Spawn the companion near the player
    local pCompanion = spawnMobile(
        player:getZoneName(), 
        companionTemplate, 
        0, 
        player:getPositionX() + 1.5, 
        player:getPositionY(), 
        player:getPositionZ() + 0.5, 
        getRandomNumber(-90, 90), 
        player:getParentID()
    )

    if pCompanion then
        local companion = LuaCreatureObject(pCompanion)
        
        -- Set name
        if customName then
            companion:setCustomObjectName(customName)
        else
            companion:setCustomObjectName("Hired " .. companionTemplate:gsub("_", " "))
        end

        -- Make them follow the player
        companion:setFollowCreature(pPlayer)
        companion:setFaction(player:getFaction())

        -- Auto add to group so mission difficulty scales
        player:addToGroup(pCompanion)

        player:sendSystemMessage("Sylara has sent a companion to fight by your side!")

        -- Despawn timer
        if durationSeconds and durationSeconds > 0 then
            createEvent(durationSeconds * 1000, "HiringAgentScreenPlay", "despawnCompanion", pCompanion, "")
        end

        -- Optional: Track the companion on the player for easy dismissal
        CreatureObject(pPlayer):setStoredObject("current_companion", pCompanion)
    else
        player:sendSystemMessage("Failed to hire companion. Try again.")
    end
end

function HiringAgentScreenPlay:despawnCompanion(pCompanion)
    if pCompanion then
        SceneObject(pCompanion):destroyObjectFromWorld()
        SceneObject(pCompanion):destroyObjectFromDatabase()
    end
end

function HiringAgentScreenPlay:hasActiveCompanion(pPlayer)
    local companion = CreatureObject(pPlayer):getStoredObject("current_companion")
    if companion and SceneObject(companion):isValid() then
        return true
    end
    return false
end

function HiringAgentScreenPlay:dismissCompanion(pPlayer)
    local pCompanion = CreatureObject(pPlayer):getStoredObject("current_companion")
    if pCompanion then
        self:despawnCompanion(pCompanion)
        CreatureObject(pPlayer):setStoredObject("current_companion", nil)
        CreatureObject(pPlayer):sendSystemMessage("Your companion has been dismissed.")
    else
        CreatureObject(pPlayer):sendSystemMessage("You have no active companion.")
    end
end