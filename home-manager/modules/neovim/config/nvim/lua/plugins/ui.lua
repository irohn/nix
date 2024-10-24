return {

	{
		"echasnovski/mini.statusline",
		version = "*",
		config = function()
			require("config.statusline")
		end,
	},

	{
		dir = vim.fn.stdpath("config") .. "lua/config/zen.lua",
		name = "zen",
		config = function()
			require("config.zen").setup()
		end,
	},

}
