local profile = {};

local Settings = {
    CurrentLevel = 0,
	isEnabled = false
};

local sets = {

	Style = {
		Head = 'Opo-opo Crown',
		Body = 'Homam corazza',
        Hands = 'Homam manopolas',
		Legs = 'Coral subligar',
		Feet = 'Homam gambieras',

	},
	
	['Idle_Priority'] = {
		Head = 'Darksteel cap +1',
		Neck = 'Evasion torque',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Dst. Harness +1',
        Hands = 'Dst. mittens +1',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
		Back = 'Resentment cape',
        Waist = 'Scouter\'s rope',
		Legs = 'Dst. subligar +1',
        Feet = 'Strider Boots',
	},
	
	['TP_Priority'] = {
        Head = {'Homam zucchetto', 'Empress Hairpin'},
        Neck = 'Love Torque',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Rapparee harness',
        Hands = 'Homam manopolas',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
		Back = 'Forager\'s mantle',
        Waist = 'Swift belt',
		Legs = 'Homam cosciales',
        Feet = {'Homam gambieras', 'Bounding Boots'},
    },
	
    ['Eva'] = {
		Range = 'Ungur boomerang',
		Head = 'Optical hat',
		Neck = 'Evasion torque',
		Ear1 = 'Stealth earring',
		Ear2 = 'Novia earring',
		Body = 'Scp. Harness +1',
        Waist = 'Scouter\'s rope',
		Back = 'Boxer\'s mantle',
    },
	
	['Haste'] = {
        Head = 'Homam zucchetto',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Body = 'Rapparee harness',
        Hands = 'Homam manopolas',
        Waist = 'Swift Belt',
		Legs = 'Homam cosciales',
		Feet = 'Homam gambieras',
	},
	
	['Precast'] = {
		Head = 'Optical hat',
		Neck = 'Evasion torque',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
		Body = 'Scp. Harness +1',
        Hands = 'Dst. mittens +1',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
        Waist = 'Scouter\'s rope',
		Legs = 'Dst. subligar +1',
        Feet = 'Dst. leggings +1',
	},
	
    ['WS_Priority'] = {
        Head = 'Assassin\'s bonnet',
        Neck = 'Love Torque',
        Ear1 = 'Genin Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Dragon harness',
		Hands = 'Hecatomb mittens',
        Ring1 = 'Thunder Ring',
        Ring2 = 'Rajas Ring',
		Back = 'Assassin\'s cape',
        Waist = 'Warwolf belt',
        Legs = 'Dragon subligar',
        Feet = 'Hct. leggings',
    },
	
    ['Multi_Priority'] = {
        Head = 'Optical hat',
        Neck = 'Love Torque',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Dragon harness',
		Hands = 'Hecatomb mittens',
        Ring1 = 'Kshama ring no.2',
        Ring2 = 'Rajas Ring',
		Back = 'Forager\'s mantle',
        Waist = 'Warwolf belt',
        Legs = 'Dragon subligar',
        Feet = 'Hct. leggings',
    },
	
    ['Dex'] = {
        Head = 'Assassin\'s bonnet',
        Neck = 'Love Torque',
        Body = 'Dragon harness',
		Hands = 'Rogue\'s Armlets',
        Ring1 = 'Thunder ring',
        Ring2 = 'Rajas Ring',
		Back = 'Assassin\'s cape',
        Waist = 'Warwolf belt',
        Legs = 'Dragon subligar',
        Feet = 'Hct. leggings',
    },
	
    ['Agi'] = {
        Head = 'Empress Hairpin',
        Ear1 = 'Drone Earring',
        Ear2 = 'Genin Earring',
        Body = 'Dragon harness',
		Back = 'Assassin\'s cape',
        Waist = 'Scouter\'s rope',
        Legs = 'Rogue\'s culottes',
        Feet = 'Bounding Boots',
    },
	
    ['Range'] = {
        Head = 'Optical hat',
        Neck = 'Peacock Amulet',
        Ear1 = 'Drone Earring',
        Ear2 = 'Genin Earring',
        Body = 'Dragon harness',
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
		Back = 'Assassin\'s cape',
        Waist = 'Scouter\'s rope',
        Legs = 'Rogue\'s culottes',
        Feet = 'Homam gambieras',
    },
	
    ['Steal'] = {
		Hands = 'Thief\'s kote',
        Legs = 'Assassin\'s culottes',
        Feet = 'Rogue\'s poulaines',
    },
	
    ['TH'] = {
        Neck = 'Nanaa\'s charm',
		Hands = 'Assassin\'s armlets',
    },
		
    ['sneakvis'] = {
        Hands = 'Dream Mittens +1',
        Feet = 'Dream Boots +1',
    },
	
};

profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind M /map');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 /lac fwd toggleLac');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 /fillmode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /lac disable main');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind q /lac fwd TH');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind e /lac fwd Eva');
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind M');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F10');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind q');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind e');
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
	--Treasure Hunter Toggle
    if (args[1] == 'TH') then
        if (Settings.TH == 1) then
            gFunc.Echo(158, "Treasure Hunter OFF")
            Settings.TH = 0
        else
            gFunc.Echo(158, "Treasure Hunter ON")
            Settings.TH = 1
        end
    end	
	--Evasion Toggle
    if (args[1] == 'Eva') then
        if (Settings.Eva == 1) then
            gFunc.Echo(158, "Evasion set OFF")
            Settings.Eva = 0
        else
            gFunc.Echo(158, "Evasion set ON")
            Settings.Eva = 1
        end
    end	
end

profile.HandleDefault = function()
	local player = gData.GetPlayer();
	local env = gData.GetEnvironment();
    local loc = gData.GetEnvironment().Area;
	local SA = gData.GetBuffCount('Sneak Attack');
	local TA = gData.GetBuffCount('Trick Attack');
	local zone = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
		if (myLevel ~= Settings.CurrentLevel) then
			gFunc.EvaluateLevels(profile.Sets, myLevel);
			Settings.CurrentLevel = myLevel;
		end
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(profile.Sets.TP);
		if Settings.Eva == 1 then
			gFunc.EquipSet(profile.Sets.Eva)
			if Settings.TH == 1 then
				gFunc.EquipSet(profile.Sets.TH)
			end
		else
			if Settings.TH == 1 then
				gFunc.EquipSet(profile.Sets.TH)
			end
		end
		if (SA > 0) then
			if (TA > 0) then
				gFunc.EquipSet(profile.Sets.Agi)
			end
			gFunc.EquipSet(profile.Sets.Dex)
		else 
			if (TA > 0) then
				gFunc.EquipSet(profile.Sets.Agi)
			end
		end
		if (env.Day == 'Lightningday') then
			gFunc.Equip('Ring1', 'Lightning Ring');
		end
		if (player.SubJob == 'NIN') then
			gFunc.Equip('Ear1', 'Stealth Earring');
		end
		
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(profile.Sets.Resting);
	else
		gFunc.EquipSet(profile.Sets.Idle);
		gFunc.LockStyle(profile.Sets.Style);
		if Settings.TH == 1 then
			gFunc.EquipSet(profile.Sets.TH)
		end
	end
	profile.CheckCity(loc);
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	
	if (action.Name == 'Flee') then
		gFunc.Equip('Feet', 'Rogue\'s poulaines');
	elseif (action.Name == 'Steal') then
		gFunc.EquipSet(profile.Sets.Steal);
	elseif (action.Name == 'Mug') then
		gFunc.Equip('Head', 'Assassin\'s bonnet');
	end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	local action = gData.GetAction();
	if (action.Name == 'Tonko: Ichi') or (action.Name == 'Tonko: Ni') then
		gFunc.EquipSet(profile.Sets.sneakvis);
	elseif (action.Name == 'Utsusemi: Ichi') or (action.Name == 'Utsusemi: Ni') then
		gFunc.EquipSet(sets.Precast)
	end
end

profile.HandleMidcast = function()
	local action = gData.GetAction();
	if (action.Name == 'Utsusemi: Ichi') or (action.Name == 'Utsusemi: Ni') then
		gFunc.EquipSet(sets.Haste)
	end
end

profile.HandlePreshot = function()
	gFunc.EquipSet(profile.Sets.Range);
		
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
	local action = gData.GetAction();
	if (action.Name == 'Shark Bite') or (action.Name == 'Viper Bite') then
		gFunc.EquipSet(profile.Sets.WS);
	elseif (action.Name == 'Evisceration') or (action.Name == 'Dancing Edge') then
		gFunc.EquipSet(profile.Sets.Multi);
		gFunc.Equip('Neck', 'Soil Gorget');
	end
	
end

return profile;