"マウス有効化
if has('mouse')
  set mouse=a
endif

if has('termguicolors')
  " 端末上でTrue Colorを使用
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
endif

" 行番号を表示する
set number

set title

" 常にタブラインを表示
set showtabline=2
"ヤンクした内容が消えないようにする
inoremap PP "0p
" ビープ音を可視化
set visualbell
" コマンドラインの補完
set wildmode=list:longest

" 改行コードを指定
set fileformats=unix,dos,mac
" 読み込み時に試みるエンコーディング(左から順に試す)
set fileencodings=ucs-bombs,utf-8,euc-jp,cp932
" 全角文字をちゃんと表示する
set ambiwidth=double
" 空白文字等、不可視な文字の可視化
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" スワップファイルを作らない
set noswapfile
" ファイル上書き前にバックアップつくらない
set nobackup
" ファイル上書き前にバックアップファイルつくらない
set nowritebackup

" closeしたバッファを(実際にはcloseせず)hiddenにする
set hidden
" クリップボードとNeovimの無名レジスタを一体化
set clipboard+=unnamedplus
" 編集中のファイルが変更されたら自動で読み直す
set autoread

" タブはスペース2つ分
set tabstop=2
" タブを入力したときスペース×Nに置き換える
set expandtab

" 空白部分でtabキーやbackspaceを押したときにカーソル移動する幅
set softtabstop=0
" 自動インデントの幅
set shiftwidth=2
" 改行時、前のインデントを継続
set autoindent
" 改行時、入力された行の末尾に合わせて次の行のインデントを増幅
set smartindent
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" スクロール時、下に余白をもたせる
set scrolloff=5
" backspaceで消せる項目追加
set backspace=indent,eol,start
" Finding files - Search down into subfolders
set path+=**

" 大文字と小文字を区別しない
set ignorecase
" 混在しているときに限り区別
set smartcase
" 下まで行ったら上に戻る
set wrapscan
" 行頭行末間移動(backspace, space, カーソルキー)
set whichwrap=b,s,<,>,[,]
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore

" ヘルプの日本語化
set helplang=ja,en

