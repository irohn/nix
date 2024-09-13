return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    config = function()
      require('render-markdown').setup({
        render_modes = { 'n', 'v', 'i', 'c' },
        anti_conceal = { enabled = true },
      })
    end,
  },
}
