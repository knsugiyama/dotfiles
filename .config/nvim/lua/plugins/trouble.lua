-- 診断情報のUI
return {
  'folke/trouble.nvim',
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>' },
    { '<leader>xs', '<cmd>Trouble symbols toggle<cr>' },
  },
}
