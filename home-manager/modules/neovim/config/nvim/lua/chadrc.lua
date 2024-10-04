M = {}

M.base46 = {
	theme = "onedark",
}

M.ui = {
  tabufline = {
    enabled = false,
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    [[                                                                       ]],
    [[                                                                     ]],
    [[       ████ ██████           █████      ██                     ]],
    [[      ███████████             █████                             ]],
    [[      █████████ ███████████████████ ███   ███████████   ]],
    [[     █████████  ███    █████████████ █████ ██████████████   ]],
    [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
    [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
    [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
    [[                                                                       ]],
  },
  buttons = {
    { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Grep", keys = "Spc f g", cmd = "Telescope live_grep" },
    { txt = "  Explore Files", keys = "Spc e", cmd = "lua require('oil').open()" },
    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
    {
      txt = function()
	local stats = require("lazy").stats()
	local ms = math.floor(stats.startuptime) .. " ms"
	return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashLazy",
      no_gap = true,
    },
    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
  },
}

return M
