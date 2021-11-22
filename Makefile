DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
SHELL=/bin/bash

.PHONY := all list deploy update clean help
.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@echo 'Show dot files in this repo.'
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@echo 'Create symlink to home directory.'
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

update: ## Fetch changes for this repository
	@echo 'Fetch changes for this repository.'
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/update

clean: ## Remobe the dot files and this repo
	@echo 'Remove dot files in your home direfctory.'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

skipfiles: ## git skip-worktree
	@git update-index --skip-worktree .gitconfig.credential
	@git update-index --skip-worktree .config/fish/env.fish

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
