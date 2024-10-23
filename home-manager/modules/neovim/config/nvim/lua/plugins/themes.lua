return {

	"EdenEast/nightfox.nvim",
	{ "rose-pine/neovim", name = "rosepine" },
	"folke/tokyonight.nvim",
	"scottmckendry/cyberdream.nvim",
	"rebelot/kanagawa.nvim",
	"Mofiqul/vscode.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	"navarasu/onedark.nvim",
	"projekt0n/github-nvim-theme",

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("config.colors")
		end
	},

}
