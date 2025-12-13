-- telescome をファイラーとする
return {
  'nvim-telescope/telescope-file-browser.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function()
    vim.keymap.set('n', '<leader>td', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')
  end,
}
