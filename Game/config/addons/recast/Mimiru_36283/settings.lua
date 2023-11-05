require('common');

local settings = T{ };
settings["windowPos"] = T{ };
settings["font"] = T{ };
settings["font"]["background"] = T{ };
settings["windowSize"] = T{ };
settings["windowName"] = "Recast";
settings["windowPos"][1] = 100;
settings["windowPos"][2] = 100;
settings["font"]["font_height"] = 13;
settings["font"]["font_family"] = "Arial";
settings["font"]["color"] = 4294901760;
settings["font"]["visible"] = true;
settings["font"]["background"]["visible"] = true;
settings["font"]["background"]["color"] = 2147483648;
settings["font"]["position_y"] = 100;
settings["font"]["position_x"] = 100;
settings["windowSize"][1] = -1;
settings["windowSize"][2] = -1;

return settings;
