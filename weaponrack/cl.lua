-- Config Section
config = {}
-- Do note that if you change these the components will no longer work and you will have to change that in each command :/
config.arName = "weapon_carbinerifle"
config.shotgunName = "weapon_pumpshotgun"
config.shotgunAmmoCount = 999
config.arAmmoCount = 9999
---


--# u shouldnt need to touch anything below this :)


-- Constant Var's
ped = GetPlayerPed(-1)
netID = NetworkGetNetworkIdFromEntity(PlayerPedId(PlayerId()))
arEquiped = false
shotgunEquiped = false

-- Ar command

RegisterCommand('ar', function()
    local currentVeh = GetVehiclePedIsIn(ped, false)
    local isPoliceVeh = tostring(GetVehicleClass(currentVeh))
    if isPoliceVeh == "18" then
        if not arEquiped then
            TriggerServerEvent("Server:SoundToRadius", netID, 3, "unrack", 0.8)
            Citizen.Wait(600)
            GiveWeaponToPed(ped, GetHashKey(config.arName), config.arAmmoCount, false, false)
            GiveWeaponComponentToPed(ped, GetHashKey(config.arName), GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped, GetHashKey(config.arName), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            arEquiped = true
            notify("~b~Weapons: ~c~Rifle ~C~unracked~c~ from your cruiser!")
        else
            TriggerServerEvent("Server:SoundToRadius", netID, 3, "unrack", 0.8)
            Citizen.Wait(600)
            RemoveWeaponFromPed(ped, GetHashKey(config.arName))
            arEquiped = false
            notify("~b~Weapons: ~c~Rifle has been ~C~racked~c~ in your cruiser!")
        end
    else
        notify("~b~Weapons: ~r~You need to be in your patrol vehicle to unrack your rifle!")
    end
end)

-- Shotgun command

RegisterCommand('shotgun', function()
    local currentVeh = GetVehiclePedIsIn(ped, false)
    local isPoliceVeh = tostring(GetVehicleClass(currentVeh))
    if isPoliceVeh == "18" then
        if not shotgunEquiped then
            TriggerServerEvent("Server:SoundToRadius", netID, 3, "unrack", 0.8)
            Citizen.Wait(600)
            GiveWeaponToPed(ped, GetHashKey(config.shotgunName), config.shotgunAmmoCount, false, false)
            GiveWeaponComponentToPed(ped, GetHashKey(config.shotgunName), GetHashKey("COMPONENT_AT_AR_FLSH"))
            shotgunEquiped = true
            notify("~b~Weapons: ~c~Shotgun ~C~unracked~c~ from your cruiser!")
        else
            TriggerServerEvent("Server:SoundToRadius", netID, 3, "unrack", 0.8)
            Citizen.Wait(600)
            RemoveWeaponFromPed(ped, GetHashKey(config.shotgunName))
            shotgunEquiped = false
            notify("~b~Weapons: ~c~Shotgun has been ~C~racked~c~ in your cruiser!")
        end
    else
        notify("~b~Weapons: ~r~You need to be in your patrol vehicle to unrack your shotgun!")
    end
end)

-- functions
function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
