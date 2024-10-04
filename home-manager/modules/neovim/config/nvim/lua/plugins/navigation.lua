return {

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.telescope")
    end,
  },

  {
    "ThePrimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.harpoon")
    end,
  },

  -- File explorer (the slower type of navigation)
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
