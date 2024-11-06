-- Pull in the wezterm API
local wezterm = require 'wezterm'
-- local mux = wezterm.mux
-- This will hold the configuration.
local config = wezterm.config_builder()
-- This is where you actually apply your config choices
-- For example, changing the color scheme:
function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
-- Spawn a nushell shell in login mode
config.default_prog = { 'nu', '-c', "zellij -l welcome --config-dir ~/.config/yazelix/zellij options --layout-dir ~/.config/yazelix/zellij/layouts" }
-- Others
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "NONE"

config.enable_tab_bar = true
config.initial_rows = 48
config.initial_cols = 150

--config.window_decorations = "NONE"
config.window_decorations = "RESIZE"
-- and finally, return the configuration to wezterm
return config
