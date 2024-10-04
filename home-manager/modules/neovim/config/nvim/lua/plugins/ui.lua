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

}
