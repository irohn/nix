local M = {}

M.apply_to_config = function(config)
  config.window_decorations = "RESIZE"
  config.window_padding = { left = 1, right = 1, top = 0, bottom = 0 }
  config.window_background_opacity = 0.9
  config.macos_window_background_blur = 20

  config.enable_tab_bar = true
  config.use_fancy_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = true
  config.show_new_tab_button_in_tab_bar = false

  config.color_scheme = "duskfox"

  config.font_size = 24.0
  config.audible_bell = "Disabled"
end

return M
