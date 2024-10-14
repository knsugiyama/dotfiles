local utils = require('rc.utils')

local hlchunk = utils.safe_require('hlchunk')

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
}

hlchunk.setup(config)
