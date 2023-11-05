local profile = {};

local Settings = {
    CurrentLevel = 0,
	isEnabled = false
};

local sets = {

	Style = {

		Head = 'Opo-opo Crown',
        Body = 'Kirin\'s Osode',
		Hands = 'Dusk Gloves',
		Legs = 'Byakko\'s Haidate',

	},
	
	['Town'] = {
        Head = 'Opo-opo Crown',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beastly Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Kirin\'s Osode',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
		Back = 'Forager\'s mantle',
        Waist = 'Swift Belt',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Armada Sollerets',
	},
	
	['Idle_Priority'] = {
        Head = 'Shep. Bonnet',
        Neck = {'Peacock Amulet'},
        Ear1 = {'Beastly Earring'},
        Ear2 = {'Brutal Earring'},
        Body = {'Shep. Doublet'},
        Hands = {'Darksteel Mittens', 'Battle gloves'},
        Ring1 = {'Merman\'s Ring', 'Kshama Ring No.2', 'Ametrine Ring'},
        Ring2 = {'Merman\'s Ring', 'Rajas Ring'},
		Back = {'Forager\'s mantle'},
        Waist = {'Warwolf Belt', 'Swift Belt', 'Tilt Belt'},
        Legs = {'Darksteel Subligar', 'Savage loincloth'},
        Feet = {'Dst. Leggings', 'Bounding Boots'},
	},
	
	['TP_Priority'] = {
        Head = {'Panther Mask', 'Optical Hat', 'Shep. Bonnet' },
        Neck = {'Peacock Amulet'},
        Ear1 = {'Beastly Earring', 'Coral Earring'},
        Ear2 = {'Brutal Earring'},
        Body = {'Haubergeon', 'Assault Jerkin', 'Shep. Doublet'},
        Hands = {'Dusk Gloves', 'Battle Gloves'},
        Ring1 = {'Toreador\'s Ring'},
        Ring2 = {'Rajas Ring'},
		Back = {'Forager\'s mantle'},
        Waist = {'Swift Belt'},
        Legs = {'Byakko\'s Haidate', 'Republic Subligar'},
        Feet = {'Armada Sollerets', 'Bounding Boots'},
	},

	['Haste_Priority'] = {
        Head = {'Panther Mask'},
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Hands = {'Dusk Gloves'},
        Waist = {'Swift Belt'},
        Legs = {'Byakko\'s Haidate'},
        Feet = {'Armada Sollerets'},
	},
	
    ['WS_Priority'] = {
		Head = {'Wyvern Helm'},
        Neck = {'Spike Necklace'},
        Ear1 = {'Bushinomimi'},
        Body = {'Kirin\'s Osode', 'Hecatomb Harness', 'Savage Separates'},
		Hands = {'Hecatomb Mittens'},
        Ring1 = {'Flame Ring'},
        Waist = {'Warwolf Belt'},
        Feet = {'Hct. Leggings', 'Savage Gaiters'},
    },
	
    ['WSAcc_Priority'] = {
		Head = {'Adaman Celata'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Bushinomimi'},
        Body = {'Haubergeon'},
		Hands = {'Hecatomb Mittens'},
        Ring1 = {'Flame Ring', 'Puissance Ring'},
        Waist = {'Warwolf Belt'},
        Feet = {'Hct. Leggings'},
    },
	
    ['Rampage_Priority'] = {
		Head = {'Adaman Celata'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Ethereal Earring'},
        Body = {'Haubergeon', 'Savage Separates'},
		Hands = {'Hecatomb Mittens'},
        Ring1 = {'Toreador\'s Ring'},
		Ring2 = {'Rajas Ring'},
        Waist = {'Warwolf Belt'},
		Legs = {'Byakko\'s Haidate'},
        Feet = {'Rutter Sabatons', 'Savage Gaiters'},
    },
	
    ['Evis_Priority'] = {
		Head = {'Adaman Celata'},
        Neck = {'Soil Gorget'},
        Ear1 = {'Coral Earring'},
        Ear2 = {'Brutal Earring'},
        Body = {'Haubergeon'},
		Hands = {'Hecatomb Mittens'},
        Ring1 = {'Toreador\'s Ring'},
		Ring2 = {'Rajas Ring'},
        Waist = {'Warwolf Belt'},
		Legs = {'Byakko\'s Haidate'},
        Feet = {'Armada Sollerets'},
    },
	
    ['Resting'] = {
		Head = 'Presidential hairpin',
		Ear1 = 'Relaxing Earring',
		Ear2 = 'Magnetic Earring',
    },
	
    ['reward'] = {
		Head = 'Beast Helm',
        Neck = 'Peacock Amulet',
        Body = 'Beast Jackcoat',
		Hands = 'Ogre Gloves',
        Ring1 = 'Aqua Ring',
        Ring2 = 'Aqua Ring',
		Legs = 'Savage Loincloth',
		Waist = 'Ryl.Kgt. Belt',
        Feet = 'Mst. Gaiters +1',
    },
	
    ['charm_Priority'] = {
	    Head = 'Monster Helm',
        Neck = {'Star necklace', 'flower necklace'},	
        Body = {'Kirin\'s Osode', 'Savage separates'},
        Ear1 = {'Beastly Earring'},
        Hands = '',
        Ring1 = {'Hope Ring'},
		Ring2 = {'Hope Ring'},
		Legs = 'Beast Trousers',
        Feet = {'Savage gaiters'},
    },
	
    ['octo'] = {
		Main = 'Martial Axe',
		Sub = 'Octave Club',
    },
	
	['mp'] = {
	    Head = 'Faerie Hairpin',
        Neck = 'Uggalepih pendant',	
		Ear1 = 'Relaxing Earring',
		Ear2 = 'Magnetic Earring',
		Body = 'Kirin\'s Osode',
        Hands = 'Savage Gauntlets',
        Ring1 = 'Ether Ring',
		Ring2 = 'Astral Ring',
        Legs = 'Savage Loincloth',
		Feet = 'River gaiters',
    },
	
    ['sneakvis'] = {
        Ear2 = 'Loquac. Earring',
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
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind z //sneak <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind x //invisible <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind c //stoneskin me');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind v //blink me');
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind M');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F10');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind z');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind x');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind c');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind v');
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
	local party = gData.GetParty();
	local zone = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
		if (myLevel ~= Settings.CurrentLevel) then
			gFunc.EvaluateLevels(profile.Sets, myLevel);
			Settings.CurrentLevel = myLevel;
		end
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.TP);
		if (player.SubJob == 'WHM') or (player.SubJob == 'BLM') then
			if (player.MP < 50) then
				gFunc.Equip('Body', 'Gaudy Harness');
			end
--		elseif (player. == 'NIN') and (player.HP < 1000) and (party.Count < 3) then
--			gFunc.Equip('Main', 'Rune Axe');				
		end
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	elseif T{230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246}:contains(zone) then
		gFunc.EquipSet(profile.Sets.Town);
		gFunc.LockStyle(sets.Style);
		if T{234, 235, 236, 237}:contains(zone) then
			gFunc.Equip('Body', 'Republic Aketon');		
		end
	else
		gFunc.EquipSet(sets.Idle);
		gFunc.LockStyle(sets.Style);
		if (player.SubJob == 'WHM') or (player.SubJob == 'BLM') then
			if (player.MP < 50) then
			gFunc.Equip('Body', 'Gaudy Harness');
			end				
		end
		if (conquest.settings.regionControl == false) then
			gFunc.Equip('head', 'Presidential hairpin');
		end
	end
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	local player = gData.GetPlayer();
	if (action.Name == 'Reward') then
		gFunc.EquipSet(sets.reward);
		if (player.MainJobSync == 60) then
			gFunc.Equip('Ammo', 'Pet Fd. Epsilon');
		elseif (player.MainJobSync == 50) then
			gFunc.Equip('Ammo', 'Pet Food Delta');
		elseif (player.MainJobSync == 40) then
			gFunc.Equip('Ammo', 'Pet Fd. Gamma');
		elseif (player.MainJobSync == 30) then
			gFunc.Equip('Ammo', 'Pet Food Beta');
		else
			gFunc.Equip('Ammo', 'Pet Food Zeta');
		end
	elseif (action.Name == 'Charm') then
		gFunc.EquipSet(sets.charm);
	elseif (action.Name == 'Tame') then
		gFunc.Equip('Head', 'Beast Helm');
	elseif (action.Name == 'Fight') then
		gFunc.Equip('Feet', 'Mst. Gaiters +1');
	elseif (action.Name == 'Heel') then
		gFunc.Equip('Feet', 'Mst. Gaiters +1');
	elseif (action.Name == 'Stay') then
		gFunc.Equip('Feet', 'Mst. Gaiters +1');
	elseif (action.Name == 'Lamb Chop') then
		gFunc.Equip('Feet', 'Mst. Gaiters +1');
	end
end

profile.HandleItem = function()
	local action = gData.GetAction();
	if (action.Name == 'Silent Oil') or (action.Name == 'Prism Powder') then
		gFunc.EquipSet(sets.sneakvis);
	end
		
end

profile.HandlePrecast = function()
	local action = gData.GetAction();
	if (action.Name == 'Sneak') or (action.Name == 'Invisible') or (action.Name == 'Tonko: Ichi') or (action.Name == 'Tonko: Ni') then
		gFunc.EquipSet(sets.sneakvis);
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
	if (action.Name == 'Calamity') or (action.Name == 'Raging Axe') then
		gFunc.EquipSet(sets.WS);
	elseif (action.Name == 'Mistral Axe') then
		gFunc.EquipSet(sets.WS);
		gFunc.Equip('Neck', 'Flame Gorget');
	elseif (action.Name == 'Decimation') then
		gFunc.EquipSet(sets.WSAcc);
		gFunc.Equip('Neck', 'Flame Gorget');
	elseif (action.Name == 'Rampage') then
		gFunc.EquipSet(sets.Rampage);
	elseif (action.Name == 'Evisceration') then
		gFunc.EquipSet(sets.Evis);
	end
	
end

return profile;