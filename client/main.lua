local driving = false
local StageCoachRep = 0
local StageCoachCompleted = 0
local keys = { ['O'] = 0xF1301666 }

-- Menu
RegisterNetEvent('qbr-stagecoach:client:Openmenu', function()
    local PlayerData = exports['qbr-core']:GetPlayerData()
    StageCoachRep = PlayerData.metadata["stagecoachrep"]
    CurRep = PlayerData.metadata["stagecoachrep"]
    if CurRep <= 0 then
        Level = 'LVL 0'
        elseif CurRep >= 0 and CurRep <= Config.RepLevelOne then
        Level = 'LVL 1'
        elseif CurRep >= Config.RepLevelOne and CurRep <= Config.RepLevelTwo then
        Level = 'LVL 2'
        elseif CurRep >= Config.RepLevelTwo and CurRep <= Config.RepLevelThree then
        Level = 'LVL 3'
        elseif CurRep >= Config.RepLevelThree and CurRep <= Config.RepLevelFour then
        Level = 'LVL 4'
        elseif CurRep >= Config.RepLevelFour and CurRep <= Config.RepLevelFive then
        Level = 'LVL 5'
        elseif CurRep >= Config.RepLevelFive and CurRep <= Config.RepLevelSix then
        Level = 'LVL 6'
        elseif CurRep >= Config.RepLevelSix and CurRep <= Config.RepLevelSeven then
        Level = 'LVL 7'
        elseif CurRep >= Config.RepLevelSeven and CurRep <= Config.RepLevelEight then
        Level = 'LVL 8'
        elseif CurRep >= Config.RepLevelEight and CurRep <= Config.RepLevelNine then
        Level = 'LVL 9'
        else
        Level = 'LVL MAXED'
        end
    shownStagecoach = true
    local stagecoach = {
        {
            header = "<b>Stage Coach",
            isMenuHeader = true,
        },
        {
            header = "Check Reputation",
			icon = "fas fa-chart-area",
            txt = "Check Your Job Statistics",
            params = {
                event = "qbr-stagecoach:client:OpenmenuREP",
            }
        },
        {
            header = "Stage Coaches",
			icon = "fas fa-horse",
            txt = "Start Your Journey",
            params = {
                event = "qbr-stagecoach:client:OpenMenuRent",
            }
        },
        {
            header = "Close Menu",
			icon = "fa-solid fa-angle-left",
            params = {
                event = "",
            }
        },
    }
    exports['qbr-menu']:openMenu(stagecoach)
end)

RegisterNetEvent('qbr-stagecoach:client:OpenMenuRent', function()
    local header = {
        {
            isMenuHeader = true,
            header = "<b>Stage Coach Rentals",
            txt =  "<p>Service Fee: $"..Config.ServiceFee.." <p>Current Rep: "..CurRep
        }
    }
    for k, v in pairs(Config.StageCoach) do
        header[#header+1] = {
            header = v.name,
            txt = "Required Rep: "..v.rep,
            icon = v.icon,
            params = {
                isServer = true,
                event = "qbr-stagecoach:server:rentalfeecheck",
                args = k
            }
        }
    
    end
    exports['qbr-menu']:openMenu(header)
end)

-- Menu
RegisterNetEvent('qbr-stagecoach:client:OpenmenuREP', function()
    local PlayerData = exports['qbr-core']:GetPlayerData()
    StageCoachCompleted = PlayerData.metadata["stagecoachcompleted"]
    shownStagecoachlvl = true
    local stagecoachlvl = {
        {
            header = "<b>Stage Coach Statistics",
            icon = "fa-solid fa-circle-info",
            isMenuHeader = true,
        },
        {
            header = "Reputation Purpose",
			icon = "fas fa-chart-area",
            txt = "- Workers Access Better Stage Coaches <p>- Earn More Money on Each Run",
            params = {
                event = "qbr-stagecoach:client:OpenmenuREP",
            }
        },
        {
            header = "Current Reputation",
			icon = "fas fa-chart-area",
            txt = "Current Rep: 【 "..StageCoachRep.." 】",
            params = {
                event = "qbr-stagecoach:client:OpenmenuREP",
            }
        },
        {
            header = "Current Level",
			icon = "fas fa-turn-up",
            txt = "Current Level:【 "..Level.." 】",
            params = {
                event = "qbr-stagecoach:client:OpenmenuREP",
            }
        },
        {
            header = "Completed Missions",
			icon = "fas fa-clipboard-list",
            txt = "Completed Jobs: 【 "..StageCoachCompleted.." 】",
            params = {
                event = "qbr-stagecoach:client:OpenmenuREP",
            }
        },
        {
            header = "Return",
			icon = "fa-solid fa-angle-left",
            params = {
                event = "qbr-stagecoach:client:Openmenu",
            }
        },
    }
    exports['qbr-menu']:openMenu(stagecoachlvl)
end)

RegisterNetEvent('qbr-stagecoach:Client:RentVehicle', function(model)
    exports['qbr-core']:Notify(8, 'Stage Coach Aquired', 5000, 'Follow The Waypoint', 'itemtype_textures', 'itemtype_coach', 'COLOR_GREEN')

    DeleteVehicle(spawn_coach)
    RequestModel(model)

    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    zone_name = GetCurentTownName()
    district_name = GetDistrictHash()

    spawn_coach = CreateVehicle(model, Config.StageCoachSpawn[zone_name].x, Config.StageCoachSpawn[zone_name].y, Config.StageCoachSpawn[zone_name].z, Config.StageCoachSpawn[zone_name].h, true, false)
    SetVehicleOnGroundProperly(spawn_coach)
    SetModelAsNoLongerNeeded(model)
    
  --  local player = PlayerPedId()

 --[[   DoScreenFadeOut(500)

    cam_a = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
            SetCamCoord(cam_a,  Config.Cams[zone_name]["cam_a"].x, Config.Cams[zone_name]["cam_a"].y, Config.Cams[zone_name]["cam_a"].z)  
            SetCamRot(cam_a, 0.0, 0.0, Config.Cams[zone_name]["cam_a"].h,  true)

    cam_b = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
            SetCamCoord(cam_b,  Config.Cams[zone_name]["cam_b"].x, Config.Cams[zone_name]["cam_b"].y, Config.Cams[zone_name]["cam_b"].z)
            SetCamRot(cam_b, 0.0, 0.0, Config.Cams[zone_name]["cam_b"].h,  true)

    Wait(500)
    -- SetPedIntoVehicle(player, spawn_coach, -1)
    Wait(500)
    DoScreenFadeIn(500)

    SetCamActiveWithInterp(cam_a, cam_b, 2000, 1, 1)
    IsCinematicCamRendering(true)
    RenderScriptCams(1, 0, cam_a,  true,  true)
    Wait(3000)

    EndStageCoachCam()
    ]]
    driving = true
    TriggerServerEvent("qbr-stagecoach:StartCoachJobServer", zone_name, spawn_coach, driving)

end)

-- Notification CB
RegisterNetEvent('qbr-stagecoach:client:notenoughrep')
AddEventHandler('qbr-stagecoach:client:notenoughrep', function()
exports['qbr-core']:Notify(8, 'Not Enough Reputation', 5000, 'Prove Yourself Worthy', 'itemtype_textures', 'itemtype_player_stamina', 'COLOR_GREEN')
end)

RegisterNetEvent('qbr-stagecoach:client:notenoughmoney')
AddEventHandler('qbr-stagecoach:client:notenoughmoney', function()
exports['qbr-core']:Notify(8, 'Not Enough Cash', 5000, 'The Stage Coaches Aren\'t Free', 'itemtype_textures', 'itemtype_cash_arthur', 'COLOR_GREEN')
end)

-- Create Wagon Wheel Map Marker

Citizen.CreateThread(function()
    for _, marker in pairs(Config.Marker) do
        local blip = N_0x554d9d53f696d002(1664425300, marker.x, marker.y, marker.z)
        SetBlipSprite(blip, marker.sprite, 1)
        SetBlipScale(blip, 0.1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, marker.name)

    end  
end)

-- Spawn Buy Stage Coach NPC Location Trigger

Citizen.CreateThread(function()
    for _, zone in pairs(Config.Marker) do
        TriggerEvent("qbr-stagecoach:CreateNPC", zone)
        --[[npc_spawned[zone.name] = true --]]                  
    end
end)  

-- Generate Job Giver NPC's

RegisterNetEvent("qbr-stagecoach:CreateNPC")
AddEventHandler("qbr-stagecoach:CreateNPC", function (zone)

    if not DoesEntityExist(npc) then
    
        local model = GetHashKey( "S_M_M_TrainStationWorker_01" )
        local coord = GetEntityCoords(PlayerPedId())
        RequestModel( model )

        while not HasModelLoaded( model ) do
            Wait(500)
        end
                
        npc = CreatePed( model, zone.x, zone.y, zone.z, zone.h,  false, true)
        Citizen.InvokeNative( 0x283978A15512B2FE , npc, true )

    end
end)

-- Get District Hash

function GetDistrictHash()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local district_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 10)
    if district_hash then
        local district_name = Config.Districts[district_hash].name
        return district_name
    else
        return ""
    end
end

-- Get Current Town Name, Some Towns missing

function GetCurentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("roanoke") then
        return "Roanoke Ridge"
    elseif town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    else
        return ""
    end
end

-- Successful Drop Off / Pay Fare

RegisterNetEvent("qbr-stagecoach:successful_dropoff")
AddEventHandler("qbr-stagecoach:successful_dropoff", function (fare, npc_id)

    while true do
    
        TriggerServerEvent("qbr-stagecoach:RewardsLoot", fare)
        exports['qbr-core']:Notify(8, 'Successful Dropoff', 5000, 'Another Job is Starting', 'itemtype_textures', 'itemtype_cash_arthur', 'COLOR_GREEN')
        local fare_paid = true
        RemoveBlip(p1)
        ClearGpsMultiRoute()
        passenger_spawned = false
        TriggerEvent("qbr-stagecoach:StartCoachJob", zone_name, spawn_coach, passenger_spawned)
        Wait(30000)
        DeleteEntity(npc_id)
        
        if fare_paid == true then
            break
        end
    end
end)

-- Unuccessful Drop Off / No Fare Payment

RegisterNetEvent("qbr-stagecoach:unsuccessful_dropoff")
AddEventHandler("qbr-stagecoach:unsuccessful_dropoff", function (fare, npc_id)

    while true do
    
        local fare_paid = true
        RemoveBlip(p1)
        ClearGpsMultiRoute()
        passenger_spawned = false
        TriggerEvent("qbr-stagecoach:StartCoachJob", zone_name, spawn_coach, passenger_spawned)
        Wait(30000)
        DeleteEntity(npc_id)
        
        if fare_paid == true then
            break
        end
    end
end)

-- PassengerOnboard

RegisterNetEvent("qbr-stagecoach:PassengerOnboard")
AddEventHandler("qbr-stagecoach:PassengerOnboard", function (zone_name, route, spawn_coach, repair_active)
 
    RemoveBlip(p1)
    ClearGpsMultiRoute()

    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(Config.PickUp[zone_name][route].x + 5, Config.PickUp[zone_name][route].y + 5, Config.PickUp[zone_name][route].z)
    AddPointToGpsMultiRoute(Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y, Config.Destination[zone_name][route].z)
    SetGpsMultiRouteRender(true)

    p1 = N_0x554d9d53f696d002(1664425300, Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y, Config.Destination[zone_name][route].z)
    SetBlipSprite(p1, Config.Destination[zone_name][route].sprite, 5)
    SetBlipScale(p1, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, p1, Config.Destination[zone_name][route].name)
    passenger_onboard = true
    
    while true do
    Wait(10)   

        local coach_health = GetVehicleBodyHealth(spawn_coach);
        local coach_drivable = IsVehicleDriveable(spawn_coach);
        
        current = GetEntityCoords(passenger)
        distance = GetDistanceBetweenCoords(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z, current, false)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local disctrict_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,10)

        fare_amount = (distance / 1609.34) * 50
        fare_amount = string.format("%.0f", fare_amount)
        fare_amount = tonumber(fare_amount)
        Wait(100)

        town_name = GetCurentTownName()
        district_hash = GetDistrictHash()    

        if GetDistanceBetweenCoords(Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y, Config.Destination[zone_name][route].z, GetEntityCoords(passenger),false)<5 and passenger_onboard ~= false then
            
            local spawn_coach = GetVehiclePedIsIn(PlayerPedId(),false)
            TaskLeaveVehicle(passenger, spawn_coach, 0)
            TaskGoToCoordAnyMeans(passenger, Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y +40, Config.Destination[zone_name][route].z, 1.0, 0, 0, 786603, 0xbf800000)
            npc_id = GetPedIndexFromEntityIndex(passenger)
            TriggerEvent("qbr-stagecoach:successful_dropoff", fare_amount, npc_id)
            passenger_onboard = false
            
        end       

        if IsEntityDead(passenger) then
            TriggerEvent("qbr-stagecoach:unsuccessful_dropoff", 0, npc_id)
            passenger_onboard = false
        end

        if GetVehicleBodyHealth(spawn_coach) == 0 or IsVehicleDriveable(spawn_coach) == false then
            local repair_active = false
            print('passenger_onboard', repair_active)
            TriggerEvent("qbr-stagecoach:replace_stagecoach", spawn_coach, repair_active)
            TaskLeaveVehicle(passenger, spawn_coach, 0)
            TriggerEvent("qbr-stagecoach:unsuccessful_dropoff", 0, npc_id, spawn_coach)
        end
    
        if passenger_onboard == false then
            break
        end
    end

end)

RegisterNetEvent("qbr-stagecoach:AddDriverBlip")
AddEventHandler("qbr-stagecoach:AddDriverBlip", function (coach_driver, coach_driver_blip)
    print('client_addDriverBlip_coach_driver', coach_driver)
    Citizen.InvokeNative(0x9CB1A1623062F402, coach_driver_blip, 'Stage Coach')

end)

-- StartCoachJob

RegisterNetEvent("qbr-stagecoach:StartCoachJob")
AddEventHandler("qbr-stagecoach:StartCoachJob", function (zone_name, spawn_coach, driving)
       
    TriggerEvent("drivingtrue")
    zone_name = GetDistrictHash()
    local passenger_despawned = true
    route = math.random(2)
    player_loc = GetEntityCoords(PlayerPedId())
    passenger_onboard = false
    
    -- Setting Blip for Driving Coaches

    local coach_driver = PlayerPedId()
    local coach_driver_blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, 631964804, coach_driver)
    
    TriggerServerEvent('qbr-stagecoach:SendDriverEntity', coach_driver)
    
    -- Set GPS route positions

    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(player_loc)
    AddPointToGpsMultiRoute(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z)
    SetGpsMultiRouteRender(true)

    p1 = N_0x554d9d53f696d002(1664425300, Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z)
    SetBlipSprite(p1, Config.PickUp[zone_name][route].sprite, 1)
    SetBlipScale(p1, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, p1, Config.PickUp[zone_name][route].name)
    
    while (passenger_despawned == true) do
    Wait(10)

            if GetDistanceBetweenCoords(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z,GetEntityCoords(PlayerPedId()),false)<500 and passenger_despawned == true then

                local model = GetHashKey(Config.PickUp[zone_name][route].model)
                
                RequestModel( model )

                    while not HasModelLoaded( model ) do
                        Wait(500)
                    end
            if not DoesEntityExist(passenger) then
                passenger = CreatePed(model, Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z, Config.PickUp[zone_name][route].h, true, true)
                print(passenger)
                Citizen.InvokeNative( 0x283978A15512B2FE , passenger, true )
                passenger_despawned = false
                Wait(10)
            end
                
            end
        if passenger_despawned == false then
            break
        end
    end
    
    
    while (passenger_onboard == false) do
    Wait(10)
        
        if GetDistanceBetweenCoords(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z, GetEntityCoords(PlayerPedId()),false)<10 then
            
            spawn_coach = GetVehiclePedIsIn(PlayerPedId(),false)
            
            SetEntityAsMissionEntity(spawn_coach, false, false)
            SetEntityAsMissionEntity(passenger, false, false)
            
            npc_group = GetPedRelationshipGroupHash(passenger)
            SetRelationshipBetweenGroups(1 , GetHashKey("PLAYER") , npc_group)
            print(npc_group)

            Wait(500)       
            TaskEnterVehicle(passenger, spawn_coach, -1, 1, 1.0, 1, 0)

            passenger_onboard = true
            RemoveBlip(p1)
            TriggerEvent("qbr-stagecoach:PassengerOnboard", zone_name, route, spawn_coach)

        end

        if passenger_onboard == true then
            break
        end
    end
end)            

-- Destroy Cams

function EndStageCoachCam()
    ClearFocus()

    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam_a, false)
    DestroyCam(cam_b, false)

    cam_a = nil
    cam_b = nil

end


-- Stop Driving Menu Event

RegisterNetEvent("qbr-stagecoach:stop_driving")
AddEventHandler("qbr-stagecoach:stop_driving", function (spawn_coach)
    
    local player = PlayerPedId()
    local spawn_coach = GetVehiclePedIsIn(PlayerPedId(),false)
    zone_name = GetDistrictHash()

    local coach_blip = GetBlipFromEntity(player)
    RemoveBlip(coach_blip)
    
    TaskLeaveVehicle(passenger, spawn_coach, 0)
    RemoveBlip(p1)
    ClearGpsMultiRoute()
    passenger_spawned = false
    driving = false
    TaskGoToCoordAnyMeans(passenger, Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y +40, Config.Destination[zone_name][route].z, 1.0, 0, 0, 786603, 0xbf800000)
    Wait(5000)
    DeleteEntity(passenger)

end)

-- Replace Wagon If Damaged

RegisterNetEvent("qbr-stagecoach:replace_stagecoach")
AddEventHandler("qbr-stagecoach:replace_stagecoach", function (spawn_coach, repair_active)
    print('replace_coach', repair_active)

    -- Repair Stage Coach Prompt Menu

    local RepairCoachPrompt
    local repair

    function RepairCoach()
        Citizen.CreateThread(function()
            local str = 'Repair Stagecoach'
            RepairCoachPrompt = PromptRegisterBegin()
            PromptSetControlAction(RepairCoachPrompt, 0xDFF812F9)
            str = CreateVarString(10, 'LITERAL_STRING', str)
            PromptSetText(RepairCoachPrompt, str)
            PromptSetEnabled(RepairCoachPrompt, true)
            PromptSetVisible(RepairCoachPrompt, true)
            PromptSetHoldMode(RepairCoachPrompt, true)
            PromptSetGroup(RepairCoachPrompt, repair)
            PromptRegisterEnd(RepairCoachPrompt)
        end)
    end

    while true do
        Wait(10)
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawn_coach))<5 then
            if repair_active == false then
                RepairCoach()
                repair_active = true
            end
        
        elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawn_coach))>6 then
                if repair_active == true then
                    PromptDelete(RepairCoachPrompt)
                    repair_active = false
                end
        end

        if PromptHasHoldModeCompleted(RepairCoachPrompt) then
            local pos = GetEntityCoords(PlayerPedId())
            local pos_h = GetEntityHeading(PlayerPedId())
            
            -- THIS NEEDS TO BE CHANGED TO PLAYERS COACH MODEL AT TIME OF REPAIR

            local model = GetHashKey("WAGON06X")

            RequestModel( model )

            while not HasModelLoaded( model ) do
                Wait(500)
            end

            DeleteVehicle(spawn_coach)
            
            spawn_coach = CreateVehicle(model, pos.x + 3, pos.y + 3, pos.z + 3, pos_h, true, false)
            SetVehicleOnGroundProperly(spawn_coach)
            SetModelAsNoLongerNeeded(model)
            
            local player = PlayerPedId()
            DoScreenFadeOut(500)
            Wait(500)
            SetPedIntoVehicle(player, spawn_coach, -1)
            Wait(500)
            DoScreenFadeIn(500)
            
            driving = true
            TriggerEvent("qbr-stagecoach:StartCoachJob", zone_name, spawn_coach, driving)
        end 
    end
end)



function OpenStageCoachMenu()
    TriggerEvent('qbr-stagecoach:client:Openmenu')
end

-- Buy Stage Coach Prompt Menu

local StageCoachPrompt
local active = false
local group 

function StageCoach()
    Citizen.CreateThread(function()
        local str = 'Stage Coach Co.'
        StageCoachPrompt = PromptRegisterBegin()
        PromptSetControlAction(StageCoachPrompt, 0xDFF812F9)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(StageCoachPrompt, str)
        PromptSetEnabled(StageCoachPrompt, true)
        PromptSetVisible(StageCoachPrompt, true)
        PromptSetHoldMode(StageCoachPrompt, true)
        PromptSetGroup(StageCoachPrompt, group)
        PromptRegisterEnd(StageCoachPrompt)
    end)
end

-- Main Stage Coach Menu Prompt Location Trigger

Citizen.CreateThread(function()
    while true do
    Wait(10)
        for _, zone in pairs(Config.Marker) do
            if GetDistanceBetweenCoords(zone.x, zone.y, zone.z,GetEntityCoords(PlayerPedId()),false)<2 then
                if active == false then
                    StageCoach()
                    menu_trigger_loc = zone.name
                    active = true

                end
            elseif GetDistanceBetweenCoords(zone.x, zone.y, zone.z,GetEntityCoords(PlayerPedId()),false)>1.5 and zone.name == menu_trigger_loc then
                if active == true then
                    Wait(200)
                    PromptDelete(StageCoachPrompt)
                    active = false
                end
            end
        end
        if PromptHasHoldModeCompleted(StageCoachPrompt) then
                        OpenStageCoachMenu()
                        PromptDelete(StageCoachPrompt)
                        active = true
        end
    end
end)

-- Warmenu Stop Driving Options

Citizen.CreateThread(function()
    WarMenu.CreateMenu('DrivingStatus', 'Coach Menu')
    while true do
        Citizen.Wait(0)
        if WarMenu.IsMenuOpened('DrivingStatus') then
            WarMenu.Display()
            if WarMenu.Button("Stop Driving") then
                    TriggerEvent("qbr-stagecoach:stop_driving")
                    WarMenu.CloseMenu()
                    Wait(600)
                    WarMenu.Display()
            elseif WarMenu.Button("Exit") then
                    WarMenu.CloseMenu()
                    Wait(600)
                    WarMenu.Display()
            end
        end

    end
end)

-- Warmenu Start Driving Options

Citizen.CreateThread(function()
    WarMenu.CreateMenu('DrivingStatusFalse', 'Coach Menu')
    while true do
        Citizen.Wait(0)
        if WarMenu.IsMenuOpened('DrivingStatusFalse') then
            WarMenu.Display()
            if WarMenu.Button("Start Driving") then
                    TriggerServerEvent("qbr-stagecoach:StartCoachJobServer", zone_name, spawn_coach, true)
                    WarMenu.CloseMenu()
                    Wait(600)
                    WarMenu.Display()
            elseif WarMenu.Button("Exit") then
                    WarMenu.CloseMenu()
                    Wait(600)
                    WarMenu.Display()
            end
        end
    end
end)

-- Warmenu Main Menu 

Citizen.CreateThread(function(HasStagecoaches)
    WarMenu.CreateMenu('Stagecoach_MainMenu', 'Coach Menu')
        WarMenu.CreateSubMenu('Stagecoach', 'Stagecoach_MainMenu', 'Buy a Stage Coach')
        WarMenu.CreateSubMenu('ListStagecoaches', 'Stagecoach_MainMenu', 'Owned Stage Coaches')
        WarMenu.CreateSubMenu('Exit', 'Stagecoach_MainMenu', 'Exit Coach Menu')

    while true do
        Citizen.Wait(0)
        if WarMenu.IsMenuOpened('Stagecoach_MainMenu') then

            if WarMenu.MenuButton('Buy Coach', 'Stagecoach') then OpenBuyStageCoachMenu() end
            if WarMenu.MenuButton('Owned Coaches', 'ListStagecoaches') then TriggerServerEvent('qbr-stagecoach:loadstagecoach') end
            if WarMenu.MenuButton('Exit', 'Exit') then WarMenu.CloseMenu() Wait(600) end

            WarMenu.Display()
        end
    end
end)

-- Warmenu Driving Status Menu Options Switch

function OpenDrivingStatusMenu()
    if driving == true then
        WarMenu.OpenMenu('DrivingStatus')
    else
        WarMenu.OpenMenu('DrivingStatusFalse')
    end    
end

-- Update Driving Status Function

RegisterNetEvent("drivingtrue")
AddEventHandler("drivingtrue", function()
    driving = true
end)

-- Calculate Fare Amount

function CalculateFare(passenger_pickup_coords, player_onboard, invheicle, driver)
    Citizen.CreateThread( function()
        while true do
            Citizen.Wait(10)
            local invehicle = GetPlayersInVehicle()
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            
            if invehicle then
                current = GetEntityCoords(PlayerPedId())
                distance = GetDistanceBetweenCoords(passenger_pickup_coords.x, passenger_pickup_coords.y, passenger_pickup_coords.z, current, false)
                fare_amount = (distance / 1609.34) * 50
                fare_amount = string.format("%.0f", fare_amount)
                fare_amount = tonumber(fare_amount)
                Wait(100)
                
            elseif invehicle == nil then
                Citizen.Wait(1000)
                TriggerServerEvent("qbr-stagecoach:pay_fare", fare_amount)
                break
            end
        end
    end)
end

-- Check if players are in vehicle

function GetPlayersInVehicle()
    local players = GetActivePlayers()
    local ply = PlayerPedId()
    local returnablePlayers = {}
    local playerVehicle = GetVehiclePedIsIn(ply, false)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local vehicle = GetVehiclePedIsIn(target, false)
            if playerVehicle ~= 0 and playerVehicle == vehicle then
                table.insert(returnablePlayers, value)
            end
        end
    end
    
    return returnablePlayers[1] 

end
    
-- Check For Button Press Menu Open / Is a Player in Vehicle

Citizen.CreateThread(function(fare_amount)
    
    local active = false
    local player = PlayerPedId()
    local get_player_passenger_coords = false
    fare_amount = 0
    
    while true do
        Citizen.Wait(10)
        
        vehicle = GetVehiclePedIsIn(player)
        driver = GetPedInVehicleSeat(vehicle, -1)

        if vehicle and driver == player then
            
            local invehicle = GetPlayersInVehicle()

            if invehicle and get_player_passenger_coords == false then
                passenger_pickup_coords = GetEntityCoords(PlayerPedId())
                player_onboard = true
                CalculateFare(passenger_pickup_coords, player_onboard, invehicle, driver)
                get_player_passenger_coords = true
            
            elseif invehicle == nil then
                player_onboard = false              
                get_player_passenger_coords = false
            end
        end

        if IsControlJustReleased(0, keys['O']) then
            if active == false then
                OpenDrivingStatusMenu()
                active = true
            elseif active == true then
                WarMenu.CloseMenu()
                active = false
            end
        end

    end
end)




