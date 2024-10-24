# https://qiita.com/sho-t/items/d553dd694900cae0966d
# 環境変数補完
setopt auto_param_keys

setopt extended_history
setopt hist_allow_clobber
setopt hist_fcntl_lock
setopt hist_find_no_dups 

setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space

setopt hist_no_functions
setopt hist_no_store

# historyに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify

# 他のzshと履歴を共有
setopt inc_append_history_time
setopt share_history
