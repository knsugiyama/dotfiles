local nt = safe_require('neo-tree')

if not nt then
  return
end

local map = vim.keymap.set
map('n', '<Leader>t', '<cmd>Neotree toggle<CR>')
map('n', '<Leader>f', '<cmd>Neotree reveal<CR>')
