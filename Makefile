MIGRATE ?= migrate
MIGRATIONS_DIR := scripts/migrations

-include .env
export MYSQL_URL

.PHONY: run migrate-create migrate-up migrate-down

run:
	go run ./cmd

migrate-create:
	@test -n "$(name)" || { echo "Usage: make migrate-create name=create_users" >&2; exit 1; }
	@command -v "$(MIGRATE)" >/dev/null 2>&1 || { echo "Migration CLI not found. Install golang-migrate and make sure '$(MIGRATE)' is on PATH." >&2; exit 1; }
	$(MIGRATE) create -ext sql -dir $(MIGRATIONS_DIR) -seq "$(name)"

migrate-up:
	@test -n "$$MYSQL_URL" || { echo "Set MYSQL_URL to your MySQL connection URL." >&2; exit 1; }
	@command -v "$(MIGRATE)" >/dev/null 2>&1 || { echo "Migration CLI not found. Install golang-migrate and make sure '$(MIGRATE)' is on PATH." >&2; exit 1; }
	$(MIGRATE) -database "$$MYSQL_URL" -path $(MIGRATIONS_DIR) up

migrate-down:
	@test -n "$$MYSQL_URL" || { echo "Set MYSQL_URL to your MySQL connection URL." >&2; exit 1; }
	@command -v "$(MIGRATE)" >/dev/null 2>&1 || { echo "Migration CLI not found. Install golang-migrate and make sure '$(MIGRATE)' is on PATH." >&2; exit 1; }
	$(MIGRATE) -database "$$MYSQL_URL" -path $(MIGRATIONS_DIR) down
