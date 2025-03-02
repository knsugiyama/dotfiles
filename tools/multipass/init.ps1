# 仮想環境の名前を設定
$INSTANCE_NAME="myvm"

# ssh 接続設定用に仮想環境名ディレクトリを切る
$WORKSPACE="$HOME\.ssh\multipass\$INSTANCE_NAME"
New-Item -ItemType Directory -Force -Path "$WORKSPACE"

# 仮想環境名の鍵生成
## パスフレーズは空
ssh-keygen -t ed25519 -b 521 -N "" -f "$WORKSPACE\$INSTANCE_NAME"

# config ファイル作成
New-Item -ItemType File -Path "$WORKSPACE\config"

# 公開鍵を仮想環境の authorized_keys に追加
multipass exec myvm --working-directory "/home/ubuntu/.ssh" -- bash -c "echo '$(Get-Content $WORKSPACE\$INSTANCE_NAME.pub)' | tee -a authorized_keys"
