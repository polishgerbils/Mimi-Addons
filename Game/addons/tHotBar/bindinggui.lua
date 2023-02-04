local d3d8 = require('d3d8');
local d3d8_device = d3d8.get_device();
local header = { 1.0, 0.75, 0.55, 1.0 };
local state = { IsOpen={ false } };
local wsmap = require('resources.wsmap');
local Setup = {};
local Update = {};

local function CheckBox(display, field)
    local displayName = display;
    local fieldName = display;
    if (field ~= nil) then
        fieldName = field;
    end
    if (imgui.Checkbox(string.format('%s##Binding_%s', displayName, displayName), { state.Components[fieldName] })) then
        state.Components[fieldName] = not state.Components[fieldName];
    end
end

local function ComboBox(displayName, varName)
    if (state.Combos[varName] == nil) then
        state.Combos[varName] = T{};
    end
    if (state.Indices[varName] == nil) then
        state.Indices[varName] = 1;
    end

    imgui.TextColored(header, displayName);
    local text = state.Combos[varName][state.Indices[varName]];
    if (text == nil) then text = 'N/A'; end
    if (imgui.BeginCombo(string.format('##%s', displayName), text, ImGuiComboFlags_None)) then
        for index,entry in ipairs(state.Combos[varName]) do
            local isSelected = (index == state.Indices[varName]);
            if (imgui.Selectable(entry, isSelected)) then
                if (not isSelected) then
                    state.Indices[varName] = index;
                    local updateFunction = Update[varName];
                    if updateFunction then
                        updateFunction(state.Combos[varName][index]);
                    end
                end
            end
        end
        imgui.EndCombo();
    end
end

local function DrawMacroImage()
    local posY = imgui.GetCursorPosY();
    local layout = gInterface:GetLayout();
    local width = 32;
    local height = 32;
    if layout then
        width = layout.ImageObjects.Icon.Width;
        height = layout.ImageObjects.Icon.Height;
    end
    if (state.Texture ~= nil) then
        local posX = (253 - width) / 2;
        imgui.SetCursorPos({ posX, posY });
        imgui.Image(tonumber(ffi.cast("uint32_t", state.Texture)),
        { width, height },
        { 0, 0 }, { 1, 1 }, { 1, 1, 1, 1 }, { 0, 0, 0, 0 });
    end
    imgui.SetCursorPos({imgui.GetCursorPosX(), posY + height});
end

local function UpdateMacroImage()
    state.Texture = nil;
    if (state.MacroImage == nil) then
        return;
    end

    if (string.sub(state.MacroImage[1], 1, 5) == 'ITEM:') then
        local item = AshitaCore:GetResourceManager():GetItemById(tonumber(string.sub(state.MacroImage[1], 6)));
        if (item ~= nil) then    
            local dx_texture_ptr = ffi.new('IDirect3DTexture8*[1]');
            if (ffi.C.D3DXCreateTextureFromFileInMemoryEx(d3d8_device, item.Bitmap, item.ImageSize, 0xFFFFFFFF, 0xFFFFFFFF, 1, 0, ffi.C.D3DFMT_A8R8G8B8, ffi.C.D3DPOOL_MANAGED, ffi.C.D3DX_DEFAULT, ffi.C.D3DX_DEFAULT, 0xFF000000, nil, nil, dx_texture_ptr) == ffi.C.S_OK) then
                state.Texture = d3d8.gc_safe_release(ffi.cast('IDirect3DTexture8*', dx_texture_ptr[0]));
            end
        end
        return;
    end

    local path = GetImagePath(state.MacroImage[1]);
    if (path ~= nil) then
        local dx_texture_ptr = ffi.new('IDirect3DTexture8*[1]');
        if (ffi.C.D3DXCreateTextureFromFileA(d3d8_device, path, dx_texture_ptr) == ffi.C.S_OK) then
            state.Texture = d3d8.gc_safe_release(ffi.cast('IDirect3DTexture8*', dx_texture_ptr[0]));
        end
    end
end

Setup.Ability = function(skipUpdate)
    state.ActionResources = T{};
    local resMgr = AshitaCore:GetResourceManager();
    local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
    for i = 0x200,0x600 do
        local res = resMgr:GetAbilityById(i);
        if (res) and (playMgr:HasAbility(res.Id)) then
            state.ActionResources:append(res);
        end
    end

    table.sort(state.ActionResources, function(a,b)
        return a.Name[1] < b.Name[1];
    end);

    state.Combos.Action = T{};
    for _,res in ipairs(state.ActionResources) do
        state.Combos.Action:append(res.Name[1]);
    end

    state.Indices.Action = 1;
    if not skipUpdate then
        Update.Action(state.Combos.Action[1]);
    end
end

Setup.Command = function(skipUpdate)
    state.Combos.Action = T{};
    state.Indices.Action = 0;
    if not skipUpdate then
        Update.Command();
    end
end

Setup.Empty = function()
    state.Combos.Action = T{};
    state.Indices.Action = 0;
    Update.Empty();
end

Setup.Item = function(skipUpdate)
    state.ActionResources = T{};
    
    local resMgr = AshitaCore:GetResourceManager();
    local bags = T{0, 3};
    for _,bag in ipairs(bags) do
        for i = 1,80 do
            local item = gInventory:GetItemTable(bag, i);
            if (item ~= nil) then
                local res = resMgr:GetItemById(item.Id);
                if (res ~= nil) and (bit.band(res.Flags, 0x200) == 0x200) then
                    if (not state.ActionResources:contains(res)) then
                        state.ActionResources:append(res);
                    end
                end
            end
        end
    end

    bags = T{ 0, 8, 10, 11, 12, 13, 14, 15, 16 };
    for _,bag in ipairs(bags) do
        for i = 1,80 do
            local item = gInventory:GetItemTable(bag, i);
            if (item ~= nil) then
                local res = resMgr:GetItemById(item.Id);
                if (res ~= nil) and (bit.band(res.Flags, 0x400) == 0x400) then
                    if (not state.ActionResources:contains(res)) then
                        state.ActionResources:append(res);
                    end
                end
            end
        end
    end

    table.sort(state.ActionResources, function(a,b)
        return a.Name[1] < b.Name[1];
    end);

    state.Combos.Action = T{};
    for index,res in ipairs(state.ActionResources) do
        local prev = state.ActionResources[index - 1];
        local next = state.ActionResources[index + 1];

        --Show item id if multiple matching items..
        if (prev) and (prev.Name[1] == res.Name[1]) then
            state.Combos.Action:append(string.format('%s[%u]', res.Name[1], res.Id));            
        elseif (next) and (next.Name[1] == res.Name[1]) then
            state.Combos.Action:append(string.format('%s[%u]', res.Name[1], res.Id));
        else
            state.Combos.Action:append(res.Name[1]);
        end
    end

    if not skipUpdate then
        state.Indices.Action = 1;
        Update.Action(state.Combos.Action[1]);
    end
end

Setup.Spell = function(skipUpdate)
    state.ActionResources = T{};
    local resMgr = AshitaCore:GetResourceManager();
    local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
    local mainJob = playMgr:GetMainJob();
    local mainJobLevel = playMgr:GetMainJobLevel();
    local subJob = playMgr:GetSubJob();
    local subJobLevel = playMgr:GetSubJobLevel();

    for i = 1,0x400 do
        local res = resMgr:GetSpellById(i);
        if (res) and (playMgr:HasSpell(res.Index)) then
            local levelRequired = res.LevelRequired;
            --Maybe not best workaround, but trust are all usable at WAR1.
            if (levelRequired[2] ~= 1) then
                local hasSpell = false;
                local jpMask = res.JobPointMask;
                if (bit.band(bit.rshift(jpMask, mainJob), 1) == 1) then
                    if (mainJobLevel == 99) and (gPlayer:GetJobPointTotal(mainJob) >= levelRequired[mainJob + 1]) then
                        hasSpell = true;
                    end
                elseif (levelRequired[mainJob + 1] ~= -1) and (mainJobLevel >= levelRequired[mainJob + 1]) then
                    hasSpell = true;
                end

                if (bit.band(bit.rshift(jpMask, subJob), 1) == 0) then
                    if (levelRequired[subJob + 1] ~= -1) and (subJobLevel >= levelRequired[subJob + 1]) then
                        hasSpell = true;
                    end
                end

                if (hasSpell) then
                    state.ActionResources:append(res);
                end
            end
        end
    end

    table.sort(state.ActionResources, function(a,b)
        return a.Name[1] < b.Name[1];
    end);

    state.Combos.Action = T{};
    for _,res in ipairs(state.ActionResources) do
        state.Combos.Action:append(res.Name[1]);
    end

    if (not skipUpdate) then
        state.Indices.Action = 1;
        Update.Action(state.Combos.Action[1]);
    end
end

Setup.Trust = function(skipUpdate)
    state.ActionResources = T{};
    local resMgr = AshitaCore:GetResourceManager();
    local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
    local mainJob = playMgr:GetMainJob();
    local mainJobLevel = playMgr:GetMainJobLevel();
    local subJob = playMgr:GetSubJob();
    local subJobLevel = playMgr:GetSubJobLevel();

    for i = 1,0x400 do
        local res = resMgr:GetSpellById(i);
        if (res) and (playMgr:HasSpell(res.Index)) then
            local levelRequired = res.LevelRequired;

            --Maybe not best workaround, but trust are all usable at WAR1.
            if (levelRequired[2] == 1) then
                local hasSpell = false;
                local jpMask = res.JobPointMask;
                if (bit.band(bit.rshift(jpMask, mainJob), 1) == 1) then
                    if (mainJobLevel == 99) and (gPlayer:GetJobPointTotal(mainJob) >= levelRequired[mainJob + 1]) then
                        hasSpell = true;
                    end
                elseif (levelRequired[mainJob + 1] ~= -1) and (mainJobLevel >= levelRequired[mainJob + 1]) then
                    hasSpell = true;
                end

                if (bit.band(bit.rshift(jpMask, subJob), 1) == 0) then
                    if (levelRequired[subJob + 1] ~= -1) and (subJobLevel >= levelRequired[subJob + 1]) then
                        hasSpell = true;
                    end
                end

                if (hasSpell) then
                    state.ActionResources:append(res);
                end
            end
        end
    end

    table.sort(state.ActionResources, function(a,b)
        return a.Name[1] < b.Name[1];
    end);

    state.Combos.Action = T{};
    for _,res in ipairs(state.ActionResources) do
        state.Combos.Action:append(res.Name[1]);
    end

    if (not skipUpdate) then
        state.Indices.Action = 1;
        Update.Action(state.Combos.Action[1]);
    end
end

Setup.Weaponskill = function(skipUpdate)
    state.ActionResources = T{};
    local resMgr = AshitaCore:GetResourceManager();
    local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
    for i = 1,0x200 do
        local res = resMgr:GetAbilityById(i);
        if (res) and (playMgr:HasAbility(res.Id)) then
            state.ActionResources:append(res);
        end
    end

    table.sort(state.ActionResources, function(a,b)
        return a.Name[1] < b.Name[1];
    end);

    state.Combos.Action = T{};
    for _,res in ipairs(state.ActionResources) do
        state.Combos.Action:append(res.Name[1]);
    end

    if (not skipUpdate) then
        state.Indices.Action = 1;
        Update.Action(state.Combos.Action[1]);
    end
end

Update.Type = function(newValue)
    Setup[newValue]();
end

Update.Action = function(newValue)
    local type = state.Combos.Type[state.Indices.Type];
    if (state.Indices.Action > #state.ActionResources) then
        Update.Empty();
    else
        Update[type](state.Indices.Action);
    end
end

Update.Ability = function(index)
    local res = state.ActionResources[index];
    if (res.Targets == 1) then
        state.MacroText = { string.format('/ja \"%s\" <me>', res.Name[1]) };
    else
        state.MacroText = { string.format('/ja \"%s\" <t>', res.Name[1]) };
    end
    state.MacroLabel = { res.Name[1] };
    if ((res.RecastTimerId == 0) or (res.RecastTimerId == 254)) then
        state.MacroImage = { 'abilities/1hr.png' };
    else
        state.MacroImage = { string.format('abilities/%u.png', res.Id - 0x200) };
    end
    state.CostOverride = { '' };
    UpdateMacroImage();
end

Update.Command = function(index)
    state.MacroText = { '/attack <t>' };
    state.MacroLabel = { 'Attack' };
    state.MacroImage = { 'misc/command.png' };
    state.CostOverride = { '' };
    UpdateMacroImage();
end

Update.Empty = function(index)
    state.MacroText = nil;
    state.MacroLabel = nil;
    state.MacroImage = { 'misc/empty.png' };
    state.CostOverride = nil;
    UpdateMacroImage();
end

Update.Item = function(index)
    local res = state.ActionResources[index];
    if (res.Targets == 1) then
        state.MacroText = { string.format('/item \"%s\" <me>', res.Name[1]) };
    else
        state.MacroText = { string.format('/item \"%s\" <t>', res.Name[1]) };
    end
    state.MacroLabel = { res.Name[1] };
    state.MacroImage = { string.format('ITEM:%u', res.Id) };
    state.CostOverride = nil;
    UpdateMacroImage();
end

Update.Spell = function(index)
    local res = state.ActionResources[index];
    if (res.Targets == 1) then
        state.MacroText = { string.format('/ma \"%s\" <me>', res.Name[1]) };
    else
        state.MacroText = { string.format('/ma \"%s\" <t>', res.Name[1]) };
    end
    state.MacroLabel = { res.Name[1] };
    state.MacroImage = { string.format('spells/%u.png', res.Index) };
    state.CostOverride = { '' };
    UpdateMacroImage();
end

Update.Trust = function(index)
    local res = state.ActionResources[index];
    if (res.Targets == 1) then
        state.MacroText = { string.format('/ma \"%s\" <me>', res.Name[1]) };
    else
        state.MacroText = { string.format('/ma \"%s\" <t>', res.Name[1]) };
    end
    state.MacroLabel = { res.Name[1] };
    state.MacroImage = { string.format('spells/%u.png', res.Index) };
    state.CostOverride = { '' };
    UpdateMacroImage();
end

Update.Weaponskill = function(index)
    local res = state.ActionResources[index];
    if (res.Targets == 1) then
        state.MacroText = { string.format('/ws \"%s\" <me>', res.Name[1]) };
    else
        state.MacroText = { string.format('/ws \"%s\" <t>', res.Name[1]) };
    end
    state.MacroLabel = { res.Name[1] };
    state.MacroImage = { wsmap[res.Id] or '' };
    state.CostOverride = { '' };
    UpdateMacroImage();
end

local function GetBindResource()
    local type = state.Combos.Type[state.Indices.Type];
    if T{'Ability', 'Item', 'Spell', 'Trust', 'Weaponskill'}:contains(type) then
        local res = state.ActionResources[state.Indices.Action];
        return res;
    else
        return true;
    end
end

local exposed = {};

function exposed:Render()
    if (state.IsOpen[1]) then
        if (imgui.Begin(string.format('%s v%s Binding', addon.name, addon.version), state.IsOpen, ImGuiWindowFlags_AlwaysAutoResize)) then
            imgui.BeginGroup();
            if imgui.BeginTabBar('##TabBar', ImGuiTabBarFlags_NoCloseWithMiddleMouseButton) then
                if imgui.BeginTabItem('Binding##BindingTab', nil) then
                    imgui.BeginChild('BindingChild', { 253, 355 }, true);
                    imgui.TextColored(header, 'Hotkey');
                    imgui.Text(state.Hotkey);
                    ComboBox('Scope', 'Scope');
                    imgui.ShowHelp('Determines how wide the binding will apply.  Job binds are used to fill empty slots in palette binds, then global binds are used to fill any remaining empty slots.');
                    ComboBox('Action Type', 'Type');
                    if (#state.Combos.Action > 0) then
                        ComboBox('Action', 'Action');
                    else
                        imgui.TextColored(header, 'Action');
                        imgui.Text('N/A');
                    end
                    imgui.TextColored(header, 'Macro');
                    if (state.MacroText ~= nil) then
                        imgui.InputTextMultiline('##MacroText', state.MacroText, 4096, { 237, 116  });
                    else
                        imgui.Text('N/A');
                    end
                    imgui.TextColored(header, 'Label');
                    if (state.MacroLabel ~= nil) then
                        imgui.InputText('##MacroLabel', state.MacroLabel, 32);
                    else
                        imgui.Text('N/A');
                    end
                    imgui.EndChild();
                    imgui.EndTabItem();
                end
                if imgui.BeginTabItem('Appearance##AppearanceTab', nil) then
                    local layout = gInterface:GetLayout();
                    local width = 32;
                    local height = 32;
                    if layout then
                        width = layout.ImageObjects.Icon.Width;
                        height = layout.ImageObjects.Icon.Height;
                    end
                    imgui.BeginChild('AppearanceChild', { 253, 210 + height }, true);
                    imgui.TextColored(header, 'Image');
                    imgui.ShowHelp('While the image file and size are correct, rendering here is done with ImGui instead of GdiPlus and may vary slightly in appearance.');
                    local posY = imgui.GetCursorPosY();
                    if (state.Texture ~= nil) then
                        imgui.Image(tonumber(ffi.cast("uint32_t", state.Texture)),
                        { width, height },
                        { 0, 0 }, { 1, 1 }, { 1, 1, 1, 1 }, { 0, 0, 0, 0 });
                    end
                    imgui.SetCursorPos({imgui.GetCursorPosX(), posY + height});
                    if (state.Combos.Type[state.Indices.Type] ~= 'Empty') then
                        imgui.InputText('##MacroImage', state.MacroImage, 256);
                        imgui.SameLine();
                        if (imgui.Button('Update', { 60, 0 })) then
                            UpdateMacroImage();
                        end
                    end
                    imgui.TextColored(header, 'Components');
                    if (state.Combos.Type[state.Indices.Type] ~= 'Empty') then
                        imgui.BeginGroup();
                        CheckBox('Cost');
                        imgui.ShowHelp('Display action cost indicators.');
                        CheckBox('Cross');
                        imgui.ShowHelp('Displays a X over actions you don\'t currently know.');
                        CheckBox('Fade');
                        imgui.ShowHelp('Fades the icon for actions where cooldown is not 0 or cost is not met.');
                        CheckBox('Recast');
                        imgui.ShowHelp('Shows action recast timers.');
                        imgui.EndGroup();
                        imgui.SameLine();
                        imgui.BeginGroup();
                        CheckBox('Name');
                        imgui.ShowHelp('Shows action names.');
                        CheckBox('Trigger');
                        imgui.ShowHelp('Shows an overlay when you activate an action.');
                        CheckBox('SC Icon', 'SkillchainIcon');
                        imgui.ShowHelp('Overrides weaponskill icons when a skillchain would be formed.');
                        CheckBox('SC Animation', 'SkillchainAnimation');
                        imgui.ShowHelp('Animates a border around weaponskill icons when a skillchain would be formed.');
                        imgui.EndGroup();
                    else
                        imgui.Text('N/A');
                    end
                    imgui.TextColored(header, 'Cost Override');
                    imgui.ShowHelp('Entering an item ID, or multiple item IDs seperated by commas, will make cost display as the total amount of those items in your inventory and wardrobes(if equippable) or temporary items(if not).  This can be useful for actions like Call Beast or Reward that use an item, but not always the same item.  Actions like angon and ninjutsu with fixed items are automatically handled without specifying this.');
                    if (state.CostOverride ~= nil) then
                        imgui.InputText('##MacroCostOverride', state.CostOverride, 256);
                    else
                        imgui.Text('N/A');
                    end
                    imgui.EndChild();
                    imgui.EndTabItem();
                end
                imgui.EndTabBar();
            end
            imgui.EndGroup();

            if imgui.Button('Cancel', { 60, 0 }) then
                state.IsOpen[1] = false;
            end
            local bindResource = GetBindResource();
            if (bindResource ~= nil) then
                imgui.SameLine();
                imgui.SetCursorPos( { 202, imgui.GetCursorPosY() });
                if imgui.Button('Bind', { 60, 0 }) then
                    if (state.Combos.Type[state.Indices.Type] == 'Empty') then
                        if (state.Indices.Scope == 1) then
                            gBindings:BindGlobal(state.Hotkey, nil);
                        elseif (state.Indices.Scope == 2) then
                            gBindings:BindJob(state.Hotkey, nil);
                        elseif (state.Indices.Scope == 3) then
                            gBindings:BindPalette(state.Hotkey, nil);
                        else
                            return;
                        end
                        state = { IsOpen={ false } };
                        return;
                    end

                    local binding = {};
                    binding.ActionType = state.Combos.Type[state.Indices.Type];
                    if T{'Ability', 'Item', 'Spell', 'Trust', 'Weaponskill'}:contains(binding.ActionType) then
                        if (binding.ActionType == 'Spell') or (binding.ActionType == 'Trust') then
                            binding.Id = bindResource.Index;
                        else
                            binding.Id = bindResource.Id;
                        end
                    end
                    if ((state.CostOverride ~= nil) and (state.CostOverride[1] ~= '')) then
                        local ids = T{};
                        local compString = string.gsub(state.CostOverride[1], ' ', '');
                        if (string.find(compString, ',')) then
                            for entry in string.gmatch(compString, '([^,]+)') do
                                local id = tonumber(entry);
                                if type(id) == 'number' then
                                    local res = AshitaCore:GetResourceManager():GetItemById(id);
                                    if (res ~= nil) and (string.len(res.Name[1]) > 0) then
                                        ids:append(id);
                                    end
                                end
                            end
                        else
                            local id = tonumber(compString);
                            if type(id) == 'number' then
                                local res = AshitaCore:GetResourceManager():GetItemById(id);
                                if (res ~= nil) and (string.len(res.Name[1]) > 0) then
                                    ids:append(id);
                                end
                            end
                        end
                        if (#ids > 0) then
                            binding.CostOverride = ids;
                        end
                    end
                    if (state.MacroLabel == nil) then
                        binding.Label = '';
                    else
                        binding.Label = state.MacroLabel[1];
                    end
                    if (state.MacroText == nil) then
                        binding.Macro = T{};
                    else
                        binding.Macro = T{};
                        for line in string.gmatch(state.MacroText[1], "[^\r\n]+") do
                            binding.Macro:append(line);
                        end
                    end
                    binding.Image = state.MacroImage[1];
                    binding.ShowCost = state.Components.Cost;
                    binding.ShowCross = state.Components.Cross;
                    binding.ShowFade = state.Components.Fade;
                    binding.ShowRecast = state.Components.Recast;
                    binding.ShowName = state.Components.Name;
                    binding.ShowTrigger = state.Components.Trigger;
                    binding.ShowSkillchainIcon = state.Components.SkillchainIcon;
                    binding.ShowSkillchainAnimation = state.Components.SkillchainAnimation;
                    if (state.Indices.Scope == 1) then
                        gBindings:BindGlobal(state.Hotkey, binding);
                    elseif (state.Indices.Scope == 2) then
                        gBindings:BindJob(state.Hotkey, binding);
                    elseif (state.Indices.Scope == 3) then
                        gBindings:BindPalette(state.Hotkey, binding);
                    else
                        return;
                    end
                    state = { IsOpen={ false } };
                end
            end
            imgui.End();
        end
    end
end

function exposed:Show(hotkey, binding)
    if (binding == nil) then
        state = {
            IsOpen = { true },
            Hotkey = hotkey;
            ActionResources = T{},
            Combos = {
                ['Scope'] = T{ 'Global', 'Job', 'Palette' },
                ['Type'] = T{ 'Ability', 'Command', 'Empty', 'Item', 'Spell', 'Trust', 'Weaponskill' },
                ['Action'] = T{ },
            },
            Components = {
                Cost = true,
                Cross = true,
                Fade = true,
                Recast = true,
                Name = true,
                Trigger = true,
                SkillchainIcon = true,
                SkillchainAnimation = true,
            },
            Indices = {
                ['Scope'] = 3,
                ['Type'] = 1,
            },
            CostOverride = { '' },
            MacroText = { '' },
            MacroLabel = { '' },
        };
        Setup.Ability();
        return;
    end

    state = {
        IsOpen = { true },
        Hotkey = hotkey,
        ActionResources = T{},
        Combos = {
            ['Scope'] = T{ 'Global', 'Job', 'Palette' },
            ['Type'] = T{ 'Ability', 'Command', 'Empty', 'Item', 'Spell', 'Trust', 'Weaponskill' },
            ['Action'] = T{ },
        },
        Components = {
            Cost = binding.ShowCost,
            Cross = binding.ShowCross,
            Fade = binding.ShowFade,
            Recast = binding.ShowRecast,
            Name = binding.ShowName,
            Trigger = binding.ShowTrigger,
            SkillchainIcon = binding.ShowSkillchainIcon,
            SkillchainAnimation = binding.ShowSkillchainAnimation
        },
        Indices = {
            ['Scope'] = binding.Scope
        },
        CostOverride = { '' },
        MacroText = { '' },
        MacroLabel = { binding.Label },
        MacroImage = { binding.Image }
    };
    UpdateMacroImage();
    
    for index,entry in ipairs(state.Combos.Type) do
        if (entry == binding.ActionType) then
            state.Indices.Type = index;
            Setup[entry](true);
        end
    end

    if (binding.ActionType == 'Ability') or (binding.ActionType == 'Weaponskill') then
        local res = AshitaCore:GetResourceManager():GetAbilityById(binding.Id);

        if not state.ActionResources:contains(res) then
            state.ActionResources:append(res);
            
            table.sort(state.ActionResources, function(a,b)
                return a.Name[1] < b.Name[1];
            end);

            state.Combos.Action = T{};
            for _,res in ipairs(state.ActionResources) do
                state.Combos.Action:append(res.Name[1]);
            end
        end
        
        for index,match in ipairs(state.ActionResources) do
            if (match == res) then
                state.Indices.Action = index;
                break;
            end
        end
    elseif (binding.ActionType == 'Spell') or (binding.ActionType == 'Trust') then
        local res = AshitaCore:GetResourceManager():GetSpellById(binding.Id);

        if not state.ActionResources:contains(res) then
            state.ActionResources:append(res);
            
            table.sort(state.ActionResources, function(a,b)
                return a.Name[1] < b.Name[1];
            end);

            state.Combos.Action = T{};
            for _,res in ipairs(state.ActionResources) do
                state.Combos.Action:append(res.Name[1]);
            end
        end
        
        for index,match in ipairs(state.ActionResources) do
            if (match == res) then
                state.Indices.Action = index;
                break;
            end
        end
    elseif (binding.ActionType == 'Item') then
        local res = AshitaCore:GetResourceManager():GetItemById(binding.Id);

        if not state.ActionResources:contains(res) then
            state.ActionResources:append(res);
            
            table.sort(state.ActionResources, function(a,b)
                return a.Name[1] < b.Name[1];
            end);

            state.Combos.Action = T{};
            for index,res in ipairs(state.ActionResources) do
                local prev = state.ActionResources[index - 1];
                local next = state.ActionResources[index + 1];
        
                --Show item id if multiple matching items..
                if (prev) and (prev.Name[1] == res.Name[1]) then
                    state.Combos.Action:append(string.format('%s[%u]', res.Name[1], res.Id));            
                elseif (next) and (next.Name[1] == res.Name[1]) then
                    state.Combos.Action:append(string.format('%s[%u]', res.Name[1], res.Id));
                else
                    state.Combos.Action:append(res.Name[1]);
                end
            end
        end
        
        for index,match in ipairs(state.ActionResources) do
            if (match == res) then
                state.Indices.Action = index;
                break;
            end
        end
    end

    if (type(binding.CostOverride) == 'table') then
        local output = '';
        for _,item in ipairs(binding.CostOverride) do
            if (output ~= '') then
                output = output .. ',';
            end
            output = output .. tostring(item);
        end
        state.MacroText = { output };
    end

    if (type(binding.Macro) == 'table') then
        local output = '';
        for _,line in ipairs(binding.Macro) do
            if (output ~= '') then
                output = output .. '\n';
            end
            output = output .. line;
        end
        state.MacroText = { output };
    end
end

return exposed;