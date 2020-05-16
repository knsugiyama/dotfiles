DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES := $(wildcard .files/.??*)

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

init: ## Setup and Create symlink for dotfile.
	@$(foreach val, $(DOTFILES), ln -snfv $(abspath $(val)) $(HOME)/$(subst .files/,,$(val));)
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/init/init.sh

deploy: ## install plugin
	@. ~/.bash_profile && \
	DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/deploy/brew.sh && \
	DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/deploy/font.sh && \
	DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/deploy/fisher.sh && \
	DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/deploy/anyenv.sh && \
	. ~/.bash_profile

skipFiles: ## git skip-worktree
	@git update-index --skip-worktree .files/.config/fish/env.fish
	@git update-index --skip-worktree .files/.bash_profile
	@git update-index --skip-worktree .files/.bashrc
	@git update-index --skip-worktree .files/.gitconfig

install: init deploy update ## Run initial setup commands
	@echo 'Set default shell by "chsh -s $$(which fish)"'

update: ## Fetch changes for this repository
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/update.sh

gcloud: ## install gcloud sdk
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/tools/gcloud.sh

intellij: ## install intellij-ce
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/tools/intellij.sh

asciidoc: ## install asciidoc
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/tools/asciidoc.sh

plantuml: ## install plantuml
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/tools/plantuml.sh

wsl2-gui: ## install wsl2-gui
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/bin/tools/wsl2-gui.sh

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
