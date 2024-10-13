local utils = require("rc.utils")

local nt = utils.safe_require('neo-tree')

if not nt then
  return
end

local map = vim.keymap.set
map('n', '<Leader>t', '<cmd>Neotree toggle<CR>', { desc = '<T>oggle tree' })
map('n', '<Leader>f', '<cmd>Neotree reveal<CR>', { desc = '<R>eveal tree' })
