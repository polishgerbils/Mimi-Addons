addon.name    = 'skillchain'
addon.author  = 'lin'
addon.version = '3.2.0'
addon.desc    = 'A little skillchain tracker so you know when things happen'

require('common')
local Settings = require('settings')
local Ffxi = require('lin.ffxi')
local Imgui = require('lin.imgui')
local Packets = require('lin.packets')

local BloodPacts = require('data.bloodpacts')
local ChainType = require('data.chaintype')
local Elements = require('data.elements')
local MagicBursts = require('data.magicbursts')
local NonChainingSkills = require('data.nonchainingskills')
local Resonances = require('data.resonances')
local Weaponskills = require('data.weaponskills')

---@class SkillchainSettings
---@field windowName string
---@field windowSize Vec2
---@field windowPos Vec2

---@class Skillchain
---@field name string
---@field time number
---@field chain SkillchainStep[]

---@class SkillchainStep
---@field id number
---@field time number
---@field type ChainType
---@field name string
---@field base_damage number
---@field bonus_damage number
---@field resonance Resonance

---@type SkillchainSettings
local Defaults = {
    windowName = 'Skillchain',
    windowSize = { -1, -1 },
    windowPos = { 100, 100 },
}

---@type SkillchainSettings
local Config = Settings.load(Defaults)

---@type Skillchain[]
local Chains = { }

---@type integer
local LastPulse = os.time()

-- Fetch an entity by its server ID. Helpful when looking up information from
-- packets, which tend to not include the entity index (since that's a client
-- thing only). Returns nil if no matching entity is found.
---@param id number
---@return table?
local function getEntityByServerId(id)
    -- The entity array is 2304 items long
    for x = 0, 2303 do
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

-- Determines if a particular entity (given as a server ID) belongs to the
-- player's alliance.
---@param id number
---@return boolean
local function isServerIdInParty(id)
    local party = AshitaCore:GetMemoryManager():GetParty()

    for i = 0, 17 do
        if party:GetMemberIsActive(i) == 1
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
local function isPetServerIdInParty(id)
    local party = AshitaCore:GetMemoryManager():GetParty()

    for i = 0, 17 do
        if party:GetMemberIsActive(i) == 1
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

-- Collects and collates data about a particular action in order for the render
-- function to display information about active skillchains. Specialized on
-- weaponskills.
---@param packet table
---@param mobs Skillchain[]
local function HandleWeaponskill(packet, mobs)
    -- Don't care about skillchains we can't participate in
    if not isServerIdInParty(packet.actor_id) then
        return
    end

    local resources = AshitaCore:GetResourceManager()

    -- Iterate down to the meat of our data
    for i = 1, packet.target_count do
        local target = packet.targets[i]

        -- Set up our display data
        ---@type Skillchain
        local mob = mobs[target.id] or {
            name = getEntityByServerId(target.id).Name,
            time = nil,
            chain = { },
        }

        for j = 1, target.action_count do
            local action = target.actions[j]
            local chain_step = nil

            -- Skip weaponskills that we'll never bother with or actions that
            -- have no reaction (like Steal)
            if not NonChainingSkills[action.animation]
            and action.reaction ~= 0 then
                -- Prep chain step display data
                ---@type SkillchainStep
                chain_step = {
                    id = action.animation,
                    time = os.time(),
                    type = nil,
                    name = resources:GetAbilityById(packet.param).Name[1],
                    base_damage = action.param,
                    bonus_damage = action.add_effect_param,
                    resonance = nil,
                }

                -- Specialize our chain step
                if action.reaction == 0x08 and not action.has_add_effect then
                    chain_step.type = ChainType.Starter
                    chain_step.resonance = table.concat(Weaponskills[packet.param].attr, ', ')

                    mob.time = os.time()
                    mob.chain = { }
                elseif action.reaction == 0x08 and action.has_add_effect then
                    chain_step.type = ChainType.Skillchain
                    chain_step.resonance = Resonances[action.add_effect_message]

                    mob.time = os.time()
                elseif action.reaction == 0x01 or action.reaction == 0x09 then
                    chain_step.type = ChainType.Miss
                else
                    chain_step.type = ChainType.Unknown
                end

                table.insert(mob.chain, chain_step)
            end
        end

        -- Replace the existing mob information or add the new one
        mobs[target.id] = mob
    end
end

-- Collects and collates data about a particular action in order for the render
-- function to display information about active skillchains. Specialized on pet
-- abilities.
---@param packet table
---@param mobs Skillchain[]
local function HandlePetAbility(packet, mobs)
    -- Don't care about skillchains we can't participate in
    if not isPetServerIdInParty(packet.actor_id)
    or BloodPacts[packet.param] == nil then
        return
    end

    -- Iterate down to the meat of our data
    for i = 1, packet.target_count do
        local target = packet.targets[i]

        -- Set up our display data
        ---@type Skillchain
        local mob = mobs[target.id] or {
            name = getEntityByServerId(packet.actor_id).Name,
            time = nil,
            chain = { },
        }

        for j = 1, target.action_count do
            local action = target.actions[j]

            ---@type SkillchainStep
            local chain_step = {
                id = action.animation,
                time = os.time(),
                type = nil,
                name = BloodPacts[packet.param].name,
                base_damage = action.param,
                bonus_damage = action.add_effect_param,
                resonance = nil,
            }

            -- Specialize our chain step
            if action.reaction == 0x08 and not action.has_add_effect then
                chain_step.type = ChainType.Starter
                chain_step.resonance = table.concat(BloodPacts[packet.param].attr, ', ')

                mob.time = os.time()
                mob.chain = { }
            elseif action.reaction == 0x08 and action.has_add_effect then
                chain_step.type = ChainType.Skillchain
                chain_step.resonance = Resonances[action.add_effect_message]

                mob.time = os.time()
            elseif action.reaction == 0x01 or action.reaction == 0x09 then
                chain_step.type = ChainType.Miss
            else
                chain_step.type = ChainType.Unknown
            end

            -- Don't expect to need this, but it's nice to be clear
            if chain_step.type == nil then
                chain_step.type = ChainType.Unknown
            end

            table.insert(mob.chain, chain_step)
        end

        -- Replace the existing mob information or add the new one
        mobs[target.id] = mob
    end
end

-- Collects and collates data about a particular action in order for the render
-- function to display information about active skillchains. Specialized on
-- magic abilities; only handles magic bursts currently, not BLU chains.
---@param packet table
---@param mobs Skillchain[]
local function HandleMagicAbility(packet, mobs)
    -- Don't care about skillchains we can't participate in
    if not isServerIdInParty(packet.actor_id)
    or MagicBursts[packet.param] == nil then
        return
    end

    -- Iterate down to the meat of our data
    for i = 1, packet.target_count do
        local target = packet.targets[i]

        -- MB targets must have a skillchain already
        local mob = mobs[target.id]
        if mob then
            for j = 1, target.action_count do
                local action = target.actions[j]

                ---@type SkillchainStep
                local chain_step = nil

                if action.message == MagicBursts[packet.param].burst_msg then
                    chain_step = {
                        id = packet.param,
                        time = os.time(),
                        type = ChainType.MagicBurst,
                        name = AshitaCore:GetResourceManager():GetSpellById(packet.param).Name[1],
                        base_damage = action.param,
                        bonus_damage = nil,
                        resonance = nil,
                    }

                    table.insert(mob.chain, chain_step)
                end
            end
        end
    end
end

-- Draws a single skillchain.
---@param mob Skillchain
local function DrawMob(mob)
    -- Create the heading for our skillchain.
    Imgui.Text(mob.name)
    -- Fill out the body of our skillchain.
    for _, chain in pairs(mob.chain) do
        -- Is this the first step of a chain? If so, don't show burstable
        -- elements (since you can't burst).
        if chain.type == ChainType.Starter then
            Imgui.BulletText(string.format('%s [%i dmg]\n%s', chain.name, chain.base_damage, chain.resonance))
        -- Otherwise, also display the bonus damage and burstable elements.
        elseif chain.type == ChainType.Skillchain then
            Imgui.BulletText(string.format('%s [%i + %i dmg]\n%s (%s)', chain.name, chain.base_damage, chain.bonus_damage or 0, chain.resonance, Elements[chain.resonance]))
        -- Display any magic bursts that occurred and their damage.
        elseif chain.type == ChainType.MagicBurst then
            Imgui.BulletText(string.format('Magic Burst! %s [%i dmg]', chain.name, chain.base_damage))
        elseif chain.type == ChainType.Miss then
            Imgui.BulletText(string.format('%s missed.', chain.name))
        else
            -- chain.type == ChainType.Unknown
        end
    end

    -- Create the footer for our skillchain, noting the remaining window and
    -- including a spacer between the mobs.
    if mob.time ~= nil then
        local time_remaining = 10 - math.abs(mob.time - os.time())
        if time_remaining >= 0 then
            -- you must wait 3 seconds before weaponskilling, but the remaining
            -- 7 seconds are free game for burst and skilling
            if time_remaining <= 7 then
                Imgui.BulletText(string.format('%is - go!', time_remaining))
            else
                Imgui.BulletText(string.format('%is - wait...', time_remaining))
            end
        else
            Imgui.BulletText('closed.')
        end
    end
end

-- Draws the whole list of active skillchains the user is aware of.
---@param mobs Skillchain[]
local function DrawSkillchain(mobs)
    local i = 1
    for _, mob in pairs(mobs) do
        if #mob.chain > 0 then
            if i > 1 then
                Imgui.Text('')
            end
            DrawMob(mob)
            i = i + 1
        end
    end
end

-- Checks each skillchain we know about for expiry and deletes when appropriate.
---@param chains Skillchain[]
local function RunGarbageCollector(chains)
    for i, mob in pairs(chains) do
        if mob.time == nil and #mob.chain > 0 and mob.chain[#mob.chain].type == ChainType.Miss then
            -- this means our starter missed
            local timeSince = os.time() - mob.chain[#mob.chain].time
            if timeSince > 12 then
                chains[i] = nil
            end
        elseif mob.time ~= nil then
            local timeSince = os.time() - mob.time
            if timeSince > 16 then
                chains[i] = nil
            end
        end
    end
end

---@param s SkillchainSettings?
local function UpdateSettings(s)
    if (s ~= nil) then
        Config = s
    end

    Settings.save()
end

local function OnLoad()
end

local function OnUnload()
    UpdateSettings()
end

---@param e CommandEventArgs
local function OnCommand(e)
    local args = e.command:args()

    if #args < 2 or args[1] ~= '/schain' then
        return
    end

    if args[2] == 'test' then
        ---@type Skillchain
        local testMob = {
            chain = { },
            name = 'Test Mob',
            time = os.time(),
        }

        ---@type SkillchainStep
        local testStep = {
            name = 'Test Weaponskill',
            resonance = Resonances[299],
            base_damage = 69,
            time = os.time(),
            type = ChainType.Starter,
        }

        table.insert(testMob.chain, testStep)
        table.insert(Chains, testMob)
    end

    e.blocked = true
end

---@param e PacketInEventArgs
local function OnPacket(e)
    if e.id == 0x28 then
        local action = Packets.ParseAction(e.data_modified_raw)

        if action.category == 3 then
            HandleWeaponskill(action, Chains)
        elseif action.category == 4 then
            HandleMagicAbility(action, Chains)
        elseif action.category == 13 then
            HandlePetAbility(action, Chains)
        end
    end
end

local function OnPresent()
    local activeCount = 0
    for _, mob in pairs(Chains) do
        if #mob.chain > 0 then
            activeCount = activeCount + 1
        end
    end

    if activeCount > 0 and not Ffxi.IsChatExpanded() then
        Imgui.Lin.DrawWindow(Config.windowName, Config.windowSize, Config.windowPos, function()
            DrawSkillchain(Chains)
        end)
    end

    local now = os.time()
    if now - LastPulse > 1 then
        LastPulse = now
        RunGarbageCollector(Chains)
    end
end

Settings.register('settings', 'settings_update', UpdateSettings)
ashita.events.register('load', 'on_load', OnLoad)
ashita.events.register('unload', 'on_unload', OnUnload)
ashita.events.register('command', 'on_command', OnCommand)
ashita.events.register('d3d_present', 'on_d3d_present', OnPresent)
ashita.events.register('packet_in', 'on_packet_in', OnPacket)
