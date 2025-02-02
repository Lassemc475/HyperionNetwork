MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_garages")
vRPgc = Tunnel.getInterface("vRP_garages","vRP_garages")

--SQL--
MySQL.createCommand("vRP/ply_get_vehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
MySQL.createCommand("vRP/ply_remove_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")


-- PLY_GARAGES
RegisterServerEvent('ply_garages:CheckForAptGarages')
AddEventHandler('ply_garages:CheckForAptGarages', function()
    local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	vRP.getUserAddress({user_id, function(address)
      if address then
		if address.home == "Villa (5 Mil)" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -751.5107421875,365.883117675781,86.9666687011719,267.344543457031)
		elseif address.home == "Basis hus 1 (1 Mil)" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -635.4501953125,57.4368324279785,43.0,88.8649536132813)
		elseif address.home == "Basis hus 2 (1 Mil)" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -1477.7786865234,-503.66763305664,32.406842803955,29.5690689086914)
		elseif address.home == "Regular House 1" then
			TriggerClientEvent("ply_garages:addAptGarage", player, 843.398803710938,-191.063568115234,71.6714935302734,339.229705810547)
		elseif address.home == "Villa Wild Oats Dr. (10 Mil)" then
			TriggerClientEvent("ply_garages:addAptGarage", player, 174.276748657227,483.056274414063,141.339096069336,357.040771484375)
		elseif address.home == "Regular House 3" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -820.590148925781,184.175857543945,71.0921401977539,131.889053344727)
		elseif address.home == "Regular House 4" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -1858.14965820313,328.570861816406,87.6500091552734,8.03947734832764)
		elseif address.home == "Regular House 5" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -25.002462387085,-1436.29431152344,29.6531391143799,89.9820022583008)
		elseif address.home == "Hawks Ale" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -81.860595703125,-809.427734375,35.4030570983887,350.814697265625)
		elseif address.home == "Midtown Lejlighed 3" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -286.63983154297,-914.98571777344,31.080615997314,342.87274169922)
		elseif address.home == "Midtown Lejlighed 6" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -820.92724609375,-383.39880371094,38.013271331787,27.119449615479)
		elseif address.home == "Midtown Lejlighed 7" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -820.92724609375,-383.39880371094,38.013271331787,27.119449615479)
		elseif address.home == "Midtown Lejlighed 8" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -820.92724609375,-383.39880371094,38.013271331787,27.119449615479)
		elseif address.home == "Midtown Lejlighed 9" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -820.92724609375,-383.39880371094,38.013271331787,27.119449615479)
		elseif address.home == "Midtown Lejlighed 10" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -828.84326171875,-437.74356079102,36.639904022217,70.669303894043)
		elseif address.home == "Regular House 6" then
			TriggerClientEvent("ply_garages:addAptGarage", player, -2587,1930.97326660156,166.304656982422,93.3231887817383)
		end
      end
	end})
end)

RegisterServerEvent('ply_garages:CheckForSpawnVeh')
AddEventHandler('ply_garages:CheckForSpawnVeh', function(vehicle)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	MySQL.query("vRP/ls_customs", {user_id = user_id, vehicle = vehicle}, function(result, affected)
	  vRP.closeMenu({player})
      vRPgc.spawnGarageVehicle(player,{result[1].veh_type,vehicle,result[1].vehicle_plate, result[1].vehicle_colorprimary, result[1].vehicle_colorsecondary, result[1].vehicle_pearlescentcolor, result[1].vehicle_wheelcolor, result[1].vehicle_plateindex, result[1].vehicle_neoncolor1, result[1].vehicle_neoncolor2, result[1].vehicle_neoncolor3, result[1].vehicle_windowtint, result[1].vehicle_wheeltype, result[1].vehicle_mods0, result[1].vehicle_mods1, result[1].vehicle_mods2, result[1].vehicle_mods3, result[1].vehicle_mods4, result[1].vehicle_mods5, result[1].vehicle_mods6, result[1].vehicle_mods7, result[1].vehicle_mods8, result[1].vehicle_mods9, result[1].vehicle_mods10, result[1].vehicle_mods11, result[1].vehicle_mods12, result[1].vehicle_mods13, result[1].vehicle_mods14, result[1].vehicle_mods15, result[1].vehicle_mods16, result[1].vehicle_turbo, result[1].vehicle_tiresmoke, result[1].vehicle_xenon, result[1].vehicle_mods23, result[1].vehicle_mods24, result[1].vehicle_neon0, result[1].vehicle_neon1, result[1].vehicle_neon2, result[1].vehicle_neon3, result[1].vehicle_bulletproof, result[1].vehicle_smokecolor1, result[1].vehicle_smokecolor2, result[1].vehicle_smokecolor3, result[1].vehicle_modvariation})
	end)
end)

RegisterServerEvent('ply_garages:CheckForVeh')
AddEventHandler('ply_garages:CheckForVeh', function(plate,vehicle,vtype)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  MySQL.query("vRP/lsc_get_vehicle", {user_id = user_id, vehicle = vehicle, plate = plate}, function(rows, affected)
    if #rows > 0 then -- has vehicle
      vRPgc.despawnGarageVehicle(player,{vtype,5})
	else
	TriggerClientEvent("pNotify:SendNotification", player,{text = "Intet køretøj i nærheden", type = "error", queue = "global", timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
  end)
end)


RegisterServerEvent('ply_garages:CheckGarageForVeh')
AddEventHandler("ply_garages:CheckGarageForVeh", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    MySQL.query("vRP/ply_get_vehicles", {user_id = user_id}, function(pvehicles, affected)
      local vehicles = {}
      for k,v in ipairs(pvehicles) do
		if v.veh_type == "car" or v.veh_type == "bike" or v.veh_type == "citybike" then
		  table.insert(vehicles, {["vehicle_model"] = v.vehicle, ["vehicle_name"] = v.vehicle_name})
		end
      end
      TriggerClientEvent("ply_garages:getVehicles", player, vehicles) 
	end)
end)