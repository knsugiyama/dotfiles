DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
SHELL=/bin/bash

.PHONY := all list deploy update clean help
.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@ln -sfnv $(HOME)/.dotfiles/Brewfile $(HOME)/Brewfile

update: ## Fetch changes for this repository
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/update

clean: ## Remobe the dot files and this repo
	@echo 'Remove dot files in your home direfctory.'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

skipfiles: ## git skip-worktree
	@git update-index --skip-worktree .gitconfig.credential
	@git update-index --skip-worktree .config/fish/env.fish

option-asdf:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/asdf.sh

option-java:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/asdf/java.sh

option-node:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/asdf/node.sh

option-python:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/asdf/python.sh

option-intellijce:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/intellij.sh

option-wsl: ## install wsl2 basic setting
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/wsl2.sh

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
