DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore .github .vscode .fleet
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
SHELL=/bin/bash

.PHONY := all list deploy update export clean help
.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@echo 'Show dot files in this repo.'
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory & create files of cloud-config
	@echo 'Create symlink to home directory.'
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

install: ## Install apps.
	@brew bundle --verbose --file=$(DOTFILES)/dist/Darwin/Brewfile
	@brew update --verbose

update: ## Fetch changes for this repository
	@echo 'Fetch changes for this repository.'
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/dist/Darwin/update.sh

export: ## Export brew packages
	@echo 'Export brew packages'
	@brew bundle dump --force --file=~/Brewfile

clean: ## Remobe the dot files and this repo
	@echo 'Remove dot files in your home direfctory.'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
