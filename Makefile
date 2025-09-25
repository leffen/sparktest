# Makefile for the SparkTest Monorepo
#
# This Makefile provides a convenient interface for common development tasks.
# It wraps pnpm and cargo commands defined in package.json and Cargo.toml.

.DEFAULT_GOAL := help
.PHONY: help install dev dev-frontend dev-backend build build-frontend build-backend test test-frontend test-backend check lint format clean docker-build docker-up docker-down docker-logs

# Use bash for all shell commands
SHELL := /bin/bash

help: ## ✨ Show this help message
	@echo "Usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%%-20s\033[0m %%s\n", $$1, $$2}'

# ------------------------------------------------------------------------------
# Installation
# ------------------------------------------------------------------------------

install: ## 📦 Install all Node.js dependencies using pnpm
	pnpm install

# ------------------------------------------------------------------------------
# Development
# ------------------------------------------------------------------------------

dev: ## 🚀 Run frontend and backend servers concurrently
	pnpm dev:all

dev-frontend: ## 🎨 Run the frontend development server only
	pnpm dev:frontend

dev-backend: ## ⚙️ Run the backend development server only
	pnpm dev:backend

# ------------------------------------------------------------------------------
# Building
# ------------------------------------------------------------------------------

build: ## 🏗️ Build all frontend packages, the app, and the Rust backend
	pnpm build:packages
	pnpm build:app
	pnpm cargo-build

build-frontend: ## 🏗️ Build all frontend packages and the main application
	pnpm build:packages
	pnpm build:app

build-backend: ## ⚙️ Build the Rust backend
	pnpm cargo-build

# ------------------------------------------------------------------------------
# Testing
# ------------------------------------------------------------------------------

test: ## 🧪 Run all frontend and backend tests
	pnpm check:test

test-frontend: ## 🧪 Run all frontend (Jest/Vitest) tests
	pnpm test

test-backend: ## 🧪 Run all backend (cargo) tests
	pnpm cargo-test

# ------------------------------------------------------------------------------
# Quality & Formatting
# ------------------------------------------------------------------------------

check: ## ✅ Run all checks (format, lint, types, build, test)
	pnpm check

lint: ## 🧹 Lint all frontend packages and the app
	pnpm lint

format: ## 💅 Format the entire codebase with Prettier
	pnpm format

# ------------------------------------------------------------------------------
# Cleaning
# ------------------------------------------------------------------------------

clean: ## 🗑️ Remove all build artifacts and dependencies
	@echo "Cleaning Rust target directory..."
	cargo clean
	@echo "Cleaning all node_modules, .next, and dist directories..."
	rm -rf node_modules
	pnpm --filter './packages/*' --filter './apps/*' exec rm -rf node_modules .next dist
	@echo "Clean complete."

# ------------------------------------------------------------------------------
# Docker
# ------------------------------------------------------------------------------


rund: docker-build
	docker compose -f docker-compose.prod.yml up

docker-build: ## 🐳 Build production Docker images using docker-compose
	docker compose -f docker-compose.prod.yml build


docker-up: ## 🐳 Start production containers in detached mode
	docker compose -f docker-compose.prod.yml up -d


docker-down: ## 🐳 Stop and remove production containers
	docker compose -f docker-compose.prod.yml down


docker-logs: ## 🐳 Follow logs from all production containers
	docker compose -f docker-compose.prod.yml logs -f
