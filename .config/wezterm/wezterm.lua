local wezterm = require("wezterm")
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- モジュール読み込み
for _, mod in ipairs({
  "env",
  "fonts",
  "appearance",
  "keymaps",
  "mouse",
}) do
  local m = require("modules." .. mod)
  if type(m) == "function" then
    m(config)
  end
end

return config
