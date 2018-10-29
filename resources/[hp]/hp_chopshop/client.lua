--------------------------------
-- Created by Mathias (Budji) --
--------------------------------

local chopshops = {
	 {name="Chopshop", marker=27, x=1204.6890869141, y=-3116.6882324219, z=4.5403265953064, blip = 225, blipcolor = 1}
}

local vehicleList = {}
local player = 0
local playerCoords = 0
local dist = 100
local distanceToShop = 5
local cooldown = 7200000 -- 2 timer

local vehicles = {
	[1] = { ["classname"] = "verlierer2", ["hash"] =	1102544804},
	[2] = { ["classname"] = "schafter3", ["hash"] =-1485523546},
	[3] = { ["classname"] = "schafter4", ["hash"] =1489967196},
	[4] = { ["classname"] = "seven70", ["hash"] = -1757836725 },
	[5] = { ["classname"] = "bestiagts", ["hash"] = 1274868363},
	[6] = { ["classname"] = "lynx", ["hash"] =	482197771 },
	[7] = { ["classname"] = "omnis", ["hash"] = -777172681},
	[8] = { ["classname"] = "tropos", ["hash"] = 1887331236},
	[9] = { ["classname"] = "tampa2", ["hash"] = -1071380347 },
	[10] = { ["classname"] = "raptor", ["hash"] = -674927303},
	[11] = { ["classname"] = "jester", ["hash"] = -1297672541 },
	[12] = { ["classname"] = "alpha", ["hash"] = 767087018 },
	[13] = { ["classname"] = "massacro", ["hash"] = -142942670 },
	[14] = { ["classname"] = "buffalo3", ["hash"] = 237764926 },
	[15] = { ["classname"] = "blista2", ["hash"] = 1039032026},
	[16] = { ["classname"] = "blista3", ["hash"] = -591651781 },
	[17] = { ["classname"] = "furoregt", ["hash"] = -1089039904 },
	[18] = { ["classname"] = "kuruma", ["hash"] = -1372848492 },
	[19] = { ["classname"] = "ninef", ["hash"] = 1032823388 },
	[20] = { ["classname"] = "ninef2", ["hash"] = -1461482751 },
	[21] = { ["classname"] = "banshee", ["hash"] = -1041692462 },
	[22] = { ["classname"] = "buffalo", ["hash"] = -304802106},
	[23] = { ["classname"] = "buffalo2", ["hash"] = 736902334 },
	[24] = { ["classname"] = "carbonizzare", ["hash"] = 2072687711},
	[25] = { ["classname"] = "comet2", ["hash"] = -1045541610},
	[26] = { ["classname"] = "coquette", ["hash"] = 108773431 },
	[27] = { ["classname"] = "elegy2", ["hash"] = -566387422 },
	[28] = { ["classname"] = "feltzer2", ["hash"] = -1995326987 },
	[29] = { ["classname"] = "fusilade", ["hash"] = 499169875},
	[30] = { ["classname"] = "futo", ["hash"] = 2016857647},
	[31] = { ["classname"] = "khamelion", ["hash"] = 544021352 },
	[32] = { ["classname"] = "penumbra", ["hash"] = -377465520},
	[33] = { ["classname"] = "rapidgt", ["hash"] = -1934452204 },
	[34] = { ["classname"] = "rapidgt2", ["hash"] = 1737773231},
	[35] = { ["classname"] = "schwarzer", ["hash"] = -746882698 },
	[36] = { ["classname"] = "sultan", ["hash"] = 970598228},
	[37] = { ["classname"] = "surano", ["hash"] = 384071873 },
	[38] = { ["classname"] = "sultanrs", ["hash"] = -295689028},
	[39] = { ["classname"] = "fmj", ["hash"] = 1426219628 },
	[40] = { ["classname"] = "pfister811", ["hash"] = -1829802492},
	[41] = { ["classname"] = "prototipo", ["hash"] = 2123327359 },
	[42] = { ["classname"] = "reaper", ["hash"] = 234062309},
	[43] = { ["classname"] = "tyrus", ["hash"] = 2067820283},
	[44] = { ["classname"] = "sheava", ["hash"] = 819197656 },
	[45] = { ["classname"] = "le7b", ["hash"] = -1232836011 },
	[46] = { ["classname"] = "turismor", ["hash"] = 408192225 },
	[47] = { ["classname"] = "zentorno", ["hash"] = -1403128555 },
	[48] = { ["classname"] = "bullet", ["hash"] = -1696146015 },
	[49] = { ["classname"] = "cheetah", ["hash"] = -1311154784 },
	[50] = { ["classname"] = "entityxf", ["hash"] = -1291952903 },
	[51] = { ["classname"] = "infernus", ["hash"] = 418536135 },
	[52] = { ["classname"] = "adder", ["hash"] = -1216765807 },
	[53] = { ["classname"] = "voltic", ["hash"] = -1622444098 },
	[54] = { ["classname"] = "vacca", ["hash"] = 338562499 },
	[55] = { ["classname"] = "osiris", ["hash"] = 1987142870},
	[56] = { ["classname"] = "t20", ["hash"] = 1663218586 },
	[57] = { ["classname"] = "schafter5", ["hash"] = -888242983 },
	[58] = { ["classname"] = "schafter6", ["hash"] = 1922255844 },
	[59] = { ["classname"] = "cog55", ["hash"] = 906642318 },
	[60] = { ["classname"] = "cog552", ["hash"] = 704435172 },
	[61] = { ["classname"] = "cognoscenti", ["hash"] = -2030171296 },
	[62] = { ["classname"] = "cognoscenti2", ["hash"] = -604842630 },
	[63] = { ["classname"] = "warrener", ["hash"] = 1373123368 },
	[64] = { ["classname"] = "glendale", ["hash"] = 75131841 },
	[65] = { ["classname"] = "asea", ["hash"] = -1809822327 },
	[66] = { ["classname"] = "asea2", ["hash"] = -1807623979 },
	[67] = { ["classname"] = "asterope", ["hash"] = -1903012613 },
	[68] = { ["classname"] = "emperor", ["hash"] = -685276541 },
	[69] = { ["classname"] = "emperor2", ["hash"] = -1883002148 },
	[70] = { ["classname"] = "emperor3", ["hash"] = -1241712818 },
	[71] = { ["classname"] = "fugitive", ["hash"] = 1909141499 },
	[72] = { ["classname"] = "ingot", ["hash"] = -1289722222 },
	[73] = { ["classname"] = "intruder", ["hash"] = 886934177 },
	[74] = { ["classname"] = "premier", ["hash"] = -1883869285 },
	[75] = { ["classname"] = "primo", ["hash"] = -1150599089 },
	[76] = { ["classname"] = "regina", ["hash"] = -14495224 	},
	[77] = { ["classname"] = "romero", ["hash"] = 627094268 	},
	[78] = { ["classname"] = "schafter2", ["hash"] = -1255452397 },
	[79] = { ["classname"] = "stanier", ["hash"] = -1477580979 	},
	[80] = { ["classname"] = "stratum", ["hash"] = 1723137093 },
	[81] = { ["classname"] = "superd", ["hash"] = 1123216662 },
	[82] = { ["classname"] = "surge", ["hash"] = -1894894188 },
	[83] = { ["classname"] = "tailgater", ["hash"] = -1008861746 },
	[84] = { ["classname"] = "washington", ["hash"] = 1777363799 },
	[85] = { ["classname"] = "stretch", ["hash"] = -1961627517},
	[86] = { ["classname"] = "brioso", ["hash"] = 1549126457 },
	[87] = { ["classname"] = "rhapsody", ["hash"] = 841808271 },
	[88] = { ["classname"] = "panto", ["hash"] = -431692672 },
	[89] = { ["classname"] = "blista", ["hash"] = -344943009 },
	[90] = { ["classname"] = "dilettante", ["hash"] = -1130810103 },
	[91] = { ["classname"] = "issi2", ["hash"] = -1177863319 },
	[92] = { ["classname"] = "prairie", ["hash"] = -1450650718 },
	[93] = { ["classname"] = "baller3", ["hash"] = 1878062887 },
	[94] = { ["classname"] = "baller4", ["hash"] = 634118882 },
	[95] = { ["classname"] = "baller5", ["hash"] = 470404958 },
	[96] = { ["classname"] = "baller6", ["hash"] = 666166960 },
	[97] = { ["classname"] = "xls", ["hash"] = 1203490606 },
	[98] = { ["classname"] = "contender", ["hash"] = 683047626 },
	[99] = { ["classname"] = "huntley", ["hash"] = 486987393 	},
	[100] = { ["classname"] = "baller", ["hash"] = -808831384},
	[101] = { ["classname"] = "baller2", ["hash"] = 142944341},
	[102] = { ["classname"] = "bjxl", ["hash"] = 850565707},
	[103] = { ["classname"] = "cavalcade", ["hash"] = 2006918058 },
	[104] = { ["classname"] = "cavalcade2", ["hash"] = -789894171},
	[105] = { ["classname"] = "gresley", ["hash"] = -1543762099},
	[106] = { ["classname"] = "dubsta", ["hash"] = 1177543287},
	[107] = { ["classname"] = "dubsta2", ["hash"] = -394074634 },
	[108] = { ["classname"] = "fq2", ["hash"] = -1137532101 },
	[109] = { ["classname"] = "granger", ["hash"] = -1775728740 },
	[110] = { ["classname"] = "habanero", ["hash"] = 884422927 },
	[111] = { ["classname"] = "landstalker", ["hash"] = 1269098716},
	[112] = { ["classname"] = "mesa", ["hash"] = 914654722 },
	[113] = { ["classname"] = "mesa2", ["hash"] = -748008636},
	[114] = { ["classname"] = "patriot", ["hash"] = -808457413},
	[115] = { ["classname"] = "radi", ["hash"] = -1651067813 },
	[116] = { ["classname"] = "rocoto", ["hash"] = 2136773105 },
	[117] = { ["classname"] = "seminole", ["hash"] = 1221512915},
	[118] = { ["classname"] = "serrano", ["hash"] = 1337041428 },
	[119] = { ["classname"] = "dubsta3", ["hash"] = -1237253773 },
	[120] = { ["classname"] = "monster", ["hash"] = -845961253 },
	[121] = { ["classname"] = "marshall", ["hash"] = 1233534620},
	[122] = { ["classname"] = "technical", ["hash"] = -2096818938},
	[123] = { ["classname"] = "bfinjection", ["hash"] = 1126868326 },
	[124] = { ["classname"] = "bodhi2", ["hash"] = -1435919434 },
	[125] = { ["classname"] = "dune", ["hash"] = -1661854193 },
	[126] = { ["classname"] = "dune2", ["hash"] = 534258863 },
	[127] = { ["classname"] = "dloader", ["hash"] = 1770332643 },
	[128] = { ["classname"] = "mesa3", ["hash"] = -2064372143 },
	[129] = { ["classname"] = "rancherxl", ["hash"] = 1645267888 },
	[130] = { ["classname"] = "rancherxl2", ["hash"] = 1933662059 },
	[131] = { ["classname"] = "rebel", ["hash"] = -1207771834 },
	[132] = { ["classname"] = "rebel2", ["hash"] = -2045594037 	},
	[133] = { ["classname"] = "sandking", ["hash"] = -1189015600 },
	[134] = { ["classname"] = "sandking2", ["hash"] = 989381445 },
	[135] = { ["classname"] = "brawler", ["hash"] = -1479664699 },
	[136] = { ["classname"] = "rumpo3", ["hash"] = 1475773103 	},
	[137] = { ["classname"] = "youga2", ["hash"] = 1026149675 },
	[138] = { ["classname"] = "boxville4", ["hash"] = 444171386 },
	[139] = { ["classname"] = "gburrito2", ["hash"] = 296357396 },
	[140] = { ["classname"] = "bison", ["hash"] = -16948145 },
	[141] = { ["classname"] = "bison2", ["hash"] = 2072156101 },
	[142] = { ["classname"] = "bison3", ["hash"] = 1739845664},
	[143] = { ["classname"] = "boxville", ["hash"] = -1987130134},
	[144] = { ["classname"] = "boxville2", ["hash"] = -233098306 },
	[145] = { ["classname"] = "boxville3", ["hash"] = 121658888 },
	[146] = { ["classname"] = "bobcatxl", ["hash"] = 1069929536},
	[147] = { ["classname"] = "burrito", ["hash"] = -1346687836 },
	[148] = { ["classname"] = "burrito2", ["hash"] = -907477130 },
	[149] = { ["classname"] = "burrito3", ["hash"] = -1743316013 },
	[150] = { ["classname"] = "burrito4", ["hash"] = 893081117 },
	[151] = { ["classname"] = "burrito5", ["hash"] = 1132262048},
	[152] = { ["classname"] = "gburrito", ["hash"] = -1745203402 },
	[153] = { ["classname"] = "camper", ["hash"] = 1876516712},
	[154] = { ["classname"] = "journey", ["hash"] = -120287622},
	[155] = { ["classname"] = "minivan", ["hash"] = -310465116},
	[156] = { ["classname"] = "pony", ["hash"] = -119658072},
	[157] = { ["classname"] = "pony2", ["hash"] = 943752001},
	[158] = { ["classname"] = "rumpo", ["hash"] = 1162065741},
	[159] = { ["classname"] = "rumpo2", ["hash"] = -1776615689 },
	[160] = { ["classname"] = "speedo", ["hash"] = -810318068},
	[161] = { ["classname"] = "speedo2", ["hash"] = 728614474 },
	[162] = { ["classname"] = "surfer", ["hash"] = 699456151},
	[163] = { ["classname"] = "surfer2", ["hash"] = -1311240698 },
	[164] = { ["classname"] = "taco", ["hash"] = 1951180813},
	[165] = { ["classname"] = "youga", ["hash"] = 65402552},
	[166] = { ["classname"] = "nightshade", ["hash"] = -1943285540 },
	[167] = { ["classname"] = "blade", ["hash"] = -1205801634 },
	[168] = { ["classname"] = "dukes", ["hash"] = 723973206},
	[169] = { ["classname"] = "dominator2", ["hash"] = -915704871},
	[170] = { ["classname"] = "gauntlet2", ["hash"] = 349315417 },
	[171] = { ["classname"] = "stalion", ["hash"] = 1923400478 },
	[172] = { ["classname"] = "stalion2", ["hash"] = -401643538},
	[173] = { ["classname"] = "slamvan2", ["hash"] = 833469436 },
	[174] = { ["classname"] = "buccaneer", ["hash"] = -682211828},
	[175] = { ["classname"] = "hotknife", ["hash"] =	37348240},
	[176] = { ["classname"] = "dominator", ["hash"] = 80636076},
	[177] = { ["classname"] = "gauntlet", ["hash"] = -1800170043 },
	[178] = { ["classname"] = "phoenix", ["hash"] = -2095439403 },
	[179] = { ["classname"] = "picador", ["hash"] = 1507916787},
	[180] = { ["classname"] = "ratloader", ["hash"] = -667151410},
	[181] = { ["classname"] = "ruiner", ["hash"] = -227741703 },
	[182] = { ["classname"] = "sabregt", ["hash"] = -1685021548 },
	[183] = { ["classname"] = "voodoo2", ["hash"] = 523724515 },
	[184] = { ["classname"] = "vigero", ["hash"] =	-825837129 },
	[185] = { ["classname"] = "virgo", ["hash"] = -498054846},
	[186] = { ["classname"] = "coquette3", ["hash"] = 784565758 },
	[187] = { ["classname"] = "chino", ["hash"] = 349605904},
	[188] = { ["classname"] = "sabregt2", ["hash"] =	223258115},
	[189] = { ["classname"] = "virgo2", ["hash"] =	-899509638 },
	[190] = { ["classname"] = "virgo3", ["hash"] =	16646064}
}

local vehicleClasses = {
		-- EKSEMPEL: <tekst> kan jeg give dig <pris> kr. for!
    [0] = { ["Tekst"] = "Du får for denne kompakte bil", ["MinPris"] = 10000, ["MaxPris"] = 14000 },
    [1] = { ["Tekst"] = "Du får for denne sedan", ["MinPris"] = 12000, ["MaxPris"] = 17000 },
    [2] = { ["Tekst"] = "Du får for denne SUV", ["MinPris"] = 10000, ["MaxPris"] = 14000 },
    [3] = { ["Tekst"] = "Du får for denne coupé", ["MinPris"] = 12000, ["MaxPris"] = 16000 },
    [4] = { ["Tekst"] = "Du får for denne muskelbil", ["MinPris"] = 12000, ["MaxPris"] = 16000 },
    [5] = { ["Tekst"] = "Du får for denne sportsklassiker af en bil,", ["MinPris"] = 16000, ["MaxPris"] = 26000 },
    [6] = { ["Tekst"] = "Du får for denne sportsvogn", ["MinPris"] = 18000, ["MaxPris"] = 26000 },
    [7] = { ["Tekst"] = "Du får for denne superbil", ["MinPris"] = 20000, ["MaxPris"] = 29000 },
    [8] = { ["Tekst"] = "Du får for denne motorcykel", ["MinPris"] = 6000, ["MaxPris"] = 10000 },
    [9] = { ["Tekst"] = "Du får for denne off-roader", ["MinPris"] = 10000, ["MaxPris"] = 12000 },
    [10] = { ["Tekst"] = "Du får for dette industri køretøj", ["MinPris"] = 5000, ["MaxPris"] = 10000 },
    [11] = { ["Tekst"] = "Du får for denne redskabsvogn", ["MinPris"] = 5000, ["MaxPris"] = 10000 },
    [12] = { ["Tekst"] = "Du får for denne varevogn", ["MinPris"] = 6500, ["MaxPris"] = 9000 },
    [13] = { ["Tekst"] = "Du får for denne cykel", ["MinPris"] = 2000, ["MaxPris"] = 5000 },
    [14] = { ["Tekst"] = "Du får for denne båd", ["MinPris"] = 12000, ["MaxPris"] = 17000 },
    [15] = { ["Tekst"] = "Du får for denne helikopter", ["MinPris"] = 40000, ["MaxPris"] = 47000 },
    [16] = { ["Tekst"] = "Du får for dette fly", ["MinPris"] = 70000, ["MaxPris"] = 85000 },
    [17] = { ["Tekst"] = "Du får for dette servicekøretøj", ["MinPris"] = 10000, ["MaxPris"] = 15000 },
    [18] = { ["Tekst"] = "Du får for dette udrykningskøretøj", ["MinPris"] = 10000, ["MaxPris"] = 15000 },
    [19] = { ["Tekst"] = "Du får for dette militærkøretøjer", ["MinPris"] = 10000, ["MaxPris"] = 15000},
    [20] = { ["Tekst"] = "Du får for dette kommercielkøretøj", ["MinPris"] = 10000, ["MaxPris"] = 15000 },
    [21] = { ["Tekst"] = "Du får for denne tog", ["MinPris"] = 0, ["MaxPris"] = 1000 }
}

Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(0)
			player = GetPlayerPed(-1)

			for _, chopshop in pairs(chopshops) do
				DrawMarker(chopshop.marker, chopshop.x, chopshop.y, chopshop.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
				
				playerCoords = GetEntityCoords(player)
				dist = Vdist(chopshop.x, chopshop.y, chopshop.z, playerCoords.x, playerCoords.y, playerCoords.z)
				if dist < distanceToShop and IsPedInAnyVehicle(player, true) == false then
					ply_drawTxt("Tryk ~b~[E] ~w~for at choppe bilen",0,1,0.5,0.8,0.6,255,255,255,255)
					if IsControlJustPressed(0, 38) then
						-- Check vehicle on location
						local currentVehicle = GetVehiclePedIsIn(player, false)
		        currentPlate = GetVehicleNumberPlateText(currentVehicle)
		        local lastVehicle = GetVehiclePedIsIn(player, true)
		        lastPlate = GetVehicleNumberPlateText(lastVehicle)

		        for k,v in pairs(vehicleList) do
		        	local currentHash = v["hash"]
		        	local lastVehicleHash = GetEntityModel(lastVehicle)
		        	local currentVehicleHash = GetEntityModel(currentVehicle)
		        	local veh = 0
		        	if currentHash == currentVehicleHash or currentHash == lastVehicleHash then

		        		if currentHash == currentVehicle then
		        			veh = currentVehicle
		        		else
		        			veh = lastVehicle
		        		end

		        		if checkForPlayerVehicle(veh) then
		        			TriggerEvent('chatMessage', '^6[Budjis Shop]', "^6[Budjis Shop]", "Jeg skal lige sørge for at du har leveret en god varer!")
		        			for i=0,7 do
	        					SetVehicleDoorOpen(veh,i,0,false)
	        					Wait(1000)
		        			end
		        			local vehClass = GetVehicleClass(veh)

		        			local priceAmount = math.random(vehicleClasses[vehClass]["MinPris"], vehicleClasses[vehClass]["MaxPris"])

		        			Wait(15000)
		        			TriggerEvent('chatMessage', '^6[Budjis Shop]', "^6[Budjis Shop]", vehicleClasses[vehClass]["Tekst"] .. " kan jeg give dig " .. tostring(priceAmount) .. " sorte kontanter for!")

		        			SetVehicleHasBeenOwnedByPlayer(veh,false)
						      Citizen.InvokeNative(0xAD738C3085FE7E11, veh, false, true) -- set not as mission entity
						      SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(veh))
						      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
		        			table.remove(vehicleList, k)

		        			-- Give payout
		        			TriggerServerEvent('hp:ChopShopPay', priceAmount)
		        		else
		        			TriggerEvent('chatMessage', '^6[Budjis Shop]', "^6[Budjis Shop]", "Jeg tager simpelthen ikke imod biler ejet af folk jeg kender!")
		        		end
		        	end
		        end
					end
				end
			end
		end
end)

Citizen.CreateThread(function()
  for _,chopshop in pairs(chopshops) do
	local blip = AddBlipForCoord(chopshop.x+0.001,chopshop.y+0.001,chopshop.z+0.001)
    SetBlipSprite(blip, chopshop.blip)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, chopshop.blipcolor)
    SetBlipAlpha(blip, 250)
    BeginTextCommandSetBlipName("STRING")
    SetBlipAsShortRange(blip, true)
    AddTextComponentString(chopshop.name)
    EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
  	selectNewVehicles()

  	Citizen.Wait(cooldown)
  end
end)

RegisterNetEvent("hp:ChopShopList")
AddEventHandler('hp:ChopShopList', function()
	if dist < distanceToShop then
		local message = getVehiclesLeft()
		if message == "" then
			TriggerEvent('chatMessage', '^6[Budjis Shop]', "^6[Budjis Shop]", "Du mangler ikke at aflevere nogle biler! Jeg skriver til dig når jeg får brug for dig igen!")
		else
			TriggerEvent('chatMessage', '^6[Budjis Shop]', "^6[Budjis Shop]", "Du mangler at aflevere mig følgende bil(er):")
			TriggerEvent('chatMessage', '^6[Budjis Shop]', "^6[Budjis Shop]", message)
		end
	else
		TriggerEvent('chatMessage', '^6[Budjis Shop]', "^6[Budjis Shop]", "Du må sgu lige komme herned for at få det at vide!")
	end
end)

function getVehiclesLeft()
	local message = ""
	for k,v in pairs(vehicleList) do
		local vehName = GetDisplayNameFromVehicleModel(v["hash"])
		local vehLblText = GetLabelText(vehName)

		message = message .. vehLblText

		if next(vehicleList,k) ~= nil then
	    message = message .. " | "
	  end
	end

	return message
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

function selectNewVehicles()
	vehicleList = {}
	for i=1,5 do
		local random = math.random(1,190)

		table.insert(vehicleList, {["classname"] = vehicles[random]["classname"], ["hash"] = vehicles[random]["hash"]})
	end

	--TriggerEvent('chatMessage', '^6[Budjis Shop]', "^6[Budjis Shop]", "Jeg har brug for en ny leverance af biler!")

	--DEBUG TOOL
	--for k,v in pairs(vehicleList) do
		--Citizen.Trace(tostring(v["classname"]) .. " - " .. tostring(v["hash"]))
	--end
end

function checkForPlayerVehicle(object)
	local numberPlate = GetVehicleNumberPlateText(object)

  if numberPlate ~= nil then
  	local firstDigit = tonumber(string.sub(tostring(numberPlate), 1, 1))
    local secondDigit = tonumber(string.sub(tostring(numberPlate), 2, 2))
    
    if firstDigit ~= nil and secondDigit ~= nil then
        if firstDigit >= 0 and secondDigit >= 0 then
            return true -- Ikke en spillers køretøj
        else
            return false -- Spillers køretøj
        end
    else
        return false -- Spillers køretøj
    end
  end

  return true -- Ikke en spillers køretøj
end
