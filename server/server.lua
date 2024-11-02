local bloodMoonStartHour = 22 -- 22:00
local bloodMoonEndHour = 5     -- 05:00

function EnableHalloweenWeatherVariation(currentTime)
    if Config.undeadWeather then
        if (currentTime >= bloodMoonStartHour or currentTime < bloodMoonEndHour) then
            if not bloodMoonActive then
                TriggerClientEvent('setHalloweenWeather', -1, "FOG")
                bloodMoonActive = true  
            end
        else
            if bloodMoonActive then
                TriggerClientEvent('setNormalWeatherWithTransition', -1, 30) 
                bloodMoonActive = false  
            end
        end
    else
        if bloodMoonActive then
            TriggerClientEvent('setNormalWeatherWithTransition', -1, 30) 
            bloodMoonActive = false  
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) 
        TriggerClientEvent('requestClockHours', -1)
    end
end)

RegisterNetEvent('sendClockHours')
AddEventHandler('sendClockHours', function(currentTime)
    EnableHalloweenWeatherVariation(currentTime)
end)

RegisterCommand('setHalloweenWeather', function(source, args, rawCommand)
    -- Solicita ao cliente a hora do jogo
    TriggerClientEvent('requestClockHours', source)
end, false)
