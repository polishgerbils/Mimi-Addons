local profile = {};

local Settings = {
    CurrentLevel = 0,
	isEnabled = false
};
local sets = {

	Style = {
		Head = 'Opo-opo Crown',
		Body = 'Savage top +1',
        Hands = 'Dusk Gloves',
		Legs = 'Savage loincloth',
		Feet = 'River gaiters',

	},
	
	['Town'] = {
        Head = 'Opo-opo Crown',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beastly Earring',
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
        Head = {'Optical Hat', 'Empress Hairpin'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Beastly Earring'},
        Ear2 = {'Brutal Earring'},
        Body = {'Barone Corazza', 'Fighter\'s Lorica' },
        Hands = {'Darksteel Mittens'},
        Ring1 = {'Merman\'s Ring'},
        Ring2 = {'Merman\'s Ring'},
		Back = {'Forager\'s mantle', 'Ram Mantle'},
        Waist = {'Warwolf Belt'},
        Legs = {'Darksteel Subligar', 'Republic Subligar'},
        Feet = {'Dst. Leggings', 'Bounding Boots'},
	},
	
	['TP_Priority'] = {

        Head = {'Panther Mask', 'Optical Hat', 'Empress Hairpin'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Beastly Earring'},
        Ear2 = {'Brutal Earring', 'Coral Earring'},
        Body = {'Haubergeon'},
        Hands = {'Dusk Gloves'},
        Ring1 = {'Toreador\'s Ring', 'Balance Ring'},
        Ring2 = {'Rajas Ring'},
        Waist = {'Swift Belt'},
        Legs = 'Byakko\'s Haidate',
        Feet = {'Armada Sollerets', 'Bounding Boots'},
    },
	
	['Haste'] = {
        Head = 'Panther Mask',
        Ear1 = 'Magnetic Earring',
        Ear2 = 'Loquac. Earring',
        Hands = 'Dusk Gloves',
        Waist = 'Swift Belt',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Armada Sollerets',
	},
	
    ['WS_Priority'] = {

        Head = {'Opo-opo crown'},
        Ear1 = {'Beastly Earring', 'Coral Earring'},      
		Ear2 = {'Brutal Earring'},
        Neck = {'Spike Necklace'},
        Body = {'Kirin\'s Osode', 'Haubergeon', 'Savage Separates'},
		Hands = {'Hecatomb Mittens'},
        Ring1 = {'Flame Ring', 'Puissance Ring'},
        Ring2 = {'Rajas Ring'},
		Waist = {'Warwolf Belt'},
        Legs = 'Warrior\'s Cuisses',		
        Feet = {'Hct. Leggings', 'Savage Gaiters'},
    },
	
    ['Multi_Priority'] = {

        Head = {'Adaman Celata'},
        Neck = {'Peacock Amulet'},   
        Ear1 = {'Beastly Earring', 'Coral Earring'},   		
		Ear2 = {'Brutal Earring'},
        Body = {'Haubergeon'},
        Hands = {'Warrior\'s Mufflers'},
        Ring1 = {'Toreador\'s Ring'},
        Ring2 = {'Rajas Ring'},
        Waist = {'Warrior\'s stone'},
        Legs = {'Byakko\'s Haidate'},
        Feet = {'Fighter\'s Calligae', 'Bounding Boots'},
    },
	
    ['Deci'] = {
		Head = 'Adaman Celata',
        Neck = 'Flame Gorget',
        Ear1 = 'Beastly Earring',
        Body = 'Haubergeon',
		Hands = 'Hecatomb Mittens',
        Ring1 = 'Flame Ring',
		Ring2 = 'Rajas Ring',
        Waist = 'Warrior\'s stone',
		Legs = 'Warrior\'s cuisses',
        Feet = 'Hct. Leggings',
    },
	
    ['Savage'] = {
		Head = 'Adaman Celata',
        Neck = 'Soil Gorget',
        Ear2 = 'Brutal Earring',
        Body = 'Kirin\'s Osode',
		Hands = 'Hecatomb Mittens',
        Ring1 = 'Aqua Ring',
		Ring2 = 'Rajas Ring',
        Waist = 'Warrior\'s stone',
		Legs = 'Warrior\'s cuisses',
        Feet = 'Suzaku\'s sune-ate',
    },
	
    ['Zerg'] = {
		Main = 'Maneater',
		Sub = 'Octave Club',
		Ammo = 'Bomb Core',

    },
	
    ['sneakvis'] = {
        Hands = 'Dream Mittens +1',
        Feet = 'Dream Boots +1',
    },
	
    ['enmity'] = {
		Body = 'Fighter\'s Lorica',
        Waist = 'Warwolf Belt',
        Feet = 'Fighter\'s Calligae',
    },

};

profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind M /map');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 /lac fwd toggleLac');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 /fillmode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /lac disable main');
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind M');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F10');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
end

profile.HandleCommand = function(args)
    if (args[1] and args[1]:lower() == 'togglelac') then
        if (isEnabled) then
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable');
            isEnabled = false;
        else
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable');
            isEnabled = true;
        end
    end
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
		if (player.SubJob == 'NIN') then
			gFunc.Equip('Ear1', 'Stealth Earring');
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
	elseif (action.Name == 'Warcry') then
		gFunc.Equip('Head', 'Warrior\'s Mask');
	end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	local action = gData.GetAction();
	if (action.Name == 'Sneak') or (action.Name == 'Invisible') or (action.Name == 'Tonko: Ichi') or (action.Name == 'Tonko: Ni') then
		gFunc.EquipSet(profile.Sets.sneakvis);
	elseif (action.Name == 'Utsusemi: Ichi') or (action.Name == 'Utsusemi: Ni') then
		gFunc.EquipSet(sets.Haste)
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
	elseif (action.Name == 'Rampage') or (action.Name == 'Vorpal Blade')  then
		gFunc.EquipSet(sets.Multi);
	elseif (action.Name == 'Savage Blade') then
		gFunc.EquipSet(sets.Savage);
	end
	
end

return profile;