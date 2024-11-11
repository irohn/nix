local focus_opts = function()
  local function is_in_tmux()
    return vim.env.TMUX ~= nil
  end

  local function set_tmux_status(visible)
    if is_in_tmux() then
      local status = visible and "on" or "off"
      vim.fn.system(string.format("tmux set status %s", status))
    end
  end

  return {
    -- filetypes = { "markdown", "text" },

    on_enter = function()
      set_tmux_status(false)
    end,

    on_exit = function()
      set_tmux_status(true)
    end,
  }
end

local M = {
  {
    "irohn/focus.nvim",
    -- dir = "~/projects/personal/focus.nvim",
    opts = focus_opts,
    -- ft = { "markdown", "text" },
    cmd = { "Focus", "FocusOn", "FocusOff" },
    keys = {
      { "<leader>z", "<cmd>Focus<cr>", desc = "Toggle focus mode" },
    },
  },
}

return M
