return {

  -- NvChad UI plugin
  {
    "nvchad/ui",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "nvchad" 
    end
  },
  {
    "nvchad/base46",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  -- File explorer
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = {
      { "echasnovski/mini.icons", opts = {}, }
    },
    config = function()
      require("configs.oil")
    end,
  },
  {
    "refractalize/oil-git-status.nvim",
    lazy = false,
    config = true,
  },

}
