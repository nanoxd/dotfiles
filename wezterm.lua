local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Tango (terminal.sexy)'
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.9

config.font = wezterm.font {
  family = 'Iosevka Nerd Font',
  stretch = 'Expanded',
  weight = 'Regular',
}

return config
