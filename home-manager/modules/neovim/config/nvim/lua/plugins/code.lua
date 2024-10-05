return {

  -- Language servers
  {
    "williamboman/mason.nvim",
    lazy = false,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("configs.lsp")
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    build = (function()
      return "make install_jsregexp"
    end),
  },
  { "saadparwaiz1/cmp_luasnip", lazy = false, },

  -- Auto completion
  { "hrsh7th/cmp-nvim-lsp", lazy = false, },
  { "hrsh7th/cmp-buffer", lazy = false, },
  { "hrsh7th/cmp-path", lazy = false, },
  { "hrsh7th/cmp-cmdline", lazy = false, },
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    config = function()
      require("configs.cmp")
    end
  },

  -- LLM
  {
    "David-Kunz/gen.nvim",
    lazy = false,
    config = function()
      require("configs.gen")
    end,
  },

}
