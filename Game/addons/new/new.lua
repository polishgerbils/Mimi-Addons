addon.author   = 'x';
addon.name     = 'new';
addon.version  = '1.2';
addon.commands = {'new', 'fa'};

require('common');
local settings = require('settings');
local imgui = require('imgui');

-- Variables
local caption = ''
local background_ability = "background_ability"
local background_magic = "background_magic"
local background_interrupt = "background_interrupt"
local background_emphasize = "background_emphasize"

local showing = false
local last_trigger = 0

-- IDs
local weapon_skill_category = 7
local magic_category = 8
local interrupt_id = 28787

-- Default settings
local defaults = {
    x_position = 800,   -- Adjust this value based on your actual screen width
    y_position = 100,
    background_size = "regular",
    emphasize = {},
    trigger_duration = 3,
    sounds = "on"
}

-- Manually checking and initializing settings
settings = settings.load(defaults)
if not settings then
    settings = defaults
end

-- Event Handling
ashita.register_event('load', function()
    print('Addon loaded successfully.')
    create_backgrounds(settings.x_position - 250, settings.y_position)
    caption = ' '
end)

ashita.register_event('render', function()
    if showing then
        local x_offset = settings.x_position
        local y_offset = settings.background_size == "regular" and settings.y_position + 10 or settings.y_position + 3
        -- Display text
        imgui.Text(caption)
        if os.time() - last_trigger > settings.trigger_duration then
            hide_caption()
        end
    end
end)

ashita.register_event('incoming_text', function(mode, message, modifiedmode, modifiedmessage, blocked)
    print('Incoming text event triggered: ' .. message)
    -- If you want to modify or block the message, return appropriate values here
    return false  -- Return false to allow other addons to process this text
end)

ashita.register_event('action', function(action)
    print('Action event triggered: category = ' .. tostring(action.category))
    -- Check if the action matches the criteria for triggering an alert
    if action.category == weapon_skill_category then
        caption = 'Weapon Skill Used'
        showing = true
        last_trigger = os.time()
        print('Weapon skill triggered.')
    elseif action.category == magic_category then
        caption = 'Magic Used'
        showing = true
        last_trigger = os.time()
        print('Magic used triggered.')
    end
end)

-- Function to hide caption
function hide_caption()
    showing = false
    caption = ''
end

-- Function to create backgrounds (adapted from Windower to Ashita)
function create_backgrounds(x, y)
    -- Adjust this function to create the necessary backgrounds in Ashita
    -- You may need to use imgui or other Ashita-specific methods
end

-- Function to emphasize certain events or text
function emphasize_text(emphasize_settings)
    -- Handle emphasis logic here, potentially using imgui for visual effects
end
