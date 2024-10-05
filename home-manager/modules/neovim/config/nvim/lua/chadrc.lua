local M = {}

M.base46 = {
  theme = "onedark",
}

M.ui = {
  tabufline = {
    enabled = false,
  },
}

-- Function to pad a string to a specific length
local function pad_string(str, total_length)
  return str .. string.rep(" ", total_length - #str)
end

-- Function to find the length of the longest line
local function get_max_length(lines)
  local max_length = 0
  for _, line in ipairs(lines) do
    max_length = math.max(max_length, #line)
  end
  return max_length
end

local function get_os_type()
  local os_name = vim.loop.os_uname().sysname:lower()
  if os_name:find("darwin") then
    return "󰀵 MAC"
  elseif os_name:find("linux") then
    return "󰌽 LINUX"
  elseif os_name:find("windows") then
    return "󰖳 WINDOWS"
  else
    return " UNKNOWN"
  end
end
local os_type = get_os_type()

local nvim_version = vim.version()
local nvim_version_str = string.format(" %d.%d.%d", nvim_version.major, nvim_version.minor, nvim_version.patch)

local username = " " .. os.getenv("USER")

-- Create your header lines
local header_lines = {
  "",
  os_type,
  nvim_version_str,
  username,
  "",
}

local max_length = get_max_length(header_lines)

-- Pad all lines to the same length
local padded_header_lines = {}
for _, line in ipairs(header_lines) do
  table.insert(padded_header_lines, pad_string(line, max_length))
end

M.nvdash = {
  load_on_startup = true,
  header = padded_header_lines,
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
