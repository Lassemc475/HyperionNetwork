--[[Proxy/Tunnel]]--

vRPgt = {}
Tunnel.bindInterface("vRP_garages",vRPgt)
Proxy.addInterface("vRP_garages",vRPgt)
vRP = Proxy.getInterface("vRP")

--[[Local/Global]]--

GVEHICLES = {}
local inrangeofgarage = false
local currentlocation = nil

local garages = {
	{name="Garage", colour=3, id=357, x=215.124, y=-791.377, z=29.646, h=0.0, hidden=false},
	{name="Garage", colour=3, id=357, x=-334.685, y=289.773, z=84.705, h=0.0, hidden=false},
	{name="Garage", colour=3, id=357, x=-55.272, y=-1838.71, z=25.442, h=0.0, hidden=false},
	{name="Garage", colour=3, id=357, x=126.434, y=6610.04, z=30.750, h=0.0, hidden=false},
	{name="Garage", colour=3, id=357, x=-2035.372, y=-470.555, z=10.376, h=0.0, hidden=false},
	{name="Garage", colour=3, id=357, x=-1329.208, y=-227.850, z=40.90, h=0.0, hidden=false},
	{name="Hidden Garage", colour=3, id=357, x=970.27404785156, y=-138.7984161377, z=72.986566162109, h=0.0, hidden=true},
	{name="Hidden Garage", colour=3, id=357, x=2410.1516113281, y=4987.2211914063, z=44.803681945801, h=0.0, hidden=true},
	{name="Hidden Garage", colour=3, id=357, x=1992.5806884766, y=3031.3732910156, z=45.656331634521, h=0.0, hidden=true},
	{name="Hidden Garage", colour=3, id=357, x=436.12869262695, y=-1021.3997192383, z=27.7141456604, h=0.0, hidden=true}, -- Garage PD
	{name="Hidden Garage", colour=3, id=357, x=-146.22012329102, y=-582.45098876953, z=32.424468994141, h=0.0, hidden=true},
	{name="Hidden Garage", colour=3, id=357, x=488.29916381836, y=-1158.5330810547, z=27.883285522461, h=0.0, hidden=true},
	{name="Hidden Garage", colour=3, id=357, x=19.306434631348, y=3678.2075195313, z=39.755027770996, h=0.0, hidden=true},
	{name="Hidden Garage", colour=3, id=357, x=1014.8598022461, y=-1846.5537109375, z=29.991794586182, h=0.0, hidden=true},
	{name="Hidden Garage", colour=3, id=357, x=1180.6281738281, y=-3262.7180175781, z=5.5700173377991, h=0.0, hidden=true},
	{name="Hidden Garage", colour=3, id=357, x=-2166.837890625, y=4280.5141601563, z=47.8268699646, h=0.0, hidden=true}
}

vehicles = {}
garageSelected = { {x=nil, y=nil, z=nil, h=nil}, }
selectedPage = 0

lang_string = {
menu1 = "Parker køretøj",
menu2 = "Hent køretøj",
menu3 = "Luk",
menu4 = "Køretøjer",
menu5 = "Valgmuligheder",
menu6 = "Hent",
menu7 = "Tilbage",
menu8 = "Tryk ~g~E~s~ for at åbne menuen",
menu9 = "Sælg",
menu10 = "Tryk ~g~E~s~ for at sælge køretøjet",
menu11 = "Opdater bilen",
menu12 = "Næste",
state1 = "Ude",
state2 = "Inde",
text1 = "Området er overfyldt",
text2 = "Køretøjet er ikke parkeret",
text3 = "Køretøjer er ude",
text4 = "Dette er ikke dit køretøj",
text5 = "Køretøj parkeret",
text6 = "Intet køretøj i nærheden",
text7 = "Køretøj solgt",
text8 = "Køretøj købt, god tur",
text9 = "Du har ikke råd",
text10 = "Køretøj opdateret"
}
--[[Functions]]--

function vRPgt.spawnGarageVehicle(vtype, name, vehicle_plate, vehicle_colorprimary, vehicle_colorsecondary, vehicle_pearlescentcolor, vehicle_wheelcolor, vehicle_plateindex, vehicle_neoncolor1, vehicle_neoncolor2, vehicle_neoncolor3, vehicle_windowtint, vehicle_wheeltype, vehicle_mods0, vehicle_mods1, vehicle_mods2, vehicle_mods3, vehicle_mods4, vehicle_mods5, vehicle_mods6, vehicle_mods7, vehicle_mods8, vehicle_mods9, vehicle_mods10, vehicle_mods11, vehicle_mods12, vehicle_mods13, vehicle_mods14, vehicle_mods15, vehicle_mods16, vehicle_turbo, vehicle_tiresmoke, vehicle_xenon, vehicle_mods23, vehicle_mods24, vehicle_neon0, vehicle_neon1, vehicle_neon2, vehicle_neon3, vehicle_bulletproof, vehicle_smokecolor1, vehicle_smokecolor2, vehicle_smokecolor3, vehicle_modvariation) -- vtype is the vehicle type (one vehicle per type allowed at the same time)

  local vehicle = vehicles[vtype]
  if vehicle and not IsVehicleDriveable(vehicle[3]) then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    SetEntityAsMissionEntity(vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
	TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i+1
    end

    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition({})
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      SetVehicleNumberPlateText(nveh, vehicle_plate)
      SetEntityAsMissionEntity(nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)
	  vehicle_migration = false
      if not vehicle_migration then
        local nid = NetworkGetNetworkIdFromEntity(nveh)
        SetNetworkIdCanMigrate(nid,false)
      end

	  TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})

      SetModelAsNoLongerNeeded(mhash)
	  
	  --grabbing customization
      local plate = plate
      local primarycolor = tonumber(vehicle_colorprimary)
      local secondarycolor = tonumber(vehicle_colorsecondary)
      local pearlescentcolor = vehicle_pearlescentcolor
      local wheelcolor = vehicle_wheelcolor
      local plateindex = tonumber(vehicle_plateindex)
      local neoncolor = {vehicle_neoncolor1,vehicle_neoncolor2,vehicle_neoncolor3}
      local windowtint = vehicle_windowtint
      local wheeltype = tonumber(vehicle_wheeltype)
      local mods0 = tonumber(vehicle_mods0)
      local mods1 = tonumber(vehicle_mods1)
      local mods2 = tonumber(vehicle_mods2)
      local mods3 = tonumber(vehicle_mods3)
      local mods4 = tonumber(vehicle_mods4)
      local mods5 = tonumber(vehicle_mods5)
      local mods6 = tonumber(vehicle_mods6)
      local mods7 = tonumber(vehicle_mods7)
      local mods8 = tonumber(vehicle_mods8)
      local mods9 = tonumber(vehicle_mods9)
      local mods10 = tonumber(vehicle_mods10)
      local mods11 = tonumber(vehicle_mods11)
      local mods12 = tonumber(vehicle_mods12)
      local mods13 = tonumber(vehicle_mods13)
      local mods14 = tonumber(vehicle_mods14)
      local mods15 = tonumber(vehicle_mods15)
      local mods16 = tonumber(vehicle_mods16)
      local turbo = vehicle_turbo
      local tiresmoke = vehicle_tiresmoke
      local xenon = vehicle_xenon
      local mods23 = tonumber(vehicle_mods23)
      local mods24 = tonumber(vehicle_mods24)
      local neon0 = vehicle_neon0
      local neon1 = vehicle_neon1
      local neon2 = vehicle_neon2
      local neon3 = vehicle_neon3
      local bulletproof = vehicle_bulletproof
      local smokecolor1 = vehicle_smokecolor1
      local smokecolor2 = vehicle_smokecolor2
      local smokecolor3 = vehicle_smokecolor3
      local variation = vehicle_modvariation
	  
	  --setting customization
      SetVehicleColours(nveh, primarycolor, secondarycolor)
      SetVehicleExtraColours(nveh, tonumber(pearlescentcolor), tonumber(wheelcolor))
      SetVehicleNumberPlateTextIndex(nveh,plateindex)
      SetVehicleNeonLightsColour(nveh,tonumber(neoncolor[1]),tonumber(neoncolor[2]),tonumber(neoncolor[3]))
      SetVehicleTyreSmokeColor(nveh,tonumber(smokecolor1),tonumber(smokecolor2),tonumber(smokecolor3))
      SetVehicleModKit(nveh,0)
      SetVehicleMod(nveh, 0, mods0)
      SetVehicleMod(nveh, 1, mods1)
      SetVehicleMod(nveh, 2, mods2)
      SetVehicleMod(nveh, 3, mods3)
      SetVehicleMod(nveh, 4, mods4)
      SetVehicleMod(nveh, 5, mods5)
      SetVehicleMod(nveh, 6, mods6)
      SetVehicleMod(nveh, 7, mods7)
      SetVehicleMod(nveh, 8, mods8)
      SetVehicleMod(nveh, 9, mods9)
      SetVehicleMod(nveh, 10, mods10)
      SetVehicleMod(nveh, 11, mods11)
      SetVehicleMod(nveh, 12, mods12)
      SetVehicleMod(nveh, 13, mods13)
      SetVehicleMod(nveh, 14, mods14)
      SetVehicleMod(nveh, 15, mods15)
      SetVehicleMod(nveh, 16, mods16)
      if turbo == "on" then
        ToggleVehicleMod(nveh, 18, true)
      else          
        ToggleVehicleMod(nveh, 18, false)
      end
      if tiresmoke == "on" then
        ToggleVehicleMod(nveh, 20, true)
      else          
        ToggleVehicleMod(nveh, 20, false)
      end
      if xenon == "on" then
        ToggleVehicleMod(nveh, 22, true)
      else          
        ToggleVehicleMod(nveh, 22, false)
      end
		SetVehicleWheelType(nveh, tonumber(wheeltype))
      SetVehicleMod(nveh, 23, mods23)
      SetVehicleMod(nveh, 24, mods24)
      if neon0 == "on" then
        SetVehicleNeonLightEnabled(nveh,0, true)
      else
        SetVehicleNeonLightEnabled(nveh,0, false)
      end
      if neon1 == "on" then
        SetVehicleNeonLightEnabled(nveh,1, true)
      else
        SetVehicleNeonLightEnabled(nveh,1, false)
      end
      if neon2 == "on" then
        SetVehicleNeonLightEnabled(nveh,2, true)
      else
        SetVehicleNeonLightEnabled(nveh,2, false)
      end
      if neon3 == "on" then
        SetVehicleNeonLightEnabled(nveh,3, true)
      else
        SetVehicleNeonLightEnabled(nveh,3, false)
      end
      if bulletproof == "on" then
        SetVehicleTyresCanBurst(nveh, false)
      else
        SetVehicleTyresCanBurst(nveh, true)
      end
      --if variation == "on" then
      --  SetVehicleModVariation(nveh,23)
      --else
      --  SetVehicleModVariation(nveh,23, false)
      --end
      SetVehicleWindowTint(nveh,tonumber(windowtint))
    end
  else
    -- vRP.notify({"Du kan kun have en "..vtype.." ude."})
			
	TriggerEvent("pNotify:SendNotification",{
    text = "Du kan kun have én <b style='color:#B22222'>"..vtype.."</b> ude",
    type = "info",
    timeout = (2000),
    layout = "bottomCenter",
    queue = "global",
	animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},
	killer = true
	})
  end
end

function vRPgt.spawnBoughtVehicle(vtype, name)

  local vehicle = vehicles[vtype]
  if vehicle then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    SetEntityAsMissionEntity(vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
	TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i+1
    end

    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition({})
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      SetVehicleNumberPlateText(nveh, "P" .. vRP.getRegistrationNumber({}))
      SetEntityAsMissionEntity(nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)
	  vehicle_migration = false
      if not vehicle_migration then
        local nid = NetworkGetNetworkIdFromEntity(nveh)
        SetNetworkIdCanMigrate(nid,false)
      end
	  TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})
	  
	  Citizen.CreateThread(function()
	    Citizen.Wait(1000)
		TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))), GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1)))))
	  end)

      SetModelAsNoLongerNeeded(mhash)
    end
  else
    -- vRP.notify({"Du kan kun have en "..vtype.." ude."})
	  	
	TriggerEvent("pNotify:SendNotification",{
    text = "Du kan kun have én <b style='color:#B22222'>"..vtype.."</b> ude",
    type = "info",
    timeout = (2000),
    layout = "bottomRight",
    queue = "global",
	animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
	})
  end
end

function vRPgt.despawnGarageVehicle(vtype,max_range)
  local vehicle = vehicles[vtype]
  if vehicle then
    local x,y,z = table.unpack(GetEntityCoords(vehicle[3],true))
    local px,py,pz = vRP.getPosition()

    if GetDistanceBetweenCoords(x,y,z,px,py,pz,true) < max_range then -- check distance with the vehicule
      -- remove vehicle
      SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
      Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
      SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
	  TriggerEvent("vrp_garages:setVehicle", vtype, nil)
      -- vRP.notify({"~g~Køretøj parkeret."})
	TriggerEvent("pNotify:SendNotification",{
	text = "Køretøj <b style='color:#0dad18'>parkeret</b>",
	type = "success",
	timeout = (3000),
	layout = "bottomCenter",
	queue = "global",
	animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
	})
    else
      -- vRP.notify({"~r~For langt væk fra køretøjet."})
	TriggerEvent("pNotify:SendNotification",{
	text = "Du er for <b style='color:#0dad18'>langt væk</b> fra køretøjet",
	type = "error",
	timeout = (3000),
	layout = "bottomCenter",
	queue = "global",
	animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
	})
    end
  else
  -- vRP.notify({"~r~Du har intet køretøj ude."})
  
	TriggerEvent("pNotify:SendNotification",{
	text = "Du har <b style='color:#ff0000'>intet</b> køretøj ude",
	type = "info",
	timeout = (3000),
	layout = "bottomCenter",
	queue = "global",
	animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
	})
  end
end

function MenuGarage()
    ped = GetPlayerPed(-1)
	selectedPage = 0
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton(lang_string.menu1,"StoreVehicle",nil)
    Menu.addButton(lang_string.menu2,"ListVehicle",selectedPage)
    Menu.addButton(lang_string.menu3,"CloseMenu",nil) 
end

function StoreVehicle()
  Citizen.CreateThread(function()
    local caissei = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 3.000, 0, 70)
    SetEntityAsMissionEntity(caissei, true, true)
    local plate = GetVehicleNumberPlateText(caissei)
	local vtype = "car"
	if IsThisModelABike(GetEntityModel(caissei)) then
		vtype = "bike"
	end
    if DoesEntityExist(caissei) then
	local damage = GetVehicleBodyHealth(caissei)
		if damage < 980 or not AreAllVehicleWindowsIntact(caissei) or IsVehicleDoorDamaged(caissei,0) or IsVehicleDoorDamaged(caissei,1) or IsVehicleDoorDamaged(caissei,2) or IsVehicleDoorDamaged(caissei,3) then
			TriggerEvent("pNotify:SendNotification",{text = "Dit køretøj er skadet, reparer det før du parkerer",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		else
		TriggerEvent("pNotify:SendNotification",{text = "parkeret dit møgsvin",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		
      TriggerServerEvent('ply_garages:CheckForVeh', plate, vehicles[vtype][2], vtype)
	  end
    else
     TriggerEvent("pNotify:SendNotification",{
    text = "<b style='color:#B22222'>Intet køretøj i nærheden</b> ude",
    type = "info",
    timeout = (2000),
    layout = "bottomCenter",
    queue = "global",
	animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},
	killer = true
	})
    end   
  end)
  CloseMenu()
end

function ListVehicle(page)
    ped = GetPlayerPed(-1)
	selectedPage = page
    MenuTitle = lang_string.menu4
    ClearMenu()
	local count = 0
    for ind, value in pairs(GVEHICLES) do
	  if ((count >= (page*10)) and (count < ((page*10)+10))) then
        Menu.addButton(tostring(value.vehicle_name), "OptionVehicle", tostring(value.vehicle_model))
	  end
	  count = count + 1
    end   
    Menu.addButton(lang_string.menu12,"ListVehicle",page+1)
	if page == 0 then
      Menu.addButton(lang_string.menu7,"MenuGarage",nil)
	else
      Menu.addButton(lang_string.menu7,"ListVehicle",page-1)
	end
end

function OptionVehicle(vehID)
  local vehID = vehID
    MenuTitle = "Valg"
    ClearMenu()
    Menu.addButton(lang_string.menu6, "SpawnVehicle", vehID)
    Menu.addButton(lang_string.menu7, "ListVehicle", selectedPage)
end

function SpawnVehicle(vehID)
  local vehID = vehID
  TriggerServerEvent('ply_garages:CheckForSpawnVeh', vehID)
  CloseMenu()
end


function drawNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

function CloseMenu()
    Menu.hidden = true    
    TriggerServerEvent("ply_garages:CheckGarageForVeh")
end

function LocalPed()
  return GetPlayerPed(-1)
end

function IsPlayerInRangeOfGarage()
  return inrangeofgarage
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

function ply_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

--[[Citizen]]--

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    for _, garage in pairs(garages) do
      DrawMarker(1, garage.x, garage.y, garage.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
      if GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 3 and IsPedInAnyVehicle(LocalPed(), true) == false then
        ply_drawTxt(lang_string.menu8,0,1,0.5,0.8,0.6,255,255,255,255)
        if IsControlJustPressed(1, 51) then
          garageSelected.x = garage.x
          garageSelected.y = garage.y
          garageSelected.z = garage.z
          MenuGarage()
          Menu.hidden = not Menu.hidden 
        end
        Menu.renderGUI() 
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    local near = false
    Citizen.Wait(0)
    for _, garage in pairs(garages) do    
      if (GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 3 and near ~= true) then 
        near = true             
      end
    end
    if near == false then 
      Menu.hidden = true
    end
  end
end)

Citizen.CreateThread(function()
    for _, item in pairs(garages) do
		if not item.hidden then
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipAsShortRange(item.blip, true)
			SetBlipColour(item.blip, item.colour)
      SetBlipScale(item.blip, 0.8)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.name)
			EndTextCommandSetBlipName(item.blip)
		end
    end
end)

--[[Events]]--

RegisterNetEvent('vrp_garages:setVehicle')
AddEventHandler('vrp_garages:setVehicle', function(vtype, vehicle)
	vehicles[vtype] = vehicle
end)

RegisterNetEvent('ply_garages:addAptGarage')
AddEventHandler('ply_garages:addAptGarage', function(gx,gy,gz,gh)
local alreadyExists = false
for _, garage in pairs(garages) do
	if garage.x == gx and garage.y == gy then
		alreadyExists = true
	end
end
if not alreadyExists then
	table.insert(garages, #garages + 1, {name="Lejligheds garage", colour=3, id=357, x=gx, y=gy, z=gz, h=gh})
end
end)

RegisterNetEvent('ply_garages:getVehicles')
AddEventHandler("ply_garages:getVehicles", function(THEVEHICLES)
    GVEHICLES = {}
    GVEHICLES = THEVEHICLES
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("ply_garages:CheckGarageForVeh")
    TriggerServerEvent("ply_garages:CheckForAptGarages")
end)
