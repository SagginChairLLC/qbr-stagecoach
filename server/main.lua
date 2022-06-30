

RegisterNetEvent('qbr-stagecoach:server:rentalfeecheck', function(model)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local cashBalance = Player.PlayerData.money["cash"]
    local RentalFee = Config.StageCoach[model].price
    local RepReq = Config.StageCoach[model].rep
    local CurRep = Player.PlayerData.metadata["stagecoachrep"]
    if cashBalance >= RentalFee then
        if CurRep >= RepReq then
    Player.Functions.RemoveMoney("cash", RentalFee)
    TriggerClientEvent('qbr-stagecoach:Client:RentVehicle', -1, model)
        else
        TriggerClientEvent('qbr-stagecoach:client:notenoughrep', Player.PlayerData.source)
        end
    else
    TriggerClientEvent('qbr-stagecoach:client:notenoughmoney', Player.PlayerData.source)
    end
end)

-- ADD WAGONE BLIP FOR COACHES TO ALL PLAYERS

RegisterServerEvent("qbr-stagecoach:SendDriverEntity")
AddEventHandler("qbr-stagecoach:SendDriverEntity", function (coach_driver)
    print('server_coach_driver', coach_driver)
    TriggerClientEvent("qbr-stagecoach:AddDriverBlip", -1, coach_driver)
end)

-- Server Sync

RegisterServerEvent("qbr-stagecoach:StartCoachJobServer")
AddEventHandler("qbr-stagecoach:StartCoachJobServer", function (zone_name, spawn_coach, driving)
    local _src = source
    TriggerClientEvent("qbr-stagecoach:StartCoachJob", _src, zone_name, spawn_coach, driving)
end)

-- Loot Table
RegisterServerEvent("qbr-stagecoach:RewardsLoot")
AddEventHandler("qbr-stagecoach:RewardsLoot", function (fare)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local CurRep = Player.PlayerData.metadata["stagecoachrep"]
    local CurCompleted = Player.PlayerData.metadata["stagecoachcompleted"]
    local Amount = fare * Config.RewardMultiplier
    print(Amount)

    Player.Functions.SetMetaData('stagecoachrep', (CurRep + Config.AddedRep))
    Player.Functions.SetMetaData('stagecoachcompleted', (CurCompleted + 1))
    Wait(1000)
    print(CurRep)
    if CurRep <= 0 then
    Player.Functions.AddMoney("cash", Amount)
    elseif CurRep >= 0 and CurRep <= Config.RepLevelOne then
    Player.Functions.AddMoney("cash", Amount * 1.1)
    elseif CurRep >= Config.RepLevelOne and CurRep <= Config.RepLevelTwo then
    Player.Functions.AddMoney("cash", Amount * 1.2)
    elseif CurRep >= Config.RepLevelTwo and CurRep <= Config.RepLevelThree then
    Player.Functions.AddMoney("cash", Amount * 1.3)
    elseif CurRep >= Config.RepLevelThree and CurRep <= Config.RepLevelFour then
    Player.Functions.AddMoney("cash", Amount * 1.4)
    elseif CurRep >= Config.RepLevelFour and CurRep <= Config.RepLevelFive then
    Player.Functions.AddMoney("cash", Amount * 1.5)
    elseif CurRep >= Config.RepLevelFive and CurRep <= Config.RepLevelSix then
    Player.Functions.AddMoney("cash", Amount * 1.6)
    elseif CurRep >= Config.RepLevelSix and CurRep <= Config.RepLevelSeven then
    Player.Functions.AddMoney("cash", Amount * 1.7)
    elseif CurRep >= Config.RepLevelSeven and CurRep <= Config.RepLevelEight then
    Player.Functions.AddMoney("cash", Amount * 1.8)
    elseif CurRep >= Config.RepLevelEight and CurRep <= Config.RepLevelNine then
    Player.Functions.AddMoney("cash", Amount * 1.9)
    else
    Player.Functions.AddMoney("cash", Amount * 2.0)
    end
end)