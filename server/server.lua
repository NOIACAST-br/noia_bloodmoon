function EnableHalloweenWeatherVariation(currentTime)
    if Config.undeadWeather then
        if (currentTime >= 22 or currentTime < 5) then
            TriggerClientEvent('setHalloweenWeather', -1, "FOG")
        else
            TriggerClientEvent('setNormalWeather', -1)
        end
    else
        TriggerClientEvent('setNormalWeather', -1)
    end
end

RegisterCommand('setHalloweenWeather', function(source, args, rawCommand)
    TriggerClientEvent('requestClockHours', source)
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600000) 
        if Config.undeadWeather then
            TriggerClientEvent('requestClockHours', -1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600000) -- Aguarda 10 minutos antes de verificar novamente
        if Config.undeadWeather then
            TriggerClientEvent('requestClockHours', -1)
        end
    end
end)

RegisterNetEvent('sendClockHours')
AddEventHandler('sendClockHours', function(currentTime)
    EnableHalloweenWeatherVariation(currentTime)
end)