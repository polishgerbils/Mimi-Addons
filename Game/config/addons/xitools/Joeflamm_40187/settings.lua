require('common');

local settings = T{ };
settings["globals"] = T{ };
settings["globals"]["hideUnderChat"] = T{ };
settings["globals"]["hideWhileLoading"] = T{ };
settings["globals"]["uiScale"] = T{ };
settings["globals"]["hideUnderMap"] = T{ };
settings["globals"]["showDemo"] = T{ };
settings["tools"] = T{ };
settings["tools"]["us"] = T{ };
settings["tools"]["us"]["isVisible"] = T{ };
settings["tools"]["us"]["isEnabled"] = T{ };
settings["tools"]["us"]["hideWhenSolo"] = T{ };
settings["tools"]["us"]["alliance1"] = T{ };
settings["tools"]["us"]["alliance1"]["isVisible"] = T{ };
settings["tools"]["us"]["alliance1"]["pos"] = T{ };
settings["tools"]["us"]["alliance1"]["size"] = T{ };
settings["tools"]["us"]["showCastbar"] = T{ };
settings["tools"]["us"]["alliance2"] = T{ };
settings["tools"]["us"]["alliance2"]["isVisible"] = T{ };
settings["tools"]["us"]["alliance2"]["pos"] = T{ };
settings["tools"]["us"]["alliance2"]["size"] = T{ };
settings["tools"]["us"]["alliance3"] = T{ };
settings["tools"]["us"]["alliance3"]["isVisible"] = T{ };
settings["tools"]["us"]["alliance3"]["pos"] = T{ };
settings["tools"]["us"]["alliance3"]["size"] = T{ };
settings["tools"]["fishe"] = T{ };
settings["tools"]["fishe"]["isVisible"] = T{ };
settings["tools"]["fishe"]["isEnabled"] = T{ };
settings["tools"]["fishe"]["size"] = T{ };
settings["tools"]["fishe"]["pos"] = T{ };
settings["tools"]["fishe"]["skill"] = T{ };
settings["tools"]["fishe"]["history"] = T{ };
settings["tools"]["me"] = T{ };
settings["tools"]["me"]["isVisible"] = T{ };
settings["tools"]["me"]["isEnabled"] = T{ };
settings["tools"]["me"]["size"] = T{ };
settings["tools"]["me"]["pos"] = T{ };
settings["tools"]["logger"] = T{ };
settings["tools"]["logger"]["isVisible"] = T{ };
settings["tools"]["logger"]["isEnabled"] = T{ };
settings["tools"]["logger"]["loggedPackets"] = T{ };
settings["tools"]["logger"]["loggedPackets"]["outbound"] = T{ };
settings["tools"]["logger"]["loggedPackets"]["outbound"][150] = T{ };
settings["tools"]["logger"]["loggedPackets"]["inbound"] = T{ };
settings["tools"]["logger"]["loggedPackets"]["inbound"][111] = T{ };
settings["tools"]["logger"]["loggedPackets"]["inbound"][41] = T{ };
settings["tools"]["logger"]["loggedPackets"]["inbound"][48] = T{ };
settings["tools"]["logger"]["loggedPackets"]["inbound"][112] = T{ };
settings["tools"]["logger"]["loggedPackets"]["inbound"][42] = T{ };
settings["tools"]["logger"]["loggedPackets"]["inbound"][40] = T{ };
settings["tools"]["logger"]["loggedPackets"]["inbound"][98] = T{ };
settings["tools"]["crafty"] = T{ };
settings["tools"]["crafty"]["isVisible"] = T{ };
settings["tools"]["crafty"]["isEnabled"] = T{ };
settings["tools"]["crafty"]["size"] = T{ };
settings["tools"]["crafty"]["skills"] = T{ };
settings["tools"]["crafty"]["skills"][0] = T{ };
settings["tools"]["crafty"]["skills"][1] = T{ };
settings["tools"]["crafty"]["skills"][2] = T{ };
settings["tools"]["crafty"]["skills"][3] = T{ };
settings["tools"]["crafty"]["skills"][4] = T{ };
settings["tools"]["crafty"]["skills"][5] = T{ };
settings["tools"]["crafty"]["skills"][6] = T{ };
settings["tools"]["crafty"]["skills"][7] = T{ };
settings["tools"]["crafty"]["skills"][8] = T{ };
settings["tools"]["crafty"]["history"] = T{ };
settings["tools"]["crafty"]["pos"] = T{ };
settings["tools"]["tgt"] = T{ };
settings["tools"]["tgt"]["isVisible"] = T{ };
settings["tools"]["tgt"]["isEnabled"] = T{ };
settings["tools"]["tgt"]["showStatus"] = T{ };
settings["tools"]["tgt"]["size"] = T{ };
settings["tools"]["tgt"]["pos"] = T{ };
settings["tools"]["inv"] = T{ };
settings["tools"]["inv"]["isVisible"] = T{ };
settings["tools"]["inv"]["isEnabled"] = T{ };
settings["tools"]["inv"]["size"] = T{ };
settings["tools"]["inv"]["pos"] = T{ };
settings["tools"]["tracker"] = T{ };
settings["tools"]["tracker"]["isVisible"] = T{ };
settings["tools"]["tracker"]["isEnabled"] = T{ };
settings["tools"]["tracker"]["size"] = T{ };
settings["tools"]["tracker"]["pos"] = T{ };
settings["tools"]["tracker"]["abilities"] = T{ };
settings["tools"]["tracker"]["spells"] = T{ };
settings["tools"]["pet"] = T{ };
settings["tools"]["pet"]["isVisible"] = T{ };
settings["tools"]["pet"]["isEnabled"] = T{ };
settings["tools"]["pet"]["size"] = T{ };
settings["tools"]["pet"]["pos"] = T{ };
settings["tools"]["config"] = T{ };
settings["tools"]["config"]["isVisible"] = T{ };
settings["tools"]["config"]["isEnabled"] = T{ };
settings["tools"]["config"]["size"] = T{ };
settings["tools"]["config"]["pos"] = T{ };
settings["globals"]["baseH"] = 14;
settings["globals"]["hideUnderChat"][1] = true;
settings["globals"]["baseW"] = 7;
settings["globals"]["hideWhileLoading"][1] = true;
settings["globals"]["uiScale"][1] = 1;
settings["globals"]["hideUnderMap"][1] = true;
settings["globals"]["showDemo"][1] = false;
settings["tools"]["us"]["isVisible"][1] = true;
settings["tools"]["us"]["isEnabled"][1] = false;
settings["tools"]["us"]["hideWhenSolo"][1] = false;
settings["tools"]["us"]["alliance1"]["isVisible"][1] = true;
settings["tools"]["us"]["alliance1"]["pos"][1] = 392;
settings["tools"]["us"]["alliance1"]["pos"][2] = 628;
settings["tools"]["us"]["alliance1"]["size"][1] = 276;
settings["tools"]["us"]["alliance1"]["size"][2] = -1;
settings["tools"]["us"]["alliance1"]["flags"] = 43;
settings["tools"]["us"]["alliance1"]["name"] = "xitools.us.1";
settings["tools"]["us"]["showCastbar"][1] = true;
settings["tools"]["us"]["alliance2"]["isVisible"][1] = true;
settings["tools"]["us"]["alliance2"]["pos"][1] = 107;
settings["tools"]["us"]["alliance2"]["pos"][2] = 628;
settings["tools"]["us"]["alliance2"]["size"][1] = 276;
settings["tools"]["us"]["alliance2"]["size"][2] = -1;
settings["tools"]["us"]["alliance2"]["flags"] = 43;
settings["tools"]["us"]["alliance2"]["name"] = "xitools.us.2";
settings["tools"]["us"]["alliance3"]["isVisible"][1] = true;
settings["tools"]["us"]["alliance3"]["pos"][1] = 0;
settings["tools"]["us"]["alliance3"]["pos"][2] = 628;
settings["tools"]["us"]["alliance3"]["size"][1] = 276;
settings["tools"]["us"]["alliance3"]["size"][2] = -1;
settings["tools"]["us"]["alliance3"]["flags"] = 43;
settings["tools"]["us"]["alliance3"]["name"] = "xitools.us.3";
settings["tools"]["fishe"]["isVisible"][1] = true;
settings["tools"]["fishe"]["isEnabled"][1] = false;
settings["tools"]["fishe"]["size"][1] = -1;
settings["tools"]["fishe"]["size"][2] = -1;
settings["tools"]["fishe"]["flags"] = 0;
settings["tools"]["fishe"]["pos"][1] = 100;
settings["tools"]["fishe"]["pos"][2] = 100;
settings["tools"]["fishe"]["skill"][1] = 0;
settings["tools"]["fishe"]["name"] = "xitools.fishe";
settings["tools"]["me"]["isVisible"][1] = true;
settings["tools"]["me"]["isEnabled"][1] = false;
settings["tools"]["me"]["size"][1] = 276;
settings["tools"]["me"]["size"][2] = -1;
settings["tools"]["me"]["flags"] = 43;
settings["tools"]["me"]["name"] = "xitools.me";
settings["tools"]["me"]["pos"][1] = 100;
settings["tools"]["me"]["pos"][2] = 100;
settings["tools"]["logger"]["isVisible"][1] = false;
settings["tools"]["logger"]["isEnabled"][1] = false;
settings["tools"]["logger"]["loggedPackets"]["outbound"][150][1] = true;
settings["tools"]["logger"]["loggedPackets"]["inbound"][111][1] = true;
settings["tools"]["logger"]["loggedPackets"]["inbound"][41][1] = true;
settings["tools"]["logger"]["loggedPackets"]["inbound"][48][1] = true;
settings["tools"]["logger"]["loggedPackets"]["inbound"][112][1] = true;
settings["tools"]["logger"]["loggedPackets"]["inbound"][42][1] = true;
settings["tools"]["logger"]["loggedPackets"]["inbound"][40][1] = true;
settings["tools"]["logger"]["loggedPackets"]["inbound"][98][1] = true;
settings["tools"]["crafty"]["isVisible"][1] = true;
settings["tools"]["crafty"]["isEnabled"][1] = false;
settings["tools"]["crafty"]["size"][1] = -1;
settings["tools"]["crafty"]["size"][2] = -1;
settings["tools"]["crafty"]["flags"] = 2;
settings["tools"]["crafty"]["skills"][0][1] = 0;
settings["tools"]["crafty"]["skills"][1][1] = 0;
settings["tools"]["crafty"]["skills"][2][1] = 0;
settings["tools"]["crafty"]["skills"][3][1] = 0;
settings["tools"]["crafty"]["skills"][4][1] = 0;
settings["tools"]["crafty"]["skills"][5][1] = 0;
settings["tools"]["crafty"]["skills"][6][1] = 0;
settings["tools"]["crafty"]["skills"][7][1] = 0;
settings["tools"]["crafty"]["skills"][8][1] = 0;
settings["tools"]["crafty"]["name"] = "xitools.crafty";
settings["tools"]["crafty"]["pos"][1] = 100;
settings["tools"]["crafty"]["pos"][2] = 100;
settings["tools"]["tgt"]["isVisible"][1] = true;
settings["tools"]["tgt"]["isEnabled"][1] = false;
settings["tools"]["tgt"]["showStatus"][1] = false;
settings["tools"]["tgt"]["flags"] = 43;
settings["tools"]["tgt"]["size"][1] = 276;
settings["tools"]["tgt"]["size"][2] = -1;
settings["tools"]["tgt"]["name"] = "xitools.tgt";
settings["tools"]["tgt"]["pos"][1] = 100;
settings["tools"]["tgt"]["pos"][2] = 100;
settings["tools"]["inv"]["isVisible"][1] = true;
settings["tools"]["inv"]["isEnabled"][1] = false;
settings["tools"]["inv"]["size"][1] = 0;
settings["tools"]["inv"]["size"][2] = 0;
settings["tools"]["inv"]["flags"] = 43;
settings["tools"]["inv"]["name"] = "xitools.inventory";
settings["tools"]["inv"]["pos"][1] = 256;
settings["tools"]["inv"]["pos"][2] = 256;
settings["tools"]["tracker"]["isVisible"][1] = true;
settings["tools"]["tracker"]["isEnabled"][1] = false;
settings["tools"]["tracker"]["size"][1] = -1;
settings["tools"]["tracker"]["size"][2] = -1;
settings["tools"]["tracker"]["flags"] = 43;
settings["tools"]["tracker"]["pos"][1] = 100;
settings["tools"]["tracker"]["pos"][2] = 100;
settings["tools"]["tracker"]["name"] = "xitools.tracker";
settings["tools"]["pet"]["isVisible"][1] = true;
settings["tools"]["pet"]["isEnabled"][1] = false;
settings["tools"]["pet"]["size"][1] = 276;
settings["tools"]["pet"]["size"][2] = -1;
settings["tools"]["pet"]["flags"] = 43;
settings["tools"]["pet"]["name"] = "xitools.pet";
settings["tools"]["pet"]["pos"][1] = 100;
settings["tools"]["pet"]["pos"][2] = 100;
settings["tools"]["config"]["isVisible"][1] = false;
settings["tools"]["config"]["isEnabled"][1] = true;
settings["tools"]["config"]["size"][1] = -1;
settings["tools"]["config"]["size"][2] = -1;
settings["tools"]["config"]["flags"] = 2;
settings["tools"]["config"]["name"] = "xitools.config";
settings["tools"]["config"]["pos"][1] = 100;
settings["tools"]["config"]["pos"][2] = 100;

return settings;