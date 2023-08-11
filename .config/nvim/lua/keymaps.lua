-- Esc連打でハイライト解除
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>')

-- close quickfix
vim.keymap.set('n', '<Leader>c', ':cclose<CR>')

-- vを二回で行末まで選択
vim.keymap.set('v', 'v', '$h')

-- Y -> 行末までヤンク
vim.keymap.set('n', 'Y', 'y$')

-- Dまたはxで削除したときはヤンクしない
vim.keymap.set('n', 'D', '"_D')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('v', 'x', '"_x')

-- 分割
vim.keymap.set('n', '<C-w>s', ':split<CR>')
vim.keymap.set('n', '<C-w>v', ':vsplit<CR>')

-- window の移動
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')

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

-- 終了
vim.keymap.set('n', 'sq', ':q<CR>')
-- 現在のバッファ削除
vim.keymap.set('n', 'bd', ':bd<CR>')

-- jjでEscする
vim.keymap.set('i', 'jj', '<Esc>')
-- 設定ファイルを開く
vim.keymap.set('n', '<F1>', ':edit $MYVIMRC<CR>')
