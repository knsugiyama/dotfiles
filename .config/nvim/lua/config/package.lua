require('core.plugin').init()
local lazy = require 'lazy'

if vim.env.NVIM_COLORSCHEME == nil then
  -- vim.cmd [[colorscheme tokyonight]]
  vim.env.NVIM_COLORSCHEME = 'tokyonight'
end

lazy.setup {
  spec = {
    { import = 'plugins' },
  },
  defaults = { lazy = true },
  install = { missing = true, colorscheme = { 'tokyonight' } },
  checker = { enabled = false },
  concurrency = 64,
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'netrw',
        'tarPlugin',
        'tar',
        'tohtml',
        'tutor',
        'zipPlugin',
        'zip',
      },
    },
  },
}
