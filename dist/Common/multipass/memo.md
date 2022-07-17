## ~/.ssh/config への記載例
Host docker.local
  Hostname docker.local
  IdentityFile ~/.ssh/multipass
  User ubuntu
  Port 22

## 起動方法
multipass launch --name docker-vm --cpus 4 --mem 8G --disk 20G --cloud-init multipass_docker.yaml 20.04

## ディレクトリ マウント
multipass mount ${HOME} docker:${HOME}
とか
multipass mount ./src docker:/home/ubuntu/src

## ディレクトリ アンマウント
multipass unmount docker:${HOME}
