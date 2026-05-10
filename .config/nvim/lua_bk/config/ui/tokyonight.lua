local utils = require("rc.utils")

local tokyonight = utils.safe_require("tokyonight")

if not tokyonight then
  return
end

tokyonight.setup({
  style = 'night',
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = false },
    keywords = { italic = false },
    functions = { italic = false },
    variables = { italic = false },
    -- Background styles. Can be "dark", "transparent" or "normal"
    -- sidebars = "dark", -- style for sidebars, see below
    -- floats = "dark", -- style for floating windows
  },
})

vim.cmd [[colorscheme tokyonight]]
