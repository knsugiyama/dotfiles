-- lazy_nvim で インストールする plugin
return {
  -- lib
  { 'nvim-lua/popup.nvim' },
  -- colorscheme
  -- https://github.com/Mofiqul/dracula.nvim
  {
    'Mofiqul/dracula.nvim',
    config = function()
      vim.cmd[[colorscheme dracula]]
    --   vim.cmd[[colorscheme dracula-soft]]
    end
  },

  -- Neovim statusline
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('plugin_configs/lualine')
    end
  },

  -- git decorations
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugin_configs/gitsigns')
    end
  },

  -- commenting plugin
  -- https://github.com/numToStr/Comment.nvim
  {
    'numToStr/Comment.nvim',
    config = function()
      require('plugin_configs/Comment')
    end
  },

  -- File Explorer
  -- https://github.com/nvim-tree/nvim-tree.lua
  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function()
  --     require('plugin_configs/nvim-tree')
  --   end
  -- },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    event = "VimEnter",
    branch = "main",
    config = function()
      require('plugin_configs/neo-tree')
    end,
  },

  -- displays a popup with possible key bindings
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  }
}
