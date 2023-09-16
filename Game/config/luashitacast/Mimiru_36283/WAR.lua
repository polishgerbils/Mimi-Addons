local profile = {};

local Settings = {
    CurrentLevel = 0,
};
local sets = {

	Style = {
		Head = 'Opo-opo Crown',
		Body = 'Fighter\'s Lorica',
        Hands = 'Dusk Gloves',
		Legs = 'Byakko\'s Haidate',
		Feet = 'Fighter\'s Calligae',

	},
	
	['Town'] = {
        Head = 'Opo-opo Crown',
        Neck = 'Peacock Amulet',
        Ear1 = 'Bushinomimi',
        Ear2 = 'Brutal Earring',
        Body = 'Kirin\'s Osode',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
		Back = 'Forager\'s mantle',
        Waist = 'Swift Belt',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Armada Sollerets',
	},
	
	['Idle_Priority'] = {
        Head = {'Optical Hat'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Ethereal Earring', 'Beetle Earring +1'},
        Ear2 = {'Brutal Earring', 'Beetle Earring +1'},
        Body = {'Kirin\'s Osode', 'Fighter\'s Lorica' },
        Hands = {'Darksteel Mittens'},
        Ring1 = {'Coral Ring'},
        Ring2 = {'Coral Ring'},
		Back = {'Forager\'s mantle', 'Ram Mantle'},
        Waist = {'Warwolf Belt'},
        Legs = {'Darksteel Subligar', 'Republic Subligar'},
        Feet = {'Dst. Leggings', 'Bounding Boots'},
	},
	
	['TP_Priority'] = {

        Head = {'Panther Mask', 'Optical Hat', 'Empress Hairpin'},
        Neck = {'Peacock Amulet', 'Spike Necklace'},
        Ear1 = {'Bushinomimi', 'Coral Earring', 'Beetle Earring +1'},
        Ear2 = {'Brutal Earring', 'Coral Earring', 'Beetle Earring +1'},
        Body = {'Haubergeon', 'Ctr. Scale Mail'},
        Hands = {'Dusk Gloves'},
        Ring1 = {'Toreador\'s Ring', 'Balance Ring'},
        Ring2 = {'Rajas Ring'},
        Waist = {'Swift Belt'},
        Legs = {'Byakko\'s Haidate', 'Fighter\'s cuisses', 'Republic Subligar'},
        Feet = {'Armada Sollerets', 'Bounding Boots'},
    },
	
    ['WS_Priority'] = {

        Head = {'Opo-opo crown'},
        Ear1 = {'Bushinomimi', 'Coral Earring', 'Beetle Earring +1'},      
		Ear2 = {'Brutal Earring', 'Diabolos\'s Earring', 'Beetle Earring +1'},
        Neck = {'Spike Necklace'},
        Body = {'Kirin\'s Osode', 'Haubergeon', 'Savage Separates'},
		Hands = {'Hecatomb Mittens'},
        Ring1 = {'Flame Ring', 'Puissance Ring'},
        Ring2 = {'Rajas Ring'},
		Waist = {'Warwolf Belt'},
        Legs = {'Warrior\'s Cuisses', 'Fighter\'s cuisses', 'Republic Subligar'},		
        Feet = {'Hct. Leggings', 'Savage Gaiters'},
    },
	
    ['Multi_Priority'] = {

        Head = {'Adaman Celata'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Ethereal Earring', 'Coral Earring', 'Beetle Earring +1'},      
		Ear2 = {'Brutal Earring', 'Diabolos\'s Earring', 'Beetle Earring +1'},
        Body = {'Haubergeon', 'Brigandine'},
        Hands = {'Warrior\'s Mufflers'},
        Ring1 = {'Toreador\'s Ring'},
        Ring2 = {'Rajas Ring'},
        Waist = {'Life Belt'},
        Legs = {'Byakko\'s Haidate', 'Republic Subligar'},
        Feet = {'Fighter\'s Calligae', 'Bounding Boots'},
    },
	
    ['Deci_Priority'] = {
		Head = {'Adaman Celata'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Ethereal Earring'},
        Body = {'Haubergeon', 'Savage Separates'},
		Hands = {'Hecatomb Mittens'},
        Ring1 = {'Flame Ring'},
		Ring2 = {'Rajas Ring'},
        Waist = {'Warwolf Belt'},
		Legs = {'Byakko\'s Haidate'},
        Feet = {'Hct. Leggings', 'Savage Gaiters'},
    },
	
    ['Evis_Priority'] = {
		Head = {'Adaman Celata'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Ethereal Earring'},
        Ear2 = {'Brutal Earring'},
        Body = {'Haubergeon'},
		Hands = {'Warrior\'s Mufflers'},
        Ring1 = {'Toreador\'s Ring'},
		Ring2 = {'Rajas Ring'},
        Waist = {'Warwolf Belt'},
		Legs = {'Byakko\'s Haidate'},
        Feet = {'Armada Sollerets'},
    },
	
    ['sneakvis'] = {
        Hands = 'Dream Mittens +1',
        Feet = 'Dream Boots +1',
    },
	
    ['enmity_Priority'] = {
        Head = {'Fighter\'s Mask'},
		Body = {'Fighter\'s Lorica'},
        Hands = {'Fighter\'s Mufflers'},
        Waist = {'Warwolf Belt'},
        Legs = {'Warrior\'s cuisses'},
        Feet = {'Fighter\'s Calligae'},
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
	local env = gData.GetEnvironment();
	local zone = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
		if (myLevel ~= Settings.CurrentLevel) then
			gFunc.EvaluateLevels(profile.Sets, myLevel);
			Settings.CurrentLevel = myLevel;
		end
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(profile.Sets.TP);
		if (env.Day == 'Lightningday') then
			gFunc.Equip('Ring1', 'Lightning Ring');
		end
	elseif (player.Status == 'Resting') then
		gFunc.EquipSet(profile.Sets.Resting);
	elseif T{230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246}:contains(zone) then
		gFunc.EquipSet(profile.Sets.Town);
		gFunc.LockStyle(sets.Style);
		if T{234, 235, 236, 237}:contains(zone) then
			gFunc.Equip('Body', 'Republic Aketon');		
		end
	else
		gFunc.EquipSet(profile.Sets.Idle);
		gFunc.LockStyle(sets.Style);
	end
	
end

profile.HandleAbility = function()
	local action = gData.GetAction();
	if (action.Name == 'Provoke') then
		gFunc.EquipSet(sets.enmity);
	end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	local action = gData.GetAction();
	if (action.Name == 'Sneak') or (action.Name == 'Invisible') or (action.Name == 'Tonko: Ichi') or (action.Name == 'Tonko: Ni') then
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
	if (action.Name == 'Penta Thrust') or (action.Name == 'Raging Rush')then
		gFunc.EquipSet(profile.Sets.Multi);
		gFunc.Equip('Neck', 'Aqua Gorget');
	elseif (action.Name == 'Sturmwind') or (action.Name == 'Full Break') or (action.Name == 'Steel Cyclone') then
		gFunc.EquipSet(profile.Sets.WS);
		gFunc.Equip('Neck', 'Aqua Gorget');
		gFunc.Equip('Head', 'Genbu\'s Kabuto');
	elseif (action.Name == 'Decimation') or (action.Name == 'Mistral Axe') then
		gFunc.EquipSet(sets.Deci);
		gFunc.Equip('Neck', 'Flame Gorget');
	elseif (action.Name == 'Rampage') then
		gFunc.EquipSet(sets.Multi);
	elseif (action.Name == 'Evisceration') then
		gFunc.EquipSet(sets.Evis);
	end
	
end

return profile;