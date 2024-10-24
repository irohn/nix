return {

	"EdenEast/nightfox.nvim",
	{ "rose-pine/neovim", name = "rosepine" },
	"folke/tokyonight.nvim",
	"scottmckendry/cyberdream.nvim",
	"rebelot/kanagawa.nvim",
	"ellisonleao/gruvbox.nvim",
	"marko-cerovac/material.nvim",
	"sainnhe/everforest",
	"sainnhe/edge",
	"ribru17/bamboo.nvim",
	"maxmx03/fluoromachine.nvim",
	"Mofiqul/vscode.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	"navarasu/onedark.nvim",
	"projekt0n/github-nvim-theme",
	"pgdouyon/vim-yin-yang",

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("config.colors")
		end
	},

}
