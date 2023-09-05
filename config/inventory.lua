Config.UseCustomInventory = false --Set to true to use a custom inventory (false will check for default inventory systems (qb-inventory/ox_inventory)) NOTE: IF using a custom framework this check is ignored and you MUST setup these inventory functions

------------------------------------------------------INVENTORY FUNCTIONS-----------------------------------------------------
Config.Inventory = {
    CreateUseableItemFunction = function(ItemName, TriggerEvent, Args) --** SERVER SIDE CODE ** below this line to create useable item (ItemName = the item used 'lockpick'/ TriggerEvent = event to be fired when item used / Args = data sent along with the function example: IsAdvanced = true)
        --TriggerClientEvent(TriggerEvent, src, Item, Args) --This must be called once you verify the item as createable and usable
        --You can pass ItemName instead of Item but it is perferred to pass a table of the actual items data

        --[[ QBCore.Functions.CreateUseableItem(ItemName, function(source, Item) --QBCORE FRAMEWORK EXAMPLE
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            if Player.Functions.GetItemBySlot(Item.slot) then 
                if Player.Functions.GetItemBySlot(Item.slot).name == ItemName then 
                    TriggerClientEvent(TriggerEvent, src, Item, Args) --This must be called once you verify the item as createable and usable
                end
            end
        end) ]]
    end,
    RemoveItemFunction = function(source, Item, cb) --** SERVER SIDE CODE ** below to verify player has the item you used and we can remove it from them. Must cb(true) and cb(false) correctly for script to not hang waiting for a result.
        --Item is passed as a table of the item details
        --cb(true) if item is removed / cb(false) if it could not be removed

        --[[ local src = source 
        local Player = QBCore.Functions.GetPlayer(src) --QBCORE FRAMEWORK EXAMPLE
        if Player then 
            if Player.Functions.GetItemBySlot(Item.slot) then 
                if Player.Functions.GetItemBySlot(Item.slot).name == Item.name then 
                    if Player.Functions.RemoveItem(Item.name, 1, Item.slot) then 
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Item.name], "remove")
                        cb(true)
                    else
                        MK_CORE.Notify(src, {Message = locale('lost_item'), Type = 'error', Duration = 5000})
                        cb(false)
                    end
                else
                    MK_CORE.Notify(src, {Message = locale('lost_item'), Type = 'error', Duration = 5000})
                    cb(false)
                end
            else
                MK_CORE.Notify(src, {Message = locale('lost_item'), Type = 'error', Duration = 5000})
                cb(false)
            end
        else
            MK_CORE.Notify(src, {Message = locale('lost_item'), Type = 'error', Duration = 5000})
            cb(false)
        end ]]
    end,
    AddItemFunction = function(source, ItemName, Info, cb) --** SERVER SIDE CODE ** below to add an item to player inventory. must cb(true) if item was given or cb(false) if item failed to give or script will hang waiting for this cb result
        --Info is the items metadata
        --If you do not set the metadata up properly with your inventory keyfobs will not work.
        --Info is passed as a table with the following keys:
            --brand = vehicle brand
            --name = vehicle name
            --id = keyfob id
            --plate = vehicle plate
        -- cb(true) if item was added / cb(false) if it could not be added

        --[[ local src = source
        local Player = QBCore.Functions.GetPlayer(src) --QBCORE FRAMEWORK EXAMPLE
        if Player then 
            if Player.Functions.AddItem(ItemName, 1, false, Info) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ItemName], "add")
                cb(true)
            else
                MK_CORE.Notify(src, {Message = locale('cant_carry_item'), Type = 'error', Duration = 5000})
                cb(false)
            end
        else
            cb(false)
        end ]]
    end,
    HasFobServer = function(FobId, PlayerSource) --** SERVER SIDE CODE ** check if player has a keyfob item with correct metadata in inventory **DOES NOT NEED TO BE SETUP IF NOT USING KEYS AS ITEMS**
        --Setup custom function to check if player has keyfob item with metadata containing FobId param
            --use keyfob item name here to check or you can use Config.KeysAsItem.PlayerOwned.ItemName
        --Must return true or false

        --[[ local src = PlayerSource
        local HasItem = false
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then 
            if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
                for key, value in pairs(Player.PlayerData.items) do 
                    if Player.PlayerData.items[key] ~= nil then 
                        if value.name == Config.KeysAsItem.PlayerOwned.ItemName then --checks if item is a keyfob as setup in config
                            if value.info.id then --checks metadata for id
                                if value.info.id == FobId then --checks metadata id if it matches the fob id we are checking
                                    HasItem = true 
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end

        return HasItem ]]
    end,
    HasFobClient = function(FobId) --** CLIENT SIDE CODE ** check if player has a keyfob item with correct metadata in inventory **DOES NOT NEED TO BE SETUP IF NOT USING KEYS AS ITEMS**
        --Setup custom function to check if player has keyfob item with metadata containing FobId param
            --use keyfob item name here to check or you can use Config.KeysAsItem.PlayerOwned.ItemName
        --Must return true or false

        --[[ local HasItem = false
        QBCore.Functions.GetPlayerData(function(PlayerData)
            if PlayerData.items ~= nil and next(PlayerData.items) ~= nil then 
                for key, value in pairs(PlayerData.items) do 
                    if PlayerData.items[key] ~= nil then 
                        if value.name == Config.KeysAsItem.PlayerOwned.ItemName then 
                            if value.info.id then 
                                if value.info.id == FobId then 
                                    HasItem = true 
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end)

        return HasItem ]]
    end
}
------------------------------------------------------------------------------------------------------------------------------