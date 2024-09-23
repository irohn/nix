return {
  "echasnovski/mini.statusline",
  version = "*",
  dependencies = {
    { "echasnovski/mini-git", version = "*", main = "mini.git", opts = {} },
    { "echasnovski/mini.diff", version = "*", opts = {} },
  },
  config = function()
    require("mini.statusline").setup({
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git           = MiniStatusline.section_git({ trunc_width = 75 })
          local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local filename      = vim.fn.expand("%:t") -- Get only the file name
          local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location      = MiniStatusline.section_location({ trunc_width = 75 })
          local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl,                  strings = { mode } },
            { hl = "MiniStatuslineDevinfo",  strings = { git, diagnostics } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl,                  strings = { search, location } },
          })
        end,
      },
    })
  end
}
