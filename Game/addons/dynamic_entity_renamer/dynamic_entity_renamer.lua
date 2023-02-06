local registry = {}
local name_list = {}
local isWindowerv4 = windower ~= nil
local isAshitav4 = ashita ~= nil and ashita.events ~= nil

local is_on_retail = nil -- only used in Ashita v4 
local ffi          = nil --

local struct = {}

if isAshitav4 then
	require('common')
    addon.name = 'dynamic_entity_renamer'
    addon.author = 'zach2good, TeoTwawki, atom0s'
    addon.version = '1.0.0.0'
	
	
    ffi = require("ffi")
    ffi.cdef("void* GetModuleHandleA(const char*)")

    is_on_retail = function()
        return ffi.C.GetModuleHandleA("polhook.dll") ~= nil
    end
elseif isWindowerv4 then
    _addon.name = 'dynamic_entity_renamer'
    _addon.author = 'zach2good, TeoTwawki, atom0s'
    _addon.version = '1.0.0.0'
    _addon.command = 'dynamic_entity_renamer'
	bit = require 'bit'
end

function struct.pack(format, ...)
    local stream = {}
    local vars = {...}
    local endianness = true

    for i = 1, format:len() do
        local opt = format:sub(i, i)

        if opt == '<' then
        endianness = true
        elseif opt == '>' then
        endianness = false
        elseif opt:find('[bBhHiIlL]') then
        local n = opt:find('[hH]') and 2 or opt:find('[iI]') and 4 or opt:find('[lL]') and 8 or 1
        local val = tonumber(table.remove(vars, 1))

        local bytes = {}
        for j = 1, n do
            table.insert(bytes, string.char(val % (2 ^ 8)))
            val = math.floor(val / (2 ^ 8))
        end

        if not endianness then
            table.insert(stream, string.reverse(table.concat(bytes)))
        else
            table.insert(stream, table.concat(bytes))
        end
        elseif opt:find('[fd]') then
        local val = tonumber(table.remove(vars, 1))
        local sign = 0

        if val < 0 then
            sign = 1
            val = -val
        end

        local mantissa, exponent = math.frexp(val)
        if val == 0 then
            mantissa = 0
            exponent = 0
        else
            mantissa = (mantissa * 2 - 1) * math.ldexp(0.5, (opt == 'd') and 53 or 24)
            exponent = exponent + ((opt == 'd') and 1022 or 126)
        end

        local bytes = {}
        if opt == 'd' then
            val = mantissa
            for i = 1, 6 do
            table.insert(bytes, string.char(math.floor(val) % (2 ^ 8)))
            val = math.floor(val / (2 ^ 8))
            end
        else
            table.insert(bytes, string.char(math.floor(mantissa) % (2 ^ 8)))
            val = math.floor(mantissa / (2 ^ 8))
            table.insert(bytes, string.char(math.floor(val) % (2 ^ 8)))
            val = math.floor(val / (2 ^ 8))
        end

        table.insert(bytes, string.char(math.floor(exponent * ((opt == 'd') and 16 or 128) + val) % (2 ^ 8)))
        val = math.floor((exponent * ((opt == 'd') and 16 or 128) + val) / (2 ^ 8))
        table.insert(bytes, string.char(math.floor(sign * 128 + val) % (2 ^ 8)))
        val = math.floor((sign * 128 + val) / (2 ^ 8))

        if not endianness then
            table.insert(stream, string.reverse(table.concat(bytes)))
        else
            table.insert(stream, table.concat(bytes))
        end
        elseif opt == 's' then
        table.insert(stream, tostring(table.remove(vars, 1)))
        table.insert(stream, string.char(0))
        elseif opt == 'c' then
        local n = format:sub(i + 1):match('%d+')
        local str = tostring(table.remove(vars, 1))
        local len = tonumber(n)
        if len <= 0 then
            len = str:len()
        end
        if len - str:len() > 0 then
            str = str .. string.rep(' ', len - str:len())
        end
        table.insert(stream, str:sub(1, len))
        i = i + n:len()
        end
    end

    return table.concat(stream)
end

function struct.unpack(format, stream, pos)
  local vars = {}
  local iterator = pos or 1
  local endianness = true

  for i = 1, format:len() do
    local opt = format:sub(i, i)

    if opt == '<' then
      endianness = true
    elseif opt == '>' then
      endianness = false
    elseif opt:find('[bBhHiIlL]') then
      local n = opt:find('[hH]') and 2 or opt:find('[iI]') and 4 or opt:find('[lL]') and 8 or 1
      local signed = opt:lower() == opt

      local val = 0
      for j = 1, n do
        local byte = string.byte(stream:sub(iterator, iterator))
        if endianness then
          val = val + byte * (2 ^ ((j - 1) * 8))
        else
          val = val + byte * (2 ^ ((n - j) * 8))
        end
        iterator = iterator + 1
      end

      if signed and val >= 2 ^ (n * 8 - 1) then
        val = val - 2 ^ (n * 8)
      end

      table.insert(vars, math.floor(val))
    elseif opt:find('[fd]') then
      local n = (opt == 'd') and 8 or 4
      local x = stream:sub(iterator, iterator + n - 1)
      iterator = iterator + n

      if not endianness then
        x = string.reverse(x)
      end

      local sign = 1
      local mantissa = string.byte(x, (opt == 'd') and 7 or 3) % ((opt == 'd') and 16 or 128)
      for i = n - 2, 1, -1 do
        mantissa = mantissa * (2 ^ 8) + string.byte(x, i)
      end

      if string.byte(x, n) > 127 then
        sign = -1
      end

      local exponent = (string.byte(x, n) % 128) * ((opt == 'd') and 16 or 2) + math.floor(string.byte(x, n - 1) / ((opt == 'd') and 16 or 128))
      if exponent == 0 then
        table.insert(vars, 0.0)
      else
        mantissa = (math.ldexp(mantissa, (opt == 'd') and -52 or -23) + 1) * sign
        table.insert(vars, math.ldexp(mantissa, exponent - ((opt == 'd') and 1023 or 127)))
      end
    elseif opt == 's' then
      local bytes = {}
      for j = iterator, stream:len() do
        if stream:sub(j,j) == string.char(0) or  stream:sub(j) == '' then
          break
        end

        table.insert(bytes, stream:sub(j, j))
      end

      local str = table.concat(bytes)
      iterator = iterator + str:len() + 1
      table.insert(vars, str)
    elseif opt == 'c' then
      local n = format:sub(i + 1):match('%d+')
      local len = tonumber(n)
      if len <= 0 then
        len = table.remove(vars)
      end

      table.insert(vars, stream:sub(iterator, iterator + len - 1))
      iterator = iterator + len
      i = i + n:len()
    end
  end

  return unpack(vars)
end

local function split(str, ch)
    local outTable = {}
    for word in string.gmatch(str, '([^' .. ch .. ']+)') do
        table.insert(outTable, word)
    end
    return outTable
end

local function getZoneId()
    if isWindowerv4 then
        return windower.ffxi.get_info().zone
	elseif isAshitav4 then
        return AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)
    end
end

local function setMobName(id, name, zoneId)
	if name_list[zoneId] then
		local new_name = name_list[zoneId][name.original_name]

		if new_name then
			if isWindowerv4 then
				windower.set_mob_name(id + 0x100, new_name)
				-- 0x100 offset may change if pets + trusts + dynamic entities all share the same space
			elseif isAshitav4 then
				local targid = bit.band(id, 0x0FFF)
				AshitaCore:GetMemoryManager():GetEntity():SetName(targid, new_name)
			end
		end
	end
end

local function askForList()
    local zoneId = getZoneId()

    registry = registry or {}
    registry[zoneId] = registry[zoneId] or {}

    if #registry[zoneId] == 0 then
        if isWindowerv4 then
            windower.packets.inject_outgoing(0x01, struct.pack("c4", { 0x01, 0x04, 0x00, 0x00 }))
        elseif isAshitav4 and is_on_retail() == false then
			AshitaCore:GetPacketManager():AddOutgoingPacket(0x01, { 0x01, 0x04, 0x00, 0x00 })
        end
    end
end

local function handleList(id, data)
    if id == 0x1FF then
        local zoneId = getZoneId()

		if name_list[zoneId] == nil then
			name_list[zoneId] = {}
		end
		
        local outString = data
        local entries = split(outString, '|')

        for _, entry in pairs(entries) do
            local parts = split(entry, ':')

            -- Transform back into original name and renamed name
            local original_name = parts[1]
            local renamed_name = parts[2]

            if original_name and renamed_name then
				local zoneId = getZoneId()
				
				name_list[zoneId][original_name] = renamed_name
            end
        end
    end
end

local function render()
    local zoneId = getZoneId()
    if registry[zoneId] then
        for k, v in pairs(registry[zoneId]) do
            if k and v then
                setMobName(k, v, zoneId)
            end
        end
    end
end

local function register_dynamic_entity(data)
	local name   = struct.unpack('s', data, 0x34 + 1)
	local targid = struct.unpack('H', data, 0x08 + 1)
	local flags  = struct.unpack('B', data, 0x0A + 1)
	local nameflag = 0x08
	
	-- check if flags contain rename flag and is in "dynamic entity" range
	-- dynamic entity range may change to start at 0x700 in the future
	if bit.band(flags, nameflag) and targid >= 0x800 then
		local zoneId = getZoneId()
		local fullid = 0x1000000 + bit.lshift(zoneId, 12) + targid

		if registry[zoneId] == nil then
			registry[zoneId] = {}
		end
		
		registry[zoneId][fullid] = {original_name = name}
	end
end

if isWindowerv4 then
    windower.register_event('load', function()
        askForList()
    end)
    windower.register_event('zone change', function()
        askForList()
    end)
    windower.register_event('incoming chunk', function(id, data)
		if id == 0x0E then
			register_dynamic_entity(data)
        elseif id == 0x1FF then
            handleList(id, data:sub(5))
        end
    end)
    windower.register_event("prerender", function()
        render()
    end)
end -- isWindowerv4

if isAshitav4 then
    ashita.events.register('load', 'load_cb', function()
        askForList()
    end)
    ashita.events.register('packet_out', 'packet_out_cb', function(e)
        if e.id == 0x011 then
            askForList()
        end
    end)
    ashita.events.register('packet_in', 'packet_in_cb', function(e)
		if e.id == 0x0E then
			register_dynamic_entity(e.data)
		elseif e.id == 0x1FF then
            handleList(e.id, e.data:sub(5))
        end
    end)
    ashita.events.register('d3d_beginscene', 'beginscene_cb', function()
        render()
    end)
end -- isAshitav4
