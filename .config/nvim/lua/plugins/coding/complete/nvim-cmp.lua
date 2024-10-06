return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("config/coding/complete/cmp")
    end,
  },
}
