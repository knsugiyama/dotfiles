return {
  setup = function()
    vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>AerialToggle<CR>', { noremap = true })
  end,
  config = function()
    require("aerial").setup {
      filter_kind = false,
    }
  end,
}
