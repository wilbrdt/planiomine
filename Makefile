# -- General
SHELL := /bin/bash

# -- Docker
# Get the current user ID to use for docker commands
DOCKER_UID           = $(shell id -u)
DOCKER_GID           = $(shell id -g)
DOCKER_USER          = $(DOCKER_UID):$(DOCKER_GID)
COMPOSE              = DOCKER_USER=$(DOCKER_USER) docker compose

# ==============================================================================
# RULES

default: help

bootstrap: ## bootstrap project
	mkdir -p files
	mkdir -p sql
	./extract_backup.sh
.PHONY: bootstrap

run: ## start redmine stack
	@$(COMPOSE) up
.PHONY: run

# -- Misc
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help
