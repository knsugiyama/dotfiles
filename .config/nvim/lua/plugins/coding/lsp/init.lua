return {
  {
    "neovim/nvim-lspconfig",
    event = "InsertEnter",
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("config/coding/lsp/mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("config/coding/lsp/mason-lspconfig")
    end,
  },
}
