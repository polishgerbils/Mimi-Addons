local profile = {};
profile.Sets = {
    ['Idle'] = {
        Main = 'Heavy Axe',
        Range = 'Zamburak',
        Ammo = 'Acid Bolt',
        Head = 'Empress Hairpin',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Ctr. Scale Mail',
        Hands = 'Ryl.Sqr. Mufflers',
        Ring1 = 'Venerer Ring',
        Ring2 = 'Balance Ring',
        Back = 'Ram Mantle',
        Waist = 'Warrior\'s Belt',
        Legs = 'Republic Subligar',
        Feet = 'Bounding Boots',
    },
	TP = {
        Head = 'Empress Hairpin',
        Feet = 'Bounding Boots',
	},
    WS = {
		Body = 'Savage Separates',
        Ring1 = 'Garnet Ring',
        Ring2 = 'Garnet Ring',
        Feet = 'Savage Gaiters',
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
	if (action.Name == 'Sturmwind') then
		gFunc.EquipSet(profile.Sets.WS);
	end
	
end

return profile;