local profile = {};

local Settings = {
	isEnabled = false;
	enmityMode = 1,
	skillMode = 1,
	sorcRingMode = 0,
    RestTimer = 0,
    CurrentLevel = 0,
};

local Staves = {
    ['Fire'] = 'Fire Staff',
    ['Earth'] = 'Terra\'s Staff',
    ['Water'] = 'Water Staff',
    ['Wind'] = 'Wind Staff',
    ['Ice'] = 'Aquilo\'s Staff',
    ['Thunder'] = 'Thunder Staff',
    ['Light'] = 'Light Staff',
    ['Dark'] = 'Pluto\'s Staff'
};

local Obis = {
	--Uncomment as you get them.
    --['Fire'] = 'Karin Obi',
    --['Earth'] = 'Dorin Obi',
    --['Water'] = 'Suirin Obi',
    --['Wind'] = 'Furin Obi',
    --['Ice'] = 'Hyorin Obi',
    --['Thunder'] = 'Rairin Obi',
    --['Light'] = 'Korin Obi',
    --['Dark'] = 'Anrin Obi'
}

local Spells = {
    Healing = T{"Cure", "Cure II", "Cure III", "Cure IV", "Curaga", "Curaga II", "Erase"},

    MndEnfeebling = {"Slow", "Slow II", "Paralyze", "Paralyze II", "Poison", "Poison II", "Banish", "Banish II"},

    IntEnfeebling = {"Sleep", "Sleep II", "Bind", "Gravity", "Blind", "Blaze Spikes", "Ice Spikes",
        "Shock Spikes"},
		
	Dark = {"Bio", "Bio II", "Drain", "Aspir"},
	 
    EleDebuffs = {"Rasp", "Drown", "Frost", "Burn", "Choke", "Shock"},

    Enhancing = {"Phalanx", "Stoneskin", "Enaero", "Enaero II", "Enfire", "Enfire II",
        "Enstone", "Enstone II", "Enthunder", "Enthunder II", "Enwater", "Enwater II",
        "Enblizzard", "Enblizzard II"},
    
    Buffs = {"Protect", "Protect II", "Protect III", "Protect IV", "Protectra", "Protectra II", "Protectra III",
     "Protectra IV", "Protectra V", "Shell", "Shell II", "Shell III", "Shell IV", "Shellra", "Shellra II",
     "Shellra III", "Shellra IV", "Shellra V", "Haste", "Refresh", "Aquaveil", "Blink"},

    Sneaking = {"Sneak", "Invisible"}
}

local Sets = {
    ['Idle_Piority'] = {
        Main = {'Terra\'s Staff', 'Casting Wand'},
		Sub = {'Solid Wand'},
        Ammo = 'Phtm. Tathlum',
        Head = 'Empress Hairpin',
        Neck = '',
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring',
        Body = 'Seer\'s tunic +1',
        Hands = 'Savage gauntlets',
        Ring1 = 'Eremite\'s ring',
        Ring2 = 'Eremite\'s ring',
        Back = 'Black Cape +1',
        Waist = 'Swift belt',
        Legs = 'Savage Loincloth',
        Feet = 'Mannequin pumps',
    },
		
	['Resting'] = {
        Main = 'Pluto\'s Staff',
        Head = 'Wizard\'s Petasos',
        Neck = 'Checkered Scarf',
        Ear1 = 'Relaxing Earring',
        Body = 'Errant Hpl.',
        Waist = 'Hierarch Belt',
		Legs = 'Barron\'s slops',
    },
	
    ['Precast'] = {
        Ear1 = 'Loquac. Earring',
        Feet = 'Rostrum Pumps',
    },
	
	['Nuke'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Seer\'s crown +1',
        Neck = 'Elemental Torque',
        Ear1 = 'Morion Earring',
        Ear2 = 'Moldavite Earring',
        Body = '',
        Hands = 'Seer\'s mitts +1',
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
        Back = 'Black cape +1',
        Waist = 'Mrc.Cpt. Belt',
        Legs = 'Seer\'s slacks +1',
        Feet = 'Mannequin pumps',
    },
		
	['EleDebuff'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Src. Petasos +1',
        Neck = 'Elemental Torque',
        Ear1 = 'Morion Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Igqira Weskit',
        Hands = 'Wizard\'s Gloves',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Rainbow Cape',
        Waist = 'Sorcerer\'s Belt',
        Legs = 'Mahatma Slops',
        Feet = 'Src. Sabots +1',
    },
	
	['Enfeebling'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Seer\'s crown +1',
        Neck = 'Elemental Torque',
        Ear1 = 'Morion Earring',
        Ear2 = 'Moldavite Earring',
        Body = '',
        Hands = 'Seer\'s mitts +1',
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
        Back = 'Black cape +1',
        Waist = 'Mrc.Cpt. Belt',
        Legs = 'Seer\'s slacks +1',
        Feet = 'Mannequin pumps',
    },
	
	['MNDEnfeeb'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Seer\'s crown +1',
        Neck = 'Elemental Torque',
        Ear1 = 'Morion Earring',
        Ear2 = 'Moldavite Earring',
        Body = '',
        Hands = 'Seer\'s mitts +1',
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
        Back = 'Black cape +1',
        Waist = 'Mrc.Cpt. Belt',
        Legs = 'Seer\'s slacks +1',
        Feet = 'Mannequin pumps',
    },
	
	['Drain'] = {
        Head = 'Wizard\'s Petasos',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Novia Earring',
        Body = 'Igqira Weskit',
        Hands = 'Sorcerer\'s Gloves',
        Waist = 'Sorcerer\'s Belt',
        Legs = 'Wizard\'s Tonban',
        Feet = 'Src. Sabots +1',
    },

    ['Cure'] = {
		Main = 'Light Staff',
        Head = 'Errant Hat',
        Neck = 'Justice Badge',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Novia Earring',
        Body = 'Errant Hpl.',
        Hands = 'Sorcerer\'s Gloves',
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
        Back = 'Rainbow Cape',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
        Feet = 'Mahatma Pigaches',
    },
		
	['SneakVis'] = {
		Hands = 'Dream Mittens +1',
		Feet = 'Dream Boots +1',
		Back = 'Skulker\'s Cape',
    },
		
	['Movement'] = {
		Feet = 'Herald\'s Gaiters',
	},
	
    ['Stoneskin'] = {
        Main = 'Kirin\'s Pole',
        Head = 'Errant Hat',
        Neck = 'Justice Badge',
        Ear1 = 'Loquac. Earring',
        Body = 'Errant Hpl.',
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
        Back = 'Rainbow Cape',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
        Feet = 'Mahatma Pigaches',
    },
	
    ['Nuke_LowSkillLowEnmity'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Wizard\'s Petasos',
        Neck = 'Checkered Scarf',
        Ear1 = 'Novio Earring',
        Ear2 = 'Moldavite Earring',
        Body = 'Igqira Weskit',
        Hands = 'Zenith Mitts',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Rainbow Cape',
        Waist = 'Sorcerer\'s Belt',
        Legs = 'Mahatma Slops',
        Feet = 'Src. Sabots +1',
    },
	
    ['Nuke_HighSkillLowEnmity'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Src. Petasos +1',
        Neck = 'Elemental Torque',
        Ear1 = 'Novio Earring',
        Ear2 = 'Moldavite Earring',
        Body = 'Errant Hpl.',
        Hands = 'Wizard\'s Gloves',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Rainbow Cape',
        Waist = 'Sorcerer\'s Belt',
        Legs = 'Mahatma Slops',
        Feet = 'Src. Sabots +1',
    },
	
    ['Nuke_LowSkillHighEnmity'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Errant Hat',
        Neck = 'Checkered Scarf',
        Ear1 = 'Novio Earring',
        Ear2 = 'Novia Earring',
        Body = 'Errant Hpl.',
        Hands = 'Wizard\'s Gloves',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Rainbow Cape',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
        Feet = 'Src. Sabots +1',
    },
	
	['Nuke_HighSkillHighEnmity'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Src. Petasos +1',
        Neck = 'Elemental Torque',
        Ear1 = 'Novio Earring',
        Ear2 = 'Novia Earring',
        Body = 'Errant Hpl.',
        Hands = 'Wizard\'s Gloves',
        Ring1 = 'Diamond Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Rainbow Cape',
        Waist = 'Penitent\'s Rope',
        Legs = 'Mahatma Slops',
        Feet = 'Src. Sabots +1',
    },
	
    ['SorcRingHPSwap'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Zenith Crown',
		Neck = 'Checkered Scarf',
        Hands = 'Errant Cuffs',
        Ring1 = 'Ether Ring',
        Ring2 = 'Astral Ring',
        Back = 'Blue Cape',
        Waist = 'Penitent\'s Rope',
        Legs = 'Zenith Slacks',
        Feet = 'Rostrum Pumps',
    },
	
}

profile.Packer = {};

profile.OnLoad = function()
	gSettings.AllowAddSet = true
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /blm /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 /blm enmityMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 /blm skillMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F12 /blm sorcRingMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind z //sneak <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind x //invisible <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind c //stoneskin me');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind v //blink me');
end

profile.OnUnload = function()
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /blm /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F9');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F10');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F12');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind z');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind x');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind c');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind v');
end

profile.HandleCommand = function(args)

	--Enmity Mode Toggle
    if (args[1] == 'enmityMode') then
        if (Settings.enmityMode == 1) then
            gFunc.Echo(158, "Enmity Mode OFF")
            Settings.enmityMode = 0
        else
            gFunc.Echo(158, "Enmity Mode ON")
            Settings.enmityMode = 1
        end
    end	
	
	--Skill Mode Toggle
    if (args[1] == 'skillMode') then
        if (Settings.skillMode == 1) then
            gFunc.Echo(158, "Skill Mode OFF")
            Settings.skillMode = 0
        else
            gFunc.Echo(158, "Skill Mode ON")
            Settings.skillMode = 1
        end
    end
	
	--Sorc Ring Toggle
    if (args[1] == 'sorcRingMode') then
        if (Settings.sorcRingMode == 1) then
            gFunc.Echo(158, "Sorc Ring OFF")
            Settings.sorcRingMode = 0
        else
            gFunc.Echo(158, "Sorc Ring ON")
            Settings.sorcRingMode = 1
        end
    end
	
end

--Default State. Acts as aftercast and state change combined. Constantly checks.
profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local loc = gData.GetEnvironment().Area;

	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
	
    if (player.Status ==  'Engaged') then
        gFunc.EquipSet(Sets.TP); 
        Settings.RestTimer = 0;
    elseif (player.Status == 'Resting') then
        if Settings.RestTimer == 0 then
            Settings.RestTimer = os.clock() + 18;
        end

        if (os.clock() > Settings.RestTimer) then
            gFunc.EquipSet(Sets.Resting);
        end
    else
        gFunc.EquipSet(Sets.Idle); 
        Settings.RestTimer = 0;
    end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(Sets.Movement);
	end
    profile.CheckCity(loc);
end

--Precast for Job Ability
profile.HandleAbility = function()
	local ability = gData.GetAction()
	
end

--Precast for Item
profile.HandleItem = function()
    local item = gData.GetAction()

	if string.match(item.Name, 'Silent Oil') or string.match(item.Name, 'Prism Powder') then 
		gFunc.EquipSet(Sets.SneakVis)
	end
end

--Precast Function
profile.HandlePrecast = function()
    local spell = gData.GetAction()
    
	gFunc.EquipSet(Sets.Precast)
	if (spell.Skill == 'Elemental Magic') then
        if (EleDebuffs:contains(spell)) then
            gFunc.EquipSet(Sets.Precast)	
		elseif (Settings.sorcRingMode == 1) and Settings.skillMode == 1 then
			gFunc.Echo(158, "Skill Mode is ON, Failed to swap to sorc ring")
		elseif (Settings.sorcRingMode == 1) and Settings.skillMode == 0 then
			gFunc.EquipSet(Sets.SorcRingHPSwap);
            gFunc.EquipSet(Sets.Precast)
		end
	end
	
end

--Midcast Function
profile.HandleMidcast = function()
    local spell = gData.GetAction()
	local target = gData.GetActionTarget()
    local environment = gData.GetEnvironment();
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0)

    --Elemental Magic Spells
    if spell.Skill == 'Elemental Magic' then
        if (EleDebuffs:contains(spell)) then
            gFunc.EquipSet(Sets.EleDebuff)
        else
			--Main Nuke Method
			if Settings.enmityMode == 1 then
				if Settings.skillMode == 1 then
					gFunc.EquipSet(Sets.Nuke_HighSkillHighEnmity);
				else
					gFunc.EquipSet(Sets.Nuke_LowSkillHighEnmity);
				end
			else
				if Settings.skillMode == 1 then
					gFunc.EquipSet(Sets.Nuke_HighSkillLowEnmity);
				else
					gFunc.EquipSet(Sets.Nuke_LowSkillLowEnmity);
				end
			end
            gFunc.Equip('main', Staves[spell.Element]);
            --UggyPendant Check
            if UggyPendant(spell) and Settings.skillMode == 0 then
				gFunc.Equip('neck', 'Uggalepih pendant')
            end
            --SorcRing Check
            if RingActive() and Settings.skillMode == 0 then
				gFunc.Equip('Ring1', 'Sorcerer\'s Ring')
            end
            --ObiApplication Check
            if ObiCheck(spell) >= 1 then
                gFunc.Equip('waist', Obis[spell.Element])
            end
			--Sorceror's Tonban Check
			if (environment.DayElement == spell.Element) then
                gFunc.Equip('Legs', 'Sorcerer\'s Tonban');
            end
        end
			
	--Enfeebling Magic Spells
	elseif spell.Skill == 'Enfeebling Magic' then
		--MND Based Enfeebling Trigger
		if (MndEnfeebling:contains(spell)) then
			gFunc.EquipSet(Sets.MNDEnfeeb)
		--Standard Enfeebling Trigger
		else
			gFunc.EquipSet(Sets.Enfeebling)
		end
		gFunc.Equip('main', Staves[spell.Element])
			
	--Dark Magic Spells
	elseif spell.Skill == 'Dark Magic' then
        gFunc.EquipSet(Sets.Drain)
		gFunc.Equip('main', Staves[spell.Element])
		--Dark Obi does apply to Drain/Aspir
		if ObiCheck(spell) >= 1 then
			gFunc.Equip('waist', Obis[spell.Element])
		end
	
	--Enhancing Magic Spells
	elseif spell.Skill == 'Enhancing Magic' then
		--Sneak Gear
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
            gFunc.EquipSet(Sets.Sneak)
		--Invisible Gear
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(Sets.Invisible)
		--Standard Enfeebling
		elseif string.match(spell.Name, 'Stoneskin') then
			gFunc.EquipSet(Sets.Stoneskin)
		else
			gFunc.EquipSet(Sets.Enhancing)
        end
		
	--Healing Magic Spells
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(Sets.Cure)
    
    --Spell Interupt / Haste Default Set	
	else
		gFunc.EquipSet(Sets.SIRD)
    end
	
end

--Weaponskill Function
profile.HandleWeaponskill = function()

    local ws = gData.GetAction()
    
    gFunc.EquipSet(Sets.WS)
	
end

--Checks for Obi Applicability. Accounts for negative weather/day associations. Obi must hit 10% to pass. 
function ObiCheck(spell)
	local element = spell.Element
	local zone = gData.GetEnvironment()
	
	local badEle = {
		['Fire'] = 'Water',
		['Earth'] = 'Wind',
		['Water'] = 'Thunder',
		['Wind'] = 'Ice',
		['Ice'] = 'Fire',
		['Thunder'] = 'Earth',
		['Light'] = 'Dark',
		['Dark'] = 'Light'
	};
	
	local weight = 0
	
	--Day comparison
	if string.find(zone.Day, spell.Element) then
		weight = weight + 1
	elseif string.find(zone.Day, badEle[spell.Element]) then
		weight = weight - 1
	end
	
	--Weather comparison
	if string.find(zone.Weather, spell.Element) then
		if string.find(zone.Weather, 'x2') then
			weight = weight + 2
		else
			weight = weight + 1
		end
	elseif string.find(zone.Weather, badEle[spell.Element]) then
		if string.find(zone.Weather, 'x2') then
			weight = weight - 2
		else
			weight = weight - 1
		end
	end	
	
	return weight

end

--Checks for Sorc Ring latent.
function RingActive()
	local player = gData.GetPlayer()
	
	if player.HPP <= 75 and player.TP <= 1000 then
		return true
	end
	
	return false
	
end

--Checks for Uggy Pendant latent.
function UggyPendant(spell)
	local player = gData.GetPlayer()
	
	if spell.MppAftercast  <= 50 then
		return true
	end
	
	return false
	
end

--Checks for location if main city
profile.CheckCity = function(loc)
    if (string.match(loc, "Bastok")) or (string.match(loc, "Metalworks")) then
        gFunc.Equip('Body', "Republic Aketon");
    elseif (string.match(loc, "Windurst")) or (string.match(loc, "Heavens Tower")) then
        --gFunc.Equip('Body', '')
    elseif (string.match(loc, "San d\'Oria")) or (string.match(loc, "d\'Oraguille")) then
        gFunc.Equip('Body', 'Tanner\'s apron')
		gFunc.Equip('Hands', 'Tanner\'s gloves')
    end
end

return profile;