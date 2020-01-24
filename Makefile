install: ## Install base packages
	bash ~/.dotfiles/.bin/install.sh

update: ## Update packages
	git pull origin master
	sudo apt -y update
	sudo apt -y upgrade
	sudo apt autoremove
	brew update

setup: ## Setup default config
	bash ~/.dotfiles/.bin/setup/font.sh
	ln -snfv "~/.dotfiles/.conf/git/.gitignore_global" "~/.gitignore_global"
	ln -snfv "~/.dotfiles/.conf/git/.gitconfig" "~/.gitconfig"
	ln -snfv "~/.dotfiles/.conf/fish/alias.fish" "~/.config/fish/alias.fish"
	ln -snfv "~/.dotfiles/.conf/fish/config.fish" "~/.config/fish/config.fish"

wsl: ## For wsl configulations
	bash ~/.dotfiles/.bin/setup/wsl.sh
	ln -snfv "~/.dotfiles/.conf/wsl/wsl.conf" "/etc/wsl.conf"

dev-install: ## Install development applications
	make anyenv
	make node
	make doc-creation

anyenv: ## Install anyenv
	bash ~/.dotfiles/.bin/anyenv/anyenv.sh

doc-creation: ## Install plantuml & asciidoc
	bash ~/.dotfiles/.bin/anyenv/plantuml.sh
	bash ~/.dotfiles/.bin/anyenv/asciidoc.sh

node: ## Install node
	bash ~/.dotfiles/.bin/anyenv/node.sh

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
