--[[
Copyright (c) 2024 Thorny

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

local d3d = require('d3d8');
local ffi = require('ffi');
local config        = require('config');
local customTracker = require('trackers.custom');
local dummyTracker  = require('trackers.dummy');
local trackers      = T{
    { Name='Buff',   Tracker=require('trackers.buff') },
    { Name='Debuff', Tracker=require('trackers.debuff') },
    { Name='Recast', Tracker=require('trackers.recast') },
    { Name='Custom',  Tracker=customTracker },
}

local sprite = ffi.new('ID3DXSprite*[1]');
if (ffi.C.D3DXCreateSprite(d3d.get_device(), sprite) == ffi.C.S_OK) then
    sprite = d3d.gc_safe_release(ffi.cast('ID3DXSprite*', sprite[0]));
else
    sprite = nil;
    Error('Failed to create sprite.');
end

ashita.events.register('d3d_present', 'd3d_present_cb', function ()
    config:Render();
    if (sprite == nil) then
        return;
    end

    sprite:Begin();
    for _,entry in ipairs(trackers) do
        local panel = gPanels[entry.Name];
        if (panel.ShowDebugTimers) then
            entry.Tracker:Tick();
            panel:Render(sprite, dummyTracker:Tick(entry.Name));
        else
            panel:Render(sprite, entry.Tracker:Tick());
        end
    end
    for i = #trackers,1,-1 do
        local panel = gPanels[trackers[i].Name];
        if panel:RenderTooltip(sprite) then
            break;
        end
    end
    sprite:End();
end);

ashita.events.register('mouse', 'mouse_cb', function (e)
    for name,panel in pairs(gPanels) do
        panel:HandleMouse(e);
    end
end);

ashita.events.register('command', 'command_cb', function (e)
    local args = e.command:args();
    if (#args == 0 or string.lower(args[1]) ~= '/tt') then
        return;
    end
    e.blocked = true;

    if (#args == 1) then
        config:Show();
        return;
    end

    if (#args > 1) then
        if (args[2] == 'reposition') then
            for name,panel in pairs(gPanels) do
                panel.AllowDrag = true;
                panel.ShowDebugTimers = true;
            end
        end
        
        if (args[2] == 'lock') then
            for name,panel in pairs(gPanels) do
                panel.AllowDrag = false;
                panel.ShowDebugTimers = false;
            end
        end

        if (args[2] == 'custom') then
            if (#args >= 4) then
                local duration;
                if type(args[4]) == 'string' then
                    local multiplier = 1;
                    local durationTrail = string.lower(string.sub(args[4], -1, -1));
                    if durationTrail == 's' then
                        args[4] = args[4]:sub(1, -2);
                    elseif (durationTrail == 'm') then
                        multiplier = 60;
                        args[4] = args[4]:sub(1, -2);
                    elseif (durationTrail == 'h') then
                        multiplier = 3600;
                        args[4] = args[4]:sub(1, -2);
                    end
                    local time = tonumber(args[4]);
                    if type(time) == 'number' then
                        duration = time * multiplier;
                    end
                elseif type(args[4]) == 'number' then
                    duration = args[4];
                end
                if (type(duration) == 'number') then
                    local newCustomTimer = {
                        Creation = os.clock(),
                        Label = args[3],
                        Local = T{},
                        Expiration = os.clock() + duration,
                        TotalDuration = duration;
                    };
                    -- Optional arguments 
                    if (#args > 4) then
                        for i=5,#args do
                            -- Makes timer repeatable
                            if (string.lower(args[i]) == 'r') then
                                newCustomTimer.Repeat = true;
                                if not newCustomTimer.Loops then
                                    newCustomTimer.Loops = 0;
                                end
                                newCustomTimer.Stop = false;
                            -- Adds # of loops completed
                            elseif (type(args[i]) == 'number' or tonumber(args[i])) then
                                newCustomTimer.Loops = args[i];
                            else
                                local stringTrail = string.lower(string.sub(args[i], -1, -1));
                                local timeSlice = args[i]:sub(1, -2);
                                -- Adds a delay to the inital timer duration
                                if (stringTrail == 'd' and tonumber(timeSlice)) then
                                    newCustomTimer.Local.InitialDuration = newCustomTimer.TotalDuration;
                                    newCustomTimer.Delay = tonumber(timeSlice);
                                    newCustomTimer.Expiration = os.clock() + newCustomTimer.Delay;
                                    newCustomTimer.TotalDuration = newCustomTimer.Delay;
                                -- Creates a timer at specified time HH:MM:SS
                                elseif (stringTrail == "t" and (string.find(timeSlice, ":") == 3 and string.find(timeSlice, ":", 4) == 6)) then
                                    local inputHours = tonumber(string.sub(timeSlice, 1, 2));
                                    local inputMins = tonumber(string.sub(timeSlice, 4, 5));
                                    local inputSecs = tonumber(string.sub(timeSlice, 7, 8));
                                    local currentHours = tonumber(os.date("%H"));
                                    local currentMins = tonumber(os.date("%M"));
                                    local currentSecs = tonumber(os.date("%S"));
                                    local hourDiff = inputHours - currentHours;
                                    local minModifier;
                                    local secModifier;
                                    local hourMult;
                                    local minMult;
                                    local secMult;
                                    local timeUntil;
                                    if (currentMins) then
                                        minModifier = 60 - currentMins;
                                    else    
                                        minModifier = 0;
                                    end
                                    if (currentSecs) then
                                        secModifier = 60 - currentSecs;
                                    else
                                        secModifier = 0;
                                    end

                                    -- Seconds
                                    if (currentSecs < inputSecs) then
                                        secMult = inputSecs - currentSecs;
                                    elseif (currentSecs == inputSecs) then
                                        secMult = 0;
                                    else
                                        secMult = secModifier + inputSecs;
                                    end
                                    -- Minutes
                                    if (minModifier) then 
                                        if (currentSecs > inputSecs) then
                                            minMult = (minModifier - 1) + inputMins;
                                        elseif (currentSecs < inputSecs) then
                                            minMult = minModifier + inputMins;
                                        end
                                        if (inputHours == currentHours or currentMins < inputMins) then
                                            minMult = minMult - 60;
                                        end
                                    else
                                        minMult = inputMins;
                                        if (currentSecs > inputSecs) then
                                            minMult = minMult - 1;
                                        end
                                    end
                                    -- Hours
                                    if (inputHours == currentHours or (inputHours - currentHours == 1 and (currentMins > inputMins or (currentMins == inputMins and currentSecs > inputSecs)))) then
                                        hourMult = 0;
                                    else
                                        if (inputHours < currentHours) then
                                            inputHours = inputHours + 24; 
                                            hourDiff = inputHours - currentHours;       
                                        end
                                        if (currentMins < inputMins or (currentMins == inputMins and currentSecs < inputSecs)) then
                                            hourMult = hourDiff;
                                        else
                                            hourMult = hourDiff - 1;
                                        end
                                    end
                                    if (currentMins == 0 and currentSecs == 0) then
                                        if ((inputHours - currentHours) > 0) then
                                            hourMult = hourMult + 1;
                                        end
                                    end
                                    if (minMult == 60) then
                                        minMult = 0;
                                    end
                                    if (secMult == 60) then
                                        secMult = 0;
                                    end
                                    timeUntil = (hourMult * 3600) + (minMult * 60) + (secMult);
                                    newCustomTimer.Timecode = timeSlice;
                                    newCustomTimer.Local.InitialDuration = newCustomTimer.TotalDuration;
                                    newCustomTimer.Expiration = os.clock() + timeUntil;
                                    newCustomTimer.TotalDuration = timeUntil;
                                elseif (type(args[i]) == 'string') then
                                    newCustomTimer.Tooltip = args[i];
                                end
                            end
                        end
                    end
                    if (newCustomTimer.Delay or newCustomTimer.Timecode) then
                        newCustomTimer.Local.InitialLoops = newCustomTimer.Loops;
                        newCustomTimer.Loops = 'DELAY';
                    end
                    customTracker:AddTimer(newCustomTimer);
                end
            end
            e.blocked = true;
            return;
        end
    end
end);