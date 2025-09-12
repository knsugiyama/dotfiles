local utils = require 'rc.utils'

local hlchunk = utils.safe_require 'hlchunk'

if not hlchunk then
  return
end

-- Config
local config = {
  -- priority = 10,
  -- style = { vim.api.nvim_get_hl(0, { name = "Whitespace" }) },
  -- use_treesitter = false,
  -- chars = { "│" },
  -- ahead_lines = 5,
  -- delay = 100,
  chunk = {
    enable = true,
    style = {
      '#f9e2af',
      '#f38ba8',
    },
    chars = {
      horizontal_line = '─',
      vertical_line = '│',
      left_top = '╭',
      left_bottom = '╰',
      right_arrow = '>',
    },
    style = '#806d9c',
  },
  indent = {
    enable = true,
    style = '#6c7086',
  },
}

hlchunk.setup(config)
