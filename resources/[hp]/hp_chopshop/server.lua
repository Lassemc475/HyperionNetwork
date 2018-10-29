--------------------------------
-- Created by Mathias (Budji) --
--------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_hpchop")

AddEventHandler('chatMessage', function(source, name, message)
    splitmessage = stringsplit(message, " ");
    if string.lower(splitmessage[1]) == "/chopshop" then
        CancelEvent()
        TriggerClientEvent("hp:ChopShopList", source)
    end
end)

RegisterServerEvent('hp:ChopShopPay')
AddEventHandler('hp:ChopShopPay', function(amount)
    local source = source
    local player = vRP.getUserSource({user_id})
    local user_id = vRP.getUserId({source})
    vRP.giveInventoryItem({user_id,"dirty_money",amount})

end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end