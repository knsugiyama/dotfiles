require('Comment').setup()
vim.keymap.set('n', '<C-_>', 'gcc') -- Toggles the current line using linewise comment
vim.keymap.set('v', '<C-_>', 'gc')  -- Toggles the region using linewise comment
