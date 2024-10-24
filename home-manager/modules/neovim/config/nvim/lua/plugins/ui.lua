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
		-- dir = "~/projects/personal/focus.nvim",
		opts = require("config.focus"),
		ft = { "markdown", "text" },
		cmd = "Focus",
		keys = {
			{ "<leader>z", "<cmd>Focus<cr>", desc = "Toggle focus mode" },
		},
	},

}
