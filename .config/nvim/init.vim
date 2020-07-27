let g:python_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/neovim3/bin/python'
" 各設定で利用する変数
let g:vim_home = $XDG_CONFIG_HOME.'/nvim'
let g:rc_dir = $XDG_CONFIG_HOME.'/nvim/rc'

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
" Esc連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 行頭行末間移動(backspace, space, カーソルキー)
set whichwrap=b,s,<,>,[,]

" close quickfix
nnoremap <Leader>c :cclose<CR>

" 常にタブラインを表示
set showtabline=2
" 現在のモードを表示しない
set noshowmode

"ヤンクした内容が消えないようにする
inoremap PP "0p

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" https://qiita.com/DuGlaser/items/f52dc1c700c3ad29e8de
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME

" Plugin
let s:dein_dir = s:cache_home . '/dein'
" dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" toml
let s:toml_dir = expand('~/.config/nvim')

" Required:
execute 'set runtimepath^=' . s:dein_repo_dir

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------
