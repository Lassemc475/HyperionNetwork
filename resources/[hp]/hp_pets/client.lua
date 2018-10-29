--------------------------------
-- Created by Mathias (Budji) --
--------------------------------

local pet = nil
local dogModel = ""
local has_control = false

RegisterCommand('dyr', function(source, args, rawCommand)
    if pet == nil then

        splitmessage = stringsplit(rawCommand, " ");


        if string.lower(splitmessage[2]) == "rottweiler" then
            dogModel = "a_c_rottweiler"
        elseif string.lower(splitmessage[2]) == "husky" then
            dogModel = "a_c_husky"
        elseif string.lower(splitmessage[2]) == "shepherd" then
            dogModel = "a_c_shepherd"
        elseif string.lower(splitmessage[2]) == "retriever" then
            dogModel = "a_c_retriever"
        elseif string.lower(splitmessage[2]) == "pug" then
            dogModel = "a_c_pug"
        elseif string.lower(splitmessage[2]) == "poodle" then
            dogModel = "a_c_poodle"
        elseif string.lower(splitmessage[2]) == "westy" then
            dogModel = "a_c_westy"
        else
            TriggerEvent('chatMessage', '^7Error', "^7Error", "Forkert valg af dyr")
        end

        --Spawn pet
        if dogModel ~= "" then
            local pedPet = GetHashKey(dogModel)
            RequestModel(pedPet)

            while not HasModelLoaded(pedPet) do
                Citizen.Wait(1)
                RequestModel(pedPet)
            end

            local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(GetLocalPlayer(), 0.0, 2.0, 1.0))
            local dog = CreatePed(28, pedPet, x, y, z, GetEntityHeading(GetLocalPlayer()), 0, 1)
            pet = dog

            SetBlockingOfNonTemporaryEvents(pet, true)
            SetPedFleeAttributes(pet,0,0)
            SetPedRelationshipGroupHash(pet, GetHashKey("PLAYER"))
            AddRelationshipGroup("playerPet")
            SetRelationshipBetweenGroups(5, GetHashKey("playerPet"), GetHashKey("PLAYER"))

            NetworkRegisterEntityAsNetworked(pet)
            while not NetworkGetEntityIsNetworked(pet) do
                NetworkRegisterEntityAsNetworked(pet)
                Citizen.Wait(1)
            end
            
            RequestNetworkControl(function(cb)
                has_control = cb
            end)

            if has_control then
                TaskFollowToOffsetOfEntity(pet, GetLocalPlayer(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
                SetPedKeepTask(pet, true)
            end
        end
    else
        --Delete pet
        SetEntityAsMissionEntity(pet, true, true)
        DeleteEntity(pet)
        pet = nil
        dogModel = ""
    end

end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if pet ~= nil then
            if IsPedInAnyVehicle(GetPlayerPed(-1)) or IsPlayerDead(PlayerId()) then
                SetEntityAsMissionEntity(pet, true, true)
                DeleteEntity(pet)
                pet = nil
                dogModel = ""
            end
        end
    end

end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/dyr', '"/dyr <valg>" - Valgmuligheder: rottweiler, husky, shepherd, retriever, pug, poodle, westy')
end)

function GetLocalPlayer()
    return GetPlayerPed(PlayerId())
end

function RequestNetworkControl(callback)
    local netId = NetworkGetNetworkIdFromEntity(pet)
    local timer = 0
    NetworkRequestControlOfNetworkId(netId)
    while not NetworkHasControlOfNetworkId(netId) do
        Citizen.Wait(1)
        NetworkRequestControlOfNetworkId(netId)
        timer = timer + 1
        if timer == 5000 then
            Citizen.Trace("Control failed")
            callback(false)
        end
    end
    callback(true)
end

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