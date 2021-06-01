" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" キーマップリーダーを最初に定義
let mapleader = " "

" ENV
let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

"------------------------------------
" 外部設定ファイル読み込み
"-----------------------------------
" Load rc file
runtime! rc/settings.vim
runtime! rc/keymap.vim
runtime! rc/dein.vim
