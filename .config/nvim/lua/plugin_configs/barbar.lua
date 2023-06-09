require('barbar').setup({
  icons = {
    -- Configure the base icons on the bufferline.
    button = '',
  },

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = true,

})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<M-h>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<M-l>', '<Cmd>BufferNext<CR>', opts)
-- Close buffer
map('n', '<leader>e', '<Cmd>BufferClose<CR>', opts)
map('n', '<leader>w', '<Cmd>BufferCloseAllButCurrent<CR>', opts)
