local M = {}

M.zen_active = false

local zen_options = {
	number = false,
	relativenumber = false,
	signcolumn = "yes:3",
	colorcolumn = {0},
	laststatus = 0,
	showmode = false,
	ruler = false,
	showcmd = false,
	cmdheight = 0,
}

local original_values = {}

function M.toggle_zen()
	if not M.zen_active then
		for option, zen_value in pairs(zen_options) do
			if pcall(function() return vim.opt[option] end) then
				original_values[option] = vim.opt[option]:get()
				vim.opt[option] = zen_value
			end
		end
		M.zen_active = true

	else
		for option, value in pairs(original_values) do
			if pcall(function() return vim.opt[option] end) then
				vim.opt[option] = value
			end
		end
		M.zen_active = false

	end
	vim.notify("Zen mode " .. (M.zen_active and "enabled" or "disabled"))
end

-- Add the user command
function M.setup()
	vim.api.nvim_create_user_command('Zen', function()
		M.toggle_zen()
	end, {})

	-- You might also want to add a keymap
	vim.keymap.set('n', '<leader>z', M.toggle_zen, { desc = "Toggle zen mode" })
end

function M.init()
	M.setup()
end

return M
