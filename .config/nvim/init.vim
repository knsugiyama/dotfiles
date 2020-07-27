let g:python_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/neovim3/bin/python'
" 各設定で利用する変数
let g:vim_home = $XDG_CONFIG_HOME.'/nvim'
let g:rc_dir = $XDG_CONFIG_HOME.'/nvim/rc'

"------------------------------------
" 外部設定ファイル読み込み
"-----------------------------------
runtime! rc/*.vim
