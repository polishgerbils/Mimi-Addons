local profile = {};
profile.Sets = {
    Idle = {
        Main = 'Barbaroi Axe',
        Sub = 'Targe',
        Ammo = 'Fish Oil Broth',
        Head = 'Mrc.Cpt. Headgear',
        Neck = 'Peacock Amulet',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Ryl.Sqr. Chainmail',
        Hands = 'Battle Gloves',
        Ring1 = 'Balance Ring',
        Ring2 = 'Balance Ring',
        Back = 'Dhalmel Mantle',
        Waist = 'Tilt Belt',
        Legs = 'Republic Subligar',
        Feet = 'Savage Gaiters',
    },
};

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
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;