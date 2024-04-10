return {
  -- 全角記号が半角文字と重なってしまう問題の対処
  {
    'delphinus/cellwidths.nvim',
    event = 'BufEnter',
    config = function()
      require('cellwidths').setup {
        name = 'default',
      }
    end,
  },

  -- tab stopとシフト幅を自動的に検出
  {
    'tpope/vim-sleuth',
  },

  {
    'nvim-tree/nvim-web-devicons',
  },

  -- See `:help gitsigns` to understand what the configuration keys do
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
