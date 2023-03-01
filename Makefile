# -- General
SHELL := /bin/bash

# -- Docker
# Get the current user ID to use for docker commands
DOCKER_UID           = $(shell id -u)
DOCKER_GID           = $(shell id -g)
DOCKER_USER          = $(DOCKER_UID):$(DOCKER_GID)
COMPOSE              = DOCKER_USER=$(DOCKER_USER) docker compose
COMPOSE_RUN          = $(COMPOSE) run --rm
DOCKERIZE            = $(COMPOSE_RUN) dockerize

# ==============================================================================
# RULES

default: help

bootstrap: ## bootstrap project
	mkdir -p files
	mkdir -p sql
	./extract_backup.sh
.PHONY: bootstrap

run: ## start redmine stack
run: \
	run-db \
	run-redmine
.PHONY: run

run-db: ## start mysql database
	@$(COMPOSE) up -d db
	@echo "Waiting for db to be up and running after importing..."
	@$(DOCKERIZE) -wait tcp://db:3306 -timeout 60s
.PHONY: run-db

run-redmine: ## start redmine instance
	@$(COMPOSE) up redmine
.PHONY: run-redmine

stop: ## stop redmine stack
	@$(COMPOSE) down
.PHONY: stop

# -- Misc
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help
