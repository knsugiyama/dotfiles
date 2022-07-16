#!/usr/bin/env bash

set -eu

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# make ファイルのシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Darwin/Makefile ${HOME}/.dotfiles/Makefile
# .zshenv ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Darwin/.zshenv ${HOME}/.dotfiles/.zshenv

# multipass 用に、SSHキーを作成
if [ ! -f ${HOME}/.ssh/multipass ]; then
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ${HOME}/.ssh/multipass
fi

AUTHORIZED_KEYS=$(<$HOME/.ssh/multipass.pub)

CLOUD_CONFIG_BASE=$(eval "echo \"$(cat ${HOME}/.dotfiles/dist/Common/multipass/cloud-config-base.yaml)\"")
cat << EOF > ~/multipass.yaml
${CLOUD_CONFIG_BASE}
EOF

CLOUD_CONFIG_BTP=$(eval "echo \"$(cat ${HOME}/.dotfiles/dist/Common/multipass/cloud-config-btp.yaml)\"")
cat << EOF > ~/multipass_btp.yaml
${CLOUD_CONFIG_BTP}
EOF

sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
