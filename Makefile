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
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/update

skipfiles: ## git skip-worktree
	@git update-index --skip-worktree .bash_profile
	@git update-index --skip-worktree .bashrc
	@git update-index --skip-worktree .gitconfig.credential
	@git update-index --skip-worktree .config/fish/env.fish

noSkipfiles: ## git no-skip-worktree
	@git update-index --no-skip-worktree .bash_profile
	@git update-index --no-skip-worktree .bashrc
	@git update-index --no-skip-worktree .gitconfig.credential
	@git update-index --no-skip-worktree .config/fish/env.fish

option-anyenv: ## install anyenv
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/anyenv.sh

option-setup-anyenvs: ## setup anyenv modules
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/anyenv/nodenv-setup.sh && \
	DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/anyenv/pyenv-setup.sh && \
	DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/anyenv/rbenv-setup.sh && \
	DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/anyenv/goenv-setup.sh

option-gcloud: ## install gcloud
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/gcloud.sh

option-nvim: ## install nvim
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/nvim-setup.sh

option-wsl-gui: ## install wsl2 gui
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/wsl2-gui.sh

option-wsl-font: ## install wsl2 font
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/options/wsl2-font.sh

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
