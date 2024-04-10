-- Escでハイライト解除
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Esc 連打で、terminal mode を終了する
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- window の移動
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- vを二回で行末まで選択
vim.keymap.set('v', 'v', '$h')

-- Y -> 行末までヤンク
vim.keymap.set('n', 'Y', 'y$')

vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

-- Dまたはxで削除したときはヤンクしない
vim.keymap.set('n', 'D', '"_D')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('v', 'x', '"_x')

-- 分割
vim.keymap.set('n', '<C-w>s', ':split<CR>')
vim.keymap.set('n', '<C-w>v', ':vsplit<CR>')

-- Tab操作
vim.keymap.set('n', '<C-t>n', ':tabnew<CR>')
vim.keymap.set('n', '<C-t>N', ':tabNext<CR>')
vim.keymap.set('n', '<C-t>p', ':tabprevious<CR>')
vim.keymap.set('n', '<C-t>X', ':tabclose<CR>')

-- j, k による移動を折り返されたテキストでも自然に振る舞うように変更
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- insert mode からの保存や閉じる
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'jkw', '<ESC>:w!<CR>', { silent = true })
vim.keymap.set('i', 'jkq', '<ESC>:wq!<CR>', { silent = true })

-- jkでEscする
vim.keymap.set('i', 'jk', '<Esc>')

-- 終了
vim.keymap.set('n', 'sq', ':q<CR>')

-- 現在のバッファ削除
vim.keymap.set('n', 'bd', ':bd<CR>')

-- 設定ファイルを開く
-- vim.keymap.set('n', '<F1>', ':edit $MYVIMRC<CR>')

-- 現在編集中のファイルのディレクトリに移動
vim.keymap.set('n', 'cd', '<CMD>cd %:h<CR>', { desc = '[C]hange [D]irectory' })
