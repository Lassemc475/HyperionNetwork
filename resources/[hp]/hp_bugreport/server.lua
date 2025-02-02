--------------------------------
-- Created by Mathias (Budji) --
--------------------------------

MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_bugreport")

RegisterServerEvent('bugreport')
AddEventHandler('bugreport', function(x, y, z, message, heading, speed, health, veh)
    local source = source
    local user_id = vRP.getUserId({source})

    PerformHttpRequest('https://discordapp.com/api/webhooks/511552868143071233/kp0J4RthH8k2oiLEJ6ZojOJ0oUR6PDokKe8Td7aHs7Rv4Orv4z7kQNTkrY2geP0leCw0', 
        function(err, text, headers) end, 
        'POST', 
        json.encode({username = "Server " .. GetConvar("servernumber","0"), 
        content = user_id .. " rapporterede en fejl:\nBesked: " .. message .. "\nKoordinater: " .. x .. ", " .. y .. ", " .. z .. "\nHeading: " .. heading .. "\nHastighed: " .. speed .. "\nHP: " .. health .. "\nKøretøj: " .. veh}), 
        { ['Content-Type'] = 'application/json' })

    TriggerClientEvent("pNotify:SendNotification", source,{text ="Tak for at fortælle os om fejlen!", type = "info", queue = "global",timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
end)

