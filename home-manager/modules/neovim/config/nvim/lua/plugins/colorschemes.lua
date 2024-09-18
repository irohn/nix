return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    config = function()
      vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<cr>", { silent = true, noremap = true, desc = "Toggle Transparent background" })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "sho-87/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.color("kanagawa-paper")
    end
  },
}
