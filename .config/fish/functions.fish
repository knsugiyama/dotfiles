# config.fishを読み込む
function reload
  source ~/.config/fish/config.fish
end

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cx\ck peco_kill # control + X からの control + K
end

function cd
  builtin cd $argv; and ls
end

function git_current_branch
  set -l ref (git symbolic-ref --quiet HEAD 2> /dev/null)
  set -l ret $status
  if [ $ret != 0 ]
    [ $ret == 128 ]; and return  # no git repo.
    set -l ref (git rev-parse --short HEAD 2> /dev/null); or return
  end
  string replace 'refs/heads/' "" $ref
end
