" Esc連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" close quickfix
nnoremap <Leader>c :cclose<CR>

" vを二回で行末まで選択
vnoremap v $h
" Y -> 行末までヤンク
nnoremap Y y$
" Dでヤンクしない
nnoremap D "_D

" 分割
nmap <C-w>s :split<CR>
nmap <C-w>v :vsplit<CR>

" window の移動
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

" Tab
nmap <C-t>n :tabnew<CR>
nmap <C-t>N :tabNext<CR>
nmap <C-t>p :tabprevious<CR>

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

inoremap <silent> jj <ESC>
inoremap <silent> jjw <ESC>:w!<CR>
inoremap <silent> jjq <ESC>:wq!<CR>

" 終了
nnoremap sq :q<CR>

"insert mode での移動
inoremap <C-d> <DELETE>
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-h> <LEFT>
inoremap <C-l> <RIGHT>
"
" コマンドモードでctrl+kjで履歴
cnoremap <C-k> <UP>
cnoremap <C-j> <DOWN>
