.PHONY: help up down build test test-docker clean

# Default goal
.DEFAULT_GOAL := help

help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

up: ## Start the Docker containers in detached mode
	docker-compose up -d

down: ## Stop and remove the Docker containers
	docker-compose down

build: ## Build the Docker images
	docker-compose build

test: ## Run tests locally (requires python environment)
	cd app && pytest test_app.py -v

test-docker: ## Run tests inside a temporary docker container
	docker-compose run --rm web pytest test_app.py -v

clean: ## Remove pycache and pytest cache
	rm -rf app/.pytest_cache
	find . -type d -name __pycache__ -exec rm -r {} + 2>/dev/null || true
