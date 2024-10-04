local wezterm = require 'wezterm'

local M = {}

M.platform = wezterm.target_triple

if M.platform == "x86_64-pc-windows-msvc" then
  M.WSL = true
else
  M.WSL = false
end

if M.WSL then
  M.default_prog = { "wsl", "~" }
end

M.apply_to_config = function(config)
  config.default_prog = M.default_prog
end

return M
