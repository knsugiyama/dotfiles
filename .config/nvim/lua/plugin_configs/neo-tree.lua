require("neo-tree").setup({
  popup_border_style = "rounded",
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
    },
    follow_current_file = { enabled = true },
  },
  window = {
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
    }
  },
  git_status = {
    window = {
      position = "float",
    },
  },
})
vim.keymap.set("n", "gx", "<Cmd>Neotree toggle<CR>", { noremap = true, silent = true, desc = 'Neotree toggle' })
vim.keymap.set("n", "G,", "<Cmd>Neotree git_status<CR>", { noremap = true, silent = true, desc = 'Git Status' })
