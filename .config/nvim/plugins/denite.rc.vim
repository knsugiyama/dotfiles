autocmd FileType denite call s:denite_my_settings()

function! s:denite_my_settings() abort
  " エンターキー: 垂直分割でファイルを開く
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action', 'vsplit')
  " スペースキー: 水平分割でファイルを開く
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('do_action', 'split')
  " エスケープキー: 終了
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  " Qキー: 終了
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  " Iキー: フィルター入力の開始
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  " Aキー: フィルター入力の開始
  nnoremap <silent><buffer><expr> a
  \ denite#do_map('open_filter_buffer')
endfunction

" Change file/rec command
call denite#custom#var('file/rec', 'command',
\ ['rg', '--files', '--glob', '!.git', '--color', 'never'])

" Ripgrep command on grep source
call denite#custom#var('grep', {
           \ 'command': ['rg'],
           \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
           \ 'recursive_opts': [],
           \ 'pattern_opt': ['--regexp'],
           \ 'separator': ['--'],
           \ 'final_opts': [],
           \ })

call denite#custom#alias('source', 'grep/ignore_test', 'grep')
call denite#custom#var('grep/ignore_test', {
\ 'command': ['rg'],
\ 'default_opts': ['-i', '--vimgrep', '--no-heading', '-g', '!test/', '-g', '!spec/', '-g', '!*_test.go'],
\ 'recursive_opts': [],
\ 'pattern_opt': ['--regexp'],
\ 'separator': ['--'],
\ 'final_opts': [],
\ })

" ファイル検索とgrepのキーマッピング
" フローティングウィンドウと自動プレビューのための設定
let s:floating_window_width_ratio = 1.0
let s:floating_window_height_ratio = 0.7

call denite#custom#option('default', {
\ 'auto_action': 'preview',
\ 'floating_preview': v:true,
\ 'preview_height': float2nr(&lines * s:floating_window_height_ratio),
\ 'preview_width': float2nr(&columns * s:floating_window_width_ratio / 2),
\ 'prompt': '% ',
\ 'split': 'floating',
\ 'vertical_preview': v:true,
\ 'wincol': float2nr((&columns - (&columns * s:floating_window_width_ratio)) / 2),
\ 'winheight': float2nr(&lines * s:floating_window_height_ratio),
\ 'winrow': float2nr((&lines - (&lines * s:floating_window_height_ratio)) / 2),
\ 'winwidth': float2nr(&columns * s:floating_window_width_ratio / 2),
\ })

" ;f ファイル検索file/recを開始
nmap <silent> ;f  :<C-u>Denite -start-filter file/rec<CR>
" ;F ファイル検索file/recを開始(プロジェクトディレクトリから検索)
nmap <silent> ;F  :<C-u>DeniteProjectDir -start-filter file/rec<CR>
" ;g カーソル位置の単語で検索できる
nmap <silent> ;g  :<C-u>DeniteProjectDir grep:::<C-r><C-w><CR>
" ;G カーソル位置の単語で検索できる
nmap <silent> ;G  :<C-u>DeniteProjectDir grep:::<C-r><C-a><CR>
nmap <silent> ;;g :<C-u>Denite grep<CR>
nmap <silent> ;;G :<C-u>DeniteProjectDir grep<CR>
