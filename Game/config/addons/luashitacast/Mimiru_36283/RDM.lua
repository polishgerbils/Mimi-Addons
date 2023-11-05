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
    ['Fire'] = 'Fire Staff',
    ['Earth'] = 'Terra\'s Staff',
    ['Water'] = 'Water Staff',
    ['Wind'] = 'Wind Staff',
    ['Ice'] = 'Aquilo\'s Staff',
    ['Thunder'] = 'Jupiter\'s Staff',
    ['Light'] = 'Light Staff',
    ['Dark'] = 'Pluto\'s Staff'
};

local Spells = {
    Healing = T{"Cure", "Cure II", "Cure III", "Cure IV", "Curaga", "Curaga II", "Erase"},

    MndEnfeebling = {"Slow", "Slow II", "Paralyze", "Paralyze II", "Poison", "Poison II", "Banish", "Banish II"},

    IntEnfeebling = {"Sleep", "Sleep II", "Bind", "Gravity", "Blind", "Blaze Spikes", "Ice Spikes",
        "Shock Spikes"},
		
	Dark = {"Bio", "Bio II", "Drain", "Aspir"},
	 
    EleDebuffs = {"Rasp", "Drown", "Frost", "Burn", "Choke", "Shock"},

    Enhancing = {"Phalanx", "Stoneskin", "Enthunder", "Enstone", "Enaero"},
	    
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
        Head = 'Duelist\'s Chapeau',
        Neck = 'Uggalepih pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = {'Magnetic Earring', 'Morion Earring'},
        Body = {'Duelist\'s Tabard', 'Savage separates'},
        Hands = 'Duelist\'s Gloves',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Hexerei Cape',
        Waist = {'Hierarch Belt', 'Swift belt'},
        Legs = {'Blood cuisses', 'Savage loincloth'},
        Feet = {'River gaiters', 'Mannequin Pumps'},
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
        Waist = 'Penitent\'s rope',
        Legs = 'Warlock\'s Tights',
        Feet = 'River gaiters'
    },

    ['Resting_Priority'] = {
        Main = {'Pluto\'s Staff', 'Pilgrim\'s wand'},
		Neck = 'Checkered Scarf',
        Ear1 = 'Relaxing Earring',
	    Ear2 = 'Magnetic Earring',
        Body = 'Errant Hpl.',
        Waist = 'Duelist\'s Belt',
        Back = 'Rainbow Cape',
        Legs = 'Baron\'s slops',
    },

    ['MndEnfeebling'] = {
        Head = 'Duelist\'s Chapeau',
        Neck = 'Enfeebling Torque', 
        Ear1 = 'Cmn. Earring',
        Ear2 = 'Coral Earring',
        Body = 'Warlock\'s Tabard',
        Hands = 'Savage gauntlets',
        Ring1 = 'Aqua Ring',
        Ring2 = 'Aqua Ring',
        Back = 'Rainbow Cape',
        Waist = 'Penitent\'s rope',
        Legs = 'Mahatma Slops',
        Feet = 'Duelist\'s Boots +1'
    },

    ['IntEnfeebling'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Duelist\'s Chapeau',
        Neck = 'Enfeebling Torque', 
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring',
        Body = 'Warlock\'s Tabard',
        Hands = 'Duelist\'s Gloves',
        Ring1 = 'Snow Ring',
        Ring2 = 'Snow Ring',
        Back = {'Rainbow Cape', 'Red Cape'},
        Waist = 'Penitent\'s rope',
        Legs = 'Mahatma Slops',
        Feet = 'River gaiters'
    },

    ['Nuking'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Warlock\'s Chapeau',
        Neck = 'Elemental Torque',
        Ear1 = 'Moldavite Earring',
        Ear2 = 'Morion Earring',
        Body = 'Errant Hpl.',
        Hands = 'Zenith Mitts',
        Ring1 = 'Snow Ring',
        Ring2 = 'Snow Ring',
        Back = {'Rainbow Cape', 'Red Cape'},
        Waist = 'Penitent\'s rope',
        Legs = 'Mahatma Slops',
        Feet = 'Duelist\'s Boots +1'
    },
	
    ['TP'] = {
		Main = 'Joyeuse',
        Sub = 'Genbu\'s Shield',
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Ear1 = 'Coral Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Assault Jerkin',
        Hands = 'Dusk Gloves',
        Ring1 = 'Toreador\'s ring',
        Ring2 = 'Rajas Ring',
		Back = 'Forager\'s mantle',
        Waist = 'Swift Belt',
        Legs = 'Duelist\'s tights',
        Feet = 'Dusk Ledelsens'
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
        Hands = 'Dusk Gloves', -- +3% haste
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
        Body = 'Duelist\'s Tabard',
        Hands = 'Dusk Gloves',
        Ring1 = 'Toreador\'s ring',
        Ring2 = 'Fencer\'s ring',
		Back = '',
        Waist = 'Swift Belt',
        Legs = 'Duelist\'s tights',
        Feet = 'Dusk Ledelsens'
    },
	
    ['HPdown'] = {
        Head = 'Zenith crown',
        Neck = 'Star necklace',
        Body = 'Assault jerkin',
        Hands = 'Zenith mitts',
        Ring1 = 'Ether ring',
        Ring2 = '',
		Back = '',
        Waist = 'Penitent\'s rope',
        Legs = 'Zenith slacks',
        Feet = 'Errant pigaches'
    },
	
    ['DarkMagic'] = {
		Body = 'Glamor jupon',
    },	

    ['Enmity'] = {

    },

    ['PlusMP'] = {
        Main = '',
        Sub = '', 
        Ammo = 'Hedgehog Bomb', -- +30 mp
        Head = 'Warlock\'s Chapeau', -- 20 mp
        Neck = '',
        Body = 'Warlock\'s Tabard', -- +14 mp
        Hands = 'Errant Cuffs', -- -20 hp +20 mp
        Ring1 = 'Tamas Ring', -- 30mp
        Ring2 = 'Peace Ring', -- 10 hp>mp
        Back = '',
        Waist = 'Hierarch Belt', -- +48 mp
        Legs = 'Savage loincloth', -- +32 mp
        Feet = 'Errant Pigaches' -- -20hp +20mp
    },

    ['MDT'] = {
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Gramary Cape',
        Hands = 'Duelist\'s Gloves',
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
    if (args[1] and args[1]:lower() == 'togglelac') then
        if (isEnabled) then
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable');
            isEnabled = false;
        else
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable');
            isEnabled = true;
        end
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local loc = gData.GetEnvironment().Area;
	local EnspellID = T{96, 97};

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
			gFunc.EquipSet(Sets.Enspell);
			if (player.HP > 899) then
				gFunc.EquipSet(Sets.HPdown);
			end
		end
    elseif (player.Status == 'Resting') then
        if Settings.RestTimer == 0 then
            Settings.RestTimer = os.clock() + 18;
        end

        if (os.clock() > Settings.RestTimer) then
            gFunc.EquipSet(Sets.Resting);
            if (player.SubJob == 'BLM') then
                gFunc.Equip('Back', 'Wizard\'s mantle');
            end
        end
    else
        gFunc.EquipSet(Sets.Idle); 
		--gFunc.LockStyle(Sets.Style);
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

    -- TODO gate for mp amount before equipping fast cast set so plusMP set can maintain extra mp after convert

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
         -- TODO same mp gate function as in HandlePrecast method before moving on
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
        elseif ((profile.CheckForSpell(Spells.IntEnfeebling, action.Name)) or (profile.CheckForSpell(Spells.EleDebuffs, action.Name))) then
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
end

return profile;