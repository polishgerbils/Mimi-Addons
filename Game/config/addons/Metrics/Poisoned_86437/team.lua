require('common');

local settings = T{ };
settings["Flags"] = T{ };
settings["Settings"] = T{ };
settings["Flags"]["Total_Damage_Only"] = false;
settings["Flags"]["Total_Acc"] = false;
settings["Flags"]["Pet"] = false;
settings["Flags"]["Crit"] = false;
settings["Flags"]["Healing"] = false;
settings["Flags"]["Deaths"] = false;
settings["Settings"]["Rank_Cutoff"] = 6;
settings["Settings"]["Show_Clock"] = true;
settings["Settings"]["Include_SC_Damage"] = false;
settings["Settings"]["Condensed_Numbers"] = false;

return settings;
