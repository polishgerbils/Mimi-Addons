addon.name      = 'bigmode';
addon.author    = 'JayTDawgzone';
addon.version   = '1.1';
addon.desc      = 'Allows changing the players model size with commands.';


require('common');
local chat = require('chat');


----------------------------------------------------------------------------------------------------
-- Configurations
----------------------------------------------------------------------------------------------------

local bigmode = T{
    enabled = false,
    defaultModelSize = GetPlayerEntity().ModelSize,
    newModelSize = GetPlayerEntity().ModelSize,
};


----------------------------------------------------------------------------------------------------
-- Print Help

-- Credit: atom0s | Addons - Copyright (c) 2021 Ashita Development Team | Contact: https://www.ashitaxi.com/ https://discord.gg/Ashita
----------------------------------------------------------------------------------------------------


local function print_help(isError)


    if (isError) then
        print(chat.header(addon.name):append(chat.error('Invalid command syntax for command: ')):append(chat.success('/' .. addon.name)));
    else
        print(chat.header(addon.name):append(chat.message('Available commands:')));
    end

    local cmds = T{
        { '/bigmode', 'Toggles bigmode on and off.' },
        { '/bigmode help', 'Displays the addons help information.' },
        { '/bigmode size <value>', 'Sets the model size to apply to the player.' },
        { '/bigmode target <value>', 'Sets the model size to apply to the player\'s target'},
        {'<value> examples', '2 (bigger) .1 (smaller) -1 (default)'}
    };

    -- Print the command list..
    cmds:ieach(function (v)
        print(chat.header(addon.name):append(chat.error('Usage: ')):append(chat.message(v[1]):append(' | ')):append(chat.color1(6, v[2])));
    end);

end

----------------------------------------------------------------------------------------------------
-- Load Addon
----------------------------------------------------------------------------------------------------

ashita.events.register('load', 'load_cb', function()

    print(chat.header(addon.name):append(chat.success('Go big mode.')));
    print_help(false);

end)

----------------------------------------------------------------------------------------------------
-- Commands
----------------------------------------------------------------------------------------------------

ashita.events.register('command', 'command_cb', function(e)

    -- -- Parse the command arguments..
    local command_args = e.command:lower():args()


    if table.contains({'/bigmode'}, command_args[1]) then
        if (#command_args == 1) then

            if bigmode.enabled then


                bigmode.enabled = false;
                bigmode.newModelSize = bigmode.defaultModelSize;

                local player = GetPlayerEntity();

                player.ModelSize = bigmode.newModelSize;
                player.ModelUpdateFlags = 0x10;

                print(chat.header(addon.name):append(chat.message('Big Mode is now: ')):append(chat.error('Disabled')));
                print(chat.header(addon.name):append(chat.message('Model Size: ')):append(chat.success(bigmode.newModelSize)));

            else

                bigmode.enabled = true
                
                print(chat.header(addon.name):append(chat.message('Big Mode is now: ')):append(chat.success('Enabled')));
            end

        elseif table.contains({'size','s'}, command_args[2]) then

            if (tonumber(command_args[3])) and bigmode.enabled then

                bigmode.newModelSize = tonumber(command_args[3]);
                local player = GetPlayerEntity();

                if (player ~= nil) then

                    player.ModelSize = bigmode.newModelSize;
                    player.ModelUpdateFlags = 0x10;

                    print(chat.header(addon.name):append(chat.message('New Model Size: ')):append(chat.success(bigmode.newModelSize)));

                end
            elseif not bigmode.enabled then
                print(chat.header(addon.name):append(chat.error('Big Mode is not enabled. Use /bigmode to enable/disable.')));

            end

        elseif table.contains({'target', 't'}, command_args[2]) then

            if (tonumber(command_args[3])) and bigmode.enabled then

                local targetModelSize = tonumber(command_args[3]);
                local player = GetPlayerEntity();

                if (player == nil) then
                    return;
                end

                local target = GetEntity(AshitaCore:GetMemoryManager():GetTarget():GetTargetIndex(0));
                if (target == nil) then
                    return;
                end

                target.ModelSize = targetModelSize;
                target.ModelUpdateFlags = 0x10;

            
            end

        elseif table.contains({'help'}, command_args[2]) then
            print_help(false);

        else
            print_help(true);
        end
    end
end)

----------------------------------------------------------------------------------------------------
-- Unload Addon
----------------------------------------------------------------------------------------------------


ashita.events.register('unload', 'unload_cb', function ()

    bigmode.enabled = false;
    bigmode.newModelSize = bigmode.defaultModelSize;

    local player = GetPlayerEntity();

    player.ModelSize = bigmode.newModelSize;
    player.ModelUpdateFlags = 0x10;

end)