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

install: ## Install apps.
	@sudo dpkg --set-selections < $(DOTPATH)/dist/Ubuntu/package_list.txt
	@sudo apt dselect-upgrade
	@git update-index --assume-unchanged ${HOME}/.dotfiles/.gitconfig_credential
	@which nu > /dev/null 2>&1; \
	if [ $$? -eq 0 ]; then \
		sudo sh -c "echo `which zsh` >> /etc/shells"; \
		chsh -s `which zsh`; \
	fi

update: ## Fetch changes for this repository
	@echo 'Fetch changes for this repository.'
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/dist/Ubuntu/update.sh

export: ## Export brew packages
	@echo 'Export brew packages'
	@dpkg --get-selections > $(DOTPATH)/dist/Ubuntu/upackage_list.txt

clean: ## Remove the dot files and this repo
	@echo 'Remove the dot files and this repo.'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
