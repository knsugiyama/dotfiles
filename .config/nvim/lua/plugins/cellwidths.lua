return {
  -- 全角記号が半角文字と重なってしまう問題の対処
  {
    "delphinus/cellwidths.nvim",
    event = "BufEnter",
    config = function()
      require("cellwidths").setup({
        name = "default",
      })
    end,
  },
}
