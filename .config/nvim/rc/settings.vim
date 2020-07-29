"マウス有効化
if has('mouse')
  set mouse=a
endif

" 改行コードを指定
set fileformats=unix,dos,mac
" 端末上でTrue Colorを使用
set termguicolors
" 読み込み時に試みるエンコーディング(左から順に試す)
set fileencodings=ucs-bombs,utf-8,euc-jp,cp932
" 全角文字をちゃんと表示する
set ambiwidth=double
" スワップファイルを作らない
set noswapfile
" closeしたバッファを(実際にはcloseせず)hiddenにする
set hidden
" クリップボードとNeovimの無名レジスタを一体化
set clipboard+=unnamedplus

" 行番号を表示する
set number
" 空白文字等、不可視な文字の可視化
set list
set listchars=tab:>-,trail:*,nbsp:+

" タブはスペース2つ分
set tabstop=2
" 空白部分でtabキーやbackspaceを押したときにカーソル移動する幅
set softtabstop=2
" 自動インデントの幅
set shiftwidth=2
" タブを入力したときスペース×Nに置き換える
set expandtab
" C系の文法に従って自動インデント、{}とかに反応する
set smartindent
set visualbell

" ヘルプの日本語化
set helplang=ja,en

" 検索関連
" 大文字と小文字を区別しない
set ignorecase
" 混在しているときに限り区別
set smartcase
" 下まで行ったら上に戻る
set wrapscan
" 行頭行末間移動(backspace, space, カーソルキー)
set whichwrap=b,s,<,>,[,]

" 常にタブラインを表示
set showtabline=2
" 現在のモードを表示しない
set noshowmode

"ヤンクした内容が消えないようにする
inoremap PP "0p

" 透過率
set pumblend=10
