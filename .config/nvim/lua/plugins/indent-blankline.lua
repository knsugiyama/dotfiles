return {
  "lukas-reineke/indent-blankline.nvim",
  -- プラグインのロードタイミング
  event = { "BufReadPre", "BufNewFile" },
  -- プラグインのメインモジュール
  main = "ibl",
  -- プラグインの設定オプション
  opts = {},
}
