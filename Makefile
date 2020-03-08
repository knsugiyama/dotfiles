DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES := $(wildcard .files/.??*)

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

init: ## Setup and Create symlink for dotfile.
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/init/init.sh
	@$(foreach val, $(DOTFILES), ln -snfv $(abspath $(val)) $(HOME)/$(subst .files/,,$(val));)
	@source ~/.bashrc

deploy: ## install plugin
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/deploy/deploy.sh

skipFiles: ## git skip-worktree
	@git update-index --skip-worktree .files/.config/fish/config.fish
	@git update-index --skip-worktree .files/.bash_profile
	@git update-index --skip-worktree .files/.bashrc

install: init deploy skipFiles ## Run initial setup commands
	@echo 'Set default shell by "chsh -s $$(which fish)"'

update: ## Fetch changes for this repository
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/update.sh

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
