require('common');

local settings = T{ };
settings["Thresholds"] = T{ };
settings["Flags"] = T{ };
settings["Thresholds"]["WS"] = 600;
settings["Thresholds"]["MAGIC"] = 1000;
settings["Thresholds"]["MAX"] = 99999;
settings["Flags"]["SC"] = true;
settings["Flags"]["Melee"] = false;
settings["Flags"]["Pet"] = true;
settings["Flags"]["Ranged"] = false;
settings["Flags"]["Timestamp"] = false;
settings["Flags"]["Healing"] = true;
settings["Flags"]["Ability"] = true;
settings["Flags"]["Mob_Death"] = true;
settings["Flags"]["WS"] = true;
settings["Flags"]["Magic"] = true;
settings["Flags"]["Deaths"] = false;

return settings;
