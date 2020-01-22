install: ## Install base packages
	sudo bash ${PWD}/.bin/install.sh

update: ## Update packages
	git pull origin master
	sudo apt -y update
	sudo apt -y upgrade
	sudo apt autoremove
	brew update

setup: ## Install default applications
	fish git anyenv wsl doc-creation node

fish:
	sudo bash ${PWD}/.bin/install/fish.sh
	ln -snfv "${PWD}/.conf/fish/alias.fish" "${HOME}/.config/fish/alias.fish"
	ln -snfv "${PWD}/.conf/fish/config.fish" "${HOME}/.config/fish/config.fish"

git:
	ln -snfv "${PWD}/.conf/git/.gitignore_global" "${HOME}/.gitignore_global"
	ln -snfv "${PWD}/.conf/git/.gitconfig" "${HOME}/.gitconfig"

anyenv:
	sudo bash ${PWD}/.bin/setup/anyenv.sh

wsl: ## For wsl configulations
	sudo bash ${PWD}/.bin/setup/wsl.sh
	ln -snfv "${PWD}/.conf/wsl/wsl.conf" "/etc/wsl.conf"

doc-creation: ## Install plantuml & asciidoc
	sudo bash ${PWD}/.bin/setup/plantuml.sh
	sudo bash ${PWD}/.bin/setup/asciidoc.sh

node: ## Install node
	sudo bash ${PWD}/.bin.setup/node.sh

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
