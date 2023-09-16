require('common');

local settings = T{ };
settings["move"] = T{ };
settings["move"]["dragging"] = false;
settings["move"]["drag_x"] = 94;
settings["move"]["shift_down"] = false;
settings["move"]["drag_y"] = 8;
settings["scale"] = 1;
settings["padding"] = 1;
settings["party_buffs"] = true;
settings["locked"] = false;
settings["opacity"] = 1;

return settings;
