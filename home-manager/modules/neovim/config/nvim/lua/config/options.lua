local M = {}

local DEFAULT_OPTIONS = {
	number = true,
	relativenumber = true,
	wrap = false,
	scrolloff = 8,
	colorcolumn = "80,120",
	listchars = "tab:→ ,space:·,nbsp:␣,trail:•,eol:¶",
	-- Add more defaults
}

-- Option type handlers
local handlers = {
	-- Handler for comma-separated string lists that can be tables
	comma_list = {
		normalize = function(value)
			if type(value) == "table" then
				return table.concat(value, ",")
			elseif type(value) == "string" then
				return value
			end
			return ""
		end,
		parse = function(value)
			if type(value) == "string" and value ~= "" then
				local items = {}
				for item in value:gmatch("[^,]+") do
					table.insert(items, item:match("^%s*(.-)%s*$")) -- trim whitespace
				end
				return items
			end
			return value
		end
	},

	-- Handler for number lists (like colorcolumn)
	number_list = {
		normalize = function(value)
			if type(value) == "table" then
				return table.concat(value, ",")
			elseif type(value) == "string" then
				return value
			end
			return ""
		end,
		parse = function(value)
			if type(value) == "string" and value ~= "" then
				local numbers = {}
				for num in value:gmatch("[^,]+") do
					table.insert(numbers, tonumber(num))
				end
				return numbers
			end
			return value
		end
	}
}

-- Map options to their handlers
local option_handlers = {
	colorcolumn = handlers.number_list,
	listchars = handlers.comma_list,
	-- Add more option mappings as needed
}

local function get_handler(option)
	return option_handlers[option] or {
		normalize = function(v) return v end,
		parse = function(v) return v end
	}
end

local function read_cache()
	local cache_file = vim.fn.stdpath('cache') .. '/option_states.json'
	local f = io.open(cache_file, 'r')
	if f then
		local content = f:read('*all')
		f:close()
		local decoded = vim.json.decode(content)
		if decoded and next(decoded) then
			return decoded
		end
	end
	return vim.deepcopy(DEFAULT_OPTIONS)
end

local function write_cache(data)
	local cache_file = vim.fn.stdpath('cache') .. '/option_states.json'
	local f = io.open(cache_file, 'w')
	if f then
		f:write(vim.json.encode(data))
		f:close()
	end
end

function M.toggle_option(option, states)
	states = states or {true, false}

	if not pcall(function() return vim.opt[option] end) then
		error(string.format("Invalid option: '%s'", option))
		return
	end

	local handler = get_handler(option)
	local current = vim.opt[option]:get()
	local cache = read_cache()

	-- Normalize current value and states for comparison
	current = handler.normalize(current)
	local normalized_states = vim.tbl_map(handler.normalize, states)

	-- Find current state in states table
	local current_index = nil
	for i, state in ipairs(normalized_states) do
		if state == current then
			current_index = i
			break
		end
	end

	-- Toggle to next state or default to first state
	if not current_index then
		vim.opt[option] = handler.parse(states[1])
		cache[option] = handler.normalize(states[1])
	else
		local next_index = current_index % #states + 1
		vim.opt[option] = handler.parse(states[next_index])
		cache[option] = handler.normalize(states[next_index])
	end

	write_cache(cache)
end

function M.restore_options()
	local cache = read_cache()
	for option, value in pairs(cache) do
		if pcall(function() return vim.opt[option] end) then
			local handler = get_handler(option)
			vim.opt[option] = handler.parse(value)
		end
	end
end

function M.reset_to_defaults()
	local cache = vim.deepcopy(DEFAULT_OPTIONS)
	write_cache(cache)
	M.restore_options()
end

return M
