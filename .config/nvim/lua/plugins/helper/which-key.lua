return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("config/helper/which-key")
  end,
}
