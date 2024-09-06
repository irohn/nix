return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    { 'echasnovski/mini.icons', version = false },
  },
  config = function()
    local nvimtree = require("nvim-tree")

    local gwidth = vim.api.nvim_list_uis()[1].width
    local gheight = vim.api.nvim_list_uis()[1].height
    local width = 60
    local height = 20

    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })

    nvimtree.setup({
      filters = {
        dotfiles = false,
      },
      renderer = {
        root_folder_label = function(path)
          return vim.fn.fnamemodify(path, ':t')
        end,
      },
      view = {
        side = "left",
        float = {
          enable = false,
          open_win_config = {
            relative = "editor",
            width = width,
            height = height,
            row = (gheight - height) * 0.4,
            col = (gwidth - width) * 0.5,
          },
        },
      },
    })

  end,
}
