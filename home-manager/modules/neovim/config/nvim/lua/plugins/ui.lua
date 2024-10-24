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
		opts = require("config.focus"),
		cmd = "Focus",
		keys = {
			{ "<leader>z", "<cmd>Focus<cr>", desc = "Toggle focus mode" },
		},
	},

}
