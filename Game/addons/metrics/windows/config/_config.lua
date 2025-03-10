Config = {}

Config.Section = {}
Config.Widget = {}

Config.Enum = {}
Config.Enum.File = {
    PARSE    = "parse",
    FOCUS    = "focus",
    BLOG     = "blog",
    WINDOW   = "window",
    DATABASE = "database",
    REPORT   = "report",
    CONFIG   = "config",    -- Just used for Settings Mode.
    EXP      = "exp",
}

Config.Settings_Mode = Config.Enum.File.CONFIG
Config.Full_Width = 120
Config.Short_Width = 75
Config.Desc_Width = 300

require("windows.config.window")

------------------------------------------------------------------------------------------------------
-- Loads the settings data to the screen.
------------------------------------------------------------------------------------------------------
Config.Populate = function()
    local tab_flags = Window.Tabs.Flags

    if UI.BeginTabBar("Focus Tabs", tab_flags) then
        if UI.BeginTabItem("Help", tab_flags) then
            Config.Section.Text_Commands()
            UI.EndTabItem()
        end
        if UI.BeginTabItem("Focus", tab_flags) then
            Config.Section.Focus()
            UI.EndTabItem()
        end
        if UI.BeginTabItem("GUI", tab_flags) then
            Window.Config.Display()
            UI.EndTabItem()
        end
        if UI.BeginTabItem("Revert", tab_flags) then
            Config.Section.Revert()
            UI.EndTabItem()
        end
        if _Debug.Is_Enabled() then
            if UI.BeginTabItem("Debug", tab_flags) then
                _Debug.Config.Display()
                UI.EndTabItem()
            end
        end
        UI.EndTabBar()
    end
end

------------------------------------------------------------------------------------------------------
-- Revert and collapse setting buttons.
------------------------------------------------------------------------------------------------------
Config.Section.Revert = function()
    local clicked = 0
    if UI.Button("Revert to Default Settings") then
        clicked = 1
        if clicked and 1 then
            Window.Config.Reset()
            Parse.Config.Reset()
            Focus.Reset_Settings()
            Blog.Config.Reset()
            Report.Config.Reset()
            Metrics.Model.Running_Accuracy_Limit = DB.Defaults.Running_Accuracy_Limit
        end
    end
end

------------------------------------------------------------------------------------------------------
-- Shows text commands the user can use.
------------------------------------------------------------------------------------------------------
Config.Section.Text_Commands = function()
    UI.Text("Bug Reports and ReadMe: https://github.com/RaraProjects/metrics")
    UI.Text("Version: " .. tostring(addon.version))

    UI.Text("Base command: /metrics or /met")
    if UI.CollapsingHeader("Commands: General") then
        if UI.BeginTable("General Commands", 3, Window.Table.Flags.Borders) then
            UI.TableSetupColumn("Full", Column.Flags.None, Config.Full_Width)
            UI.TableSetupColumn("Short", Column.Flags.None, Config.Short_Width)
            UI.TableSetupColumn("Description", Column.Flags.None)
            UI.TableHeadersRow()

            UI.TableNextRow()
            UI.TableNextColumn() UI.Text("{none}")
            UI.TableNextColumn()
            UI.TableNextColumn() UI.Text("Toggles settings window.")

            UI.TableNextColumn() UI.Text("reset")
            UI.TableNextColumn() UI.Text("r")
            UI.TableNextColumn() UI.Text("Clears the database.")

            UI.TableNextColumn() UI.Text("show")
            UI.TableNextColumn() UI.Text("s")
            UI.TableNextColumn() UI.Text("Toggles window visibility.")

            UI.TableNextColumn() UI.Text("percent")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Toggles showing numerators and denominators for percents.")

            UI.EndTable()
        end
    end

    if UI.CollapsingHeader("Commands: Switch Tabs/Windows") then
        if UI.BeginTable("Switch Commands", 3, Window.Table.Flags.Borders) then
            UI.TableSetupColumn("Full", Column.Flags.None, Config.Full_Width)
            UI.TableSetupColumn("Short", Column.Flags.None, Config.Short_Width)
            UI.TableSetupColumn("Description", Column.Flags.None)
            UI.TableHeadersRow()

            UI.TableNextRow()
            UI.TableNextColumn() UI.Text("parse")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Switch to the Parse tab.")

            UI.TableNextColumn() UI.Text("focus")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Switch to the Focus tab.")

            UI.TableNextColumn() UI.Text("log")
            UI.TableNextColumn() UI.Text("bl")
            UI.TableNextColumn() UI.Text("Switch to the Battle Log tab.")

            UI.TableNextColumn() UI.Text("report")
            UI.TableNextColumn() UI.Text("rep")
            UI.TableNextColumn() UI.Text("Switch to the Report tab.")

            UI.EndTable()
        end
    end

    if UI.CollapsingHeader("Commands: Parse") then
        if UI.BeginTable("Parse Commands", 3, Window.Table.Flags.Borders) then
            UI.TableSetupColumn("Full", Column.Flags.None, Config.Full_Width)
            UI.TableSetupColumn("Short", Column.Flags.None, Config.Short_Width)
            UI.TableSetupColumn("Description", Column.Flags.None)
            UI.TableHeadersRow()

            UI.TableNextRow()
            UI.TableNextColumn() UI.Text("full")
            UI.TableNextColumn() UI.Text("f")
            UI.TableNextColumn() UI.Text("Shows Parse in full mode.")

            UI.TableNextColumn() UI.Text("mini")
            UI.TableNextColumn() UI.Text("m")
            UI.TableNextColumn() UI.Text("Shows Parse in mini mode.")

            UI.TableNextColumn() UI.Text("nano")
            UI.TableNextColumn() UI.Text("n")
            UI.TableNextColumn() UI.Text("Shows Parse in nano mode.")

            UI.TableNextColumn() UI.Text("pet")
            UI.TableNextColumn() UI.Text("p")
            UI.TableNextColumn() UI.Text("Toggles pet columns in Parse (if not in Focus tab).")

            UI.TableNextColumn() UI.Text("dps")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Toggles the DPS column.")

            UI.TableNextColumn() UI.Text("speed")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Toggles the attack speed column.")

            UI.TableNextColumn() UI.Text("clock")
            UI.TableNextColumn() UI.Text("c")
            UI.TableNextColumn() UI.Text("Toggles the duration timer visibility.")

            UI.EndTable()
        end
    end

    if UI.CollapsingHeader("Commands: Focus") then
        if UI.BeginTable("Focus Commands", 3, Window.Table.Flags.Borders) then
            UI.TableSetupColumn("Full", Column.Flags.None, Config.Full_Width)
            UI.TableSetupColumn("Short", Column.Flags.None, Config.Short_Width)
            UI.TableSetupColumn("Description", Column.Flags.None)
            UI.TableHeadersRow()

            UI.TableNextRow()
            UI.TableNextColumn() UI.Text("player {name}")
            UI.TableNextColumn() UI.Text("pl {name}")
            UI.TableNextColumn() UI.Text("Focus on a player in the Focus tab. Partial matching works.")

            UI.TableNextColumn() UI.Text("melee")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Switch to Melee tab in Focus tab.")

            UI.TableNextColumn() UI.Text("ranged")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Switch to Ranged tab in Focus tab.")

            UI.TableNextColumn() UI.Text("weaponskill")
            UI.TableNextColumn() UI.Text("ws")
            UI.TableNextColumn() UI.Text("Switch to Weaponskill tab in Focus tab.")

            UI.TableNextColumn() UI.Text("magic")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Switch to Magic tab in Focus tab.")

            UI.TableNextColumn() UI.Text("ability")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Switch to Ability tab in Focus tab.")

            UI.TableNextColumn() UI.Text("pet")
            UI.TableNextColumn() UI.Text("p")
            UI.TableNextColumn() UI.Text("Switch to Pet tab in Focus tab.")

            UI.TableNextColumn() UI.Text("defense")
            UI.TableNextColumn() UI.Text("def")
            UI.TableNextColumn() UI.Text("Switch to Defense tab in Focus tab.")

            UI.EndTable()
        end
    end

    if UI.CollapsingHeader("Commands: XP") then
        if UI.BeginTable("XP Commands", 3, Window.Table.Flags.Borders) then
            UI.TableSetupColumn("Full", Column.Flags.None, Config.Full_Width)
            UI.TableSetupColumn("Short", Column.Flags.None, Config.Short_Width)
            UI.TableSetupColumn("Description", Column.Flags.None)
            UI.TableHeadersRow()

            UI.TableNextRow()
            UI.TableNextColumn() UI.Text("xp")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Toggles the XP window.")

            UI.EndTable()
        end
    end

    if UI.CollapsingHeader("Commands: Report") then
        if UI.BeginTable("Report Commands", 3, Window.Table.Flags.Borders) then
            UI.TableSetupColumn("Full", Column.Flags.None, Config.Full_Width)
            UI.TableSetupColumn("Short", Column.Flags.None, Config.Short_Width)
            UI.TableSetupColumn("Description", Column.Flags.None)
            UI.TableHeadersRow()

            UI.TableNextRow()
            UI.TableNextColumn() UI.Text("rep total")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Publishes total damage report in chat.")

            UI.TableNextColumn() UI.Text("rep acc")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Publishes accuracy report in chat.")

            UI.TableNextColumn() UI.Text("rep melee")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Publishes melee report in chat.")

            UI.TableNextColumn() UI.Text("rep ws")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Publishes weaponskill report in chat.")

            UI.TableNextColumn() UI.Text("rep healing")
            UI.TableNextColumn() UI.Text("")
            UI.TableNextColumn() UI.Text("Publishes healing report in chat.")

            UI.EndTable()
        end
    end
end

------------------------------------------------------------------------------------------------------
-- Shows settings that affect the Focus screen.
------------------------------------------------------------------------------------------------------
Config.Section.Focus = function()
    local col_flags = Column.Flags.None
    UI.Text("Set max healing thresholds for overcure.")
    UI.BulletText("Otherwise Divine Seal will mess up the calculations.")
    UI.BulletText("Set each value to be about your max healing for each spell.")
    UI.BulletText("Values can also be a little more--just below Divine Seal values.")
    UI.BulletText("Curagas should be amount healed per person--not in total.")

    if UI.BeginTable("Battle Log", 2) then
        UI.TableSetupColumn("Col 1", col_flags)
        UI.TableSetupColumn("Col 2", col_flags)

        UI.TableNextColumn() Config.Widget.Healing("Cure")
        UI.TableNextColumn() Config.Widget.Healing("Curaga")
        UI.TableNextColumn() Config.Widget.Healing("Cure II")
        UI.TableNextColumn() Config.Widget.Healing("Curaga II")
        UI.TableNextColumn() Config.Widget.Healing("Cure III")
        UI.TableNextColumn() Config.Widget.Healing("Curaga III")
        UI.TableNextColumn() Config.Widget.Healing("Cure IV")
        UI.TableNextColumn() Config.Widget.Healing("Curaga IV")
        UI.TableNextColumn() Config.Widget.Healing("Cure V")
        UI.EndTable()
    end
end

------------------------------------------------------------------------------------------------------
-- Set the healing threshold defaults to prevent overcure with Divine Seal.
------------------------------------------------------------------------------------------------------
Config.Widget.Healing = function(spell)
    local healing_threshold = {[1] = DB.Healing_Max[spell]}
    if UI.DragInt(spell, healing_threshold, 1, 0, 3000, "%d", ImGuiSliderFlags_None) then
        DB.Healing_Max[spell] = healing_threshold[1]
    end
end