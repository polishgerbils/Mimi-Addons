local ffxi = {}

-- Fetch an entity by its server ID. Helpful when looking up information from
-- packets, which tend to not include the entity index (since that's a client
-- thing only). Returns nil if no matching entity is found.
---@param id number
---@return Entity?
function ffxi.GetEntityByServerId(id)
    -- The entity array is 2304 items long
    for x = 0, 2303 do
        ---@type Entity
        local e = GetEntity(x)

        -- Ensure the entity is valid
        if e ~= nil and e.WarpPointer ~= 0 then
            if e.ServerId == id then
                return e
            end
        end
    end

    return nil
end

-- Shorthand method to grab an entity's name (by server id, obviously) or a
-- placeholder string if the entity can't be found.
---@param id number
---@param default_name string?
---@return string
function ffxi.GetEntityNameByServerId(id, default_name)
    local e = ffxi.GetEntityByServerId(id)

    if e ~= nil and e.Name ~= nil then
        return e.Name
    else
        return default_name or '[unknown]'
    end
end


-- Determines if a particular entity (given as a server ID) belongs to the
-- player's alliance.
---@param id number
---@return boolean
function ffxi.IsServerIdInParty(id)
    local party = AshitaCore:GetDataManager():GetParty()

    for i = 0, 17 do
        if party:GetMemberActive(i) == 1
        and party:GetMemberServerId(i) ~= 0 then
            local party_mem = GetEntity(party:GetMemberTargetIndex(i))

            if party_mem ~= nil and party_mem.ServerId == id then
                return true
            end
        end
    end

    return false
end


-- Determines if a particular pet (given as a server ID) belongs to the
-- player's alliance.
---@param id number
---@return boolean
function ffxi.IsPetServerIdInParty(id)
    local party = AshitaCore:GetDataManager():GetParty()

    for i = 0, 17 do
        if party:GetMemberActive(i) == 1
        and party:GetMemberServerId(i) ~= 0 then
            local party_mem = GetEntity(party:GetMemberTargetIndex(i))

            if party_mem ~= nil and party_mem.PetTargetIndex ~= nil then
                local party_pet = GetEntity(party_mem.PetTargetIndex)

                if party_pet ~= nil and party_pet.ServerId == id then
                    return true
                end
            end
        end
    end

    return false
end

--- Determines if the chat window is fully-expanded.
---@return boolean
function ffxi.IsChatExpanded()
    -- courtesy of Syllendel
	local pattern = "83EC??B9????????E8????????0FBF4C24??84C0"
	local patternAddress = ashita.memory.find("FFXiMain.dll", 0, pattern, 0x04, 0);
	local chatExpandedPointer = ashita.memory.read_uint32(patternAddress)+0xF1
	local chatExpandedValue = ashita.memory.read_uint8(chatExpandedPointer)

	return chatExpandedValue ~= 0
end

--- Fetches the party index of your <stpt> target, if it exists.
---@return integer?
function ffxi.GetStPartyIndex()
    -- Courtesy of Thorny from the Ashita discord
    local ptr = AshitaCore:GetPointerManager():Get('party')
    ptr = ashita.memory.read_uint32(ptr)
    ptr = ashita.memory.read_uint32(ptr)
    local isActive = (ashita.memory.read_uint32(ptr + 0x54) ~= 0)
    if isActive then
        return ashita.memory.read_uint8(ptr + 0x50)
    else
        return nil
    end
end

return ffxi
