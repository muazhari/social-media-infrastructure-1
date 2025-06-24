# Default action.
all:
	- make run-datastore
	- make run-backend
	- make compose-wgc
	- make run-gateway
	- make run-frontend

# Stop all containers.
stop-all:
	- docker compose down gateway-1
	- docker compose down frontend-1
	- docker compose down datastore-1 datastore-2 datastore-3
	- docker compose down backend-1 backend-2

# Run gateway containers.
run-gateway:
	docker compose -f docker-compose.yml up -d gateway-1

# Run frontend containers.
run-frontend:
	docker compose -f docker-compose.yml up -d frontend-1

# Run datastore containers.
run-datastore:
	docker compose -f docker-compose.yml up -d datastore-1 datastore-2 datastore-3

# Run backend containers.
run-backend:
	docker compose -f docker-compose.yml up -d backend-1 backend-2

# Compose graph.
compose-wgc:
	npx wgc router compose -i graphs.yaml -o config.json

# Reload gateway configuration.
reload-gateway:
	- docker compose down gateway-1
	- npx wgc router compose -i graphs.yaml -o config.json
	- docker compose -f docker-compose.yml up -d gateway-1