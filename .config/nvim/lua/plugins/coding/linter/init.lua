return {
  {
    'nvimtools/none-ls-extras.nvim',
  },
  {
    'nvimtools/none-ls.nvim',
    config = function()
      require 'config/coding/linter/none-ls'
    end,
  },
}
