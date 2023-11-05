local profile = {};

local Settings = {
    CurrentLevel = 0,
	restTimer = 0;
	isEnabled = false,
}

local pacts = {

	Skill = T{'Shining Ruby','Glittering Ruby','Crimson Howl','Inferno Howl','Frost Armor','Crystal Blessing','Aerial Armor','Hastega II','Fleet Wind','Hastega','Earthen Ward','Earthen Armor','Rolling Thunder','Lightning Armor','Soothing Current','Ecliptic Growl','Heavenward Howl','Ecliptic Howl','Noctoshield','Dream Shroud','Altana\'s Favor','Reraise','Reraise II','Reraise III','Raise','Raise II','Raise III','Wind\'s Blessing'};

	Magic = T{'Searing Light','Meteorite','Holy Mist','Inferno','Fire II','Fire IV','Meteor Strike','Conflag Strike','Diamond Dust','Blizzard II','Blizzard IV','Heavenly Strike','Aerial Blast','Aero II','Aero IV','Wind Blade','Earthen Fury','Stone II','Stone IV','Geocrush','Judgement Bolt','Thunder II','Thunder IV','Thunderstorm','Thunderspark','Tidal Wave','Water II','Water IV','Grand Fall','Howling Moon','Lunar Bay','Ruinous Omen','Somnolence','Nether Blast','Night Terror','Level ? Holy'};

	Heal = T{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'};

	Hybrid = T{'Flaming Crush','Burning Strike'};

	MAcc = T{'Diamond Storm','Sleepga','Shock Squall','Slowga','Tidal Roar','Pavor Nocturnus','Ultimate Terror','Nightmare','Mewing Lullaby','Eerie Eye'};

};

local sets = {

	['Style'] = {
		Main = 'Rep. Signet Staff',
		Head = 'Opo-opo Crown',
	},
	
	['Town'] = {

	},
	
    ['Idle_Priority'] = {
        Main = {'Terra\'s Staff', 'Dragon Staff'},
        Ammo = 'Hedgehog Bomb',
        Head = {'Faerie Hairpin', 'Shep. Bonnet'},
        Neck = 'Uggalepih pendant',
        Ear1 = {'Magnetic Earring', 'Morion earring'},
        Ear2 = {'Loquac. Earring', 'Morion earring'},
        Body = {'Yinyang Robe', 'Shep. Doublet'},
        Hands = {'Smn. Bracers +1', 'Savage Gauntlets'},
        Ring1 = 'Merman\'s Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Summoner\'s Cape',
        Waist = 'Hierarch Belt',
        Legs = {'Summoner\'s Spats', 'Savage Loincloth'},
        Feet = {'River Gaiters', 'Mannequin Pumps'},
    },
	
    ['Pet_Idle_Priority'] = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',	
        Ear2 = 'Beastly Earring',		
		Body = 'Austere Robe',
        Hands = 'Smn. Bracers +1',
		Ring2 = 'Evoker\'s Ring',
		Legs = 'Evoker\'s Spats',
		Feet = 'Evk. pigaches +1',
    },
	
    ['Resting_Priority'] = {
        Main = {'Pluto\'s Staff', 'Kukulcan\'s Staff', 'Pilgrim\'s Wand'},
		Neck = 'Checkered Scarf',
        Ear1 = 'Magnetic Earring',
		Ear2 = 'Relaxing Earring',
        Body = 'Errant Hpl.',
		Waist = 'Hierarch Belt',
		Legs = 'Baron\'s Slops',
    },
		
    ['Pet_TP_Priority'] = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Ear2 = 'Beastly Earring',		
		Body = 'Austere Robe',	
        Hands = 'Smn. Bracers +1',		
		Legs = 'Evoker\'s Spats',		
		Feet = 'Austere Sabots',		
    },

    Precast = {
        Ear2 = 'Loquac. Earring',
		Feet = 'Evoker\'s Boots',
    },

    Cure = {
		Main = 'Light Staff',
        Ear2 = 'Loquac. Earring',
		Body = 'Evoker\'s Doublet',
		Hands = 'Savage Gauntlets',
        Legs = 'Savage Loincloth',
		Feet = 'Rostrum Pumps',
    },
	
    SIRD = {
	
	},
		
    ['BPDown'] = {
		Head = "Austere Hat",
		Body = 'Yinyang Robe',
        Hands = 'Smn. Bracers +1',
		Legs = 'Summoner\'s Spats',
    },
    
	['Siphon'] = {
	
    },

	['PetPhys_Priority'] = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Ear2 = 'Beastly Earring',
        Hands = 'Smn. Bracers +1',
		Legs = 'Evoker\'s Spats',
		Feet = 'Austere Sabots',	
    },
	
	['PetMagic_Priority'] = {
        Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Ear1 = 'Relaxing Earring',
		Body = 'Shep. Doublet',
		Legs = 'Evoker\'s Spats',
		Feet = 'Austere Sabots',	
    },
	
	['PetWard'] = {
		Head = 'Evoker\'s Horn',
		Neck = 'Smn. Torque',
		Legs = 'Evoker\'s Spats',
	},
    
	['PetHealing'] = {--Avatar HP+
	
    },
	
	['PetMAcc_Priority'] = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Legs = 'Evoker\'s Spats',
		Feet = 'Austere Sabots',
    },
	
    ['PetHybrid_Priority'] = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Ear2 = 'Beastly Earring',
		Legs = 'Evoker\'s Spats',
		Feet = 'Austere Sabots',
    },
	
    ['sneakvis'] = {
        Ear2 = 'Loquac. Earring',
        Hands = 'Dream Mittens +1',
        Feet = 'Dream Boots +1',
        Back = 'Skulker\'s Cape',
    },
	
	['Movement'] = {
	
	},
	
};

local staves = {
    ['Fire'] = 'Bahamut\'s Staff',
    ['Earth'] = 'Bahamut\'s Staff',
    ['Water'] = 'Bahamut\'s Staff',
    ['Wind'] = 'Bahamut\'s Staff',
    ['Ice'] = 'Bahamut\'s Staff',
    ['Thunder'] = 'Bahamut\'s Staff',
    ['Light'] = 'Bahamut\'s Staff',
    ['Dark'] = 'Bahamut\'s Staff'
};

local summons = {
	['LightSpirit'] = 'Light',
	['Carbuncle'] = 'Light',
	['Fenrir'] = 'Dark',
	['Ifrit'] = 'Fire',
	['Titan'] = 'Earth',
	['Leviathan'] = 'Water',
	['Garuda'] = 'Wind',
	['Shiva'] = 'Ice',
	['Ramuh'] = 'Thunder',
	['Diabolos'] = 'Dark',
};

profile.Sets = sets;

profile.Packer = {};

local function HandlePetAction(PetAction)
	local BPName = string.sub(PetAction.Name,1,string.len(PetAction.Name)-1);
	if (pacts.Skill:contains(BPName)) then
        gFunc.EquipSet(sets.PetWard);
	elseif (pacts.Magic:contains(BPName)) then
        gFunc.EquipSet(sets.PetMagic);
    elseif (pacts.Hybrid:contains(BPName)) then
        gFunc.EquipSet(sets.PetHybrid);
	elseif (pacts.Heal:contains(BPName)) then
        gFunc.EquipSet(sets.PetHealing);
    elseif (pacts.MAcc:contains(BPName)) then
        gFunc.EquipSet(sets.PetMAcc);
    else
        gFunc.EquipSet(sets.PetPhys);
    end
end

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind M /map');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 /lac fwd toggleLac');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 /fillmode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /lac disable main');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind z //sneak <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind x //invisible <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind c //stoneskin me');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind v //blink me');
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind M');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F10');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind z');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind x');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind c');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind v');
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
	local pet = gData.GetPet();
	local petAction = gData.GetPetAction();
	local location = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);
	local zone = gData.GetEnvironment()	
	local DotW = zone.Day
	
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
    
	if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    end
	
	if DotW == 'Lightningday' then
		DotW = 'Thunderday'
	end
	
    if player.Status == 'Engaged' then
        gFunc.EquipSet(sets.TP);
    elseif pet ~= nil and pet.Status == 'Engaged' then
        gFunc.EquipSet(sets.Pet_TP);
		gFunc.Equip('main', staves[summons[pet.Name]])
		if pet.Name == 'Carbuncle' then
			gFunc.Equip('hands', 'Carbuncle Mitts')
			gFunc.Equip('body', 'Yinyang Robe')
			gFunc.Equip('feet', 'River Gaiters')
		end
		if string.match(DotW, summons[pet.Name]) then
			gFunc.Equip('body', 'Summoner\'s Dblt.')
		end
		if string.match(zone.Weather,summons[pet.Name]) then
			gFunc.Equip('head', 'Summoner\'s Horn')
		end

	elseif pet ~= nil and pet.Status == 'Idle' then
        gFunc.EquipSet(sets.Pet_Idle)
		gFunc.Equip('main', staves[summons[pet.Name]])
		if pet.Name == 'Carbuncle' then
			gFunc.Equip('hands', 'Carbuncle Mitts')
			gFunc.Equip('body', 'Yinyang Robe')
			gFunc.Equip('feet', 'River Gaiters')
		end
		if string.match(DotW, summons[pet.Name]) then
			gFunc.Equip('body', 'Summoner\'s Dblt.')
		end
		if string.match(zone.Weather,summons[pet.Name]) then
			gFunc.Equip('head', 'Summoner\'s Horn')
		end
    elseif (player.Status == 'Resting') then
		if restTimer == 0 then
			restTimer = os.clock() + 18;
		end

		if (os.clock() > restTimer) then
			gFunc.EquipSet(sets.Resting);
		end
	elseif T{230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246}:contains(location) then
		gFunc.EquipSet(profile.Sets.Idle);
		gFunc.LockStyle(sets.Style);
		if T{234, 235, 236, 237}:contains(location) then
			gFunc.Equip('Body', 'Republic Aketon');		
		end	
    else
		gFunc.EquipSet(sets.Idle);
		gFunc.LockStyle(sets.Style);
		restTimer = 0;
    end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
	
end

profile.HandleAbility = function()
	local ability = gData.GetAction();
    local ac = gData.GetBuffCount('Astral Conduit');
    if ac > 0 then return end

    if (ability.Name == 'Release') or (ability.Name == 'Avatar\'s Favor') or (ability.Name == 'Assault') or (ability.Name == 'Retreat') or (ability.Name == 'Apogee') then return end
		gFunc.EquipSet(sets.BPDown);

    if (ability.Name == 'Elemental Siphon') then
        gFunc.EquipSet(sets.Siphon);
    end
	
end

profile.HandleItem = function()
	local action = gData.GetAction();
	if (action.Name == 'Silent Oil') or (action.Name == 'Prism Powder') then
		gFunc.EquipSet(sets.sneakvis);
	end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    
	gFunc.EquipSet(sets.Precast);
	
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
	local target = gData.GetActionTarget();
    local me = gData.GetPlayer().Name

    if spell.Skill == 'Enhancing Magic' then
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
		    gFunc.EquipSet(sets.sneakvis);
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.sneakvis);
        end
    elseif (spell.Skill == 'Healing Magic') then
        if string.match(spell.Name, 'Cursna') then
            gFunc.EquipSet(sets.Cursna);
		else
			gFunc.EquipSet(sets.Cure);
        end
    elseif spell.Skill == 'Summoning Magic' then
        gFunc.EquipSet(sets.SIRD);		
	else
		gFunc.EquipSet(sets.SIRD);
    end
	
end

profile.HandlePreshot = function() 

end

profile.HandleMidshot = function()

end

profile.HandleWeaponskill = function()

    local ws = gData.GetAction();
    
    gFunc.EquipSet(sets.WS)
	
end

return profile;