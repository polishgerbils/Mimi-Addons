local profile = {};

local Settings = {
    CurrentLevel = 53,
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
    ['Idle_Priority'] = {
        Main = {'Ice Staff', 'Casting Wand', 'Yew Wand +1' },
		Sub = 'Solid Wand',
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
        Sub = 'Solid Wand',
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
        Ammo = 'Morion Tathlum',
        Head = 'Seer\'s Crown +1',
        Neck = 'Black Neckerchief',
        Ear1 = 'Cunning Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Seer\'s Tunic',
        Hands = {'Wizard\'s Gloves', 'Seer\'s Mitts +1'},
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
        Back = 'Black Cape +1',
        Waist = {'Mantra Belt', 'Blood Stone'},
        Legs = 'Seer\'s Slacks',
        Feet = {'Wizard\'s Sabots','Seer\'s Pumps'},
    },
    ['DarkMagic_Priority'] = {
        Main = {'Ice Staff', 'Casting Wand', 'Yew Wand +1' },
		Sub = 'Solid Wand',
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
    ['logging'] = {
        Main = 'Ice Staff',
        Ammo = 'Morion Tathlum',
        Head = 'Seer\'s Crown +1',
        Neck = 'Black Neckerchief',
        Ear1 = 'Cunning Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Field Tunica',
        Hands = 'Field Gloves',
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
        Back = 'Black Cape +1',
        Waist = 'Mantra Belt',
        Legs = 'Field Hose',
        Feet = 'Seer\'s Pumps',
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
   local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end
    local player = gData.GetPlayer();
    if (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else
        gFunc.EquipSet(sets.Idle);
	end
end


profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
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
end

return profile;