-- packer.nvim auto install
local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

local packer = require "packer"
packer.reset()

packer.startup {
  function(use)
    use { "wbthomason/packer.nvim" }

    --------------------------------
    -- Global
    --------------------------------
    -- lua プラグインの読み込み高速化
    use { "lewis6991/impatient.nvim" }

    use { "vim-jp/vimdoc-ja" }

    use { "nathom/filetype.nvim" }

    use {
      "monkoose/matchparen.nvim",
      config = function()
        require("matchparen").setup()
      end,
    }

    --------------------------------
    -- Code
    --------------------------------
    -- Highlights
    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'RRethy/nvim-treesitter-textsubjects',
      },
      run = ':TSUpdate',
    }

    use {
      -- Neovim を言語サーバーとして使用
      "jose-elias-alvarez/null-ls.nvim",
      requires = { { "nvim-lua/plenary.nvim", module = "plenary" } },
      module = "null-ls",
    }
    use {
      "weilbith/nvim-code-action-menu",
      cmd = "CodeActionMenu",
    }

    use { "neovim/nvim-lspconfig", module = "lspconfig" }
    use { "ray-x/lsp_signature.nvim", module = "lsp_signature" }
    use { "onsails/lspkind-nvim", module = "lspkind" }
    use { "tami5/lspsaga.nvim", module = "lspsaga", cmd = "Lspsaga" }
    use { "folke/lua-dev.nvim", module = "lua-dev" }
    use { "jose-elias-alvarez/nvim-lsp-ts-utils", module = "nvim-lsp-ts-utils" }
    use { "b0o/schemastore.nvim", module = "schemastore" }
    use { "j-hui/fidget.nvim", module = "fidget" }

    use "williamboman/nvim-lsp-installer"

    use {
      "nazo6/installer.nvim",
      module = "installer",
      cmd = { "Install", "Uninstall", "Update" },
      config = function()
        require "rc.installer"
      end,
    }

    use {
      "L3MON4D3/LuaSnip",
      config = function()
        require "rc.luasnip"
      end,
      event = "InsertEnter",
    }
    use {
      -- auto complete
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-calc", after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      },
      event = { "InsertEnter", "CmdlineEnter" },
      config = function()
        require "rc.cmp"
      end,
    }

    ------------------------
    -- Appearance plugins --
    ------------------------
    use "folke/tokyonight.nvim"

    use {
      "windwp/windline.nvim",
      config = function()
        require "rc.windline"
      end,
    }

    use { "dstein64/nvim-scrollview" }

    use {
      "akinsho/nvim-bufferline.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require "rc.bufferline"
      end,
    }

    use {
      -- 多言語対応のVimグラフィカルデバッガ
      "puremourning/vimspector",
      ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      config = function()
        vim.g.vimspector_install_gadgets = { "vscode-node-debug2" }
        vim.g.vimspector_enable_mappings = "HUMAN"
      end,
    }

    -- Path navigation
    use 'justinmk/vim-dirvish'

    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require "rc.indent-blankline"
      end,
    }

    -------------
    -- Coading --
    -------------
    -- debugger
    use {
      "mfussenegger/nvim-dap",
      module = { "dap" },
      config = function()
        require "rc.dap"
      end,
    }

    use {
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      module = { "dapui" } }

    use {
      "theHamsta/nvim-dap-virtual-text",
      module = "nvim-dap-virtual-text",
    }

    use {
      "windwp/nvim-autopairs",
      event = { "InsertEnter" },
      after = { "nvim-cmp" },
      config = function()
        require("nvim-autopairs").setup {
          enable_check_bracket_line = false,
        }
      end,
    }

    use {
      "windwp/nvim-ts-autotag",
      ft = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "xml",
        "php",
      },
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    }

    -- Markdown
    use { "ellisonleao/glow.nvim",
      config = function()
        require("glow")
      end,
    }

    -----------
    -- Utils --
    -----------
    use {
      -- neovim 用のクリップボードマネージャ
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup()
      end,
    }

    use {
      -- ファジーファインダー
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      module = "telescope",
      requires = {
        { "nvim-lua/plenary.nvim", module = "plenary" },
      },
      setup = function()
        require("rc.telescope").setup()
      end,
      config = function()
        require("rc.telescope").config()
      end,
    }

    use {
      -- File Explorer
      "kyazdani42/nvim-tree.lua",
      requires = { { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" } },
      cmd = { "NvimTree*" },
      setup = function()
        require("rc.nvim-tree").setup()
      end,
      config = function()
        require("rc.nvim-tree").config()
      end,
    }

    use {
      "folke/trouble.nvim",
      requires = { { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" } },
      cmd = "Trouble*",
      setup = function()
        require("rc.trouble").setup()
      end,
      config = function()
        require("rc.trouble").config()
      end,
    }

    use {
      "stevearc/aerial.nvim",
      event = "BufRead",
      cmd = "Aerial*",
      setup = function()
        require("rc.aerial").setup()
      end,
      config = function()
        require("rc.aerial").config()
      end,
    }

    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        { "nvim-lua/plenary.nvim", module = "plenary" },
      },
      event = "BufRead",
      config = function()
        require("gitsigns").setup()
      end,
    }

    -------------------------------
    -- Language specific plugins --
    -------------------------------
    use { "teal-language/vim-teal", ft = { "teal" } }
    use { "chrisbra/csv.vim", ft = { "csv" } }
    use { "dag/vim-fish", ft = { "fish" } }
    use { "kevinoid/vim-jsonc", ft = { "json" } }

    use {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { { "nvim-lua/plenary.nvim", module = "plenary" } },
      config = function()
        require("crates").setup()
      end,
    }
    use {
      "vuki656/package-info.nvim",
      event = { "BufRead package.json" },
      requires = { { "MunifTanjim/nui.nvim", module = "nui" } },
    }

    use {
      "NTBBloodbath/rest.nvim",
      requires = { { "nvim-lua/plenary.nvim", module = "plenary" } },
      ft = { "http" },
    }

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
}
