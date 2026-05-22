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
	end

	return pConvScreen
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

function slicingDroidConvoHandler:performSliceOnItem(pPlayer, itemID, sliceType, cost)
	local player = CreatureObject(pPlayer)
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")
	
	if pInventory == nil then
		player:sendSystemMessage("Could not find your inventory.")
		return
	end
	
	-- Check credits
	if player:getCashCredits() < cost then
		player:sendSystemMessage("You need " .. cost .. " credits for this slice.")
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
	
	-- Deduct credits
	player:subtractCashCredits(cost)
	
	-- DEBUG: Show item type
	local gameObjectType = SceneObject(pItem):getGameObjectType()
	logDebug(" Item type: " .. gameObjectType .. ", Slice type: " .. sliceType)
	
	-- Apply slice or DOT
	local success = false
	if sliceType == "poison" or sliceType == "disease" or sliceType == "fire" or sliceType == "bleed" then
		logDebug(" Calling applyDot")
		success = self:applyDot(pItem, sliceType)
		logDebug(" applyDot returned: " .. tostring(success))
	else
		logDebug(" Calling applySlice")
		success = self:applySlice(pItem, sliceType)
		logDebug(" applySlice returned: " .. tostring(success))
	end
	
	if success then
		player:sendSystemMessage("R2-SLIC successfully applied " .. sliceType .. " to your item!")
	else
		player:sendSystemMessage("The operation failed. Your credits have been refunded.")
		player:addCashCredits(cost)
	end
end

function slicingDroidConvoHandler:applySlice(pItem, sliceType)
	-- Call native C++ function to apply slice
	local success = applySlice(pItem, sliceType)
	return success
end

function slicingDroidConvoHandler:applyDot(pItem, dotType)
	-- Call native C++ function to apply DOT
	local success = applyDot(pItem, dotType)
	return success
end