DOTPATH   := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
SHELL=/bin/bash

.PHONY := all init install uninstall help
.DEFAULT_GOAL := help

all:

init: ## Init cf cli
	@echo "[cf-cli] Init..."
	@bash $(DOTPATH)/scripts/init

install: ## Install cf cli.
	@echo "[cf-cli] Install..."
	@bash $(DOTPATH)/scripts/install

uninstall: ## Uninstall cf cli.
	@bash $(DOTPATH)/scripts/uninstall

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
