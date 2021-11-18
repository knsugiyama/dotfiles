# config.fishを読み込む
function reload
  source ~/.config/fish/config.fish
end

# configディレクトリをnvimで開く
function open_config
  cd ~/.config
  nvim
end

#######
# git
#######
# 現在のブランチ名を表示
function git_current_branch
  set -l ref (git symbolic-ref --quiet HEAD 2> /dev/null)
  set -l ret $status

  if [ $ret != 0 ]
    if [ $ret = 128 ]
      echo "no git repo."
      return 0
    end

    set -l ref (git rev-parse --short HEAD 2> /dev/null); or return
  end

  string replace 'refs/heads/' "" $ref
end

# gitの差分ファイルをzip化
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

#######
# tmux
#######
# https://blog.abekoh.dev/post/prj-command/
# prj.fish
function prj -d "start project"
  # 引数が設定されていれば、それをpecoにわたす
  if test (count $argv) -gt 0
    set prjflag --query "$argv"
  end
  set PRJ_PATH (ghq root)/(ghq list | peco $prjflag)
  # プロジェクトが選択されなければ終了
  if test -z $PRJ_PATH
    return
  end
  # プロジェクト名は 所有者/リポジトリ名 の形式。その名前に`.`を含む場合は`_`に置換
  set PRJ_NAME (echo (basename (dirname $PRJ_PATH))/(basename $PRJ_PATH) | sed -e 's/\./_/g')
  # プロジェクトのtmuxセッションが存在しなければ作成
  if not tmux has-session -t $PRJ_NAME
    tmux new-session -c $PRJ_PATH -s $PRJ_NAME -d
    tmux setenv -t $PRJ_NAME TMUX_SESSION_PATH $PRJ_PATH
  end
  # tmuxセッション外であればattach
  if test -z $TMUX
    tmux attach -t $PRJ_NAME
  # tmuxセッション内であればswitch
  else
    tmux switch-client -t $PRJ_NAME
  end
end

# https://blog.abekoh.dev/post/prj-command/
# cdの拡張
function cd -d "プロジェクトのルートに移動"
  if test -n "$TMUX" -a -z "$argv"
    set session_path (tmux show-environment | grep TMUX_SESSION_PATH | string replace "TMUX_SESSION_PATH=" "")
    if test $session_path
      builtin cd $session_path; and ls
      return $status
    end
  end
  # tmuxセッション内でない場合は、通常のcd + ls
  builtin cd $argv; and ls
end

function ide -d "tmux を画面分割"
  tmux split-window -v -p 30
  tmux split-window -h -p 66
  tmux split-window -h -p 50
end
