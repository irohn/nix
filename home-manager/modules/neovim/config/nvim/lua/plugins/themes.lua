return {

	"EdenEast/nightfox.nvim",
	{ "rose-pine/neovim", name = "rosepine" },
	"folke/tokyonight.nvim",
	"scottmckendry/cyberdream.nvim",
	"rebelot/kanagawa.nvim",
	"sainnhe/gruvbox-material",
	"marko-cerovac/material.nvim",
	"sainnhe/everforest",
	"sainnhe/edge",
	"ribru17/bamboo.nvim",
	"maxmx03/fluoromachine.nvim",
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
