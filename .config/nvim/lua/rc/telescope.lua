return {
  setup = function()
    vim.api.nvim_set_keymap('n', "<C-p>", "<cmd>Telescope<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', "<leader>p", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
  end,
  config = function()
    require("telescope").setup {
      defaults = {
        vimgrep_arguments = {
          require("installer.integrations.tools").get "ripgrep",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
      },
    }

    require("telescope").load_extension "neoclip"
  end,
}
