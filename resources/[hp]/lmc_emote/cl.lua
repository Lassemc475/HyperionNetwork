-- Credit : Ideo
Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, true)
end

Menu = {}
Menu.GUI = {}
Menu.TitleGUI = {}
Menu.buttonCount = 0
Menu.titleCount = 0
Menu.selection = 0
Menu.hidden = true
MenuTitle = "Menu"

-------------------
posXMenu = 0.1
posYMenu = 0.05
width = 0.1
height = 0.05

posXMenuTitle = 0.1
posYMenuTitle = 0.05
widthMenuTitle = 0.1
heightMenuTitle = 0.05
-------------------

function Menu.addTitle(name)

	local yoffset = 0.3
	local xoffset = 0
	
	local xmin = posXMenuTitle
	local ymin = posYMenuTitle
	local xmax = widthMenuTitle
	local ymax = heightMenuTitle

	
	Menu.TitleGUI[Menu.titleCount +1] = {}
	Menu.TitleGUI[Menu.titleCount +1]["name"] = name
	Menu.TitleGUI[Menu.titleCount+1]["xmin"] = xmin + xoffset
	Menu.TitleGUI[Menu.titleCount+1]["ymin"] = ymin * (Menu.titleCount + 0.01) +yoffset
	Menu.TitleGUI[Menu.titleCount+1]["xmax"] = xmax 
	Menu.TitleGUI[Menu.titleCount+1]["ymax"] = ymax 
	Menu.titleCount = Menu.titleCount+1
end

function Menu.addButton(name, func,args)

	local yoffset = 0.3
	local xoffset = 0
	
	local xmin = posXMenu
	local ymin = posYMenu
	local xmax = width
	local ymax = height

	
	Menu.GUI[Menu.buttonCount +1] = {}
	Menu.GUI[Menu.buttonCount +1]["name"] = name
	Menu.GUI[Menu.buttonCount+1]["func"] = func
	Menu.GUI[Menu.buttonCount+1]["args"] = args
	Menu.GUI[Menu.buttonCount+1]["active"] = false
	Menu.GUI[Menu.buttonCount+1]["xmin"] = xmin + xoffset
	Menu.GUI[Menu.buttonCount+1]["ymin"] = ymin * (Menu.buttonCount + 0.01) +yoffset
	Menu.GUI[Menu.buttonCount+1]["xmax"] = xmax 
	Menu.GUI[Menu.buttonCount+1]["ymax"] = ymax 
	Menu.buttonCount = Menu.buttonCount+1
end


function Menu.updateSelection() 
	if IsControlJustPressed(1, Keys["DOWN"])  then 
		if(Menu.selection < Menu.buttonCount -1  )then
			Menu.selection = Menu.selection +1
		else
			Menu.selection = 0
		end
	elseif IsControlJustPressed(1, Keys["TOP"]) then
		if(Menu.selection > 0)then
			Menu.selection = Menu.selection -1
		else
			Menu.selection = Menu.buttonCount-1
		end
	elseif IsControlJustPressed(1, Keys["NENTER"])  then
			MenuCallFunction(Menu.GUI[Menu.selection +1]["func"], Menu.GUI[Menu.selection +1]["args"])
	end
	local iterator = 0
	for id, settings in ipairs(Menu.GUI) do
		Menu.GUI[id]["active"] = false
		if(iterator == Menu.selection ) then
			Menu.GUI[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function Menu.renderGUI()
	if not Menu.hidden then
		Menu.renderTitle()
		Menu.renderButtons()
		Menu.updateSelection()
	end
end

function Menu.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
	DrawRect(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end

function Menu.renderTitle()
	local yoffset = 0.3
	local xoffset = 0

	local xmin = posXMenuTitle
	local ymin = posYMenuTitle
	local xmax = widthMenuTitle
	local ymax = heightMenuTitle
	for id, settings in pairs(Menu.TitleGUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GetScreenResolution(0, 0)
		boxColor = {20,30,10,255}

		SetTextFont(0)
		SetTextScale(0.0,0.35)
		SetTextColour(255, 255, 255, 255)
		SetTextCentre(true)
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
		SetTextEntry("STRING") 
		AddTextComponentString(string.upper(settings["name"]))
		DrawText(settings["xmin"], (settings["ymin"] - heightMenuTitle - 0.0125))
		Menu.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"] - heightMenuTitle, settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	end	
end

function Menu.renderButtons()
		
	for id, settings in pairs(Menu.GUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GetScreenResolution(0, 0)
		boxColor = {42,63,17,255}
		
		if(settings["active"]) then
			boxColor = {107,158,44,255}
		end
		SetTextFont(0)
		SetTextScale(0.0,0.35)
		SetTextColour(255, 255, 255, 255)
		SetTextCentre(true)
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
		SetTextEntry("STRING") 
		AddTextComponentString(settings["name"])
		DrawText(settings["xmin"], (settings["ymin"] - 0.0125 )) 
		Menu.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"], settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	 end     
end


--------------------------------------------------------------------------------------------------------------------

function ClearMenu()
	--Menu = {}
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.titleCount = 0
	Menu.selection = 0
end

function MenuCallFunction(fnc, arg)
	_G[fnc](arg)
end

--------------------------------------------------------------------------------------------------------------------
function NameOfMenu()
	ClearMenu()
	Menu.addTitle("Emotes")
	Menu.addButton("Telefon","Phone",nil)	
	Menu.addButton("Selvmord (Pistol)","Pistol",nil)
	Menu.addButton("Bouton 4","MainFunction",nil)
	Menu.addButton("Bouton 5","MainFunction",nil)
	-- ...
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,Keys["F3"]) then
			NameOfMenu()                     -- Menu to draw
			Menu.hidden = not Menu.hidden    -- Hide/Show the menu
		end
		Menu.renderGUI()     -- Draw menu on each tick if Menu.hidden = false
	end
end)

function MainFunction()
	drawNotification("~g~Hello World")
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end


function Pistol()
        local theGunThatKillU = GetHashKey("WEAPON_PISTOL")
        SetCurrentPedWeapon(GetPlayerPed(-1), theGunThatKillU, true)

        loadAnimDict("mp_suicide")
        TaskPlayAnim(GetPlayerPed(-1), "mp_suicide", "pistol", 8.0, 1.0, -1, 0, 1, 1, 0, 0 )
        Wait(1200)
        SetEntityHealth(GetPlayerPed(-1), 105)
    
end

function Phone()
    local ped = GetPlayerPed(-1)
    if not DoesEntityExist(ped) then
        return false
    end
    local veh = GetVehiclePedIsUsing(ped)
    if DoesEntityExist(veh) then
        --TriggerEvent("pNotify:SendNotification", {text = "Du kan ikke bruge emotes i et køretøj!", type = "error", timeout = 2000, layout = "centerLeft"})
        return false
    end
    loadAnimDict("amb@world_human_stand_mobile@male@text@enter")
    local prop = "prop_amb_phone"
    TaskPlayAnim(GetPlayerPed(-1), "amb@world_human_stand_mobile@male@text@enter", "enter", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -4.0)
    local propspawned = CreateObject(GetHashKey(prop), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
    Citizen.Wait(100)
    local netid = ObjToNet(propspawned)
    prop_net = netid
    AttachEntityToEntity(propspawned, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 1)
    Wait(2000)
    loadAnimDict("amb@code_human_wander_texting@male@base")
    TaskPlayAnim(GetPlayerPed(-1), "amb@code_human_wander_texting@male@base", "static", 8.0, 1.0, -1, 49, 0, 0, 0, 0)

    Drink = true
    emotePlaying = true
end

