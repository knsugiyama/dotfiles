''
  function prj() {
    local repo=$(ghq list | fzf --preview "ghq list --full-path --exact {} | xargs eza -h --long --icons --classify --git --no-permissions --no-user --no-filesize --git-ignore --sort modified --reverse --tree --level 2")
    if [ -n "$repo" ]; then
      repo=$(ghq list --full-path --exact $repo)
      cd ''${repo}
    fi
  }
  bindkey '^p' prj
  zle -N prj

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

  function create_vm() {
      local filePath="$1"
      local vmName="$2"
      INSTANCE_NAME="$vmName"
      WORKSPACE="$HOME/.ssh/multipass/$INSTANCE_NAME"
      _create_ssh_key $INSTANCE_NAME $WORKSPACE
      _create_multipass_vm $filePath $INSTANCE_NAME
      multipass exec $INSTANCE_NAME --working-directory "/home/ubuntu/.ssh" -- bash -c "echo '$(cat ''${WORKSPACE}/''${INSTANCE_NAME}.pub)' | tee -a authorized_keys"
  }

  function _create_ssh_key() {
    INSTANCE_NAME="$1"
    WORKSPACE="$2"
    mkdir -p "$WORKSPACE"
    ssh-keygen -t ed25519 -N "" -f "$WORKSPACE/$INSTANCE_NAME"
    touch "$WORKSPACE/config"
    configBlock="cat <<EOF
  Host ''${INSTANCE_NAME}
      HostName ''${INSTANCE_NAME}.local
      User ubuntu
      IdentityFile ~/.ssh/multipass/''${INSTANCE_NAME}/''${INSTANCE_NAME}
      IdentitiesOnly yes
      ServerAliveInterval 60
      LocalForward 8080 127.0.0.1:8080
  EOF"
    if ! eval "$configBlock" >> "$WORKSPACE/config"; then
      echo "ファイルへの書き込みに失敗しました" >&2
      return 1
    fi
    echo "設定ブロックをファイル '$WORKSPACE/config' に追加しました (ホスト名: '$INSTANCE_NAME')"
    CONFIG_FILE="$HOME/.ssh/config"
    INCLUDE_LINE="Include ~/.ssh/multipass/''${INSTANCE_NAME}/config"
    if [ ! -f "$CONFIG_FILE" ]; then
      touch "$CONFIG_FILE"
    fi
    echo "$INCLUDE_LINE" >> "$CONFIG_FILE"
  }

  function _create_multipass_vm() {
      local filePath="$1"
      local vmName="$2"
      multipass launch --cpus 2 --disk 36G --memory 4G --cloud-init ''${filePath} --name ''${vmName} --timeout 1800
  }
''
