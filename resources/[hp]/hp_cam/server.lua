local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_cam")



RegisterCommand("cam", function(source, args, raw)
	local source = source
    local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id,"journalist.announce"}) then
		local src = source
		TriggerClientEvent("Cam:ToggleCam", src)
	end
end)

RegisterCommand("bmic", function(source, args, raw)
	local source = source
    local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id,"journalist.announce"}) then
		local src = source
		TriggerClientEvent("Mic:ToggleBMic", src)
	end
end)

RegisterCommand("mic", function(source, args, raw)
	local source = source
    local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id,"journalist.announce"}) then
		local src = source
		TriggerClientEvent("Mic:ToggleMic", src)
	end
end)