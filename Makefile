install: ## Install base packages
	bash ${PWD}/.bin/install.sh

update: ## Update packages
	git pull origin master
	sudo apt -y update
	sudo apt -y upgrade
	sudo apt autoremove
	brew update

setup: ## Setup default config
	@make git
	@make fish

setup-fish: ## Setup fish shell
	ln -snfv "${PWD}/.conf/fish/alias.fish" "${HOME}/.config/fish/alias.fish"
	ln -snfv "${PWD}/.conf/fish/config.fish" "${HOME}/.config/fish/config.fish"

setup-git: ## Setup git config
	ln -snfv "${PWD}/.conf/git/.gitignore_global" "${HOME}/.gitignore_global"
	ln -snfv "${PWD}/.conf/git/.gitconfig" "${HOME}/.gitconfig"

dev-install: ## Install development applications
	@make anyenv
	@make node
	@make doc-creation

anyenv: ## Install anyenv
	bash ${PWD}/.bin/anyenv/anyenv.sh

wsl: ## For wsl configulations
	bash ${PWD}/.bin/setup/wsl.sh
	ln -snfv "${PWD}/.conf/wsl/wsl.conf" "/etc/wsl.conf"

doc-creation: ## Install plantuml & asciidoc
	bash ${PWD}/.bin/anyenv/plantuml.sh
	bash ${PWD}/.bin/anyenv/asciidoc.sh

node: ## Install node
	bash ${PWD}/.bin/anyenv/node.sh

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
