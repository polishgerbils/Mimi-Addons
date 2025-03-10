H.TP = {}

H.TP.SC_Opener = nil
H.TP.SC_Opening_WS = nil
H.TP.SC_Step   = 0

------------------------------------------------------------------------------------------------------
-- Parse the weaponskill packet.
-- Surprises:
-- 1. Some abilities--like DRG Jumps--oddly show up in this packet.
------------------------------------------------------------------------------------------------------
---@param action table action packet data.
---@param actor_mob table the mob data of the entity performing the action.
---@param log_offense boolean if this action should actually be logged.
------------------------------------------------------------------------------------------------------
H.TP.Action = function(action, actor_mob, log_offense)
    if not log_offense then return nil end

	local ws_data = H.TP.WS_Data(action, actor_mob)
    if not ws_data then return nil end
    local ws_name = ws_data.en
    local ws_id = ws_data.id

    local result, target_mob, sc_name
    local damage    = 0
    local sc_damage = 0

    for target_index, target_value in pairs(action.targets) do
        for action_index, _ in pairs(target_value.actions) do

            result = action.targets[target_index].actions[action_index]

            -- Abilities marked as weaponskills
            if H.TP.WS_Ability(result, ws_id, action, actor_mob) then return nil end
            target_mob = Ashita.Mob.Get_Mob_By_ID(action.targets[target_index].id)

            if target_mob then
                if Ashita.Mob.Is_Monster(target_mob) then DB.Lists.Check.Mob_Exists(target_mob.name) end

                -- Check for skillchains
                sc_damage, sc_name = H.TP.Skillchain_Parse(result, actor_mob, target_mob, ws_name)

                -- Need to calculate WS damage here to account for AOE weaponskills
                damage = damage + H.TP.Weaponskill_Parse(result, actor_mob, target_mob, ws_name, ws_id)
            end
        end
    end

    -- Finalize weaponskill data.
    -- Have to do it outside of the loop to avoid counting attempts and hits multiple times.
    local audits = {
        player_name = actor_mob.name,
        target_name = target_mob.name,
    }
    local tp = Ashita.Party.Refresh(actor_mob.name, Ashita.Enum.Player_Attributes.TP)
    if not tp then tp = 0 end

    H.TP.Weaponskill_Attempts(audits, ws_name)
    H.TP.Weaponskill_TP(audits, ws_name, tp, H.Trackable.WS)
    if damage > 0 then H.TP.Weaponskill_Hit(audits, ws_name) end
    if sc_name ~= DB.Enum.Values.DEBUG then H.TP.Skillchain_Hit(audits, sc_name) end

    -- Update the battle log.
    H.TP.Blog_WS(actor_mob, damage, ws_data, ws_name, tp)
    H.TP.Blog_SC(actor_mob, sc_damage, sc_name)
end

------------------------------------------------------------------------------------------------------
-- Parse the begin monster TP move packet. This is primarily used to capture pet TP when using abilities.
-- BST Pet and Puppet ranged attacks fall into this category.
-- Trust abilities can show up here too. They don't have an owner.
-- As DRG, using Smiting Breath and Restoring Breath also come through here (as abilities).
-- Using the avatar ability as SMN also goes through here.
------------------------------------------------------------------------------------------------------
---@param action table action packet data.
---@param actor_mob table the mob data of the entity performing the action.
---@param log_offense boolean if this action should actually be logged.
------------------------------------------------------------------------------------------------------
H.TP.Begin_Monster_Action = function(action, actor_mob, log_offense)
    if not log_offense or Ashita.Mob.Is_Player(actor_mob) then return false end
    local owner_mob = Ashita.Mob.Pet_Owner(actor_mob)    -- Check to see if the pet belongs to anyone in the party.

    local target_mob, result, action_id, skill_data, skill_name
    local trackable = H.Trackable.PET_WS
    for target_index, target_value in pairs(action.targets) do
        target_mob = Ashita.Mob.Get_Mob_By_ID(target_value.id)
        if not target_mob then target_mob = {name = DB.Enum.Values.DEBUG} end
        for action_index, _ in pairs(target_value.actions) do
            result = action.targets[target_index].actions[action_index]
            action_id = result.param
            skill_data = H.TP.Pet_Skill_Data(action_id, actor_mob)
            if not skill_data then return nil end
            skill_name = skill_data.en

            -- Avatar and wyvern abilities go through here too.
            if Res.Avatar.Get_Healing(action_id) then
                trackable = H.Trackable.PET_HEAL
            elseif Res.Avatar.Get_Rage(action_id) or Res.Avatar.Get_Ward(action_id) then
                trackable = H.Trackable.PET_ABILITY
            elseif Res.Pets.Get_Damaging_Wyvern_Breath(action_id) then
                trackable = H.Trackable.PET_ABILITY
                skill_name = Res.Pets.Get_Damaging_Wyvern_Breath(action_id).en
            elseif Res.Pets.Get_Healing_Wyvern_Breath(action_id) then
                trackable = H.Trackable.PET_HEAL
                skill_name = Res.Pets.Get_Healing_Wyvern_Breath(action_id).en
            elseif not Res.Monster.Get_Damaging_Ability(action_id) then
                return nil
            end
        end
    end

    local pet_tp = Ashita.Player.Get(Ashita.Enum.Player_Attributes.PET_TP) or 0
    local audits = H.TP.Audits(actor_mob, owner_mob, target_mob)
    H.TP.Weaponskill_TP(audits, skill_name, pet_tp, trackable)
end

------------------------------------------------------------------------------------------------------
-- Parse the finish monster TP move packet.
-- BST Pet and Puppet ranged attacks fall into this category.
-- Trust abilities can show up here too. They don't have an owner.
------------------------------------------------------------------------------------------------------
---@param action table action packet data.
---@param actor_mob table the mob data of the entity performing the action.
---@param log_offense boolean if this action should actually be logged.
------------------------------------------------------------------------------------------------------
H.TP.Monster_Action = function(action, actor_mob, log_offense)
    if not log_offense then return false end
    local owner_mob = Ashita.Mob.Pet_Owner(actor_mob)    -- Check to see if the pet belongs to anyone in the party.

    local skill_data = H.TP.Pet_Skill_Data(action.param, actor_mob)
    if not skill_data then return nil end
    local skill_name = skill_data.en
    local action_id = skill_data.id

    local result, target_mob
    local damage = 0

    for target_index, target_value in pairs(action.targets) do
        for action_index, _ in pairs(target_value.actions) do
            result = action.targets[target_index].actions[action_index]
            target_mob = Ashita.Mob.Get_Mob_By_ID(action.targets[target_index].id)
            if not target_mob then target_mob = {name = DB.Enum.Values.DEBUG} end

            -- Puppet ranged attack
            -- This needs to be inside the result loop in order to send the data to the ranged handler.
            if action_id == 1949 then
                H.Ranged.Parse(result, actor_mob, target_mob, owner_mob)
                skill_name = "Pet Ranged"
                damage = result.param

            -- BST pet abilities can't skillchain in HorizonXI.
            -- Need to calculate WS damage here to account for AOE weaponskills.
            else
                damage = damage + H.TP.Weaponskill_Parse(result, actor_mob, target_mob, skill_name, action_id, owner_mob)
            end
        end
    end

    local audits = H.TP.Audits(actor_mob, owner_mob, target_mob)
    H.TP.Pet_Skill_Attempts(audits, audits.trackable, skill_name)
    if damage > 0 then H.TP.Pet_Skill_Hit(audits, audits.trackable, skill_name) end

    -- Update the battle log.
    H.TP.Blog_Pet_Skill(owner_mob, actor_mob, action_id, damage, skill_name)

    return true
end

------------------------------------------------------------------------------------------------------
-- Set data for a weaponskill action.
-- AOE weaponskills will go through this one time for each mob hit.
------------------------------------------------------------------------------------------------------
---@param result table contains all the information for the action.
---@param actor_mob table name of the player that did the action.
---@param target_mob table name of the target that received the action.
---@param ws_name string name of the weaponskill that was used.
---@param ws_id number ID of the ability that was used. Right now this is used to check monster abilities.
---@param owner_mob? table if the action was from a pet then this will hold the owner's mob.
---@return number
------------------------------------------------------------------------------------------------------
H.TP.Weaponskill_Parse = function(result, actor_mob, target_mob, ws_name, ws_id, owner_mob)
    Debug.Packet.Add_Action(actor_mob.name, target_mob.name, "Weaponskill", result)
    local damage = result.param
    local audits = H.TP.Audits(actor_mob, owner_mob, target_mob)

    -- A lot of pet abilities just land a status effect and it carries in a value as if it were damage.
    damage = H.TP.Pet_Skill_Ignore(owner_mob, audits, damage, ws_id, ws_name)

    -- Some weaponskills drain MP instead of doing damage.
    audits = H.TP.MP_Drain(audits, ws_id)

    -- This handles both the pet and player case.
    DB.Catalog.Update_Damage(audits.player_name, audits.target_name, audits.trackable, damage, ws_name, audits.pet_name)

    return damage
end

-- ------------------------------------------------------------------------------------------------------
-- Get weaponskill data.
-- ------------------------------------------------------------------------------------------------------
---@param action table
---@param actor_mob table
---@return table|nil
-- ------------------------------------------------------------------------------------------------------
H.TP.WS_Data = function(action, actor_mob)
    local ws_data = Ashita.WS.Get_By_ID(action.param)
	if not ws_data then
        Debug.Error.Add("TP.WS_Data: {" .. tostring(actor_mob.name) .. "} used ws ID " .. tostring(action.param) .. " and it wasn't found.")
        return nil
    end
    return ws_data
end

-- ------------------------------------------------------------------------------------------------------
-- Get pet skill data.
-- ------------------------------------------------------------------------------------------------------
---@param action_id number
---@param actor_mob table
---@return table
-- ------------------------------------------------------------------------------------------------------
H.TP.Pet_Skill_Data = function(action_id, actor_mob)
    local skill_data = Res.Monster.Get_Full_List(action_id)
    if not skill_data then
        Debug.Error.Add("TP.Pet_Skill_Data: {" .. tostring(actor_mob.name) .. "} TP move " .. tostring(action_id) .. " unmapped in Pet_Skill.")
        skill_data = {id = action_id, en = "UNK Mon. Ability (" .. action_id .. ")"}
    end
    return skill_data
end

-- ------------------------------------------------------------------------------------------------------
-- Checks for abilities that come through on the WS packet.
-- I'm differentiating them based on chat message, so this needs to be called in the result loop and not before.
-- Specific case: Steal/Swift Blade, Atonement/Mug, Gale Axe/Jump, Spinning Axe/Super Jump
-- ------------------------------------------------------------------------------------------------------
---@param result table
---@param ws_id number
---@param action table
---@param actor_mob table
---@return boolean true: weaponskill was actually an ability
-- ------------------------------------------------------------------------------------------------------
H.TP.WS_Ability = function(result, ws_id, action, actor_mob)
    if Res.WS.Get_Ability(ws_id) then
        if result.message ~= 185 and result.message ~= 188 then
            H.Ability.Action(action, actor_mob, true)
            return true
        end
    end
    return false
end

-- ------------------------------------------------------------------------------------------------------
-- Increments weaponskill attempts.
-- ------------------------------------------------------------------------------------------------------
---@param audits table
---@param ws_name string
-- ------------------------------------------------------------------------------------------------------
H.TP.Weaponskill_Attempts = function(audits, ws_name)
    DB.Data.Update(H.Mode.INC, 1, audits, H.Trackable.WS, H.Metric.COUNT)
    DB.Catalog.Update_Metric(H.Mode.INC, 1, audits, H.Trackable.WS, ws_name, H.Metric.COUNT)
end

-- ------------------------------------------------------------------------------------------------------
-- Increments weaponskill hits.
-- ------------------------------------------------------------------------------------------------------
---@param audits table
---@param ws_name string
-- ------------------------------------------------------------------------------------------------------
H.TP.Weaponskill_Hit = function(audits, ws_name)
    DB.Data.Update(H.Mode.INC, 1, audits, H.Trackable.WS, H.Metric.HIT_COUNT)
    DB.Catalog.Update_Metric(H.Mode.INC, 1, audits, H.Trackable.WS, ws_name, H.Metric.HIT_COUNT)
end

-- ------------------------------------------------------------------------------------------------------
-- Increments weaponskill hits.
-- ------------------------------------------------------------------------------------------------------
---@param audits table
---@param ws_name string
---@param tp integer
---@param trackable string
-- ------------------------------------------------------------------------------------------------------
H.TP.Weaponskill_TP = function(audits, ws_name, tp, trackable)
    if tp < 0 then tp = 0 end
    if tp > 3000 then tp = 3000 end
    DB.Data.Update(H.Mode.INC, tp, audits, trackable, H.Metric.TP_SPENT)
    DB.Catalog.Update_Metric(H.Mode.INC, tp, audits, trackable, ws_name, H.Metric.TP_SPENT)
end

-- ------------------------------------------------------------------------------------------------------
-- Increments pet skill attempts.
-- ------------------------------------------------------------------------------------------------------
---@param audits table
---@param trackable string
---@param skill_name string
-- ------------------------------------------------------------------------------------------------------
H.TP.Pet_Skill_Attempts = function(audits, trackable, skill_name)
    DB.Data.Update(H.Mode.INC, 1, audits, trackable, H.Metric.COUNT)
    DB.Catalog.Update_Metric(H.Mode.INC, 1, audits, trackable, skill_name, H.Metric.COUNT)
end

-- ------------------------------------------------------------------------------------------------------
-- Some pet skills don't do direct damage and their effects come in as damage--must be ignored.
-- ------------------------------------------------------------------------------------------------------
---@param owner_mob table|nil
---@param audits table
---@param damage number
---@param ws_id number
---@param ws_name string
---@return number
-- ------------------------------------------------------------------------------------------------------
H.TP.Pet_Skill_Ignore = function(owner_mob, audits, damage, ws_id, ws_name)
    if owner_mob then
        if not Res.Monster.Get_Damaging_Ability(ws_id) then
            Debug.Error.Add("TP.Pet_Skill_Ignore: " .. tostring(ws_id) .. " " .. tostring(ws_name) .. " considered a non-damage pet ability.")
            damage = 0
        end
        DB.Data.Update(H.Mode.INC, damage, audits, H.Trackable.PET, H.Metric.TOTAL)
    end
    return damage
end

-- ------------------------------------------------------------------------------------------------------
-- Increments pet skill hits.
-- ------------------------------------------------------------------------------------------------------
---@param audits table
---@param trackable string
---@param skill_name string
-- ------------------------------------------------------------------------------------------------------
H.TP.Pet_Skill_Hit = function(audits, trackable, skill_name)
    DB.Data.Update(H.Mode.INC, 1, audits, trackable, H.Metric.HIT_COUNT)
    DB.Catalog.Update_Metric(H.Mode.INC, 1, audits, trackable, skill_name, H.Metric.HIT_COUNT)
end

-- ------------------------------------------------------------------------------------------------------
-- Handle weaponskills that drain MP instead of doing damage.
-- ------------------------------------------------------------------------------------------------------
---@param audits table
---@param ws_id number
---@return table
-- ------------------------------------------------------------------------------------------------------
H.TP.MP_Drain = function(audits, ws_id)
    if Res.WS.Get_MP_Drain(ws_id) then
        audits.trackable = DB.Enum.Trackable.MP_DRAIN
    end
    return audits
end

-- ------------------------------------------------------------------------------------------------------
-- Set audit information for pet skills.
-- ------------------------------------------------------------------------------------------------------
---@param actor_mob table
---@param owner_mob table|nil
---@param target_mob table
---@return table
-- ------------------------------------------------------------------------------------------------------
H.TP.Audits = function(actor_mob, owner_mob, target_mob)
    -- Initialize on case where this is a trust or regular monster.
    local player_name = actor_mob.name
    local pet_name = nil
    local trackable = H.Trackable.WS
    -- Case where this is a player's pet using an ability.
    if owner_mob then
        player_name = owner_mob.name
        pet_name = actor_mob.name
        trackable = H.Trackable.PET_WS
    end
    local audits = {
        player_name = player_name,
        target_name = target_mob.name,
        pet_name = pet_name,
        trackable = trackable
    }
    return audits
end

-- ------------------------------------------------------------------------------------------------------
-- Check for skillchains.
-- ------------------------------------------------------------------------------------------------------
---@param result table
---@param actor_mob table
---@param target_mob table
---@param ws_name string
---@return number, string
-- ------------------------------------------------------------------------------------------------------
H.TP.Skillchain_Parse = function(result, actor_mob, target_mob, ws_name)
    local sc_id = result.add_effect_message
    local sc_damage = 0
    local sc_name = DB.Enum.Values.DEBUG
    if sc_id > 0 then
        sc_name    = Res.WS.Get_Skillchain(sc_id)
        sc_damage  = sc_damage + H.TP.Skillchain_Damage(result, actor_mob.name, target_mob.name, sc_name)
        H.TP.SC_Step = H.TP.SC_Step + 1
    else
        H.TP.SC_Opener = actor_mob.name
        H.TP.SC_Opening_WS = ws_name
        H.TP.SC_Step   = 1
    end
    return sc_damage, sc_name
end

------------------------------------------------------------------------------------------------------
-- Set damage data for a skillchain action.
------------------------------------------------------------------------------------------------------
---@param result table contains all the information for the action.
---@param player_name string name of the player that did the action.
---@param target_name string name of the target that received the action.
---@param sc_name string name of the skillchain that happened.
---@return number
------------------------------------------------------------------------------------------------------
H.TP.Skillchain_Damage = function(result, player_name, target_name, sc_name)
    local damage = result.add_effect_param
    DB.Catalog.Update_Damage(player_name, target_name, H.Trackable.SC, damage, sc_name)
    return damage
end

-- ------------------------------------------------------------------------------------------------------
-- Increments skillchain counts.
-- ------------------------------------------------------------------------------------------------------
---@param audits table
---@param sc_name string
-- ------------------------------------------------------------------------------------------------------
H.TP.Skillchain_Hit = function(audits, sc_name)
    -- Total Attempts
    DB.Data.Update(H.Mode.INC, 1, audits, H.Trackable.SC, H.Metric.COUNT)
    DB.Catalog.Update_Metric(H.Mode.INC, 1, audits, H.Trackable.SC, sc_name, H.Metric.COUNT)

    -- Successfull SC Count
    DB.Data.Update(H.Mode.INC, 1, audits, H.Trackable.SC, H.Metric.HIT_COUNT)
    DB.Catalog.Update_Metric(H.Mode.INC, 1, audits, H.Trackable.SC, sc_name, H.Metric.HIT_COUNT)

    -- Credit to skillchain closer.
    DB.Data.Update(H.Mode.INC, 1, audits, H.Trackable.SC, H.Metric.SC_CLOSED)
    DB.Catalog.Update_Metric(H.Mode.INC, 1, audits, H.Trackable.SC, sc_name, H.Metric.SC_CLOSED)

    -- Credit to skillchain opener (except for multistep skillchains).
    if H.TP.SC_Step <= 2 then
        local sc_audits = T{
            player_name = H.TP.SC_Opener,
            target_name = audits.target_name,
        }
        DB.Data.Update(H.Mode.INC, 1, sc_audits, H.Trackable.SC, H.Metric.SC_OPENED)
        DB.Catalog.Update_Metric(H.Mode.INC, 1, sc_audits, H.Trackable.SC, sc_name, H.Metric.SC_OPENED)
    end
end

-- ------------------------------------------------------------------------------------------------------
-- Adds weaponskill damage to the battle log.
-- ------------------------------------------------------------------------------------------------------
---@param actor_mob table
---@param damage number
---@param ws_data table
---@param ws_name string
---@param tp integer
-- ------------------------------------------------------------------------------------------------------
H.TP.Blog_WS = function(actor_mob, damage, ws_data, ws_name, tp)
    Blog.Add(actor_mob.name, nil, Blog.Enum.Types.WS, ws_name, damage, tp, H.Trackable.WS, ws_data)
end

-- ------------------------------------------------------------------------------------------------------
-- Adds skillchain damage to the battle log.
-- ------------------------------------------------------------------------------------------------------
---@param actor_mob table
---@param sc_damage number
---@param sc_name string
-- ------------------------------------------------------------------------------------------------------
H.TP.Blog_SC = function(actor_mob, sc_damage, sc_name)
    if sc_damage > 0 then
        Blog.Add(actor_mob.name, nil, Blog.Enum.Types.SC, sc_name, sc_damage, nil, DB.Enum.Trackable.SC)
    end
end

-- ------------------------------------------------------------------------------------------------------
-- Adds pet skill damage to the battle log.
-- The battle log is interesting here. Pets have abilities that have status effects but don't do any damage.
-- The text needs a little massaging to avoid making it look like all the pet's status effect abilities missed.
-- Additional abilities such as these may need to be added to monster ability filter.
-- ------------------------------------------------------------------------------------------------------
---@param owner_mob? table
---@param actor_mob table
---@param action_id number
---@param damage number
---@param skill_name string
-- ------------------------------------------------------------------------------------------------------
H.TP.Blog_Pet_Skill = function(owner_mob, actor_mob, action_id, damage, skill_name)
    if owner_mob then
        local ignore = nil
        if not Res.Monster.Get_Damaging_Ability(action_id) then ignore = H.Enum.Flags.IGNORE end
        Blog.Add(owner_mob.name, actor_mob.name, Blog.Enum.Types.PET_TP, skill_name, damage, H.Enum.Text.BLANK, ignore)
    end
end