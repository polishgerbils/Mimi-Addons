require('common');

local settings = T{ };
settings["showWindow"] = T{ };
settings["fps"] = T{ };
settings["fps"]["min_denominator"] = T{ };
settings["fps"]["fps_decrease_threshold"] = T{ };
settings["fps"]["updateInterval"] = T{ };
settings["fps"]["max_denominator"] = T{ };
settings["fps"]["fps_increase_threshold"] = T{ };
settings["showWindow"][1] = false;
settings["fps"]["format"] = "%d < %d < %d";
settings["fps"]["min_denominator"][1] = 1;
settings["fps"]["fps_decrease_threshold"][1] = 0.10000000000000001;
settings["fps"]["updateInterval"][1] = 1;
settings["fps"]["max_denominator"][1] = 3;
settings["fps"]["fps_increase_threshold"][1] = 0.01;

return settings;
