local displayComputerBlips = false -- Toggles Bank Blips on the map (Default: true)
local enableComputerGui = true -- Enables the banking GUI (Default: true) // MAY HAVE SOME ISSUES
local name = "Bill's bilshop"
-- Banks
local computers = {
    {name="Computer", id=108, x=-1156.2083, y=-1720.7385, z=4.9049},
    --{name="Computer", id=108, x=-366.81, y=-123.99, z=38.7},
}
-- Display Map Blips
Citizen.CreateThread(function()
    if displayComputerBlips then
        for k,v in ipairs(computers)do
            local blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(blip, v.id)
            SetBlipScale(blip, 0.8)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING");
            AddTextComponentString(tostring(v.name))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- NUI Variables
local computerOpen = false

-- Open Gui and Focus NUI
function openGui()
    SetNuiFocus(true, true)
    SendNUIMessage({openComputer = true})
end

-- Close Gui and disable NUI
function closeGui()
    SetNuiFocus(false)
    SendNUIMessage({openComputer = false})
    computerOpen = false
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
if enableComputerGui then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if IsNearComputer() and not (GetEntityHealth(GetPlayerPed(-1)) == 105) then
                if IsNearComputer() then
                    drawTxt('[~g~E~s~] for at tilgå '..name, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                end
                if IsControlJustPressed(1, 51) then
                    if (IsInVehicle()) then
                        chatPrint("Du kan ikke sidde i et køretøj")
                    else
                        if (GetEntityHealth(GetPlayerPed(-1)) == 100) then
                            chatPrint("Du kan ikke bruge computeren imens du er død!")
                        else
                            if computerOpen then
                                closeGui()
                                computerOpen = false
                            else
                                TriggerServerEvent("cardealer:getfront")
                                openGui()
                                computerOpen = true
                            end
                        end
                    end
                end
            else
                if(computerOpen) then
                    closeGui()
                end
                computerOpen = false
            end
        end
    end)
end

-- Disable controls while GUI open
Citizen.CreateThread(function()
    SetNuiFocus( false )
    while true do
        if computerOpen then
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

RegisterNUICallback('carsubmit', function(data, cb)
    TriggerServerEvent("cardealer:create", data['vehiclename'], data['vehicle'], data['vehicledesc'],data['price'],data['img'])
    cb('ok')
end)
RegisterNUICallback('getsearch', function(data, cb)
    TriggerServerEvent("cardealer:getsearch", data["search"])
    cb('ok')
end)
RegisterNUICallback('getprofil', function(data, cb)
    TriggerServerEvent("cardealer:getprofil")
    cb('ok')
end)
RegisterNUICallback('getvehicles', function(data, cb)
    TriggerServerEvent("cardealer:get")
    cb('ok')
end)
RegisterNUICallback('getfrontpage', function(data, cb)
    TriggerServerEvent("cardealer:getAll")
    cb('ok')
end)
RegisterNUICallback('buy', function(data, cb)
    TriggerServerEvent("cardealer:Buy", data['id'])
    cb('ok')
end)
RegisterNUICallback('confirmedbuy', function(data, cb)
    TriggerServerEvent("cardealer:ConfirmBuy", data['id'])
    cb('ok')
end)
RegisterNUICallback('deleteProfil', function(data, cb)
    TriggerServerEvent("cardealer:deleteProfil", data['id'])
    cb('ok')
end)

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
function IsNearComputer()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for _, item in pairs(computers) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance <= 1) then
            return true
        end
    end
end

-- Send NUI Message to display add balance popup
RegisterNetEvent("cardealer:discord")
AddEventHandler("cardealer:discord", function(discord, id, img, vehiclename, vehicle, price, vehicledesc, link)
    SendNUIMessage({
        mode = "discord",
        discord = discord,
        id = id,
        img = img,
        vehiclename = vehiclename,
        vehicle = vehicle,
        price = price,
        vehicledesc = vehicledesc,
        link = link
    })
end)

RegisterNetEvent("cardealer:search")
AddEventHandler("cardealer:search", function(list)
    SendNUIMessage({
        mode = "search",
        list = list
    })
end)

RegisterNetEvent("cardealer:sendBuy")
AddEventHandler("cardealer:sendBuy", function(list, user_id)
    if(list ~= "0") then
        SendNUIMessage({
            mode = "buy",
            user_id = user_id,
            id = list[1]["cardealer_id"],
            title = list[1]["cardealer_vehiclename"],
            seller = list[1]["cardealer_seller"],
            desc = list[1]["cardealer_vehicledesc"],
            sellerphone = list["phone"],
            sellername = list[1]["cardealer_sellername"],
            price = list[1]["cardealer_price"],
            img = list[1]["cardealer_img"],
        })
    end
end)

RegisterNetEvent("cardealer:updatevehlist")
AddEventHandler("cardealer:updatevehlist", function(list)
    if(list ~= "0") then
        local cars = ""
        for k,v in pairs(list) do
            if(cars == "") then
                cars = v['vehicle']..":"..v['vehicle_name']
            else
                cars = cars .. "," .. v['vehicle']..":"..v['vehicle_name']
            end
        end
        SendNUIMessage({
            mode = "carlist",
            player = list[1]["user_id"],
            list = cars
        })
    else
        SendNUIMessage({
            mode = "carlist",
            list = ""
        })
    end
end)

RegisterNetEvent("cardealer:showProfil")
AddEventHandler("cardealer:showProfil", function(list)
    SendNUIMessage({
        mode = "profil",
        list = list
    })
end)

RegisterNetEvent("cardealer:frontpage")
AddEventHandler("cardealer:frontpage", function(list)
    SendNUIMessage({
        mode = "frontlist",
        list = list
    })
end)

-- FUNCTION
function chatPrint( msg )
    TriggerEvent( 'chatMessage', "^3"..name, { 255, 255, 255 }, msg )
end