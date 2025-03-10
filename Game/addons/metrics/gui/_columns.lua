local c = {}

c.Damage = {}
c.Healing = {}
c.Acc = {}
c.Crit = {}
c.Kick = {}
c.Spell = {}
c.Single = {}
c.String = {}
c.Util = {}

-- Easier reference for Model's ENUMs.
c.Mode = DB.Enum.Mode
c.Trackable = DB.Enum.Trackable
c.Metric = DB.Enum.Metric

------------------------------------------------------------------------------------------------------
-- Grabs the damage of a certain trackable that the entity has done.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param damage_type string a trackable from the model.
---@param percent? boolean whether or not the damage should be raw or percent.
---@param justify? boolean whether or not to right justify the text
---@param raw? boolean true: just output the raw value; false: output a column to a table.
---@return string
------------------------------------------------------------------------------------------------------
c.Damage.By_Type = function(player_name, damage_type, percent, justify, raw)
    local focused_damage = DB.Data.Get(player_name, damage_type, c.Metric.TOTAL)
    local color = c.String.Color_Zero(focused_damage)
    if percent then
        local total_damage = c.Util.Total_Damage(player_name)
        if raw then return c.String.Format_Percent(focused_damage, total_damage) end
        return UI.TextColored(color, c.String.Format_Percent(focused_damage, total_damage, justify))
    end
    if raw then return c.String.Format_Number(focused_damage) end
    return UI.TextColored(color, c.String.Format_Number(focused_damage, justify))
end

------------------------------------------------------------------------------------------------------
-- Grabs the damage of a certain trackable that the entity has done. Returns the raw number.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param damage_type string a trackable from the model.
---@return number
------------------------------------------------------------------------------------------------------
c.Damage.By_Type_Raw = function(player_name, damage_type)
    return DB.Data.Get(player_name, damage_type, c.Metric.TOTAL)
end

------------------------------------------------------------------------------------------------------
-- Grabs the damage of a certain trackable that the entity's pet has done.
------------------------------------------------------------------------------------------------------
---@param player_name string the entity that owns the pet.
---@param pet_name string the pet that we want the damage for.
---@param damage_type string a trackable from the model.
---@param percent? boolean whether or not the damage should be raw or percent.
---@param justify? boolean whether or not to right justify the text
---@param all_total? boolean controls denominator for %; true = pet total; false = all total
---@return string
------------------------------------------------------------------------------------------------------
c.Damage.Pet_By_Type = function(player_name, pet_name, damage_type, percent, justify, all_total)
    local focused_damage = DB.Pet_Data.Get(player_name, pet_name, damage_type, c.Metric.TOTAL)
    local color = c.String.Color_Zero(focused_damage)
    if percent then
        local total_damage = DB.Data.Get(player_name, c.Trackable.PET, c.Metric.TOTAL)
        if all_total then total_damage = DB.Data.Get(player_name, c.Trackable.TOTAL, c.Metric.TOTAL) end
        return UI.TextColored(color, c.String.Format_Percent(focused_damage, total_damage, justify))
    end
    return UI.TextColored(color, c.String.Format_Number(focused_damage, justify))
end

------------------------------------------------------------------------------------------------------
-- Grabs the magic burst damage for the player.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param percent? boolean whether or not the damage should be raw or percent.
---@param magic_only? boolean whether or not the denominator for percent should be total damage or just magic damage.
---@param justify? boolean whether or not to right justify the text
---@return string
------------------------------------------------------------------------------------------------------
c.Damage.Burst = function(player_name, percent, magic_only, justify)
    local focused_damage = DB.Data.Get(player_name, c.Trackable.MAGIC, c.Metric.BURST_DAMAGE)
    local color = c.String.Color_Zero(focused_damage)
    if percent then
        local total_damage = c.Util.Total_Damage(player_name)
        if magic_only then
            total_damage = DB.Data.Get(player_name, c.Trackable.MAGIC, c.Metric.TOTAL)
        end
        return UI.TextColored(color, c.String.Format_Percent(focused_damage, total_damage, justify))
    end
    return UI.TextColored(color, c.String.Format_Number(focused_damage, justify))
end

------------------------------------------------------------------------------------------------------
-- Grabs the overcure amount for the player.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param justify? boolean whether or not to right justify the text
---@return string
------------------------------------------------------------------------------------------------------
c.Healing.Overcure = function(player_name, justify)
    local overcure = DB.Data.Get(player_name, c.Trackable.HEALING, c.Metric.OVERCURE)
    local color = c.String.Color_Zero(overcure)
    return UI.TextColored(color, c.String.Format_Number(overcure, justify))
end

------------------------------------------------------------------------------------------------------
-- Grabs the total damage that the entity has done.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param percent? boolean whether or not the damage should be raw or percent.
---@param justify? boolean whether or not to right justify the text
---@param raw? boolean true: just output the raw value; false: output a column to a table.
---@return string
------------------------------------------------------------------------------------------------------
c.Damage.Total = function(player_name, percent, justify, raw)
    local grand_total = c.Util.Total_Damage(player_name)
    local color = c.String.Color_Zero(grand_total)

    if percent then
        local party_damage = DB.Team_Damage()
        if raw then return c.String.Format_Percent(grand_total, party_damage) end
        return UI.TextColored(color, c.String.Format_Percent(grand_total, party_damage, justify))
    end

    if raw then return c.String.Format_Number(grand_total) end
    return UI.TextColored(color, c.String.Format_Number(grand_total, justify))
end

------------------------------------------------------------------------------------------------------
-- Grabs the total damage that the entity has done.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@return number
------------------------------------------------------------------------------------------------------
c.Util.Total_Damage = function(player_name)
    if player_name then
        if Metrics.Team.Settings.Include_SC_Damage then
            return DB.Data.Get(player_name, c.Trackable.TOTAL, c.Metric.TOTAL)
        else
            return DB.Data.Get(player_name, c.Trackable.TOTAL_NO_SC, c.Metric.TOTAL)
        end
    end
    return 0
end

------------------------------------------------------------------------------------------------------
-- Grabs an entities accuracy for a specific trackable.
-- Accuracy can be broken up into type--like melee and ranged--or melee and ranged combined.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param acc_type string a trackable from the model.
---@param justify? boolean whether or not to right justify the text
---@param count_type? string used for getting ranged square and truestrike rates.
---@param raw? boolean true: just output the raw value; false: output a column to a table.
---@return string
------------------------------------------------------------------------------------------------------
c.Acc.By_Type = function(player_name, acc_type, justify, count_type, raw)
    local hits, attempts
    if not count_type then count_type = c.Metric.HIT_COUNT end
    if acc_type == DB.Enum.Values.COMBINED then
        local melee_hits = DB.Data.Get(player_name, c.Trackable.MELEE, c.Metric.HIT_COUNT)
        local melee_attempts = DB.Data.Get(player_name, c.Trackable.MELEE, c.Metric.COUNT)
        local ranged_hits = DB.Data.Get(player_name, c.Trackable.RANGED, c.Metric.HIT_COUNT)
        local ranged_attempts = DB.Data.Get(player_name, c.Trackable.RANGED, c.Metric.COUNT)
        hits = melee_hits + ranged_hits
        attempts = melee_attempts + ranged_attempts
    else
        hits = DB.Data.Get(player_name, acc_type, count_type)
        attempts = DB.Data.Get(player_name, acc_type, c.Metric.COUNT)
    end

    local color = Window.Colors.WHITE
    local percent = c.String.Raw_Percent(hits, attempts)
    if percent == 0 then
        color = Window.Colors.DIM
    elseif percent <= DB.Settings.Accuracy_Warning then
        color = Window.Colors.RED
    end

    if raw then return c.String.Format_Percent(hits, attempts) end
    return UI.TextColored(color, c.String.Format_Percent(hits, attempts, justify))
end

------------------------------------------------------------------------------------------------------
-- Grabs the accuracy of a certain trackable that the entity's pet has done.
------------------------------------------------------------------------------------------------------
---@param player_name string the entity that owns the pet.
---@param pet_name string the pet that we want the damage for.
---@param acc_type string a trackable from the model.
---@param justify? boolean whether or not to right justify the text
---@param count_type? string used for getting ranged square and truestrike rates.
---@return string
------------------------------------------------------------------------------------------------------
c.Acc.Pet_By_Type = function(player_name, pet_name, acc_type, justify, count_type)
    if not count_type then count_type = c.Metric.HIT_COUNT end
    local hits = DB.Pet_Data.Get(player_name, pet_name, acc_type, count_type)
    local attempts = DB.Pet_Data.Get(player_name, pet_name, acc_type, c.Metric.COUNT)

    local color = Window.Colors.WHITE
    local percent = c.String.Raw_Percent(hits, attempts)
    if percent == 0 then
        color = Window.Colors.DIM
    elseif percent <= DB.Settings.Accuracy_Warning then
        color = Window.Colors.RED
    end

    return UI.TextColored(color, c.String.Format_Percent(hits, attempts, justify))
end


------------------------------------------------------------------------------------------------------
-- Grabs an entity's accuracy for last {X} amount of attempts. Includes melee and ranged combined.
-- {X} is defined in the model's settings.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@return string
------------------------------------------------------------------------------------------------------
c.Acc.Running = function(player_name)
    local accuracy = DB.Accuracy.Get(player_name)
    local color = Window.Colors.WHITE
    local percent = c.String.Raw_Percent(accuracy[1], accuracy[2])

    if percent == 0 then
        color = Window.Colors.DIM
    elseif percent <= DB.Settings.Accuracy_Warning then
        color = Window.Colors.RED
    end

    return UI.TextColored(color, c.String.Format_Percent(accuracy[1], accuracy[2], true))
end

------------------------------------------------------------------------------------------------------
-- Grabs an entity's critical hit rate for a given trackable.
-- Can also give combine melee/ranged crit rate.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param damage_type string a trackable from the model.
---@param justify? boolean whether or not to right justify the text
---@return string
------------------------------------------------------------------------------------------------------
c.Crit.Rate = function(player_name, damage_type, justify)
    local crits, attempts
    if damage_type == DB.Enum.Values.COMBINED then
        local melee_crits     = DB.Data.Get(player_name, c.Trackable.MELEE, c.Metric.CRIT_COUNT)
        local melee_attempts  = DB.Data.Get(player_name, c.Trackable.MELEE, c.Metric.COUNT)
        local ranged_crits    = DB.Data.Get(player_name, c.Trackable.RANGED, c.Metric.CRIT_COUNT)
        local ranged_attempts = DB.Data.Get(player_name, c.Trackable.RANGED, c.Metric.COUNT)
        crits = melee_crits + ranged_crits
        attempts = melee_attempts + ranged_attempts
    else
        crits = DB.Data.Get(player_name, damage_type, c.Metric.CRIT_COUNT)
        attempts = DB.Data.Get(player_name, damage_type, c.Metric.COUNT)
    end
    local color = c.String.Color_Zero(crits)
    return UI.TextColored(color, c.String.Format_Percent(crits, attempts, justify))
end

------------------------------------------------------------------------------------------------------
-- Grabs an entity's critical hit damage for a given trackable.
-- Can also give combine melee/ranged crit damage.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param damage_type string
---@param percent? boolean whether or not the damage should be raw or percent.
---@param justify? boolean whether or not to right justify the text
---@return string
------------------------------------------------------------------------------------------------------
c.Crit.Damage = function(player_name, damage_type, percent, justify)
    local crit_damage
    if damage_type == DB.Enum.Values.COMBINED then
        local melee_crits  = DB.Data.Get(player_name, c.Trackable.MELEE,  c.Metric.CRIT_DAMAGE)
        local ranged_crits = DB.Data.Get(player_name, c.Trackable.RANGED, c.Metric.CRIT_DAMAGE)
        crit_damage = melee_crits + ranged_crits
    else
        crit_damage = DB.Data.Get(player_name, damage_type, c.Metric.CRIT_DAMAGE)
    end
    local color = c.String.Color_Zero(crit_damage)
    if percent then
        local total_damage = c.Util.Total_Damage(player_name)
        return UI.TextColored(color, c.String.Format_Percent(crit_damage, total_damage, justify))
    end
    return UI.TextColored(color, c.String.Format_Number(crit_damage, justify))
end

------------------------------------------------------------------------------------------------------
-- Shows an entity's kick rate.
------------------------------------------------------------------------------------------------------
---@param player_name string
------------------------------------------------------------------------------------------------------
c.Kick.Rate = function(player_name)
    local kick_count = DB.Data.Get(player_name, c.Trackable.MELEE_KICK, c.Metric.COUNT)
    local melee_count = DB.Data.Get(player_name, c.Trackable.MELEE, c.Metric.COUNT)
    local color = c.String.Color_Zero(kick_count)
    return UI.TextColored(color, c.String.Format_Percent(kick_count, melee_count))
end

------------------------------------------------------------------------------------------------------
-- Shows MP a player has used.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param magic_type string
---@param justify? boolean whether or not to right justify the text
---@return string
------------------------------------------------------------------------------------------------------
c.Spell.MP = function(player_name, magic_type, justify)
    if not magic_type then magic_type = c.Trackable.MAGIC end
    local mp = 0
    if magic_type == "Other" then
        local total = DB.Data.Get(player_name, c.Trackable.MAGIC, c.Metric.MP_SPENT)
        local healing = DB.Data.Get(player_name, c.Trackable.HEALING, c.Metric.MP_SPENT)
        local nuke = DB.Data.Get(player_name, c.Trackable.NUKE, c.Metric.MP_SPENT)
        local enfeeble = DB.Data.Get(player_name, c.Trackable.ENFEEBLE, c.Metric.MP_SPENT)
        local enspell = DB.Data.Get(player_name, c.Trackable.ENSPELL, c.Metric.MP_SPENT)
        local mp_drain = DB.Data.Get(player_name, c.Trackable.MP_DRAIN, c.Metric.MP_SPENT)
        mp = total - healing - nuke - enfeeble - enspell - mp_drain
    else
        mp = DB.Data.Get(player_name, magic_type, c.Metric.MP_SPENT)
    end
    local color = c.String.Color_Zero(mp)
    return UI.TextColored(color, c.String.Format_Number(mp, justify))
end

------------------------------------------------------------------------------------------------------
-- Shows many much MP is used per damage or healing done.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param magic_type string
---@return string
------------------------------------------------------------------------------------------------------
c.Spell.Unit_Per_MP = function(player_name, magic_type)
    local mp = DB.Data.Get(player_name, magic_type, c.Metric.MP_SPENT)
    local unit = DB.Data.Get(player_name, magic_type, c.Metric.TOTAL)
    local color = c.String.Color_Zero(unit)
    return UI.TextColored(color, string.format("%.1f", c.String.Raw_Percent(unit, mp)))
end

------------------------------------------------------------------------------------------------------
-- Grabs how many times an entity has died.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@return string
------------------------------------------------------------------------------------------------------
c.Deaths = function(player_name)
    local death_count = DB.Data.Get(player_name, c.Trackable.DEATH, c.Metric.COUNT)
    local color = c.String.Color_Zero(death_count)
    return UI.TextColored(color, c.String.Format_Number(death_count))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- Grabs the total amount of damage a cataloged action has done for a given trackable and metric.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param action_name string
---@param focus_type string a trackable from the model.
---@param metric string a metric from the model.
---@param percent? boolean whether or not the damage should be raw or percent.
---@param raw? boolean true: just output the raw value; false: output a column to a table.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Damage = function(player_name, action_name, focus_type, metric, percent, raw)
    local single_damage
    if metric == DB.Enum.Values.IGNORE then
        single_damage = 0
    else
        single_damage = DB.Catalog.Get(player_name, focus_type, action_name, metric)
    end

    local color = c.String.Color_Zero(single_damage)
    if percent then
        local total_damage = c.Util.Total_Damage(player_name)
        if raw then return c.String.Format_Percent(single_damage, total_damage) end
        return UI.TextColored(color, c.String.Format_Percent(single_damage, total_damage))
    end
    if raw then return c.String.Format_Number(single_damage) end
    return UI.TextColored(color, c.String.Format_Number(single_damage))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- Grabs the total amount of damage a cataloged action has done for a given trackable and metric.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param action_name string
---@param focus_type string a trackable from the model.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Damage_Per_MP = function(player_name, action_name, focus_type)
    local single_damage = DB.Catalog.Get(player_name, focus_type, action_name, c.Metric.TOTAL)
    local mp = DB.Catalog.Get(player_name, focus_type, action_name, c.Metric.MP_SPENT)
    local color = c.String.Color_Zero(mp)
    if single_damage == 0 or mp == 0 then color = Window.Colors.DIM end
    return UI.TextColored(color, string.format("%.1f", c.String.Raw_Percent(single_damage, mp)))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- This is for pet actions.
-- Grabs the total amount of damage a cataloged action has done for a given trackable and metric.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param pet_name string
---@param action_name string
---@param trackable string a trackable from the model.
---@param metric string a metric from the model.
---@param percent? boolean whether or not the damage should be raw or percent.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Pet_Damage = function(player_name, pet_name, action_name, trackable, metric, percent)
    local single_damage
    if metric == DB.Enum.Values.IGNORE then
        single_damage = 0
    else
        single_damage = DB.Pet_Catalog.Get(player_name, pet_name, trackable, action_name, metric)
    end
    local color = c.String.Color_Zero(single_damage)
    if percent then
        local total_damage = DB.Pet_Data.Get(player_name, pet_name, c.Trackable.TOTAL, c.Metric.TOTAL)
        return UI.TextColored(color, c.String.Format_Percent(single_damage, total_damage))
    end
    return UI.TextColored(color, c.String.Format_Number(single_damage))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- Grabs how many times a cataloged action was attempted for a given trackable.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param action_name string
---@param focus_type string a trackable from the model.
---@param raw? boolean true: just output the raw value; false: output a column to a table.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Attempts = function(player_name, action_name, focus_type, raw)
    local single_attempts = DB.Catalog.Get(player_name, focus_type, action_name, c.Metric.COUNT)
    local color = c.String.Color_Zero(single_attempts)
    if raw then return c.String.Format_Number(single_attempts) end
    return UI.TextColored(color, c.String.Format_Number(single_attempts))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- Returns how much total MP was used for a specific spell.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param action_name string
---@param focus_type string a trackable from the model.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.MP_Used = function(player_name, action_name, focus_type)
    local mp = DB.Catalog.Get(player_name, focus_type, action_name, c.Metric.MP_SPENT)
    local color = c.String.Color_Zero(mp)
    return UI.TextColored(color, c.String.Format_Number(mp))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- This is for pet actions.
-- Grabs how many times a cataloged action was attempted for a given trackable.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param pet_name string
---@param action_name string
---@param trackable string a trackable from the model.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Pet_Attempts = function(player_name, pet_name, action_name, trackable)
    local single_attempts = DB.Pet_Catalog.Get(player_name, pet_name, trackable, action_name, c.Metric.COUNT)
    local color = c.String.Color_Zero(single_attempts)
    return UI.TextColored(color, c.String.Format_Number(single_attempts))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- Grabs how many times a cataloged action was magic burst.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param action_name string
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Bursts = function(player_name, action_name)
    local burst_count = DB.Catalog.Get(player_name, c.Trackable.NUKE, action_name, c.Metric.BURST_COUNT)
    local color = c.String.Color_Zero(burst_count)
    return UI.TextColored(color, c.String.Format_Number(burst_count))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- Grabs how overcure was done with a certain spell.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param action_name string
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Overcure = function(player_name, action_name)
    local overcure = DB.Catalog.Get(player_name, c.Trackable.HEALING, action_name, c.Metric.OVERCURE)
    local color = c.String.Color_Zero(overcure)
    return UI.TextColored(color, c.String.Format_Number(overcure))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- Grabs the accuracy for a given cataloged action and trackable.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param action_name string
---@param focus_type string a trackable from the model.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Acc = function(player_name, action_name, focus_type)
    local single_hits = DB.Catalog.Get(player_name, focus_type, action_name, c.Metric.HIT_COUNT)
    local single_attempts = DB.Catalog.Get(player_name, focus_type, action_name, c.Metric.COUNT)
    local color = c.String.Color_Zero(single_hits)
    return UI.TextColored(color, c.String.Format_Percent(single_hits, single_attempts))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- This is for pet actions.
-- Grabs the accuracy for a given cataloged action and trackable.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param pet_name string
---@param action_name string
---@param trackable string a trackable from the model.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Pet_Acc = function(player_name, pet_name, action_name, trackable)
    local single_hits = DB.Pet_Catalog.Get(player_name, pet_name, trackable, action_name, c.Metric.HIT_COUNT)
    local single_attempts = DB.Pet_Catalog.Get(player_name, pet_name, trackable, action_name, c.Metric.COUNT)
    local color = c.String.Color_Zero(single_hits)
    return UI.TextColored(color, c.String.Format_Percent(single_hits, single_attempts))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- Grabs the usage rate of specfic enspells.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param action_name string
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Enspell_Acc = function(player_name, action_name)
    local procs = DB.Catalog.Get(player_name, c.Trackable.ENSPELL, action_name, c.Metric.HIT_COUNT)
    local attempts = DB.Data.Get(player_name, c.Trackable.MELEE, c.Metric.COUNT)
    local color = c.String.Color_Zero(procs)
    return UI.TextColored(color, c.String.Format_Percent(procs, attempts))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- Grabs the average damage for a given cataloged action and trackable.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param action_name string
---@param focus_type string a trackable from the model.
---@param raw? boolean true: just output the raw value; false: output a column to a table.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Average = function(player_name, action_name, focus_type, raw)
    local single_hits = DB.Catalog.Get(player_name, focus_type, action_name, c.Metric.HIT_COUNT)
    local color = c.String.Color_Zero(single_hits)
    if single_hits == 0 then
        if raw then return c.String.Format_Number(0) end
        return UI.TextColored(color, c.String.Format_Number(0))
    end
    local single_damage  = DB.Catalog.Get(player_name, focus_type, action_name, c.Metric.TOTAL)
    local single_average = single_damage / single_hits
    color = c.String.Color_Zero(single_damage)
    if raw then return c.String.Format_Number(single_average) end
    return UI.TextColored(color, c.String.Format_Number(single_average))
end

------------------------------------------------------------------------------------------------------
-- This is for cataloged actions.
-- This is for pet actions.
-- Grabs the average damage for a given cataloged action and trackable.
------------------------------------------------------------------------------------------------------
---@param player_name string
---@param pet_name string
---@param action_name string
---@param trackable string a trackable from the model.
---@return string
------------------------------------------------------------------------------------------------------
c.Single.Pet_Average = function(player_name, pet_name, action_name, trackable)
    local single_hits = DB.Pet_Catalog.Get(player_name, pet_name, trackable, action_name, c.Metric.HIT_COUNT)
    local single_damage  = DB.Pet_Catalog.Get(player_name, pet_name, trackable, action_name, c.Metric.TOTAL)
    local color = c.String.Color_Zero(single_hits)
    if single_hits == 0 or single_damage == 0 then
        color = Window.Colors.DIM
        return UI.TextColored(color, c.String.Format_Number(0))
    end
    local single_average = single_damage / single_hits
    return UI.TextColored(color, c.String.Format_Number(single_average))
end

------------------------------------------------------------------------------------------------------
-- Create a nicely formatted number string.
-- I floor the number to get rid of any decimals. Decimals were a problem with the average column.
------------------------------------------------------------------------------------------------------
---@param number number this should be an actual number and not a string.
---@param justify? boolean whether or not to right justify the text
---@return string
------------------------------------------------------------------------------------------------------
c.String.Format_Number = function(number, justify)
    local format = "%d"
    if justify then format = "%6d" end
    if Metrics.Team.Settings.Condensed_Numbers then return c.String.Compact_Number(number, justify) end
    number = math.floor(number)
    return string.format(format, number)
end

------------------------------------------------------------------------------------------------------
-- Calculates and formats a percent.
------------------------------------------------------------------------------------------------------
---@param numerator number The numerator for the percent.
---@param denominator number The denominator for the percent.
---@param justify? boolean whether or not to right justify the text
---@return string
------------------------------------------------------------------------------------------------------
c.String.Format_Percent = function(numerator, denominator, justify)
    local format = "%.1f"
    if justify then format = "%5.1f" end
    if not denominator or denominator == 0 then return string.format(format, 0) end
    local percent = (numerator / denominator) * 100
    if percent == 0 then return string.format(format, 0) end
    return string.format(format, percent)
end

------------------------------------------------------------------------------------------------------
-- Calculates and returns a raw percent as a number.
------------------------------------------------------------------------------------------------------
---@param numerator number The numerator for the percent.
---@param denominator number The denominator for the percent.
---@return number
------------------------------------------------------------------------------------------------------
c.String.Raw_Percent = function(numerator, denominator)
    if not denominator or denominator == 0 then return 0 end
    return numerator / denominator
end

------------------------------------------------------------------------------------------------------
-- Handles formatting numbers into a more compact easier to read mode (with rounding).
-- Mode examples: Compact = 2.5M; Regular = 2,500,000
------------------------------------------------------------------------------------------------------
---@param number number this should be an actual number and not a string.
---@param justify? boolean whether or not to right justify the text
---@return string
------------------------------------------------------------------------------------------------------
c.String.Compact_Number = function(number, justify)
    number = number or 0

    local display_number, suffix
    local length = 6

    -- Millions
    if number >= 1000000 then
        display_number = (number / 1000000)
        suffix = " M"
        length = length - 2
    -- Thousands
    elseif number >= 1000 then
        display_number = (number / 1000)
        suffix = " K"
        length = length - 2
    -- No adjustments necessary
    else
        display_number = number
        suffix = ""
    end

    local format = "%d"
    if justify then format = "%" .. length .. "d" end

    if number == 0 then return string.format(format, number) end

    return string.format(format, display_number) .. suffix
end

------------------------------------------------------------------------------------------------------
-- Truncates a string if it is too long.
------------------------------------------------------------------------------------------------------
---@param string string
---@param limit number
---@return string
------------------------------------------------------------------------------------------------------
c.String.Truncate = function(string, limit)
    local length = string.len(string)
    if length <= limit then return string end
    return string.sub(string, 1, limit) .. "."
end

------------------------------------------------------------------------------------------------------
-- Makes zero values dim.
------------------------------------------------------------------------------------------------------
---@param value number
---@return table
------------------------------------------------------------------------------------------------------
c.String.Color_Zero = function(value)
    if value == 0 then return Window.Colors.DIM end
    return Window.Colors.WHITE
end

------------------------------------------------------------------------------------------------------
-- NOT IN USE. I COULDN'T GET THIS TO WORK WITH RIGHT ALIGNMENT.
-- Adds commas to large numbers for easier readability.
------------------------------------------------------------------------------------------------------
-- ---@param number number the number to be formatted with commas.
-- ---@return string
------------------------------------------------------------------------------------------------------
-- c.String.Add_Comma = function(number)
--     -- Take the string apart
--     local str = tostring(number)
--     str = string.format("%6.0f", str)
--     local length = string.len(str)
--     local numbers = {}
--     for i = 1, length, 1 do numbers[i] = string.byte(str, i) end

--     -- Rebuild adding a comma after every third number
--     local new_str = ""
--     local count = 0
--     for i = length, 1, -1 do
--         if count > 0 and (count % 3) == 0 then new_str = ","  ..  new_str end
--         new_str = string.char(numbers[i]) .. new_str
--         count = count + 1
--     end

--     return new_str
-- end

return c