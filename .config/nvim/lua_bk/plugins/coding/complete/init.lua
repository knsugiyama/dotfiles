return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("config/coding/complete/cmp")
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "f3fora/cmp-spell",
  },
  {
    "rafamadriz/friendly-snippets",
  },
  {
    "onsails/lspkind.nvim",
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
  },
}
