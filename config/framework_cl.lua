------------------------------------------------------PLAYER LOADED EVENT-----------------------------------------------------
CustomFramework.PlayerLoadedEvent = 'QBCore:Client:OnPlayerLoaded' --(QBCORE FRAMEWORK EXAMPLE) --Event that is called by your framework when your character is loaded
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------PLAYER UNLOADED EVENT---------------------------------------------------
CustomFramework.PlayerUnloadedEvent = 'QBCore:Client:OnPlayerUnload' --(QBCORE FRAMEWORK EXAMPLE) --Event that is called by your framework when your character logs out
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------FRAMEWORK LOAD FUNCTION-------------------------------------------------
CustomFramework.LoadClient = function(cb)
    CreateThread(function() ---PLACE CLIENT SIDE CODE BELOW TO REGISTER THE SCRIPT WITH YOUR FRAMEWORK CORE SO WE CAN GET YOUR IDENTIFIER. MUST CB true WHEN CORE IS LOADED OR SCRIPT WILL NOT PROCEED
        --[[ QBCore = exports['qb-core']:GetCoreObject() --QBCORE FRAMEWORK EXAMPLE
        if QBCore then
            cb(true) --TELLS THE SCRIPT THE CORE IS LOADED
        else
            cb(false) --TELLS THE SCRIPT THE CORE RESOURCE WAS NOT FOUND OR THERE WAS AN ERROR LOADING FRAMEWORK
        end ]]
    end)
end
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------UNIQUE IDENTIFIER OBTAIN FUNCTION---------------------------------------
CustomFramework.GetIdentifier = function(cb) ---**CLIENT SIDE** FUNCTION THAT WILL GET US YOUR UNIQUE IDENTIFIER TO USE WITH THE SCRIPT
    --[[ QBCore.Functions.GetPlayerData(function(PlayerData) --QBCORE FRAMEWORK EXAMPLE
        if PlayerData then 
            cb(PlayerData.citizenid) --RETURN YOUR UNIQUE IDENTIFIER HERE. CAN BE A CITIZEN ID / PHONE NUMBER / ANYTHING FROM YOUR FRAMEWORK THAT IS UNIQUE TO THE PLAYER CHARACTER (NOT SHARED)
        else
            cb(false)
        end
    end) ]]
end
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------RESTRICTIONS------------------------------------------------------------
CustomFramework.Restrictions = function(self, cb) --CUSTOM RESTRICTIONS (DOWN/CUFFED/ECT) **CLIENT SIDE CODE** TO CHECK IF A PLAYER IS RESTRICTED
    --[[ QBCore.Functions.GetPlayerData(function(PlayerData) --QBCORE FRAMEWORK EXAMPLE
        if PlayerData then 
            if PlayerData.metadata.inlaststand or PlayerData.metadata.isdead or PlayerData.metadata.ishandcuffed then 
                cb(true) --cb(true) if the player is restricted (IN THIS CASE LASTSTAND/DEAD/HANDCUFFED)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end) ]]
end

------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------GET PLAYER JOB----------------------------------------------------------
CustomFramework.GetPlayerJob = function(cb) --CLIENT SIDE CODE TO GET PLAYER JOB NAME
    --[[ QBCore.Functions.GetPlayerData(function(PlayerData) --QBCORE FRAMEWORK EXAMPLE
        if PlayerData then 
            if PlayerData.job then 
                if PlayerData.job.name then 
                    cb(PlayerData.job.name)
                else
                    cb(false)
                end
            else
                cb(false)
            end
        else
            cb(false)
        end
    end) ]]
end

------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------Vehicle Info------------------------------------------------------------
CustomFramework.GetVehicleInfo = function(Model) --CLIENT SIDE CODE TO GET VEHICLE NAME AND BRAND--
    --Retrieve vehicle info based on the model provided. Return a found vehicle as a table
    --Script is looking for the following keys in the returndata table
        --brand (string)
        --name (string)
    --Returning false the script will attempt to use FiveM natives to retrieve this info but will not work for any import vehicles


    --[[ if QBCore.Shared.Vehicles[Model] then --QBCORE FRAMEWORK EXAMPLE
        return QBCore.Shared.Vehicles[Model]
    else
        return false
    end ]]
end
------------------------------------------------------------------------------------------------------------------------------