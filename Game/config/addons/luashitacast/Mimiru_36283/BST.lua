local profile = {};
profile.Sets = {
	TP = {
        Head = 'Empress Hairpin',
        Neck = 'Peacock Amulet',
        Ear1 = 'Spike Earring',
        Ear2 = 'Spike Earring',
        Body = 'Shep. Doublet',
        Hands = 'Battle Gloves',
        Ring1 = 'Venerer Ring',
        Ring2 = 'Balance Ring',
        Back = 'Dhalmel Mantle',
        Waist = 'Life Belt',
        Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',
	},
	Gaudy = {
        Body = 'Gaudy Harness',
	},
    WS = {
        Head = 'Mrc.Cpt. Headgear',
        Neck = 'Spike Necklace',
        Body = 'Savage Separates',
		Hands = 'Enkelados\'s Brc.',
        Ring1 = 'Garnet Ring',
        Ring2 = 'Garnet Ring',
        Waist = 'Ryl.Kgt. Belt',
        Feet = 'Savage Gaiters',
    },
    WSAcc = {
        Head = 'Mrc.Cpt. Headgear',
        Neck = 'Peacock Amulet',
        Body = 'Shep. Doublet',
		Hands = 'Enkelados\'s Brc.',
        Ring1 = 'Garnet Ring',
        Ring2 = 'Garnet Ring',
        Waist = 'Life Belt',
        Feet = 'Savage Gaiters',
    },
    Resting = {

    },
    reward = {
        Neck = 'Peacock Amulet',	
        Hands = 'Savage Gauntlets',
		Legs = 'Savage Loincloth',
		Waist = 'Ryl.Kgt. Belt',
        Feet = 'Beast Gaiters',
    },
    charm = {
	    Head = 'Entrancing Ribbon',
        Neck = 'Flower necklace',	
        Body = 'Gaudy Harness',
        Hands = 'Savage Gauntlets',
		Legs = 'Savage Loincloth',
		Ring1 = 'Pearl Ring',
        Ring2 = 'Pearl Ring',
		Waist = 'Ryl.Kgt. Belt',
        Feet = 'Beast Gaiters',
    },
    sneakvis = {
        Hands = 'Dream Mittens +1',
        Feet = 'Dream Boots +1',
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
	if (player.SubJob == 'WHM') then
		if (player.MP < 49) then
			gFunc.EquipSet(profile.Sets.Gaudy);
		else
			gFunc.EquipSet(profile.Sets.TP);
		end
	elseif (player.Status == 'Engaged') then
		gFunc.EquipSet(profile.Sets.TP);
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(profile.Sets.Resting);
	else
		gFunc.EquipSet(profile.Sets.TP);
	end
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	if (action.Name == 'Reward') then
		gFunc.EquipSet(profile.Sets.reward);
		gFunc.Equip('Ammo', 'Pet Food Beta');
	elseif (action.Name == 'Charm') then
		gFunc.EquipSet(profile.Sets.charm);
	end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	local action = gData.GetAction();
	if (action.Name == 'Sneak') or (action.Name == 'Invisible') then
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
	if (action.Name == 'Spinning Axe') then
		gFunc.EquipSet(profile.Sets.WS);
	elseif (action.Name == 'Rampage') then
		gFunc.EquipSet(profile.Sets.WSAcc);
	end
	
end

return profile;