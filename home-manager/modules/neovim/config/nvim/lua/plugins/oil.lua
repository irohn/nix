return {
  {
    "stevearc/oil.nvim",
    opts = {},
    config = function()
      require("oil").setup()

      local function find_git_root()
        local current_dir = vim.fn.expand("%:p:h")
        local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(current_dir) .. " rev-parse --show-toplevel")[1]
        return vim.v.shell_error == 0 and git_root or nil
      end

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { noremap = true, silent = true, desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>e", function()
        local project_root = find_git_root() or vim.fn.getcwd()
        vim.cmd.Oil(project_root)
      end, { noremap = true, silent = true, desc = "Open parent directory" })
    end,
  },
}
