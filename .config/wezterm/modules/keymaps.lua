local wezterm = require("wezterm")
local act = wezterm.action

return function(config)
  config.leader = { key = "Space", mods = "CTRL|SHIFT" }

  config.keys = {
    -- Ctrl+Backspaceで前の単語を削除
    {
      key = "Backspace",
      mods = "CTRL",
      action = act.SendKey({
        key = "w",
        mods = "CTRL",
      }),
    },
    -- Ctrl+Shift+t で新しいタブを作成
    {
      key = "t",
      mods = "SHIFT|CTRL",
      action = act.SpawnTab("CurrentPaneDomain"),
    },
    -- Leader+d で水平分割
    {
      key = "d",
      mods = "LEADER",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    -- Leader+Enter で垂直分割
    {
      key = "Enter",
      mods = "LEADER",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
  }
end
