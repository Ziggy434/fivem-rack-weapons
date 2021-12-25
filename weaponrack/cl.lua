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
arEquiped = false
shotgunEquiped = false

-- Ar command

RegisterCommand('ar', function()
    local currentVeh = GetVehiclePedIsIn(ped, false)
    local isPoliceVeh = tostring(GetVehicleClass(currentVeh))
    if isPoliceVeh == "18" then
        if not arEquiped then
            GiveWeaponToPed(ped, GetHashKey(config.arName), config.arAmmoCount, false, false)
            GiveWeaponComponentToPed(ped, GetHashKey(config.arName), GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped, GetHashKey(config.arName), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            arEquiped = true
            notify("~b~Weapons: ~c~Rifle unracked from your cruiser!")
        else
            RemoveWeaponFromPed(ped, GetHashKey(config.arName))
            arEquiped = false
            notify("~b~Weapons: ~c~Rifle has been racked in your cruiser!")
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
            GiveWeaponToPed(ped, GetHashKey(config.shotgunName), config.shotgunAmmoCount, false, false)
            GiveWeaponComponentToPed(ped, GetHashKey(config.shotgunName), GetHashKey("COMPONENT_AT_AR_FLSH"))
            shotgunEquiped = true
            notify("~b~Weapons: ~c~Shotgun unracked from your cruiser!")
        else
            RemoveWeaponFromPed(ped, GetHashKey(config.shotgunName))
            shotgunEquiped = false
            notify("~b~Weapons: ~c~Shotgun has been racked in your cruiser!")
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