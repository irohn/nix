return {
  "irohn/ssh.nvim",
  -- "ssh.nvim", -- this is for local development
  -- dir = "~/projects/personal/ssh.nvim", -- this is for local development
  config = function()
    require("ssh")  -- This loads your plugin
    require("telescope").load_extension("ssh")

    -- keymaps
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', '<leader>sl', ':SSHSessionList<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ss', ':Telescope ssh browse_sessions<CR>', opts)

  end,

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}
