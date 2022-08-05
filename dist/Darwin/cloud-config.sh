AUTHORIZED_KEYS=$(<$HOME/.ssh/multipass.pub)

# CLOUD_CONFIG_BASE=$(eval "echo \"$(cat ${HOME}/.dotfiles/dist/Common/multipass/cloud-config-base.yaml)\"")
# cat << EOF > ~/multipass_base.yaml
# ${CLOUD_CONFIG_BASE}
# EOF

# CLOUD_CONFIG_BTP=$(eval "echo \"$(cat ${HOME}/.dotfiles/dist/Common/multipass/cloud-config-btp.yaml)\"")
# cat << EOF > ~/multipass_btp.yaml
# ${CLOUD_CONFIG_BTP}
# EOF

CLOUD_CONFIG_BASE=$(cat ${HOME}/.dotfiles/dist/Common/multipass/cloud-config-base.yaml)
CLOUD_CONFIG_BASE=`echo "${CLOUD_CONFIG_BASE//AUTHORIZED_KEYS/$AUTHORIZED_KEYS}"`
cat << EOF > ~/multipass_base.yaml
${CLOUD_CONFIG_BASE}
EOF


CLOUD_CONFIG_BTP=$(cat ${HOME}/.dotfiles/dist/Common/multipass/cloud-config-btp.yaml)
CLOUD_CONFIG_BTP=`echo "${CLOUD_CONFIG_BTP//AUTHORIZED_KEYS/$AUTHORIZED_KEYS}"`
cat << EOF > ~/multipass_btp.yaml
${CLOUD_CONFIG_BTP}
EOF
