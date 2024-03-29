-- conquest needs to be included in the luashitacast.lua file. The  line can be added under the other includes: conquest = require('conquest')
-- conquest.setControl() is fired when the incoming packet event listener in luashitacast.lua detects the conquest packet with id: 0x05E
-- on lac updates that main file may be overwritten so make a copy or remember to add the code back in if it is rewritten 

local conquest = {};
conquest.controlTable = {};
conquest.settings = {
    regionControl = false,
    tableInitiated = false
};


-- Initiates Area tables with all relavant zone ids
local ARAGONEU = {
    152, 
    7,
    8,
    151,
    200,
    119,
    120
}
local BASTOK = {
    234,
    235,
    236,
    237
}
local DERFLAND = {
    147,
    197,
    109,
    148,
    110
}
local ELSHIMOLOWLANDS = {
    250,
    252,
    176,
    123
}
local ELSHIMOUPLANDS = {
    207,
    211,
    160,
    205,
    163,
    159,
    124
}
local FAUREGANDI = {
    111,
    203,
    204,
    9,
    206,
    166,
    10
}
local GUSTABERG = {
    191,
    173,
    106,
    143,
    107,
    144,
    172
}
local JEUNO = {
    243,
    244,
    245,
    246
}
local KOLSHUSHU = {
    4,
    118,
    213,
    3,
    198,
    249,
    117
}
local KUZOTZ = {
    209,
    114,
    168,
    208,
    247,
    125
}
local LITELOR = {
    153,
    202,
    154,
    251,
    122,
    121
}
local MOVALPOLOS = {
    13,
    12,
    11
}
local NORVALLEN = {
    105,
    2,
    149,
    195,
    104,
    150,
    1
}
local QUFIMISLAND = {
    127,
    184,
    157,
    126,
    179,
    158
}
local RONFAURE = {
    167,
    101,
    141,
    140,
    139,
    190,
    100,
    142
}
local SANDORIA = {
    230,
    231,
    232,
    233
}
local SARUTABARUTA = {
    146,
    116,
    170,
    145,
    192,
    194,
    169,
    115
}
local TAVNAZIA = {
    24,
    25,
    31,
    27,
    30,
    29,
    28,
    32,
    26
}
local TULIA = {
    181,
    180,
    130,
    178,
    177
}
local VALDEAUNIA = {
    6,
    161,
    162,
    165,
    5,
    112
}
local VOLLBOW = {
    113,
    201,
    212,
    174,
    128
}
local WINDURST = {
    238,
    239,
    240,
    241,
    242
}
local ZULKHEIM = {
    196,
    108,
    102,
    193,
    248,
    103
}
local OTHER = {
    -- Promyvion zones
    14,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    -- Limbus Zones
    37,
    38,
    -- Dynamis Zones
    39,
    40,
    41,
    42,
    134,
    135,
    185,
    186,
    187,
    188,
    -- Airships
    223,
    224,
    225,
    226,
    -- Ferries
    46,
    47,
    220,
    221,
    227,
    228,
    58,
    59,
    -- Misc no nation zones
    43,
    44,
    131,
    70,
}

-- checks if zone is under player's nation's control
conquest.getControl = function()
    local playerNation = AshitaCore:GetMemoryManager():GetPlayer():GetNation() + 1;
    local playerZone = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);

    if (conquest.settings.tableInitiated == true) then
        local message = chat.header("Conquest"):append(chat.message('Zone control: '));
        if playerNation == conquest.controlTable[playerZone] then
            print(message:append(chat.color1(2, 'O')));
            conquest.settings.regionControl = true;
        else 
            print(message:append(chat.color1(8, 'X')));
            conquest.settings.regionControl = false;
        end
    else
        gFunc.Echo(135, "control table has not been created, open /rmap or zone in/out to fill table and try again");
    end
end

-- Fills conquest table for each area and then zone
conquest.setControl = function(e)
    conquest.controlTable['Ronfaure'] = struct.unpack('B', e.data, 0x1E);
    conquest.controlTable['Zulkheim'] = struct.unpack('B', e.data, 0x22);
    conquest.controlTable['Norvallen'] = struct.unpack('B', e.data, 0x26);
    conquest.controlTable['Gustaberg'] = struct.unpack('B', e.data, 0x2A);
    conquest.controlTable['Derfland'] = struct.unpack('B', e.data, 0x2E);
    conquest.controlTable['Sarutabaruta'] = struct.unpack('B', e.data, 0x32);
    conquest.controlTable['Kolshushu'] = struct.unpack('B', e.data, 0x36);
    conquest.controlTable['Aragoneu'] = struct.unpack('B', e.data, 0x3A);
    conquest.controlTable['Fauregandi'] = struct.unpack('B', e.data, 0x3E);
    conquest.controlTable['Valdeaunia'] = struct.unpack('B', e.data, 0x42);
    conquest.controlTable['Qufim'] = struct.unpack('B', e.data, 0x46);
    conquest.controlTable['LiTelor'] = struct.unpack('B', e.data, 0x4A);
    conquest.controlTable['Kuzotz'] = struct.unpack('B', e.data, 0x4E);
    conquest.controlTable['Vollbow'] = struct.unpack('B', e.data, 0x52);
    conquest.controlTable['ElshimoLow'] = struct.unpack('B', e.data, 0x56);
    conquest.controlTable['ElshimoUp'] = struct.unpack('B', e.data, 0x5A);
    conquest.controlTable['TuLia'] = struct.unpack('B', e.data, 0x5E);
    conquest.controlTable['Movapolos'] = struct.unpack('B', e.data, 0x62);
    conquest.controlTable['Tavnazian'] = struct.unpack('B', e.data, 0x66);
    
    for k,v in pairs(ARAGONEU) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Aragoneu'];
    end
    for k,v in pairs(BASTOK) do
        conquest.controlTable[tonumber(v)] = 2;
    end
    for k,v in pairs(DERFLAND) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Derfland'];
    end
    for k,v in pairs(ELSHIMOLOWLANDS) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['ElshimoLow'];
    end
    for k,v in pairs(ELSHIMOUPLANDS) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['ElshimoUp'];
    end
    for k,v in pairs(FAUREGANDI) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Fauregandi'];
    end
    for k,v in pairs(GUSTABERG) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Gustaberg'];
    end
    for k,v in pairs(KOLSHUSHU) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Kolshushu'];
    end
    for k,v in pairs(KUZOTZ) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Kuzotz'];
    end
    for k,v in pairs(LITELOR) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['LiTelor'];
    end
    for k,v in pairs(MOVALPOLOS) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Movalpolos'];
    end
    for k,v in pairs(NORVALLEN) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Norvallen'];
    end
    for k,v in pairs(QUFIMISLAND) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Qufim'];
    end
    for k,v in pairs(RONFAURE) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Ronfaure'];
    end
    for k,v in pairs(SANDORIA) do
        conquest.controlTable[tonumber(v)] = 1;
    end
    for k,v in pairs(SARUTABARUTA) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Sarutabaruta'];
    end
    for k,v in pairs(TAVNAZIA) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Tavnazian'];
    end
    for k,v in pairs(TULIA) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['TuLia'];
    end
    for k,v in pairs(VALDEAUNIA) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Valdeaunia'];
    end
    for k,v in pairs(VOLLBOW) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Vollbow'];
    end
    for k,v in pairs(WINDURST) do
        conquest.controlTable[tonumber(v)] = 3;
    end
    for k,v in pairs(ZULKHEIM) do
        conquest.controlTable[tonumber(v)] = conquest.controlTable['Zulkheim'];
    end
    for k,v in pairs(OTHER) do
        conquest.controlTable[tonumber(v)] = 5;
    end

        conquest.settings.tableInitiated = true;
        conquest.getControl();
end

return conquest;