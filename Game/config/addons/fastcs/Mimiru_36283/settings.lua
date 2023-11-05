require('common');

local settings = T{ };
settings["exclusions"] = T{ };
settings["frame_rate_divisor"] = 2;
settings["exclusions"][1] = "home point #1";
settings["exclusions"][2] = "home point #2";
settings["exclusions"][3] = "home point #3";
settings["exclusions"][4] = "home point #4";
settings["exclusions"][5] = "home point #5";
settings["exclusions"][6] = "igsli";
settings["exclusions"][7] = "urbiolaine";
settings["exclusions"][8] = "teldro-kesdrodo";
settings["exclusions"][9] = "nunaarl bthtrogg";
settings["exclusions"][10] = "survival guide";
settings["exclusions"][11] = "waypoint";

return settings;
