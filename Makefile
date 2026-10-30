# One place for agent rules: docs/rules/ is synced into each repo's docs/rules/,
# global/ is installed for every agent on this Mac. bin/agent-rules does the
# work; these targets are the memorable names for it.

.DEFAULT_GOAL := help

.PHONY: all help install uninstall install-repo sync check sync-all test

CLI := $(CURDIR)/bin/agent-rules

# `##@ Name` lines start a group in `make help`; `target: ## text` documents a target.
##@ Help

all: help ## Alias for `make help`

help: ## List every make target, grouped by category
	@awk 'BEGIN { FS = ":.*## " } \
		/^##@ / { printf "\n%s\n", substr($$0, 5); next } \
		/^[a-zA-Z_-]+:.*## / { printf "  make %-14s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo

##@ This Mac

install: ## Install global/ for every agent on this Mac (Claude and Codex)
	@$(CLI) install-global

uninstall: ## Remove the global rules from Claude and Codex (keeps any of your own text)
	@$(CLI) uninstall-global

##@ Repos

install-repo: ## Set a repo up: make install-repo REPO=~/Sites/name
	@$(CLI) install "$(REPO)"

sync: ## Copy docs/rules/ into a repo: make sync REPO=~/Sites/name
	@$(CLI) sync "$(REPO)"

check: ## Show what a sync would change: make check REPO=~/Sites/name
	@$(CLI) check "$(REPO)"

sync-all: ## Sync every installed repo under ~/Sites (ROOT=dir to change)
	@$(CLI) sync-all "$(ROOT)"

##@ Development

test: ## Run the CLI's tests against throwaway repos and a throwaway HOME
	@bash test/run.sh
