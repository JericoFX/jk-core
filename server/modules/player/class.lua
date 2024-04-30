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
    self.location = nil
    self.data = {}
    self.newData = newData or nil
    return self
end

function Player:getInformation()
   self.data =  db.getPlayerInformation(self.license)
   if self.data then
    self.name = data.name
    self.private.metadata = json.decode(data.metadata)
    self.private.charinfo = json.decode(data.charinfo)
    self.location = json.decode(data.charinfo)
    return true
   else
    return self:createNewCharacter()
   end
end

function Player:createNewCharacter()
    self.private.charinfo = {
        firstname = self.newData.firstname
        lastname = self.newData.lastname
        date = self.newData.date
        id = self.newData.id
    }
    Wait(10)
    self.private.metadata = {
        hunger = 100
        thirst = 100
        stress = 0
        isdead = false
        inlaststand = false
        armor = 0
        ishandcuffed = false
        mission = {}
        group = {}
        effect = self.newData.effect
    }
    return true
end

function Player:setMetadata(key,value)
    if not self.private.metadata[key] then return end
     self.private.metadata[key] = value
    return true
end

function Player:getMetadata(key)
    if not self.private.metadata[key] then return end
    return self.private.metadata[key]
end

function Player:getCharInfo(key)
if not key then return self.private.charinfo end
    return self.private.charinfo[key]
end