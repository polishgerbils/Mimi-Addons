local profile = {};

local Settings = {
    isFast = false,
    isMDT = false,
    isMP = false,
	isEnabled = false,
    Subslot = 'Default',
    RestTimer = 0,
    CurrentLevel = 0,
	Subjob = {
		WHM = false,
		BLM = false,
		NIN = false,
		WAR = false,
		DRK = false
	}

}

local EleStaffTable = {
    ['Fire'] = 'Vulcan\'s Staff',
    ['Earth'] = 'Terra\'s Staff',
    ['Water'] = 'Water Staff',
    ['Wind'] = 'Auster\'s Staff',
    ['Ice'] = 'Aquilo\'s Staff',
    ['Thunder'] = 'Jupiter\'s Staff',
    ['Light'] = 'Light Staff',
    ['Dark'] = 'Pluto\'s Staff'
};

local Spells = {
    Healing = T{"Cure", "Cure II", "Cure III", "Cure IV", "Curaga", "Curaga II", "Erase"},

    MndSkill = {"Dia", "Dia II", "Banish", "Banish II"},
	
	MndEnfeebling = {"Paralyze", "Paralyze II", "Slow", "Slow II"},

    IntEnfeebling = {"Blind", "Blaze Spikes", "Ice Spikes", "Shock Spikes", "Rasp", "Drown", "Frost", "Burn", "Choke", "Shock"},
		
	AccEnfeebling = {"Sleep", "Sleep II", "Bind", "Gravity", "Poison", "Poison II", "Dispel", "Silence"},
		
	Dark = {"Bio", "Bio II", "Drain", "Aspir"},
	 
    EleDebuffs = {},

    Enhancing = {"Phalanx", "Enthunder", "Enstone", "Enaero"},
	    
    Buffs = {"Protect", "Protect II", "Protect III", "Protect IV", "Protectra", "Protectra II", "Protectra III",
     "Protectra IV", "Protectra V", "Shell", "Shell II", "Shell III", "Shell IV", "Shellra", "Shellra II",
     "Shellra III", "Shellra IV", "Shellra V", "Haste", "Refresh", "Aquaveil", "Blink"},

    Sneaking = {"Sneak", "Invisible"}
}

local Sets = {

	Style = {
	},
	
    ['Idle_Priority'] = {
        Main = 'Terra\'s Staff',
        Sub = '',
        Ammo = 'Hedgehog Bomb',
        Head = 'Dls. Chapeau +1',
        Neck = 'Uggalepih pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = {'Magnetic Earring', 'Morion Earring +1'},
        Body = 'Dalmatica',
        Hands = 'Duelist\'s Gloves',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Hexerei Cape',
        Waist = {'Hierarch Belt', 'Swift belt'},
        Legs = {'Blood cuisses', 'Savage loincloth'},
        Feet = {'River gaiters'},
    },

    ['Healing'] = {
	    Ammo = 'Hedgehog Bomb',
		Head = 'Hydra beret',
        Neck = 'Promise Badge', 
        Body = 'Mahatma Hpl.',
        Ear1 = 'Loquac. Earring',
		Ear2 = 'Novia earring',
        Hands = 'Hydra gloves',
        Ring1 = 'Aqua Ring',
        Ring2 = 'Aqua Ring',
        Back = 'Prism Cape',	
        Waist = 'Penitent\'s rope',
        Legs = 'Warlock\'s Tights',
        Feet = 'River gaiters'
    },

    ['Resting_Priority'] = {
        Main = {'Pluto\'s Staff', 'Pilgrim\'s wand'},
		Head = 'Hydra beret',
		Neck = 'Checkered Scarf',
        Ear1 = 'Relaxing Earring',
	    Ear2 = 'Magnetic Earring',
        Hands = 'Hydra gloves',
        Ring1 = 'Ether Ring',
        Ring2 = '',
        Body = 'Mahatma Hpl.',
        Back = 'Astute Cape',
        Waist = 'Duelist\'s Belt',
        Legs = 'Baron\'s slops',
    },
	
    ['MndSkill'] = {
        Head = 'Dls. Chapeau +1',
        Neck = 'Enfeebling Torque', 
        Ear1 = 'Cmn. Earring',
        Ear2 = 'Coral Earring',
        Body = 'Warlock\'s Tabard',
        Hands = 'Dvt. Mitts +1',
        Ring1 = 'Aqua Ring',
        Ring2 = 'Aqua Ring',
        Back = 'Prism Cape',
        Waist = 'Penitent\'s rope',
        Legs = 'Nashira Seraweels',
        Feet = 'Duelist\'s Boots +1'
    },
	
    ['MndEnfeebling'] = {
        Head = 'Dls. Chapeau +1',
        Neck = 'Promise Badge', 
        Ear1 = 'Cmn. Earring',
        Ear2 = 'Coral Earring',
        Body = 'Mahatma Hpl.',
        Hands = 'Dvt. Mitts +1',
        Ring1 = 'Aqua Ring',
        Ring2 = 'Aqua Ring',
        Back = 'Prism Cape',
        Waist = 'Penitent\'s rope',
        Legs = 'Mahatma Slops',
        Feet = 'Duelist\'s Boots +1'
    },

    ['IntEnfeebling'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Dls. Chapeau +1',
        Neck = 'Enfeebling Torque', 
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring +1',
        Body = 'Warlock\'s Tabard',
        Hands = 'Duelist\'s Gloves',
        Ring1 = 'Snow Ring',
        Ring2 = 'Snow Ring',
        Back = 'Prism Cape',
        Waist = 'Penitent\'s rope',
        Legs = 'Mahatma Slops',
        Feet = 'River gaiters'
    },
	
    ['AccEnfeebling'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Dls. Chapeau +1',
        Neck = 'Enfeebling Torque', 
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring',
        Body = 'Warlock\'s Tabard',
        Hands = 'Duelist\'s Gloves',
        Ring1 = 'Snow Ring',
        Ring2 = 'Snow Ring',
        Back = 'Prism Cape',
        Waist = 'Penitent\'s rope',
        Legs = 'Nashira Seraweels',
        Feet = 'River gaiters'
    },

    ['Nuking'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Warlock\'s Chapeau',
        Neck = 'Elemental Torque',
        Ear1 = 'Moldavite Earring',
        Ear2 = 'Morion Earring +1',
        Body = 'Mahatma Hpl.',
        Hands = 'Zenith Mitts',
        Ring1 = 'Snow Ring',
        Ring2 = 'Snow Ring',
        Back = 'Prism Cape',
        Waist = 'Penitent\'s rope',
        Legs = 'Mahatma Slops',
        Feet = 'Duelist\'s Boots +1'
    },
	
    ['TP'] = {
		Main = 'Joyeuse',
        Sub = 'Genbu\'s Shield',
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Scp. Harness +1',
        Hands = 'Dusk Gloves',
        Ring1 = 'Toreador\'s ring',
        Ring2 = 'Rajas ring',
		Back = 'Forager\'s mantle',
        Waist = 'Swift Belt',
        Legs = 'Nashira Seraweels',
        Feet = 'Dusk Ledelsens'
    },
	   
	['Kclub'] = {
		Main = 'Enhancing Sword',
        Sub = 'Octave Club',
        Ear1 = 'Stealth Earring',
        Ring2 = 'Fencer\'s ring',
	},
	
    ['Savage'] = {
		Head = 'Opo-opo Crown',
        Neck = 'Soil Gorget',
        Ear1 = 'Coral Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Assault Jerkin',
		Hands = 'Ogre Gloves',
        Ring1 = 'Aqua Ring',
		Ring2 = 'Rajas Ring',
		Back = 'Forager\'s mantle',
        Waist = 'Warwolf Belt',
		Legs = 'Warlock\'s tights',
        Feet = 'Rutter Sabatons',
    },

    ['FastCast'] = {
        Head = 'Warlock\'s Chapeau',
        Ear1 = 'Loquac. Earring',
        Body = 'Duelist\'s Tabard'
    },

    ['HasteCast'] = {
        Ear1 = 'Loquac. Earring',
        Hands = 'Dusk Gloves', -- +3% haste
        Legs = 'Nashira Seraweels',
        Feet = 'Dusk Ledelsens', -- +2% haste
        Waist = 'Swift Belt' -- +4% haste
    },

    ['Sneaking'] = {
        Hands = 'Dream Mittens +1',
        Back = 'Skulker\'s Cape',
        Feet = 'Dream Boots +1'
    },

    ['Enhancing'] = {
        Neck = 'Enhancing Torque',
		Body = 'Glamor jupon',
        Hands = 'Duelist\'s Gloves',
        Legs = 'Warlock\'s Tights'
    },

    ['Enspell'] = {
		Main = 'Ceremonial dagger',
        Sub = 'Ceremonial dagger',
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Ear1 = 'Stealth Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Scp. Harness +1',
        Hands = 'Dusk Gloves',
        Ring1 = 'Toreador\'s ring',
        Ring2 = 'Fencer\'s ring',
		Back = '',
        Waist = 'Swift Belt',
        Legs = 'Nashira Seraweels',
        Feet = 'Dusk Ledelsens'
    },
	
    ['HPdown'] = {
        Head = 'Zenith crown',
        Neck = '',
        Body = 'Flora cotehardie',
        Hands = 'Zenith mitts',
        Ring1 = 'Ether ring',
        Ring2 = '',
		Back = '',
        Waist = 'Penitent\'s rope',
        Legs = 'Zenith slacks',
        Feet = 'Zenith pumps'
    },
	
    ['DarkMagic'] = {
		Body = 'Glamor jupon',
		Hands = 'Crimson Fng. Gnt.',
		Ring1 = 'Overlord\'s ring',
        Legs = 'Nashira Seraweels',
    },	

    ['Enmity'] = {
        Ammo = 'Happy Egg',
		Head = 'Baron\'s Chapeau',
		Neck = 'Harmonia\'s torque',
        Body = 'Dst. Harness +1',
		Hands = 'Dst. mittens +1',
		Ear1 = 'Titanis Earring',
		Ear2 = 'Magnetic Earring',
        Ring2 = 'Bomb Queen Ring',
        Waist = 'Warwolf Belt',
		Back = 'Resentment cape',
		Legs = 'Dst. subligar +1',
        Feet = 'Dst. leggings +1',
    },

    ['PlusMP'] = {-- 999 with this set on to 872 in refresh idle, 698 after standing up from resting
        Main = '',
        Sub = '', 
        Ammo = 'Hedgehog Bomb', -- +30 mp
        Head = 'Zenith Crown', -- +50 mp
        Neck = 'Uggalepih Pendant', -- +20 mp
        Ear1 = 'Loquac. Earring', -- +30 mp
        Ear2 = 'Magnetic Earring', -- +20 mp
        Body = 'Dalmatica', -- +50 mp
        Hands = 'Zenith mitts', -- +50 mp
        Ring1 = 'Ether Ring', -- +30 mp
        Ring2 = 'Bomb Queen Ring', -- +75 HP
        Back = 'Astute Cape', -- +8 mp
        Waist = 'Hierarch Belt', -- +48 mp
        Legs = 'Blood cuisses', -- +50 mp
        Feet = 'Zenith pumps' -- - +50 mp
    },

    ['MDT'] = {
        Head = 'Coral Visor +1',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Hands = 'Duelist\'s Gloves',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Hexerei Cape',
        Legs = 'Coral Cuisses +1',
        Feet = 'Coral Greaves +1',
    },

    ['PDT'] = {
        Main = 'Terra\'s Staff',
        Ammo = 'Happy Egg',
		Head = 'Darksteel cap +1',
        Neck = 'Promise Badge', 
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dst. Harness +1',
		Hands = 'Dst. mittens +1',
        Ring1 = 'Jelly Ring',
        Ring2 = 'Bomb Queen Ring',
        Back = 'Hexerei Cape',
        Waist = 'Warwolf Belt',
		Legs = 'Dst. subligar +1',
        Feet = 'Dst. leggings +1',
    },

};

profile.Sets = Sets;

profile.Packer = {
};

profile.OnLoad = function()
	local player = gData.GetPlayer();
    gSettings.AllowAddSet = true;
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind M /map');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 /lac fwd toggleLac');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 /fillmode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /lac disable main');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind z //sneak <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind x //invisible <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind c //stoneskin me');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind v //blink me');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind q /lac fwd swordMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind e /lac fwd Tank');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind r /lac fwd plusmp');
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind M');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F10');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind z');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind x');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind c');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind v');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind q');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind e');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind r');
end

-- Method that cycles through player abilities to match the correct ability for recast time
profile.GetRecastTimer = function(abilityRecastId)
    local memRecast  = AshitaCore:GetMemoryManager():GetRecast();
    
    if (abilityRecastId == 0) then
        return memRecast:GetAbilityTimer(0);
    end
    
    -- Searches player's recasts
    for x = 0, 31 do
        local id = memRecast:GetAbilityTimerId(x);
        if (id == abilityRecastId) then
            return memRecast:GetAbilityTimer(x);
        end
    end
    
    -- if ability wasn't found 
    return -1;
end

-- Method that checks a list for a specific spell string, returns true if found
profile.CheckForSpell = function(spellList, castSpell)
    for _, spell in pairs(spellList) do
        if spell == castSpell then
            return true 
        end
    end
end

-- Method that checks passed element string and equips appropriate elemental staff
profile.EquipEleStaff = function(element, spellName)
    if (profile.CheckForSpell(Spells.Buffs, spellName)) then
        gFunc.Equip('Main', EleStaffTable["Earth"]);
        gFunc.Equip('Sub', '');
    elseif (not profile.CheckForSpell(Spells.EleDebuffs, spellName)) then
        gFunc.Equip('main', EleStaffTable[element]);
        gFunc.Equip('Sub', '');
    end
end

profile.EquipSprint = function()
    if (Settings.isFast) then
        gFunc.EquipSet(Sets.Sprint);
    end
end

profile.CheckCity = function(loc)
    if (string.match(loc, "Bastok")) or (string.match(loc, "Metalworks")) then

    elseif (string.match(loc, "Windurst")) or (string.match(loc, "Heavens Tower")) then

    elseif (string.match(loc, "San d\'Oria")) or (string.match(loc, "d\'Oraguille")) then

    end
end

profile.EquipMP = function(player)
    if ((Settings.isMP) and (player.MP < 836)) then
        gFunc.EquipSet(Sets.Idle);
    elseif (Settings.isMP) then
        gFunc.EquipSet(Sets.PlusMP);
    end
end

-- Sub job function for platte swaps
profile.CheckPalette = function(sub)
	if (sub and not Settings.Subjob[sub]) then
		if (sub == 'WHM') then
			AshitaCore:GetChatManager():QueueCommand(-1, '/tb palette change Base');
		elseif (sub == 'BLM') then
			AshitaCore:GetChatManager():QueueCommand(-1, '/tb palette change blm');
		elseif (sub == 'NIN') then
			AshitaCore:GetChatManager():QueueCommand(-1, '/tb palette change nin');
		elseif (sub == 'WAR') then
			AshitaCore:GetChatManager():QueueCommand(-1, '/tb palette change war');
		elseif (sub == 'DRK') then
			AshitaCore:GetChatManager():QueueCommand(-1, '/tb palette change drk');
		end
		for sub in pairs(Settings.Subjob) do
			sub = false;
		end
		Settings.Subjob[sub] = true;
	end
end	

profile.HandleCommand = function(args)
    if (args[1] and args[1]:lower() == 'togglelac') then
        if (isEnabled) then
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable');
            isEnabled = false;
        else
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable');
            isEnabled = true;
        end
    end
	--Enhancing Sword Toggle
    if (args[1] == 'swordMode') then
        if (Settings.swordMode == 1) then
            gFunc.Echo(158, "Enhancing Sword Mode OFF")
            Settings.swordMode = 0
        else
            gFunc.Echo(158, "Enhancing Sword Mode ON")
            Settings.swordMode = 1
        end
    end	
	
	--ZDPS Toggle
    if (args[1] == 'Tank') then
        if (Settings.tank == 1) then
            gFunc.Echo(158, "Tank Mode OFF")
            Settings.tank = 0
        else
            gFunc.Echo(158, "Tank Mode ON")
            Settings.tank = 1
        end
    end
	
	-- PlusMp toggle
    if (args[1] == 'plusmp') then
        if (Settings.isMP == true) then
            Settings.isMP = false;
            gFunc.Echo(158, 'Plus MP set OFF');
        else
            Settings.isMP = true;
            gFunc.Echo(158, 'Plus MP set ON');
        end
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local loc = gData.GetEnvironment().Area;
	local EnspellID = T{94, 95, 96, 97, 98, 99};

	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
		
	local function GetEnSpellActive()
		local buffs = AshitaCore:GetMemoryManager():GetPlayer():GetBuffs();
		for _,buff in ipairs(buffs) do
			if (EnspellID:contains(buff)) then
				return true;
			end
		end
		return false;
	end
    if (player.Status ==  'Engaged') then
        gFunc.EquipSet(Sets.TP); 
        Settings.RestTimer = 0;
		if GetEnSpellActive() == true then
			if Settings.swordMode == 1 then
				gFunc.EquipSet(Sets.Kclub);
			end
			if (player.HP > 965) then
				gFunc.EquipSet(Sets.HPdown);
			end
		end
		if Settings.tank == 1 then
			gFunc.EquipSet(Sets.PDT);
		end
    elseif (player.Status == 'Resting') then
        if Settings.RestTimer == 0 then
			Settings.RestTimer = os.clock() + 18;
        end
        if (os.clock() > Settings.RestTimer) then
            gFunc.EquipSet(Sets.Resting);
        end
	else
		gFunc.EquipSet(Sets.Idle); 
		Settings.RestTimer = 0;
	end
    if (player.Status ~= 'Resting') then 
        profile.EquipMP(player);
    end
	if Settings.tank == 1 then
		gFunc.EquipSet(Sets.PDT);
	end
    profile.CheckCity(loc);
	profile.CheckPalette(player.SubJob);
	
end

profile.HandleAbility = function()
    local action = gData.GetAction();
    local distance = tonumber(('%.1f'):fmt(math.sqrt(gData.GetActionTarget().Distance)));
    local ability = AshitaCore:GetResourceManager():GetAbilityByName(action.Name, 2);
    local abilityCooldown = profile.GetRecastTimer(ability.RecastTimerId)/60;
    
    if((abilityCooldown < 0.6) and (distance <= ability.Range)) then
        if (ability.Name[3] == "Convert") then
            Settings.isMP = true;
            gFunc.EquipSet(Sets.PlusMP);
        end
    end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer();
    local action = gData.GetAction();
	local distance = tonumber(('%.1f'):fmt(gData.GetActionTarget().Distance));
    local spellCooldown = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(action.Id)/60;

    if ((spellCooldown < 0.6) and (distance <= 20.4) and not (Settings.isMP)) then
        -- Precast equips FastCast set and switches into appropriate set during HandleMidcast method
        gFunc.EquipSet(Sets.FastCast);
    elseif ((Settings.isMP) and (player.MP < 873)) then
        gFunc.EquipSet(Sets.FastCast);
    end

end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local action = gData.GetAction();
	local distance = tonumber(('%.1f'):fmt(gData.GetActionTarget().Distance));
    local spell = AshitaCore:GetResourceManager():GetSpellById(action.Id);
    local spellCooldown = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(action.Id)/60;

    if ((spellCooldown < 0.6) and (distance <= 20.4) and ((not Settings.isMP) or (Settings.isMP and (player.MP < 873))) ) then

        -- Buffs 
        if (profile.CheckForSpell(Spells.Buffs, action.Name) and not (string.match(action.Name, "Stoneskin"))) then
            gFunc.EquipSet(Sets.HasteCast);
			
        -- Stoneskin
        elseif (string.match(action.Name, "Stoneskin")) then
            gFunc.EquipSet(Sets.MndEnfeebling);
			if Settings.tank == 1 then
				gFunc.EquipSet(Sets.PDT);
			end

        -- Mnd Enfeebling
        elseif (profile.CheckForSpell(Spells.MndEnfeebling, action.Name)) then
            gFunc.EquipSet(Sets.MndEnfeebling);
			if (conquest.settings.regionControl == false) then
				gFunc.Equip('hands', 'Mst.Cst. Bracelets');
			end
			
        -- Mnd Skill
        elseif (profile.CheckForSpell(Spells.MndSkill, action.Name)) then
            gFunc.EquipSet(Sets.MndSkill);

        -- Int Enfeebling
        elseif (profile.CheckForSpell(Spells.IntEnfeebling, action.Name)) then
            gFunc.EquipSet(Sets.IntEnfeebling);
			if (conquest.settings.regionControl == false) then
				gFunc.Equip('hands', 'Mst.Cst. Bracelets');
			end
			if Settings.tank == 1 then
				gFunc.EquipSet(Sets.Enmity);
			end

        -- Acc Enfeebling
        elseif (profile.CheckForSpell(Spells.AccEnfeebling, action.Name)) then
            gFunc.EquipSet(Sets.AccEnfeebling);
			if (conquest.settings.regionControl == false) then
				gFunc.Equip('hands', 'Mst.Cst. Bracelets');
			end
			if Settings.tank == 1 then
				gFunc.EquipSet(Sets.Enmity);
			end
						
		-- Shadows
		elseif (action.Name == 'Utsusemi: Ichi') or (action.Name == 'Utsusemi: Ni') then
			gFunc.EquipSet(Sets.HasteCast)
			
        -- Sneak/Invis
        elseif (profile.CheckForSpell(Spells.Sneaking, action.Name)) then
            gFunc.EquipSet(Sets.Sneaking);
			
        -- Healing-
        --elseif (profile.CheckForSpell(Spells.Healing, action.Name)) then
        elseif Spells.Healing:contains(action.Name) then
            gFunc.EquipSet(Sets.Healing);
			if Settings.tank == 1 then
				gFunc.EquipSet(Sets.Enmity);
			end
			
        -- Enhancing
        elseif ((string.match(action.Name, "Bar")) or profile.CheckForSpell(Spells.Enhancing, action.Name)) then
            gFunc.EquipSet(Sets.MndEnfeebling);
            gFunc.EquipSet(Sets.Enhancing);

        -- Nuking
        elseif ((action.Skill == 'Elemental Magic') ~= (profile.CheckForSpell(Spells.EleDebuffs, action.Name)) ~= (profile.CheckForSpell(Spells.Dark, action.Name))) then
            gFunc.EquipSet(Sets.Nuking);
            if (action.MppAftercast < 51) then
            gFunc.Equip('neck', 'Uggalepih pendant')
			end
			if (conquest.settings.regionControl == false) then
				gFunc.Equip('hands', 'Mst.Cst. Bracelets');
			end
		
		-- Dark
		elseif (profile.CheckForSpell(Spells.Dark, action.Name)) then
			gFunc.EquipSet(Sets.DarkMagic)
		
        -- Defaults to idle set if the check falls through somehow
        else 
            gFunc.EquipSet(Sets.Idle);
        end

        -- Equips appropriate Elemental Staff
        profile.EquipEleStaff(action.Element, action.Name);
		if Settings.tank == 1 then
			gFunc.Equip('main', 'Terra\'s staff')
		end
	else
        profile.EquipEleStaff(action.Element, action.Name);
		if Settings.tank == 1 then
			gFunc.Equip('main', 'Terra\'s staff')
		end
	end
	
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
	local action = gData.GetAction();
	if (action.Name == 'Savage Blade') then
		gFunc.EquipSet(Sets.Savage);
	end
	if (action.Name == 'Skullbreaker') then
		gFunc.EquipSet(Sets.TP);
	end
end

return profile;