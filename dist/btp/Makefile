SHELL=/bin/bash

.PHONY := all init install clean help
.DEFAULT_GOAL := help

all:

init: ## Init btp cli
	@echo "[btp] Init..."
	@curl --remote-name --location --url "https://raw.githubusercontent.com/SAP-samples/sap-tech-bytes/2021-09-01-btp-cli/getbtpcli" && chmod +x getbtpcli

install: ## Install btp cli.
	@echo "[btp] Install..."
	@echo -e "\n" | ./getbtpcli
	@echo "set PATH $HOME/bin $PATH" >> ~/.config/fish/env.fish

clean: ## Remove getbtpcli
	@test -f ./getbtpcli && rm -f ./getbtpcli

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
