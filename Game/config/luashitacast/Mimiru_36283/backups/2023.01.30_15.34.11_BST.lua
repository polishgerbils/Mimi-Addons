local profile = {};
profile.Sets = {
    Idle = {
        Main = 'Barbaroi Axe',
        Sub = 'Targe',
        Ammo = 'Fish Oil Broth',
        Head = 'Mrc.Cpt. Headgear',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Ryl.Sqr. Chainmail',
        Hands = 'Battle Gloves',
        Ring1 = 'Balance Ring',
        Ring2 = 'Balance Ring',
        Back = 'Dhalmel Mantle',
        Waist = 'Tilt Belt',
        Legs = 'Republic Subligar',
        Feet = 'Savage Gaiters',
    },
	TP = {
	    Main = 'Barbaroi Axe',
        Sub = 'Targe',
        Ammo = 'Fish Oil Broth',
        Head = 'Mrc.Cpt. Headgear',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Ryl.Sqr. Chainmail',
        Hands = 'Battle Gloves',
        Ring1 = 'Balance Ring',
        Ring2 = 'Balance Ring',
        Back = 'Dhalmel Mantle',
        Waist = 'Tilt Belt',
        Legs = 'Republic Subligar',
        Feet = 'Savage Gaiters',
	},
    Weaponskill = {
        Main = 'Barbaroi Axe',
        Sub = 'Targe',
        Ammo = 'Fish Oil Broth',
        Head = 'Mrc.Cpt. Headgear',
        Neck = 'Spike Necklace',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Savage Separates',
        Hands = 'Battle Gloves',
        Ring1 = 'Garnet Ring',
        Ring2 = 'Garnet Ring',
        Back = 'Dhalmel Mantle',
        Waist = 'Tilt Belt',
        Legs = 'Republic Subligar',
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
	local action = gData.GetAction();
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(profile.Sets.TP);
	elseif (player.Status == 'Resting') then
		gFunc.Equipset(profile.Sets.Resting);
	else
		gFunc.EquipSet(profile.Sets.Idle);
	end
	
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
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