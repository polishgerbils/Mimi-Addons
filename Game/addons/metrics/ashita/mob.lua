Ashita.Mob = T{}

-- ------------------------------------------------------------------------------------------------------
-- Get an index from a mob ID. I got this from WinterSolstice8's parse lua.
-- Parse: https://github.com/WinterSolstice8/parse
-- ------------------------------------------------------------------------------------------------------
---@param id number
---@return number
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Index_By_ID = function(id)
    local index = bit.band(id, 0x7FF)
    local entity_manager = AshitaCore:GetMemoryManager():GetEntity()

    if entity_manager:GetServerId(index) == id then
        return index
    end

    for i = 1, 2303 do
        if entity_manager:GetServerId(i) == id then
            return i
        end
    end

    return 0
end

-- ------------------------------------------------------------------------------------------------------
-- Get mob data. Trying to make this behave like get_mob_by_id() in windower.
-- ------------------------------------------------------------------------------------------------------
---@param id number
---@return table
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Get_Mob_By_ID = function(id)
    return Ashita.Mob.Data(id, true)
end

-- ------------------------------------------------------------------------------------------------------
-- Get mob data. Trying to make this behave like get_mob_by_index() in windower.
-- ------------------------------------------------------------------------------------------------------
---@param index number this is different than ID.
---@return table
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Get_Mob_By_Index = function(index)
    return Ashita.Mob.Data(index)
end

-- ------------------------------------------------------------------------------------------------------
-- Get mob data. Trying to make this behave like get_mob_by_id() in windower.
-- Ashita  : https://github.com/AshitaXI/Ashita-v4beta/blob/main/plugins/sdk/Ashita.h
-- Windower: https://github.com/Windower/Lua/wiki/FFXI-Functions
-- HXUI    : https://github.com/tirem/HXUI
-- Zone might only come from the party packet.
-- ------------------------------------------------------------------------------------------------------
---@param id number this can be an ID or an index. If it's an ID then set the convert_id flag.
---@param convert_id? boolean if an ID is supplied then the it will be need to be converted to an index.
---@return table
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Data = function(id, convert_id)
    -- Unit testing short circuit for creating pets.
    local unit_testing_mob = Debug.Unit.Get_Mob(id)
    if unit_testing_mob then return unit_testing_mob end

    local index = id
    if convert_id then
        index = Ashita.Mob.Index_By_ID(id)
    end

	local entity_manager = AshitaCore:GetMemoryManager():GetEntity()
    local entity = {}

    -- Sometimes players and pets can have blank names.
    entity.name = entity_manager:GetName(index)
    if entity.name == "" then
        Debug.Error.Add("Mob.Data: Encountered a blank mob name. ID {" .. tostring(id) .. "}.")
        entity.name = DB.Enum.Values.DEBUG
    end

    entity.id = string.sub(string.format("0x%X", entity_manager:GetServerId(index)), -3) -- This came from HXUI
    entity.id_num = entity_manager:GetServerId(index)
    entity.index = index                                        -- Primary identifier.
    entity.entity_type = entity_manager:GetType(index)
    entity.status = entity_manager:GetStatus(index)             -- Idle [0], Engaged [1], Healing [33]
    entity.distance = entity_manager:GetDistance(index)         -- This distance is NOT in yalms.
    entity.hpp = entity_manager:GetHPPercent(index)
    entity.x = entity_manager:GetLocalPositionX(index)
    entity.y = entity_manager:GetLocalPositionY(index)
    entity.z = entity_manager:GetLocalPositionZ(index)
    entity.target_index = entity_manager:GetTargetIndex(index)  -- Should be same as index.
    entity.pet_index = entity_manager:GetPetTargetIndex(index)  -- The index of the entity's pet. This should be blank for the pet.
    entity.claim_id = entity_manager:GetClaimStatus(index)      -- The server ID of the entity who has claim.
    entity.spawn_flags = entity_manager:GetSpawnFlags(index)    -- Player [525], Avatar/Jug Pet [258], Mob [16], Trust [4366]

    return entity
end

-- ------------------------------------------------------------------------------------------------------
-- Checks to see if a given string matches your character's name.
-- ------------------------------------------------------------------------------------------------------
---@param player_name string
---@return boolean
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Is_Me = function(player_name)
    local player = Ashita.Mob.Get_Mob_By_Target(Ashita.Enum.Targets.ME)
    if not player then return false end
    return player_name == player.name
end

-- ------------------------------------------------------------------------------------------------------
-- Checks if a given mob is a player.
-- ------------------------------------------------------------------------------------------------------
---@param mob_data table
---@return boolean
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Is_Player = function(mob_data)
    if not mob_data or not mob_data.spawn_flags then return false end
    return mob_data.spawn_flags == Ashita.Enum.Spawn_Flags.MAINPLAYER
    or mob_data.spawn_flags == Ashita.Enum.Spawn_Flags.OTHERPLAYER
    or mob_data.spawn_flags == Ashita.Enum.Spawn_Flags.IN_PARTY
    or mob_data.spawn_flags == Ashita.Enum.Spawn_Flags.IN_ALLIANCE
end

-- ------------------------------------------------------------------------------------------------------
-- Checks if a given mob is an engageable mob.
-- ------------------------------------------------------------------------------------------------------
---@param mob_data table
---@return boolean
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Is_Monster = function(mob_data)
    if not mob_data or not mob_data.spawn_flags then return false end
    return mob_data.spawn_flags == Ashita.Enum.Spawn_Flags.MOB
end

-- ------------------------------------------------------------------------------------------------------
-- Get mob data. Trying to make this behave like get_mob_by_target() in windower.
-- Ashita  : https://github.com/AshitaXI/Ashita-v4beta/blob/main/plugins/sdk/Ashita.h
-- Windower: https://github.com/Windower/Lua/wiki/FFXI-Functions
-- ------------------------------------------------------------------------------------------------------
---@param target string Things you put in <> in game--me, t, pet, etc.
---@return table
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Get_Mob_By_Target = function(target)
    local player = Ashita.Player.Entity()
    if not player then return {} end
    local player_id = player.ServerId
    local player_entity = Ashita.Mob.Get_Mob_By_ID(player_id)

    if target == Ashita.Enum.Targets.ME then
        return player_entity
    elseif target == Ashita.Enum.Targets.TARGET then
        local target_index = Ashita.Player.Target_Index()
        if target_index then
            return Ashita.Mob.Get_Mob_By_Index(target_index)
        end
    elseif target == Ashita.Enum.Targets.PET then
        -- local pet_index = player_entity.pet_index
        -- local pet_id = pet_entity.ServerId
        -- return a.Data.Mob_By_ID(pet_id)
    end

    return {}
end

-- ------------------------------------------------------------------------------------------------------
-- Check to see if the pet belongs to anyone in the party.
-- Influenced by Flippant parse
-- ------------------------------------------------------------------------------------------------------
---@param pet_data table the pet's mob table; needs to have an index.
---@return table|nil
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Pet_Owner = function(pet_data)
    if not pet_data then return nil end
    local party = Ashita.Party.Get()
    local owner
    for _, member in pairs(party) do
        if type(member) == 'table' and member.mob then
            -- May not always have a pet when running unit tests so need to short circuit here.
            if Debug.Enabled and Debug.Unit.Active and Debug.Unit.Has_Pet and pet_data.spawn_flags == Ashita.Enum.Spawn_Flags.PET then
                return Ashita.Mob.Get_Mob_By_Target(Ashita.Enum.Targets.ME)
            elseif member.mob.pet_index == pet_data.index then
                owner = member.mob
            end
        end
    end
    return owner
end

-- ------------------------------------------------------------------------------------------------------
-- Checks if a mob is claimed by someone in the party or alliance.
-- ------------------------------------------------------------------------------------------------------
---@param mob_data table
---@return boolean
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Claimed_By_Affiliate = function(mob_data)
    if not mob_data then return false end
    local claim_id = mob_data.claim_id
    if not claim_id or claim_id == 0 then return false end
    local claimer = Ashita.Mob.Get_Mob_By_ID(claim_id)
    if not claimer then return false end
    return Ashita.Party.Is_Affiliate(claimer.name)
end

-- ------------------------------------------------------------------------------------------------------
-- Gets the distance between two mobs.
-- ------------------------------------------------------------------------------------------------------
---@param pos1 table could be a mob or any table with an x and y element.
---@param pos2 table could be a mob or any table with an x and y element.
---@return integer
-- ------------------------------------------------------------------------------------------------------
Ashita.Mob.Distance = function(pos1, pos2)
    if not pos1 or not pos2 then return -1 end
    if not pos1.x or not pos2.x then return -1 end
    if not pos1.y or not pos2.y then return -1 end
    local x = (pos2.x - pos1.x)^2
    local y = (pos2.y - pos1.y)^2
    local d = math.sqrt(x + y)
    return d
end