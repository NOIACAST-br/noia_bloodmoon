RegisterNetEvent('requestClockHours')
AddEventHandler('requestClockHours', function()
    local currentTime = GetClockHours()
    TriggerServerEvent('sendClockHours', currentTime)
end)

RegisterNetEvent('setHalloweenWeather')
AddEventHandler('setHalloweenWeather', function(weatherType)
    local transition_time_in_seconds = 30.0
    local next_weather_type_hash = GetHashKey(weatherType)
    Citizen.InvokeNative(0x59174F1AFE095B5A, next_weather_type_hash, true, true, true, transition_time_in_seconds, false)  
    N_0x3373779baf7caf48("MISTY", "misty_MP_Pred")
    N_0x3373779baf7caf48("SHOWER", "shower_MP_Pred")
    N_0x3373779baf7caf48("FOG", "fog_MP_Pred")
end)

RegisterNetEvent('setNormalWeatherWithTransition')
AddEventHandler('setNormalWeatherWithTransition', function(transitionTime)
    local transition_time_in_seconds = transitionTime or 30.0
    local clearWeatherType = "CLEAR"
    local next_weather_type_hash = GetHashKey(clearWeatherType)
    
    Citizen.InvokeNative(0x59174F1AFE095B5A, next_weather_type_hash, true, true, true, transition_time_in_seconds, false)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('requestClockHours')
end)
