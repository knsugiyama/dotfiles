-- https://wezfurlong.org/wezterm/config/files.html
-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- change default shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'pwsh.exe', '-l' }
end

-- This is where you actually apply your config choices
-- Changing the color scheme and font:
config.color_scheme = 'Dracula (Official)'
config.font = wezterm.font 'HackGen35 Console NF'
config.font_size = 11.0

config.leader = { key = "Space", mods = "CTRL|SHIFT" }

-- and finally, return the configuration to wezterm
return config
