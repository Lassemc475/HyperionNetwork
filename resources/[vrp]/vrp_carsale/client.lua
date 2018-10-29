-- Settings
local depositAtATM = false -- Allows the player to deposit at an ATM rather than only in banks (Default: false)
local giveCashAnywhere = false -- Allows the player to give CASH to another player, no matter how far away they are. (Default: false)
local withdrawAnywhere = false -- Allows the player to withdraw cash from bank account anywhere (Default: false)
local depositAnywhere = false -- Allows the player to deposit cash into bank account anywhere (Default: false)
local displayBankBlips = true -- Toggles Bank Blips on the map (Default: true)
local displayAtmBlips = false -- Toggles ATM blips on the map (Default: false) // THIS IS UGLY. SOME ICONS OVERLAP BECAUSE SOME PLACES HAVE MULTIPLE ATM MACHINES. NOT RECOMMENDED
local enableBankingGui = true -- Enables the banking GUI (Default: true) // MAY HAVE SOME ISSUES

-- ATMS
local atms = {
  {name="Hæveautomat", id=277, x=-386.733, y=6045.953, z=31.501}
}

-- Banks
local banks = {
  {name="Bank", id=108, x=-54.31, y=-1097.28, z=26.42}
}

-- Display Map Blips
Citizen.CreateThread(function()
  if displayBankBlips then
    for k,v in ipairs(banks)do
      local blip = AddBlipForCoord(v.x, v.y, v.z)
      SetBlipSprite(blip, v.id)
      SetBlipScale(blip, 0.8)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING");
      AddTextComponentString(tostring(v.name))
      EndTextCommandSetBlipName(blip)
    end
  end
  if displayAtmBlips then
    for k,v in ipairs(atms)do
      local blip = AddBlipForCoord(v.x, v.y, v.z)
      SetBlipSprite(blip, v.id)
      SetBlipScale(blip, 0.65)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING");
      AddTextComponentString(tostring(v.name))
      EndTextCommandSetBlipName(blip)
    end
  end
end)

-- NUI Variables
local atBank = false
local atATM = false
local bankOpen = false
local atmOpen = false

-- Open Gui and Focus NUI
function openGui()
  SetNuiFocus(true, true)
  SendNUIMessage({openBank = true})
end

-- Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false)
  SendNUIMessage({openBank = false})
  bankOpen = false
  atmOpen = false
end

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

-- If GUI setting turned on, listen for INPUT_PICKUP keypress
if enableBankingGui then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if(IsNearBank() or IsNearATM()) and not (GetEntityHealth(GetPlayerPed(-1)) == 105) then
		if IsNearBank() then
			drawTxt('[~g~E~s~] for at snakke med John', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255) 
		else
			drawTxt('[~g~E~s~] for at snakke med John', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255) 
		end

        if IsControlJustPressed(1, 51)  then -- IF INPUT_PICKUP Is pressed
          if (IsInVehicle()) then
            TriggerEvent("pNotify:SendNotification",{text = "Dette kan du ikke gøre fra et køretøj.",type = "error",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          else
            if bankOpen then
              closeGui()
              bankOpen = false
            else
              TriggerServerEvent("bank:update")
              openGui()
              bankOpen = true
            end
          end
        end
      else
        if(atmOpen or bankOpen) then
          closeGui()
        end
        -- atBank = false
        atmOpen = false
        bankOpen = false
      end
    end
  end)
end

-- Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if bankOpen or atmOpen then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisableControlAction(0, 24, active) -- Attack
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
    end
    Citizen.Wait(0)
  end
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('balance', function(data, cb)
  SendNUIMessage({openSection = "balance"})
  cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
  SendNUIMessage({openSection = "withdraw"})
  cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
  SendNUIMessage({openSection = "deposit"})
  cb('ok')
end)

RegisterNUICallback('transfer', function(data, cb)
  SendNUIMessage({openSection = "transfer"})
  cb('ok')
end)

RegisterNUICallback('quickCash', function(data, cb, wallet)
  TriggerEvent('bank:deposit', wallet)
  cb('ok')
end)

RegisterNUICallback('withdrawSubmit', function(data, cb)
  TriggerEvent('bank:withdraw', data.amount)
  cb('ok')
end)

RegisterNUICallback('depositSubmit', function(data, cb)
  TriggerEvent('bank:deposit', data.amount)
  cb('ok')
end)

RegisterNUICallback('transferSubmit', function(data, cb)
  local fromPlayer = GetPlayerServerId(PlayerId());
  TriggerEvent('bank:transfer', tonumber(fromPlayer), tonumber(data.toPlayer), tonumber(data.amount))
  cb('ok')
end)

-- Check if player is near an atm
function IsNearATM()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(atms) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 3) then
      return true
    end
  end
end

-- Check if player is in a vehicle
function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

-- Check if player is near a bank
function IsNearBank()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(banks) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 3) then
      return true
    end
  end
end

-- Check if player is near another player
function IsNearPlayer(player)
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
  local ply2Coords = GetEntityCoords(ply2, 0)
  local distance = GetDistanceBetweenCoords(ply2Coords["x"], ply2Coords["y"], ply2Coords["z"],  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
  if(distance <= 5) then
    return true
  end
end

-- Process deposit if conditions met
RegisterNetEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
  if(IsNearBank() == true or depositAtATM == true and IsNearATM() == true or depositAnywhere == true ) then
    if (IsInVehicle()) then
     TriggerEvent("pNotify:SendNotification",{text = "Dette kan du ikke gøre fra et køretøj.",type = "error",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    else
     TriggerServerEvent("bank:deposit", tonumber(amount))
    end
  else
    TriggerEvent("pNotify:SendNotification",{text = "Du kan kun indsætte penge hos en bank.",type = "error",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
  end
end)

-- Process withdraw if conditions met
RegisterNetEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
  if(IsNearATM() == true or IsNearBank() == true or withdrawAnywhere == true) then
    if (IsInVehicle()) then
      TriggerEvent("pNotify:SendNotification",{text = "Dette kan du ikke gøre fra et køretøj.",type = "error",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    else
      TriggerServerEvent("bank:withdraw", tonumber(amount))
    end
  else
    TriggerEvent("pNotify:SendNotification",{text = "Dette kan du kun gøre i en bank eller ved en hæveautomat.",type = "error",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
  end
end)

-- Process give cash if conditions met
RegisterNetEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
  if(IsNearPlayer(toPlayer) == true or giveCashAnywhere == true) then
    local player2 = GetPlayerFromServerId(toPlayer)
    local playing = IsPlayerPlaying(player2)
    if (playing ~= false) then
      TriggerServerEvent("bank:givecash", toPlayer, tonumber(amount))
    else
      TriggerEvent("pNotify:SendNotification",{text = "Denne spiller er ikke online.",type = "error",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  else
    TriggerEvent("pNotify:SendNotification",{text = "Denne spiller er ikke i nærheden.",type = "error",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
  end
end)

-- Process bank transfer if player is online
RegisterNetEvent('bank:transfer')
AddEventHandler('bank:transfer', function(fromPlayer, toPlayer, amount)
  local player2 = GetPlayerFromServerId(toPlayer)
  local playing = IsPlayerPlaying(player2)
  if (playing ~= false) then
    TriggerServerEvent("bank:transfer", fromPlayer, toPlayer, tonumber(amount))
  else
    TriggerEvent("pNotify:SendNotification",{text = "Denne spiller er ikke online.",type = "error",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
  end
end)

-- Send NUI message to update bank balance
RegisterNetEvent('banking:updateBalance')
AddEventHandler('banking:updateBalance', function(balance, wallet)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
  SendNUIMessage({
    updateBalance = true,
    balance = balance,
    wallet = wallet,
    player = playerName
  })
end)

-- Send NUI Message to display add balance popup
RegisterNetEvent("banking:addBalance")
AddEventHandler("banking:addBalance", function(amount)
  SendNUIMessage({
    addBalance = true,
    amount = amount
  })

end)

-- Send NUI Message to display remove balance popup
RegisterNetEvent("banking:removeBalance")
AddEventHandler("banking:removeBalance", function(amount)
  SendNUIMessage({
    removeBalance = true,
    amount = amount
  })
end)
