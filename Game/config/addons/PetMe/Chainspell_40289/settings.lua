require('common');

local settings = T{ };
settings["charmUntil"] = T{ };
settings["useHorizonMerits"] = T{ };
settings["window"] = T{ };
settings["window"]["backgroundColor"] = T{ };
settings["window"]["scale"] = T{ };
settings["window"]["textColor"] = T{ };
settings["window"]["borderColor"] = T{ };
settings["window"]["opacity"] = T{ };
settings["charmGear"] = T{ };
settings["components"] = T{ };
settings["components"]["petTarget"] = T{ };
settings["components"]["petDuration"] = T{ };
settings["components"]["alwaysVisible"] = T{ };
settings["components"]["petName"] = T{ };
settings["components"]["hideLog"] = T{ };
settings["components"]["petRecasts"] = T{ };
settings["components"]["hideMap"] = T{ };
settings["components"]["petStats"] = T{ };
settings["charmUntil"][1] = 0;
settings["useHorizonMerits"][1] = true;
settings["window"]["backgroundColor"][1] = 0.23000000000000001;
settings["window"]["backgroundColor"][2] = 0.23000000000000001;
settings["window"]["backgroundColor"][3] = 0.26000000000000001;
settings["window"]["backgroundColor"][4] = 1;
settings["window"]["scale"][1] = 1;
settings["window"]["textColor"][1] = 1;
settings["window"]["textColor"][2] = 1;
settings["window"]["textColor"][3] = 1;
settings["window"]["textColor"][4] = 1;
settings["window"]["borderColor"][1] = 0;
settings["window"]["borderColor"][2] = 0;
settings["window"]["borderColor"][3] = 0;
settings["window"]["borderColor"][4] = 1;
settings["window"]["opacity"][1] = 0.80000000000000004;
settings["charmGear"][1] = 0;
settings["components"]["petTarget"][1] = true;
settings["components"]["petDuration"][1] = true;
settings["components"]["alwaysVisible"][1] = false;
settings["components"]["petName"][1] = true;
settings["components"]["hideLog"][1] = false;
settings["components"]["petRecasts"][1] = true;
settings["components"]["hideMap"][1] = false;
settings["components"]["petStats"][1] = true;

return settings;