-- https://wezfurlong.org/wezterm/config/files.html
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font_size = 16.0

config.font = wezterm.font_with_fallback({
  { family = "Moralerspace Argon NF" },
  { family = "HackGen35 Console NF" },
})

config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

-- change default shell
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "pwsh.exe", "-l" }
  config.font_size = 12.0
end

-- This is where you actually apply your config choices
-- Changing the color scheme and font:
-- config.color_scheme = 'Solarized (light) (terminal.sexy)'
config.color_scheme = 'MaterialDesignColors'

config.initial_rows = 40
config.initial_cols = 150
config.default_cursor_style = "BlinkingUnderline"

config.leader = { key = "Space", mods = "CTRL|SHIFT" }

-- 背景透過
config.window_background_opacity = 0.95
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- ショートカットキー設定
local act = wezterm.action
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
  -- Ctrl+Shift+tで新しいタブを作成
  {
    key = "t",
    mods = "SHIFT|CTRL",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
}

-- マウス操作の挙動設定
config.mouse_bindings = {
  -- 右クリックでクリップボードから貼り付け
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
}

-- and finally, return the configuration to wezterm
return config
