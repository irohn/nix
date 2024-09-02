local wezterm = require("wezterm")

local config = wezterm.config_builder()

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "wsl", "~" }
end

config.window_decorations = "RESIZE"

config.enable_tab_bar = false

config.color_scheme = "One Dark (Gogh)"

config.font_size = 16.0

config.audible_bell = "Disabled"

return config

