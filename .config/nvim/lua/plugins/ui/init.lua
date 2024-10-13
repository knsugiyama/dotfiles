return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    config = function()
      require("config/ui/tokyonight")
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    config = function()
      require("config/ui/lualine")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    config = function()
      require("keymap/ui/neo-tree")
      require("config/ui/neo-tree")
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("config/coding/hlchunk")
    end
  },
}
