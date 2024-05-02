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


function Vehicle:constructor(model,coords,tipe,hasOwner,mods,customPlate,save)
    self.model = model
    self.coords = coords
    self.tipe = tipe or "automobile"
    self.hasOwner = hasOwner
    self.mods = mods
    self.customPlate = customPlate
    self.venicle = nil
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
    
self:set()
end

function Vehicle:set()
    Entity(self.vehicle).state:set("init",true,true)
end
function Vehicle:get(key)
if not key then return Entity(self.vehicle) end
	return Entity(self.vehicle).state[key]
end