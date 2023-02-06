local profile = {};
profile.Sets = {
    Idle = {
        Head = 'Empress Hairpin',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Shep. Doublet',
        Hands = 'Battle Gloves',
        Ring1 = 'Balance Ring',
        Ring2 = 'Balance Ring',
        Back = 'Dhalmel Mantle',
        Waist = 'Life Belt',
        Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',
    },
	TP = {
        Head = 'Empress Hairpin',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Shep. Doublet',
        Hands = 'Battle Gloves',
        Ring1 = 'Balance Ring',
        Ring2 = 'Balance Ring',
        Back = 'Dhalmel Mantle',
        Waist = 'Life Belt',
        Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',
	},
    Weaponskill = {
        Head = 'Mrc.Cpt. Headgear',
        Neck = 'Spike Necklace',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Savage Separates',
        Hands = 'Battle Gloves',
        Ring1 = 'Garnet Ring',
        Ring2 = 'Garnet Ring',
        Back = 'Dhalmel Mantle',
        Waist = 'Life Belt',
        Legs = 'Republic Subligar',
        Feet = 'Savage Gaiters',
    },
    Resting = {
        Head = 'Shep. Bonnet',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Savage Separates',
        Hands = 'Battle Gloves',
        Ring1 = 'Garnet Ring',
        Ring2 = 'Garnet Ring',
        Back = 'Dhalmel Mantle',
        Waist = 'Life Belt',
        Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',
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
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(profile.Sets.TP);
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
	if (action.Name == 'Avalanche Axe') then
		gFunc.EquipSet(profile.Sets.Weaponskill);
	end
	
end

return profile;