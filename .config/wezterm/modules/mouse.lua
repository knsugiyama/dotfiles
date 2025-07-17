local wezterm = require("wezterm")

return function(config)
  config.mouse_bindings = {
    -- 右クリックでクリップボードから貼り付け
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
  }
end
