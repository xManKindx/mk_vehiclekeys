Config = {}
CustomFramework = {}

Config.UseCustomFramework = false --SET TO TRUE TO LOAD CUSTOM FRAMEWORK AND FOLLOW THE SETUP GUIDE IN README OR COMMENTS INSIDE framework_cl.lua / framework_sv.lua / inventory.lua - Leave false to integrate QB/ESX automatically
Config.ConsoleLogging = true --TRUE DISPLAYS SCRIPT LOGGING INFO IN F8 AND SERVER CONSOLE
Config.ToggleLockSpamDelay = 1500 --DELAY IN MS THE PLAYER MUST WAIT TO TOGGLE LOCKING/UNLOCKING A VEHICLE

------------------------------------------------------DISPATCH----------------------------------------------------------------
Config.PoliceNotify = {
    Chance = 50, --Number 0-100. Lower the number less chance to alert. 0 = will never alert. 100 = will always alert.
    AlertTimeout = 15, --Seconds between alert notifications (Prevents spam alerts)
    UseCustomDispatchAlert = false, --FALSE = USE DEFAULT FRAMEWORK DISPATCH NOTIFICATIONS / TRUE = SETUP EVENT FOR CUSTOM DISPATCH SCRIPT (EXAMPLE: PS-DISPATCH) [**MUST BE SET TO TRUE FOR CUSTOM FRAMEWORK USE**]
    CustomAlertFunction = function(Vehicle, Plate, Coords, VehName) --** CLIENT ** CODE BELOW THIS LINE TO SETUP YOUR CUSTOM DISPATCH ALERT
        --Custom Code Here to setup your police alert when a vehicle is hotwired/lockpicked
        ---@param Vehicle number Vehicle entity
        ---@param Plate string Vehicle plate text
        ---@param Coords vector3 Vehicle coordinates
        ---@param VehName string Vehicle make/model

        --TriggerServerEvent('police:server:policeAlert', 'Attempted Vehicle Theft') --QBCORE EXAMPLE
        --exports['ps-dispatch']:VehicleTheft(Vehicle) --PS-DISPATCH EXAMPLE
    end
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------NOTIFICATIONS-----------------------------------------------------------
Config.Notify = { 
    UseCustom = false, --FALSE = DEFAULT NOTIFY WILL BE YOUR FRAMEWORKS NOTIFY SYSTEM (QBCore:Notify / esx:showNotification) / TRUE = CUSTOM NOTIFY SCRIPT (OX_LIB / T-NOTIFY / ECT) (VIEW README FILE FOR DETAILED SETUP INFO)
    CustomClientNotifyFunction = function(Data) --**CLIENT SIDE CODE**
        ---@param Data table: { Message string, Type string (error, success, primary), Duration number }
        
        --TriggerEvent('QBCore:Notify', Data.Message, Data.Type, Data.Duration) --QBCORE EXAMPLE
    end,
    CustomServerNotifyFunction = function(PlayerSource, Data) --**SERVER SIDE CODE** SAME AS ABOVE EXCEPT PASSES THE SOURCE TO SEND THE NOTIFICATION TO FROM THE SERVER
        ---@param PlayerSource number Server id of the player
        ---@param Data table: { Message string, Type string (error, success, primary), Duration number }

        --TriggerClientEvent('QBCore:Notify', PlayerSource, Data.Message, Data.Type, Data.Duration) --QBCORE EXAMPLE
    end,
    NotifyOnKeyAdd = true --If set to true the client will get a Notify message when keys are given to them. Set to false if you do notifications manually to prevent duplicate keys given notifications
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------PROGRESS BAR------------------------------------------------------------
Config.ProgressCircle = false --true = circle progress bar from ox_lib / false = rectangle progress bar from ox_lib
Config.ProgressCirclePosition = 'middle' --position of the progress circle. can be either 'middle' or 'bottom'
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------FLYING LICENSES---------------------------------------------------------
Config.Licenses = {
    Helicopter = {
        CheckLicense = false, --will run the below function to check for a heli license
        CheckLicenseFunction = function(cb)
            --CUSTOM CHECK FOR HELICOPTER LICENSE
            --CLIENT SIDE CHECK
            --IF HAS LICENSE THEN cb(true)
            --IF NOT HAS LICENSE THEN cb(false)
        end,
        CheckJob = true, --IF TRUE WILL CHECK PLAYERS JOB AGAINST JOBS LISTED IN [AuthorizedJobs]. IF TRUE WILL GIVE PLAYER KEYS TO HELICOPTER WHEN THEY SIT IN THE DRIVER SEAT. WILL NOT BE USED FOR CUSTOM FRAMEWORK
        AuthorizedJobs = {'police', 'ambulance'}, --IF CHECKJOB = TRUE AND PLAYER HAS A JOB LISTED IN THIS TABLE THEY WILL BE GIVEN HELICOPTER KEYS WHEN THEY SIT IN THE DRIVER SEAT
        UseCustomJobCheck = false, --FALSE = USE DEFAULT JOB CHECK HARDCODED INTO THE SCRIPT (QB/ESX) / TRUE = USE A CUSTOM FUNCTION BELOW TO CHECK FOR JOBS (USEFULL IF YOU HAVE CHANGED YOUR JOB STRUCTURE FROM DEFAULT QB/ESX OR USING CUSTOM FRAMEWORK)
        CheckJobFunction = function(cb) --CUSTOM FUNCTION TO CHECK PLAYERS JOB ** CLIENT SIDE ** cb(true) for the job to give keys automatically when sitting in driver seat of a helicopter. cb(false) must be setup properly for the script to not hang waiting for a result.
            --CUSTOM CHECK FOR JOB ACCESS TO FLY HELICOPTERS
            --IF HAS JOB THEN cb(true)
            --IF NOT HAS JOB THEN cb(false)

            --[[ QBCore.Functions.GetPlayerData(function(PlayerData) --QBCORE EXAMPLE ON HOW TO SETUP THIS FUNCTION
                if PlayerData then 
                    if (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            end) ]]
        end,
        CanHotwire = false, --TRUE = PLAYERS CAN HOTWIRE A HELICOPTER 
        CanLockpick = false --TRUE = PLAYERS CAN LOCKPICK A HELICOPTER
    },
    Plane = { --ALL FUNCTIONS BELOW ARE THE EXACT SAME SET AS HELICOPTERS ABOVE EXCEPT THEY ONLY APPLY TO PLANES
        CheckLicense = false,
        CheckLicenseFunction = function(cb)
            --CUSTOM CHECK FOR PLANE LICENSE
            --IF HAS LICENSE THEN cb(true)
            --IF NOT HAS LICENSE THEN cb(false)

        end,
        CheckJob = false,
        AuthorizedJobs = {'police'},
        UseCustomJobCheck = false,
        CheckJobFunction = function(cb)
            --CUSTOM CHECK FOR JOB ACCESS TO FLY PLANES
            --IF HAS JOB THEN cb(true)
            --IF NOT HAS JOB THEN cb(false)
            --[[ QBCore.Functions.GetPlayerData(function(PlayerData) --QBCORE EXAMPLE ON HOW TO SETUP THIS FUNCTION
                if PlayerData then 
                    if (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            end) ]]
        end,
        CanHotwire = false, --TRUE = PLAYERS CAN HOTWIRE A PLANE 
        CanLockpick = false --TRUE = PLAYERS CAN LOCKPICK A PLANE
    }
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------LOCKPICKING CONFIG-------------------------------------------------------
Config.Lockpick = {
    LockpickIgnition = true, --TRUE = USING A LOCKPICK ITEM WILL LOCKPICK IGNITION
    IgnitionTime = {Min = 30, Max = 45}, --RANDOM AMOUNT OF TIME (SECONDS) TO ATTEMPT LOCKPICKING A VEHICLE DOOR WITH A REGULAR LOCKPICK. ADVANCED PICK WILL BE HALF OF THIS VALUE
    IgnitionFailChance = 10, --NUMBER 0-100. LOWER NUMBER = LESS CHANCE TO FAIL THE ATTEMPT. 0 = NEVER FAIL. 100 = ALWAYS FAIL.
    IgnitionBreakPick = {
        OnSuccess = {
            Break = true, --TRUE = ON SUCCESSFUL IGNITION LOCKPICK THE PICK HAS A CHANCE TO BREAK BASED ON NUMBER BELOW / FALSE = NEVER BREAK ON SUCCESS
            Chance = 5 --NUMBER 0-100. LOWER NUMBER = LESS CHANCE TO BREAK LOCKPICK. 0 = NEVER BREAK. 100 = ALWAYS BREAK. ADVANCED PICK WILL BE HALF OF THIS VALUE
        },
        OnFail = {
            Break = true, --TRUE = ON FAIL IGNITION LOCKPICK THE PICK HAS A CHANCE TO BREAK BASED ON THE NUMBER BELOW / FALSE = NEVER BREAK ON FAIL
            Chance = 15 --NUMBER 0-100. LOWER NUMBER = LESS CHANCE TO BREAK LOCKPICK. 0 = NEVER BREAK. 100 = ALWAYS BREAK. ADVANCED PICK WILL BE HALF OF THIS VALUE
        }
    },
    LockpickVehicleDoors = true, --TRUE = USING A LOCKPICK ITEM WILL INITIATE LOCKING THE VEHICLE DOOR TO ULOCK IT / FALSE = WILL NOT ALLOW LOCKPICKING VEHICLE DOORS
    DoorsTime = {Min = 15, Max = 30}, --RANDOM AMOUNT OF TIME (SECONDS) TO ATTEMPT LOCKPICKING A VEHICLE DOOR WITH A REGULAR LOCKPICK. ADVANCED PICK WILL BE HALF OF THIS VALUE
    DoorsFailChance = 10, --NUMBER 0-100. LOWER NUMBER = LESS CHANCE TO FAIL THE ATTEMPT. 0 = NEVER FAIL. 100 = ALWAYS FAIL.
    DoorsBreakPick = {
        OnSuccess = {
            Break = true, --TRUE = ON SUCCESSFUL DOOR LOCKPICK THE PICK HAS A CHANCE TO BREAK BASED ON THE NUMBER BELOW / FALSE = NEVER BREAK ON SUCCESS
            Chance = 5 --NUMBER 0-100. LOWER NUMBER = LESS CHANCE TO BREAK LOCKPICK. 0 = NEVER BREAK. 100 = ALWAYS BREAK. ADVANCED PICK WILL BE HALF OF THIS VALUE
        },
        OnFail = {
            Break = true, --TRUE = ON FAIL DOOR LOCKPICK THE PICK HAS A CHANCE TO BREAK BASED ON THE NUMBER BELOW / FALSE = NEVER BREAK ON FAIL
            Chance = 15 --NUMBER 0-100. LOWER NUMBER = LESS CHANCE TO BREAK LOCKPICK. 0 = NEVER BREAK. 100 = ALWAYS BREAK. ADVANCED PICK WILL BE HALF OF THIS VALUE
        }
    },
    LockpickItem = 'lockpick', --LOCKPICK ITEM THAT WHEN USED INITIATES LOCKPICKING VEHICLE DOORS OR IGNITIONS
    UseQBLockpickEvent = true, --IF USING QBCORE WILL USE 'lockpicks:UseLockpick' EVENT SO OTHER SCRIPTS DONT BREAK. SET TO FALSE TO HAVE THIS SCRIPT REGISTER AN EVENT. ONLY APPLYS TO QBCORE. OTHER FRAMEWORK CAN IGNORE THIS.
    UseAdvancedLockpick = true, --TRUE = SETUP ADVANCED LOCKPICK ITEM / FALSE = DONT USE ADVANCED
    AdvancedLockpickItem = 'advancedlockpick', --ADVANCED LOCKPICK ITEM THAT WHEN USED INITIATES LOCKPICKING VEHICLE DOORS OR IGNITIONS (BETTER PROGRESS TIME/EASIER MINI GAME COMPARED TO REGULAR LOCKPICK)
    UseQBAdvancedLockpickEvent = true, --IF USING QBCORE WILL USE 'lockpicks:UseLockpick' EVENT SO OTHER SCRIPTS DONT BREAK. SET TO FALSE TO HAVE THIS SCRIPT REGISTER AN EVENT. ONLY APPLYS TO QBCORE. OTHER FRAMEWORK CAN IGNORE THIS.
    Game = { --SETUP GAMES TO USE FOR LOCKPICKING
        VehicleDoors = {
            UseGame = false, --TRUE = USE CUSTOM MINIGAME TO LOCKPICK VEHICLE DOORS / FALSE = USE DEFAULT PROGRESS BAR
            StartGame = function(AdvancedLockpick, cb) --CUSTOM CODE BELOW TO RUN YOUR MINI GAME (AdvancedLockpick will equal true/false depending on the item used) cb(true) for a game win and cb(false) for a game lose. IF YOU DONT SETUP CB CORRECTLY THE SCRIPT WILL HANG WAITING FOR A RESULT.
                --[[ local Result --(OX_LIB SKILLCHECK GAME EXAMPLE ON HOW TO SETUP THIS FUNCTION)
                if AdvancedLockpick then 
                    Result = lib.skillCheck({'easy', 'easy', 'easy'})
                else
                    Result = lib.skillCheck({'easy', 'medium', 'hard'})
                end
                if Result then 
                    cb(true) --Callback true if we win the mini game
                else
                    cb(false) --Callback false if we fail the mini game
                end ]]
            end,
            StopGame = function()
                --No stop function for this game so just leave it empty
                --IF GAME HAS A STOPGAME FUNCTION OR EXPORT PLACE IT HERE. THIS WOULD BE CALLED IF THE PLAYER WAS KILLED/MOVED AWAY WHILE DOING THE MINI GAME
            end
        },
        Ignition = {
            UseGame = false, --TRUE = USE CUSTOM MINI GAME TO LOCKPICK VEHICLE IGNITION / FALSE = USE OX_LIB SKILLCHECK MINIGAME
            StartGame = function(AdvancedLockpick, cb) --CUSTOM CODE BELOW TO RUN YOUR MINI GAME (AdvancedLockpick will equal true/false depending on the item used) cb(true) for a game win and cb(false) for a game lose. IF YOU DONT SETUP CB CORRECTLY THE SCRIPT WILL HANG WAITING FOR A RESULT.
                --[[ TriggerEvent('qb-lockpick:client:openLockpick', function(Success) --(QB-LOCKPICK GAME EXAMPLE ON HOW TO SETUP THIS FUNCTION)
                    if Success then 
                        cb(true) --CB TRUE IF WE WIN THE GAME
                    else
                        cb(false) --CB FALSE IF WE LOSE THE GAME
                    end
                end) ]]
            end,
            StopGame = function()
                --No stop function for this game so just leave empty
                --IF GAME HAS A STOPGAME FUNCTION OR EXPORT PLACE IT HERE. THIS WOULD BE CALLED IF THE PLAYER WAS KILLED/MOVED AWAY WHILE DOING THE MINI GAME
            end
        }
    }
}

Config.LockpickIgnitionEvent = function(Vehicle, Plate, Coords) --CUSTOM EVENT TO TRIGGER CLIENT SIDE AFTER A SUCCESSFULL VEHICLE ENGINE LOCKPICK
    ---@param Vehicle number Vehicle entity
    ---@param Plate string Vehicle plate text
    ---@param Coords vector3 Vehicle coordinates

end

Config.LockpickDoorEvent = function(Vehicle, Plate, Coords) --CUSTOM EVENT TO TRIGGER CLIENT SIDE AFTER A SUCCESSFULL VEHICLE DOOR LOCKPICK
    ---@param Vehicle number Vehicle entity
    ---@param Plate string Vehicle plate text
    ---@param Coords vector3 Vehicle coordinates

end

Config.LockpickIgnitionCustomAuth = function(Vehicle, Plate) --CUSTOM EVENT TO CHECK IF A PLAYER IS AUTHORIZED TO LOCKPICK A SPECIFIC VEHICLE. MUST RETURN TRUE OR FALSE
    ---@param Vehicle number Vehicle entity
    ---@param Plate string Vehicle plate text
    
    return true
end

Config.LockpickDoorCustomAuth = function(Vehicle, Plate) --CUSTOM EVENT TO CHECK IF A PLAYER IS AUTHORIZED TO LOCKPICK A SPECIFIC VEHICLE. MUST RETURN TRUE OR FALSE
    ---@param Vehicle number Vehicle entity
    ---@param Plate string Vehicle plate text
    
    return true
end
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------HOTWIRING CONFIG--------------------------------------------------------
Config.EnableHotwiring = true --TRUE = HOTWIRING ENABLED / FALSE = HOTWIRING DISABLED
Config.HotwireFailChance = 50 --Number 0-100. Lower the number less chance to fail. 0 = will never fail. 100 = will always fail. [DOES NOT APPLY IF USING MINIGAME BELOW]

Config.HotwireTime = { --DOES NOT APPLY IF USING MINIGAME BELOW
    Min = 10, --Minimum time to attempt a hotwire (Seconds)
    Max = 15 --Maximum time to attempt a hotwire (Seconds)
}

Config.HotwireTextUI = { --EDIT THE TEXTUI THAT APPEARS TO SHOW YOU CAN HOTWIRE A VEHICLE
    Position = 'left-center', --left-center / right-center / top-center
    Icon = {
        Icon = 'fa-solid fa-car-burst', --FONT AWESOME ICON
        Color = 'white', --ICON COLOR
    },
    Style = { --REACT.CSS PROPERTIES STYLING
        borderRadius = 0,
        backgroundColor = '#1A626B', --BACKGROUND
        color = 'white' --TEXT COLOR
    }
}

Config.HotwireGame = {
    UseGame = false, --TRUE = USE CUSTOM MINIGAME TO ATTEMPT TO HOTWIRE A VEHICLE / FALSE = USE PROGRESSBAR WITH SETTINGS IN THE TABLE ABOVE
    StartGame = function(cb) --CUSTOM CODE BELOW TO RUN YOUR MINI GAME cb(true) for a game win and cb(false) for a game lose. IF YOU DONT SETUP CB CORRECTLY THE SCRIPT WILL HANG WAITING FOR A RESULT.
        --EXAMPLE USED HERE IS A FREE SCRIPT IF YOU WANT TO TRY IT YOU CAN OBTAIN IT AT (https://github.com/JackDUpModZ/B01_CTWHotWire)
        --[[ local Result = exports['B01_CTWHotWire']:startMinigame(10000)
        if Result then 
            cb(true) --Callback true if we win the mini game
        else
            cb(false) --Callback false if we fail the mini game
        end ]]
    end,
    StopGame = function()
        --exports['B01_CTWHotWire']:stopMinigame()
    end
}

Config.HotwireEvent = function(Vehicle, Plate, Coords) --CUSTOM EVENT TO TRIGGER CLIENT SIDE AFTER A SUCCESSFULL VEHICLE ENGINE HOTWIRE
    ---@param Vehicle number Vehicle entity
    ---@param Plate string Vehicle plate text
    ---@param Coords vector3 Vehicle coordinates

end

Config.HotwireCustomAuth = function(Vehicle, Plate) --CUSTOM EVENT TO CHECK IF A PLAYER IS AUTHORIZED TO HOTWIRE A SPECIFIC VEHICLE. MUST RETURN TRUE OR FALSE
    ---@param Vehicle number Vehicle entity
    ---@param Plate string Vehicle plate text

    return true
end
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------RESTRICTIONS------------------------------------------------------------
Config.CheckRestrictions = true --FALSE = TO NOT CHECK IF PLAYERS ARE RESTRICTED FROM USING VEHICLE LOCKS/HOTWIRING/LOCKPICKING/ECT. TRUE = CHECK IF PLAYER IS RESTRICTED (CUFFED/DOWN/DEAD/ECT)
--DEFAULT FRAMEWORK (QBCORE/ESX) WILL CHECK IF THE PLAYER IS DOWN OR CUFFED WHEN THIS IS SET TO TRUE.
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------SOUNDS------------------------------------------------------------------
Config.VehicleDoorlockSounds = true --[TRUE = PLAY SOUND WHEN LOCK/UNLOCK VEHICLE / FALSE = PLAY NO SOUND]
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------NO SHUFFLE--------------------------------------------------------------
Config.NoShuffle = false --TRUE = RUN CHECKS WHEN IN PASSENGER SEAT TO NOT AUTO SHUFFLE TO DRIVERS SEAT / FALSE = DISABLED
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------KEY BINDS---------------------------------------------------------------
Config.Binds = {
    ToggleLocks = { --Cannot disable this keybind or you can't lock/unlock your vehicles
        DefaultBind = 'l', --Default keybind for toggling vehicle locks. Can be changed in keybinds/fivem by users
        BindType = 'keyboard' --DONT CHANGE THIS UNLESS YOU CHANGE THE DEFAULT KEYBIND TO A MOUSE BUTTON
    },
    EngineToggle = {
        Enable = true, --TRUE = ENABLES A KEYBIND FOR TOGGLE VEHICLE ENGINE ON/OFF / FALSE = DISABLED
        DefaultBind = 'IOM_WHEEL_UP', --DEFAULT KEYBIND FOR TOGGLING THE ENGINE (MOUSE WHEEL UP)
        BindType = 'MOUSE_WHEEL' --change to 'keyboard' if you change defaultbind to a keypress instead of mouse wheel
    }
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------COMMANDS----------------------------------------------------------------
Config.Commands = {
    GiveKey = { --GIVE KEYS TO NEAREST PLAYER OF NEAREST VEHICLE YOU HAVE KEYS FOR
        Enable = true, --TRUE = ENABLES COMMAND / FALSE = DISABLES COMMAND
        CommandName = 'givekey', --COMMAND NAME (/givekey) CAN CHANGE TO WHATEVER YOU LIKE
    },
    RemoveKey = { --REMOVE KEYS FROM NEAREST PLAYER OF NEAREST VEHICLE YOU HAVE KEYS FOR
        Enable = true, --TRUE = ENABLES COMMAND / FALSE = DISABLES COMMAND
        CommandName = 'removekey', --COMMAND NAME (/removekey) CAN CHANGE TO WHATEVER YOU LIKE
    },
    EngineToggle = { --TOGGLES ENGINE ON/OFF
        Enable = true, --TRUE = ENABLES COMMAND / FALSE = DISABLES COMMAND
        CommandName = 'engine', --COMMAND NAME (/engine) CAN CHANGE TO WHATEVER YOU LIKE
        Notify = true, --TRUE = NOTIFICATION WHEN ENGINE IS TOGGLED ON OR OFF / FALSE = DISABLED
    }
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------NPC VEHICLES------------------------------------------------------------
Config.NpcVehicles = { --NONE OF THE CHECKS BELOW APPLY TO PLAYER OWNED OR STOLEN NPC VEHICLES.
    Driving = {
        CanBeLocked = true, --TRUE = NPC VEHICLE DOORS CAN BE LOCKED WHILE THEY ARE DRIVING / FALSE = ALWAYS UNLOCKED
        LockedChance = 50, --NUMBER 1 TO 100. HIGHER NUMBER IS HIGHER CHANCE TO BE LOCKED. 100 = ALWAYS LOCKED.
    },
    Parked = { --USING THIS FEATURE WILL NOT ALLOW YOU TO BREAK VEHICLE WINDOWS TO UNLOCK THE DOOR. VEHICLE WILL EITHER BE UNLOCKED OR LOCKED AND REQUIRE YOU TO LOCKPICK IT OPEN.
        CheckParkedVehicleLocks = true, --SET TO FALSE IF YOU DON'T WANT THE SCRIPT TO CHANGE DOORLOCKS FOR PARKED NPC VEHICLES
        LockedChance = 50, --NUMBER 0 TO 100. HIGHER NUMBER IS HIGHER CHANCE TO BE LOCKED. 100 = ALWAYS LOCKED. 0 = NEVER LOCKED.
    },
    Carjacking = {
        Enabled = true, --TRUE = ALLOW CARJACKING WITH A WEAPON / FALSE = DISABLED
        VehicleBlacklist = { --ANY VEHICLE LISTED BELOW WILL NOT ALLOW CARJACKING. ADD BY SPAWN NAME OR MODEL HASH.
            'stockade'
        },
        SuccessFunction = function(Vehicle, Plate, Coords, VehName) --CLIENT SIDE FUNCTION THAT IS CALLED WHEN PLAYER SUCCESSFULLY CARJACKS AN NPC
            ---@param Vehicle number Vehicle entity
            ---@param Plate string Vehicle plate text
            ---@param Coords vector3 Vehicle coordinates
            ---@param VehName string Vehicle make/model

        end
    },
    StealDriverKeys = {
        Enabled = true, --TRUE = ALLOW STEALING DEAD NPC DRIVER KEYS WHEN DRAGGED OUT OF THE CAR / FALSE = DISABLED
        RequireDriverDead = true, --TRUE = DRIVER MUST BE DEAD TO TAKE THEIR KEYS / FALSE = WILL TAKE THEIR KEYS EITHER WAY
        VehicleBlacklist = { --ANY VEHICLE LISTED BELOW WILL NOT ALLOW STEALING KEYS FROM THE DRIVER. ADD BY SPAWN NAME OR MODEL HASH.
            'stockade'
        },
        SuccessFunction = function(Vehicle, Plate, Coords, VehName) --CLIENT SIDE FUNCTION THAT IS CALLED WHEN PLAYER SUCCESSFULLY TAKES AN NPC DRIVERS KEYS
            ---@param Vehicle number Vehicle entity
            ---@param Plate string Vehicle plate text
            ---@param Coords vector3 Vehicle coordinates
            ---@param VehName string Vehicle make/model

        end
    }
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------KEYS AS ITEMS-----------------------------------------------------------
Config.KeysAsItem = { --THIS FEATURE CURRENTLY ONLY SUPPORTS (QBCORE FRAMEWORK WITH QB-INVENTORY) OR (ESX-LEGACY FRAMEWORK WITH OX_INVENTORY); DO NOT ENABLE IF YOU RUN SOMETHING DIFFERENT.
    PlayerOwned = {
        Enabled = false, --TRUE = PLAYER VEHICLES REQUIRE A PHYSICAL ITEM / FALSE = DISABLED
        ItemName = 'carkey',
        Database = {
            Custom = false, --FALSE WILL USE DEFAULT DB TABLES FOR YOUR FRAMEWORK (QB/ESX). SET TRUE IF YOU USE DIFFERENT VEHICLE TABLES FOR DATABASE
            OwnedVehicleTable = 'player_vehicles', --QB EXAMPLE
            PlateField = 'plate', --QB EXAMPLE
            FakePlateField = 'fakeplate', --QB EXAMPLE
            IdentifierField = 'citizenid', --QB EXAMPLE
        },
        CanHotwire = false, --TRUE = CAN HOTWIRE PLAYER OWNED VEHICLES / FALSE = CANNOT HOTWIRE PLAYER OWNED VEHICLES
        CanLockpickDoor = false, --TRUE = CAN LOCKPICK PLAYER OWNED VEHICLE DOORS / FALSE = CANNOT LOCKPICK PLAYER OWNED VEHICLE DOORS
        CanLockpickIgnition = false, --TRUE = CAN LOCKPICK PLAYER OWNED VEHICLE IGNITIONS / FALSE = CANNOT LOCKPICK PLAYER OWNED VEHICLE IGNITIONS
        FobRange = 100, --DISTANCE FROM A PLAYER OWNED VEHICLE THAT YOU CAN USE THE FOB ITEM TO LOCK/UNLOCK VEHICLE; MAX = 150; HAS TO BE WITHIN PLAYERS INFINITY SCOPE SO MAX 150 TO BE SAFE.
        GiveWhitelistJobKeys = false, --TRUE = IF VEHICLE MODEL IS LISTED IN CONFIG.JOBWHITELISTEDVEHICLES ANY PLAYER WITH THAT WHITELISTED JOB WILL GET A SET OF KEYS (NOT FOB) WHEN THEY SIT IN THE DRIVER SEAT OR TOGGLE VEHICLE LOCKS. / FALSE = MUST HAVE FOB EVEN IF YOU HAVE THE WHITELISTED JOB
    },
    KeyManagement = {
        DuplicateKeyCost = 500, --PRICE TO PURCHASE A SPARE SET OF KEYS FOR A PLAYER OWNED VEHICLE
        ReprogramCost = 1000, --PRICE TO REPROGRAM A VEHICLE TO A NEW FOB ID; MAKES OLD FOBS NOT WORK
    },
    Command = {
        Enable = true, --TRUE = COMMAND IS USEABLE / FALSE = COMMAND WILL NOT BE AVAILABLE
        CommandName = 'keyfobs', --COMMAND NAME (/keyfobs) CAN CHANGE TO WHATEVER YOU LIKE
    },
    UseTarget = true, --TRUE = LOADS NPC PEDS IN THE TABLE BELOW FOR USE WITH [QB-TARGET] OR [OX_TARGET] TO ACCESS THE KEYFOB MANAGEMENT MENU / FALSE = DISABLED. (DISABLE THIS IF YOU ONLY WANT TO USE THE COMMAND ABOVE)
    Peds = { --ADD AS MANY NPC PEDS AS YOU WOULD LIKE FOR PLAYERS TO HAVE ACCESS TO THE KEYFOB MANAGEMENT MENU. UseTarget MUST BE TRUE FOR THESE PEDS TO BE LOADED.
        { --Garage B (lower pink cage)
            Coords = { --POLYZONE COORDS FOR [OX_LIB]; NPC WILL SPAWN WHEN PLAYER ENTERS THIS ZONE/DESPAWN WHEN THEY LEAVE OR LOGOUT.
                vec3(249.22290039062, -347.42340087891, 45.25),
                vec3(302.80364990234, -364.47235107422, 45.25),
                vec3(320.55392456055, -321.66110229492, 45.25),
                vec3(262.82815551758, -298.92684936523, 45.25)
            },
            debug = false, --TRUE = SHOWS POLYZONE SO YOU CAN TEST YOUR ZONE / FALSE = POLYZONE NOT SHOWN.
            PedPosition = {x = 260.88, y = -335.70, z = 45.01, h = 269.29}, --COORDS FOR THE NPC PED. BLIP USES THESE COORDS IF ENABLED
            Freeze = false, --FREEZE PED POSITION AFTER IT SPAWNS
            Hash = 1142162924, --Hash of spawnable PED (https://forge.plebmasters.de/peds)
            Blip = {
                ShowBlip = true,
                Sprite = 134, -- BLIP PICTURE
                Scale = 1.0, --SIZE OF BLIP
                Color = 55, --BLIP COLOR
                Label = 'Vehicle Locksmith', --TEXT THAT SHOWS WHEN YOU CLICK ON THE BLIP IN THE GAME MAP
                ShortRange = true, --TRUE = BLIP ONLY SHOWS ON MINIMAP WHILE NEAR / FALSE = SHOWS ON MINIMAP AT ALL TIMES
            }
        },
        { --Legion Square garage
            Coords = {
                vec3(196.93092346191, -810.22283935547, 31.0),
                vec3(239.45631408691, -826.46923828125, 31.0),
                vec3(271.99243164062, -748.68383789062, 31.0),
                vec3(223.00494384766, -730.93469238281, 31.0)
            },
            debug = false,
            PedPosition = {x = 215.16, y = -806.16, z = 30.79, h = 337.32}, 
            Freeze = false,
            Hash = 1142162924,
            Blip = {
                ShowBlip = true,
                Sprite = 134,
                Scale = 1.0,
                Color = 55,
                Label = 'Vehicle Locksmith',
                ShortRange = true,
            }
        },
    },
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------VEHICLE WHITELIST-------------------------------------------------------
Config.WhitelistedVehicles = { --ANY VEHICLE LISTED BELOW WILL NOT REQUIRE KEYS TO OPERATE. ADD BY SPAWN NAME OR MODEL HASH. (NOTE: ANY VEHICLE THAT THE NATIVE 'IsThisModelABicycle' RETURNS TRUE WILL AUTOMATICALLY BE WHITELISTED BY THE SCRIPT AND DOESNT NEED TO BE ADDED HERE)
    'caddy',
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------VEHICLE WHITELIST-------------------------------------------------------
Config.JobWhitelistedVehicles = { --ADD A TABLE WITH A JOBNAME AND ANY WHITELISTED VEHICLES THAT JOB WILL GET KEYS TO AUTOMATICALLY WHEN THEY SIT IN THE DRIVER SEAT OR TOGGLE VEHICLE LOCKS.
    ['police'] = {
        'police2', 
        'police3' 
    },
    ['ambulance'] = {
        'ambulance',
    },
    --[[ ['somejobname'] = { --EXAMPLE
        'whitelistvehicle1',
        'whitelistvehicle2',
    }, ]]
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------VEHICLE STARTING--------------------------------------------------------
Config.DisableAutoStartEngine = true --TRUE = ENGINE WILL NOT START WHEN YOU SIT IN THE DRIVER SEAT / FALSE = ENGINE WILL BE STARTED WHEN YOU SIT IN THE DRIVER SEAT IF YOU HAVE KEYS
Config.DisableAccelerateVehicleStart = true --TRUE = ENGINE WILL NOT START WHEN YOU ACCELERATE IF YOU HAVE KEYS / FALSE = ENGINE STARTS WHEN YOU PRESS ACCELERATE KEY IF YOU HAVE KEYS TO THE VEHICLE
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------QB-VEHICLEKEYS SNIPPET--------------------------------------------------
RegisterNetEvent('vehiclekeys:client:SetOwner', function(Plate)
    local plate = Utils:RemoveTrailSpaces(Plate)
    Wait(250) --Giving vehicle time to be spawned and plate set. Increase if having issues.
    local vehicles = GetGamePool('CVehicle')
    if vehicles then 
        for i = 1, #vehicles, 1 do 
            if Utils:RemoveTrailSpaces(GetVehicleNumberPlateText(vehicles[i])) == plate then 
                exports['mk_vehiclekeys']:AddKey(vehicles[i])
                break
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------