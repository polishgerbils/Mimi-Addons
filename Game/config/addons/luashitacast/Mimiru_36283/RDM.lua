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
        Main = {'Ice Staff', 'Casting Wand', 'Bee Spatha' },
        Ammo = 'Morion Tathlum',
        Head = 'Seer\'s Crown +1',
        Neck = 'Black Neckerchief',
        Ear1 = 'Cunning Earring',
        Ear2 = 'Cunning Earring',
        Body = {'Black Cotehardie', 'Seer\'s Tunic'},
        Hands = {'Wizard\'s Gloves', 'Seer\'s Mitts +1'},
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
        Back = 'Black Cape +1',
        Waist = {'Mantra Belt', 'Blood Stone'},
        Legs = 'Seer\'s Slacks',
        Feet = {'Wizard\'s Sabots','Seer\'s Pumps'},
    },
    ['Nuke_Priority'] = {
        Main = {'Ice Staff', 'Casting Wand', 'Yew Wand +1' },
		Ammo = 'Morion Tathlum',
        Head = 'Seer\'s Crown +1',
        Neck = 'Black Neckerchief',
        Ear1 = 'Cunning Earring',
        Ear2 = 'Cunning Earring',
        Body = {'Black Cotehardie', 'Seer\'s Tunic'},
        Hands = {'Wizard\'s Gloves', 'Seer\'s Mitts +1'},
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
        Back = 'Black Cape +1',
        Waist = {'Mantra Belt', 'Blood Stone'},
        Legs = 'Seer\'s Slacks',
        Feet = {'Wizard\'s Sabots','Seer\'s Pumps'},
    },
    ['Resting_Priority'] = {
        Main = 'Pilgrim\'s Wand',
    },
    ['DarkMagic_Priority'] = {
        Main = {'Ice Staff', 'Casting Wand', 'Yew Wand +1' },
        Ammo = 'Morion Tathlum',
        Head = 'Seer\'s Crown +1',
        Neck = 'Black Neckerchief',
        Ear1 = 'Cunning Earring',
        Ear2 = 'Cunning Earring',
        Body = {'Black Cotehardie', 'Seer\'s Tunic'},
        Hands = 'Seer\'s Mitts +1',
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
        Back = 'Black Cape +1',
        Waist = {'Mantra Belt', 'Blood Stone'},
        Legs = 'Seer\'s Slacks',
        Feet = {'Wizard\'s Sabots','Seer\'s Pumps'},
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
    local Enfeebles = T{ 'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Silence', 'Bind' };
    local ElementalDebuffs = T{ 'Burn', 'Rasp', 'Drown', 'Choke', 'Frost', 'Shock' };
    local action = gData.GetAction();				
    if (action.Skill == 'Enfeebling Magic') then
        if (Enfeebles:contains(action.Name)) then
            gFunc.EquipSet(sets.Enfeeble);
        end
        gFunc.Equip('main', ElementalStaffTable[action.Element]);
    elseif (action.Skill == 'Elemental Magic') then
        if (ElementalDebuffs:contains(action.Name)) then
            gFunc.EquipSet(sets.Nuke);
        end
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