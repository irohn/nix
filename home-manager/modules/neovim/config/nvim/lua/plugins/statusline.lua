local statusline_config = function()
  require("mini.statusline").setup({
    use_icons = vim.g.patched_font,
  })
end

local M = {
  {
    "echasnovski/mini.statusline",
    version = "*",
    config = statusline_config,
  },
}

return M
