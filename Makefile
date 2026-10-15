PY := backend/.venv/bin/python

.PHONY: help install dev build lint test android docker-up docker-down clean

help:
	@echo "winkterm — web terminal (backend: python, frontend: npm)"
	@echo
	@echo "  make install   - frontend: npm ci, backend: venv + requirements"
	@echo "  make dev       - frontend dev-сервер"
	@echo "  make build     - production-сборка frontend"
	@echo "  make lint      - eslint"
	@echo "  make test      - backend pytest"
	@echo "  make android   - сборка android apk"
	@echo "  make docker-up / docker-down"
	@echo "  make clean     - удалить venv и node-кэш"

install:
	cd frontend && npm ci
	python3 -m venv backend/.venv
	backend/.venv/bin/pip install -r backend/requirements.txt --quiet

dev:
	cd frontend && npm run dev

build:
	cd frontend && npm run build

lint:
	cd frontend && npm run lint

test:
	$(PY) -m pytest backend/tests/ -v

android:
	cd frontend && npm run android:apk

docker-up:
	docker compose up -d --build

docker-down:
	docker compose down

clean:
	rm -rf backend/.venv backend/__pycache__
