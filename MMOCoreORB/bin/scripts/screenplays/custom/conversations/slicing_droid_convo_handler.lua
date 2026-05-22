slicingDroidConvoHandler = conv_handler:new {}

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

	-- Slicing cost (set to 0 for testing)
	local sliceCost = 0

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
			local isWeapon = tangible:isWeaponObject()
			local isArmor = tangible:isArmorObject()
			
			-- For DOT types, only show weapons
			local isDotType = (sliceType == "poison" or sliceType == "disease" or sliceType == "fire" or sliceType == "bleed")
			
			if not tangible:isSliced() and ((isDotType and isWeapon) or (not isDotType and ((isWeapon and (sliceType == "speed" or sliceType == "damage")) or (isArmor and (sliceType == "effectiveness" or sliceType == "encumbrance"))))) then
				local itemName = SceneObject(pItem):getDisplayedName()
				table.insert(items, {id = SceneObject(pItem):getObjectID(), name = itemName})
			end
		end
	end
	
	if #items == 0 then
		player:sendSystemMessage("You have no unsliced items of that type in your inventory.")
		return
	end
	
	-- Create SUI listbox
	local sui = SuiListBox.new("SlicingDroidConvoHandler", "suiItemSelectionCallback")
	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())
	sui.setTitle("Select Item to Slice")
	sui.setPrompt("Select which item you want to slice for " .. sliceType .. ":")
	
	for i, item in ipairs(items) do
		sui.add(item.name, tostring(item.id))
	end
	
	sui.sendTo(pPlayer)
	
	-- Store slice type in player data for callback
	writeData(SceneObject(pPlayer):getObjectID() .. ":slicing_type", sliceType)
	writeData(SceneObject(pPlayer):getObjectID() .. ":slicing_cost", cost)
end

function slicingDroidConvoHandler:suiItemSelectionCallback(pPlayer, pSui, eventIndex, arg0)
	local playerID = SceneObject(pPlayer):getObjectID()
	
	if eventIndex == 1 then -- Cancel button
		deleteData(playerID .. ":slicing_type")
		deleteData(playerID .. ":slicing_cost")
		return
	end
	
	local itemID = tonumber(arg0)
	local sliceType = readData(playerID .. ":slicing_type")
	local cost = readData(playerID .. ":slicing_cost")
	
	deleteData(playerID .. ":slicing_type")
	deleteData(playerID .. ":slicing_cost")
	
	if itemID == nil or sliceType == nil then
		return
	end
	
	self:performSliceOnItem(pPlayer, itemID, sliceType, cost)
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
	
	for i = 0, inventorySize - 1 do
		local pInvItem = SceneObject(pInventory):getContainerObject(i)
		if pInvItem ~= nil and SceneObject(pInvItem):getObjectID() == itemID then
			pItem = pInvItem
			break
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
	
	-- Check if item is a weapon for DOT types
	local isDotType = (sliceType == "poison" or sliceType == "disease" or sliceType == "fire" or sliceType == "bleed")
	if isDotType and not tangible:isWeaponObject() then
		player:sendSystemMessage("DOTs can only be applied to weapons.")
		return
	end
	
	-- Deduct credits
	player:subtractCashCredits(cost)
	
	-- Apply slice or DOT
	local success = false
	if isDotType then
		success = self:applyDot(pItem, sliceType)
	else
		success = self:applySlice(pItem, sliceType)
	end
	
	if success then
		player:sendSystemMessage("R2-SLIC successfully applied " .. sliceType .. " to your item!")
	else
		player:sendSystemMessage("The operation failed. Your credits have been refunded.")
		player:addCashCredits(cost)
	end
end

function slicingDroidConvoHandler:applySlice(pItem, sliceType)
	local tangible = TangibleObject(pItem)
	
	-- Generate random slice percentage between 20-35% (master smuggler quality)
	local slicePercent = getRandomNumber(20, 35) / 100.0

	if sliceType == "speed" then
		local weapon = WeaponObject(pItem)
		if weapon ~= nil then
			weapon:setSpeedSlice(slicePercent)
			weapon:setSliced(true)
			return true
		end
	elseif sliceType == "damage" then
		local weapon = WeaponObject(pItem)
		if weapon ~= nil then
			-- Remove powerup if present
			if weapon:hasPowerup() then
				local pPowerup = weapon:removePowerup()
				if pPowerup ~= nil then
					SceneObject(pPowerup):destroyObjectFromWorld(true)
					SceneObject(pPowerup):destroyObjectFromDatabase(true)
				end
			end
			weapon:setDamageSlice(slicePercent)
			weapon:setSliced(true)
			return true
		end
	elseif sliceType == "effectiveness" then
		local armor = ArmorObject(pItem)
		if armor ~= nil then
			armor:setEffectivenessSlice(slicePercent)
			armor:setSliced(true)
			return true
		end
	elseif sliceType == "encumbrance" then
		local armor = ArmorObject(pItem)
		if armor ~= nil then
			armor:setEncumbranceSlice(slicePercent)
			armor:setSliced(true)
			return true
		end
	end

	return false
end

function slicingDroidConvoHandler:applyDot(pItem, dotType)
	local weapon = WeaponObject(pItem)
	if weapon == nil then
		return false
	end
	
	-- DOT types: 1 = Poison, 2 = Disease, 3 = Fire, 4 = Bleed
	local dotTypeID = 0
	if dotType == "poison" then
		dotTypeID = 1
	elseif dotType == "disease" then
		dotTypeID = 2
	elseif dotType == "fire" then
		dotTypeID = 3
	elseif dotType == "bleed" then
		dotTypeID = 4
	end
	
	-- Generate random DOT values
	-- Attribute: 0 = Health, 3 = Action, 6 = Mind
	local dotAttribute = getRandomNumber(0, 2) * 3
	local dotStrength = getRandomNumber(50, 150) -- Damage per tick
	local dotDuration = getRandomNumber(30, 60) -- Duration in seconds
	local dotPotency = getRandomNumber(100, 200) -- Resistance check
	local dotUses = getRandomNumber(500, 1000) -- Number of uses
	
	-- Add DOT to weapon
	weapon:addDotType(dotTypeID)
	weapon:addDotAttribute(dotAttribute)
	weapon:addDotStrength(dotStrength)
	weapon:addDotDuration(dotDuration)
	weapon:addDotPotency(dotPotency)
	weapon:addDotUses(dotUses)
	
	weapon:setSliced(true)
	return true
end
				end
			end
			weapon:setDamageSlice(slicePercent)
			weapon:setSliced(true)
			return true
		end
	elseif sliceType == "effectiveness" then
		local armor = ArmorObject(pItem)
		if armor ~= nil then
			armor:setEffectivenessSlice(slicePercent)
			armor:setSliced(true)
			return true
		end
	elseif sliceType == "encumbrance" then
		local armor = ArmorObject(pItem)
		if armor ~= nil then
			armor:setEncumbranceSlice(slicePercent)
			armor:setSliced(true)
			return true
		end
	end

	return false
end
end
