return {

	{
		"echasnovski/mini.statusline",
		version = "*",
		config = function()
			require("config.statusline")
		end,
	},

	{
		"irohn/focus.nvim",
		opts = {
			keymaps = {
				n = {
					["<leader>z"] = true,
				}
			}
		},
		cmd = "Focus",
		keys = {
			{ "<leader>z", desc = "Toggle focus mode" },
		},
	},

}
