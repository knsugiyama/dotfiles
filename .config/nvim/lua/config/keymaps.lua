local map = vim.keymap.set

-- Escでハイライト解除
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Esc 連打で、terminal mode を終了する
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- vを二回で行末まで選択
map('v', 'v', '$h')

map('n', 'H', '^')
map('n', 'L', '$')

-- Dまたはxで削除したときはヤンクしない
map('n', 'D', '"_D')
map('n', 'x', '"_x')
map('v', 'x', '"_x')

-- U でリドゥ
map('n', 'U', '<c-r>')

-- window の移動
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Tab操作
map('n', '<C-t>n', ':tabnew<CR>', { desc = '<T>ab <N>ew' })
map('n', '<C-t>N', ':tabNext<CR>', { desc = '<T>ab <N>ext' })
map('n', '<C-t>p', ':tabprevious<CR>', { desc = '<T>ab <P>revious' })
map('n', '<C-t>X', ':tabclose<CR>', { desc = '<T>ab close' })

-- j, k による移動を折り返されたテキストでも自然に振る舞うように変更
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- insert mode からの保存や閉じる
map('i', 'jk', '<ESC>', { silent = true })
map('i', 'jkw', '<ESC>:w!<CR>', { silent = true })
map('i', 'jkq', '<ESC>:wq!<CR>', { silent = true })

-- jkでEscする
map('i', 'jk', '<Esc>')

-- 終了
map('n', 'sq', ':q<CR>')

-- 現在のバッファ削除
map('n', 'bd', ':bd<CR>')

-- 設定ファイルを開く
map('n', '<F1>', ':edit $MYVIMRC<CR>')
