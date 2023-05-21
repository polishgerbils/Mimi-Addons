local profile = {};

local Settings = {
    CurrentLevel = 0,
};

local ElementalStaffTable = {
    ['Fire'] = 'Ice Staff',
    ['Earth'] = 'Ice Staff',
    ['Water'] = 'Ice Staff',
    ['Wind'] = 'Casting Wand',
    ['Ice'] = 'Ice Staff',
    ['Thunder'] = 'Ice Staff',
    ['Light'] = 'Ice Staff',
    ['Dark'] = 'Ice Staff'
};

local sets = {

	Style = {
	},
	
    ['Idle_Priority'] = {
        Main = {'Earth Staff' },
        Ammo = 'Morion Tathlum',
        Head = 'Shep. Bonnet',
        Neck = 'Holy Phial',
        Ear1 = 'Energy Earring',
        Ear2 = 'Energy Earring',
        Body = {'Shep. Doublet', 'Seer\'s Tunic +1'},
        Hands = {'Carbuncle Mitts', 'Battle Gloves'},
        Ring1 = {'Ether Ring', 'Astral Ring'},
        Ring2 = 'Astral Ring',
        Back = 'White Cape',
        Waist = {'Hojutsu Belt'},
        Legs = 'Savage Loincloth',
        Feet = {'Mannequin Pumps'},
    },

    ['Resting_Priority'] = {
        Main = {'Kukulcan\'s Staff', 'Pilgrim\'s Wand'},
        Body = {'Black Cotehardie', 'Seer\'s Tunic +1'},
    },

    ['sneakvis'] = {
        Hands = 'Dream Mittens +1',
        Feet = 'Dream Boots +1',
    },
    ['gather'] = {
        Body = 'Field Tunica',
        Hands = 'Field Gloves',
        Feet = 'Field Boots',
    },

};


profile.Sets = sets;

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
	local zone = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
		if (myLevel ~= Settings.CurrentLevel) then
			gFunc.EvaluateLevels(profile.Sets, myLevel);
			Settings.CurrentLevel = myLevel;
		end
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.TP);

	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(sets.Resting);
	elseif T{234, 235, 236, 237}:contains(zone) then
		gFunc.Equip('Body', 'Republic Aketon');
	else
		gFunc.EquipSet(sets.Idle);
		gFunc.LockStyle(sets.Style);
	end
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	local player = gData.GetPlayer();

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
	
end

return profile;