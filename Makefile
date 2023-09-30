SHELL := /bin/bash

MAKEFLAGS += --no-print-directory

ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.PHONY: dev clean migrate seed watch

dev:
	@if [ ! -d "./client/node_modules" ]; then \
		export NVM_DIR=$$HOME/.nvm; \
 	   	source $$NVM_DIR/nvm.sh; \
		if [ ! -d "$$NVM_DIR" ]; then \
			echo "[!] Install nvm on your system!"; \
		fi; \
		echo "[+] Installing client dependencies!"; \
		cd client && nvm install && nvm use && npm install || exit 1; \
	fi

	@docker compose -f ./docker/app.yml -f ./docker/db.yml -f ./docker/client.yml up -d --build
	@until docker exec cfml bash -c "echo 'Containers are ready'"; do sleep 1; done
	@make migrate
	@make seed
	@make watch

clean:
	@docker compose -f ./docker/app.yml -f ./docker/db.yml -f ./docker/client.yml down
	@sudo rm -rf ./app/modules
	@sudo rm -rf ./app/taffy
	@sudo rm -rf ./client/node_modules
	@docker volume rm docker_pgdata

migrate:
	@echo "[+] Migrating database!"
	@docker exec -it cfml bash -c "box migrate fresh"

seed:
	@echo "[+] Seeding database!"
	@docker exec -it cfml bash -c "box migrate seed run"

watch:
	@echo "[+] Watching for changes!"
	@docker exec -it cfml bash -c "box run-script format:watch"
