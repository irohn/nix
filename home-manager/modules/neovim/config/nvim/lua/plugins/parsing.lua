return {

  {
    "tpope/vim-sleuth",
    lazy = false,
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

  -- Markdown renderer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  },

}
