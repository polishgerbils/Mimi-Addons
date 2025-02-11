local profile = {
};

local Settings = {
    TpVariant = 'Default',
	IdleVariant = 'Default',
	DT = 'OFF',
	mpp = 70,
	RI = 'true',
	Disonce = 'true',
	Enonce = 'true',
	Enmity = 'false',
	Hpt = 0,
	gigantswap = 'Gigant mantle',
	resentmentswap = 'Gigant mantle',
	absorbmacc = false,
	drainmacc = false,
	movetoggle = true,
	stunmacc = false,
	movement = false,
	Vcloak = false,
	Whead = false,
	Parade = false,
	Slayer = false,
	Fenrir = false,
	Gloom = false,
	Touchdown = false,
	aspirmacc = false,
	Subjob = {
		NIN = false,
		SAM = false,
		THF = false,
	}
};

profile.OnLoad = function()
    local player = gData.GetPlayer();
    gSettings.AllowAddSet = false;
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind M /map');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 /fillmode');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias /drk /lac fwd');
	gFunc.ApplyBaseSets(profile.Sets);	
	if (player.SubJob == 'SAM') then
		Settings.Hpt = 10;
	elseif (player.SubJob == 'NIN') then
		Settings.Hpt = 0;	
	end
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind M');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F10');
    AshitaCore:GetChatManager():QueueCommand(1, '/alias delete /drk');
end

profile.HandleCommand = function(args)
     if (args[1] == 'movetoggle') then
        if (#args > 1) then
            Settings.movetoggle = args[2];
			gFunc.Echo(135,Settings.movetoggle)				
        end
    end   
	if (args[1] == 'tpset') then
        if (#args > 1) then
            Settings.TpVariant = args[2];
			gFunc.Echo(135,Settings.TpVariant)				
        end
    end
    if (args[1] == 'Touchdown') then
		if (Settings.DT == 'fr') or (Settings.DT == 'ir') then
            Settings.Touchdown = true;
			gFunc.Echo(135,"TD mode on")	
		end
    end
    if (args[1] == 'absorbmacc') then
            Settings.absorbmacc = not Settings.absorbmacc;
		if (Settings.absorbmacc == true) then
			gFunc.Echo(200,"Absorb macc ON")
		elseif (Settings.absorbmacc == false) then
			gFunc.Echo(135,"Absorb macc OFF")			
		end				
    end	
    if (args[1] == 'drainmacc') then
            Settings.drainmacc = not Settings.drainmacc;
		if (Settings.drainmacc == true) then
			gFunc.Echo(200,"Drain macc ON")
		elseif (Settings.drainmacc == false) then
			gFunc.Echo(135,"Drain macc OFF")			
		end					
    end
	if (args[1] == 'aspirmacc') then
            Settings.aspirmacc = not Settings.aspirmacc;
		if (Settings.aspirmacc == true) then
			gFunc.Echo(200,"Aspir macc ON")
		elseif (Settings.aspirmacc == false) then
			gFunc.Echo(135,"Aspir macc OFF")			
		end				
    end	
	if (args[1] == 'stunmacc') then
            Settings.stunmacc = not Settings.stunmacc;
		if (Settings.stunmacc == true) then
			gFunc.Echo(200,"Stun macc ON")
		elseif (Settings.stunmacc == false) then
			gFunc.Echo(135,"Stun macc OFF")			
		end					
				
    end
	if (args[1] == 'idleset') then
        if (#args > 1) then
            Settings.IdleVariant = args[2];
			gFunc.Echo(135,Settings.IdleVariant)	
	    end
    end
	if (args[1] == 'mpp') then
        if (#args > 1) then
            Settings.mpp = tonumber(args[2]);
			gFunc.Echo(135,Settings.mpp)
        end
    end
	if (args[1] == 'RI') and (Settings.RI ~= 'OFF') then
        if (#args > 1) then
            Settings.RI = args[2];
			gFunc.Echo(135,Settings.RI)
        end
    end
	if (args[1] == 'Enmity') then
        Settings.Enmity = not Settings.Enmity;
		if (Settings.Enmity == true) then
			gFunc.Echo(200,"Enmity mode >>>>>>Enabled<<<<<<")
		elseif (Settings.Enmity == false) then
			gFunc.Echo(135,"Enmity mode *OFF*")			
		end	
    end
	if (args[1] == 'Gloom') then
        Settings.Gloom = not Settings.Gloom;
		if (Settings.Gloom == true) then
			gFunc.Echo(200,"Gloom mode ON")
		elseif (Settings.Gloom == false) then
			gFunc.Echo(135,"Gloom mode OFF")			
		end	
    end	
	if (args[1] == 'movement') then
        Settings.movement = not Settings.movement;
		if (Settings.movement == true) then
			gFunc.Echo(200,"Movement mode ON")
		elseif (Settings.movement == false) then
			gFunc.Echo(135,"Movement mode Off")			
		end	
    end	
	
	if (args[1] == 'Enmityon') then
        Settings.Enmity = true;
		if (Settings.Enmity == true) then
			gFunc.Echo(200,"Enmity mode >>>>>>Enabled<<<<<<")
		elseif (Settings.Enmity == false) then
			gFunc.Echo(135,"Enmity mode *OFF*")			
		end	
    end		
	if (args[1] == 'DT') then
        if (#args > 1) then
			if (Settings.DT==args[2]) then
				Settings.DT = 'OFF'
			else	
				Settings.DT = args[2];
			end
			 
        end
		gFunc.Echo(135,Settings.DT)
    end
	
end


local sets = {
--*********************************IDLE SETS**********************
	Idle_Default = {
		Ammo = {Name = 'Happy Egg', Priority = 99},
		Head = 'Darksteel Cap +1',
		Neck = {Name = 'Ajase Beads', Priority = 100},
		Ear1 = 'Merman\'s Earring',
		Ear2 = 'Merman\'s Earring',
		Body = 'Dst. Harness +1',
		Hands = 'Dst. Mittens +1',
		Ring1 = 'Merman\'s Ring',
		Ring2 = {Name = 'Merman\'s Ring', Priority = 100},
		Back = 'Boxer\'s mantle',
		Waist = {Name = 'Jungle Sash', Priority = 100},
		Legs = {Name = 'Blood Cuisses', Priority = 100},
		Feet = 'Dst. Leggings +1',
	},
--***********************Physical damage taken set*************************	
	PDT = {
		Head = 'Darksteel Cap +1',
		Neck = 'ajase beads',		
		Ear1 = {Name = 'Pigeon Earring +1', Priority = 99},
		Ear2 = {Name = 'Pigeon Earring +1', Priority = 99},
		Body = 'Dst. Harness +1',
		Hands = 'Dst. Mittens +1',
		Ring1 = 'Jelly ring',
		Ring2 = {Name = 'Merman\'s Ring', Priority = 100},
		Back = Settings.gigantswap,
		Waist = {Name = 'Jungle Sash', Priority = 100},
		Legs = 'Dst. Subligar +1',
		Feet = 'Dst. Leggings +1',
	},
	Slayer = {
		Head = 'Homam Zucchetto',
		Neck = 'ajase beads',
		Ear1 = 'Slayer\'s Earring',
		Ear2 = 'Pigeon Earring +1',
		Body = 'Homam Corazza',
		Hands = 'Crimson Fng. Gnt.',
		Ring1 = 'Bomb Queen Ring',
		Ring2 = 'Sattva Ring',
		Back = 'Gigant Mantle',
		Waist = 'Jungle Sash',
		Legs = 'Blood Cuisses',
		Feet = 'Homam Gambieras',
	},	
--***********************Magica damage taken set***************************
	MDT = {
		BaseSet = 'PDT',
		Head = 'Coral Visor +1',
		Body = 'Cor. Scale Mail +1',
		Hands = 'Coral Fng. Gnt. +1',
		Ring1 = 'Merman\'s Ring',
		Ring2 = 'Sattva Ring',
		Waist = 'Jungle Sash',
		Ear1 = 'Merman\'s Earring',
		Ear2 = 'Merman\'s Earring',
		Back = Settings.resentmentswap,
		Legs = 'Abs. Flanchard +1' ,
		Feet = 'Coral Greaves +1',
	},	

--*************Misc resist sets*****************	
	fr = {
		Main = 'Hrotti',
		Sub = 'Furnace Tabarzin',
		Ammo = 'Happy Egg',
		Head = 'Tsoo\'s headgear',
		Neck = 'Jeweled Collar',
		Ear1 = 'Triumph Earring',
		Ear2 = 'Tmph. Earring +1',
		Body = 'Assault Brstplate',
		Hands = 'Tarasque mitts +1',
        Ring1 = 'Triumph Ring',
		Ring2 = 'Triumph Ring',
		Back = 'Dino Mantle',
		Waist = 'Water Belt',
		Legs = 'Blood Cuisses',
		Feet = 'Power Sandals',
    },		
	er = {
		Main = 'Wind Staff',
		Head = 'Tsoo\'s headgear',
		Neck = 'Clay Amulet',
		Ear1 = 'Topaz Earring',
		Ear2 = 'Topaz Earring',
		Body = 'Assault Brstplate',
		Hands = 'Sand Gloves',
		Ring1 = 'Topaz Ring',
		Ring2 = 'Maldust ring',
		Back = 'Gaia Mantle +1',
		Waist = 'Wind Belt',
		Legs = 'Beak Trousers +1',
		Feet = 'Blood Greaves',
    },
	ir = {
		Main = 'Vulcan\'s Staff',
		Head = 'Snowman Cap',
		Neck = 'Jeweled Collar',
		Ear1 = 'Triumph Earring',
		Ear2 = 'Tmph. Earring +1',
        Body = 'Assault Brstplate',
		Hands = 'Feral Gloves',
		Ring1 = 'Omniscient Ring',
		Ring2 = 'Omniscient Ring',
		Back = 'Ram Mantle +1',
		Waist = 'Fire Belt',
		Legs = 'Feral Trousers',
		Feet = 'Blood Greaves',
    },		
	lr = {
		BaseSet = 'mdt',
		Head = 'Tsoo\'s headgear',
		Neck = 'Jeweled Collar',
		Ear1 = 'Topaz Earring',
		Ear2 = 'Topaz Earring',
		Body = 'Assault Brstplate',
		Hands = 'Heavy Gauntlets',
		Waist = 'Earth Belt',
		Ring1 = 'Spinel ring',
		Ring2 = 'Malflash ring',
		Back = 'Gaia Mantle +1',
		Legs = 'Blood Cuisses',
		Feet = 'Dst. Leggings +1',
    },
	wr = {
		BaseSet = 'mdt',
		Head = 'Tsoo\'s headgear',
		Neck = 'Jeweled Collar',
		Ear1 = 'Pigeon Earring +1',
		Ear2 = 'Pigeon Earring +1',
		Body = 'Assault Brstplate',
		Hands = 'Coral Fng. Gnt. +1',
		Waist = 'Earth Belt',
		Ring1 = 'Sapphire Ring',
		Ring2 = 'Sapphire Ring',
		Back = resentmentswap,
		Legs = 'Blood Cuisses',
    },		

	Idle_Tank = {
		BaseSet = 'PDT',
		Main = 'Terra\'s Staff',
		Ammo = 'Happy Egg',
        Ear1 = 'Pigeon Earring +1',
        Ear2 = 'Pigeon Earring +1',		
        Ring1 = 'Bomb Queen Ring',
		Back = Settings.gigantswap,
    },
	Idle_Tankpdt = {
		BaseSet = 'Idle_Tank',
        Ring1 = 'Jelly Ring',
		Back = 'Shadow mantle',
    },	
	Idle_MDT = {
		BaseSet ='MDT',
		Head = 'Coral Visor +1',
		Neck = 'Parade Gorget',
		Body = 'Cor. Scale Mail +1',
		Hands = 'Coral Fng. Gnt. +1',
		Ring1 = 'Merman\'s Ring',
		Ring2 = 'Sattva Ring',
		Ear1 = 'Merman\'s Earring',
		Ear2 = 'Merman\'s Earring',
	    Back = 'Gigant Mantle',
		Waist = 'Jungle Sash',
		Legs = 'Blood Cuisses' ,
	},
	Idle_KB = {
		BaseSet = 'Idle_MDT',
		Body = 'Assault Brstplate',
		Legs = 'Blood Cuisses',
	},
	Idle_BDT = {
		BaseSet= 'Idle_Tank',
		Head = 'Homam Zucchetto',
		Ring1 = 'Bomb queen Ring',
		Back = 'Gigant Mantle',
		Feet = 'Homam Gambieras',
	},	
--***************Zerg set ***********************	
    Zerg = {
  		Head = 'Ace\'s Helm',
		Ammo = 'Happy Egg',
        Neck = 'ajase beads',
        Ear1 = 'Pigeon Earring +1',
        Ear2 = 'Pigeon Earring +1',
        Body = 'Gloom Breastplate',
        Hands = 'Homam Manopolas', 
        Ring1 = 'Blitz Ring',
        Ring2 = 'Bomb Queen Ring',
        Back = 'Gigant mantle',
		Waist = 'Swift Belt',
        Legs = 'Homam Cosciales',
        Feet = 'Homam Gambieras',
    },	

-- **********ENGAGED SETS HERE *************	
    Tp_Default = {
		Ammo = 'Bomb Core',
  		Head = 'Optical hat',
        Neck = 'Peacock Amulet',
        Ear1 = 'Abyssal Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Haubergeon +1',
        Hands = 'Homam Manopolas', 
        Ring1 = 'Toreador\'s Ring',		
        Ring2 = 'Rajas Ring',
        Back = 'Forager\'s Mantle',
		Waist = 'Swift Belt',
        Legs = 'Homam Cosciales',
        Feet = 'Homam Gambieras',
    },
	Tp_Default_A = {
		BaseSet = 'Tp_Default',
		ring1 = 'Toreador\'s Ring',
		hands = 'Armada Mufflers',
        Waist = 'Swift Belt',		
		Feet = 'Armada Sollerets',
		

	},
	Tp_Gigas = {
		BaseSet = 'Tp_Default',
		ring1 = 'Triumph Ring',
		ring2 = 'Triumph Ring',
	},
	Tp_Gigas_A = {
		BaseSet = 'Tp_Default',
		ring1 = 'Triumph Ring',
		ring2 = 'Triumph Ring',
        Waist = 'Swift Belt',				
		hands = 'Armada Mufflers',
		Feet = 'Armada Sollerets',				
	},	
	
	Tp_acc = {
		BaseSet = 'Tp_Default',
        Ring1 = 'Toreador\'s Ring',	
		Back = 'Abyss Cape',
    },
	Tp_acc_A = {
		BaseSet = 'Tp_acc',
		hands = 'Armada Mufflers',	
        Waist = 'Swift Belt',				
		Feet = 'Armada Sollerets',		
    },	
	
	Tp_Tank = {	
		BaseSet='idle_Tank',		
	},
	Tp_Tankpdt = {
		BaseSet='Idle_Tankpdt',
	},
	Tp_Tank_A = {	
		BaseSet='Tp_Tank',		
	},	
	
	Tp_BDT = {	
		BaseSet='idle_BDT',		
	},
	Tp_BDT_A = {	
		BaseSet='Tp_BDT',		
	},
	
	Tp_Def = {
		BaseSet='tp_default',
        Ear1 = 'Pigeon Earring +1',
        Body = 'Homam Corazza',
        Hands = 'Homam Manopolas',
        Ring1 = 'Bomb Queen Ring',
        Ring2 = 'Sattva Ring',
        Back = Settings.gigantswap,
 		Waist = 'Swift Belt',
        Legs = 'Homam Cosciales',
    },
	Tp_Def_A = {
		BaseSet='tp_Def',
     },	

	Tp_Tankhp = {
		BaseSet = 'Tp_Tank',
        Hands = 'Homam Manopolas',
        Waist = 'Jungle Sash',
        Legs = 'Homam Cosciales',
    },
	Tp_Tankhp_A = {
		BaseSet = 'Tp_Tankhp',
    },
	
	Tp_MDT = {
		BaseSet = 'MDT',
	},
	Tp_MDT_A = {
		BaseSet = 'MDT',
	},	
	
--**********************Resting /set*****************************	
    Resting = {
		BaseSet = 'Idle_Default',
		Neck = 'checkered scarf',
		Waist = 'Hierarch Belt', 
		Ear1 = 'Relaxing earring',
		Ear2 = 'Magnetic earring',
		Legs = 'Baron\'s slops',
	},
--*********************Weaponskill sets*************************	
	DefaultWS = {
		Head = 'Chaos burgeonet',
        Neck = 'Peacock Amulet',
        Ear1 = 'Abyssal Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Adaman Hauberk',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Triumph Ring',
        Ring2 = 'Triumph Ring',
		Back = 'Forager\'s Mantle',
        Waist = 'Warwolf Belt',
        Legs = 'Onyx Cuisses',
        Feet = 'Onyx Sollerets',
	},
	CataWS = {
		BaseSet = 'DefaultWS',
        Ear1 = 'Triumph Earring',
		Hands = 'Alkyoneus\'s Brc.',
		Ring1 = 'Flame Ring',
		Ring2 = 'Flame Ring',
    },	
--***********************Misc sets*****************************	
	Enmity = {    
		Head = 'Bahamut\'s mask',
		Neck = 'Harmonia\'s Torque',
		Ear1 = 'Hades Earring +1',		
		Ear2 = 'Hades Earring +1',
		Body = 'Hydra Haubert',
        Hands = 'Hydra Moufles',
		Ring1 = 'Mermaid Ring',
		Ring2 = 'Sattva Ring',
		Back = 'Resentment Cape',
		Waist = 'Warwolf belt',
		Legs = 'Hydra Brayettes',
		Feet = 'Hydra Sollerets',
		
 	},
	Haste = {
		Head = 'Homam Zucchetto',
		Body = 'Dst. harness +1',
		Waist = 'Swift Belt',
		Hands = 'Homam Manopolas',
		Ring1 = 'Blitz ring',
		Ear1 = 'Loquac. Earring',
		Legs = 'Homam Cosciales',	
		Feet = 'Homam Gambieras',
    },
	 Macc = {
		Ammo = 'Phtm. Tathlum',
		Head = 'Homam Zucchetto',
		Back = 'Abyss Cape',
		Ring1 = 'Omniscient Ring',
		Ring2 = 'Omniscient Ring',		
		Ear1 = 'Abyssal Earring',
		Ear2 = 'Morion Earring +1',
	 },
	Dark = {
		BaseSet = 'Macc',
		Ear1 = 'Abyssal Earring',
		Head = 'Chaos Burgeonet',
		Hands = 'Crimson fng. Gnt.',
		Legs = 'Abs. Flanchard +1',
	},
	Fastcast = {
		Ear1 = 'Loquac. earring',
		Legs = 'Homam Cosciales',
	},
	SIR = {
		Ear2 = 'Magnetic Earring',
		Back = 'Shadow mantle',
	},
	Shadow = {
		Back = 'Shadow mantle',
	},	
	Enfeebling = {
		BaseSet = 'Macc',
		Head = 'Crimson Mask',
		Neck = 'enfeebling torque',		
	},
};
local ElementalStaffTable = {
    ['Fire'] = 'Vulcan\'s Staff',
    ['Earth'] = 'Terra\'s Staff',
    ['Water'] = 'Water Staff',
    ['Wind'] = 'Auster\'s Staff',
    ['Ice'] = 'Aquilo\'s Staff',
    ['Thunder'] = 'Jupiter\'s Staff',
    ['Light'] = 'Terra\'s Staff',
    ['Dark'] = 'Pluto\'s Staff'
};

profile.Sets = sets;

profile.Packer = {
};
profile.UpdateSets = function()
    sets.Idle_Default.Back = Settings.gigantswap;
    sets.PDT.Back = Settings.gigantswap;
    sets.Idle_Tank.Back = Settings.gigantswap;
    sets.Tp_Tank.Back = Settings.gigantswap;
    sets.Idle_Tankpdt.Back = Settings.gigantswap;
    sets.Tp_Tankpdt.Back = Settings.gigantswap;	
end

-- Sub job function for platte swaps
profile.CheckPalette = function(sub)
	if (sub and not Settings.Subjob[sub]) then
		if (sub == 'NIN') then
			AshitaCore:GetChatManager():QueueCommand(-1, '/tb palette change Base');
		elseif (sub == 'SAM') then
			AshitaCore:GetChatManager():QueueCommand(-1, '/tb palette change sam');
		elseif (sub == 'THF') then
			AshitaCore:GetChatManager():QueueCommand(-1, '/tb palette change thf');
		end
		for sub in pairs(Settings.Subjob) do
			sub = false;
		end
		Settings.Subjob[sub] = true;
	end
end	

profile.HandleDefault = function()
    local player = gData.GetPlayer();
	local environment = gData.GetEnvironment();
	local moving = gData.GetPlayer().IsMoving
	
    if (player.Status == 'Engaged') then
		if (Settings.DT~='OFF') then
			gFunc.EquipSet(Settings.DT)		
			if (Settings.DT=='PDT') and (player.HP < (420 + Settings.Hpt)) and (player.TP < 1000) then
				if (player.HP < (370 + Settings.Hpt)) then
					gFunc.EquipSet(sets.PDT);
					gFunc.Equip('ear1', 'Slayer\'s earring');					
 				elseif (player.HP < (420 + Settings.Hpt)) then 
					gFunc.EquipSet(sets.Slayer);
				end
			end
		else
			if gData.GetBuffCount(273) > 0 then
				local tpset = ('Tp_' .. Settings.TpVariant);
				gFunc.EquipSet(tpset .. '_A');
			else
				gFunc.EquipSet('Tp_' .. Settings.TpVariant);
			end
			if (Settings.Fenrir == true) then
				if (environment.Time > 6.00 and environment.Time < 18.00) then
					gFunc.Equip('Ear1', 'Fenrir\'s Earring')
				end
			end
			if (Settings.Gloom == true) and gData.GetBuffCount(63) > 0 then
				gFunc.Equip('body', 'Gloom Breastplate')
			end	
			if (player.HPP > 85 and player.MPP < tonumber(Settings.mpp)) then
				gFunc.Equip('Neck', 'Parade Gorget');
			end
			if (player.HPP < 25) and (player.TP < 1000) then
				gFunc.Equip('ear1', 'Slayer\'s earring');			
			end				
		end	
				
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else
		if (Settings.DT~='OFF') then
				gFunc.EquipSet(Settings.DT)			
			if (Settings.DT=='PDT') and (player.HP < (420 + Settings.Hpt)) and (player.TP < 1000) then
				if (player.HP < (370 + Settings.Hpt)) then
					gFunc.EquipSet(sets.PDT);
					gFunc.Equip('ear1', 'Slayer\'s earring');					
 				elseif (player.HP < (420 + Settings.Hpt)) then 
					gFunc.EquipSet(sets.Slayer);
				end
			end
		else
			gFunc.EquipSet('Idle_' .. Settings.IdleVariant);
			if (Settings.Whead == true) and (Settings.RI == 'true') then
				gFunc.Equip('Head', 'Crimson Mask');	
			elseif (Settings.Vcloak == true) and (Settings.RI == 'true') then
    			gFunc.Equip('Head', ' ');
				gFunc.Equip('Body', 'Vampire Cloak');	
			end
			if (Settings.Slayer == true) then
				gFunc.Equip('ear1', 'Slayer\'s earring');			
			end
			if (Settings.Parade == true) then
				gFunc.Equip('Neck', 'Parade Gorget');		
			end
			if (player.IsMoving == true) then 
				if (Settings.RI == 'true') then
					if (environment.Time < 6.00 or environment.Time > 18.00) then	
						if (player.MP < 341)  then	
							Settings.Vcloak = true
							Settings.Whead = false
						elseif (player.HPP < 93) and (player.MP > 341) then
							Settings.Vcloak = false
							Settings.Whead = true
						else
							Settings.Vcloak = false
							Settings.Whead = false		
						end	
					elseif (player.HPP < 93) and (environment.Time > 6.00 or environment.Time < 18.00) then
						Settings.Vcloak = false
						Settings.Whead = true
					else
						Settings.Vcloak = false
						Settings.Whead = false	
					end	
				end	
				if (player.HPP > 85 and player.MPP < tonumber(Settings.mpp)) then
					Settings.Parade = true
				else
					Settings.Parade = false
				end
				if (player.HPP < 25) and (player.TP < 1000) then
					Settings.Slayer = true
				else
					Settings.Slayer = false
				end	
			end
		end
	end 

		if (player.IsMoving == true) and (Settings.movement == true) then
			gFunc.Equip('Legs', 'Blood Cuisses');
		end
	profile.CheckPalette(player.SubJob);
end

profile.HandleAbility = function()
	local player = gData.GetPlayer();
	local environment = gData.GetEnvironment();	
if (Settings.DT == 'OFF') then 	
	local action = gData.GetAction();
	if (action.Name == 'Arcane Circle') then
			gFunc.Equip('Feet', 'Chaos sollerets');
		elseif (action.Name == 'Last Resort') then
			if (Settings.Enmity == true) then
				gFunc.EquipSet(sets.Enmity);
				gFunc.Equip('Ear2', 'Pigeon Earring +1');
			else
				gFunc.Equip('Body', 'Assault Brstplate');	
			end	
		elseif (action.Name == 'Souleater') then
			if (Settings.Enmity == true) then
				gFunc.EquipSet(sets.Enmity);
			else
				gFunc.Equip('Body', 'Assault Brstplate');	
			end		
		elseif (action.Name == 'Weapon Bash') then
			if (Settings.Enmity == true) then
				gFunc.EquipSet(sets.Enmity);
			else
				gFunc.Equip('Body', 'Assault Brstplate');	
			end			
		elseif (action.Name == 'Hasso' or 'Seigan' or 'third eye') then
				gFunc.Equip('Body', 'Assault Brstplate');			
		elseif (action.Name == 'Provoke') then
			gFunc.EquipSet(sets.Enmity);
		elseif (action.Name == 'Flee') then
			gFunc.Equip('Body', 'Assault Brstplate');		
		end
	end
	if (player.HPP < 93) then
		Settings.gigantswap = 'Shadow Mantle';
		profile.UpdateSets();			
	elseif (player.HPP > 98) then
		Settings.gigantswap = 'Gigant Mantle';
		profile.UpdateSets();			
	end
			if (Settings.RI == 'true') then
				if (environment.Time < 6.00 or environment.Time > 18.00) then	
					if (player.MP < 341)  then	
						Settings.Vcloak = true
						Settings.Whead = false
					elseif (player.HPP < 93) and (player.MP > 341) then
						Settings.Vcloak = false
						Settings.Whead = true
					end
				elseif (player.HPP < 93) and (environment.Time > 6.00 or environment.Time < 18.00) then
					Settings.Vcloak = false
					Settings.Whead = true
				else
					Settings.Vcloak = false
					Settings.Whead = false	
				end	
			end	
			
			if (player.HPP > 85 and player.MPP < tonumber(Settings.mpp)) then
				Settings.Parade = true
			else
				Settings.Parade = false
			end
			
			if (player.HPP < 25) and (player.TP < 1000) then
				Settings.Slayer = true
			else
				Settings.Slayer = false
			end		
				
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
	if (Settings.DT == 'OFF') then 	
		local action = gData.GetAction();
		gFunc.EquipSet(sets.Fastcast);
	end
end

profile.HandleMidcast = function()
		local player = gData.GetPlayer();	
		local environment = gData.GetEnvironment();		
	if (Settings.DT == 'OFF') then 	
		local action = gData.GetAction();
		local spell = gData.GetAction();
	--Your fast cast, expressed as a percentage.  0.3 = 30% fast cast.
		local fastCastValue = 0.05;
	--Minimum number of seconds to leave before spell completion.  Client can tack on up to 400ms wait due to packet interval..
		local minimumBuffer = 0.60;
    --Calculated delay for midcast..
		local castDelay = ((spell.CastTime * (1 - fastCastValue)) / 1000) - minimumBuffer;
	
	if (action.Name == 'Utsusemi: Ichi') then
		if (Settings.Touchdown == true) then 
			gFunc.InterimEquipSet(gFunc.Combine(sets.MDT,sets.Shadow));
			Settings.Touchdown = false
		else 
			gFunc.InterimEquipSet(gFunc.Combine(sets.PDT,sets.Shadow));
		end
		gFunc.SetMidDelay(castDelay)
		gFunc.EquipSet(gFunc.Combine(sets.SIR,sets.Haste));	
	elseif (action.Name == 'Utsusemi: Ni') then
	    gFunc.InterimEquipSet(gFunc.Combine(sets.PDT,sets.Shadow));
		gFunc.SetMidDelay(castDelay)
		gFunc.EquipSet(gFunc.Combine(sets.SIR,sets.Haste));	
	elseif (action.Name == 'Stun') then
		if (Settings.Enmity == true) then
			gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Enmity));
			gFunc.Equip('Hands', 'Homam Manopolas')
			gFunc.Equip('Ear2', 'Loquac. Earring')
		else
			gFunc.EquipSet(gFunc.Combine(sets.Dark,sets.Haste));
		end
		if Settings.stunmacc == true then
			gFunc.Equip('main', ElementalStaffTable[action.Element]);
		end		
	elseif (action.Skill =='Dark Magic' and action.Name ~='Stun') then
	    gFunc.InterimEquipSet(gFunc.Combine(sets.PDT,sets.SIR));
		gFunc.SetMidDelay(castDelay)
		if (action.Name == 'Drain') then
			gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Dark));
			if Settings.drainmacc == true then
				gFunc.Equip('main', ElementalStaffTable[action.Element]);
				gFunc.Echo(135,Settings.IdleVariant);	
			end
		elseif (action.Name == 'Aspir') then
			if Settings.aspirmacc == true then
				gFunc.Equip('main', ElementalStaffTable[action.Element]);
			end
		elseif  string.match(action.Name, 'Absorb') then
			if (Settings.Enmity == true) then
				gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Enmity));
			else	
				gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Dark));
				gFunc.Equip('Legs', 'Onyx Cuisses');		
			end			
			if (Settings.absorbmacc == true) then
				gFunc.Equip('main', ElementalStaffTable[action.Element]);	
			end
		else 
			if (Settings.Enmity == true) then
				gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Enmity));
			else	
				gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Dark));
			end
		end
		elseif (action.Skill =='Enfeebling Magic') then
			gFunc.InterimEquipSet(gFunc.Combine(sets.PDT,sets.SIR));
			gFunc.SetMidDelay(castDelay)
			if (Settings.Enmity == true) then
				gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Enmity));
			else	
				gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Enfeebling));	
			end
		elseif (action.Skill =='Ninjutsu Magic') and (string.match ~='utsu') then
			gFunc.InterimEquipSet(gFunc.Combine(sets.PDT,sets.SIR));
			gFunc.SetMidDelay(castDelay)
			if (Settings.Enmity == true) then
				gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Enmity));
			else	
				gFunc.EquipSet(gFunc.Combine(sets.PDT,sets.Haste));	
			end	
		elseif (action.Name == 'Invisible') then
			gFunc.Equip('hands', 'Dream Mittens +1');
		elseif (action.Name == 'Sneak') then
			gFunc.Equip('feet', 'Dream Boots +1');
		elseif (action.Skill == 'Elemental Magic') then
			gFunc.InterimEquipSet(gFunc.Combine(sets.PDT,sets.SIR));
			gFunc.SetMidDelay(castDelay)			
			gFunc.EquipSet(gFunc.Combine(sets.Haste,sets.Macc));
		end
		
	
	end
	if (player.HPP < 93) then
		Settings.gigantswap = 'Shadow Mantle';
		profile.UpdateSets();			
	elseif (player.HPP > 98) then
		Settings.gigantswap = 'Gigant Mantle';
		profile.UpdateSets();			
	end			
	if (conquest.settings.regionControl == false) and (Settings.resentmentswap == 'Gigant mantle') then
		Settings.resentemntswap = 'Resentment Cape';
		profile.UpdateSets();			
	elseif (conquest.settings.regionControl == true) and (Settings.resentmentswap == 'Resentment Cape') then
		Settings.resentmentswap = 'Gigant Mantle';
		profile.UpdateSets();			
	end		
			if (Settings.RI == 'true') then
				if (environment.Time < 6.00 or environment.Time > 18.00) then	
					if (player.MP < 341)  then	
						Settings.Vcloak = true
						Settings.Whead = false
					elseif (player.HPP < 93) and (player.MP > 341) then
						Settings.Vcloak = false
						Settings.Whead = true
					end
				elseif (player.HPP < 93) and (environment.Time > 6.00 or environment.Time < 18.00) then
					Settings.Vcloak = false
					Settings.Whead = true
				else
					Settings.Vcloak = false
					Settings.Whead = false	
				end	
			end	
			
			if (player.HPP > 85 and player.MPP < tonumber(Settings.mpp)) then
				Settings.Parade = true
			else
				Settings.Parade = false
			end
			
			if (player.HPP < 25) and (player.TP < 1000) then
				Settings.Slayer = true
			else
				Settings.Slayer = false
			end	
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
	if (Settings.DT == 'OFF') then 	
		local action = gData.GetAction();
		local environment = gData.GetEnvironment();			
		
		if (action.Name == 'Catastrophe') then
			gFunc.EquipSet(sets.CataWS);	
			gFunc.Equip('neck', 'soil gorget');
				if (environment.Time > 6.00 and environment.Time < 18.00) then
					gFunc.Equip('ear1', 'Fenrir\'s Earring')
				end
		elseif (action.Name == 'Guillotine' or 'Cross Reaper' or 'Spiral Hell'
		or 'Shadow of death' or 'Ground Strike' or 'frostbite')  then
			gFunc.EquipSet(sets.DefaultWS);
			gFunc.Equip('neck', 'snow gorget');
		else
			gFunc.EquipSet(sets.DefaultWS);
		end
	end
end

return profile;