require("glow").setup {
  vim.api.nvim_set_keymap('n', '<leader>mp', ':Glow<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-w>z', '<C-w>\|<C-w>\_', { noremap = true })
}
