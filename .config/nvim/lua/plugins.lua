-- lazy_nvim で インストールする plugin list
return {
  --#region
  --{{{ lib
  -- displays a popup with possible key bindings
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require('plugin_configs/which-key')
    end
  },
  --}}}
  --#endregion

  --#region
  --{{{ UI
  -- 全角記号が半角文字と重なってしまう問題の対処
  {
    "delphinus/cellwidths.nvim",
    event = "BufEnter",
    config = function()
      require('plugin_configs/cellwidths')
    end,
  },
  --}}}
  --#endregion

}
