# Default action.
all:
	- make run-datastore
	- make run-backend
	- make run-router
	- make run-frontend
	- make run-gateway

# Stop all containers.
stop-all:
	- docker compose down gateway-1
	- docker compose down frontend-1
	- docker compose down router-1
	- docker compose down backend-1 backend-2
	- docker compose down datastore-1 datastore-2 datastore-3

# Run gateway containers.
run-gateway:
	docker compose -f docker-compose.yml up -d gateway-1

# Run frontend containers.
run-frontend:
	docker compose -f docker-compose.yml up -d frontend-1

# Run router containers.
run-router:
	docker compose -f docker-compose.yml up -d router-1

# Run backend containers.
run-backend:
	docker compose -f docker-compose.yml up -d backend-1 backend-2

# Run datastore containers.
run-datastore:
	docker compose -f docker-compose.yml up -d datastore-1 datastore-2 datastore-3

# publish subgraphs.
publish-subgraph:
	- npx wgc subgraph publish backend-1 --namespace default --schema ../social-media-backend-1/internal/outers/deliveries/graphqls/schema.graphqls --routing-url http://172.23.128.1:8081/graphql
	- npx wgc subgraph publish backend-2 --namespace default --schema ../social-media-backend-2/src/main/resources/graphql/schema.graphqls --routing-url http://172.23.128.1:8082/graphql