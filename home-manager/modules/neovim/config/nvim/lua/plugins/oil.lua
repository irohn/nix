return {
  {
    "stevearc/oil.nvim",
    opts = {},
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { noremap = true, silent = true, desc = "Open parent directory" })
    end,
  },
}
