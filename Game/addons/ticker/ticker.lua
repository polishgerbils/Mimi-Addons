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
local display = {};
local osd = {};
local defaults = T{
	visible = true,
	font_family = 'Arial',
	font_height = 24,
	color = 0xFFFFFFFF,
	position_x = 705,
	position_y = 1400,
	background = T{
		visible = false,
		color = 0xFF000000,
	}
};

local tickTime = 20;
local party = AshitaCore:GetMemoryManager():GetParty();
local _timer = 0;

ashita.events.register('load', 'load_cb', function()
    osd.settings = settings.load(defaults);
    
    display = fonts.new(osd.settings);
end);

ashita.events.register('unload', 'unload_cb', function()
    settings.save();

    if (display ~= nil) then
		display:destroy();
	end
end);

ashita.events.register('d3d_present', 'present_cb', function ()
	-- only run this once a second
	if (os.time() >= _timer + 1) then
		_timer = os.time();

		selfIndex = party:GetMemberTargetIndex(0);
		if selfIndex ~= nil then
			local me = GetEntity(selfIndex)
			if me ~= nil then
				currentStatus = me.Status;
			end
		end

		if currentStatus ~= nil then
			if currentStatus == 33 then
				display.text = tostring(tickTime);
				display.visible = true;
				if tickTime > 1 then
					tickTime = tickTime - 1;
				else
					tickTime = 10;
				end 
			else
				tickTime = 20;
				display.visible = false;
			end
		end
	end

    if display.position_x ~= osd.settings.position_x or display.position_y ~= osd.settings.position_y then
        osd.settings.position_x = display.position_x;
        osd.settings.position_y = display.position_y;
        settings.save();
    end
end);
