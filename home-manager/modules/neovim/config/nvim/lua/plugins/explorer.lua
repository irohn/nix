return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.files').setup({
        windows = {
          preview = true,
        },
      })
      vim.keymap.set("n", "<leader>e", function() MiniFiles.open() end, { desc = "Open file explorer" })
    end,
  },
}
