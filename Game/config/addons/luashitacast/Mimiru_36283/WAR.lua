local profile = {};
profile.Sets = {

	['TP'] = {

		ammo = 'Acid Bolt',
        Head = 'Empress Hairpin',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Brigandine',
        Hands = 'Ryl.Sqr. Mufflers',
        Ring1 = 'Sniper\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Ram Mantle',
        Waist = 'Swift Belt',
        Legs = 'Republic Subligar',
        Feet = 'Fighter\'s Calligae',
    },
    ['WS'] = {

        Neck = 'Spike Necklace',
        Body = 'Savage Separates',
        Hands = 'Fighter\'s Mufflers',
        Ring1 = 'Puissance Ring',
        Ring2 = 'Raja\'s Ring',
		Waist = 'Ryl.Kgt. Belt',
        Feet = 'Savage Gaiters',
    },
    ['WSAcc'] = {

        Neck = 'Peacock Amulet',
        Body = 'Brigandine',
        Hands = 'Fighter\'s Mufflers',
        Ring1 = 'Sniper\'s Ring',
        Ring2 = 'Rajas Ring',
        Waist = 'Life Belt',
        Feet = 'Bounding Boots',
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
		gFunc.EquipSet(profile.Sets.TP);
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
	if (action.Name == 'Penta Thrust') then
		gFunc.EquipSet(profile.Sets.WSAcc);
	elseif (action.Name == 'Double Thrust') or (action.Name == 'Keen Edge') then
		gFunc.EquipSet(profile.Sets.WS);
	end
	
end

return profile;