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

-- Tab操作
map('n', '<C-t>n', ':tabnew<CR>')
map('n', '<C-t>N', ':tabNext<CR>')
map('n', '<C-t>p', ':tabprevious<CR>')
map('n', '<C-t>X', ':tabclose<CR>')

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
