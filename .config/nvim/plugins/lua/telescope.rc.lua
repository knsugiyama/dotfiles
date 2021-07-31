local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}

local api = vim.api
api.nvim_set_keymap('n', ';fg', ':Telescope find_files<CR>', {noremap=true, silent=true})
api.nvim_set_keymap('n', ';f', ':Telescope live_grep<CR>', {noremap=true, silent=true})
api.nvim_set_keymap('n', '\\', ':Telescope buffers<CR>', {noremap=true, silent=true})
api.nvim_set_keymap('n', ';;', ':Telescope help_tags<CR>', {noremap=true, silent=true})
