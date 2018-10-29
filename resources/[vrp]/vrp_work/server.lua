local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_work")


local amount = 20

RegisterServerEvent('vrp_work:Pay')
AddEventHandler('vrp_work:Pay', function()


	local source = source
	local user_id = vRP.getUserId({source})
	vRP.giveBankMoney({user_id,amount})
	TriggerClientEvent("pNotify:SendNotification", source,{text = "Modtog <b style='color: #4E9350'>"..amount.." DKK</b>.", type = "success", queue = "global", timeout = 5000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})

end)

--notification
function sendNotification(source, message, messageType, messageTimeout)
    TriggerClientEvent("pNotify:SendNotification", user_id, {
        text = message,
        type = messageType,
        queue = "lmao",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end