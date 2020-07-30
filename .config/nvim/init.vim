let g:python_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/neovim3/bin/python'

"------------------------------------
" 外部設定ファイル読み込み
"-----------------------------------
runtime! rc/*.vim
