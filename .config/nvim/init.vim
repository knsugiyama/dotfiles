let g:python3_host_prog = expand('~/nvim-python3/bin/python3')
let g:python_host_prog = expand('~/nvim-python2/bin/python2')

" let g:python_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/neovim2/bin/python'
" let g:python3_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/neovim3/bin/python'

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" キーマップリーダーを最初に定義
let mapleader = ','

"------------------------------------
" 外部設定ファイル読み込み
"-----------------------------------
runtime! rc/settings.vim
runtime! rc/keymap.vim
runtime! rc/dein.vim
