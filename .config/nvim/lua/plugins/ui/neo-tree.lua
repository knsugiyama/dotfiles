return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  config = function()
    require("config/keymaps/neo-tree")
    require("config/ui/neo-tree")
  end,
}
