DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES := $(wildcard .files/.??*)

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

init: ## Setup
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/init/init.sh
	@$(foreach val, $(DOTFILES), ln -snfv $(abspath $(val)) $(HOME)/$(subst .files/,,$(val));)
	@source ~/.bashrc

deploy: ## Create symlink for dotfile and install plugin
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/deploy/deploy.sh

install: init deploy ## Run initial setup commands
	@echo 'Set default shell by "chsh -s $$(which fish)"'

update: ## Fetch changes for this repository
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/update.sh

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
