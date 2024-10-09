return {
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("config/coding/lsp/mason-lspconfig")
    end,
  },
}
