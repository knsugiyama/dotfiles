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
	ln -snfv ~/.dotfiles/.config/wsl/wsl.conf /etc/wsl.conf

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

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
