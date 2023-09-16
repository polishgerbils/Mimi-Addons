--[[
* timers - Copyright (c) 2022 The Mystic
*
* This file is part of Timers for Ashita.
*
* Timers is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Timers is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Timers.  If not, see <https://www.gnu.org/licenses/>.
--]]

require('timer_group')
require('action_packets')
require('timer_common')
require('ashita4data')
require('enums')

local helpers = require('helpers')

local AoEBuff = T{
    id = nil,
    name = nil,
    duration = nil,
    o_time = nil,
    show = true
}


local buffsByCharacter = T{
};


local BlockedSpells = T{
    24931,
}

local BlockedBuffs = T{
    0,1,603,627
}

local AbilityMsgs = T{
    [100] = T{id=100},
    [115] = T{id=115},
    [116] = T{id=116},
    [117] = T{id=117},
    [118] = T{id=118},
    [120] = T{id=120},
    [121] = T{id=121},
    [126] = T{id=126},
    [131] = T{id=131},
    [134] = T{id=134},
    [143] = T{id=143},
    [146] = T{id=146},
    [148] = T{id=148},
    [150] = T{id=150},
    [323] = T{id=323}, -- RUN Valiance Ward
    [420] = T{id=420}, -- Corsair Rolls
    [424] = T{id=424}, -- Double Up
    [426] = T{id=426}, -- Bust
    [532] = T{id=532},
    [667] = T{id=667}, -- RUN Swordplay
    [668] = T{id=668}, -- RUN Vallation Ward
    [670] = T{id=670}, -- RUN Liement Ward
    [671] = T{id=671}, -- RUN Pflug Ward
    [798] = T{id=797}, -- Maneuvers
}

local PetMsgs = T{
	[186] = T{id=0} -- Summoner Ward Pacts
}
local PetTypes = T{
	[13] = T{id=0} -- Summoner Ward Pacts
}

local PetActionMap = T{
	-- Pet Action ID => Player BP ID
	

	[908] = 514, --Shining Ruby
    [0] = 515, --Glittering Ruby
    [0] = 526, --Reraise II
    [0] = 532, --Ecliptic Growl
    [0] = 533, --Ecliptic Howl
    [0] = 538, --Heavenward Howl
    [844] = 548, --Crimson Howl
    [0] = 553, --Inferno Howl
    [0] = 554, --Conflag Strike
    [0] = 560, --Rock Throw
    [0] = 562, --Rock Buster
    [0] = 563, --Megalith Throw
    [0] = 564, --Earthen Ward
    [0] = 565, --Stone IV
    [0] = 566, --Mountain Buster
    [0] = 569, --Earthen Armor
    [0] = 570, --Crag Throw
    [0] = 578, --Tail Whip
    [861] = 579, --Spring Water
    [0] = 580, --Slowga
    [0] = 585, --Tidal Roar
    [0] = 586, --Soothing Current
    [870] = 595, --Hastega
    [0] = 596, --Aerial Armor
    [0] = 601, --Fleet Wind
    [0] = 602, --Hastega II
    [0] = 610, --Frost Armor
    [0] = 611, --Sleepga
    [0] = 617, --Diamond Storm
    [0] = 618, --Crystal Blessing
    [887] = 626, --Rolling Thunder
    [0] = 628, --Lightning Armor
    [0] = 633, --Shock Squall
    [0] = 634, --Volt Strike
    [0] = 658, --Nightmare
    [0] = 660, --Noctoshield
    [0] = 661, --Dream Shroud
    [0] = 671, --Perfect Defense

}

local AbilityTypes = T{
    [6]  = T{id=6},
    [14] = T{id=14},
    [15] = T{id=15}, -- Run Pflug Ward.  Maybe others
}

local SpellMsgs = T{
    [205] = T{id=205},
    [230] = T{id=230},
    [266] = T{id=266},
    [280] = T{id=280},
    [319] = T{id=319},
}

local SpellTypes = T{
    [4] = T{id=4},
}


local CorsairRolls = T{
    [98]  = T{ id=98, status=310 },
    [99]  = T{ id=99, status=311 },
    [100] = T{ id=100, status=312 },
    [101] = T{ id=101, status=313 },
    [102] = T{ id=102, status=314 },
    [103] = T{ id=103, status=315 },
    [104] = T{ id=104, status=316 },
    [105] = T{ id=105, status=317 },
    [106] = T{ id=106, status=318 },
    [107] = T{ id=107, status=319 },
    [108] = T{ id=108, status=320 },
    [109] = T{ id=109, status=321 },
    [110] = T{ id=110, status=322 },
    [111] = T{ id=111, status=323 },
    [112] = T{ id=112, status=324 },
    [113] = T{ id=113, status=325 },
    [114] = T{ id=114, status=326 },
    [115] = T{ id=115, status=327 },
    [116] = T{ id=116, status=328 },
    [117] = T{ id=117, status=329 },
    [118] = T{ id=118, status=330 },
    [119] = T{ id=119, status=331 },
    [120] = T{ id=120, status=332 },
    [121] = T{ id=121, status=333 },
    [122] = T{ id=122, status=334 },
    [302] = T{ id=302, status=335 },
    [303] = T{ id=303, status=336 },
    [304] = T{ id=304, status=337 },
    [305] = T{ id=305, status=338 },
    [390] = T{ id=305, status=339 },
    [391] = T{ id=305, status=600 },
}

local SpellOverride = T{
    -- All Utsusemi spells apply param 66 in the action packet.  Normally param is
    -- the buff Id, but in this case, it's not.  Both apply buff 445 if your subjob
    -- is NIN. If your main job is NIN, Ni applies 446, and Ichi applies 445.
    -- Utsusemi: Ichi and Utsusemi: Ni
    [338] = T{ job=Jobs.Ninja, main=445, sub=445 },
    [339] = T{ job=Jobs.Ninja, main=446, sub=445 },
}

local AbilityOverride = T{
    -- Holy Circle
    [47]  = T{ job=Jobs.Paladin, main=74, sub=74 },

    -- Arcane Circle
    [50]  = T{ job=Jobs.DarkKnight, main=75, sub=75 },

    -- Mikage
    [335] = T{ job=Jobs.Ninja, main=502, sub=502 },

    -- Runes
    [358] = T{ job=Jobs.RuneFencer, main=523, sub=523 },
    [359] = T{ job=Jobs.RuneFencer, main=524, sub=524 },
    [360] = T{ job=Jobs.RuneFencer, main=525, sub=525 },
    [361] = T{ job=Jobs.RuneFencer, main=526, sub=526 },
    [362] = T{ job=Jobs.RuneFencer, main=527, sub=527 },
    [363] = T{ job=Jobs.RuneFencer, main=528, sub=528 },
    [364] = T{ job=Jobs.RuneFencer, main=529, sub=529 },
    [365] = T{ Job=Jobs.RuneFencer, main=530, sub=530 },

    -- Maneuvers
    [141] = T{ Job=Jobs.Puppetmaster, main=300, sub=300 },
    [142] = T{ Job=Jobs.Puppetmaster, main=301, sub=301 },
    [143] = T{ Job=Jobs.Puppetmaster, main=302, sub=302 },
    [144] = T{ Job=Jobs.Puppetmaster, main=303, sub=303 },
    [145] = T{ Job=Jobs.Puppetmaster, main=304, sub=304 },
    [146] = T{ Job=Jobs.Puppetmaster, main=305, sub=305 },
    [147] = T{ Job=Jobs.Puppetmaster, main=306, sub=306 },
    [148] = T{ Job=Jobs.Puppetmaster, main=307, sub=307 },

    -- Ward -> Valiance
    [371] = T{ Job=Jobs.RuneFencer, main=535, sub=535 },
}

local PetOverride = T{
}

local MultipleAllowed = T{ 
    309, -- Corsair
    523,524,525,526,527,528,529,530, -- Runefencer
    192,195,196,197,198,199,200,201,206,214,215,216,219, -- Bard
}

local function SetAoEBuff(name, effect, duration, time)
    AoEBuff.id = effect
    AoEBuff.name = name
    AoEBuff.duration = duration
    AoEBuff.o_time = time

    -- Give AoEBuff a 5 second TTL
    ashita.tasks.once(5, function()
        AoEBuff.id = nil
    end)
end

local function IsBardBuff(id)
    return T{ 192,195,196,197,198,199,200,201,206,214,215,216,219, }:hasval(id)
end

local function GetEffectOverride(spell, type)
    local player = AshitaCore:GetMemoryManager():GetPlayer()

    if not player then return nil end

    local mjob = player:GetMainJob()

    if AbilityTypes:haskey(type) and AbilityOverride:haskey(spell) then
        if mjob == AbilityOverride[spell].job then
            return AbilityOverride[spell].main
        else
            return AbilityOverride[spell].sub
        end
    elseif SpellTypes:haskey(type) and SpellOverride:haskey(spell) then
         if mjob == SpellOverride[spell].job then
            return SpellOverride[spell].main
        else
            return SpellOverride[spell].sub
        end
    elseif PetTypes:haskey(type) and PetOverride:haskey(spell) then
         if mjob == PetOverride[spell].job then
            return PetOverride[spell].main
        else
            return PetOverride[spell].sub
        end
    end

    return nil
end

local function InsertBuff(actor, target, effect, name, duration, replace, time)
    local o_time = time or ashita.time.clock()['ms']
    if replace == nil then replace = true end

    if (not target or target == 0) or (not actor or actor == 0) then return end

    if not effect or effect == 0 or BlockedBuffs:hasval(effect) then return end

    local target_index = GetTargetIndex(target)
    if not target_index then return end

    if not buffsByCharacter[target] then
        buffsByCharacter[target] = T{}
        buffsByCharacter[target].effects = T{}
    end

    if not buffsByCharacter[target].effects[effect] then
        buffsByCharacter[target].effects[effect] = T{}
    end

    local t = buffsByCharacter[target].effects[effect]
    if replace or not MultipleAllowed:hasval(effect) then
        t[1] = T{ name=name, o_time=o_time, duration=duration, target_id=target,
                  a_index=GetTargetIndex(actor), t_index=target_index, ttl=-1 }
    else
        table.insert(t, T{ name=name, o_time=o_time, duration=duration, target_id=target,
                           a_index=GetTargetIndex(actor), t_index=target_index, ttl=-1 })
    end
end

-- This doesn't fuly remove the bar,
-- Merely update the buff to the flashing state.
local function RemoveBuff(character, target_effect_id)
    local char_buffs = buffsByCharacter[character]
	
    if not char_buffs then return false end

	--print(('Timers: RemoveBuff(Character:[%d],Effect:[%d]) Called'):fmt(character, target_effect_id));
	
    -- Find the oldest matching buff then reset the time and duration
    -- to indicate that the buff has expired, and when it expired
    -- Any BRD buff matches any other BRD buff
    local least_duration = math.huge
    local effect_copy_index = nil
    for effect_id, effects_table in pairs(char_buffs.effects) do
        if (effect_id == target_effect_id) or (IsBardBuff(target_effect_id) and IsBardBuff(effect_id)) then
            for k, v in pairs(effects_table) do
                if v.duration > -1 and (v.duration < least_duration) then
                    least_duration = v.duration
                    target_effect_id = effect_id
                    effect_copy_index = k
                end
            end
        end
    end

	-- If we found a copy of the effect to remove..
    if target_effect_id and effect_copy_index and char_buffs.effects[target_effect_id] and char_buffs.effects[target_effect_id][effect_copy_index] then
		-- Set it's duraction to -1 and oiginal time to now...?
        char_buffs.effects[target_effect_id][effect_copy_index].duration = -1
        char_buffs.effects[target_effect_id][effect_copy_index].o_time = ashita.time.clock()['ms']
        return true
    end

    return false
end

local function GetBustDuration() 
    local base = 300 -- 5 Minutes
    local merits = gData.GetMeritCount(0x588)

    return (base - (merits * 10))
end

local function HandleCorsairBust(spell, target, name, actor)
    local bust_effect = 309
    local duration = GetBustDuration()

    -- Get the right status and Remove the effect of the roll that busted
    local status = CorsairRolls[spell].status
    buffsByCharacter[target].effects[status] = nil

    InsertBuff(actor, target, bust_effect, name, duration, false)
end

local function HandleCorsairRoll(target, effect, spell, actor)
    local a = AshitaCore:GetResourceManager():GetAbilityById(spell + 512)
    local name = (a and a.Name[1]) or 'Unknown'
    name = ('%s [%s]'):fmt(name, helpers.to_roman_numerals(effect))

    if effect >= 12 then -- Bust
        HandleCorsairBust(spell, target, name, actor)
        return
    end

    effect = CorsairRolls[spell].status

    local t = buffsByCharacter[target].effects[effect]
    if t and t[1] then
        -- This is a double-up since the buff already exists
        local e = buffsByCharacter[target].effects[effect][1]
        local duration = e.duration
        local o_time = e.o_time

        -- Replace the old buff with a new one so that we can change the name
        local mmParty = AshitaCore:GetMemoryManager():GetParty()
        for i = 1, mmParty:GetAlliancePartyMemberCount1() do
            local s_id = mmParty:GetMemberServerId(i - 1)
            InsertBuff(actor, s_id, effect, name, duration, true, o_time)
        end

        return -- We're done here, everything below is for the initial cast/use
    end

    local duration = gDuration.GetAbilityDuration(spell, target)
    duration = (duration and duration) or nil
    local o_time = ashita.time.clock()['ms']

    if not duration then return end

    if a.AreaRange > 0 then SetAoEBuff(name, effect, duration, o_time) end
    InsertBuff(actor, target, effect, name, duration, false, o_time)

    -- Create a timer for Double-Up
    t = buffsByCharacter[target].effects[308]
    if not t or not t[1] then
        InsertBuff(actor, target, 308, 'Double-Up Chance', 45, true)
    end
end
 
local function ApplyBuff(target, effect, spell, actor, type)
    if not buffsByCharacter[target] then
        buffsByCharacter[target] = T{}
        buffsByCharacter[target].effects = T{}
    end

    local resMan = AshitaCore:GetResourceManager()
	
	--print(('ApplyBuff: Target:%d, Effect:%d, Spell:%d, Actor:%d, Type:%d'):fmt(target, effect, spell, actor, type));

    -- Create timer
    local duration = nil
    local name = nil
    local o_time = ashita.time.clock()['ms']

    if AbilityTypes:haskey(type) then
        if CorsairRolls:haskey(spell) then
            HandleCorsairRoll(target, effect, spell, actor)
            return
        end
        duration = gDuration.GetAbilityDuration(spell, target)
        duration = (duration and duration) or nil
        local a = resMan:GetAbilityById(spell + 512)
        name = (a and a.Name[1]) or 'Unknown'
        if a.AreaRange > 0 then SetAoEBuff(name, effect, duration, o_time) end
    elseif SpellTypes:haskey(type) then
        duration = gDuration.GetSpellDuration(spell, target)
        duration = (duration and duration) or nil
        local s = resMan:GetSpellById(spell)
        name = (s and s.Name[1]) or 'Unknown'
        if s.AreaRange > 0 then SetAoEBuff(name, effect, duration, o_time) end
	elseif PetTypes:haskey(type) then 
		duration = gDuration.GetPetAbilityDuration(spell, target);
        duration = (duration and duration) or nil
		name = 'Unknown';
		
		-- Check our map to get the actual player blood pact ability ID
		if(PetActionMap:haskey(spell)) then
			local s = resMan:GetAbilityById(PetActionMap[spell] + 512)
			if(s ~= nil and s.Name[1]) then 
				name = s.Name[1];
				
				if s.AreaRange > 0 then SetAoEBuff(name, effect, duration, o_time) end
			end
		end
		
		
    else
        local t = GetEntity(GetTargetIndex(actor))
        name = (t and t.Name) or nil
        print(('Timers: Unknown action [%d] with type [%d] used by %s'):fmt(spell, type, name or 'Unknown'))
    end

    if not duration then return end

    InsertBuff(actor, target, effect, name, duration, false, o_time)
end

local function HandleAction(act)
    local party = AshitaCore:GetMemoryManager():GetParty()
	
	local player = GetPlayerEntity();
	if (player ~= nil and player.PetTargetIndex ~= 0) then
		-- Obtain the player pet entity..
		local petId = player.PetTargetIndex;
		_pet = AshitaCore:GetMemoryManager():GetEntity():GetServerId(petId);
	else
		_pet = nil;
	end


    if not party then return end

    if #act.targets == 0 then return end
    if #act.targets[1].actions == 0 then return end

    local message = act.targets[1].actions[1].message

    local serverId = party:GetMemberServerId(0)
	
    local target = act.targets[1].id
    local spell = act.param
    local param = act.targets[1].actions[1].param
    local effect = act.targets[1].actions[1].effect
    local actor = act.actor_id
    local type = act['type']

	
    if not serverId or (serverId ~= act.actor_id and act.actor_id ~= _pet) then 
		 --print(('Timers: Ignored Spell Cast:[%d] || Effect:[%d] || Param:[%d] || Target:[%d] || Actor:[%d] || Type:[%d]'):fmt(spell,effect,param, target, actor, type))
		return 
	end

	--print(('Timers: Accepted Spell Cast:[%d] || Effect:[%d] || Param:[%d] || Target:[%d] || Actor:[%d] || Type:[%d]'):fmt(spell,effect,param, target, actor, type))
	
    if not BlockedSpells:hasval(spell) and (AbilityMsgs:haskey(message) or SpellMsgs:haskey(message) or PetMsgs:haskey(message)) then
        --print(('Timers: Known message: Message:%d, Spell:%d, Type:%d, Effect:%d, Param:%d'):fmt(message, spell, type, effect, param))
        param = (GetEffectOverride(spell) or param)

        ApplyBuff(target, param, spell, actor, type)
    else
        --print(('Timers: Unknown message: Message:%d, Spell:%d, Type:%d, Effect:%d, Param:%d'):fmt(message, spell, type, effect, param))
    end
end

local function HandleActionMessage(data)
    local msg = {}
    msg.actor_id    = struct.unpack('I', data, 0x05)
    msg.target_id   = struct.unpack('I', data, 0x09)
    msg.param_1     = struct.unpack('I', data, 0x0D)
    msg.param_2     = struct.unpack('I', data, 0x11)
    msg.actor_idx   = struct.unpack('H', data, 0x15)
    msg.target_idx  = struct.unpack('H', data, 0x17)
    msg.message_id  = struct.unpack('H', data, 0x19) % 32768

    -- Target died
    if T{6, 20, 113, 406, 605, 646}:hasval(msg.message_id) then
        buffsByCharacter[msg.target_id] = nil
        
    -- Buff expired or was cancelled.  This may be unnecessary.
    -- Since I'm not sure, it doesn't hurt anything to have it
    elseif T{206, 321, 322}:hasval(msg.message_id) then
        RemoveBuff(msg.target_id, msg.param_1)
    end
end

local function HandlePartyBuffUpdate(e)
    local packetBuffs = T{}
	--print('Timers: Party Buff Update');

	-- Here we are compiling a list of all buffs on the party members we recieved data for.
    for i = 0, 4 do
        local memberId = struct.unpack('L', e.data, 0x04 + (i * 0x48) + 1);
        local memberIndex = struct.unpack('H', e.data, 0x08 + (i * 0x48) + 1);
        if memberIndex == 0 then break end

        -- memberIndex is a Trust, and we don't get buff updates for Trusts
        if memberIndex > 0x6FF and memberIndex <= 0x8FF then goto continue end

        packetBuffs[memberId] = T{}
        
        for j = 1, 32 do
            local buff = struct.unpack('B', e.data, 0x14 + (i * 0x48) + j);
            if (buff == 255) then
                break;
            end
            local bitMask = ashita.bits.unpack_be(e.data_raw, 0x0C + (i * 0x48), (j - 1) * 2, 2);
            local buff_id = bit.lshift(bitMask, 8) + buff;

            table.insert(packetBuffs[memberId], buff_id)
        end
        ::continue::
    end

    -- Loop our internal table to remove any buffs we no longer need tracked.
    for target_character, data in pairs(buffsByCharacter) do
        for effect_id, effects_table in pairs(data.effects) do
            for effect_copy_index, v in pairs(effects_table) do
				
				-- We received packet information on this character, but the buff was missing.
				-- Ergo, it expired.
				if packetBuffs[target_character] and not packetBuffs[target_character]:hasval(effect_id) then
                    RemoveBuff(target, effect_id)
                end
            end
        end
    end

    -- AoEBufId is saved when an AoE spell/ability is used.  Any party buff updates
    -- containing that spell ID are likely ours.  Maybe there's a better way of doing
    -- this, but I don't know of another way to work out if a non-targetted spell was
    -- cast by us.  This should work the vast majority of the time
    if not AoEBuff.id or not AoEBuff.show then return end

    local actor = AshitaCore:GetMemoryManager():GetParty():GetMemberServerId(0)
    for target, buff_t in pairs(packetBuffs) do
        for _, v in pairs(buff_t) do
            if v == AoEBuff.id then
                local e = GetEntity(GetTargetIndex(target))
                InsertBuff(actor, target, v, AoEBuff.name,
                        AoEBuff.duration, false, AoEBuff.o_time)
            end
        end
    end

    AoEBuff.id = nil
end

function HandleReplaceUtsusemi(server_id, id)
    local new_utsusemi_id = nil
    local utsusemi_table = T{ 446, 445, 444, 66 }
    if utsusemi_table:hasval(id) then
        utsusemi_table:each(function(v)
            if gData.GetBuffActive(v) then
                local effects = buffsByCharacter[server_id].effects
                effects[v] = T{}
                effects[v][1] = effects[id][1]
                effects[id] = T{}
                new_utsusemi_id = v
            end
        end)
    end

    return new_utsusemi_id
end

function HandleBuffUpdate(e)
    local p_server_id = AshitaCore:GetMemoryManager():GetParty():GetMemberServerId(0)
    if not p_server_id or not buffsByCharacter[p_server_id] then return end
	
	-- We don't know why this packet was sent, but there's two main options we care about.
	-- A (de)buff was added to us, or a (de)buff was removed.
	
	-- In the case of added buffs, we don't know the source of them, and theoretically
	-- only care about tracking things we applied.
	
	-- And so, this only checks for removal.
	
	-- Start from full list of locally tracked buffs.
    for effect_id, effect_t in pairs(buffsByCharacter[p_server_id].effects) do
	
		-- Buffs/"effects" can have multiple copies applied to us of the same effect, which can each have unique timers.
		-- So we have to compare the # of copies of each effect.
        local real_count = gPackets.GetBuffCount(effect_id)
		local tracked_count = helpers.table_length(effect_t)
		
		local modified_id = HandleReplaceUtsusemi(p_server_id, effect_id)
			
		for i = 1, tracked_count - real_count do
			--print('Timers: Removing Buff via HandleBuffUpdate()');
			RemoveBuff(p_server_id, effect_id)
		end
    end
end

--[[
    This Function syncs the buffs active on the current player's client with 
	our table list.  It has no effect with respect to buffs on other players.
]]
function SyncBuffs()
    local target = AshitaCore:GetMemoryManager():GetParty():GetMemberServerId(0)
    local player = AshitaCore:GetMemoryManager():GetPlayer()

    if not target or not player then return end
	

	-- Clear personal buffs table. (Buffs on our character)
	buffsByCharacter[target] = {}
	buffsByCharacter[target].effects = {}

	-- Why the fuck are we not using this elsewhere?
    local active_buffs = player:GetBuffs()
    local active_timers = player:GetStatusTimers()
	
	
	-- Must be max of 32 buffs?
    for i=1, 32 do
        local name = AshitaCore:GetResourceManager():GetString('buffs.names', active_buffs[i])
		
        if name == nil then break end

        local effect_t = buffsByCharacter[target].effects[active_buffs[i]]
		local buff_count = gPackets.GetBuffCount(active_buffs[i])
        if effect_t then
            -- We already have an instance of this buff in our locally tracked table.
            if buff_count < helpers.table_length(effect_t) then
                local duration = helpers.buff_duration(active_timers[i])
                InsertBuff(target, target, active_buffs[i], name, duration, false)
            end
        else    
			-- This is a buff we are missing from our locally tracked table.
            local duration = helpers.buff_duration(active_timers[i])
            InsertBuff(target, target, active_buffs[i], name, duration, true)
        end
    end
	
end

local _pet = nil;

local function HandlePacket(e)
    if e.blocked then return end

    if e.id == 0x028 then
        -- Obtain the player entitiy..
        HandleAction(ParseActionPacket(e.data_modified))
    elseif e.id == 0x029 then
        HandleActionMessage(e.data_modified)
    elseif e.id == 0x37 then -- Called any time current player's state is updated.
        HandleBuffUpdate(e)
    elseif e.id == 0x076 then -- Called whenever a party member's buff/debuff state is updated.
        HandlePartyBuffUpdate(e)
    end
end

-- Handles updating the actual visual display of the timers.
local function UpdateBuffs(timers)
    local bars = T{}

    for character_id, data in pairs(buffsByCharacter) do
	
	
        for effect_id, effects_table in pairs(data.effects) do
            for effect_copy_index, effect_info in pairs(effects_table) do
                local effect_target = GetEntity(effect_info.t_index)
                local effect_source = GetEntity(effect_info.a_index)

				-- Adjust timer names as needed based on target and source.
                local timer_name = effect_info.name
				if(effect_target ~= nil and effect_target.Name ~= nil) then
					if (effect_target and effect_target.ServerId) ~= (effect_source and effect_source.ServerId) then
						timer_name = ("%s (%s)"):fmt(effect_info.name, effect_target.Name)
					end
				end

                local time_active = (ashita.time.clock()['ms'] - effect_info.o_time)
				local time_remaining = ((effect_info.duration) - time_active);
				
				if(effect_info.duration >= 0 and time_remaining <= -5000) then
					-- Catch case for situations where we've missed all relevant packets for buffs expiring.
					-- At this point, mark the timer as toast and let the user deal with it.
					RemoveBuff(character_id, effect_id);
				end
				
				local maxTime = 1000 * 60 * 60; -- Don't track buffs longer than one hour.
				
				if(effect_info.duration >= 0 and time_remaining > maxTime) then
					-- Catch case for extremely long buffs (Ex. Signet) that we most likely don't care about tracking.
					buffsByCharacter[character_id].effects[effect_id][effect_copy_index] = nil;
					render = false;
				end
				
				-- Expired buffs
				local render = true;
				if(effect_info.duration <= -1) then
					local expired_time = time_active;
					if(time_active > 2000 and time_active <= 12000) then
						effect_info.duration = -2;
					elseif (time_active > 12000) then
						buffsByCharacter[character_id].effects[effect_id][effect_copy_index] = nil;
						render = false;
					end
				end
				
				if(render) then
					table.insert(bars, { name=timer_name, duration=effect_info.duration, remains=time_remaining,
									 key=effect_info.t_index .. effect_id, icon_id=effect_id })
				end

            end
        end
    end

    timers:render(bars)
end

local function ShowPartyBuffs(show)
    AoEBuff.show = show
end

local ret = {
	buffs = buffsByCharacter
}
ret.Update = UpdateBuffs
ret.HandlePacket = HandlePacket
ret.SyncBuffs = SyncBuffs
ret.ShowPartyBuffs = ShowPartyBuffs

return ret

