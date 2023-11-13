" ヤンクでクリップボードにコピー
set clipboard+=unnamed

" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~

" Esc 2回で、ハイライトを解除する
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"Dやx キー削除でデフォルトレジスタに入れない
nnoremap D "_D
nnoremap x "_x
vnoremap x "_x

" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" I like using H and L for beginning/end of line
nmap H ^
nmap L $
