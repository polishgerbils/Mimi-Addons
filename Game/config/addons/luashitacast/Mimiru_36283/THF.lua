local profile = {};

local Settings = {
    CurrentLevel = 0,
	isEnabled = false
};

local sets = {
	
	['Idle_Priority'] = {
        Head = 'Empress Hairpin',
        Neck = 'Peacock Amulet',
        Ear1 = 'Drone Earring',
        Ear2 = 'Genin Earring',
        Body = {'Rapparee harness', 'Brigandine'},
        Hands = 'Battle Gloves',
        Ring1 = {'Toreador\'s Ring', 'Kshama Ring No.2'},
        Ring2 = 'Rajas Ring',
		Back = 'Genin Mantle',
        Waist = 'Swift belt',
        Legs = {'Bravo\'s subligar', 'Noct brais +1'},
        Feet = 'Bounding Boots',
	},
	
	['TP_Priority'] = {
        Head = 'Empress Hairpin',
        Neck = 'Peacock Amulet',
        Ear1 = 'Drone Earring',
        Ear2 = 'Genin Earring',
        Body = {'Rapparee harness', 'Brigandine'},
        Hands = 'Battle Gloves',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
		Back = 'Genin Mantle',
        Waist = 'Swift belt',
        Legs = {'Bravo\'s subligar', 'Noct brais +1'},
        Feet = 'Bounding Boots',
    },
	
	['Haste'] = {
        Head = 'Panther Mask',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Body = 'Rapparee harness',
        Hands = 'Dusk Gloves',
        Waist = 'Swift Belt',
	},
	
    ['WS_Priority'] = {
        Head = 'Empress Hairpin',
        Neck = 'Spike necklace',
        Ear1 = 'Drone Earring',
        Ear2 = 'Genin Earring',
        Body = 'Brigandine',
		Hands = 'Rogue\'s Armlets',
        Ring1 = 'Ametrine Ring',
        Ring2 = 'Rajas Ring',
		Back = 'Rep. Army Mantle',
        Waist = 'R.K. Belt +1',
        Legs = 'Noct brais +1',
        Feet = 'Bounding Boots',
    },
	
    ['Multi_Priority'] = {
        Head = 'Empress Hairpin',
        Neck = 'Peacock Amulet',
        Ear1 = 'Drone Earring',
        Ear2 = 'Genin Earring',
        Body = {'Brigandine', 'Mrc.Cpt. Doublet'},
        Hands = 'Battle Gloves',
        Ring1 = 'Ametrine Ring',
        Ring2 = 'Rajas Ring',
		Back = 'Genin Mantle',
        Waist = 'R.K. Belt +1',
        Legs = 'Noct brais +1',
        Feet = 'Bounding Boots',
    },
	
    ['Dex'] = {
        Head = 'Empress Hairpin',
        Neck = 'Spike Necklace',
        Body = 'Brigandine',
		Hands = 'Rogue\'s Armlets',
        Ring1 = 'Ametrine Ring',
        Ring2 = 'Rajas Ring',
		Back = 'Rep. Army Mantle',
        Waist = 'R.K. Belt +1',
        Legs = 'Noct brais +1',
        Feet = 'Bounding Boots',
    },
	
    ['Agi'] = {
        Head = 'Empress Hairpin',
        Ear1 = 'Drone Earring',
        Ear2 = 'Genin Earring',
		Back = 'Genin Mantle',
        Waist = 'R.K. Belt +1',
        Legs = 'Rogue\'s culottes',
        Feet = 'Bounding Boots',
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
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind M');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F10');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
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
	local env = gData.GetEnvironment();
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
	end
	
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	local action = gData.GetAction();
	if (action.Name == 'Tonko: Ichi') or (action.Name == 'Tonko: Ni') then
		gFunc.EquipSet(profile.Sets.sneakvis);
	elseif (action.Name == 'Utsusemi: Ichi') or (action.Name == 'Utsusemi: Ni') then
		gFunc.EquipSet(sets.Haste)
	end
end

profile.HandleMidcast = function()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
	local action = gData.GetAction();
	if (action.Name == 'Wasp Sting') or (action.Name == 'Viper Bite') then
		gFunc.EquipSet(profile.Sets.WS);
	elseif (action.Name == 'Evisceration') then
		gFunc.EquipSet(profile.Sets.Multi);
	end
	
end

return profile;