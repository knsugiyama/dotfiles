return {
  setup = function()
    vim.api.nvim_set_keymap('n', "<leader>x", "<cmd>TroubleToggle<CR>", { noremap = true, silent = true })
  end,
  config = function()
    require("trouble").setup {}
  end,
}
