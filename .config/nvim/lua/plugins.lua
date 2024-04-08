-- lazy_nvim で インストールする plugin list
return {
  -- 入力を開始したコマンドの可能なキー バインドをポップアップで表示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require('plugin_configs/which-key')
    end
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
