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

    

end