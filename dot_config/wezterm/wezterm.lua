-- Based on: https://wezfurlong.org/wezterm/config/files.html

-- Pull in the wezterm API
local wezterm = require 'wezterm'

local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

config.default_prog = { 'nvim', '-c' ,'"startinsert"', '+terminal'}

wezterm.on('gui-startup', function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	tab:set_title 'Neovim'
end)

-- and finally, return the configuration to wezterm
return config

