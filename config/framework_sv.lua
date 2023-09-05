------------------------------------------------------FRAMEWORK LOAD FUNCTION-------------------------------------------------
CustomFramework.LoadServer = function(cb)
    Citizen.CreateThread(function() ---PLACE CODE BELOW TO REGISTER THE SCRIPT WITH YOUR FRAMEWORK CORE SO WE CAN GET YOUR IDENTIFIER
        --[[ QBCore = exports['qb-core']:GetCoreObject() --QBCORE FRAMEWORK EXAMPLE
        if QBCore then
            cb(true) --TELLS THE SCRIPT THE CORE IS LOADED
        else
            cb(false) --TELLS THE SCRIPT THE CORE RESOURCE WAS NOT FOUND
        end ]]
    end)
end
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------Money-------------------------------------------------------------------
CustomFramework.Money = { --**DOES NOT NEED TO BE SETUP IF NOT USING KEYS AS ITEMS**
    CheckBalance = function(self, source, Type) --CHECK A PLAYERS CASH/BANK BALANCE
        --Type params:
            --  cash
            --  bank

        --[[ local src = source --QBCORE EXAMPLE
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then 
            return tonumber(Player.PlayerData.money[Type])
        else
            return 0
        end ]]
    end,
    Remove = function(self, source, Type, Amount) --REMOVE BALANCE FROM A PLAYERS CASH/BANK BALANCE
        --Type params:
            --  cash
            --  bank

        --[[ local src = source --QBCORE EXAMPLE
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then 
            if Player.Functions.RemoveMoney(Type, tonumber(Amount), 'Vehicle Keys Payment') then
                return true
            else
                return false
            end
        else
            return false
        end ]]
    end
}
------------------------------------------------------------------------------------------------------------------------------