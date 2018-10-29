local music = { -- Steder hvor der skal være musik
  {x = -1387.6063232422, y = -618.01007080078, z = 30.819082260132}, -- Bahamas Mamas
}

Citizen.CreateThread(function()
while true do
  Wait(0)
  for k,v in pairs(music) do
    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player, true)
    if Vdist2(music[k].x, music[k].y, music[k].z, coords["x"], coords["y"], coords["z"]) < 12 and not DelayOnThis then
      
	  	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 100, "blahblahblah", 0.8)
		DelayTime = 193
		DelayOnThis = true
		StartDelay()
      break
    end
  end
  end
end)

function StartDelay()
	DelayTime = DelayTime - 1
   if DelayTime == 0 then
      DelayOnThis = false
   else
      Wait(1000)
      StartDelay()
   end
end


RegisterNetEvent("music:start")
AddEventHandler("music:start", function()
  	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 100, "blahblahblah", 0.4)
end)