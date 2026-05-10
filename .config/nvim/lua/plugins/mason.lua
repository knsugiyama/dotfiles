return {
  {
    -- LSPサーバーを自動でインストール
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    -- LSPサーバーを自動で lspconfig に渡す
    "mason-org/mason-lspconfig.nvim",
    -- Bufferが読み込まれるときをトリガーに遅延ロードする
    event = { "BufNewFile", "BufReadPre" },
    opts = {},
  },
}
