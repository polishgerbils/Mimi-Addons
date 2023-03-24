local profile = {};
profile.Sets = {
	Style = {
	    Head = 'Empress Hairpin',	
	},
	TP = {
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Body = 'Assault Jerkin',
        Hands = 'Thick Mufflers',
        Ring1 = 'Sniper\'s Ring',
        Ring2 = 'Rajas Ring',
        Waist = 'Life Belt',
        Legs = 'Thick Breeches',
        Feet = 'Thick Sollerets',
	},
    WS = {
        Neck = 'Spike Necklace',
        Ear1 = 'Bushinomimi',
		Hands = 'Ogre Gloves',
        Ring1 = 'Garnet Ring',
        Ring2 = 'Rajas Ring',
        Waist = 'Ryl.Kgt. Belt',
        Feet = 'Savage Gaiters',
    },
    WSAcc = {
        Neck = 'Peacock Amulet',
        Ear1 = 'Bushinomimi',
        Body = 'Assault Jerkin',
		Hands = 'Ogre Gloves',
        Ring1 = 'Sniper\'s Ring',
        Ring2 = 'Rajas Ring',
        Waist = 'Life Belt',
        Feet = 'Savage Gaiters',
    },
    Resting = {

    },
    reward = {
		Head = 'Beast Helm',
        Neck = 'Peacock Amulet',
        Body = 'Beast Jackcoat',		
		Hands = 'Ogre Gloves',
		Legs = 'Savage Loincloth',
		Waist = 'Ryl.Kgt. Belt',
        Feet = 'Beast Gaiters',
    },
    charm = {
	    Head = 'Beast Helm',
        Neck = 'Flower necklace',	
        Body = 'Beast Jackcoat',
        Hands = 'Beast gloves',
		Ring1 = 'Pearl Ring',
        Ring2 = 'Pearl Ring',
		Waist = 'Ryl.Kgt. Belt',
		Legs = 'Beast Trousers',
        Feet = 'Beast Gaiters',
    },
    sneakvis = {
        Hands = 'Dream Mittens +1',
        Feet = 'Dream Boots +1',
    },
    gather = {
        Body = 'Field Tunica',
        Hands = 'Field Gloves',
        Feet = 'Field Boots',
    },
};

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
	local player = gData.GetPlayer();

	if (player.Status == 'Engaged') then
		gFunc.EquipSet(profile.Sets.TP);
		if (player.SubJob == 'WHM') then
			if (player.MP < 49) then
				gFunc.Equip('Body', 'Gaudy Harness');
			end
		end
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(profile.Sets.Resting);
	else
		gFunc.EquipSet(profile.Sets.TP);
		gFunc.LockStyle(profile.Sets.Style);
		if (player.SubJob == 'WHM') then
			if (player.MP < 49) then
			gFunc.Equip('Body', 'Gaudy Harness');
			end
		end
	end
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	if (action.Name == 'Reward') then
		gFunc.EquipSet(profile.Sets.reward);
		gFunc.Equip('Ammo', 'Pet Food Zeta');
	elseif (action.Name == 'Charm') then
		gFunc.EquipSet(profile.Sets.charm);
	elseif (action.Name == 'Tame') then
		gFunc.Equip('Head', 'Beast Helm');
	end
end

profile.HandleItem = function()
	local action = gData.GetAction();
	if (action.Name == 'Silent Oil') or (action.Name == 'Prism Powder') then
		gFunc.EquipSet(profile.Sets.sneakvis);
	elseif (action.Name == 'Pickaxe') then
		gFunc.EquipSet(profile.Sets.gather);
	end
		
end

profile.HandlePrecast = function()
	local action = gData.GetAction();
	if (action.Name == 'Sneak') or (action.Name == 'Invisible') or (action.Name == 'Tonko: Ichi') or (action.Name == 'Tonko: Ni') then
		gFunc.EquipSet(profile.Sets.sneakvis);
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
	if (action.Name == 'Decimation') or (action.Name == 'Calamity') or (action.Name == 'Mistral Axe') then
		gFunc.EquipSet(profile.Sets.WS);
	elseif (action.Name == 'Rampage') then
		gFunc.EquipSet(profile.Sets.WSAcc);
	end
	
end

return profile;