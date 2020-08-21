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

function git_diff_archive
  set -l d (date '+%y%m%d_%H%M')
  set -l p (basename $PWD)
  set -l h "HEAD"
  set -l diff ""
  set -l length (count $argv)

  if test $length -ge 2
    set diff $argv[1] $argv[2]
    set h $argv[1]
  else if test $length -eq 1
    if expr "$argv[1]" : '[0-9]*$' > /dev/null
      set diff HEAD~$argv[1] HEAD
    else
      set diff $argv[1] HEAD
    end
  end

  command git archive --format=zip $h (git diff --name-only --diff-filter=d $diff) -o $p-$d.zip
end
