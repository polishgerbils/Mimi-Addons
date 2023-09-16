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
		Head = 'Opo-opo Crown',
	},
	
    ['Idle_Priority'] = {
        Main = 'Yew wand +1',
        Ammo = 'Morion Tathlum',
        Head = 'Baron\'s chapeau',
        Neck = 'Justice Badge',
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring',
        Body = 'Baron\'s saio',
        Hands = 'Savage Gauntlets',
        Ring1 = 'Astral Ring',
        Ring2 = '',
        Back = 'White Cape',
        Waist = 'Friar\'s rope',
        Legs = 'Savage Loincloth',
        Feet = '',
    },
	
    ['Nuke_Priority'] = {
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
    },
	
    ['Resting_Priority'] = {
        Main = 'Pilgrim\'s Wand',
		Legs = 'Baron\'s slops',
    },
	
    ['WhiteMagic_Priority'] = {
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
    },
	
    ['BlackMagic_Priority'] = {
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
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
    local wEnfeeb = T{ 'Slow', 'Paralyze', 'Silence'};
    local bEnfeeb = T{ 'Blind', 'Bind', 'Gravity', 'Sleep'};
    local action = gData.GetAction();				
    if (action.Skill == 'Enfeebling Magic') then
        if (wEnfeeb:contains(action.Name)) then
            gFunc.EquipSet(sets.WhiteMagic);
		elseif (bEnfeeb:contains(action.Name)) then
			gFunc.EquipSet(sets.BlackMagic)
        end
        gFunc.Equip('main', ElementalStaffTable[action.Element]);
    elseif (action.Skill == 'Elemental Magic') then
		gFunc.EquipSet(sets.Nuke)
        gFunc.Equip('main', ElementalStaffTable[action.Element]);
    elseif (action.Skill == 'Dark Magic') then
        if (action.Name == 'Stun') then
            gFunc.EquipSet(sets.DarkMagic);
        end
	end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
	local action = gData.GetAction();
	
end

return profile;