local profile = {};

local Settings = {
    CurrentLevel = 0,
	restTimer = 0;
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
		Head = 'Opo-opo Crown',
	},
	
	['Town'] = {

	},
	
    ['Idle_Priority'] = {
        Main = {'Earth Staff'},
        Ammo = 'Hedgehog Bomb',
        Head = 'Faerie Hairpin',
        Neck = 'Fenrir\'s torque',
        Ear1 = 'Morion Earring',
        Ear2 = 'Magnetic Earring',
        Body = {'Yinyang Robe', 'Shep. Doublet', 'Seer\'s Tunic +1'},
        Hands = {'Evoker\'s Bracers', 'Savage Gauntlets'},
        Ring1 = {'Ether Ring'},
        Ring2 = {'Evoker\'s Ring'},
        Back = {'Summoner\'s Cape', 'White Cape'},
        Waist = {'Hierarch Belt', 'Hojutsu Belt'},
        Legs = {'Summoner\'s Spats', 'Savage Loincloth'},
        Feet = {'Rostrum Pumps', 'Evoker\'s Pigaches', 'Mannequin Pumps'},
    },
	
    ['Pet_Idle_Priority'] = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',		
		Body = 'Austere Robe',
		Ring2 = 'Evoker\'s Ring',
		Legs = 'Evoker\'s Spats',
		Feet = 'Austere Sabots',
    },
	
    ['Resting_Priority'] = {
        Main = {'Dark Staff', 'Kukulcan\'s Staff', 'Pilgrim\'s Wand'},
		Neck = 'Checkered Scarf',
		Ear1 = 'Relaxing Earring',
        Body = {'Errant Hpl.', 'Seer\'s Tunic +1'},
		Waist = 'Hierarch Belt',
		Legs = 'Baron\'s Slops',
    },
		
    ['Pet_TP_Priority'] = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Ear2 = 'Beastly Earring',		
		Body = 'Austere Robe',		
		Legs = 'Evoker\'s Spats',		
		Feet = 'Austere Sabots',		
    },

    Precast = {
		Feet = 'Evoker\'s Boots',
    },

    Cure = {
		Main = 'Light Staff',
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
		Legs = 'Summoner\'s Spats',
    },
    
	['Siphon'] = {
	
    },

	['PetPhys_Priority'] = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Ear2 = 'Beastly Earring',
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
		Head = "Austere Hat",
		Neck = 'Smn. Torque',
		Legs = 'Evoker\'s Spats',
		Feet = 'Austere Sabots',
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
        Hands = 'Dream Mittens +1',
        Feet = 'Dream Boots +1',
    },
	
	['Movement'] = {
	
	},
	
};

local staves = {
    ['Fire'] = 'Fire Staff',
    ['Earth'] = 'Earth Staff',
    ['Water'] = 'Water Staff',
    ['Wind'] = 'Wind Staff',
    ['Ice'] = 'Ice Staff',
    ['Thunder'] = 'Thunder Staff',
    ['Light'] = 'Light Staff',
    ['Dark'] = 'Dark Staff'
};

local summons = {
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
end

profile.OnUnload = function()

end

profile.HandleCommand = function(args)

end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
	local pet = gData.GetPet();
	local petAction = gData.GetPetAction();
	local zone = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);
	
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
    
	if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    end
	
    if player.Status == 'Engaged' then
        gFunc.EquipSet(sets.TP);
    elseif pet ~= nil and pet.Status == 'Engaged' then
        gFunc.EquipSet(sets.Pet_TP);
		gFunc.Equip('main', staves[summons[pet.Name]])
	elseif pet ~= nil and pet.Status == 'Idle' then
        gFunc.EquipSet(sets.Pet_Idle)
		gFunc.Equip('main', staves[summons[pet.Name]])
		if pet.Name == 'Carbuncle' then
			gFunc.Equip('hands', 'Carbuncle Mitts')
		end
    elseif (player.Status == 'Resting') then
		if restTimer == 0 then
			restTimer = os.clock() + 18;
		end

		if (os.clock() > restTimer) then
			gFunc.EquipSet(sets.Resting);
		end
	elseif T{230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246}:contains(zone) then
		gFunc.EquipSet(profile.Sets.Idle);
		gFunc.LockStyle(sets.Style);
		if T{234, 235, 236, 237}:contains(zone) then
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