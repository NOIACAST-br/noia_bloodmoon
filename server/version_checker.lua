local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'
    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    local latestVersion = '1.0.0'  
    local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

    if currentVersion then
        versionCheckPrint('success', ('Versão atual do recurso: %s'):format(currentVersion))

        if currentVersion ~= latestVersion then
            versionCheckPrint('error', ('Sua versão está desatualizada. Atualize para a versão mais recente: %s'):format(latestVersion))
        else
            versionCheckPrint('success', 'Você está rodando a versão mais recente do recurso.')
        end
    else
        versionCheckPrint('error', 'A versão não está definida no fxmanifest.')
    end
end

CreateThread(function()
    CheckVersion()
end)
