DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
SHELL=/bin/bash

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

update: ## Fetch changes for this repository
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/update.sh

skipFiles: ## git skip-worktree
	@git update-index --skip-worktree .bash_profile
	@git update-index --skip-worktree .bashrc
	@git update-index --skip-worktree .gitconfig
	@git update-index --skip-worktree .config/fish/env.fish

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
