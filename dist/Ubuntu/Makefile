DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore .github .vscode
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
SHELL=/bin/bash

.PHONY := all list deploy install update export clean help
.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@echo 'Show dot files in this repo.'
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@echo 'Create symlink to home directory.'
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@which zsh > /dev/null 2>&1; \
	if [ $$? -eq 0 ]; then \
		sudo sh -c "echo `which zsh` >> /etc/shells"; \
		chsh -s `which zsh`; \
	fi

install: ## Install apps.
	@brew bundle --file=${HOME}/.dotfiles/dist/Ubuntu/Brewfile
	@brew upgrade

update: ## Fetch changes for this repository
	@echo 'Fetch changes for this repository.'
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/dist/Ubuntu/update.sh

export: ## Export brew packages
	@echo 'Export brew packages'
	@brew bundle dump --force --file=~/Brewfile

clean: ## Remove the dot files and this repo
	@echo 'Remove the dot files and this repo.'
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
	@bash <(curl -sL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

