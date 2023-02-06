--[[
* Addons - Copyright (c) 2021 Ashita Development Team
* Contact: https://www.ashitaxi.com/
* Contact: https://discord.gg/Ashita
*
* This file is part of Ashita.
*
* Ashita is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Ashita is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Ashita.  If not, see <https://www.gnu.org/licenses/>.
--]]

addon.author   = 'Almavivaconte';
addon.name     = 'ticker';
addon.version  = '0.0.2';

require ('common');

local settings = require('settings');
local fonts = require('fonts');
local scaling = require('scaling');
local chat = require('chat');

local default_settings =
T{
    font =
    T{
        family      = 'Arial',
        font_height = scaling.scale_f(16),
        color 		= 0xFFFFFFFF,
        bold 		= true,
        position    = { 30, 30 },
        bgcolor     = 0x80000000,
        bgvisible   = true
    },
};

-- Ticker Variables
local ticker = 
T{
    settings = settings.load(default_settings),
    font = nil,
};

local tickTime = 20;
local party = AshitaCore:GetMemoryManager():GetParty();
local currenstatus = 0;
local _timer = 0;

local function getStatus(index)
    return GetEntity(index).Status;
end

--[[
* event: load
* desc : Event called when the addon is being loaded.
--]]
ashita.events.register('load', 'load_cb', function()
	ticker.font = fonts.new(ticker.settings.font);
end);

--[[
* event: unload
* desc : Event called when the addon is being unloaded.
--]]
ashita.events.register('unload', 'unload_cb', function()
	if (ticker.font ~= nil) then
		ticker.font:destroy();
		ticker.font = nil;
	end	
end);

--[[
* event: d3d_present
* desc : Event called when the Direct3D device is presenting a scene.
--]]
ashita.events.register('d3d_present', 'present_cb', function ()
	-- only run this once a second
	if (os.time() >= _timer + 1) then
		_timer = os.time();

		selfIndex = party:GetMemberTargetIndex(0);
		currentStatus = GetEntity(selfIndex).Status;
		
	    -- Todo: Update the current settings font position...

		if currentStatus ~= nil then
			if currentStatus == 33 then
				ticker.font:SetText(tostring(tickTime));
				ticker.font:SetVisible(true);
				if tickTime > 1 then
					tickTime = tickTime - 1;
				else
					tickTime = 10;
				end 
			else
				tickTime = 20;
				ticker.font:SetVisible(false);
			end
		end
	end
    
end);
