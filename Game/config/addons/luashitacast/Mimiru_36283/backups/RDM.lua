local profile = {};

profile.Sets = {
    Idle = {
        Main = 'Earth Staff',
        Sub = '',
        Ammo = 'Hedgehog Bomb',
        Head = '',
        Neck = 'Justice Badge',
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Body = 'Warlock\'s tabard',
        Hands = 'Savage gauntlets',
        Ring1 = 'Ether Ring',
        Ring2 = 'Electrum Ring',
        Back = 'Red Cape',
        Waist = 'Swift Belt',
        Legs = 'Savage loincloth',
        Feet = 'Mannequin Pumps'
    },

    Healing = {
        Main = 'Fencing Degen',
        Sub = '',
        Head = 'Warlock\'s Chapeau',
        Neck = 'Healing Torque',
        Ear1 = 'Cmn. Earring',
        Ear2 = 'Coral Earring',
        Body = 'Mahatma Hpl.',
        Hands = 'Warlock\'s Gloves',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Sapphire Ring',
        Waist = 'Swift Belt',
        Legs = 'Warlock\'s Tights',
        Feet = 'Warlock\'s Boots'
    },

    Resting = {
        Main = 'Dark Staff',
        Head = 'Warlock\'s Chapeau',
		Neck = 'Checkered Scarf',
        Body = 'Mahatma Hpl.',
        Hands = '',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Red Cape +1',
        Waist = 'Hierarch Belt',
        Legs = 'Baron\'s slops',
        Feet = 'Warlock\'s Boots'
    },

    MndEnfeebling = {
        Main = 'Ebony Wand +1',
        Sub = 'Numinous Shield',
        Head = 'Warlock\'s Chapeau',
        Neck = 'Enfeebling Torque',
        Ear1 = 'Cmn. Earring',
        Ear2 = 'Coral Earring',
        Body = 'Warlock\'s Tabard',
        Hands = 'Warlock\'s Gloves',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Sapphire Ring',
        Back = 'Red Cape +1',
        Waist = 'Penitent\'s Rope',
        Legs = 'Errant Slops',
        Feet = 'Duelist\'s Boots'
    },

    IntEnfeebling = {
        Main = 'Ebony Wand +1',
        Sub = 'Numinous Shield',
        Ammo = 'Phtm. Tathlum',
        Head = 'Warlock\'s Chapeau',
        Neck = 'Enfeebling Torque', 
        Ear1 = 'Cunning Earring',
        Ear2 = 'Coral Earring',
        Body = 'Warlock\'s Tabard',
        Hands = 'Errant Cuffs',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Red Cape +1',
        Waist = 'Penitent\'s Rope',
        Legs = 'Errant Slops',
        Feet = 'Warlock\'s Boots'
    },

    Nuking = {
        Main = 'Ebony Wand +1',
        Ammo = 'Phtm. Tathlum',
        Head = 'Warlock\'s Chapeau',
        Neck = 'Elemental Torque',
        Ear1 = 'Moldavite Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Mahatma Hpl.',
        Hands = 'Warlock\'s Gloves',
        Ring1 = 'Tamas Ring',
        Ring2 = 'Diamond Ring',
        Back = 'Red Cape +1',
        Waist = 'Swift Belt',
        Legs = 'Errant Slops',
        Feet = 'Duelist\'s Boots'
    },

    FastCast = {
        Head = 'Warlock\'s Chapeau',
        Body = 'Mahatma Hpl.',
        Waist = 'Swift Belt'
    },

    HasteCast = {},

    Sneaking = {
        Hands = 'Dream Mittens +1',
        Back = 'Skulker\'s Cape',
        Feet = 'Dream Boots +1'
    },

    Enhancing = {
        Neck = 'Enhancing Torque',
        Body = "Mahatma Hpl.",
        Hands = 'Duelist\'s Gloves',
        Legs = 'Warlock\'s Tights'
    },

    Enmity = {
        Main = 'Ebony Wand +1',
        Sub = 'Numinous Shield',
        Ammo = 'Hedgehog Bomb',
        Head = 'Raven Beret',
        Neck = 'Justice Badge',
        Body = 'Raven Jupon',
        Hands = 'Crow Bracers',
        Ring2 = 'Peace Ring',
        Back = 'Red Cape +1',
        Waist = 'Healer\'s Belt',
        Legs = 'Warlock\'s Tights',
        Feet = 'Crow Gaiters'
    },

    PlusMP = {
        Main = 'Fencing Degen', -- +10 mp
        Sub = 'Numinous Shield', -- +10 mp
        Ammo = 'Hedgehog Bomb', -- +30 mp
        Head = 'Warlock\'s Chapeau', -- 20 mp
        --Neck = '',
        Body = 'Warlock\'s Tabard', -- +14 mp
        Hands = 'Errant Cuffs', -- -20 hp +20 mp
        Ring1 = 'Tamas Ring', -- 30mp
        Ring2 = 'Peace Ring', -- 10 hp>mp
        --Back = '',
        Waist = 'Hierarch Belt', -- +48 mp
        Legs = 'Custom Slacks', -- +32 mp
        Feet = 'Errant Pigaches' -- -20hp +20mp
    },

    MDT = {
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Back = 'Gramary Cape',
        Hands = 'Duelist\'s Gloves',
        Legs = 'Coral Cuisses +1',
    },

    PDT = {
        Main = 'Terra\'s Staff',
        Back = 'Cheviot Cape'
    },

};

profile.Spells = {
    Healing = T{"Cure", "Cure II", "Cure III", "Cure IV", "Curaga", "Curaga II", "Erase"},

    MndEnfeebling = {"Slow", "Slow II", "Paralyze", "Paralyze II", "Poison", "Poison II", "Banish", "Banish II"},

    IntEnfeebling = {"Sleep", "Sleep II", "Bind", "Gravity", "Blind", "Blaze Spikes", "Ice Spikes",
        "Shock Spikes"},

    EleDebuffs = {"Rasp", "Drown", "Frost", "Burn", "Choke", "Shock"},

    Enhancing = {"Phalanx", "Stoneskin", "Enaero", "Enaero II", "Enfire", "Enfire II",
        "Enstone", "Enstone II", "Enthunder", "Enthunder II", "Enwater", "Enwater II",
        "Enblizzard", "Enblizzard II"},
    
    Buffs = {"Protect", "Protect II", "Protect III", "Protect IV", "Protectra", "Protectra II", "Protectra III",
     "Protectra IV", "Protectra V", "Shell", "Shell II", "Shell III", "Shell IV", "Shellra", "Shellra II",
     "Shellra III", "Shellra IV", "Shellra V", "Haste", "Refresh", "Aquaveil", "Blink"},

    Sneaking = {"Sneak", "Invisible"}
}

profile.Packer = {
};

local Settings = {
    isFast = false,
    isMDT = false,
    isPDT = false,
    Subslot = 'Default',
    RestTimer = 0,
    CurrentLevel = 0,
}

local EleStaffTable = {
    ['Fire'] = 'Ice Staff',
    ['Earth'] = 'Earth Staff',
    ['Water'] = 'Ice Staff',
    ['Wind'] = 'Wind Staff',
    ['Ice'] = 'Ice Staff',
    ['Thunder'] = 'Thunder Staff',
    ['Light'] = 'Light Staff',
    ['Dark'] = 'Dark Staff'
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

end

profile.OnUnload = function()

end


-- Method that checks a list for a specific spell string, returns true if found
profile.CheckForSpell = function(spellList, castSpell)
    for _, spell in pairs(spellList) do
        if spell == castSpell then
            return true 
        end
    end
end

-- Method that checks passed element string and equips appropriate elemental staff
profile.EquipEleStaff = function(element, spellName)
    if (profile.CheckForSpell(profile.Spells.Buffs, spellName)) then
        gFunc.Equip('Main', EleStaffTable["Earth"]);
        gFunc.Equip('Sub', '');
    elseif (not profile.CheckForSpell(profile.Spells.EleDebuffs, spellName)) then
        gFunc.Equip('main', EleStaffTable[element]);
        gFunc.Equip('Sub', '');
    end
end

profile.EquipSprint = function()
    if (Settings.isFast) then
        gFunc.EquipSet(profile.Sets.Sprint);
    end
end

profile.CheckSixtySync = function(synclvl)
    if (synclvl == 60) then
        gFunc.EquipSet(profile.Sets.Sixtycap);
    end
end

profile.CheckCity = function(loc)
    if (string.match(loc, "Bastok")) or (string.match(loc, "Metalworks")) then
        gFunc.Equip('Body', "Republic Aketon");
    elseif (string.match(loc, "Windurst")) or (string.match(loc, "Heavens Tower")) then
        --gFunc.Equip('Body', '')
    elseif (string.match(loc, "San d\'Oria")) or (string.match(loc, "d\'Oraguille")) then
        --gFunc.Equip('Body', '')
    end
end



profile.HandleCommand = function(args)
    profile.WarpCudgel(args);
    if (args[1] == 'fast') then
        if (Settings.isFast == true) then
            Settings.isFast = false;
            gFunc.Enable('Feet');
            gFunc.Echo(135, 'Powder Boots off');
        else
            Settings.isFast = true;
            gFunc.Echo(135, "Powder Boots On");
        end
    end
    if (args[1] == 'mdt') then
        if (Settings.isMDT == true) then
            Settings.isMDT = false;
        else
            Settings.isMDT = true;
        end
    end
    if (args[1] == 'pdt') then
        if (Settings.isPDT == true) then
            Settings.isPDT = false;
        else
            Settings.isPDT = true;
        end
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local loc = gData.GetEnvironment().Area;
	
    if (player.Status ==  'Engaged') then
        gFunc.EquipSet(profile.Sets.Idle); 
        Settings.RestTimer = 0;
    elseif (player.Status == 'Resting') then
        if Settings.RestTimer == 0 then
            Settings.RestTimer = os.clock() + 18;
        end

        if (os.clock() > Settings.RestTimer) then
            gFunc.EquipSet(profile.Sets.Resting);
            if (player.SubJob == 'BLM') then
                gFunc.Equip('Back', 'Wizard\'s mantle');
            end
        end
    else
        gFunc.EquipSet(profile.Sets.Idle); 
        Settings.RestTimer = 0;
    end
    profile.CheckCity(loc);
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local action = gData.GetAction();
    local distance = tonumber(('%.1f'):fmt(math.sqrt(gData.GetActionTarget().Distance)));
    local spellCooldown = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(action.Id)/60;

    -- TODO gate for mp amount before equipping fast cast set so plusMP set can maintain extra mp after convert

    if((spellCooldown < 0.6) and (distance <= 20.4)) then
        -- Precast equips FastCast set and switches into appropriate set during HandleMidcast method
        gFunc.EquipSet(profile.Sets.FastCast);
    end
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local distance = tonumber(('%.1f'):fmt(math.sqrt(gData.GetActionTarget().Distance)));
    local spell = AshitaCore:GetResourceManager():GetSpellById(action.Id);
    local spellCooldown = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(action.Id)/60;

    if ((spellCooldown < 0.6) and (distance <= 20.4)) then
         -- TODO same mp gate function as in HandlePrecast method before moving on

        -- Mind Enfeebling
        if (profile.CheckForSpell(profile.Spells.MndEnfeebling, action.Name)) then
            gFunc.EquipSet(profile.Sets.MndEnfeebling);

        -- Int Enfeebling
        elseif ((profile.CheckForSpell(profile.Spells.IntEnfeebling, action.Name)) or (profile.CheckForSpell(profile.Spells.EleDebuffs, action.Name))) then
            gFunc.EquipSet(profile.Sets.IntEnfeebling);

        -- Sneak/Invis
        elseif (profile.CheckForSpell(profile.Spells.Sneaking, action.Name)) then
            gFunc.EquipSet(profile.Sets.Sneaking);

        -- Enmity-
        --elseif (profile.CheckForSpell(profile.Spells.Healing, action.Name)) then
        elseif profile.Spells.Healing:contains(action.Name) then
            gFunc.EquipSet(profile.Sets.Enmity);

        -- Nuking
        elseif ((action.Skill == 'Elemental Magic') ~= (profile.CheckForSpell(profile.Spells.EleDebuffs, action.Name))) then
            gFunc.EquipSet(profile.Sets.Nuking);

        -- Enhancing
        elseif ((string.match(action.Name, "Bar")) or profile.CheckForSpell(profile.Spells.Enhancing, action.Name)) then
            gFunc.EquipSet(profile.Sets.MndEnfeebling);
            gFunc.EquipSet(profile.Sets.Enhancing);
    
        -- Defaults to idle set if the check falls through somehow
        else 
            gFunc.EquipSet(profile.Sets.Idle);
        end

        -- Equips appropriate Elemental Staff
        profile.EquipEleStaff(action.Element, action.Name);
    end

end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;