DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES := $(wildcard .??*)

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

init: ## Setup
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/init/init.sh

install: ## Install base packages
	bash ~/.dotfiles/.bin/install.sh
	exec $$SHELL -l

update: ## Update packages
	git pull origin master
	sudo apt -y update
	sudo apt -y upgrade
	sudo apt autoremove
	brew update

setup-fish: ## Setup fish shell plugins
	bash ~/.dotfiles/.bin/setup/fish-plugins.sh
	exec $$SHELL -l

setup-font: ## Setup font
	bash ~/.dotfiles/.bin/setup/font.sh
	exec $$SHELL -l

link: ## Create symbolic links
	ln -snfv ~/.dotfiles/.bashrc ~/.bashrc
	ln -snfv ~/.dotfiles/.config/git/.gitignore_global ~/.gitignore_global
	ln -snfv ~/.dotfiles/.config/git/.gitconfig ~/.gitconfig
	ln -snfv ~/.dotfiles/.config/fish/alias.fish ~/.config/fish/alias.fish
	ln -snfv ~/.dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
	git update-index --assume-unchanged ~/.dotfiles/.bash_profile
	git update-index --assume-unchanged ~/.dotfiles/.bashrc
	git update-index --assume-unchanged ~/.dotfiles/.config/fish/config.fish

wsl: ## For wsl configulations
	bash ~/.dotfiles/.bin/setup/wsl.sh
	sudo ln -snfv ~/.dotfiles/.config/wsl/wsl.conf /etc/wsl.conf

anyenv: ## Install anyenv
	bash ~/.dotfiles/.bin/anyenv/anyenv.sh
	exec $$SHELL -l
nodenv: ## Install nodenv
	bash ~/.dotfiles/.bin/anyenv/nodenv.sh
	exec $$SHELL -l
jenv: ## Install jenv
	bash ~/.dotfiles/.bin/anyenv/jenv.sh
	exec $$SHELL -l
rbenv: ## Install rbenv
	bash ~/.dotfiles/.bin/anyenv/rbenv.sh
	exec $$SHELL -l

doc-creation: ## Install plantuml & asciidoc
	bash ~/.dotfiles/.bin/install/plantuml.sh
	bash ~/.dotfiles/.bin/install/asciidoc.sh

gcloud: ## Install gcloud
	export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
	echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	sudo apt-get update && sudo apt-get install google-cloud-sdk

intellij: ## Install intellij
	wget https://download.jetbrains.com/idea/ideaIC-2019.3.2-no-jbr.tar.gz
	mkdir -p ~/opt/ideaIC && sudo tar -zxvf ideaIC-2019.*.tar.gz -C ~/opt/ideaIC --strip-components 1
	sudo ln -s ~/opt/ideaIC/bin/idea.sh /usr/bin/idea

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
