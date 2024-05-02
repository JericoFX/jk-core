local db = lib.load("server.modules.player.db")
--[[
    Set Player Data.
    Set Player Metadata
    Get Data

    Data Player:
        * First Name
        * Last Name
        * metadata
            * Health
            * Armor
            * 
]]

local Player = lib.class("Player")

function Player:constructor(license,source,newData)
    self.license = license
    self.source = source
    self.private.metadata = nil
    self.private.charinfo = nil
    self.private.inventory = nil
    self.player = GetPlayerPed(self.source)
    self.location = nil
    self.data = {}
    self.newData = newData or nil
    return self
end

function Player:login()
   self.data =  db.getPlayerInformation(self.license)
   if self.data then
    self.name = data.name
    self.id = data.id
    self.private.metadata = json.decode(data.metadata)
    self.private.charinfo = json.decode(data.charinfo)
    self.private.inventory = json.decode(data.inventory)
    self.location = json.decode(data.charinfo)
    return true
   else
    return self:createNewCharacter()
   end
end

function Player:createNewCharacter()
    self.private.charinfo = {
        firstname = self.newData.firstname,
        lastname = self.newData.lastname,
        fullname = ("%s %s"):format(self.newdata.firstname,self.newData.lastname),
        date = self.newData.date,
        id = ("%s%s%s"):format(lib.string.random("A",2),lib.string.random("a",3),lib.string.random("1",3)),
    }
    Wait(10)
    self.private.metadata = {
        hunger = 100,
        thirst = 100,
        stress = 0,
        isdead = false,
        inlaststand = false,
        armor = 0,
        ishandcuffed = false,
        mission = {},
        group = {},
        effect = self.newData.effect
    }
    self.location = vector4(0,0,73,180)
    return true
end

function Player:updateMetadata(key,value)
    if not self.private.metadata[key] then return end
     self.private.metadata[key] = value
    return true
end

function Player:getMetadata(key)
    if not self.private.metadata[key] then return end
    return self.private.metadata[key]
end

function Player:getCharinfo(key)
    if not key then return self.private.charinfo end
    return self.private.charinfo[key]
end

function Player:setMetadata(key,value)
    if not self.private.metadata[key] then self:updateMetadata(key,value) end
    self.private.metadata[key] = value
    return true
end

--https://github.com/overextended/ox_lib/blob/master/imports/triggerClientEvent/server.lua
function Player:triggerEvent(eventName, targetIds, ...)
    local payload = msgpack.pack_args(...)
    local payloadLen = #payload
    if lib.array.isArray(targetIds) then
        for i = 1, #targetIds do
            TriggerClientEventInternal(eventName, targetIds[i] --[[@as string]], payload, payloadLen)
        end

        return
    end
    TriggerClientEventInternal(eventName, targetIds --[[@as string]], payload, payloadLen)
end

function Player:savePlayer()
    -- Function to save the player information
end

return Player