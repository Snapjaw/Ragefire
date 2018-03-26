inventoryHelper = require("inventoryHelper")

local menuHelper = {}
menuHelper.conditions = {}
menuHelper.effects = {}
menuHelper.destinations = {}

function menuHelper.conditions.requireItem(inputRefId, inputCount)
    local condition = {
        conditionType = "item",
        refId = inputRefId,
        count = inputCount
    }

    return condition
end

function menuHelper.conditions.requireAttribute(inputName, inputValue)
    local condition = {
        conditionType = "attribute",
        attributeName = inputName,
        attributeValue = inputValue
    }

    return condition
end

function menuHelper.conditions.requireSkill(inputName, inputValue)
    local condition = {
        conditionType = "skill",
        skillName = inputName,
        skillValue = inputValue
    }

    return condition
end

function menuHelper.effects.giveItem(inputRefId, inputCount)
    local effect = {
        effectType = "item",
        action = "give",
        refId = inputRefId,
        count = inputCount
    }

    return effect
end

function menuHelper.effects.removeItem(inputRefId, inputCount)
    local effect = {
        effectType = "item",
        action = "remove",
        refId = inputRefId,
        count = inputCount
    }

    return effect
end

function menuHelper.effects.setDataVariable(inputVariable, inputValue)
    local effect = {
        effectType = "variable",
        action = "data",
        variable = inputVariable,
        value = inputValue
    }

    return effect
end

function menuHelper.effects.runFunction(inputFunctionName, inputArguments)
    local effect = {
        effectType = "function",
        functionName = inputFunctionName,
        arguments = inputArguments
    }

    return effect
end

function menuHelper.destinations.setDefault(inputMenu, inputEffects)
    local destination = {
        targetMenu = inputMenu,
        effects = inputEffects
    }

    return destination
end

function menuHelper.destinations.setFromCustomVariable(inputVariable)
    local destination = {
        customVariable = inputVariable
    }

    return destination
end

function menuHelper.destinations.setConditional(inputMenu, inputConditions, inputEffects)
    local destination = {
        targetMenu = inputMenu,
        conditions = inputConditions,
        effects = inputEffects
    }

    return destination
end

function menuHelper.checkCondition(pid, condition)

    local targetPlayer = Players[pid]

    if condition.conditionType == "item" then

        if inventoryHelper.containsItem(targetPlayer.data.inventory, condition.refId) then
            local itemIndex = inventoryHelper.getItemIndex(targetPlayer.data.inventory, condition.refId)
            local item = targetPlayer.data.inventory[itemIndex]

            if item.count >= condition.count then
                return true
            end
        end
    elseif condition.conditionType == "attribute" then

        if targetPlayer.data.skills[condition.attributeName] >= condition.attributeValue then
            return true
        end
    elseif condition.conditionType == "skill" then

        if targetPlayer.data.skills[condition.skillName] >= condition.skillValue then
            return true
        end
    end

    return false
end

function menuHelper.processEffects(pid, effects)

    if effects == nil then return end

    local targetPlayer = Players[pid]
    local shouldReloadInventory = false

    for _, effect in ipairs(effects) do

        if effect.effectType == "item" then

            shouldReloadInventory = true

            if effect.action == "give" then

                local item = { refId = effect.refId, count = effect.count, charge = -1 }
                table.insert(targetPlayer.data.inventory, item)

            elseif effect.action == "remove" then

                if inventoryHelper.containsItem(targetPlayer.data.inventory, effect.refId) then

                    -- If the item is equipped by the target, unequip it first
                    if inventoryHelper.containsItem(targetPlayer.data.equipment, effect.refId) then
                        local equipmentItemIndex = inventoryHelper.getItemIndex(targetPlayer.data.equipment, effect.refId)
                        targetPlayer.data.equipment[equipmentItemIndex] = nil
                    end

                    local inventoryItemIndex = inventoryHelper.getItemIndex(targetPlayer.data.inventory, effect.refId)
                    local item = targetPlayer.data.inventory[inventoryItemIndex]
                    item.count = item.count - effect.count

                    if item.count < 0 then item.count = 0 end

                    targetPlayer.data.inventory[inventoryItemIndex] = item
                end
            end
        elseif effect.effectType == "variable" then

            if effect.action == "data" then
                targetPlayer.data[effect.variable] = effect.value
            end
			
        elseif effect.effectType == "function" then

            local arguments = effect.arguments

            if arguments == nil then
                targetPlayer[effect.functionName](targetPlayer)
            else
                targetPlayer[effect.functionName](targetPlayer, unpack(arguments))
            end
        end
		
    end

    targetPlayer:Save()

    if shouldReloadInventory then
        targetPlayer:LoadInventory()
        targetPlayer:LoadEquipment()
    end
end

function menuHelper.getButtonDestination(pid, menuIndex, buttonIndex)

    if Menus[menuIndex] ~= nil and Menus[menuIndex].buttons[buttonIndex] ~= nil then

        local button = Menus[menuIndex].buttons[buttonIndex]
        local defaultDestination = {}

        if button.destinations ~= nil then

            for _, destination in ipairs(button.destinations) do

                if destination.customVariable ~= nil then
                    local customVariable = destination.customVariable
                    destination.targetMenu = Players[pid][customVariable]
                end

                if destination.conditions == nil then
                    defaultDestination = destination
                else
                    local conditionCount = table.maxn(destination.conditions)
                    local conditionsMet = 0

                    for _, condition in ipairs(destination.conditions) do

                        if menuHelper.checkCondition(pid, condition) then
                            conditionsMet = conditionsMet + 1
                        end
                    end

                    if conditionsMet == conditionCount then
                        return destination
                    end
                end
            end
        end

        return defaultDestination
    end

    return {}
end

function menuHelper.displayMenu(pid, menuIndex)

    if menuIndex == nil or Menus[menuIndex] == nil then return end

    local text = Menus[menuIndex].text
    local buttonList = ""

    for buttonIndex, button in ipairs(Menus[menuIndex].buttons) do
        buttonList = buttonList .. button.caption

        if buttonIndex < tableHelper.getCount(Menus[menuIndex].buttons) then
            buttonList = buttonList .. ";"
        end
    end

    tes3mp.CustomMessageBox(pid, -1,  text, buttonList)
end

return menuHelper
