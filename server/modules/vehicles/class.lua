local Vehicle = lib.class("Vehicle")

---@enum tipes
local tipos = {
    automobile = "automobile",
    bike = "bike",
    boat = "boat",
    heli = "heli",
    plane = "plane",
    submarine = "submarine",
    trailer = "trailer"
}


function Vehicle:constructor(source,model,coords,tipe,mods,customPlate,save)
    self.source = source
    self.model = model
    self.coords = coords
    self.tipe = tipe or "automobile"
    self.hasOwner = hasOwner
    self.mods = mods
    self.customPlate = customPlate
    self.venicle = nil
    self.entity = nil
    return self
end

function Vehicle:Spawn()
    self.vehicle = CreateVehicleServerSetter(self.model,self.tipe,self.coords.x,self.coords.y,self.coords.z,self.coords.w)
    local wait = lib.waitFor(function()
        return DoesEntityExist(self.vehicle)
    end,("Error loading model: %s"):format(self.model),2000)

    if self.customPlate then
        SetVehicleNumberPlateText(self.vehicle, self.customPlate)
        local plate = lib.waitFor(function() 
            SetVehicleNumberPlateText(self.vehicle, self.customPlate)
            return GetVehicleNumberPlateIndex(self.vehicle) == self.customPlate
        end,("Error setting plate: %s"):format(self.customPlate),2000)
    end
    self.entity = NetworkGetNetworkIdFromEntity(self.vehicle)
    if self.mods then
        TriggerClientEvent('ox_lib:setVehicleProperties', self.source, self.entity, self.mods)
    end

    if self.safe then
        --save the vehicle in the db
    end

    self:set("init",true,true)
   
    return true
end

function Vehicle:set(key,value,replicated)
    Entity(self.vehicle).state:set(key,value,replicated)
end

function Vehicle:get(key)
    if not key then return Entity(self.vehicle) end
	return Entity(self.vehicle).state[key]
end


function Vehicle:updateMod(mod,value)
    self.mods[mod] = value
    TriggerClientEvent('ox_lib:setVehicleProperties', self.source, self.entity, self.mods)
end