COMPOSE = docker compose

.PHONY: help build up down restart logs shell db-shell install parse

help:
	@echo "Targets:"
	@echo "  make build   - build Docker images"
	@echo "  make up      - start db and app in background"
	@echo "  make down    - stop and remove containers"
	@echo "  make restart - down then up"
	@echo "  make logs    - follow compose logs"
	@echo "  make install - composer install in app container"
	@echo "  make shell   - bash in app container"
	@echo "  make db-shell - psql in db container"
	@echo "  make parse   - run app/30.php (full forum parser example)"

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

restart: down up

logs:
	$(COMPOSE) logs -f

install:
	$(COMPOSE) run --rm app composer install --no-interaction

shell:
	$(COMPOSE) run --rm app bash

db-shell:
	$(COMPOSE) exec db psql -U parser -d parser

parse:
	$(COMPOSE) run --rm app php 30.php
