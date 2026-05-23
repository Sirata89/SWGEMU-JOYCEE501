slicingDroidConvoHandler = conv_handler:new {}

-- Global SUI callback object
slicing_droid_sui_callback = {}

-- Debug logging function
function logDebug(message)
	local logFile = io.open("log/slicingbot.log", "a")
	if logFile then
		logFile:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. message .. "\n")
		logFile:close()
	end
	print("SLICING DEBUG: " .. message)
end

function slicingDroidConvoHandler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	return convoTemplate:getScreen("greeting")
end

function slicingDroidConvoHandler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)

	local player = CreatureObject(pPlayer)
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

	if pInventory == nil then
		player:sendSystemMessage("Could not find your inventory.")
		return pConvScreen
	end

	-- Slicing costs
	local sliceCost = 20000
	local dotCost = 100000

	if screenID == "trigger_speed" then
		self:showItemSelectionSUI(pPlayer, pInventory, "speed", sliceCost)
	elseif screenID == "trigger_damage" then
		self:showItemSelectionSUI(pPlayer, pInventory, "damage", sliceCost)
	elseif screenID == "trigger_effectiveness" then
		self:showItemSelectionSUI(pPlayer, pInventory, "effectiveness", sliceCost)
	elseif screenID == "trigger_encumbrance" then
		self:showItemSelectionSUI(pPlayer, pInventory, "encumbrance", sliceCost)
	elseif screenID == "trigger_poison" then
		self:showItemSelectionSUI(pPlayer, pInventory, "poison", dotCost)
	elseif screenID == "trigger_disease" then
		self:showItemSelectionSUI(pPlayer, pInventory, "disease", dotCost)
	elseif screenID == "trigger_fire" then
		self:showItemSelectionSUI(pPlayer, pInventory, "fire", dotCost)
	elseif screenID == "trigger_bleed" then
		self:showItemSelectionSUI(pPlayer, pInventory, "bleed", dotCost)
	elseif screenID == "trigger_container" then
		self:showContainerSUI(pPlayer, pInventory, sliceCost)
	elseif screenID == "trigger_poison_standard" then
		self:showItemSelectionSUI(pPlayer, pInventory, "poison_standard", 100000)
	elseif screenID == "trigger_poison_premium" then
		self:showItemSelectionSUI(pPlayer, pInventory, "poison_premium", 250000)
	elseif screenID == "trigger_poison_elite" then
		self:showItemSelectionSUI(pPlayer, pInventory, "poison_elite", 500000)
	elseif screenID == "trigger_disease_standard" then
		self:showItemSelectionSUI(pPlayer, pInventory, "disease_standard", 100000)
	elseif screenID == "trigger_disease_premium" then
		self:showItemSelectionSUI(pPlayer, pInventory, "disease_premium", 250000)
	elseif screenID == "trigger_disease_elite" then
		self:showItemSelectionSUI(pPlayer, pInventory, "disease_elite", 500000)
	elseif screenID == "trigger_fire_standard" then
		self:showItemSelectionSUI(pPlayer, pInventory, "fire_standard", 100000)
	elseif screenID == "trigger_fire_premium" then
		self:showItemSelectionSUI(pPlayer, pInventory, "fire_premium", 250000)
	elseif screenID == "trigger_fire_elite" then
		self:showItemSelectionSUI(pPlayer, pInventory, "fire_elite", 500000)
	elseif screenID == "trigger_bleed_standard" then
		self:showItemSelectionSUI(pPlayer, pInventory, "bleed_standard", 100000)
	elseif screenID == "trigger_bleed_premium" then
		self:showItemSelectionSUI(pPlayer, pInventory, "bleed_premium", 250000)
	elseif screenID == "trigger_bleed_elite" then
		self:showItemSelectionSUI(pPlayer, pInventory, "bleed_elite", 500000)
	elseif screenID == "trigger_recharge" then
		self:showRechargeSUI(pPlayer, pInventory, 50000)
	end

	return pConvScreen
end

-- Helper function to deduct credits from cash or bank seamlessly
function slicingDroidConvoHandler:deductCredits(pPlayer, cost)
	local player = CreatureObject(pPlayer)
	local cashCredits = player:getCashCredits()
	local bankCredits = player:getBankCredits()
	local totalCredits = cashCredits + bankCredits
	
	if totalCredits < cost then
		return false
	end
	
	-- Deduct from cash first
	if cashCredits >= cost then
		player:subtractCashCredits(cost)
	else
		-- Use all cash, then deduct remaining from bank
		player:subtractCashCredits(cashCredits)
		local remaining = cost - cashCredits
		player:subtractBankCredits(remaining)
	end
	
	return true
end

function slicingDroidConvoHandler:showItemSelectionSUI(pPlayer, pInventory, sliceType, cost)
	local player = CreatureObject(pPlayer)
	local inventorySize = SceneObject(pInventory):getContainerObjectsSize()
	local items = {}
	
	-- Find all unsliced items of the appropriate type
	for i = 0, inventorySize - 1 do
		local pItem = SceneObject(pInventory):getContainerObject(i)
		if pItem ~= nil then
			local tangible = TangibleObject(pItem)
			
			-- Check if item is weapon or armor by gameObjectType
			-- Weapon = 0x20000 to 0x2001F (131072-131103), Armor = 0x100 to 0x108 (256-264)
			-- Components are in 0x40000+ range (262144+)
			local gameObjectType = SceneObject(pItem):getGameObjectType()
			local isWeapon = (gameObjectType >= 131072 and gameObjectType <= 131103) -- Weapons only (0x20000-0x2001F)
			local isArmor = (gameObjectType >= 256 and gameObjectType <= 264) -- All armor types
			local isComponent = (gameObjectType >= 262144) -- Components (0x40000+)
			
			-- For DOT types, only show weapons
			local isDotType = (sliceType == "poison" or sliceType == "disease" or sliceType == "fire" or sliceType == "bleed")
			
			-- Skip components
			if isComponent then
				logDebug(" Skipping component with type: " .. gameObjectType)
			end
			
			if not tangible:isSliced() and not isComponent then
				local shouldInclude = false
				if isDotType then
					shouldInclude = isWeapon -- Only weapons for DOTs
				elseif sliceType == "speed" or sliceType == "damage" then
					shouldInclude = isWeapon
				elseif sliceType == "effectiveness" or sliceType == "encumbrance" then
					shouldInclude = isArmor
				end
				
				if shouldInclude then
					local itemName = SceneObject(pItem):getDisplayedName()
					table.insert(items, {id = SceneObject(pItem):getObjectID(), name = itemName})
				end
			end
		end
	end
	
	if #items == 0 then
		player:sendSystemMessage("You have no unsliced items of that type in your inventory.")
		return
	end
	
	-- Create SUI listbox
	local sui = SuiListBox.new("slicing_droid_sui_callback", "suiItemSelectionCallback")
	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())
	sui.setTitle("Select Item to Slice")
	sui.setPrompt("Select which item you want to slice for " .. sliceType .. ":")
	
	for i, item in ipairs(items) do
		sui.add(item.name, "")
	end
	
	sui.sendTo(pPlayer)
	
	-- Store items table in player data for callback
	local itemsTable = {}
	for i, item in ipairs(items) do
		itemsTable[i] = item.id
	end
	writeStringData(SceneObject(pPlayer):getObjectID() .. ":slicing_items", table.concat(itemsTable, ","))
	
	-- Store slice type in player data for callback (use writeStringData for string values)
	writeStringData(SceneObject(pPlayer):getObjectID() .. ":slicing_type", sliceType)
	writeData(SceneObject(pPlayer):getObjectID() .. ":slicing_cost", cost)
end

function slicingDroidConvoHandler:showContainerSUI(pPlayer, pInventory, cost)
	local player = CreatureObject(pPlayer)
	local inventorySize = SceneObject(pInventory):getContainerObjectsSize()
	local items = {}
	
	-- Find all locked and sliceable containers
	for i = 0, inventorySize - 1 do
		local pItem = SceneObject(pInventory):getContainerObject(i)
		if pItem ~= nil then
			-- Check if it's a container (gameObjectType 0x2005 = 8193)
			local gameObjectType = SceneObject(pItem):getGameObjectType()
			local isContainer = (gameObjectType == 8193 or gameObjectType == 8276) -- CONTAINER or STATICLOOTCONTAINER
			
			if isContainer then
				-- Check if locked and sliceable via Lua method if available
				-- For now, we'll assume containers can be sliced
				local itemName = SceneObject(pItem):getDisplayedName()
				table.insert(items, {id = SceneObject(pItem):getObjectID(), name = itemName})
			end
		end
	end
	
	if #items == 0 then
		player:sendSystemMessage("You have no locked containers in your inventory.")
		return
	end
	
	-- Create SUI listbox
	local sui = SuiListBox.new("slicing_droid_sui_callback", "suiContainerCallback")
	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())
	sui.setTitle("Select Container")
	sui.setPrompt("Select which locked container you want to slice:")
	
	for i, item in ipairs(items) do
		sui.add(item.name, "")
	end
	
	sui.sendTo(pPlayer)
	
	-- Store items table in player data for callback
	local itemsTable = {}
	for i, item in ipairs(items) do
		itemsTable[i] = item.id
	end
	writeStringData(SceneObject(pPlayer):getObjectID() .. ":slicing_items", table.concat(itemsTable, ","))
	
	-- Store cost in player data for callback
	writeData(SceneObject(pPlayer):getObjectID() .. ":slicing_cost", cost)
end

function slicingDroidConvoHandler:showRechargeSUI(pPlayer, pInventory, cost)
	local player = CreatureObject(pPlayer)
	local inventorySize = SceneObject(pInventory):getContainerObjectsSize()
	local items = {}
	
	-- Find all weapons with DOTs
	for i = 0, inventorySize - 1 do
		local pItem = SceneObject(pInventory):getContainerObject(i)
		if pItem ~= nil then
			local gameObjectType = SceneObject(pItem):getGameObjectType()
			local isWeapon = (gameObjectType >= 0x20000 and gameObjectType <= 0x2001F)
			
			if isWeapon then
				-- Check if weapon has a DOT by trying to get the dot type
				local weapon = WeaponObject(pItem)
				if weapon ~= nil and weapon:getDotType() > 0 then
					local itemName = SceneObject(pItem):getDisplayedName()
					local currentUses = weapon:getDotUses()
					table.insert(items, {id = SceneObject(pItem):getObjectID(), name = itemName .. " (" .. currentUses .. " uses)"})
				end
			end
		end
	end
	
	if #items == 0 then
		player:sendSystemMessage("You have no weapons with DOTs in your inventory.")
		return
	end
	
	-- Create SUI listbox
	local sui = SuiListBox.new("slicing_droid_sui_callback", "suiRechargeCallback")
	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())
	sui.setTitle("Select Weapon to Recharge")
	sui.setPrompt("Select which weapon you want to recharge DOT uses for (+500 uses):")
	
	for i, item in ipairs(items) do
		sui.add(item.name, "")
	end
	
	sui.sendTo(pPlayer)
	
	-- Store items table in player data for callback
	local itemsTable = {}
	for i, item in ipairs(items) do
		itemsTable[i] = item.id
	end
	writeStringData(SceneObject(pPlayer):getObjectID() .. ":slicing_items", table.concat(itemsTable, ","))
	
	-- Store cost in player data for callback
	writeData(SceneObject(pPlayer):getObjectID() .. ":slicing_cost", cost)
end

-- Global SUI callback function
function slicing_droid_sui_callback:suiItemSelectionCallback(pPlayer, pSui, eventIndex, arg0)
	local playerID = SceneObject(pPlayer):getObjectID()
	local player = CreatureObject(pPlayer)
	
	logDebug(" suiItemSelectionCallback called, eventIndex: " .. eventIndex .. ", arg0: " .. arg0)
	
	if eventIndex == 1 then -- Cancel button
		deleteData(playerID .. ":slicing_type")
		deleteData(playerID .. ":slicing_cost")
		deleteStringData(playerID .. ":slicing_items")
		return
	end
	
	local selectedIndex = tonumber(arg0)
	local itemsString = readStringData(playerID .. ":slicing_items")
	local sliceType = readStringData(playerID .. ":slicing_type")
	local cost = readData(playerID .. ":slicing_cost")
	
	logDebug(" selectedIndex: " .. selectedIndex .. ", sliceType: " .. sliceType)
	
	deleteStringData(playerID .. ":slicing_items")
	deleteStringData(playerID .. ":slicing_type")
	deleteData(playerID .. ":slicing_cost")
	
	if selectedIndex == nil or itemsString == nil or sliceType == nil then
		logDebug(" selectedIndex, itemsString, or sliceType is nil")
		return
	end
	
	-- Parse items table and get the selected item ID
	local itemsTable = {}
	for id in string.gmatch(itemsString, "[^,]+") do
		table.insert(itemsTable, tonumber(id))
	end
	
	local itemID = itemsTable[selectedIndex + 1] -- Lua arrays are 1-indexed, SUI is 0-indexed
	
	if itemID == nil then
		logDebug(" itemID is nil from index " .. selectedIndex)
		return
	end
	
	logDebug(" Retrieved itemID: " .. itemID)
	
	-- Call the handler method
	local handler = slicingDroidConvoHandler
	handler:performSliceOnItem(pPlayer, itemID, sliceType, cost)
end

function slicing_droid_sui_callback:suiContainerCallback(pPlayer, pSui, eventIndex, arg0)
	local playerID = SceneObject(pPlayer):getObjectID()
	local player = CreatureObject(pPlayer)
	
	logDebug(" suiContainerCallback called, eventIndex: " .. eventIndex .. ", arg0: " .. arg0)
	
	if eventIndex == 1 then -- Cancel button
		deleteStringData(playerID .. ":slicing_items")
		deleteData(playerID .. ":slicing_cost")
		return
	end
	
	local selectedIndex = tonumber(arg0)
	local itemsString = readStringData(playerID .. ":slicing_items")
	local cost = readData(playerID .. ":slicing_cost")
	
	deleteStringData(playerID .. ":slicing_items")
	deleteData(playerID .. ":slicing_cost")
	
	if selectedIndex == nil or itemsString == nil then
		logDebug(" selectedIndex or itemsString is nil")
		return
	end
	
	-- Parse items table and get the selected item ID
	local itemsTable = {}
	for id in string.gmatch(itemsString, "[^,]+") do
		table.insert(itemsTable, tonumber(id))
	end
	
	local itemID = itemsTable[selectedIndex + 1] -- Lua arrays are 1-indexed, SUI is 0-indexed
	
	if itemID == nil then
		logDebug(" itemID is nil from index " .. selectedIndex)
		return
	end
	
	logDebug(" Retrieved containerID: " .. itemID)
	
	-- Call the handler method
	local handler = slicingDroidConvoHandler
	handler:performContainerSlice(pPlayer, itemID, cost)
end

function slicing_droid_sui_callback:suiRechargeCallback(pPlayer, pSui, eventIndex, arg0)
	local playerID = SceneObject(pPlayer):getObjectID()
	local player = CreatureObject(pPlayer)
	
	logDebug(" suiRechargeCallback called, eventIndex: " .. eventIndex .. ", arg0: " .. arg0)
	
	if eventIndex == 1 then -- Cancel button
		deleteStringData(playerID .. ":slicing_items")
		deleteData(playerID .. ":slicing_cost")
		return
	end
	
	local selectedIndex = tonumber(arg0)
	local itemsString = readStringData(playerID .. ":slicing_items")
	local cost = readData(playerID .. ":slicing_cost")
	
	deleteStringData(playerID .. ":slicing_items")
	deleteData(playerID .. ":slicing_cost")
	
	if selectedIndex == nil or itemsString == nil then
		logDebug(" selectedIndex or itemsString is nil")
		return
	end
	
	-- Parse items table and get the selected item ID
	local itemsTable = {}
	for id in string.gmatch(itemsString, "[^,]+") do
		table.insert(itemsTable, tonumber(id))
	end
	
	local itemID = itemsTable[selectedIndex + 1] -- Lua arrays are 1-indexed, SUI is 0-indexed
	
	if itemID == nil then
		logDebug(" itemID is nil from index " .. selectedIndex)
		return
	end
	
	logDebug(" Retrieved weaponID: " .. itemID)
	
	-- Call the handler method
	local handler = slicingDroidConvoHandler
	handler:performRecharge(pPlayer, itemID, cost)
end

function slicingDroidConvoHandler:performRecharge(pPlayer, itemID, cost)
	local player = CreatureObject(pPlayer)
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")
	
	if pInventory == nil then
		player:sendSystemMessage("Could not find your inventory.")
		return
	end
	
	-- Check credits
	if not self:deductCredits(pPlayer, cost) then
		player:sendSystemMessage("You need " .. cost .. " credits (cash or bank) for this recharge.")
		return
	end
	
	-- Find the specific weapon
	local pItem = nil
	local inventorySize = SceneObject(pInventory):getContainerObjectsSize()
	
	logDebug(" Searching for weaponID: " .. itemID .. " in inventory with " .. inventorySize .. " items")
	
	for i = 0, inventorySize - 1 do
		local pInvItem = SceneObject(pInventory):getContainerObject(i)
		if pInvItem ~= nil then
			local invItemID = SceneObject(pInvItem):getObjectID()
			if invItemID == itemID then
				pItem = pInvItem
				logDebug(" Found weapon!")
				break
			end
		end
	end
	
	if pItem == nil then
		player:sendSystemMessage("Weapon not found in inventory.")
		return
	end
	
	-- Deduct credits
	player:subtractCashCredits(cost)
	
	-- Call native C++ function to recharge DOT uses
	logDebug(" Calling rechargeDot with 500 additional uses")
	local success, newUses = rechargeDot(pItem, 500)
	logDebug(" rechargeDot returned: " .. tostring(success) .. ", newUses: " .. tostring(newUses))
	
	if success then
		player:sendSystemMessage("R2-SLIC successfully recharged your weapon! (" .. newUses .. " total uses)")
	else
		player:sendSystemMessage("Failed to recharge. The weapon may not have a DOT.")
		player:addCashCredits(cost)
	end
end

function slicingDroidConvoHandler:performContainerSlice(pPlayer, itemID, cost)
	local player = CreatureObject(pPlayer)
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")
	
	if pInventory == nil then
		player:sendSystemMessage("Could not find your inventory.")
		return
	end
	
	-- Check credits
	if not self:deductCredits(pPlayer, cost) then
		player:sendSystemMessage("You need " .. cost .. " credits (cash or bank) for this slice.")
		return
	end
	
	-- Find the specific container
	local pItem = nil
	local inventorySize = SceneObject(pInventory):getContainerObjectsSize()
	
	logDebug(" Searching for containerID: " .. itemID .. " in inventory with " .. inventorySize .. " items")
	
	for i = 0, inventorySize - 1 do
		local pInvItem = SceneObject(pInventory):getContainerObject(i)
		if pInvItem ~= nil then
			local invItemID = SceneObject(pInvItem):getObjectID()
			if invItemID == itemID then
				pItem = pInvItem
				logDebug(" Found container!")
				break
			end
		end
	end
	
	if pItem == nil then
		player:sendSystemMessage("Container not found in inventory.")
		return
	end
	
	-- Deduct credits
	player:subtractCashCredits(cost)
	
	-- Call native C++ function to slice container
	logDebug(" Calling sliceContainer")
	local success = sliceContainer(pItem)
	logDebug(" sliceContainer returned: " .. tostring(success))
	
	if success then
		player:sendSystemMessage("R2-SLIC successfully sliced your container!")
	else
		player:sendSystemMessage("Failed to slice container. The container may not be locked or sliceable.")
		player:addCashCredits(cost)
	end
end

function slicingDroidConvoHandler:performSliceOnItem(pPlayer, itemID, sliceType, cost)
	local player = CreatureObject(pPlayer)
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")
	
	if pInventory == nil then
		player:sendSystemMessage("Could not find your inventory.")
		return
	end
	
	-- Check credits
	if not self:deductCredits(pPlayer, cost) then
		player:sendSystemMessage("You need " .. cost .. " credits (cash or bank) for this slice.")
		return
	end
	
	-- Find the specific item
	local pItem = nil
	local inventorySize = SceneObject(pInventory):getContainerObjectsSize()
	
	logDebug(" Searching for itemID: " .. itemID .. " in inventory with " .. inventorySize .. " items")
	
	for i = 0, inventorySize - 1 do
		local pInvItem = SceneObject(pInventory):getContainerObject(i)
		if pInvItem ~= nil then
			local invItemID = SceneObject(pInvItem):getObjectID()
			logDebug(" Inventory item " .. i .. " has ID: " .. invItemID)
			if invItemID == itemID then
				pItem = pInvItem
				logDebug(" Found item!")
				break
			end
		end
	end
	
	if pItem == nil then
		player:sendSystemMessage("Item not found in inventory.")
		return
	end
	
	-- Check if already sliced
	local tangible = TangibleObject(pItem)
	if tangible:isSliced() then
		player:sendSystemMessage("This item has already been sliced.")
		return
	end
	
	-- DEBUG: Show item type
	local gameObjectType = SceneObject(pItem):getGameObjectType()
	logDebug(" Item type: " .. gameObjectType .. ", Slice type: " .. sliceType)
	
	-- Apply slice or DOT
	local result = 0
	local dotType = nil
	local customUses = -1
	
	-- Parse sliceType for tier-based DOTs
	local isDotTier = false
	for _, dt in ipairs({"poison", "disease", "fire", "bleed"}) do
		if string.find(sliceType, dt) == 1 then
			isDotTier = true
			dotType = dt
			local tier = string.sub(sliceType, string.len(dt) + 2) -- Extract tier (standard, premium, elite)
			if tier == "standard" then
				customUses = math.random(500) + 500 -- 500-1000
			elseif tier == "premium" then
				customUses = math.random(500) + 2000 -- 2000-2500
			elseif tier == "elite" then
				customUses = math.random(500) + 4000 -- 4000-4500
			end
			break
		end
	end
	
	if isDotTier then
		logDebug(" Calling applyDot with customUses: " .. customUses)
		result = self:applyDot(pItem, dotType, customUses)
		logDebug(" applyDot returned: " .. tostring(result))
	elseif sliceType == "poison" or sliceType == "disease" or sliceType == "fire" or sliceType == "bleed" then
		logDebug(" Calling applyDot")
		result = self:applyDot(pItem, sliceType)
		logDebug(" applyDot returned: " .. tostring(result))
	else
		logDebug(" Calling applySlice")
		result = self:applySlice(pItem, sliceType)
		logDebug(" applySlice returned: " .. tostring(result))
	end
	
	if result > 0 then
		if isDotTier then
			player:sendSystemMessage("R2-SLIC successfully applied " .. dotType .. " DOT to your item! (" .. customUses .. " uses)")
		else
			local slicePercent = math.floor(result)
			player:sendSystemMessage("R2-SLIC successfully applied " .. sliceType .. " to your item! (" .. slicePercent .. "% (35% max))")
		end
	else
		player:sendSystemMessage("The operation failed. Your credits have been refunded.")
		player:addCashCredits(cost)
	end
end

function slicingDroidConvoHandler:applySlice(pItem, sliceType)
	-- Call native C++ function to apply slice and get percentage
	local percentage = applySlice(pItem, sliceType)
	return percentage
end

function slicingDroidConvoHandler:applyDot(pItem, dotType, customUses)
	-- Call native C++ function to apply DOT
	if customUses and customUses > 0 then
		return applyDot(pItem, dotType, customUses)
	else
		return applyDot(pItem, dotType)
	end
end