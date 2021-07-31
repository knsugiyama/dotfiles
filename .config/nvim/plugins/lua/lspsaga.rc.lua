local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

local api = vim.api
api.nvim_set_keymap('n', '<C-j>', ':Lspsaga diagnostic_jump_next<CR>', {noremap=true, silent=true})
api.nvim_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', {noremap=true, silent=true})
api.nvim_set_keymap('n', '<C-k>', ':Lspsaga signature_help<CR>', {noremap=true, silent=true})
api.nvim_set_keymap('n', 'gh', ':Lspsaga lsp_finder<CR>', {noremap=true, silent=true})
