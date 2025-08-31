local wezterm = require("wezterm")

return function(config)
  config.font = wezterm.font_with_fallback({
    { family = "Moralerspace Argon NF" },
    { family = "HackGen35 Console NF" },
  })
  config.font_size = 16.0
end
