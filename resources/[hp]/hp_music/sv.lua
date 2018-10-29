RegisterCommand("musik", function(source, args, raw)
    local src = source
    TriggerClientEvent("music:start", src)
end)