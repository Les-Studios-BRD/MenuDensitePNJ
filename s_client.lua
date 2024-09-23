--------Désactive le spawn des PNJ flics

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(375)
        local myCoords = GetEntityCoords(GetPlayerPed(-1))
        ClearAreaOfCops(myCoords.x, myCoords.y, myCoords.z, 100.0, 0)
    end
end)

Citizen.CreateThread(function()
	for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300)
       
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
    end
end)

---------- Plus aucune armes droppées par les PNJ

local pedindex = {}

function SetWeaponDrops() 
    local handle, ped = FindFirstPed()
    local finished = false 
    repeat 
        if not IsEntityDead(ped) then
                pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle) 
    until not finished
    EndFindPed(handle)

    for peds,_ in pairs(pedindex) do
        if peds ~= nil then -- ne pas laisse pas tomber les armes à la mort pour les peds.
            SetPedDropsWeaponsWhenDead(peds, false) 
        end
    end
end

Citizen.CreateThread(function()
    while true do
       -- Citizen.Wait(0)
        Citizen.Wait(500)
        SetWeaponDrops()
    end
end)

------------- Réduire les véhicules de PNJ, [entre 0 et 1]

DensityMultiplier = 0.3  -- Par défaut
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(1)
	    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetPedDensityMultiplierThisFrame(DensityMultiplier)
	    SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
	end
end)