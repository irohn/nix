return {
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    opts = {},
    config = function()
      local oil = require("oil")

      local detail = false

      local function find_git_root()
        local current_dir = vim.fn.expand("%:p:h")
        local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(current_dir) .. " rev-parse --show-toplevel")[1]
        return vim.v.shell_error == 0 and git_root or nil
      end

      oil.setup({
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 90,
          max_height = 25,
          border = "none",
          win_options = {
            winblend = 0,
          },
        },
        keymaps = {
          ["gr"] = {
            desc = "Go to project's root",
            callback = function()
              local project_root = find_git_root() or vim.fn.getcwd()
              oil.open(project_root)
            end
          },
          ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
              detail = not detail
              if detail then
                require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
              else
                require("oil").set_columns({ "icon" })
              end
            end,
          },
        },
      })

      vim.keymap.set("n", "<leader>e", function()
        oil.toggle_float()
      end, { noremap = true, silent = true, desc = "Open parent directory" })

    end,
  },
}
