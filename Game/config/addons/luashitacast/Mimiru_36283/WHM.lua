local profile = {};
profile.Sets = {
	Idle = {
        Body = 'Field Tunica',
        Hands = 'Field Gloves',
        Feet = 'Field Boots',
	},
	Resting = {
        Body = 'Field Tunica',
        Hands = 'Field Gloves',
        Feet = 'Field Boots',
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
	if (player.Status == 'Resting') then
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

	
end

return profile;