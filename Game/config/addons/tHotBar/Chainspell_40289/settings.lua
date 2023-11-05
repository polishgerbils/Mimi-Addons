require('common');

local settings = T{ };
settings["Position"] = T{ };
settings["Position"]["10x3_750p"] = T{ };
settings["ShowCross"] = true;
settings["ShowCost"] = true;
settings["Position"]["10x3_750p"][1] = 925.5;
settings["Position"]["10x3_750p"][2] = 995.66666666666674;
settings["ClickToActivate"] = true;
settings["ShowSkillchainIcon"] = true;
settings["HideWhileZoning"] = true;
settings["ShowName"] = true;
settings["ShowRecast"] = true;
settings["HideWhileMap"] = true;
settings["ShowFade"] = true;
settings["ShowSkillchainAnimation"] = true;
settings["ShowTrigger"] = true;
settings["Layout"] = "10x3_750p";
settings["ShowHotkey"] = true;
settings["HideWhileCutscene"] = true;

return settings;
