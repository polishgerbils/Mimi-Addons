Parse.Full = T{}
Parse.Full.Name = "Parse"
Parse.Full.Table_Flags = bit.bor(ImGuiTableFlags_PadOuterX, ImGuiTableFlags_Borders)
Parse.Full.Width = T{
    Base = 410,
}

------------------------------------------------------------------------------------------------------
-- Loads the Team data to the screen.
------------------------------------------------------------------------------------------------------
Parse.Full.Populate = function()
    Parse.Widgets.Settings_Button()
    UI.SameLine() UI.Text(" ") UI.SameLine() Parse.Widgets.Filter_Button()
    UI.SameLine() UI.Text(" ") UI.SameLine() Parse.Widgets.Timer_Button()
    UI.SameLine() UI.Text(" ") UI.SameLine() Parse.Widgets.Reset_Button()
    if Parse.Confirmation then UI.SameLine() UI.Text(" ") UI.SameLine() Parse.Widgets.Reset_Confirmation_Button() end
    if Metrics.Parse.Show_Filter then DB.Widgets.Mob_Filter() end
    Parse.Widgets.Clock()

    local player = Ashita.Player.My_Mob()
    if not player then return nil end

    if UI.BeginTable(Parse.Full.Name, Parse.Columns.Current, Parse.Full.Table_Flags) then
        Parse.Full.Headers()

        local player_name = "Debug"
        DB.Lists.Sort.Total_Damage()
        for rank, data in ipairs(DB.Sorted.Total_Damage) do
            if rank <= Parse.Config.Rank_Cutoff() then
                player_name = data[1]
                Parse.Full.Rows(player_name)
            elseif data[1] == player.name then
                Parse.Full.Rows(player.name)
            end
        end
        if Metrics.Parse.Grand_Totals and #DB.Sorted.Total_Damage > 0 then Parse.Full.Total_Row() end

        UI.EndTable()
    end
end

------------------------------------------------------------------------------------------------------
-- Sets up the headers for the Team table.
------------------------------------------------------------------------------------------------------
Parse.Full.Headers = function()
    local flags = Column.Flags.None

    if Metrics.Parse.Jobs then         UI.TableSetupColumn("Job", flags) end

    UI.TableSetupColumn("Name", flags)
    UI.TableSetupColumn("Total", flags)
    UI.TableSetupColumn("%T", flags)

    if Metrics.Parse.Attack_Speed then UI.TableSetupColumn("Speed", flags) end
    if Metrics.Parse.DPS then          UI.TableSetupColumn("DPS", flags) end
    if Metrics.Parse.Running_Acc then  UI.TableSetupColumn("%A-" .. Metrics.Model.Running_Accuracy_Limit, flags) end
    if Metrics.Parse.Total_Acc then    UI.TableSetupColumn("%A-T", flags) end
    if Metrics.Parse.Melee then        UI.TableSetupColumn("Melee", flags) end
    if Metrics.Parse.Crit then         UI.TableSetupColumn("Crit Rate", flags) end
    if Metrics.Parse.Average_WS then   UI.TableSetupColumn("Avg WS", flags) end
    if Metrics.Parse.Weaponskill then  UI.TableSetupColumn("WS", flags) end
    if Parse.Config.Include_SC_Damage() then UI.TableSetupColumn("SC", flags) end
    if Metrics.Parse.Ranged then       UI.TableSetupColumn("Ranged", flags) end
    if Metrics.Parse.Magic then        UI.TableSetupColumn("Magic", flags) end
    if Metrics.Parse.Ability then      UI.TableSetupColumn("JA", flags) end
    if Metrics.Parse.Pet_Acc then      UI.TableSetupColumn("Acc (P)", flags) end
    if Metrics.Parse.Pet_Melee then    UI.TableSetupColumn("Melee (P)", flags) end
    if Metrics.Parse.Pet_Ranged then   UI.TableSetupColumn("Ranged (P)", flags) end
    if Metrics.Parse.Pet_WS then       UI.TableSetupColumn("WS (P)", flags) end
    if Metrics.Parse.Pet_Ability then  UI.TableSetupColumn("Ability (P)", flags) end
    if Metrics.Parse.Healing then      UI.TableSetupColumn("Healing", flags) end
    if Metrics.Parse.Deaths then       UI.TableSetupColumn("Deaths", flags) end

    UI.TableHeadersRow()
end

------------------------------------------------------------------------------------------------------
-- Loads data into the rows of the Team table.
------------------------------------------------------------------------------------------------------
---@param player_name string
------------------------------------------------------------------------------------------------------
Parse.Full.Rows = function(player_name)
    UI.TableNextRow()

    if Metrics.Parse.Jobs then         UI.TableNextColumn() Column.String.Job(player_name) end

    UI.TableNextColumn() Column.String.Format_Name(player_name)
    UI.TableNextColumn() Column.Damage.Total(player_name, false, true)
    UI.TableNextColumn() Column.Damage.Total(player_name, true, true)

    if Metrics.Parse.Attack_Speed then UI.TableNextColumn() Column.Attack_Speed.Get(player_name, true) end
    if Metrics.Parse.DPS then          UI.TableNextColumn() Column.Damage.DPS(player_name, true) end
    if Metrics.Parse.Running_Acc then  UI.TableNextColumn() Column.Acc.Running(player_name) end
    if Metrics.Parse.Total_Acc then    UI.TableNextColumn() Column.Acc.By_Type(player_name, DB.Enum.Values.COMBINED, true) end
    if Metrics.Parse.Melee then        UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.MELEE, false, true) end
    if Metrics.Parse.Crit then         UI.TableNextColumn() Column.Proc.Crit_Rate(player_name, DB.Enum.Values.COMBINED, true) end
    if Metrics.Parse.Average_WS then   UI.TableNextColumn() Column.Damage.Average_By_Type(player_name, DB.Enum.Trackable.WS, true) end
    if Metrics.Parse.Weaponskill then  UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.WS, false, true) end
    if Parse.Config.Include_SC_Damage() then UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.SC, false, true) end
    if Metrics.Parse.Ranged then       UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.RANGED, false, true) end
    if Metrics.Parse.Magic then        UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.MAGIC, false, true) end
    if Metrics.Parse.Ability then      UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.ABILITY_DAMAGING, false, true) end
    if Metrics.Parse.Pet_Acc then      UI.TableNextColumn() Column.Acc.By_Type(player_name, DB.Enum.Trackable.PET_MELEE_DISCRETE) end
    if Metrics.Parse.Pet_Melee then    UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.PET_MELEE, false, true) end
    if Metrics.Parse.Pet_Ranged then   UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.PET_RANGED, false, true) end
    if Metrics.Parse.Pet_WS then       UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.PET_WS, false, true) end
    if Metrics.Parse.Pet_Ability then  UI.TableNextColumn() Column.Damage.By_Type(player_name, DB.Enum.Trackable.PET_ABILITY, false, true) end
    if Metrics.Parse.Healing then      UI.TableNextColumn() Column.Healing.Total(player_name, false, true) end
    if Metrics.Parse.Deaths then       UI.TableNextColumn() Column.Proc.Deaths(player_name) end
end

------------------------------------------------------------------------------------------------------
-- Shows totals for each column.
------------------------------------------------------------------------------------------------------
Parse.Full.Total_Row = function()
    UI.TableNextRow()
    local x, y, z, w = UI.GetStyleColorVec4(ImGuiCol_TableHeaderBg)
    local row_bg_color = UI.GetColorU32({x, y, z, w})
    UI.TableSetBgColor(ImGuiTableBgTarget_RowBg0, row_bg_color)

    UI.TableNextColumn() UI.Text("Total")
    UI.TableNextColumn() Column.Damage.Parse_Total(true)
    UI.TableNextColumn() UI.Text(" ")

    if Metrics.Parse.Attack_Speed then UI.TableNextColumn() UI.Text(" ") end
    if Metrics.Parse.DPS then          UI.TableNextColumn() Column.Damage.Parse_DPS(true) end
    if Metrics.Parse.Running_Acc then  UI.TableNextColumn() UI.Text(" ") end
    if Metrics.Parse.Total_Acc then    UI.TableNextColumn() UI.Text(" ") end
    if Metrics.Parse.Melee then        UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.MELEE, true) end
    if Metrics.Parse.Crit then         UI.TableNextColumn() UI.Text(" ") end
    if Metrics.Parse.Average_WS then   UI.TableNextColumn() UI.Text(" ") end
    if Metrics.Parse.Weaponskill then  UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.WS, true) end
    if Parse.Config.Include_SC_Damage() then UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.SC, true) end
    if Metrics.Parse.Ranged then       UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.RANGED, true) end
    if Metrics.Parse.Magic then        UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.MAGIC, true) end
    if Metrics.Parse.Ability then      UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.ABILITY_DAMAGING, true) end
    if Metrics.Parse.Pet_Acc then      UI.TableNextColumn() UI.Text(" ") end
    if Metrics.Parse.Pet_Melee then    UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.PET_MELEE, true) end
    if Metrics.Parse.Pet_Ranged then   UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.PET_RANGED, true) end
    if Metrics.Parse.Pet_WS then       UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.PET_WS, true) end
    if Metrics.Parse.Pet_Ability then  UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.PET_ABILITY, true) end
    if Metrics.Parse.Healing then      UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.ALL_HEAL, true) end
    if Metrics.Parse.Deaths then       UI.TableNextColumn() Column.Damage.Trackable_Total(DB.Enum.Trackable.DEATH, true) end
end

------------------------------------------------------------------------------------------------------
-- Toggles full mode.
------------------------------------------------------------------------------------------------------
Parse.Full.Enable = function()
    Metrics.Parse.Display_Mode = Parse.Enum.Display_Mode.FULL
end