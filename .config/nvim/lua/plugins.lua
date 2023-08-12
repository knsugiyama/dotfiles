-- lazy_nvim で インストールする plugin
return {
    -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('plugin_configs/tokyonight')
    end,
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

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '|',
      show_trailing_blankline_indent = false,
    },
  },

  -- git decorations
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugin_configs/gitsigns')
    end
  },

  -- File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require('plugin_configs/neo-tree')
    end,
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
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
  },

  -- commenting plugin
  -- https://github.com/numToStr/Comment.nvim
  {
    'numToStr/Comment.nvim',
    config = function()
      require('plugin_configs/Comment')
    end
  },

    -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugin_configs/telescope')
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'cmake',
    cond = function()
      return vim.fn.executable 'cmake' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require('plugin_configs/nvim-treesitter')
    end,
  },

  --
  -- https://github.com/dinhhuy258/git.nvim
  {
    'dinhhuy258/git.nvim',
    config = function ()
      require('plugin_configs/git')
    end,
  },

  -- Surround selections
  {
    'kylechui/nvim-surround',
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require('plugin_configs/nvim-surround')
    end
  },

  -- Tabs, as understood by any other editor.
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    config = function()
      require('plugin_configs/barbar')
    end,
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  -- 全角記号が半角文字と重なってしまう問題の対処
  {
    "delphinus/cellwidths.nvim",
    event = "BufEnter",
    config = function()
      require('plugin_configs/cellwidths')
    end,
  },
}
