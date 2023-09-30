SHELL := /bin/bash

MAKEFLAGS += --no-print-directory

.PHONY: deploy migrate

deploy:
	@docker compose -f ./deploy.yml up -d
	@until docker exec cfml bash -c "echo 'Containers are ready'"; do sleep 1; done
	@make migrate
	@exit 0

migrate:
	@echo "[+] Migrating database!"
	@docker exec -it cfml bash -c "box migrate install"
	@docker exec -it cfml bash -c "box migrate up"
	@echo "[+] Database migrated!"
