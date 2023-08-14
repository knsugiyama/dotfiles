-- lazy_nvim で インストールする plugin
return {
  -- Automatically install LSPs to stdpath for neovim
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "VimEnter" },
    build = ":MasonUpdate",
    config = function()
      require("plugin_configs/mason")
    end,
  },

  --#region
  --{{{ libs
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- git decorations
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugin_configs/gitsigns')
    end
  },

  --}}}
  --#endregion

  --#region
  --{{{ UI
  -- notify
  {
    "rcarriga/nvim-notify",
    event = "BufReadPre",
    config = function()
      require("plugin_configs/nvim-notify")
    end,
  },
  -- color scheme
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
    config = function()
      require('plugin_configs/lualine')
    end
  },

  { "nvim-tree/nvim-web-devicons" },
  -- 全角記号が半角文字と重なってしまう問題の対処
  {
    "delphinus/cellwidths.nvim",
    event = "BufEnter",
    config = function()
      require('plugin_configs/cellwidths')
    end,
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    config = function()
      require('plugin_configs/indent-blankline')
    end
  },

  -- File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    config = function()
      require('plugin_configs/neo-tree')
    end,
  },

  -- Tabs, as understood by any other editor.
  {
    'romgrk/barbar.nvim',
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
      require('plugin_configs/barbar')
    end,
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  --}}}
  --#endregion

  --#region
  --{{{ LSP / completion
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = "VimEnter",
    config = function()
      require("plugin_configs/nvim-cmp")
    end,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      { "L3MON4D3/LuaSnip" },
      -- Adds a number of user-friendly snippets
      { "rafamadriz/friendly-snippets" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lua" },
      {
        "zbirenbaum/copilot-cmp",
        config = true
      },
      { "hrsh7th/cmp-emoji" },
      { "f3fora/cmp-spell" },
      { "yutkat/cmp-mocword" },
      -- Snippet Engine & its associated nvim-cmp source
      { "saadparwaiz1/cmp_luasnip" },
      { "ray-x/cmp-treesitter" },
      {
        "onsails/lspkind-nvim",
        config = function()
          require("plugin_configs/lspkind-nvim")
        end,
      },
    },
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    config = function()
      require("plugin_configs/nvim-lspconfig")
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = "BufReadPre",
    config = function()
      require("plugin_configs/mason-lspconfig")
    end,
    dependencies = {
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        tag = "legacy",
        event = "LspAttach",
        config = function()
          require("plugin_configs/fidget")
        end
      },

      -- {
      --   'folke/neoconf.nvim',
      --   config = function()
      --     require("plugin_configs/neoconf")
      --   end
      -- },
      --
      -- Additional lua configuration, makes nvim stuff amazing!
      {
        'folke/neodev.nvim',
        config = function()
          require("plugin_configs/neodev")
        end
      },
    },
  },

  -- -- AI completion
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   config = function()
  --     vim.defer_fn(function()
  --       require("plugin_configs/copilot-cmp")
  --     end, 100)
  --   end,
  -- },
  --
  -- LSP UI
  {
    "nvimdev/lspsaga.nvim",
    event = "VimEnter",
    config = function()
      require("plugin_configs/lspsaga")
    end,
  },

  -- LSP Diagnostics UI
  {
    "folke/trouble.nvim",
    event = "VimEnter",
    config = function()
      require("plugin_configs/trouble")
    end,
  },
  --}}}
  --#endregion

  -- displays a popup with possible key bindings
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require('plugin_configs/which-key')
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
  {
    'nvim-telescope/telescope.nvim',
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
    config = function()
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

  -- lint
  {
    "mfussenegger/nvim-lint",
    event = "VimEnter",
    config = function()
      require("plugin_configs/nvim-lint")
    end,
  },

  -- format-on-save
  {
    "elentok/format-on-save.nvim",
    event = "VimEnter",
    config = function()
      require("plugin_configs/format-on-save")
    end,
  },
}
