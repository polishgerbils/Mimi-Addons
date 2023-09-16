--[[
Copyright (c) 2023 Lunaretic

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

local function CalculateBloodPactDuration(base)
    local skill = gData.GetCombatSkill(38);
    if skill > 300 then
        return base + (skill - 300);
    end
    return base;
end

local function CalculateManeuverDuration()
    --This can be calculated but not necessarily straightforward.
    return 60;
end


-- All of the pacts with a 0 ID have not been filled in yet.
local function FillAbilityTable(abilityTable)

    --Shining Ruby
    abilityTable[908] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Glittering Ruby
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --[[UNKNOWN
    --Mewing Lullaby
    abilityTable[522] = function(targetId)
        return nil;
    end
    ]]--

    --[[UNKNOWN
    --Eerie Eye
    abilityTable[523] = function(targetId)
        return nil;
    end
    ]]--

    --Reraise II
    abilityTable[526] = function(targetId)
        return 3600;
    end

    --Ecliptic Growl
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Ecliptic Howl
    abilityTable[844] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Heavenward Howl
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(60);
    end

    --Crimson Howl
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(60);
    end

    --Inferno Howl
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(60);
    end

    --Conflag Strike
    abilityTable[0] = function(targetId)
        return 60;
    end

    --[[UNKNOWN
    --Rock Throw
    abilityTable[560] = function(targetId)
        return nil;
    end
    ]]--
    
    --Rock Buster
    abilityTable[0] = function(targetId)
        return 30;
    end

    --[[UNKNOWN
    --Megalith Throw
    abilityTable[563] = function(targetId)
        return nil;
    end
    ]]--

    --Earthen Ward
    abilityTable[0] = function(targetId)
        return 900;
    end

    --Stone IV
    abilityTable[0] = function(targetId)
        return nil;
    end

    --[[UNKNOWN
    --Mountain Buster
    abilityTable[566] = function(targetId)
        return nil;
    end
    ]]--

    --Earthen Armor
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(60);
    end

    --Crag Throw
    abilityTable[0] = function(targetId)
        return 120;
    end

	-- Spring Water
    abilityTable[861] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --[[UNKNOWN
    --Tail Whip
    abilityTable[578] = function(targetId)
        return nil;
    end
    ]]--

    --[[UNKNOWN
    --Slowga
    abilityTable[580] = function(targetId)
        return nil;
    end
    ]]--

    --Tidal Roar
    abilityTable[0] = function(targetId)
        return 90;
    end

    --Soothing Current
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Hastega
    abilityTable[870] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Aerial Armor
    abilityTable[0] = function(targetId)
        return 900;
    end

    --Fleet Wind
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(120);
    end

    --Hastega II
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Frost Armor
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Sleepga
    abilityTable[0] = function(targetId)
        return 90;
    end

    --Diamond Storm
    abilityTable[0] = function(targetId)
        return 180;
    end

    --Crystal Blessing
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Rolling Thunder
    abilityTable[887] = function(targetId)
        return CalculateBloodPactDuration(120);
    end

    --Lightning Armor
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Shock Squall
    abilityTable[0] = function(targetId)
        return 15;
    end

    --Volt Strike
    abilityTable[0] = function(targetId)
        return 15;
    end

    --Nightmare
    abilityTable[0] = function(targetId)
        return 90;
    end
    
    --Noctoshield
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Dream Shroud
    abilityTable[0] = function(targetId)
        return CalculateBloodPactDuration(180);
    end

    --Perfect Defense
    abilityTable[0] = function(targetId)
        return 30 + math.floor(gData.GetCombatSkill(38) / 20);
    end

end

return FillAbilityTable;
