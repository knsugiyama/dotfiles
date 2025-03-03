function prj() {
  local repo=$(ghq list | fzf --preview "ghq list --full-path --exact {} | xargs exa -h --long --icons --classify --git --no-permissions --no-user --no-filesize --git-ignore --sort modified --reverse --tree --level 2")
  if [ -n "$repo" ]; then
    repo=$(ghq list --full-path --exact $repo)
    cd ${repo}
  fi
}
bindkey '^p' prj
zle -N prj

# https://zenn.dev/kis9a/articles/my_zsh_completion_function >>
function zsh_functions() {
  if [[ -z "$1" ]]; then
    functions | grep \(\) | grep -v '^\_' | grep -v '^\s' | grep '^[a-z]' | cut -f 1 -d " " &&
      alias | cut -f 1 -d "="
  fi
  while getopts ":a" option; do
    case "$option" in
    a)
      functions | grep \(\) | grep -v '^\_' | grep -v '^\s' | grep '^[a-z]' | cut -f 1 -d " " &&
        alias | cut -f 1 -d "=" && bash -c "compgen -c"
      break
      ;;
    *)
      cat <<'EOF'
USAGE:
zsh_functions [option]
  -a: all commands
EOF
      break
      ;;
    esac
  done
}

function zh() {
  funcs=($(zsh_functions | uniq | sort | fzf -m | tr "\n" " "))
  for f in $funcs; do
    alias "$f"
    functions "$f"
  done
}

function _zsh_function_find() {
  BUFFER="$BUFFER$(zsh_functions | uniq | sort | fzf -m)"
  zle end-of-line
}
bindkey '^o' _zsh_function_find
zle -N _zsh_function_find

function _zsh_command_find() {
  BUFFER="$BUFFER$(zsh_functions -a | uniq | sort | fzf -m)"
  zle end-of-line
}
bindkey '^k' _zsh_command_find
zle -N _zsh_command_find
# <<

function create_multipass_vm() {
    # echo "$1"
    local filePath="$1"
    local vmName="$2"

    multipass launch --cpus 2 --disk 36G --memory 4G --cloud-init ${filePath} --name ${vmName} --timeout 1800
}

function create_ssh_key() {
  vmName="$1"

  # 仮想環境の名前を設定
  INSTANCE_NAME="$vmName"

  # ssh 接続設定用に仮想環境名ディレクトリを切る
  WORKSPACE="$HOME/.ssh/multipass/$INSTANCE_NAME"
  mkdir -p "$WORKSPACE"

  # 仮想環境名の鍵生成
  ssh-keygen -t ed25519 -N "" -f "$WORKSPACE/$INSTANCE_NAME"

  # config ファイル作成
  touch "$WORKSPACE/config"

  # 設定内容のブロックを定義 (ヒアドキュメント使用)
  configBlock="cat <<EOF
Host ${INSTANCE_NAME}
    HostName ${INSTANCE_NAME}.local
    User u${INSTANCE_NAME}
    IdentityFile ~/.ssh/multipass/${INSTANCE_NAME}/${INSTANCE_NAME}
    IdentitiesOnly yes
    ServerAliveInterval 60
EOF"

  # ファイルに設定内容を追記
  if ! eval "$configBlock" >> "$WORKSPACE/config"; then
    echo "ファイルへの書き込みに失敗しました" >&2
    return 1
  fi
  echo "設定ブロックをファイル '$WORKSPACE/config' に追加しました (ホスト名: '$INSTANCE_NAME')"

  # ~/.ssh/config への Include 行追記処理
  CONFIG_FILE="$HOME/.ssh/config"
  INCLUDE_LINE="Include ~/.ssh/multipass/${INSTANCE_NAME}/config"

  # ~/.ssh/config が存在するか確認、なければ作成
  if [ ! -f "$CONFIG_FILE" ]; then
    touch "$CONFIG_FILE"
  fi

  # ~/.ssh/config に Include 行を追記
  echo "$INCLUDE_LINE" >> "$CONFIG_FILE"

#   multipass exec myvm --working-directory "/home/ubuntu/.ssh" -- bash -c "echo '$(cat ${WORKSPACE}/${INSTANCE_NAME}.pub)' | tee -a authorized_keys"
}
