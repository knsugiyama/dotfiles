local api = vim.api

-- Esc連打でハイライト解除
-- nmap <Esc><Esc> :nohlsearch<CR><Esc>
api.nvim_set_keymap('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { })

-- close quickfix
-- nnoremap <Leader>c :cclose<CR>
api.nvim_set_keymap('n', '<Leader>c', ':cclose<CR>', { noremap = true })

-- vを二回で行末まで選択
-- vnoremap v $h
api.nvim_set_keymap('v', 'v', '$h', { noremap = true })

-- Y -> 行末までヤンク
-- nnoremap Y y$
api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Dまたはxで削除したときはヤンクしない
--nnoremap D "_D
--vnoremap x "_x
--nnoremap x "_x
api.nvim_set_keymap('n', 'D', '"_D', { noremap = true })
api.nvim_set_keymap('n', 'x', '"_x', { noremap = true })
api.nvim_set_keymap('v', 'x', '"_x', { noremap = true })

-- 分割
-- nmap <C-w>s :split<CR>
-- nmap <C-w>v :vsplit<CR>
api.nvim_set_keymap('n', '<C-w>s', ':split<CR>', { })
api.nvim_set_keymap('n', '<C-w>v', ':vsplit<CR>', { })

-- window の移動
-- nmap <C-j> <C-w>j
-- nmap <C-k> <C-w>k
-- nmap <C-l> <C-w>l
-- nmap <C-h> <C-w>h
api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { })
api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { })
api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { })
api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { })

-- Tab
-- nmap <C-t>n :tabnew<CR>
-- nmap <C-t>N :tabNext<CR>
-- nmap <C-t>p :tabprevious<CR>
api.nvim_set_keymap('n', '<C-t>n', ':tabnew<CR>', { })
api.nvim_set_keymap('n', '<C-t>N', ':tabNext<CR>', { })
api.nvim_set_keymap('n', '<C-t>p', ':tabprevious<CR>', { })

-- j, k による移動を折り返されたテキストでも自然に振る舞うように変更
-- nnoremap j gj
-- nnoremap k gk
api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- insert mode からの保存や閉じる
-- inoremap <silent> jk <ESC>
-- inoremap <silent> jkw <ESC>:w!<CR>
-- inoremap <silent> jkq <ESC>:wq!<CR>
api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true, silent = true })
api.nvim_set_keymap('i', 'jkw', '<ESC>:w!<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('i', 'jkq', '<ESC>:wq!<CR>', { noremap = true, silent = true })

-- 終了
-- nnoremap sq :q<CR>
api.nvim_set_keymap('n', 'sq', ':q<CR>', { noremap = true })
-- 現在のバッファ削除
-- nnoremap bd :bd<CR>
api.nvim_set_keymap('n', 'bd', ':bd<CR>', { noremap = true })
