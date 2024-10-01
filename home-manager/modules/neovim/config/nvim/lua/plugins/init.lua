return {

  {
    "tpope/vim-sleuth",
    lazy = false,
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = {
      {
        "echasnovski/mini.icons",
        opts = {},
      }
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

  {
    "echasnovski/mini.align",
    lazy = false,
    version = "*",
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("configs.treesitter")
    end,
  },

  {
    "echasnovski/mini-git",
    lazy = false,
    version = "*",
    main = "mini.git",
    opts = {},
  },

  {
    "echasnovski/mini.diff",
    lazy = false,
    version = "*",
    opts = {},
  },

  {
    "echasnovski/mini.statusline",
    lazy = false,
    version = "*",
    opts = {},
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("configs.telescope")
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
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

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "b0o/SchemaStore.nvim", -- json and yaml schemas
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          return "make install_jsregexp"
        end)
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      require("configs.cmp")
    end
  },

}
