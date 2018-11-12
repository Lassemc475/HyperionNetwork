local WaitTime = 100

Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(511500411748745216)
		SetDiscordRichPresenceAsset('boom')
		Citizen.Wait(60000)
	end
end)

Citizen.CreateThread(function()
	while true do
	    local onlinePlayers = 0
		for i = 0, 31 do
			if NetworkIsPlayerActive(i) then
				onlinePlayers = onlinePlayers+1
			end
		end
		Citizen.Wait(WaitTime)
    end
end)
