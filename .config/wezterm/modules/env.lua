local wezterm = require("wezterm")

return function(config)
  config.set_environment_variables = {
    XDG_CONFIG_HOME = wezterm.home_dir .. "/.config",
    XDG_CACHE_HOME = wezterm.home_dir .. "/.cache",
    XDG_DATA_HOME = wezterm.home_dir .. "/.local/share",
    XDG_STATE_HOME = wezterm.home_dir .. "/.local/state",
  }

  if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_domain = "WSL:Ubuntu"
    config.font_size = 12.0
  end
end
