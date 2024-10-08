local wezterm = require 'wezterm'
local platform = require 'platform'
local mappings = require 'mappings'
local appearance = require 'appearance'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

platform.apply_to_config(config)
mappings.apply_to_config(config)
appearance.apply_to_config(config)

return config

