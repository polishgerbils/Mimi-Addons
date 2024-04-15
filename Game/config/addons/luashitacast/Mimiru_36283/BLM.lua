local profile = {};

local Settings = {
    isFast = false,
    isMDT = false,
    isPDT = false,
	isEnabled = false,
    Subslot = 'Default',
    RestTimer = 0,
    CurrentLevel = 0,
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

    MndEnfeebling = {"Slow", "Slow II", "Paralyze", "Paralyze II", "Poison", "Poison II", "Banish", "Banish II"},

    IntEnfeebling = {"Sleep", "Sleep II", "Sleepga", "Sleepga II", "Bind", "Gravity", "Blind", "Blaze Spikes", "Ice Spikes",
        "Shock Spikes"},
		
	Dark = {"Bio", "Bio II", "Drain", "Aspir"},
	 
    EleDebuffs = {"Rasp", "Drown", "Frost", "Burn", "Choke", "Shock"},

    Enhancing = {"Phalanx", "Stoneskin", "Enaero", "Enaero II", "Enfire", "Enfire II",
        "Enstone", "Enstone II", "Enthunder", "Enthunder II", "Enwater", "Enwater II",
        "Enblizzard", "Enblizzard II"},
    
    Buffs = {"Protect", "Protect II", "Protect III", "Protect IV", "Protectra", "Protectra II", "Protectra III",
     "Protectra IV", "Protectra V", "Shell", "Shell II", "Shell III", "Shell IV", "Shellra", "Shellra II",
     "Shellra III", "Shellra IV", "Shellra V", "Haste", "Refresh", "Aquaveil", "Blink"},

    Sneaking = {"Sneak", "Invisible"}
}

local Sets = {
		
    ['Idle_Priority'] = {
        Main = 'Terra\'s Staff',
        Sub = '',
        Ammo = 'Phtm. Tathlum',
        Head = 'Wizard\'s petasos',
		Neck = {'Uggalepih pendant', 'Checkered Scarf'},
        Ear1 = {'Loquac. Earring', 'Morion Earring'},
        Ear2 = {'Magnetic Earring', 'Morion Earring'},
        Body = {'Dalmatica', 'Wizard\'s coat'},
        Hands = {'Sorcerer\'s gloves','Wizard\'s gloves'},
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Hexerei cape',
        Waist = {'Hierarch Belt', 'Swift belt'},
        Legs = 'Nashira Seraweels',
        Feet = {'River gaiters'},
    },

    ['Healing'] = {
	    Ammo = 'Hedgehog Bomb',
        Neck = 'Justice badge',
        Body = 'Errant Hpl.',
        Ear2 = 'Loquac. Earring',
        Hands = 'Savage gauntlets',
        Ring1 = 'Aqua Ring',
        Ring2 = 'Aqua Ring',
        Back = 'Rainbow Cape',		
        Waist = 'Swift Belt',
        Legs = 'Mahatma Slops',
        Feet = 'River gaiters'
    },

    ['Resting_Priority'] = {
        Main = {'Pluto\'s Staff', 'Pilgrim\'s wand'},
        Head = 'Wizard\'s petasos',
		Neck = 'Checkered Scarf',
        Ear1 = 'Relaxing Earring',
	    Ear2 = 'Magnetic Earring',
        Body = {'Errant Hpl.', 'Seer\'s tunic +1'},
        Waist = 'Hierarch Belt',
        Back = 'Rainbow Cape',
        Legs = 'Baron\'s slops',
    },

    ['MndEnfeebling'] = {
        Head = 'Igqira tiara',
        Neck = 'Enfeebling Torque', 
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Body = 'Wizard\'s coat',
        Hands = 'Savage gauntlets',
        Ring1 = 'Aqua Ring',
        Ring2 = 'Aqua Ring',
        Back = 'Rainbow Cape',
        Waist = 'Penitent\'s rope',
        Legs = 'Mahatma Slops',
        Feet = 'River gaiters'
    },

    ['IntEnfeebling'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Igqira tiara',
        Neck = 'Enfeebling Torque', 
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring',
        Body = 'Wizard\'s coat',
        Hands = '',
        Ring1 = 'Snow Ring',
        Ring2 = 'Snow Ring',
        Back = 'Rainbow Cape',
        Waist = 'Penitent\'s rope',
        Legs = 'Nashira Seraweels',
        Feet = 'River gaiters'
    },

    ['Nuking'] = {
        Ammo = '',
        Head = 'Wizard\'s petasos',
		Neck = 'Elemental torque',
        Ear1 = 'Moldavite Earring',
        Ear2 = 'Morion Earring',
        Body = 'Igqira Weskit',
        Hands = 'Zenith mitts',
        Ring1 = 'Snow Ring',
        Ring2 = 'Snow Ring',
        Back = 'Rainbow cape',
        Waist = 'Penitent\'s rope',
        Legs = 'Mahatma Slops',
        Feet = 'River gaiters',
    },
	
    ['EleSkill'] = {
		Head = 'Sorcerer\'s petas.',
		Neck = 'Elemental torque',
        Body = 'Errant Hpl.',
        Hands = 'Wizard\'s gloves',
    },
	
    ['FastCast'] = {
        Ear1 = 'Loquac. Earring',
		Feet = 'Rostrum pumps',
    },

    ['HasteCast'] = {
        Waist = 'Swift Belt' -- +4% haste
    },

    ['Sneaking'] = {
        Hands = 'Dream Mittens +1',
        Back = 'Skulker\'s Cape',
        Feet = 'Dream Boots +1'
    },

    ['Enhancing'] = {
        Neck = 'Enhancing Torque',
    },
	
    ['DarkMagic'] = {
		Hands = 'Sorcerer\'s gloves',
		Legs = 'Wizard\'s tonban',
    },	

    ['Enmity'] = {
	    Ammo = 'Hedgehog Bomb',
        Head = 'Wizard\'s petasos',
		Ear2 = 'Novia earring',
        Body = 'Errant Hpl.',
        Hands = 'Sorcerer\'s gloves',
        Waist = 'Penitent\'s rope',
        Legs = 'Mahatma Slops',
		Feet = 'Sorcerer\'s sabbots', 
    },

    ['MDT'] = {
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Gramary Cape',
        Legs = 'Coral Cuisses +1',
    },

    ['PDT'] = {
        Main = 'Terra\'s Staff',
        Back = 'Cheviot Cape'
    },

};

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind M /map');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 /lac fwd toggleLac');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 /fillmode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /lac disable main');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind q /lac fwd enmityMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind e /lac fwd skillMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind z //sneak <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind x //invisible <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind c //stoneskin me');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind v //blink me');
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
    else
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
        gFunc.Equip('Body', "Republic Aketon");
    elseif (string.match(loc, "Windurst")) or (string.match(loc, "Heavens Tower")) then
        gFunc.Equip('Body', 'Tanner\'s apron')
		gFunc.Equip('Hands', 'Tanner\'s gloves')
    elseif (string.match(loc, "San d\'Oria")) or (string.match(loc, "d\'Oraguille")) then
        gFunc.Equip('Body', 'Tanner\'s apron')
		gFunc.Equip('Hands', 'Tanner\'s gloves')
    end
end



profile.HandleCommand = function(args)
	-- Lac toggle
    if (args[1] and args[1]:lower() == 'togglelac') then
        if (isEnabled) then
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable');
            isEnabled = false;
        else
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable');
            isEnabled = true;
        end
    end

	--Enmity Mode Toggle
    if (args[1] == 'enmityMode') then
        if (Settings.enmityMode == 1) then
            gFunc.Echo(158, "Enmity Mode OFF")
            Settings.enmityMode = 0
        else
            gFunc.Echo(158, "Enmity Mode ON")
            Settings.enmityMode = 1
        end
    end	
	
	--Skill Mode Toggle
    if (args[1] == 'skillMode') then
        if (Settings.skillMode == 1) then
            gFunc.Echo(158, "Skill Mode OFF")
            Settings.skillMode = 0
        else
            gFunc.Echo(158, "Skill Mode ON")
            Settings.skillMode = 1
        end
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local loc = gData.GetEnvironment().Area;

	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
	
    if (player.Status ==  'Engaged') then
        gFunc.EquipSet(Sets.TP); 
        Settings.RestTimer = 0;
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
    profile.CheckCity(loc);
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer();
    local action = gData.GetAction();
    local distance = tonumber(('%.1f'):fmt(math.sqrt(gData.GetActionTarget().Distance)));
    local spellCooldown = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(action.Id)/60;

    if((spellCooldown < 0.6) and (distance <= 20.4)) then
        -- Precast equips FastCast set and switches into appropriate set during HandleMidcast method
		gFunc.EquipSet(Sets.FastCast);
    end

end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local distance = tonumber(('%.1f'):fmt(math.sqrt(gData.GetActionTarget().Distance)));
    local spell = AshitaCore:GetResourceManager():GetSpellById(action.Id);
    local spellCooldown = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(action.Id)/60;

    if ((spellCooldown < 0.6) and (distance <= 20.4)) then
        -- Buffs 
        if (profile.CheckForSpell(Spells.Buffs, action.Name) and not (string.match(action.Name, "Stoneskin"))) then
            gFunc.EquipSet(Sets.HasteCast);

        -- Mind Enfeebling
        elseif (profile.CheckForSpell(Spells.MndEnfeebling, action.Name)) then
            gFunc.EquipSet(Sets.MndEnfeebling);
			if (conquest.settings.regionControl == false) then
				gFunc.Equip('hands', 'Mst.Cst. Bracelets');
			end

        -- Int Enfeebling
        elseif ((profile.CheckForSpell(Spells.IntEnfeebling, action.Name))) then
            gFunc.EquipSet(Sets.IntEnfeebling);
			if (conquest.settings.regionControl == false) then
				gFunc.Equip('hands', 'Mst.Cst. Bracelets');
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
			if Settings.enmityMode == 1 then
				if Settings.skillMode == 1 then
					gFunc.EquipSet(Sets.EleSkill);
				end
				gFunc.EquipSet(Sets.Enmity);
			else 
				if Settings.skillMode == 1 then
					gFunc.EquipSet(Sets.EleSkill);
				end
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
    end

end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;