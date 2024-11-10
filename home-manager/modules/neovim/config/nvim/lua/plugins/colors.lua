local colorschemes = {
  "EdenEast/nightfox.nvim",
  { "rose-pine/neovim", name = "rosepine" },
  "folke/tokyonight.nvim",
  "scottmckendry/cyberdream.nvim",
  "rebelot/kanagawa.nvim",
  "ellisonleao/gruvbox.nvim",
  "sainnhe/everforest",
  "ribru17/bamboo.nvim",
  "maxmx03/fluoromachine.nvim",
  "Mofiqul/vscode.nvim",
  { "catppuccin/nvim", name = "catppuccin" },
  "navarasu/onedark.nvim",
  "projekt0n/github-nvim-theme",
  "pgdouyon/vim-yin-yang",
}

local M = {
  colorschemes,

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({})
    end,
  },
}

return M
